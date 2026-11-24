local this = {vm = nil,currentType = nil,itemType = 11,staminaCount = 0, clickMaxCount = 0,
              currentStamina = 0,cost = {},isPlayAni = false,ToString = tostring,buyCount = nil,
              timeStr = "",timeStr_1 = "",ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_",
              pressInverval=0.1;
              pressTime=0;
}

local data = {
    propText = "",
    propChoose = false,
    propView = false,
    notView = false,
    emptyBtn = false,
    buyText = "",
    buyChoose = true,
    inventoryValue = "",
    countValue = "",
    timeIcon = Vector2.zero,
    fatigueMaxText = "",
    timeTipText = "",
    currentValue = "",
    usingAfterValue = "",
    usingTipText = "",
    buyTipText = Vector3.zero,
    frontTipText = "",
    afterTipText = "",
    falseBtn = Vector3.zero,
    trueBtn = Vector3.zero,
    confirmBtn = Vector3.zero,
    uiAnimName = "",
    buyCountText = "",
    allTimeTipText = "",
    tipText = "",
    tipBool = false,

    propList = {{itemId = "",name = "",choose = Vector3.zero,rare = DefaultSprite,icon = DefaultTexture,chooseNum = "",
                count = "",time = Vector3.zero,timeText = ""}}
}

local function GetSeasonalConstants()
    return ConfigMgr.Config.SeasonalConstants or {}
end

local function GetSeasonalStaminaItemId()
    return GetSeasonalConstants().SeasonalStaminaItem
end

local function GetSeasonalStaminaBuyCost()
    return GetSeasonalConstants().SeasonalStaminaBuyCost or {}
end

local function GetSeasonalStaminaBuyLimit()
    return #GetSeasonalStaminaBuyCost()
end

local function GetSeasonalDailyBoughtCount()
    if DataMgr.Player == nil then
        return 0
    end
    return tonumber(DataMgr.Player.SeasonalDailyStaminaCount) or 0
end

local function GetSeasonalStaminaBuyReward()
    return tonumber(GetSeasonalConstants().SeasonalStaminaBuyReward) or 0
end

local function GetSeasonalStaminaCount()
    local staminaItemId = GetSeasonalStaminaItemId()
    if staminaItemId == nil then
        return 0
    end
    return tonumber(DataHelper.GetItemCountById(staminaItemId)) or 0
end

local function GetSeasonalStaminaBuyValue(count)
    return GetSeasonalStaminaBuyReward() * (tonumber(count) or 0)
end

local function GetSeasonalStaminaBuyCostCount(count)
    local costList = GetSeasonalStaminaBuyCost()
    local boughtCount = GetSeasonalDailyBoughtCount()
    local costCount = 0
    for i = 1, (tonumber(count) or 0) do
        local costConfig = costList[boughtCount + i]
        if costConfig == nil then
            return nil
        end
        costCount = costCount + (tonumber(costConfig[2]) or 0)
    end
    return costCount
end

