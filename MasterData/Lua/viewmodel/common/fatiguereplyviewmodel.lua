




local this = {vm = nil,currentType = nil,itemType = 11,staminaCount = 0, clickMaxCount = 0,
              currentStamina = 0,cost = {},isPlayAni = false,ToString = tostring,buyCount = nil,
              timeStr = "",timeStr_1 = "",ITEM_ICON_PATH = "Assets/_BundleResources/Images/ItemIcons/itemicon_",
              pressInverval=0.1;
              pressTime=0;
              
}

local UsingType = {
Prop = 1,
Buy = 2,
}

local data = {
    propText = "",
    propChoose = false,
    propView = false,
    notView = false,
    emptyBtn = false,
    buyText = "",
    buyChoose = false,
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

local command = {

    propCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.currentType ~= UsingType.Prop then
                this.currentType = UsingType.Prop
                this.SwitchTypeBtn()
                this.InitDefaultChoose()
            end
        end
    },

    buyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.currentType ~= UsingType.Buy then
                this.currentType = UsingType.Buy
                this.SwitchTypeBtn()
                this.InitDefaultChoose()
            end
        end
    },
    itemCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local id = this.vm.data.propList[param + 1].itemId
            this.clickMaxCount = this.vm.data.propList[param + 1].countNum
            this.ChooseItem(id, param + 1)
        end
    },
    pressCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local id = this.vm.data.propList[param + 1].itemId
            this.clickMaxCount = this.vm.data.propList[param + 1].countNum
            local count = this.clickMaxCount - 1
            LuaMgr.AddTimer(TimerConst.PressClickTime, function()
                this.ChooseItem(id, param + 1)
            end, 0.1, count, true)
        end
    },
    liftUpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.RemoveTimer(TimerConst.PressClickTime)
        end
    },
    subtractCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local id = this.vm.data.propList[param + 1].itemId
            this.SubtractItem(id, param + 1)
        end
    },

    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.currentType == UsingType.Prop then
                if this.isPlayAni then
                    this.CloseFunction()
                end
            elseif this.currentType == UsingType.Buy then

                if this.staminaCount == 0 then
                    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2021"].NameLan)
                    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
                    return
                end

                local value = this.currentStamina + ConfigMgr.Config.constants.staminaGemRecover * this.buyCount
                if value > ConfigMgr.Config.constants.maxStamina then
                    local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2063"].NameLan)
                    LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
                    return
                end
                local needCount = 0
                for i = 1, this.buyCount do
                    needCount = needCount + ConfigMgr.Config.constants.costGemRecoverStamina[1]
                end
                local count = 0
                for i = 1, this.buyCount do
                    count = count + ConfigMgr.Config.constants.costGemRecoverStamina[1]
                end
                DataHelper.ConditionCheck("1", needCount, function()
                    this.cost["1"] = { ID = "1", Count = count, Expiry = 0 }
                    this.SendRestore()
                end)
            end
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
            LuaMgr.ShowLuaPanel(UIName.DiamondExchangeViewModel, "2", "1")
        end
    },
    addCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local clickType = tonumber(param);
            if clickType == 1 then

                this.UpdateBuyCount(true)
            elseif clickType == 2 then

                this.pressTime=0;
                LuaMgr.AddUpdate(this.LongPressAdd);
            elseif clickType == 3 then

                LuaMgr.RemoveUpdate(this.LongPressAdd)
            end
        end
    },
    countSubtractCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local clickType = tonumber(param);
            if clickType == 1 then

                this.UpdateBuyCount(false)
            elseif clickType == 2 then

                this.pressTime=0;
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
        this.InitTypeBtn()
        this.InitDefaultChoose()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveTimer(TimerConst.StaminaTime)
        LuaMgr.RemoveTimer(TimerConst.PressClickTime)
        LuaMgr.RemoveUIEventListener("102",this.CloseCallBack);
        LuaMgr.RemoveUpdate(this.LongPressReduce)
        LuaMgr.RemoveUpdate(this.LongPressAdd)
    end,
    before_destroy = function(vm)
        this = nil
    end,
}
this.SetLanguageText = function()
    this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2020"].NameLan)
