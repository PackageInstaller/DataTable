





local this = {
    vm = nil,activityData = nil,groupId = nil,questEvents = nil,
    heatList = nil,rewardUIRoot = {},rewardData = {},
    c_Color = UnityEngine.Color(199/255,105/255,59/255,1),
    n_Color = UnityEngine.Color(121/255,119/255,78/255,1),
    rewardContent = nil,
    rewardPos = {{{-4.6,29.3}},{{-3.6,80.7},{-3.6,-19.5}},{{-3.6,80.7},{-49.6,-19.7},{42.1,-19.7}}}
}

local data = {
    timeText = "",tipText = "",
    slider_1 = 0.0,slider_2 = 0.0,slider_3 = 0.0,
    num_1 = "",num_2 = "",num_3 = "",num_4 = "",num_5 = "",
    numOutline_1 = UnityEngine.Color(1,1,1,1),
    numOutline_2 = UnityEngine.Color(1,1,1,1),
    numOutline_3 = UnityEngine.Color(1,1,1,1),
    numOutline_4 = UnityEngine.Color(1,1,1,1),
    numOutline_5 = UnityEngine.Color(1,1,1,1),
}

local command = {
    getRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param)
            local eventId = this.questEvents[index].id
            if IsNullOrEmpty(eventId) then return end
            if DataMgr.Player.quests[eventId] == nil then return end
            if DataMgr.Player.quests[eventId].state == 2 then
                DataExHelper.EX_GetAward(eventId,function()
                    this.SetRewardItem()
                    RedMgr.Singleton:UpdateClientRedData("1400",ActivityMgr.ActivityCanFinish("museumcheck") and 1 or 0)
                    RedMgr.Singleton:Refresh()
                end)
            end
        end
    },
    gotoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local webURL = ConfigMgr.Config.constants.MuseumcheckUrl
            if IsNullOrEmpty(webURL) then return end
            LuaMgr.OpenURL(webURL)
        end 
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitGetView()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this.ClearRewardData()
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    this.rewardContent.anchoredPosition = Vector2.zero
    this.SetLanguageText()
    this.groupId = ActivityMgr.groupKeyList["museumcheck"]
    if IsNullOrEmpty(this.groupId) then return end
    
    this.activityData = DataMgr.Player.variables[this.groupId]
    
    if this.activityData == nil then return end
    
    this.SetTime()
    this.SetProgress()
    this.SetRewardItem()
end


this.SetLanguageText = function()
    this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["15902"].NameLan)
end


this.SetTime = function()
    local startTimeStr = ""
    local delayTimeStr = ""
    startTimeStr = os.date(LuaMgr.GetLangText("CollectActivityPopup_6"),this.activityData.startTime)
    delayTimeStr = os.date(LuaMgr.GetLangText("CollectActivityPopup_7"),this.activityData.delTime)
    this.vm.data.timeText = string.format("%s-%s",startTimeStr,delayTimeStr)
end


