




require("Tools/ScrollRectInfinite")
require("ViewModel/Terminal/ActivityItemModel")
require("ViewModel/Terminal/BranchItemModel")
require("ViewModel/Terminal/NovelItemModel")
require("ViewModel/Terminal/ChapterItemModel")

local this = {
    vm = nil,tableInsert = table.insert,tableSort = table.sort,
    tableRemove = table.remove,
    curLabel = 0, labelType = {main = 1,branch = 2,activity = 3},
    scrollView = nil,itemTemplate = nil,branchNumItem = nil,
    branchConfig = nil,activityConfig = nil,selectObject = nil,
    novelTypeView = nil,novelTemplate = nil,novelLabelNum = 0,
    itemScroll_1 = nil,itemScroll_2 = nil,
    activityTemplate = nil,itemScrollInfinite = nil,
    chapterReadConfig = nil,chapterConfig = nil,
    mainConfig = nil,chapterContent = nil,chapterTemplate = nil,chapterList = {},
    dragBehaviour = nil,clickContentY = nil,mainItemTemplate = nil,
    activityNovelId = nil,isLock = nil,
    rotation_1 = nil,rotation_2 = nil,rotation_3 = nil,
    scale_1 = nil,scale_2 = nil,scale_3 = nil,
    position_1 = nil,position_2 = nil,position_3 = nil,
    themeBarList={};
    themInfo=nil;
    activityAnimator=nil;
    rewardTF=nil;
    conditionTxt=nil;
}

local data = {
    mainRoot = false, activityRoot = false, branchRoot = false,
    mainNormal = false, activityNormal = false, branchNormal = false,
    mainText = "", activityText = "", branchText = "",
    leftImg = false, rightImg = false,
    novelDetails = false,
    novelName = "", novelIntroText = "",
    mainEffect = false,
    themeShopBool = false;
    themeActivityBool = false;
    themeRewarded=false;
    themRewarding=false;
    themRewardPro=false;
    reviewBtnLock=false;
    
}

