




require("ViewModel/Terminal/PhotoItemModel")
require("ViewModel/Terminal/RewardItemModel")
local this = {
    vm = nil,tableInsert = table.insert,
    tableSort = table.sort,
    labelList = nil,labelIndex = 1,
    timeTipPos = nil,timeTipText = nil,
    collectReward = nil,allGetBtn = nil,
    collectCount = nil,collectCanGet = nil,collectNo = nil,
    collectCanGetEffect = nil,isHaveCanGet = nil,
    heroConfig = nil,heroTotalCount = nil,heroHaveCount = nil,
    heroPicList = nil,heroPicObj = nil,heroDrawings = nil,
    scrollView = nil,rewardItemObj = nil,labelTransform = nil,
    rootAnim = nil,
}

local data = {
    rewardTipText = "",shearText = "",
}

local command = {
    labelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param)
            this.SetLabelChoose(index)
            this.rootAnim:Play("UI_GroupPhotoPanel_02",0,0)
        end
    },
    shearCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.Shear()
        end
    },
    rewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.InitReward()
        end
    },
    maskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            SetActive(this.collectReward,false)
        end
    },
    allGetCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.AllGetReward()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.heroPicObj = vm.behaviour.transform:Find("template/HeroPic").gameObject
        this.rewardItemObj = vm.behaviour.transform:Find("template/RewardItem").gameObject
        this.heroDrawings = vm.behaviour.transform:Find("root/Drawings"):GetComponent("RectTransform")
        this.timeTipPos = vm.behaviour.transform:Find("root/Middle/_Middle/TimeTip"):GetComponent("RectTransform")
        this.timeTipText = vm.behaviour.transform:Find("root/Middle/_Middle/TimeTip/Time/Text"):GetComponent("Text")
        this.allGetBtn = vm.behaviour.transform:Find("root/CollectReward/Reward/AllGetBtn").gameObject
        this.collectReward = vm.behaviour.transform:Find("root/CollectReward").gameObject
        this.collectCount = vm.behaviour.transform:Find("root/Middle/_Middle/Reward/Count"):GetComponent("Text")
        this.collectNo = vm.behaviour.transform:Find("root/Middle/_Middle/Reward/No").gameObject
        this.collectCanGetEffect = vm.behaviour.transform:Find("root/Middle/_Middle/Reward/ui_fx_GroupPhotoPanel_CanGet").gameObject
        this.collectCanGet = vm.behaviour.transform:Find("root/Middle/_Middle/Reward/CanGet").gameObject
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/CollectReward/Reward/Scroll").gameObject)
        this.labelTransform = vm.behaviour.transform:Find("root/Middle/_Middle"):GetComponent("Transform")
        this.rootAnim = vm.behaviour.transform:Find("root"):GetComponent("Animator")
        this.shareObject = vm.behaviour.transform:Find("root/Middle/_Middle/ShareBtn").gameObject
        this.GetLabelUiRoot(this.labelTransform)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.GetHeroConfig()
        this.SetCollectCount()
        this.SetCollectState()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.heroTotalCount = nil
        this.heroHaveCount = nil
        this.RemoveUIEvent()
        this.ClearHeroPicList()
        this.scrollView:Clear(false)
        SetActive(this.collectReward,false)
        SetActive(this.labelList[this.labelIndex].choose,false)
    end,
    before_destroy = function(vm)
        this.DestroyHeroPicList()
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.GroupGetRewardClick, this.RewardGetEvent)
end
this.RemoveUIEvent = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.GroupGetRewardClick, this.RewardGetEvent)
end


this.SetLanguageText = function()
    this.vm.data.rewardTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5702"].NameLan)
    this.vm.data.shearText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5704"].NameLan)
end


this.InitParameter = function()
    local shareStatus = ConfigHelper.GetShareStatus("Closegroupphoto");
    SetActive(this.shareObject, shareStatus)
    this.labelIndex = -1
    if this.heroPicList == nil then
        this.heroPicList = {}
    end
    this.SetLabelChoose(1)
end