local command = {

    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)

            if this.staminaCount <= 0 or this.buyCount <= 0 then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2021"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
                return
            end

            local value = GetSeasonalStaminaBuyValue(this.buyCount)
            this.currentStamina = GetSeasonalStaminaCount()
            if value + this.currentStamina > SeasonSLGMapMgr.GetSeasonalStaminaMax() then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2063"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
                return
            end
            local count = GetSeasonalStaminaBuyCostCount(this.buyCount)
            if count == nil then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2021"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
                return
            end
            DataHelper.ConditionCheck("1", count, function()
                this.cost["1"] = { ID = "1", Count = count, Expiry = 0 }
                this.restoreCount = this.buyCount
                this.SendRestore()
            end)
        end
    },

    emptyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.cost = {}
            this.SwitchTypeBtn()
        end
    },
    trueCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SendRestore()
        end
    },
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.isPlayAni then
                this.CloseFunction()
            end
        end
    },
    convertCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.SeasonSLGDiamondExchangeViewModel, "2", "1")
        end
    },
    addCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local clickType = tonumber(param)
            if clickType == nil or clickType == 1 then
                this.UpdateBuyCount(true)
            elseif clickType == 2 then
                this.pressTime = 0
                LuaMgr.AddUpdate(this.LongPressAdd)
            elseif clickType == 3 then
                LuaMgr.RemoveUpdate(this.LongPressAdd)
            end
        end
    },
    countSubtractCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local clickType = tonumber(param)
            if clickType == nil or clickType == 1 then
                this.UpdateBuyCount(false)
            elseif clickType == 2 then
                this.pressTime = 0
                LuaMgr.AddUpdate(this.LongPressReduce)
            elseif clickType == 3 then
                LuaMgr.RemoveUpdate(this.LongPressReduce)
            end
        end
    },

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.SetLanguageText()
        this.isPlayAni = true
        this.vm.data.uiAnimName = "UI_FatigueReplyPanel_01"
        this.buyCount = 1
        this.InitLeftData()
        this.InitRightData()
        this.UpdateButton()
        LuaMgr.AddDataEventListener(this.InitLeftData)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveTimer(TimerConst.StaminaTime)
        LuaMgr.RemoveTimer(TimerConst.PressClickTime)
        LuaMgr.RemoveUIEventListener("102",this.CloseCallBack);
        LuaMgr.RemoveUpdate(this.LongPressReduce)
        LuaMgr.RemoveUpdate(this.LongPressAdd)
        LuaMgr.RemoveDataEventListener(this.InitLeftData);
    end,
    before_destroy = function(vm)
        this = nil
    end,
}
this.SetLanguageText = function()
    this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2020"].NameLan)
end

this.InitLeftData = function()
    this.vm.data.propView = false
    this.vm.data.notView = false
    this.vm.data.inventoryValue = LuaMgr.NumFormat(LuaMgr.GetFreeDiamond())
    local maxCount = GetSeasonalStaminaBuyLimit()
    local boughtCount = GetSeasonalDailyBoughtCount()
    this.staminaCount = math.max(0, maxCount - boughtCount)
    if this.staminaCount <= 0 then
        this.buyCount = 0
    elseif this.buyCount == nil or this.buyCount < 1 then
        this.buyCount = 1
    elseif this.buyCount > this.staminaCount then
        this.buyCount = this.staminaCount
    end

    this.vm.data.buyCountText = this.buyCount
end

this.InitRightData = function()
    this.vm.data.buyTipText = Vector3.zero
    this.currentStamina = GetSeasonalStaminaCount()
    local maxValue = SeasonSLGMapMgr.GetSeasonalStaminaRecoverMax()
    local staminaMax = SeasonSLGMapMgr.GetSeasonalStaminaMax()
    this.vm.data.currentValue = this.ToString(this.currentStamina)
    this.vm.data.fatigueMaxText = this.currentStamina.."<color=#b3b096>/</color>".."<color=#b291de>"..maxValue.."</color>"
    if this.currentStamina >= maxValue then
        this.vm.data.timeIcon = Vector2(0,32)
        this.vm.data.tipBool = true
        this.vm.data.timeTipText = ""
        this.vm.data.allTimeTipText = ""

        this.vm.data.usingTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2162"].NameLan)
        this.vm.data.usingAfterValue = this.ToString(this.currentStamina)
        LuaMgr.RemoveTimer(TimerConst.StaminaTime)
    else
        this.vm.data.tipBool = false
        this.vm.data.timeIcon = Vector2(32,32)
        this.vm.data.usingTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2163"].NameLan)
        this.vm.data.usingAfterValue = this.ToString(this.currentStamina + 1)
        local staminaRecoverInterval = ConfigMgr.Config.SeasonalConstants.SeasonalStaminaRecoverMin * 60
        local lastRecoverStaminaTime = DataMgr.Player.SeasonalStaminaLastRecoverTime
        local count = maxValue * staminaRecoverInterval
        this.timeStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35133")
        this.timeStr_1 = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35147")
        LuaMgr.AddTimer(TimerConst.StaminaTime,function()
            this.UpdateTime(staminaRecoverInterval,lastRecoverStaminaTime) end,1,count,true)
    end

    local buyValue = GetSeasonalStaminaBuyValue(this.buyCount)

    local usingAfterValue = this.currentStamina + buyValue
    if usingAfterValue > staminaMax then
        usingAfterValue = staminaMax
    end
    this.vm.data.usingAfterValue = this.ToString(usingAfterValue)
    local itemCount = GetSeasonalStaminaBuyCostCount(this.buyCount) or 0
    this.vm.data.usingTipText = ""
    this.vm.data.frontTipText = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35134"),buyValue)
    this.vm.data.afterTipText = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35135"),itemCount)
    this.vm.data.buyTipText = Vector3.one
