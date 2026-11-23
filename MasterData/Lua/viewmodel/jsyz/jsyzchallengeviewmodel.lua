require("ViewModel/JSYZ/JSYZChallengeItem")

local this = {
    vm = nil,
    curAreaEventList = nil,
    curPlayerData = nil,
    curSelectedIndex = 0,
    rewardList = {}
}

local objs = {
    LevelBtnObj = { path = "template/ItemModel", type = "GameObject" },
    ContentLV = { path = "root/Middle/ScrollViewLv", type = "RectTransform" },
    passToggle1 = { path = "root/Middle/ToggleGroup/PassToggle1", type = "GameObject" },
    passToggle2 = { path = "root/Middle/ToggleGroup/PassToggle2", type = "GameObject" },

}

local data = {}
local command = {}

this.before_awake = function()
    this.scrollViewUI = UIScrollView.New(this.ContentLV)
    this.toggleNodes = {}
    for i = 1, 2 do

        local toggleNode = CommonToggleItem.New(this["passToggle" .. i], nil, false, i, this.ClickPageToggle)
        this.toggleNodes[i] = toggleNode
        local data = {}
        toggleNode:SetData(data)
    end
end

this.ClickPageToggle = function(index, value)
    if value == true then
        this.curSelectPage = index
        this.SwitchPage()
        for i = 1, #this.toggleNodes do
            local toggleNode = this.toggleNodes[i]
            toggleNode:SetIsOn(index == i)
        end
    end
end

this.SetData = function()
    if (RedMgr.Singleton:CheckRedCondition("17206")) then
        RedMgr.Singleton:FrushRedCondition("17206")
    end
    this.scrollViewUI:Clear()
    this.curPlayerData = DataMgr.Player.activityMaps["JSYZ"]
    local curAreaEventList = DataExHelper.EX_GetEventListByArea("JSYZ")
    this.curAreaEventList = {}
    for key, value in pairs(curAreaEventList) do
        if value.type == 4 or value.type == 5 then
            this.curAreaEventList[value.type] = this.curAreaEventList[value.type] or {}
            table.insert(this.curAreaEventList[value.type], value)
        end
    end

    local lastPage = JSYZMgr.GetChallengeLastPaget() or 1
    for i = 1, #this.toggleNodes do
        local toggleNode = this.toggleNodes[i]
        if i == lastPage then
            this.curSelectPage = i
            this.firstToggle = toggleNode
            this.firstToggle.toggle.isOn = true
            this.firstToggle:SetIsOn(true)
        else
            toggleNode.toggle.isOn = false
            toggleNode:SetIsOn(false)
        end
    end
    this.SwitchPage()
end

this.SwitchPage = function()
    local allConfigs = {}
    if this.curSelectPage == 1 then
        allConfigs = this.curAreaEventList[4] or {}
    else
        allConfigs = this.curAreaEventList[5] or {}
    end
    local scrollDatas = {}
    local moveToIndex = nil
    local allMapEvents = DataExHelper.GetActivityMapEventMap()
    if allMapEvents == nil then
        return
    end
    for i = 1, #allConfigs do
        local config = allConfigs[i]
        local state = this.CheckState(config)
        local data = {}
        data.index = i
        data.config = config
        data.state = state
        data.isUnlock = state ~= 0
        data.bg = state == 1 or state == 2
        data.isFinish = state == 2
        data.onClickCallback = this.OnClickLevel
        local unlockPassConfig = allMapEvents[data.config.unlockParam]
        if unlockPassConfig then
            data.unlockPassName = LuaMgr.GetLangText(unlockPassConfig.namelan)
        end
        local tempData = UIScrollData.GetData(this.LevelBtnObj, "JSYZChallengeItem", 424, 376, data)
        table.insert(scrollDatas, tempData)
        if data.isFinish == false and moveToIndex == nil then
            moveToIndex = i
        end
    end

    this.scrollViewUI:SetParams(1280, 528)
    this.scrollViewUI:SetData(scrollDatas, true)
    if moveToIndex == nil then
        moveToIndex = #scrollDatas
    end
    this.scrollViewUI:MoveToIndex(moveToIndex, true)
    SetActive(this.easyNameBG, this.curSelectPage == 1)
    SetActive(this.hardNameBG, this.curSelectPage == 2)
end

this.CheckState = function(_config)
    if this.curPlayerData == nil then
        if _config.unlockType == 0 then
            return 1
        end
        local isUnlock = DataHelper.CheckDungeonComplete(_config.unlockParam)
        return isUnlock == true and 1 or 0
    end
    local playerData = this.curPlayerData.activityEvents[_config.id]
    local recodeData = DataMgr.Player.dungeonRecords[_config.eventParam]
    local lock = playerData == nil
    if (lock) then
        return 0
    else
        if (recodeData ~= nil and recodeData.completeCount > 0) then
            return 2
        else
            return 1
        end
    end
end

this.OnClickLevel = function(item)
    local index = item.data.index
    local cache = item.data
    if (cache == nil) then
        return
    end
    this.curSelectedIndex = index
    if (cache.state == 0) then
        local unlockName = ConfigRhythmGameMgr.GetUnlockName(cache.config.unlockParam)
LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("25207"), unlockName))
    else
        JSYZMgr.SetChallengeLastPaget(this.curSelectPage)
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = cache.config.id
        enterDungeonParams.dungeonId = cache.config.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
        this.curSelectPassData = nil
    end
end

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
    end,
    before_active = function(vm)
        if (RedMgr.Singleton:CheckRedCondition("17606")) then
            RedMgr.Singleton:FrushRedCondition("17606")
        end
        if (vm.behaviour.Params ~= nil) then
            this.SetData()
        end
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("JSYZChallengeItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)