local command = {
    mainBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.curLabel = this.labelType.main
            this.SwitchLabel()
        end
    },
    branchBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.curLabel = this.labelType.branch
            this.SwitchLabel()
        end
    },
    activityBtnCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.curLabel = this.labelType.activity
            this.SwitchLabel()
        end
    },
    detailsCloseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.CloseDetails()
        end
    },
    playCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.activityNovelPlay()
        end 
    },
    topClickCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            for i = 1, #this.chapterReadConfig do
                this.chapterReadConfig[i] = this.chapterReadConfig[i] - 1
                if this.chapterReadConfig[i] <= 0 then
                    this.chapterReadConfig[i] = #this.chapterConfig
                end
            end
            this.UpdateChapter(true)
        end
    },
    bottomClickCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            for i = 1, #this.chapterReadConfig do
                this.chapterReadConfig[i] = this.chapterReadConfig[i] + 1
                if this.chapterReadConfig[i] > #this.chapterConfig then
                    this.chapterReadConfig[i] = 1
                end
            end
            this.UpdateChapter(true)
        end
    },







    themeShopCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            HeroParameter.ReviewActivityBarIndex=this.novelLabelNum
            LuaMgr.ShowLuaPanel(UIName.ReViewShopViewModel)
        end
    },
    themeActivityCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            HeroParameter.SaveNovelEventParam(this.curLabel,0,0)
            HeroParameter.ReviewActivityBarIndex=this.novelLabelNum;
           LuaMgr.ShowLuaPanel(this.themInfo.Panel);
        end
    },
    themeActivityRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local themeID=this.themeBarList[this.novelLabelNum].ID;
            ApiMgr.Request("activityreview/reward",{ID=themeID},true,function(result)
                local re=json.decode(result);
                local data=json.encode(re.result);
                LuaMgr.ShowItemRewared(data);
                this.InitParameter();
            end,nil,true)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.isLock = vm.behaviour.transform:Find("root/Left").gameObject
        
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/BranchRoot/BranchView").gameObject)
        this.scrollView.scrollRect.onValueChanged:RemoveListener(this.BranchListener)
        this.scrollView.scrollRect.onValueChanged:AddListener(this.BranchListener)
        this.itemTemplate = vm.behaviour.transform:Find("template/BranchItem").gameObject
        this.branchNumItem = vm.behaviour.transform:Find("template/BranchNum").gameObject
        
        this.novelTypeView = UIScrollView.New(vm.behaviour.transform:Find("root/ActivityRoot/NovelType/ItemView").gameObject)
        this.novelTemplate = vm.behaviour.transform:Find("template/NovelItem").gameObject
        
        this.activityTemplate = vm.behaviour.transform:Find("template/ActivityItem").gameObject
        this.itemScroll_1 = vm.behaviour.transform:Find("root/ActivityRoot/ScrollView_1").gameObject
        this.itemScroll_2 = vm.behaviour.transform:Find("root/ActivityRoot/ScrollView_2").gameObject
        this.itemScrollInfinite = ScrollRectInfinite.New(this.itemScroll_1,this.itemScroll_2,this.activityTemplate)
        
        this.chapterContent = vm.behaviour.transform:Find("root3D/MainRoot/MainChapterView/Viewport/Content")
        this.chapterTemplate = vm.behaviour.transform:Find("template/MainChapterItem").gameObject
        this.mainItemTemplate = vm.behaviour.transform:Find("template/MainItem").gameObject
        this.dragBehaviour = vm.behaviour.transform:Find("root3D/MainRoot/MainChapterView"):GetComponent("OnDragBehaviour")
        this.dragBehaviour.onBeginDrag = this.BeginDrag
        this.dragBehaviour.onEndDrag = this.EndDrag



        this.activityAnimator=vm.behaviour.transform:Find("root/ActivityRoot"):GetComponent("Animator")
        this.rewardTF=vm.behaviour.transform:Find("root/ActivityRoot/btns/reward/rewardTF");
        this.conditionTxt = vm.behaviour.transform:Find("root/ActivityRoot/btns/reward/state1"):GetComponent("Text")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.HidePanel()
        this.CloseDetails()
        this.RemoveUIEvent()
        this.scrollView:Clear(false)
        this.novelTypeView:Clear(false)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("BranchItemModel")
        UIScrollView.ClearItem("NovelItemModel")
        this.itemScrollInfinite:Close()
        this.DestroyPanel()
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.BranchItemClick, this.BranchItemClickEvent)
    LuaMgr.AddUIEventListener(UIEventConst.NovelItemClick, this.NovelItemClickEvent)
    LuaMgr.AddUIEventListener(UIEventConst.ActivityClick, this.ActivityItemClickEvent)
    LuaMgr.AddUIEventListener(UIEventConst.MainNovelSaveReadList,this.SaveReadList)
end
this.RemoveUIEvent = function()
    this.branchConfig = nil
    this.activityConfig = nil
    this.chapterConfig = nil
    this.chapterReadConfig = nil
    this.mainConfig = nil
    LuaMgr.RemoveUIEventListener(UIEventConst.BranchItemClick, this.BranchItemClickEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.NovelItemClick, this.NovelItemClickEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.ActivityClick, this.ActivityItemClickEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.MainNovelSaveReadList,this.SaveReadList)
end

this.SetLanguageText = function()
    this.vm.data.mainText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["9001"].NameLan)
    this.vm.data.branchText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["9002"].NameLan)
    this.vm.data.activityText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["9003"].NameLan)
end

this.InitParameter = function()
    this.SetThemeBarList();
    this.GetActivityConfig()
    this.activityNovelId = nil
    this.curLabel=HeroParameter.NovelTypeLabel;
    if this.curLabel == nil then
        this.curLabel=this.vm.behaviour.Params.Length>0 and this.labelType.activity or this.labelType.main;
    end
    SetActive(this.isLock,this.curLabel~=this.labelType.activity)
    this.vm.data.themeShopBool=false;
    this.vm.data.themeActivityBool=false;
    this.SwitchLabel()
end