end


this.UpdateRightData = function()
    if not TableIsNull(this.cost) then
        this.cost = {}
        this.InitDefaultChoose()
    end
end

this.ChooseItem = function(id,index)
    local value = ConfigMgr.Config.itemMap[id].drop
    local tempStamina = this.WhetherCeiling(this.currentStamina,value)
    if not tempStamina then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2063"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        LuaMgr.RemoveTimer(TimerConst.PressClickTime);
    else
        local tempValue = {ID = id,Count = 1,Expiry = this.vm.data.propList[index].timeValue}
        local tempIndex = tempValue.ID..tempValue.Expiry
        if this.cost[tempIndex] == nil then
            this.cost[tempIndex] = tempValue
            this.vm.data.propList[index].choose = Vector3.one
        else
            if this.cost[tempIndex].Count + 1 > this.clickMaxCount then
                local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2064"].NameLan)
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
                LuaMgr.RemoveTimer(TimerConst.PressClickTime);
                return
            else
                this.cost[tempIndex].Count = this.cost[tempIndex].Count + 1
            end
        end
        this.vm.data.usingAfterValue = this.ToString(tempStamina)
        local restoreValue = this.ToString(tempStamina - this.currentStamina)
        this.vm.data.usingTipText = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35136"),restoreValue)
        this.vm.data.propList[index].chooseNum = this.ToString(this.cost[tempIndex].Count)
        tempValue = {}
    end
    this.UpdateButton()
end

