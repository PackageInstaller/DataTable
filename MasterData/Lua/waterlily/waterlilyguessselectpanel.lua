
require("Waterlily/WaterlilyGuessSelectItem")
require("Waterlily/WaterlilyConst")
require("Manager/Player/PlayerWaterlilyMgr")

local this = {}

local objs = {
    itemModel = {path = "template/ItemModel", type = UITool.GameObject},
    scrollView = {path = "root/Middle/ScrollView", type = UITool.ScrollRect}
}

this.before_awake = function()
    this.scrollViewUI = UIScrollView.New(this.scrollView)
end

this.before_deactive = function()
    this.RefreshScroll()
end

this.RefreshScroll = function()
    this.scrollViewUI:Clear()
    this.SetSearchItemData()
    local allDatas = this.searchItemDataList
    local scrollDatas = {}
    local datasLen = #allDatas
    local lastFinishIndex = nil
    for i = 1, datasLen do
        local data = allDatas[i]
        local tempData = UIScrollData.GetData(this.itemModel, "WaterlilyGuessSelectItem", 360, 464, data)
        table.insert(scrollDatas, tempData)
        if data.isUnlock == true and data.isFinish == false and lastFinishIndex == nil then
            lastFinishIndex = i
        end
    end
    local width = LuaMgr.GetScreenWidth()
    this.scrollViewUI:SetParams(width, 464)
    this.scrollViewUI:SetData(scrollDatas, true)
    if lastFinishIndex ~= nil then
        local index = math.max(1, lastFinishIndex - 1)
        this.scrollViewUI:MoveToIndex(index)
    end
end

this.SetSearchItemData = function()
    local configList = DataExHelper.EX_GetEventListByArea(WaterlilyLevelType.Repeat)
    this.searchItemDataList = {}
    local lastFinishID = ""
    local lastID = ""
    local allMapEvents = DataExHelper.GetActivityMapEventMap()
    if allMapEvents == nil then
        return
    end
    for i, config in ipairs(configList) do
        if config.type == WaterlilyLevel2NumType.Event then
            local cache = {}
            cache.id = config.id
            cache.icon = config.type
            cache.config = config
            cache.onClickCallback = this.OnClickItem
            cache.isUnlock = false
            cache.unlockPassName = ""
            if config.unlockType == 0 then
                cache.isUnlock = true
            else
                if lastFinishID == lastID then
                    cache.isUnlock = true
                end
                local unlockPassConfig = allMapEvents[config.unlockParam]
                if unlockPassConfig then
                    cache.unlockPassName = LuaMgr.GetLangText(unlockPassConfig.namelan)
                end
            end
            local guessNum = DataMgr.Player.AnswerQuestion.AnswerCount[config.eventParam] or 0
            local gotReward = (DataMgr.Player.AnswerQuestion.AnswerRewards[config.eventParam] or 0) > 0 and true or false
            cache.guessNum = guessNum

            local rewardData = PlayerWaterlilyMgr.GetGameRewardsData()
            local isFinish = false
            if (rewardData ~= nil and rewardData[config.eventParam] ~= nil) then
                isFinish = true
            end
            local rewardConf = ConfigMgr.Config.ColorQuestionMap[config.eventParam]
            local itemDataList = {}
            for k, v in pairs(rewardConf.Reward) do
                table.insert(itemDataList, v)
            end
            cache.rewardItemList = itemDataList
            cache.isFinish = isFinish

             if gotReward == true then
                lastFinishID = config.eventParam
            end
            lastID = config.eventParam
            table.insert(this.searchItemDataList, cache)
        end
    end
end


this.OnClickItem = function(item)
    LuaMgr.ShowLuaPanel(UIName.WaterlilyGuessPanel, item.data.config)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.before_deactive()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("WaterlilyGuessSelectItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)