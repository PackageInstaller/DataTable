




require("ViewModel/CardPool/CardPoolSeasonReward")


local this = {
    vm = nil,cardPoolConfig = nil,rewardScroll = nil,rewardTemplate = nil,
}

local data = {
    tipStr_1 = "",
    tipStr_2 = "",
    progressValue = Vector2.zero
}

local command = {
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.HidePanel(UIName.CardPoolSeasonPopup)
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.rewardTemplate = vm.behaviour.transform:Find("template/RewardItem").gameObject
        this.rewardScroll = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/ScrollView").gameObject)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.SetLanguageText()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("CardPoolSeasonReward")
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()
    this.rewardScroll:Clear()
end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length <= 0 then
        return
    end
    local cardId = this.vm.behaviour.Params[0]
    this.cardPoolConfig = ConfigMgr.Config.cardPools[cardId]
    if TableIsNull(this.cardPoolConfig) then
        return
    end
    this.SetReward()
end


this.SetLanguageText = function()
    this.vm.data.tipStr_2 = ConfigMgr.LangGlobal("34163")
end

this.SetReward = function()
    this.rewardScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local nowCount = 0
    if DataMgr.Player.drawCard.exchangePoints[this.cardPoolConfig.id] ~= nil then
        nowCount = DataMgr.Player.drawCard.exchangePoints[this.cardPoolConfig.id]
    end
    local nowReward = 0
    if DataMgr.Player.DrawCardSeasonalRewards[this.cardPoolConfig.id] ~= nil then
        nowReward = DataMgr.Player.DrawCardSeasonalRewards[this.cardPoolConfig.id]
    end
    local seasonCount = 0
    for i = 1, #this.cardPoolConfig.seasonExchange do
        seasonCount = tonumber(this.cardPoolConfig.seasonExchange[i][1])
        groupData = {}
        groupData.data = this.cardPoolConfig.seasonExchange[i]
        groupData.state = 0
        if nowCount > nowReward and nowCount >= seasonCount and nowReward < seasonCount then
            groupData.state = 3
        elseif nowCount >= nowReward and nowCount < seasonCount then
            groupData.state = 2
        else
            groupData.state = 1
        end
        groupData.callBack = this.GetReward
        scrollData = UIScrollData.GetData(this.rewardTemplate,"CardPoolSeasonReward",516,112 - 10,groupData)
        table.insert(scrollDatas,scrollData)
    end
    table.sort(scrollDatas,function(a,b)
        if a.data.state ~= b.data.state then
            return a.data.state > b.data.state
        else
            return tonumber(a.data.data[1]) < tonumber(b.data.data[1])
        end
    end)
    this.rewardScroll:SetParams(526,375)
    this.rewardScroll:SetPadding(0,0,0,0)
    this.rewardScroll:SetData(scrollDatas, true)
    local maxCount = this.cardPoolConfig.seasonExchange[#this.cardPoolConfig.seasonExchange][1]
    local tipStr = LuaMgr.GetLangText("CardPoolSeasonPopup_0")..LuaMgr.GetLangText(this.cardPoolConfig.nameLan)..LuaMgr.GetLangText("CardPoolSeasonPopup_1")..string.format(ConfigMgr.LangGlobal("34162"),nowCount,maxCount)
    this.vm.data.tipStr_1 = tipStr
    local width = (nowCount / tonumber(maxCount)) * 325
    if width > 325 then width = 325 end
    this.vm.data.progressValue = Vector2(width,24)
end

this.GetReward = function(param)
    if TableIsNull(param) then
        return
    end
    local tempData = {}
    tempData["CardPool"] = this.cardPoolConfig.id
    ApiMgr.Request("drawcard/seasonal/rewards", tempData,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            local data = json.encode(re.result)
            LuaMgr.ShowItemRewared(data)
            this.SetReward()
            LuaMgr.InvokeUIEventListeners(UIEventConst.CardPoolSelectWish)
        end
    end,nil,true)
end

return vm({
    data = data,
    command = command,
    hook = hook
})