end
this.InitPropView = function()
    local tempList = {}
    local itemConfig
    for key,value in pairs(DataMgr.Player.items) do
        itemConfig = ConfigMgr.Config.itemMap[key]
        if itemConfig.type == this.itemType then
            if not value.counts or #value.counts == 0 then
                if value.count0 ~= 0 then
                    local tempItem = {itemId = key,name = LuaMgr.GetLangText(itemConfig.nameLan),choose = Vector3.zero,
                                      rare = LuaMgr.GetSprite("ItemRare","itemRare"..itemConfig.rare),
                                      icon = LuaMgr.GetTexture(this.ITEM_ICON_PATH..key..".png"),chooseNum = "",timeValue = 0,
                                      count = this.ToString(value.count0),time = Vector3.zero,timeText = "",countNum = value.count0}
                    table.insert(tempList,tempItem)
                end
            else

                for i = 1, #value.counts do
                    if value.counts[i][2] > LuaMgr.Timestamp() then
                        local tempItem = {itemId = key,name = LuaMgr.GetLangText(itemConfig.nameLan),choose = Vector3.zero,
                                          rare = LuaMgr.GetSprite("ItemRare","itemRare"..itemConfig.rare),
                                          icon = LuaMgr.GetTexture(this.ITEM_ICON_PATH..key..".png"),chooseNum = "",
                                          count = this.ToString(value.counts[i][1]),time = Vector3.one,timeValue = value.counts[i][2],
                                          timeText = ConfigHelper.GoodsTime(value.counts[i][2]),countNum = value.counts[i][1]}
                        table.insert(tempList,tempItem)
                    end
                end
            end
        end
    end
    table.sort(tempList,this.ListSort)
    this.vm.data.propList = tempList
end
this.InitLeftData = function()
    if this.currentType == UsingType.Prop then
        this.InitPropView()
        this.vm.data.propView = #this.vm.data.propList > 0
        this.vm.data.notView = #this.vm.data.propList == 0
    elseif this.currentType == UsingType.Buy then
        this.vm.data.propView = false
        this.vm.data.notView = false
        this.vm.data.inventoryValue = LuaMgr.NumFormat(LuaMgr.GetFreeDiamond())
local maxCount = 999;
        this.staminaCount = maxCount - DataMgr.Player.dailyRecoverStaminaCount

        this.buyCount = 1
        this.vm.data.buyCountText = this.buyCount
    end
end
this.InitRightData = function()
    this.vm.data.buyTipText = Vector3.zero
    this.currentStamina = DataMgr.Player.stamina
    local maxValue = ConfigMgr.Config.playerLevelUp[this.ToString(DataMgr.Player.level)].staminaLimit
    this.vm.data.currentValue = this.ToString(this.currentStamina)
    this.vm.data.fatigueMaxText = this.currentStamina.."<color=#a29a85>/"..maxValue.."</color>"
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
        this.vm.data.usingAfterValue = this.ToString(this.currentStamina + ConfigMgr.Config.constants.staminaRecover)
        local staminaRecoverInterval = ConfigMgr.Config.constants.staminaRecoverInterval * 60
        local lastRecoverStaminaTime = DataMgr.Player.lastRecoverStaminaTime
        local count = maxValue * staminaRecoverInterval
        this.timeStr = LuaMgr.GetLangText("FatigueReplyViewModel_10")
        this.timeStr_1 = LuaMgr.GetLangText("FatigueReplyViewModel_15")
        LuaMgr.AddTimer(TimerConst.StaminaTime,function()
            this.UpdateTime(staminaRecoverInterval,lastRecoverStaminaTime) end,1,count,true)
    end
    if this.currentType == UsingType.Buy then
        local buyValue = ConfigMgr.Config.constants.staminaGemRecover * this.buyCount
        local usingAfterValue = this.currentStamina + buyValue
        if usingAfterValue > ConfigMgr.Config.constants.maxStamina then
            usingAfterValue = 999
        end
        this.vm.data.usingAfterValue = this.ToString(usingAfterValue)
        local itemCount = 0





        for i = 1, this.buyCount do
            itemCount = itemCount + ConfigMgr.Config.constants.costGemRecoverStamina[1]
        end


        this.vm.data.usingTipText = ""
        this.vm.data.frontTipText = string.format(LuaMgr.GetLangText("FatigueReplyViewModel_11"),buyValue)
        this.vm.data.afterTipText = string.format(LuaMgr.GetLangText("FatigueReplyViewModel_12"),itemCount)
        this.vm.data.buyTipText = Vector3.one
    end
    
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
        this.vm.data.usingTipText = string.format(LuaMgr.GetLangText("FatigueReplyViewModel_13"),restoreValue)
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
        if this.currentStamina < ConfigMgr.Config.playerLevelUp[this.ToString(DataMgr.Player.level)].staminaLimit then
            restoreValue = 1
            this.vm.data.usingTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2163"].NameLan)
        else
            this.vm.data.usingTipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2162"].NameLan)
        end
    else
        this.vm.data.usingTipText = string.format(LuaMgr.GetLangText("FatigueReplyViewModel_14"),restoreValue)
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
    if tempStamina > ConfigMgr.Config.constants.maxStamina then
        return false
    else
        return tempStamina
    end
