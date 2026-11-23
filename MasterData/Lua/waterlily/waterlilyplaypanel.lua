require("Waterlily/WaterlilyConst")
require("Waterlily/WaterlilyPlayMovieItem")
require("Waterlily/WaterlilyPlayPassItem")

local this = {

    movieItems = {},
    rewardList = {}
}

local objs = {
    passPrefab = {path = "template/Prefab", name = UITool.GameObject},
    goodsDataItem = {path = "template/GoodsDataItem", type = UITool.GameObject},
    passScrollView = {path = "root/Middle/Left/ScrollView", type = UITool.GameObject},
    passName = {path = "root/Middle/BattleConfirm/TextName", type = UITool.Text},
    startBattleBtn = {path = "root/Middle/BattleConfirm/ComfirmBtn", type = UITool.Button},
    battleConfirm = {path = "root/Middle/BattleConfirm", type = UITool.GameObject},
    battleConfirmTrans = {path = "root/Middle/BattleConfirm", type = UITool.RectTransform},
    battleConfirmMaskBtn = {path = "root/Middle/BattleConfirm", type = UITool.Button},
    passRewardParent = {path = "root/Middle/BattleConfirm/ScrollViewReward/Viewport/Content", type = UITool.RectTransform},
    maskBtn = {path = "root/Mask", type = UITool.Button}
}

this.before_awake = function()
    for i = 1, 6 do
        local name = "Movie" .. i
        local item = WaterlilyPlayMovieItem.New(this[name])
        table.insert(this.movieItems, item)
    end
    this.passScrollViewUI = UIScrollView.New(this.passScrollView)
    this.battleConfirmTrans.sizeDelta = Vector2(LuaMgr.ScreenWidth(), LuaMgr.ScreenHeight())
end

this.before_active = function()
    SetActive(this.battleConfirm, false)
    local allMapEvents = DataExHelper.GetActivityMapEventMap()
    if allMapEvents == nil then
        return
    end
    for i = 1, #this.movieItems do
        local data = this.movieEventDatas[i]
        local item = this.movieItems[i]
        if data ~= nil then
            data.isUnLock = PlayerWaterlilyMgr.CheckUnlock(data.config)
            data.isFinish = PlayerWaterlilyMgr.CheckFinish(data.config)
            local unlockPassConfig = allMapEvents[data.config.unlockParam]
            if unlockPassConfig then
                data.unlockPassName = LuaMgr.GetLangText(unlockPassConfig.namelan)
            end
            item:SetData(data)
        end
    end
    for i = 1, #this.passEventDatas do
        local data = this.passEventDatas[i]
        if data ~= nil then
            data.isUnLock = PlayerWaterlilyMgr.CheckUnlock(data.config)
            data.isFinish = PlayerWaterlilyMgr.CheckFinish(data.config)
            local unlockPassConfig = allMapEvents[data.config.unlockParam]
            if unlockPassConfig then
                data.unlockPassName = LuaMgr.GetLangText(unlockPassConfig.namelan)
            end
        end
    end
    this.SetPassItems()
end

this.OnClickMaskBtn = function()
    LuaMgr.Back()
end

this.SetMovieItems = function()
    for i = 1, 6 do
        local name = "Movie" .. i
        local path = "root/Middle/Right/" .. name
        objs[name] = {path = path, type = UITool.GameObject}
    end
end

this.SetPassItems = function()
    if this.passEventDatas == nil then
        return
    end
    this.passScrollViewUI:Clear(false)
    local scrollDatas = {}
    for i = 1, #this.passEventDatas do
        local scrollData = UIScrollData.GetData(this.passPrefab, "WaterlilyPlayPassItem", 417, 68, this.passEventDatas[i])
        table.insert(scrollDatas, scrollData)
    end
    this.passScrollViewUI:SetParams(419, 302)
    this.passScrollViewUI:SetData(scrollDatas, true)

    if this.coroutine ~= nil then
        coroutine_runner.stop(this.coroutine)
        this.coroutine = nil
    end
    this.coroutine = coroutine_runner.start(this.SetPassItemVisible)
end

this.SetPassItemVisible = function()
    for i = 1, #this.passEventDatas do
        if this.passScrollViewUI:InScreen(i) == true then
            local item = this.passScrollViewUI:GetItemByIndex(i)
            item:SetData(this.passEventDatas[i])
            coroutine_runner.wait(0.1)
        end
    end
end