this.SetThemeBarList=function()
    this.themeBarList={}
    this.themInfo=nil;
    for i,v in pairs(ConfigMgr.Config.ActivityThemeMap) do
        if LuaMgr.Timestamp()>v.StartTime then

            if v.Key== ActivityKey.entry then
                local groupId = ActivityMgr.groupKeyList["entry"]
                if DataMgr.Player.variables[groupId] ~= nil and DataMgr.Player.variables[groupId].clientFished then
                    table.insert(this.themeBarList,v);
                end
            else
                table.insert(this.themeBarList,v);
            end
        end
    end
    this.tableSort(this.themeBarList,function(a, b) return a.Arrange<b.Arrange end);
end
this.SetMainView = function()
    this.GetMainConfig()
    local tempItem = nil
    local config = nil
    for i = 1, #this.chapterReadConfig do
        if #this.chapterList < i then
            tempItem = ChapterItemModel.New(this.chapterTemplate,this.chapterContent,this.mainItemTemplate)
            this.tableInsert(this.chapterList,tempItem)
        end
        config = ConfigMgr.Config.areas[this.chapterConfig[this.chapterReadConfig[i]]]
        this.chapterList[i]:SetData(config,this.mainConfig[config.area],i,HeroParameter.MainIndexList == nil)
    end
    this.vm.data.mainEffect = false
end

this.SetBranchView = function()
    this.scrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    this.GetBranchConfig()
    local length = #this.branchConfig
    for i = 1, length do
        groupData = {}
        groupData.item = this.branchNumItem
        groupData.branch = this.branchConfig[i]
        scrollData = UIScrollData.GetData(this.itemTemplate,"BranchItemModel",248 + 36,348,groupData)
        this.tableInsert(scrollDatas,scrollData)
    end
    this.scrollView:SetParams(1177 + LuaMgr.GetScreenAddWidth(),520)
    if HeroParameter.NovelTypeLabel ~= nil then
        this.scrollView.contentX = HeroParameter.contentX
        this.scrollView.contentY = HeroParameter.contentY
        this.scrollView:SetData(scrollDatas, false)
    else
        this.scrollView:SetData(scrollDatas, true)
    end
    local isShow = this.scrollView.scrollRect.content.sizeDelta.x > this.scrollView.rectWidth
    if isShow then
        local normalizedPosition = this.scrollView.scrollRect.horizontalNormalizedPosition
        this.vm.data.leftImg = normalizedPosition > 0
        this.vm.data.rightImg = normalizedPosition < 1
    end
end

this.SetActivityView = function()
    this.novelTypeView:Clear(false)
    this.novelLabelNum = nil;
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local index = 1
    local isLockAll=true;
    for key,value in ipairs(this.themeBarList) do
        groupData = {}
        groupData.item = this.novelTemplate
        groupData.type = value.GroupID
        groupData.index = index
        groupData.select = false
        groupData.isUnLock=this.CheckActivityThemeUnLock(value.ID)
        groupData.isRed=PlayerCharacterMgr.GetActivityThemeReviewRed(value.ID)>0
        scrollData = UIScrollData.GetData(this.novelTemplate,"NovelItemModel",100 + 20,100,groupData)
        this.tableInsert(scrollDatas,scrollData)
        if groupData.isUnLock then
            isLockAll=false;
            if this.novelLabelNum==nil then
                this.novelLabelNum=index;
            end
        end
        index = index + 1
    end
    if isLockAll then
        this.vm.data.reviewBtnLock=true;
        this.vm.data.themeActivityBool=false;
        this.vm.data.themeShopBool=false;
    else
        this.vm.data.reviewBtnLock=false;
    end
    if HeroParameter.ReviewActivityBarIndex~=nil then
        this.novelLabelNum=HeroParameter.ReviewActivityBarIndex;
    end
    this.novelTypeView:SetParams(790,130)
    this.novelTypeView:SetData(scrollDatas, true)
    if #this.novelTypeView.itemMap > 0 and not isLockAll then
        if #this.novelTypeView.itemMap < this.novelLabelNum then
            this.novelTypeView:MoveToIndex(this.novelLabelNum)
        end
        this.novelTypeView.itemMap[this.novelLabelNum].clickCommand()
    end
end