this.InitReward = function()
    this.scrollView.scrollRect:StopMovement()
    this.scrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    for key,value in pairs(DataMgr.Player.missions["groupPhoto"]["901"]) do
        groupData = {}
        groupData.data = value
        scrollData = UIScrollData.GetData(this.rewardItemObj,"RewardItemModel",864,80,groupData)
        this.tableInsert(scrollDatas,scrollData)
    end
    if this.isHaveCanGet then
        this.scrollView:SetParams(878,387)
    else
        this.scrollView:SetParams(878,439)
    end
    this.tableSort(scrollDatas,this.RewardSort)
    this.scrollView:SetData(scrollDatas, true)
    SetActive(this.allGetBtn,this.isHaveCanGet)
    SetActive(this.collectReward,true)
end


this.SetLabelChoose = function(index)
    if this.labelIndex ~= -1 then
        SetActive(this.labelList[this.labelIndex].choose,false)
    end
    this.labelIndex = index
    SetActive(this.labelList[index].choose,true)
    local x,y = this.labelList[index].anchoredPosition.x,nil
    if index % 2 == 0 then
        y = -344
    else
        y = -244
    end
    if (not LuaMgr.ScreenCompare() or LuaMgr.GetScreenAddWidth() > 315) and index == 1 then x = x + 50 end
    this.timeTipPos.anchoredPosition = Vector2(x,y)
    this.timeTipText.text = LuaMgr.GetLangText(ConfigMgr.Config.GroupPhotoTypeMaps[index].TimeInfoLan)
    this.CreateHeroPic()
end


this.CreateHeroPic = function()
    local template = nil
    for i = 1, #this.heroConfig[this.labelIndex] do
        if #this.heroPicList < i then
            template = PhotoItemModel.New(this.heroPicObj,this.heroDrawings)
            this.tableInsert(this.heroPicList,template)
        end
        this.heroPicList[i]:SetData(this.heroConfig[this.labelIndex][i].id)
    end
    for i = #this.heroConfig[this.labelIndex] + 1, #this.heroPicList do
        this.heroPicList[i]:Clear()
    end
end

this.GetHeroConfig = function()
    if this.heroConfig == nil then
        local tempMap = {}
        local tempConfig = nil

        for key,value in pairs(ConfigMgr.Config.historicalRelicsMap) do
            if ConfigMgr.Config.GroupPhotoConfigMap[key] ~= nil then
                if ConfigMgr.Config.characterTable[key].Switch == 0 then
                    if tempMap[value.photoDynasty] == nil then
                        tempMap[value.photoDynasty] = {}
                    end
                    tempConfig = table.Copy(value)
                    tempConfig.layer = ConfigMgr.Config.GroupPhotoConfigMap[key].Layer
                    this.tableInsert(tempMap[value.photoDynasty],tempConfig)
                end
            else
                print("GroupPhotoConfigMap表没有配置"..key)
            end
        end

        this.heroConfig = {}
        local dynasty = nil
        for i = 1, #ConfigMgr.Config.GroupPhotoTypeMaps do
            this.heroConfig[i] = {}
            for j = 1, #ConfigMgr.Config.GroupPhotoTypeMaps[i].DynastyGroup do
                dynasty = ConfigMgr.Config.GroupPhotoTypeMaps[i].DynastyGroup[j]
                if tempMap[dynasty] ~= nil then
                    for t = 1, #tempMap[dynasty] do
                        this.tableInsert(this.heroConfig[i],tempMap[dynasty][t])
                    end   
                end
            end
        end
        tempMap,tempConfig = nil,nil
        for i = 1, #this.heroConfig do
            this.tableSort(this.heroConfig[i],this.HeroLayerSort)
        end
    end
end


this.RewardGetEvent = function(args)
    if args ~= nil and args.Length > 0 then
        local missionId = args[0]
        local tempData = {}
        tempData.Tab = "groupPhoto"
        tempData.MissionID = missionId
        ApiMgr.Request("complete_mission",tempData,true,function(result)
            this.GetRewardResult(result)
        end,nil,true)
        missionId,tempData = nil,nil
    end
end

this.AllGetReward = function()
    local tempData,eventIdList = {},{}
    tempData.Tab = "groupPhoto"
    for key,value in pairs(DataMgr.Player.missions["groupPhoto"]["901"]) do
        if not value.completed and value.current >= value.target then
            this.tableInsert(eventIdList,key)
        end
    end
    tempData.MissionIDs = eventIdList
    ApiMgr.Request("complete_mission",tempData,true,function(result)
        this.GetRewardResult(result)
    end,nil,true)
    tempData,eventIdList = nil,nil
