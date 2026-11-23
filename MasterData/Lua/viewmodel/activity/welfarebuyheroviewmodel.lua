




local this = {
    vm = nil,
    tableInsert = table.insert,
    tableSort = table.sort,
    characterId = "A0139",
    characterConfig = nil,

    giftBagList = nil,

    giftBagAll = nil,
    curIndex = -1,
    rewardList = {},
    rewardContent = nil,
    chargeId = nil,
    timeTextStr = "",
    endTime = nil,
    order = nil,
    animator,
    timeFormat = "%s<color=#ffffff>%s-%s</color>",
    skinPicPath = "Assets/_BundleResources/Character/%s/Drawing/%s.png"
}

local data = {
    picTexture = DefaultTexture,
    rewardTip = false,
    rewardTipPos = Vector2.zero,
    leftImg = false,rightImg = false,
    groupPivot = Vector2.zero,
    groupSizeDelta = Vector2.zero,
    buyButton = false,
    timeText = "",tipText = "",
    jobIcon = DefaultSprite,rareColor = UnityEngine.Color(0,0,0,0),
    heroName = "",
    giftItem = {{groupPos = Vector2.zero,icon = DefaultSprite,text = DefaultSprite,
                 complete = false,value = "",confirm = false}},
}

local command = {
    rewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            if this.curIndex == index then return end
            this.OpenRewardTip(index)
        end
    },
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.CloseRewardTip()
        end
    },
    buyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param) + 1
            this.SendOrder(index)
        end
    },
    allBuyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.SendOrder()
        end
    },
    nameCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            LuaMgr.ShowPanel("Laigu.ViewModel.TakeCard.HeroAttrPreviewViewModel",this.characterConfig.id);
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.InitConfig()
        this.rewardContent = vm.behaviour.transform:Find("root/Left/RewardTip/Group/Content")
        this.animator = vm.behaviour.transform:Find("root/Left"):GetComponent("Animator")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.InitParameter()
        LuaMgr.AddUIEventListener(UIEventConst.PayOrder,this.PayOrder)
        LuaMgr.AddUIEventListener(UIEventConst.OnPayResult,this.OnPayResult)
        LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess)
        DataReportMgr.ClickPayView("",6);
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.CloseRewardTip()
        LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult)
        LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess)
    end,
    before_destroy = function(vm)
        this = nil
    end,
}


this.InitConfig = function()
    this.giftBagList = DataExHelper.Check_ConfigQuestEventByText("Tea1")
    this.tableSort(this.giftBagList,this.GiftBagSort)
    this.giftBagAll = DataExHelper.Check_ConfigQuestEventByText("Tea2")
    local groupId = ActivityMgr.groupKeyList["buyHero"]
    local activityData = DataMgr.Player.variables[groupId]
    local timeStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7032"].NameLan)
    local startTimeStr = os.date(LuaMgr.GetLangText("WelfareBuyHeroViewModel_0"),activityData.startTime)
    local delayTimeStr = os.date(LuaMgr.GetLangText("WelfareBuyHeroViewModel_1"),activityData.delTime)
    this.endTime = activityData.delTime
    this.timeTextStr = string.format(this.timeFormat,timeStr,startTimeStr,delayTimeStr)
end


this.InitParameter = function()
    this.animator:Play("WelfareBuyHeroPopup_RewardTip",0,0)
    this.SetSpine()
    this.InitGiftBag()
end

this.SetSpine = function()
    this.characterConfig = ConfigMgr.Config.characterTable[this.characterId]
    this.vm.data.heroName = LuaMgr.GetLangText(this.characterConfig.namelan)
    this.vm.data.jobIcon = LuaMgr.GetSprite("JobIcon","job_"..this.characterConfig.job)
    if this.characterConfig.rare == CharacterRare.R then
        this.vm.data.rareColor = UnityEngine.Color(33 / 225, 155 / 225, 161 / 225, 1)
    elseif this.characterConfig.rare == CharacterRare.SR then
        this.vm.data.rareColor = UnityEngine.Color(216 / 225, 187 / 225, 70 / 225, 1)
    elseif this.characterConfig.rare == CharacterRare.SSR then
        this.vm.data.rareColor = UnityEngine.Color(236 / 225, 56 / 225, 57 / 225, 1)
    end
    this.vm.data.picTexture = LuaMgr.GetTexture(string.format(this.skinPicPath,this.characterId,this.characterId.."002"))
    this.vm.data.timeText = this.timeTextStr
    this.vm.data.tipText = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["8001"].NameLan)
end