this.CheckActivityThemeUnLock=function(ID)
    if IsNull(DataMgr.Player.activityReview) or IsNull(DataMgr.Player.activityReview.unlock) then 
        return false
    end;
    if DataMgr.Player.activityReview.unlock[ID]==nil then
        return false;
    end
    return DataMgr.Player.activityReview.unlock[ID]>0;
end


this.SwitchLabel = function()
    this.vm.data.mainRoot = this.curLabel == this.labelType.main
    this.vm.data.mainNormal = this.curLabel ~= this.labelType.main
    
    this.vm.data.branchRoot = this.curLabel == this.labelType.branch
    this.vm.data.branchNormal = this.curLabel ~= this.labelType.branch
    
    this.vm.data.activityRoot = this.curLabel == this.labelType.activity
    this.vm.data.activityNormal = this.curLabel ~= this.labelType.activity
    
    this.UpdateViewData()
end

this.UpdateViewData = function()
    if this.curLabel == this.labelType.main then
        this.SetMainView()
    elseif this.curLabel == this.labelType.branch then
        this.SetBranchView()
    elseif this.curLabel == this.labelType.activity then
        this.SetActivityView() 
    end
    HeroParameter.EmptyNovelEventParam()
end

this.BranchItemClickEvent = function(args)
    HeroParameter.SaveNovelEventParam(this.curLabel,this.scrollView.contentX,this.scrollView.contentY)
    local novelId = args[0]
    LuaMgr.PlayNovel(novelId,function() LuaMgr.ShowLuaPanel(UIName.EventPlaybackViewModel) end)
end

this.NovelItemClickEvent = function(args)
    local index,activityType = args[0],args[1]
    if  not this.CheckActivityThemeUnLock(this.themeBarList[index].ID) then
        LuaMgr.ShowLuaPanel(UIName.ReViewUnlockViewModel,this.themeBarList[index].ID,activityType,function()
            HeroParameter.ReviewActivityBarIndex = index
            this.InitParameter();
        end)
        return;
    end
    this.activityAnimator:Play("UI_EventPlayback_ActivityBar",0,0);
    if this.novelLabelNum ~= index then
        if this.novelTypeView.itemMap[this.novelLabelNum] == nil then
            this.novelTypeView.dataList[this.novelLabelNum].data.select = false
            this.novelTypeView:Refresh()
        else
            this.novelTypeView.itemMap[this.novelLabelNum]:Close()
        end
    end
    this.novelLabelNum = index
    this.novelTypeView.itemMap[this.novelLabelNum]:Open()
    this.itemScrollInfinite:SetData(this.activityConfig[activityType])
    this.themInfo=this.themeBarList[index];
    this.vm.data.themeShopBool=this.themInfo.OpenShop>0;
    this.vm.data.themeActivityBool=this.themInfo.OpenActive>0;
    this.SetActivityThemeReward(index);
    this.conditionTxt.text=LuaMgr.GetLangText(ConfigMgr.Config.ActivityThemeMap[this.themeBarList[index].ID].NameLan)
end


this.SetActivityThemeReward=function(index)
    local curTheme=this.themeBarList[index]
    if IsNull(curTheme.Rewards) then
        return;
    end
    local isRewarded=this.CheckActivityThemeReward(curTheme.ID);
    local isRewarding=PlayerCharacterMgr.GetActivityThemeReviewRed(curTheme.ID)>0;
    this.vm.data.themRewardPro=not isRewarded and not isRewarding;
    this.vm.data.themRewarding=isRewarding;
    this.vm.data.themeRewarded=isRewarded;
    local reward=curTheme.Rewards[1]
    if this.item==nil then
        this.item=GoodsDataItem.New(this.rewardTF)
    end
    local itemConfig = ConfigMgr.Config.itemMap[reward.id]
    itemConfig["count0"] = reward.count
    this.item:SetData(1,itemConfig,1,false,Vector3(0.5,0.5,0.5),false)
end

this.CheckActivityThemeReward=function(id)
    if IsNull(DataMgr.Player.activityReview) or IsNull(DataMgr.Player.activityReview.reward) then
        return false;
    end
    return DataMgr.Player.activityReview.reward[id]~=nil;