end

this.GetRewardResult = function(result)
    local re = json.decode(result)
    local resultData = json.encode(re.result)
    LuaMgr.ShowItemRewared(resultData,nil)
    this.SetCollectState()
    this.InitReward()
end


this.Shear = function()
    LuaMgr.HidePanel("Laigu.ViewModel.TopBarViewModel")
    LuaMgr.HidePanel(UIName.MessageTipsViewModel)
    LuaMgr.HidePanel(UIName.NoticeRollhorseViewModel)
    SetActive(this.labelTransform.gameObject,false)
    local filename = "screenshot/shareScreenshot.png"
    LuaMgr.NextFrame(function()
        LuaMgr.CaptureScreenshot(filename)
        local path = UnityEngine.Application.persistentDataPath..'/'..filename
        LuaMgr.NextFrame(function()
            LuaMgr.ShowPanel("Laigu.ViewModel.SharePopupViewModel","collect",path,function()
                SetActive(this.labelTransform.gameObject,true)
                this.vm.behaviour:UpdateTopBar("",nil)
            end)
        end)
    end)
end


this.SetCollectCount = function()
    this.heroHaveCount = 0
    this.heroTotalCount = 0
    for i = 1, #this.heroConfig do
        this.heroTotalCount = this.heroTotalCount + #this.heroConfig[i]
        for j = 1, #this.heroConfig[i] do
            if DataMgr.Player.characters[this.heroConfig[i][j].id] ~= nil then
                this.heroHaveCount = this.heroHaveCount + 1
            end
        end
    end
    local strTip = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["5703"].NameLan)
    this.collectCount.text = string.format(strTip,this.heroHaveCount,this.heroTotalCount)
end

this.SetCollectState = function()
    this.isHaveCanGet = false

    for key,value in pairs(DataMgr.Player.missions["groupPhoto"]["901"]) do
        if not value.completed and value.current >= value.target then
            this.isHaveCanGet = true
            break
        end
    end
    SetActive(this.collectNo,not this.isHaveCanGet)
    SetActive(this.collectCanGetEffect,this.isHaveCanGet)
    SetActive(this.collectCanGet,this.isHaveCanGet)
end

this.HeroLayerSort = function(item1,item2)
    return item1.layer < item2.layer
end

this.RewardSort = function(item1,item2)
    local targetCount1 = item1.data.data.target
    local targetCount2 = item2.data.data.target
    if item1.data.data.completed == item2.data.data.completed then
        if item1.data.data.current / targetCount1 ~= item2.data.data.current / targetCount2 then
            return item1.data.data.current / targetCount1 > item2.data.data.current / targetCount2
        else
            return item1.data.data.id < item2.data.data.id
        end
    else
        return not item1.data.data.completed and item2.data.data.completed
    end
end

this.ClearHeroPicList = function()
    if this.heroPicList == nil or #this.heroPicList == 0 then return end
    for i = 1, #this.heroPicList do
        this.heroPicList[i]:Clear()
    end
end

this.DestroyHeroPicList = function()
    UIScrollView.ClearItem("RewardItemModel")
    if this.heroPicList == nil or #this.heroPicList == 0 then return end
    for i = 1, #this.heroPicList do
        this.heroPicList[i]:Destroy()
    end
end

this.GetLabelUiRoot = function(transform)
    if this.labelList == nil then
        this.labelList = {}
    end
    local label = {
        normalText = {path = "Text",type = "Text"},
        choose = {path = "Choose",type = "GameObject"},
        chooseText = {path = "Choose/Text",type = "Text"}}
    local object,item,text = nil,{},nil
    for i = 1, #ConfigMgr.Config.GroupPhotoTypeMaps do
        object = transform:Find("LabelBtn_"..i)
        if object ~= nil then
            item = {}
            text = LuaMgr.GetLangText(ConfigMgr.Config.GroupPhotoTypeMaps[i].ButtonTextLan)
            UITool.Parse(object,item,label)
            item.normalText.text = text
            item.chooseText.text = text
            item.anchoredPosition = object.anchoredPosition
            this.tableInsert(this.labelList,item)
        end
    end
    label = nil
end

return vm({
    data = data,
    command = command,
    hook = hook
})