this.SubtractItem = function(id,index)
    local tempIndex = id..this.vm.data.propList[index].timeValue
    this.cost[tempIndex].Count = this.cost[tempIndex].Count - 1
    if this.cost[tempIndex].Count == 0 then
        this.cost[tempIndex] = nil
        this.vm.data.propList[index].choose = Vector3.zero
    else
        this.vm.data.propList[index].chooseNum = this.ToString(this.cost[tempIndex].Count)
    end
    local restoreValue = this.WhetherCeiling(0,0)
    if restoreValue == 0 then
        if this.currentStamina < SeasonSLGMapMgr.GetSeasonalStaminaRecoverMax() then
            restoreValue = 1
            this.vm.data.usingTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2163"].NameLan)
        else
            this.vm.data.usingTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2162"].NameLan)
        end
    else
        this.vm.data.usingTipText = string.format(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35146"),restoreValue)
    end
    this.vm.data.usingAfterValue = this.ToString(this.currentStamina + restoreValue)
    this.UpdateButton()
end

this.WhetherCeiling = function(currentValue,value)
    local tempValue = 0
    for key,_value in pairs(this.cost) do
        tempValue = tempValue + ConfigMgr.Config.itemMap[_value.ID].drop * _value.Count
    end
    local tempStamina = currentValue + tempValue + value
    local seasonalStaminaMax = SeasonSLGMapMgr.GetSeasonalStaminaMax()
    if tempStamina > seasonalStaminaMax then
        return false
    else
        return tempStamina
    end
end


this.UpdateTime = function(staminaRecoverInterval,lastRecoverStaminaTime)
    local pastTime = LuaMgr.Timestamp() - lastRecoverStaminaTime
    local residueTime = (staminaRecoverInterval - (pastTime % staminaRecoverInterval))
    local maxValue = SeasonSLGMapMgr.GetSeasonalStaminaRecoverMax()
    local residueAllTime = (SeasonSLGMapMgr.GetSeasonalStaminaRecoverMax() - this.currentStamina - 1) * staminaRecoverInterval + residueTime
    local h, m, s = GetTimeHMS(residueAllTime);
    if pastTime == staminaRecoverInterval then
        this.vm.data.timeTipText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_35148")
    else
        this.vm.data.timeTipText = string.format(this.timeStr,os.date("%M:%S",residueTime))
        this.vm.data.allTimeTipText = string.format(this.timeStr_1,h,m,s)
    end
    if pastTime > staminaRecoverInterval and maxValue > this.currentStamina then
        local data = {}
        data.DeviceID = LuaMgr.GetToken()
        ApiMgr.Request("heartbeat",data,true,function(result)
            local re = json.decode(result)
            this.InitRightData()
            this.UpdateRightData()
        end,nil,true)
    end
end
this.UpdateButton = function()
    this.vm.data.emptyBtn = next(this.cost) ~= nil
    this.vm.data.falseBtn = next(this.cost) ~= nil and Vector3.one or Vector3.zero
    this.vm.data.trueBtn = next(this.cost) ~= nil and Vector3.one or Vector3.zero
    this.vm.data.confirmBtn = next(this.cost) ~= nil and Vector3.zero or Vector3.one
end
this.SendRestore = function()
    if this.cost == nil or TableIsNull(this.cost) then return end
    local param = {Count = this.restoreCount or ConfigHelper.GetTableLength(this.cost)}
    this.restoreCount = nil
    this.cost = {}
    ApiMgr.Request("seasonal/stamina",param,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.CloseFunction()
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2020"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            LuaMgr.InvokeUIEventListeners(UIEventConst.FatigueReply)
        end
    end,nil,true)
end



this.UpdateBuyCount = function(param)
    local tempCount = 0
    local tipStr = ""
    if param then
        tempCount = this.buyCount + 1
    else
        tempCount = this.buyCount - 1
    end
    if tempCount > this.staminaCount then
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2021"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        return
    elseif tempCount < 1 then
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2062"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        return
    end
    this.currentStamina = GetSeasonalStaminaCount()
    local buyValue = GetSeasonalStaminaBuyValue(tempCount)
    if not this.WhetherCeiling(this.currentStamina,buyValue) then
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2063"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        return
    end
    this.buyCount = tempCount
    this.vm.data.buyCountText = this.buyCount
    this.InitRightData()
end
this.ListSort = function(item1,item2)
    if item1.timeValue ~= item2.timeValue then
        return item1.timeValue < item2.timeValue
    else
        return item1.itemId < item2.itemId
    end
end
this.CloseFunction = function()
    this.isPlayAni = false
    this.vm.data.uiAnimName = "UI_FatigueReplyPanel_02"
    LuaMgr.AddUIEventListener("102",this.CloseCallBack)
end
this.CloseCallBack = function()

    if this ~= nil then
        this.isPlayAni = true
    end
    LuaMgr.Back()
end

this.LongPressAdd=function()
    this.LongPressUpdateBuyCount(1)
end

this.LongPressReduce=function()
    this.LongPressUpdateBuyCount(-1)
end

this.LongPressUpdateBuyCount=function(dir)
    if UnityEngine.Time.realtimeSinceStartup - this.pressTime > this.pressInverval then
        this.pressTime = UnityEngine.Time.realtimeSinceStartup
        this.UpdateBuyCount(dir > 0)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})