end

this.ActivityItemClickEvent = function(args)
    this.selectObject = args[2]
    this.OpenDetails(args[0],args[1])
end
this.SaveReadList = function(args)
    HeroParameter.SaveNovelMainIndexList(this.chapterReadConfig)
end
this.OpenDetails = function(plotId,plotInfoLan)
    SetActive(this.selectObject,true)
    this.activityNovelId = ConfigMgr.Config.narrativeMap[plotId].script
    this.vm.data.novelName = LuaMgr.GetLangText(ConfigMgr.Config.narrativeMap[plotId].nameLan)
    this.vm.data.novelIntroText = LuaMgr.GetLangText(plotInfoLan)
    this.vm.data.novelDetails = true
end
this.activityNovelPlay = function()
    if this.activityNovelId == nil or this.activityNovelId == "" then
        return
    end
    HeroParameter.SaveNovelEventParam(this.curLabel,0,0)
    HeroParameter.ReviewActivityBarIndex=this.novelLabelNum
    LuaMgr.PlayNovel(this.activityNovelId,function() LuaMgr.ShowLuaPanel(UIName.EventPlaybackViewModel) end)
end
this.CloseDetails = function()
    SetActive(this.selectObject,false)
    this.vm.data.novelDetails = false
    this.vm.data.novelName = ""
    this.vm.data.novelIntroText = ""
    this.selectObject = nil
    this.activityNovelId = nil
end

this.BranchListener = function()
    local isShow = this.scrollView.scrollRect.content.sizeDelta.x > this.scrollView.rectWidth
    if isShow then
        local normalizedPosition = this.scrollView.scrollRect.horizontalNormalizedPosition
        this.vm.data.leftImg = normalizedPosition > 0
        this.vm.data.rightImg = normalizedPosition < 1
    end
end
this.GetBranchConfig = function()
    if this.branchConfig == nil then
        this.branchConfig = {}
        local isBanned = false
        for key,value in pairs(ConfigMgr.Config.BranchPlotMap) do
            isBanned = FeatureManager.UnifyVerControls("branchPlot",key)
            if isBanned then
                this.tableInsert(this.branchConfig,value)
            end
        end
        this.tableSort(this.branchConfig,this.SortBranch)
    end
end
this.GetActivityConfig = function()
    if this.activityConfig == nil then
        this.activityConfig = {}
        local type = nil

        for key,value in pairs(ConfigMgr.Config.ActivityPlotMap) do
            if ConfigMgr.Config.narrativeMap[value.PlotId] ~= nil then
                if value.StartTime < LuaMgr.Timestamp() then
                    type = value.ActivityType






                    if this.activityConfig[type] == nil then
                        this.activityConfig[type] = {}
                    end
                    this.tableInsert(this.activityConfig[type],value)
                end

            else
                print("剧情id找不到配置："..value.PlotId)
            end
        end
        for key,value in pairs(this.activityConfig) do
            this.tableSort(value,this.SortBranch)
        end
    end
end
this.GetMainConfig = function()
    if this.mainConfig == nil then
        this.mainConfig = {}
        local type = nil
        for i = 1, #ConfigMgr.Config.MainPlotMap do
            type = ConfigMgr.Config.MainPlotMap[i].MainType

            local isBanned = FeatureManager.UnifyVerControls("areamap",type)
            if isBanned then
                if this.mainConfig[type] == nil then
                    this.mainConfig[type] = {}
                end
                this.tableInsert(this.mainConfig[type],ConfigMgr.Config.MainPlotMap[i])
            end
        end
        this.chapterConfig = {}
        local index = 1
        for key,value in pairs(this.mainConfig) do

            local isBanned = FeatureManager.UnifyVerControls("areamap",key)
            if isBanned then

                this.chapterConfig[index] = key
                index = index + 1
            end
        end
        this.tableSort(this.chapterConfig,this.SortChapter)
        if HeroParameter.MainIndexList ~= nil then
            this.chapterReadConfig = HeroParameter.MainIndexList
        else
            local sortNum = 1
            this.chapterReadConfig = {ConfigHelper.GetTableLength(this.chapterConfig),sortNum, sortNum + 1}
        end
    end