this.InitGiftBag = function()
    local tempList,tempItem = {},{}
    local tagBool,completeState,orderConfig = false,false,nil
    for i = 1, #this.giftBagList do
        orderConfig = ConfigMgr.Config.charge[this.giftBagList[i].conditionArgs[1]]
        orderConfig = ConfigHelper.GetChargeChannel(orderConfig.ChargeGroup)
        if DataMgr.Player.quests[this.giftBagAll[1].id].progress > 0 then
            completeState = true
        else
            completeState = DataMgr.Player.quests[this.giftBagList[i].id] ~= nil and
                    DataMgr.Player.quests[this.giftBagList[i].id].progress > 0
        end
        tempItem = {groupPos = Vector2.zero,confirm = false,
                    icon = LuaMgr.GetSprite("WelfareBuyHero","icon_"..i),
                    text = LuaMgr.GetSprite("WelfareBuyHero","text_"..i),
                    complete = completeState,
                    value = orderConfig.CurrencySymbol..orderConfig.PriceShow,
                    giftBagId = this.giftBagList[i].id,
                    orderId = this.giftBagList[i].conditionArgs[1]}
        if not tagBool and DataMgr.Player.quests[this.giftBagAll[1].id].progress == 0 then
            tagBool = DataMgr.Player.quests[this.giftBagList[i].id].progress == 0
            if tagBool then
                this.OpenRewardTip(i)
                tempItem.groupPos = Vector2(0,20)
                tempItem.confirm = tagBool
            end
        end
        this.tableInsert(tempList,tempItem)
    end
    this.vm.data.giftItem = tempList
    this.vm.data.buyButton = DataMgr.Player.quests[this.giftBagList[1].id].progress == 0 and
            DataMgr.Player.quests[this.giftBagAll[1].id].progress == 0
end


this.OpenRewardTip = function(index)
    this.curIndex = index
    this.vm.data.groupPivot = index <= 5 and Vector2(0,0.5) or Vector2(1,0.5)
    this.CreateRewardItem(index)
    if index <= 5 then
        this.vm.data.leftImg = true
        this.vm.data.rightImg = false
        this.vm.data.rewardTipPos = Vector2(34 + (index - 1) * 140,-18)
    else
        index = #this.giftBagList - index
        this.vm.data.leftImg = false
        this.vm.data.rightImg = true
        this.vm.data.rewardTipPos = Vector2(847 - index * 140,-18)
    end
    this.vm.data.rewardTip = true
end

this.CreateRewardItem = function(index)
    local itemConfig,tempItem = nil,nil
    local rewardTab = this.giftBagList[index].showReward
    for i = 1, #rewardTab do
        itemConfig = ConfigMgr.Config.itemMap[rewardTab[i].id]
        itemConfig["count0"] = rewardTab[i].count
        if #this.rewardList < i then
            tempItem = GoodsDataItem.New(this.rewardContent)
            this.tableInsert(this.rewardList,tempItem)
        end
        this.rewardList[i]:SetData(i,itemConfig,1,false,Vector3(0.6,0.6,0.6))
    end
    local extraCount = #this.rewardList - #rewardTab
    if extraCount > 0 then
        for i = #this.rewardList,#rewardTab,-1  do
            this.rewardList[i]:Clear()
            this.rewardList[i] = nil
            if #this.rewardList == #rewardTab then
                break
            end
        end
    end

    this.vm.data.groupSizeDelta = Vector2(#rewardTab * (128 * 0.6) + 16.5 * 2,100)
end


this.CloseRewardTip = function()
    this.curIndex = -1
    for i = 1, #this.rewardList do
        this.rewardList[i]:Clear()
    end
    this.rewardList = {}
    this.vm.data.rewardTip = false
end

this.SendOrder = function(index)
    this.CloseRewardTip()
    if this.endTime < LuaMgr.Timestamp() then
        local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7023"].NameLan)
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", tipStr)
        return
    end
    if index == nil then
        this.chargeId = this.giftBagAll[1].conditionArgs[1]
        LuaMgr.LuaOnAskPay(this.chargeId)
    else
        this.chargeId = this.vm.data.giftItem[index].orderId
        if index == 1 then
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["8000"].NameLan)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr,function() LuaMgr.LuaOnAskPay(this.chargeId) end,nil)
        else
            LuaMgr.LuaOnAskPay(this.chargeId)
        end
    end
end

this.PayOrder = function(data)
    if data.Length == 2 then
        local reChargeId = tostring(data[0])
        this.order = tostring(data[1])
        if this.chargeId ~= reChargeId then return end
        if LuaMgr.GetPlatform() ~= "EDITOR" then return end
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.AddTimer(TimerConst.FristPayRechargeStatus,this.OnTimer,1,100,true)
    end
end

this.OnPayResult = function(data)
    if data.Length == 1 then
        if this.order ~= nil and this.order ~= tostring(data[0]) then return end
    end
end

this.OnPaySuccess = function(data)
    if data.Length == 1 then
        if this.order ~= nil and this.order ~= tostring(data[0]) then return end
        this.InitGiftBag()
    end
end

this.OnTimer = function()
    local askData = {order = this.order}
    ApiMgr.Request("check_recharge_status", askData, true, function(result)
        local re = json.decode(result)
        if re.result.status == 2 then
            LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
            local rewards = re.result.rewards
            if rewards ~= nil then
                local tempData = json.encode(rewards)
                LuaMgr.ShowItemRewared(tempData)
            end
            this.InitGiftBag()
        end
    end, nil, true);
end

this.GiftBagSort = function(item1,item2)
    return item1.id < item2.id
end

return vm({
    data = data,
    command = command,
    hook = hook
})