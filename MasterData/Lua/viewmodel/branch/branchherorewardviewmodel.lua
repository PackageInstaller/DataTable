




require("ViewModel/Branch/BHRewardItemModel")

local this = {vm = nil,storyId = nil,tableInsert = table.insert,
              tableSort = table.sort,questEvents = nil,groupId = nil,
              missionConfig = nil,activityData = nil,
              allGetItem = nil,allGetText = nil,allGetBtnText = nil,
              scrollView = nil,rewardItemObj = nil,timeText = nil,
              labelConfig = nil,middleAnim = nil,
              head_Icon_choose = "Assets/_BundleResources/Images/BranchHero/head_c_",
              head_Icon_normal = "Assets/_BundleResources/Images/BranchHero/head_n_",
}

local data = {
    headItem = {{normalIcon = DefaultTexture,chooseIcon = DefaultTexture,choose = false,red = false}}
}

local command = {
    allGetCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.GetAllSortReward()
        end
    },
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.HidePanel(UIName.BranchHeroRewardViewModel)
        end
    },
    labelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.activityData.expireTime < LuaMgr.Timestamp() then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7023"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
                return
            end
            local index = tonumber(param) + 1
            this.storyId = this.vm.data.headItem[index].storyId
            this.SwitchLabel()
            this.InitMission()
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.timeText = vm.behaviour.transform:Find("root/Middle/TimeText"):GetComponent("Text")
        this.allGetItem = vm.behaviour.transform:Find("root/Middle/AllGetItem").gameObject
        this.allGetText = vm.behaviour.transform:Find("root/Middle/AllGetItem/Text"):GetComponent("Text")
        this.allGetText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15010"].NameLan)
        this.allGetBtnText = vm.behaviour.transform:Find("root/Middle/AllGetItem/Btn/Text"):GetComponent("Text")
        this.allGetBtnText.text = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15008"].NameLan)
        
        this.middleAnim = vm.behaviour.transform:Find("root/Middle"):GetComponent("Animator")
        this.rewardItemObj = vm.behaviour.transform:Find("template/BHRewardItem").gameObject
        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/ScrollView").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.scrollView:Clear(false)
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("BHRewardItemModel")
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.BranchHeroGetReward, this.GetSortReward)
end
this.RemoveUIEvent = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.BranchHeroGetReward, this.GetSortReward)
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length > 0 then
        this.groupId = this.vm.behaviour.Params[1]
    else
        this.groupId = ActivityMgr.groupKeyList["Story1"]
    end
    this.activityData = DataMgr.Player.variables[this.groupId]
    local time = this.activityData.expireTime - LuaMgr.Timestamp()
    local d,h,m = GetTimeDHM2(time)
    local timeStr = ConfigMgr.LangGlobal("10908")
    this.timeText.text = string.format(timeStr,d,h,m)
    
    local typeId = tonumber(string.sub(this.groupId,7))
    this.questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(typeId)
    this.GetLabelConfig()

    if this.vm.behaviour.Params.Length > 0 then
        this.storyId = this.vm.behaviour.Params[0]
    else
        this.storyId = this.labelConfig[1].storyId
    end
    this.InitLabel()
    this.InitMission()
    this.HeadRed()
end

this.InitLabel = function()
    local tempList,tempItem = {},{}
    for i = 1, #this.labelConfig do
        tempItem = {
            choose = this.labelConfig[i].storyId == this.storyId,storyId = this.labelConfig[i].storyId,
            normalIcon = LuaMgr.GetTexture(this.head_Icon_normal..this.labelConfig[i].heroId..".png"), 
            chooseIcon = LuaMgr.GetTexture(this.head_Icon_choose..this.labelConfig[i].heroId..".png"),
            red = false}
        this.tableInsert(tempList,tempItem)
    end
    this.tableSort(tempList,this.LabelSort)
    this.vm.data.headItem = tempList
end
this.SwitchLabel = function()
    local isShow = false
    for i = 1, #this.vm.data.headItem do
        isShow = this.vm.data.headItem[i].storyId == this.storyId
        this.vm.data.headItem[i].choose = isShow
    end
    this.middleAnim:Play("ani_BranchHeroRewardPanel_BHMiddle",0,0)
end