this.SetWatchMoviecallback = function(item)
    if item.data == nil or item.data.config == nil then
        LuaDebug.error("WaterlilyPlayPanel SetWatchMoviecallback item data is nil")
        return
    end
    local movieId = item.data.config.eventParam
    if movieId == nil or movieId == 0 then
        LuaDebug.error("WaterlilyPlayPanel SetWatchMoviecallback movieId is nil")
        return
    end
    local playNovelCallback = function()
        LuaMgr.ShowLuaPanel(UIName.WaterlilyPlayViewModel)
        if this.isBeDestroy == true then
            return
        end
        item.data.isFinish = true
        item:SetData(item.data)
    end
    LuaMgr.HidePanel(UIName.WaterlilyPlayViewModel)
    LuaMgr.PlayNovel(movieId, playNovelCallback)
end



this.SetBattlePasscallback = function(item)
    if item.data == nil or item.data.config == nil then
        LuaDebug.error("WaterlilyPlayPanel SetBattlePasscallback item data is nil")
        return
    end
    SetActive(this.battleConfirm, true)
    this.passName.text = LuaMgr.GetLangText(item.data.config.namelan)
    this.curSelectPassData = item.data
    this.curSelectPassData.state = this.CheckState(item.data.config)
    this.SetReward(item.data.config)
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
            local goodsItem = GoodsDataItem.New(this.passRewardParent, this.goodsDataItem)
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
        SetActive(data.gotFlag, false)
        index = index + 1
    end
    local len = #this.rewardList
    for i = index, len do
        this.rewardList[i].item:Hide()
    end
end

this.OnClickComfirmBtn = function()
    local data = this.curSelectPassData
    if (data == nil) then
        return
    end
    if data.state == 0 then
        local unlockName = ConfigRhythmGameMgr.GetUnlockName(data.config.unlockParam)
LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("25207"), unlockName))
    else
        PlayerWaterlilyMgr.SetChallengeLastPaget(this.curSelectPage)
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = data.config.id
        enterDungeonParams.dungeonId = data.config.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
        this.curSelectPassData = nil
    end
end

this.OnClickBattleMask = function()
    SetActive(this.battleConfirm, false)
end

this.CheckState = function(_config)
    this.curPlayerData = DataMgr.Player.activityMaps[WaterlilyLevelType.Repeat]
    local playerData = this.curPlayerData.activityEvents[_config.id]
    local recodeData = DataMgr.Player.dungeonRecords[_config.eventParam]
    local lock = playerData == nil
    if lock then
        return 0
    else
        if (recodeData ~= nil and recodeData.completeCount > 0) then
            return 2
        else
            return 1
        end
    end
end

local data = {}

local command = {}

local hook = {

    before_awake = function(vm)
        this.SetMovieItems()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        RedMgr.Singleton:RegisterViewModel(UIName.WaterlilyPlayViewModel)
        local allList = DataExHelper.EX_GetEventMapByArea("Waterlily1") or {}
        local allEventData = allList[tostring(40801)] or {}
        this.passEventDatas = {}
        this.movieEventDatas = {}
        for i = 1, #allEventData do
            local eventData = allEventData[i]
            local data = {}
            data.config = eventData
            data.isFinish = false
            if eventData.type == WaterlilyLevel2NumType.Fushua then
                data.onClickCallback = this.SetBattlePasscallback
                table.insert(this.passEventDatas, data)
            elseif eventData.type == WaterlilyLevel2NumType.Juqing then
                data.onClickCallback = this.SetWatchMoviecallback
                table.insert(this.movieEventDatas, data)
            end
        end
        LuaMgr.AddClick(this.startBattleBtn, this.OnClickComfirmBtn)
        LuaMgr.AddClick(this.battleConfirmMaskBtn, this.OnClickBattleMask)
        LuaMgr.AddClick(this.maskBtn, this.OnClickMaskBtn)
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.isBeDestroy = false
        this.before_active()
        PlayerWaterlilyMgr.CheckEntranceRedDot()
        RedMgr.Singleton:Refresh()
        if (RedMgr.Singleton:CheckRedCondition("16405")) then
            RedMgr.Singleton:FrushRedCondition("16405")
        end
    end,

    before_deactive = function(vm)
        if this.coroutine ~= nil then
            coroutine_runner.stop(this.coroutine)
            this.coroutine = nil
        end
        UIScrollView.ClearItem("WaterlilyPlayPassItem")
    end,

    before_destroy = function()
        LuaMgr.RemoveClick(this.startBattleBtn, this.OnClickComfirmBtn)
        LuaMgr.RemoveClick(this.battleConfirmMaskBtn, this.OnClickBattleMask)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMaskBtn)
        this.isBeDestroy = true
    end
}



this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.Waterlily) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false
    end
    return true
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)