end


this.UpdateTime = function(staminaRecoverInterval,lastRecoverStaminaTime)
    local pastTime = LuaMgr.Timestamp() - lastRecoverStaminaTime
    local residueTime = (staminaRecoverInterval - (pastTime % staminaRecoverInterval))
    
    local maxValue = ConfigMgr.Config.playerLevelUp[this.ToString(DataMgr.Player.level)].staminaLimit
    local residueAllTime = (maxValue - this.currentStamina - 1) * staminaRecoverInterval + residueTime
    local h, m, s = GetTimeHMS(residueAllTime);
    if pastTime == staminaRecoverInterval then
        this.vm.data.timeTipText = LuaMgr.GetLangText("FatigueReplyViewModel_7")
    else
        this.vm.data.timeTipText = string.format(this.timeStr,os.date("%M:%S",residueTime))
        this.vm.data.allTimeTipText = string.format(this.timeStr_1,h,m,s)
    end
    if pastTime > staminaRecoverInterval then
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
    if this.cost == nil or this.cost == {} then return end
    local data = {}
    for key,value in pairs(this.cost) do
        table.insert(data,value)
    end
    this.cost = {}
    ApiMgr.Request("recover_stamina2",data,true,function(result)
        local re = json.decode(result)
        if re.code == 0 then
            this.CloseFunction()
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2020"].NameLan)
            LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
            LuaMgr.InvokeUIEventListeners(UIEventConst.FatigueReply)
        end
    end,nil,true)
end

this.InitTypeBtn = function()
    this.currentType = this.GetWhetherHaveProp() and UsingType.Prop or UsingType.Buy
    this.vm.data.propText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2065"].NameLan)
    this.vm.data.buyText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2066"].NameLan)
    this.SwitchTypeBtn()
end
this.GetWhetherHaveProp = function()
    local itemConfig = nil
    for key,value in pairs(DataMgr.Player.items) do
        itemConfig = ConfigMgr.Config.itemMap[key]
        if itemConfig ~= nil and itemConfig.type == this.itemType then
            return true
        end
    end
    return false
end



this.InitDefaultChoose = function()
    if #this.vm.data.propList > 0 and this.currentType == UsingType.Prop then
        local id = this.vm.data.propList[1].itemId
        this.clickMaxCount = this.vm.data.propList[1].countNum
        this.ChooseItem(id,1)
    end
end

this.SwitchTypeBtn = function()
    this.cost = {}
    this.vm.data.propChoose = this.currentType == UsingType.Prop
    this.vm.data.buyChoose = this.currentType == UsingType.Buy
    this.InitLeftData()
    this.InitRightData()
    this.UpdateButton()
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
    this.currentStamina = DataMgr.Player.stamina
    local buyValue = ConfigMgr.Config.constants.staminaGemRecover * tempCount
    if not this.WhetherCeiling(this.currentStamina,buyValue) then
        tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2063"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel",tipStr)
        return
    end
    if param then
        this.buyCount = this.buyCount + 1
    else
        this.buyCount = this.buyCount - 1
    end
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
    if UnityEngine.Time.realtimeSinceStartup-this.pressTime>this.pressInverval then
        this.pressTime=UnityEngine.Time.realtimeSinceStartup;
        this.UpdateBuyCount(dir>0)
    end
end

return vm({
    data = data,
    command = command,
    hook = hook
})