end

this.OnDrag = function()










    























    

















































    








































    this.chapterList[1].transform.localPosition = Vector3(this.chapterList[1].transform.localPosition.x,this.chapterList[1].transform.localPosition.y,this.position_1)

    this.chapterList[1].transform.localScale = Vector3(this.scale_1,this.scale_1,this.scale_1)
    this.chapterList[1].transform.localRotation = UnityEngine.Quaternion.Euler(Vector3(this.rotation_1,0,0))

    this.chapterList[2].transform.localPosition = Vector3(this.chapterList[2].transform.localPosition.x,this.chapterList[2].transform.localPosition.y,this.position_2)

    this.chapterList[2].transform.localScale = Vector3(this.scale_1,this.scale_1,this.scale_2)
    this.chapterList[2].transform.localRotation = UnityEngine.Quaternion.Euler(Vector3(this.rotation_2,0,0))

    this.chapterList[3].transform.localPosition = Vector3(this.chapterList[3].transform.localPosition.x,this.chapterList[3].transform.localPosition.y,this.position_3)

    this.chapterList[3].transform.localScale = Vector3(this.scale_1,this.scale_1,this.scale_3)
    this.chapterList[3].transform.localRotation = UnityEngine.Quaternion.Euler(Vector3(this.rotation_3,0,0))
    



end

this.BeginDrag = function(eventData)
    this.vm.data.mainEffect = false
    this.clickContentY = this.dragBehaviour.content.anchoredPosition.y
    this.rotation_1,this.rotation_2,this.rotation_3 = 7.75,0,-7.75
    this.scale_1,this.scale_2,this.scale_3 = 1,1,1


end

this.EndDrag = function(eventData)
    this.dragBehaviour:StopMovement()
    DOTWeen.To(
            function() return this.dragBehaviour.content.anchoredPosition end,
            function(vector)
                this.dragBehaviour.content.anchoredPosition = vector
            end,
            Vector2.zero, 0.3):SetEase(Ease.OutCubic)
    
    local isUpdate = false
    if this.dragBehaviour.content.anchoredPosition.y < 0 then
        isUpdate = true
        for i = 1, #this.chapterReadConfig do
            this.chapterReadConfig[i] = this.chapterReadConfig[i] - 1
            if this.chapterReadConfig[i] <= 0 then
                this.chapterReadConfig[i] = #this.chapterConfig
            end
        end
    else
        isUpdate = true
        for i = 1, #this.chapterReadConfig do
            this.chapterReadConfig[i] = this.chapterReadConfig[i] + 1
            if this.chapterReadConfig[i] > #this.chapterConfig then
                this.chapterReadConfig[i] = 1
            end
        end
    end
    this.UpdateChapter(isUpdate)
end

this.UpdateChapter = function(isUpdate)
    if isUpdate then
        this.vm.data.mainEffect = true
        AudioMgr.Singleton:PlayUISFX(Path.audio_PATH.."newUI/File_open.mp3")
        local config = nil
        for i = 1, #this.chapterList do
            config = ConfigMgr.Config.areas[this.chapterConfig[this.chapterReadConfig[i]]]
            if this.chapterList[i].uiScroll ~= nil then
                this.chapterList[i].uiScroll.scrollRect:StopMovement()
            end
            this.chapterList[i]:SetData(config,this.mainConfig[config.area],i,true)
        end
    end
end


this.SortBranch = function(item1,item2)
    return item1.Arrange < item2.Arrange
end

this.SortChapter = function(item1,item2)
    return ConfigMgr.Config.areas[item1].sortNum < ConfigMgr.Config.areas[item2].sortNum
end

this.HidePanel = function()
    for i = 1, #this.chapterList do
        this.chapterList[i]:Clear()
    end
end

this.DestroyPanel = function()
    for i = 1, #this.chapterList do
        this.chapterList[i]:Destroy()
    end
    this.chapterList = {}
end
return vm({
    data = data,
    command = command,
    hook = hook
})