this.SetProgress = function()
    if TableIsNull(this.questEvents) then
        local typeId = tonumber(string.sub(this.groupId,7))
        this.questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(typeId)
    end
    if TableIsNull(this.questEvents) then return end
    
    table.sort(this.questEvents,this.RewardSort)

    if TableIsNull(this.heatList) then
        this.heatList = {}
        for i = 1, #this.questEvents do
            table.insert(this.heatList,this.questEvents[i].progress)
        end
    end
    if TableIsNull(this.heatList) then return end

    this.vm.data.num_1 = this.heatList[1]
    this.vm.data.num_2 = this.heatList[2]
    this.vm.data.num_3 = this.heatList[3]
    this.vm.data.num_4 = this.heatList[4]
    this.vm.data.num_5 = this.heatList[5]
    
    local nowHeat = 0
    if DataMgr.Player.quests[this.questEvents[#this.questEvents].id] ~= nil then
        nowHeat = DataMgr.Player.quests[this.questEvents[#this.questEvents].id].progress
    end
    local totalHeat = this.heatList[#this.heatList]
    
    this.vm.data.slider_1 = nowHeat < this.heatList[1] and nowHeat / this.heatList[1] or 1.0

    this.vm.data.slider_2 = nowHeat >= this.heatList[1] and (nowHeat - this.heatList[1]) / (totalHeat - this.heatList[1] - 18) or 0.0

    this.vm.data.slider_3 = nowHeat >= totalHeat and 1.0 or 0.0


    this.vm.data.numOutline_1 = nowHeat >= this.heatList[1] and this.c_Color or this.n_Color
    this.vm.data.numOutline_2 = nowHeat >= this.heatList[2] and this.c_Color or this.n_Color
    this.vm.data.numOutline_3 = nowHeat >= this.heatList[3] and this.c_Color or this.n_Color
    this.vm.data.numOutline_4 = nowHeat >= this.heatList[4] and this.c_Color or this.n_Color
    this.vm.data.numOutline_5 = nowHeat >= this.heatList[5] and this.c_Color or this.n_Color
end


this.SetRewardItem = function()
    if TableIsNull(this.questEvents) then return end
    local quests = nil
    local contentTransform = nil
    for i = 1, #this.rewardUIRoot do
        quests = DataMgr.Player.quests[this.questEvents[i].id]
        if quests ~= nil then

            if quests.state == 1 then
                contentTransform = this.rewardUIRoot[i].n_rewardGroup
                SetActive(this.rewardUIRoot[i].n_reward_1,#this.questEvents[i].reward == 1)
                SetActive(this.rewardUIRoot[i].n_reward_2,#this.questEvents[i].reward == 2)
                SetActive(this.rewardUIRoot[i].n_reward_3,#this.questEvents[i].reward == 3)
            end
            SetActive(this.rewardUIRoot[i].normal,quests.state == 1)

            if quests.state == 2 then
                contentTransform = this.rewardUIRoot[i].c_rewardGroup
                SetActive(this.rewardUIRoot[i].c_reward_1,#this.questEvents[i].reward == 1)
                SetActive(this.rewardUIRoot[i].c_reward_2,#this.questEvents[i].reward == 2)
                SetActive(this.rewardUIRoot[i].c_reward_3,#this.questEvents[i].reward == 3)
            end
            SetActive(this.rewardUIRoot[i].cnGet,quests.state == 2)

            if quests.state == 3 then
                contentTransform = this.rewardUIRoot[i].f_rewardGroup
                SetActive(this.rewardUIRoot[i].f_reward_1,#this.questEvents[i].reward == 1)
                SetActive(this.rewardUIRoot[i].f_reward_2,#this.questEvents[i].reward == 2)
                SetActive(this.rewardUIRoot[i].f_reward_3,#this.questEvents[i].reward == 3)
            end
            SetActive(this.rewardUIRoot[i].finish,quests.state == 3)
            this.CreateReward(i,contentTransform)
        else
            SetActive(this.rewardUIRoot[i].normal,false)
            SetActive(this.rewardUIRoot[i].cnGet,false)
            SetActive(this.rewardUIRoot[i].finish,false)
        end
    end
end

this.CreateReward = function(index,contentTransform)
    local shareReward = this.questEvents[index].reward
    if TableIsNull(shareReward) then return end
    local itemConfig,tempItem = nil,nil
    local length = #shareReward
    local scale = length == 1 and 0.8 or 0.6
    if this.rewardData[index] == nil then
        this.rewardData[index] = {}
        for i = 1, length do
            itemConfig = table.Copy(ConfigMgr.Config.itemMap[shareReward[i].id])
            itemConfig["count0"] = shareReward[i].count
            tempItem = GoodsDataItem.New(contentTransform)
            tempItem:SetData(i,itemConfig,1,false,Vector3(scale,scale,scale),false)
            tempItem.transform.anchoredPosition = Vector2(this.rewardPos[length][i][1],this.rewardPos[length][i][2])
            table.insert(this.rewardData[index],tempItem)
        end
    else
        for i = 1, #this.rewardData[index] do
            this.rewardData[index][i].transform:SetParent(contentTransform)
        end
    end
end

this.ClearRewardData = function()
    for i = #this.rewardData,1,-1 do
        for j = #this.rewardData[i],1,-1 do
            this.rewardData[i][j]:Clear()
        end
        this.rewardData[i] = nil
    end
    this.rewardData = nil
end

this.InitGetView = function()

    this.rewardContent = this.vm.behaviour.transform:Find("root/Middle/RewardView/Viewport/Content"):GetComponent("RectTransform")
    local node = {
        normal = {path = "Normal",type = "GameObject"},
        n_reward_1 = {path = "Normal/Reward1",type = "GameObject"},
        n_reward_2 = {path = "Normal/Reward2",type = "GameObject"},
        n_reward_3 = {path = "Normal/Reward3",type = "GameObject"},
        n_rewardGroup = {path = "Normal/RewardGroup",type = "Transform"},

        cnGet = {path = "CanGet",type = "GameObject"},
        c_reward_1 = {path = "CanGet/Reward1",type = "GameObject"},
        c_reward_2 = {path = "CanGet/Reward2",type = "GameObject"},
        c_reward_3 = {path = "CanGet/Reward3",type = "GameObject"},
        c_rewardGroup = {path = "CanGet/RewardGroup",type = "Transform"},

        finish = {path = "Finish",type = "GameObject"},
        f_reward_1 = {path = "Finish/Reward1",type = "GameObject"},
        f_reward_2 = {path = "Finish/Reward2",type = "GameObject"},
        f_reward_3 = {path = "Finish/Reward3",type = "GameObject"},
        f_rewardGroup = {path = "Finish/RewardGroup",type = "Transform"},
    }
    local object,objectName,tempNode = nil,"",{}
    for i = 1, this.rewardContent.childCount - 1 do
        objectName = "RewardItem"..i
        object = this.rewardContent:Find(objectName).gameObject
        tempNode = {}
        UITool.Parse(object,tempNode,node)
        table.insert(this.rewardUIRoot,i,tempNode)
    end
    node = nil
    object,objectName,tempNode = nil,nil,nil
end

this.RewardSort = function(item1,item2)
    return item1.id < item2.id
end

return vm({
    data = data,
    command = command,
    hook = hook
})