this.InitMission = function()
    this.GetMissionConfig()
    this.scrollView.scrollRect:StopMovement()
    this.scrollView:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local canCount = 0
    for i = 1, #this.missionConfig do
        groupData = {}
        groupData.index = i
        groupData.config = this.missionConfig[i]
        if DataMgr.Player.quests[this.missionConfig[i].id] == nil then
            goto continue
        end
        groupData.data = DataMgr.Player.quests[this.missionConfig[i].id]
        if groupData.data.state == 2 and groupData.config.progress == groupData.data.progress then
            canCount = canCount + 1
            groupData.sortNum = 1
        elseif groupData.data.state == 1 then
            groupData.sortNum = 2
        else
            groupData.sortNum = 3
        end
        scrollData = UIScrollData.GetData(this.rewardItemObj,"BHRewardItemModel",715,92,groupData)
        this.tableInsert(scrollDatas,scrollData)
        ::continue::
    end
    if canCount >= 2 then
        this.scrollView:SetParams(715,330)
    else
        this.scrollView:SetParams(715,420)
    end
    this.tableSort(scrollDatas,this.RewardSort)
    this.scrollView:SetData(scrollDatas, true)
    SetActive(this.allGetItem,canCount >= 2)
end
this.HeadRed = function()
    if this.vm.behaviour.Params.Length > 0 then
        return
    end
    local groupId = ActivityMgr.groupKeyList["Story1"]
    local typeId = tonumber(string.sub(groupId,7))
    local questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(typeId)
    local tempData = nil
    for i = 1, #this.vm.data.headItem do
        this.vm.data.headItem[i].red = false
        for j = 1, #questEvents do
            if questEvents[j].text == this.vm.data.headItem[i].storyId then
                tempData = DataMgr.Player.quests[questEvents[j].id]
                if tempData.state == 2 and questEvents[j].progress == tempData.progress then
                    this.vm.data.headItem[i].red = true
                    break
                end
            end
        end
    end
end

this.GetAllCanRewardId = function()
    local canIds = {}
    for i = 1, #this.missionConfig do
        if DataMgr.Player.quests[this.missionConfig[i].id].state == 2 then
            this.tableInsert(canIds,this.missionConfig[i].id)
        end
    end
    return canIds
end

this.GetAllSortReward = function()
    if this.activityData.expireTime < LuaMgr.Timestamp() then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7023"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
    end
    local canIds = this.GetAllCanRewardId()
    if #canIds <= 0 then return end
    local askData={questIds=canIds}
    ApiMgr.Request("ex/get_award", askData, true, function(result)
        local re=json.decode(result);
        local tempData = json.encode(re.result);
        LuaMgr.ShowItemRewared(tempData);
        this.HeadRed()
        this.InitMission()
        LuaMgr.InvokeUIEventListeners(UIEventConst.BranchHeroRedUpDate)
    end, nil, true);
end

this.GetSortReward = function(args)
    if this.activityData.expireTime < LuaMgr.Timestamp() then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7023"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
    end
    if args ~= nil and args.Length > 0 then
        local id,index = args[0],args[1]
        DataExHelper.EX_GetAward(id,function()
            LuaMgr.InvokeUIEventListeners(UIEventConst.BranchHeroRedUpDate)
            local num = this.scrollView:GetIndex()
            for i = 1, ConfigHelper.GetTableLength(this.scrollView.itemMap) do
                if this.scrollView.itemMap[num].index == index then
                    this.scrollView.itemMap[num]:PlayAnim()
                    break
                end
                num = num + 1
            end
            this.HeadRed()
            this.InitMission()
        end)
    end
end
this.GetLabelConfig = function()
    this.labelConfig = {}
    local temp = {}
    for i = 1, #this.questEvents do
        if temp[this.questEvents[i].text] == nil then
            temp[this.questEvents[i].text] = this.questEvents[i].text
        end
    end
    for key,value in pairs(temp) do
        this.tableInsert(this.labelConfig,{storyId = key,heroId = this.GetLabelHeroId(key)})
    end
    this.tableSort(this.labelConfig,this.LabelSort)
    temp = nil
end
this.GetLabelHeroId = function(text)
    for i = 1, #ConfigMgr.Config.branchStoryList do
        if ConfigMgr.Config.branchStoryList[i].ID == text then
            return ConfigMgr.Config.branchStoryList[i].page
        end
    end
    return ""
end
this.GetMissionConfig = function()
    this.missionConfig = {}
    for i = 1, #this.questEvents do
        if this.questEvents[i].text == this.storyId then
            this.tableInsert(this.missionConfig,this.questEvents[i])
        end
    end
end
this.RewardSort = function(item1,item2)
    local targetCount1 = item1.data.config.progress
    local targetCount2 = item2.data.config.progress
    if item1.data.sortNum == item2.data.sortNum then
        if item1.data.data.progress / targetCount1 ~= item2.data.data.progress / targetCount2 then
            return item1.data.data.progress / targetCount1 > item2.data.data.progress / targetCount2
        else
            return item1.data.data.id < item2.data.data.id
        end
    else
        return item1.data.sortNum < item2.data.sortNum
    end
end
this.LabelSort = function(item1,item2)
    return item1.storyId < item2.storyId
end
return vm({
    data = data,
    command = command,
    hook = hook
})