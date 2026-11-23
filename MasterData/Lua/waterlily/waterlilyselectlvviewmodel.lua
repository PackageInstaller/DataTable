require("Waterlily/WaterlilySelectLvItem")

local this = {
    vm = nil,
    curAreaEventList = nil,
    curPlayerData = nil,
    curSelectedIndex = 0,
    rewardList = {}
}

local objs = {
    LevelBtnObj = {path = "template/ItemModel", type = "GameObject"},
    GoodsDataItem = {path = "template/GoodsDataItem", type = "GameObject"},
    TextName = {path = "root/Middle/BattleConfirm/Group/TextName", type = "Text"},
    TextContent = {path = "root/Middle/BattleConfirm/Group/TextContent", type = "Text"},
    ContentLV = {path = "root/Middle/ScrollViewLv", type = "RectTransform"},
    Content = {path = "root/Middle/BattleConfirm/Group/ScrollViewReward/Viewport/Content", type = "RectTransform"},
    ComfirmBtn = {path = "root/Middle/BattleConfirm/Group/ComfirmBtn", type = "Button"},
    battleConfirm = {path = "root/Middle/BattleConfirm", type = "GameObject"},
    battleConfirmTrans = {path = "root/Middle/BattleConfirm", type = "RectTransform"},
    battleConfirmMaskBtn = {path = "root/Middle/BattleConfirm", type = "Button"},
    passToggle1 = {path = "root/Middle/ToggleGroup/PassToggle1", type = "GameObject"},
    passToggle2 = {path = "root/Middle/ToggleGroup/PassToggle2", type = "GameObject"},
    easyNameBG = {path = "root/Middle/BattleConfirm/Group/EasyNameBG", type = "GameObject"},
    hardNameBG = {path = "root/Middle/BattleConfirm/Group/HardNameBG", type = "GameObject"}, 
}

local data = {}
local command = {}

this.before_awake = function()
    this.ClearReward()
    this.scrollViewUI = UIScrollView.New(this.ContentLV)
    this.toggleNodes = {}
    for i = 1, 2 do

        local toggleNode = CommonToggleItem.New(this["passToggle" .. i], nil, false, i, this.ClickPageToggle)
        this.toggleNodes[i] = toggleNode
        local data = {}
        toggleNode:SetData(data)
    end
    this.battleConfirmTrans.sizeDelta = Vector2(LuaMgr.ScreenWidth(), LuaMgr.ScreenHeight())
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

this.before_active = function()
    this.scrollViewUI:Clear()
    SetActive(this.battleConfirm, false)
    this.curPlayerData = DataMgr.Player.activityMaps["Waterlily2"]
    local curAreaEventList = DataExHelper.EX_GetEventListByArea("Waterlily2")
    this.curAreaEventList = {}
    for key, value in pairs(curAreaEventList) do
        this.curAreaEventList[value.type] = this.curAreaEventList[value.type] or {}
        table.insert(this.curAreaEventList[value.type], value)
    end

    local lastPage = PlayerWaterlilyMgr.GetChallengeLastPaget() or 1
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
        local tempData = UIScrollData.GetData(this.LevelBtnObj, "WaterlilySelectLvItem", 426.6, 655, data)
        table.insert(scrollDatas, tempData)
        if data.isFinish == false and moveToIndex == nil then
            moveToIndex = i
        end
    end

    this.scrollViewUI:SetParams(1280, 655)
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
    SetActive(this.battleConfirm, true)
    local cache = item.data
    if (cache == nil) then
        return
    end
    this.curSelectedIndex = index
    this.TextName.text = LuaMgr.GetLangText(cache.config.namelan)
    this.TextContent.text = LuaMgr.GetLangText(cache.config.descriptionlan)
    this.SetReward(cache.config)
    this.curSelectPassData = cache
end

this.OnClickComfirmBtn = function()
    local cache = this.curSelectPassData
    if (cache == nil) then
        return
    end
    if (cache.state == 0) then
        local unlockName = ConfigRhythmGameMgr.GetUnlockName(cache.config.unlockParam)
LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("25207"), unlockName))
    else
        PlayerWaterlilyMgr.SetChallengeLastPaget(this.curSelectPage)
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = cache.config.id
        enterDungeonParams.dungeonId = cache.config.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
        this.curSelectPassData = nil
    end
end

this.OnClickBattleMask = function()
    SetActive(this.battleConfirm, false)
end

this.SetReward = function(config)
    local index = 1
    local itemData
    local scaleNum = 0.6
    local scale = Vector3(scaleNum, scaleNum, scaleNum)
    local dungeon = ConfigMgr.Config.dungeonMap[config.eventParam]
    local rewardMap = {}
    if IsNull(dungeon) then
        return
    end
    for i, v in ipairs(dungeon.firstDrop) do
        local items = ConfigMgr.Config.dropMap[v.id].items
        for p, m in ipairs(items) do
            if rewardMap[m.id] == nil then
                rewardMap[m.id] = m.count
            else
                rewardMap[m.id] = rewardMap[m.id] + m.count
            end
        end
    end
    local raring = DataExHelper.GetDungeonDecordRating(config.eventParam)
    for k, v in pairs(rewardMap) do
        local data = this.rewardList[index]
        if (data == nil) then
            local goodsItem = GoodsDataItem.New(this.Content, this.GoodsDataItem)
            this.rewardList[index] = {
                item = goodsItem,
                firstGetFlag = goodsItem.transform:Find("FirstGetFlag").gameObject,
                gotFlag = goodsItem.transform:Find("GotFlag").gameObject,
            }
            data = this.rewardList[index]
        end
        local itemConfig = ConfigMgr.Config.itemMap[k]
        if (itemConfig == nil) then
            return
        end
        itemData = table.Copy(itemConfig)
        itemData.count0 = v
        data.item:SetData(index, itemData, 1, false, scale, false, false)
        SetActive(data.firstGetFlag, raring == 0)
        SetActive(data.gotFlag, raring ~= 0)
        index = index + 1
    end
    local len = #this.rewardList
    for i = index, len do
        this.rewardList[i].item:Hide()
    end
end


this.ClearReward = function()
    if (this.rewardList ~= nil) then
        for k, v in pairs(this.rewardList) do
            v.item:Clear()
        end
        this.rewardList = {}
    end
end

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.ComfirmBtn, this.OnClickComfirmBtn)
        LuaMgr.AddClick(this.battleConfirmMaskBtn, this.OnClickBattleMask)
        this.before_awake()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params ~= nil) then
            this.before_active()
        end
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.ComfirmBtn, this.OnClickComfirmBtn)
        LuaMgr.RemoveClick(this.battleConfirmMaskBtn, this.OnClickBattleMask)
        this.ClearReward()
        UIScrollView.ClearItem("WaterlilySelectLvItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)