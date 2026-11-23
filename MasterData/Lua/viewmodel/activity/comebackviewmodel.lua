




require("ViewModel/Activity/ComeBackMissionItem")

local this = {
    vm = nil,curLabel = nil,labelEnum = {SignIn = 1,Mission = 2,Permit = 3,Gift = 4},
signInKey = "backPlayer",signInData = nil,signInRootUI = {},
    missionData = nil,dayIndex = nil,missionScroll = nil,missionTemplate = nil,
    phaseKey = "backPhase",phaseData = nil,
    rewardList = nil,rewardRoot = nil,postList = {-119,32,182,332,481},
    tableInsert = table.insert,permitPassesId = "11001",permitIsPay = false,
    chargeId = "",order = nil,lastDayFreeId = nil,lastDayCollectFeeId = nil,
    lastDayFreeCanGet = false,lastDayCollectFeeCanGet = false,lastDayId = nil,
    giftList = {"100009101","100009102"},
    nowReward = nil,unlockReward = nil,
    nowRewardList = nil,unlockRewardList = nil,allPayReward = nil,
}
local paying=false;

local data = {
    signInRoot = false,signInText = "",
    missionRoot = false,missionText = "",
    permitRoot = false,permitText = "",
    giftRoot = false,giftText = "",
    timeTipsText = "",timeText = "",
    barTipText = "",barNumText = "",
    barValue = 0.0,
    rewardPopup = false,rewardPost = Vector2.zero,
    allGetBtn = false,allGetBtnText = "",
    signInTipText = "",
    signInRed = false,missionRed = false,
    permitRed = false,giftRed = false,
    
    freeText = "",collectText = "",collectBuyText = "",
    theLastDayText = "",theLastDayTipText = "",
    thsLastDayCanGet = false,
    
    lastDayFreeRare = DefaultSprite,lastDayFreeIcon = DefaultTexture,
    lastDayFreeCount = "",lastDayFreeAlready = false,
    
    lastDayCollectFeeRare = DefaultSprite,lastDayCollectFeeIcon = DefaultTexture,
    lastDayCollectFeeCount = "",lastDayCollectFeeAlready = false,
    lastDayCollectFeeSuo = false,permitBuyBtn = false,
    
    buyGiftPopup = false,buyTitle = "",nowAcquireText = "",unlockAcquireText = "",
    buyBtnText = "",

    dayList = {{normal = false,choose = false,dayText = ""},
               {normal = false,choose = false,dayText = ""},
               {normal = false,choose = false,dayText = ""},
               {normal = false,choose = false,dayText = ""},
               {normal = false,choose = false,dayText = ""}},
    phaseReward = {{normal = false,canGet = false,already = false,count = ""},
                   {normal = false,canGet = false,already = false,count = ""},
                   {normal = false,canGet = false,already = false,count = ""},
                   {normal = false,canGet = false,already = false,count = ""},
                   {normal = false,canGet = false,already = false,count = ""}},
    permitDayItem = {{canGet = false,normal = false,dayText = "",
                      freeRare = DefaultSprite,freeIcon = DefaultTexture,freeCount = "",freeAlready = false,collectFeeSuo = false,
                      collectFeeRare = DefaultSprite,collectFeeIcon = DefaultTexture,collectFeeCount = "",collectFeeAlready = false,red = false}},
    giftItem = {{discountText = "",giftNameText = "",giftCount = "",buyText = "",soldOut = false,soldOutText = ""},
                {discountText = "",giftNameText = "",giftCount = "",buyText = "",soldOut = false,soldOutText = ""}},
    giftReward_1 = {{rare_1 = DefaultSprite,icon_1 = DefaultTexture,name_1 = "",count_1 = ""}},
    giftReward_2 = {{rare_2 = DefaultSprite,icon_2 = DefaultTexture,name_2 = "",count_2 = ""}},
}

local command = {
    signInLabelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not DataExHelper.Check_ComeBackActivity() then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("7023"))
                return
            end
            this.curLabel = this.labelEnum.SignIn
            this.SwitchLabel()
        end
    },
    missionLabelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not DataExHelper.Check_ComeBackActivity() then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("7023"))
                return
            end
            this.curLabel = this.labelEnum.Mission
            this.SwitchLabel()
        end
    },
    permitLabelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not DataExHelper.Check_ComeBackActivity() then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("7023"))
                return
            end
            this.curLabel = this.labelEnum.Permit
            this.SwitchLabel()
        end
    },
    giftLabelCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not DataExHelper.Check_ComeBackActivity() then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("7023"))
                return
            end
            this.curLabel = this.labelEnum.Gift
            this.SwitchLabel()
        end
    },
    goodsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param)
            local id = this.signInRootUI[index].id
            if this.signInRootUI[index].type == 9 then
                LuaMgr.ShowPanel(UIName.WeaponTipsViewModel,id)
            else
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,id,false,false,false,0,0);
            end
        end
    },
    signInGetCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not DataExHelper.Check_ComeBackActivity() then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("7023"))
                return
            end
            local index = tonumber(param)
            local missionId = this.signInData[index].id
            this.GetReward(missionId,this.signInKey,function()
                this.GetSignInData()
                this.SetSignInData()
                this.RefreshRed()
            end)
        end
    },
    dayNormalCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param)
            this.SetMissionData(index)
        end
    },
    phaseRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if not DataExHelper.Check_ComeBackActivity() then
                LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", ConfigMgr.LangGlobal("7023"))
                return
            end


            this.GetReward("all",this.phaseKey,function()
                this.GetProgressBarData()
                this.SetProgressBar()
                this.RefreshRed()
            end)
        end
    },
    previewRewardCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param)
            this.OpenRewardPopup(index)
        end
    },
    closePreviewCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.vm.data.rewardPopup = false
        end
    },
    allGetCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local tab = "back0"..this.dayIndex
            this.GetReward("all",tab,this.UpdateMission)
        end
    },
    freeGoodsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            local isGet = this.vm.data.permitDayItem[index].canGet
            if isGet then
                local passesRewardId = this.vm.data.permitDayItem[index].passesRewardId
                this.OnAskLevelReward(passesRewardId,0)
            else
                local freeGoodsId = this.vm.data.permitDayItem[index].freeGoodsId
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,freeGoodsId,false,false,false,0,0);
            end
        end
    },
    collectFeeGoodsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = param + 1
            local isGet = this.vm.data.permitDayItem[index].collectFeeCanGet
            if isGet then
                local passesRewardId = this.vm.data.permitDayItem[index].passesRewardId
                this.OnAskLevelReward(passesRewardId,1)
            else
                local collectFeeGoodsId = this.vm.data.permitDayItem[index].collectFeeGoodsId
                LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,collectFeeGoodsId,false,false,false,0,0);
            end
        end
    },
    permitBuyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.PermitPopup(not this.vm.data.buyGiftPopup)
        end
    },
    permitBuyConfirm = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if paying then return end;
            paying=true;
            LuaMgr.LuaOnAskPay(this.chargeId)
        end
    },
    permitCloseCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            this.PermitPopup(false)
        end
    },
    lastDayGoodsCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            if param == "1" then
                if this.lastDayFreeCanGet then
                    this.OnAskLevelReward(this.lastDayId,0)
                else
                    LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,this.lastDayFreeId,false,false,false,0,0);
                end
            else
                if this.lastDayCollectFeeCanGet then
                    this.OnAskLevelReward(this.lastDayId,1)
                else
                    LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,this.lastDayCollectFeeId,false,false,false,0,0);
                end
            end
        end
    },
    giftBuyCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm,param)
            local index = tonumber(param)
            if paying then
                return
            end
            paying = true
            this.chargeId = this.giftList[index]
            LuaMgr.LuaOnAskPay(this.chargeId)
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.GetUIRootNode()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
        this.RefreshRed()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.signInData = nil
        this.missionData = nil
        this.phaseData = nil
        this.vm.data.rewardPopup = false
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this.ClearReward()
        this.ClearPermitReward()
        UIScrollView.ClearItem("ComeBackMissionItem")
        this = nil
    end,
}

this.AddUIEvent = function()
    LuaMgr.AddUIEventListener(UIEventConst.ComeBackMissionGetReward, this.UpdateMission)

    LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder)
    LuaMgr.AddUIEventListener(UIEventConst.PayOrder,this.PayOrder)
    LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult)
    LuaMgr.AddUIEventListener(UIEventConst.OnPayResult,this.OnPayResult)
    LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess)
    LuaMgr.AddUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess)
end
this.RemoveUIEvent = function()
    this.missionScroll:Clear()
    LuaMgr.RemoveUIEventListener(UIEventConst.ComeBackMissionGetReward, this.UpdateMission)
    LuaMgr.RemoveUIEventListener(UIEventConst.PayOrder,this.PayOrder)
    LuaMgr.RemoveUIEventListener(UIEventConst.OnPayResult,this.OnPayResult)
    LuaMgr.RemoveUIEventListener(UIEventConst.OnPaySuccess,this.OnPaySuccess)
end


this.InitParameter = function()
    this.vm.data.buyGiftPopup = false
    if not DataExHelper.Check_ComeBackActivity() then
        return
    end
    this.SetLanguageText()
    this.SetTime()

    local param = "SignIn"
    this.curLabel = this.labelEnum.SignIn

    if HeroParameter.comeBackLabel ~= nil then
        param = HeroParameter.comeBackLabel
    else

        if this.vm.behaviour.Params.Length > 0 then
            param = this.vm.behaviour.Params[0]
        end
    end
    if param == "SignIn" then
        this.curLabel = this.labelEnum.SignIn
    elseif param == "Mission" then
        this.curLabel = this.labelEnum.Mission
    end
    this.vm.behaviour:UpdateTopBar(param,this.Back)
    this.SwitchLabel()
end


this.RefreshRed = function()
    local redCount = HeroRedDataHelper.ComeBackSignInRed()
    this.vm.data.signInRed = redCount > 0

    redCount = HeroRedDataHelper.ComeBackMissionRed()
    if redCount == 0 then
        redCount = HeroRedDataHelper.ComeBackPhaseRed()
    end
    this.vm.data.missionRed = redCount > 0
    
    redCount = HeroRedDataHelper.ComeBackPermitRed()
    this.vm.data.permitRed = redCount > 0
end


this.SetLanguageText = function()
    this.vm.data.signInText = ConfigMgr.LangGlobal("10906")
    this.vm.data.missionText = ConfigMgr.LangGlobal("10907")
    this.vm.data.permitText = ConfigMgr.LangGlobal("29737")
    this.vm.data.giftText = ConfigMgr.LangGlobal("29738")
    this.vm.data.timeTipsText = ConfigMgr.LangGlobal("10901")
    this.vm.data.barTipText = ConfigMgr.LangGlobal("10913")
    this.vm.data.allGetBtnText = ConfigMgr.LangGlobal("10912")
    this.vm.data.signInTipText = ConfigMgr.LangGlobal("10914")
    this.vm.data.freeText = ConfigMgr.LangGlobal("29741")
    this.vm.data.collectText = ConfigMgr.LangGlobal("29742")
    this.vm.data.collectBuyText = ConfigMgr.LangGlobal("29692")
    this.vm.data.theLastDayTipText = ConfigMgr.LangGlobal("29743")
end


this.SetTime = function()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.backPlayer]
    local activityData = DataMgr.Player.variables[groupId]
    if activityData == nil then
        return
    end
    local endTime = activityData.delTime
    local surplusTime = endTime - LuaMgr.Timestamp()
    local timeFormat = ConfigMgr.LangGlobal("10908")
    local d,h,m = GetTimeDHM2(surplusTime)
    this.vm.data.timeText = string.format(timeFormat,d,h,m)
end

this.SwitchLabel = function()
    if this.curLabel == this.labelEnum.SignIn then
        this.GetSignInData()
        this.SetSignInData()
    elseif this.curLabel == this.labelEnum.Mission then
        this.GetMissionData()
        this.SetMissionDay()
        this.GetProgressBarData()
        this.SetProgressBar()
        this.DefaultDayIndex()
        this.SetMissionData(this.dayIndex)
    elseif this.curLabel == this.labelEnum.Permit then
        paying = false
        this.SetPermitData()
    elseif this.curLabel == this.labelEnum.Gift then
        paying = false
        this.SetGiftData()
    end
    HeroParameter.EmptyComeBackParam()
    this.vm.data.signInRoot = this.curLabel == this.labelEnum.SignIn
    this.vm.data.missionRoot = this.curLabel == this.labelEnum.Mission
    this.vm.data.permitRoot = this.curLabel == this.labelEnum.Permit
    this.vm.data.giftRoot = this.curLabel == this.labelEnum.Gift
end


this.GetSignInData = function()
    this.signInData = {}
    if TableIsNull(DataMgr.Player.backPlayerMissions) then
        return
    end
    if TableIsNull(DataMgr.Player.backPlayerMissions[this.signInKey]) then
        return
    end
    for key,value in pairs(DataMgr.Player.backPlayerMissions[this.signInKey]) do
        this.tableInsert(this.signInData,value)
    end
    table.sort(this.signInData,this.SortSignIn)
end


this.SetSignInData = function()
    if TableIsNull(this.signInData) then
        return
    end
    local targetCount = 0
    local canGetBool = false
    local signInConfig = nil
    local itemConfig = nil
    for i = 1, #this.signInData do
        signInConfig = ConfigMgr.Config.BackPlayerTaskMap[this.signInData[i].id]
        if signInConfig == nil then return end
        this.signInRootUI[i].numText.text = i
        targetCount = MissionHelper.GetTargetCount(signInConfig.id)
        canGetBool = not this.signInData[i].completed and this.signInData[i].current >= targetCount
        SetActive(this.signInRootUI[i].canGet,canGetBool)
        SetActive(this.signInRootUI[i].complete,this.signInData[i].completed)
        itemConfig = ConfigMgr.Config.itemMap[signInConfig.rewards[1].itemId]
        this.signInRootUI[i].countText.text = signInConfig.rewards[1].count
        if itemConfig == nil then return end
        this.signInRootUI[i].icon.texture = GetItemTexture(itemConfig.id)
        this.signInRootUI[i].rare.sprite = GetRareSprite(itemConfig.rare)
        this.signInRootUI[i].nameText.text = LuaMgr.GetLangText(itemConfig.nameLan)
        this.signInRootUI[i].id = itemConfig.id
        this.signInRootUI[i].type = itemConfig.type
    end
end


this.GetMissionData = function()
    this.missionData = {}
    if TableIsNull(DataMgr.Player.backPlayerMissions) then
        return
    end
    local dayKey = nil
    for i = 1, 5 do
        dayKey = "back0"..i
        this.missionData[i] = {}
        for key,value in pairs(DataMgr.Player.backPlayerMissions[dayKey]) do
            this.tableInsert(this.missionData[i],value)
        end
        table.sort(this.missionData[i],this.SortMission)
    end
end


this.SetMissionDay = function()
    if DataMgr.Player.backPlayer == nil or DataMgr.Player.backPlayer.startTime <= 0 then
        return
    end

    local dayKey = nil
    local dayTextStr = ConfigMgr.LangGlobal("10911")
    for i = 1, #this.vm.data.dayList do
        dayKey = "back0"..i
        this.vm.data.dayList[i].normal = DataMgr.Player.backPlayer.tabUnlock[dayKey]
        this.vm.data.dayList[i].choose = false
        this.vm.data.dayList[i].dayText = string.format(dayTextStr,i)
    end
end


this.SetMissionData = function(index)
    this.vm.data.dayList[this.dayIndex].choose = false
    this.dayIndex = index
    this.vm.data.dayList[this.dayIndex].choose = true

    this.missionScroll:Clear(false)
    local scrollData,scrollDatas = {},{}
    local groupData = nil
    local tempData = nil
    local canGetCount = 0
    local targetCount = 0
    for i = 1, #this.missionData[this.dayIndex] do
        groupData = {}
        tempData = this.missionData[this.dayIndex][i]
        groupData.data = tempData
        groupData.tab = "back0"..this.dayIndex
        groupData.tabNum = this.dayIndex
        scrollData = UIScrollData.GetData(this.missionTemplate,"ComeBackMissionItem",952.5,80 + 8,groupData)
        this.tableInsert(scrollDatas,scrollData)
        targetCount = MissionHelper.GetTargetCount(tempData.id)
        if not tempData.completed and tempData.current >= targetCount then
            canGetCount = canGetCount + 1
        end
    end
    this.vm.data.allGetBtn = canGetCount >= 1
    if canGetCount >= 1 then
        this.missionScroll:SetParams(1036,386)
    else
        this.missionScroll:SetParams(1036,454)
    end
    this.missionScroll:SetPadding(0,0,-6,0)
    this.missionScroll:SetData(scrollDatas, true)
end


this.GetProgressBarData = function()
    this.phaseData = {}
    if TableIsNull(DataMgr.Player.backPlayerMissions) then
        return
    end
    if TableIsNull(DataMgr.Player.backPlayerMissions[this.phaseKey]) then
        return
    end
    for key,value in pairs(DataMgr.Player.backPlayerMissions[this.phaseKey]) do
        this.tableInsert(this.phaseData,value)
    end
    table.sort(this.phaseData,this.SortSignIn)
end


this.SetProgressBar = function()
    if TableIsNull(this.phaseData) then
        return
    end
    local length = #this.phaseData
    local targetCount = 0
    for i = 1, length do
        targetCount = MissionHelper.GetTargetCount(this.phaseData[i].id)
        this.vm.data.phaseReward[i].normal = not this.phaseData[i].completed and this.phaseData[i].current < targetCount
        this.vm.data.phaseReward[i].canGet = not this.phaseData[i].completed and this.phaseData[i].current >= targetCount
        this.vm.data.phaseReward[i].already = this.phaseData[i].completed
        this.vm.data.phaseReward[i].count = targetCount
    end
    local phaseValue = this.phaseData[length].current
    this.vm.data.barNumText = phaseValue
    this.vm.data.barValue = phaseValue / targetCount
end


this.DefaultDayIndex = function()
    if HeroParameter.comeBackDayIndex ~= nil then
        this.dayIndex = HeroParameter.comeBackDayIndex
    else
        local dayKey = nil
        for i = 1, #this.missionData do
            dayKey = "back0"..i
            if DataMgr.Player.backPlayer.tabUnlock[dayKey] then
                this.dayIndex = i
                for k = 1, #this.missionData[i] do
                    if not this.missionData[i][k].completed then
                        this.dayIndex = i
                        return
                    end
                end
            end
        end
    end
end


this.SetPermitData = function()
    this.vm.data.buyGiftPopup = false
    local passesConfig = ConfigMgr.Config.PassesMap[this.permitPassesId]
    if TableIsNull(passesConfig) then
        return
    end
    this.chargeId = passesConfig.Charge1[1]
    this.vm.data.theLastDayText = string.format(ConfigMgr.LangGlobal("10911"),passesConfig.MaxLevel)
    local passesData = DataMgr.Player.passesMultiple[this.permitPassesId]
    if TableIsNull(passesData) then
        return
    end
    this.permitIsPay = passesData.pay
    this.vm.data.permitBuyBtn = not this.permitIsPay

    local passesRewardsMultiple = DataMgr.Player.passesRewardsMultiple[this.permitPassesId]
    if TableIsNull(passesRewardsMultiple) then
        return
    end
    local passesRewardsList = {}
    for key,value in pairs(passesRewardsMultiple) do
        this.tableInsert(passesRewardsList,value)
    end
    table.sort(passesRewardsList,function(a,b) return a.level < b.level end)

    local passesReward = nil
    local tempData,tempList = nil,{}
    local period = nil
    local dayTextStr = ConfigMgr.LangGlobal("10911")
    local goods = nil
    local length = #passesRewardsList - 1
    this.allPayReward = {}
    for i = 1, length do
        passesReward = ConfigMgr.Config.PassesRewardMap[passesRewardsList[i].id]
        if not TableIsNull(passesReward) then
            tempData = {canGet = false,normal = false,dayText = "",red = false,
                        freeRare = DefaultSprite,freeIcon = DefaultTexture,freeCount = "",freeAlready = false,
                        collectFeeRare = DefaultSprite,collectFeeIcon = DefaultTexture,collectFeeCount = "",collectFeeAlready = false}
            period = DataMgr.Player.passesMissionsMultiple[this.permitPassesId].period[passesReward.TaskId]
            if not TableIsNull(period) then
                tempData.collectFeeCanGet = this.permitIsPay and period.completed and period.current >= period.target and passesRewardsMultiple[passesRewardsList[i].id].payReceiveTime == 0
                tempData.canGet = (period.completed and period.current >= period.target and passesRewardsMultiple[passesRewardsList[i].id].freeReceiveTime == 0) or tempData.collectFeeCanGet
                tempData.normal = not tempData.canGet and not tempData.collectFeeCanGet
                tempData.dayText = string.format(dayTextStr,i)
                
                goods = ConfigMgr.Config.itemMap[passesReward.FreeReward[1].id]
                tempData.freeGoodsId = goods.id
                tempData.freeRare = ConfigHelper.GetRareSprite(goods.rare)
                tempData.freeIcon = ConfigHelper.GetItemTexture(goods.id)
                tempData.freeCount = tostring(passesReward.FreeReward[1].count)
                tempData.freeAlready = passesRewardsMultiple[passesRewardsList[i].id].freeReceiveTime ~= 0
                
                goods = ConfigMgr.Config.itemMap[passesReward.PayReward[1].id]
                if this.allPayReward[goods.id] == nil then
                    this.allPayReward[goods.id] = {id = goods.id,count = passesReward.PayReward[1].count}
                else
                    this.allPayReward[goods.id].count = this.allPayReward[goods.id].count + passesReward.PayReward[1].count
                end
                tempData.collectFeeGoodsId = goods.id
                tempData.collectFeeRare = ConfigHelper.GetRareSprite(goods.rare)
                tempData.collectFeeIcon = ConfigHelper.GetItemTexture(goods.id)
                tempData.collectFeeCount = tostring(passesReward.PayReward[1].count)
                tempData.collectFeeAlready = passesRewardsMultiple[passesRewardsList[i].id].payReceiveTime ~= 0
                tempData.collectFeeSuo = not this.permitIsPay

                tempData.red = tempData.canGet or tempData.collectFeeCanGet
                tempData.passesRewardId = passesReward.Id
                tempData.missionMultiple = table.Copy(period)
                this.tableInsert(tempList,tempData)
            end
        end
    end
    this.vm.data.permitDayItem = tempList

    passesReward = ConfigMgr.Config.PassesRewardMap[passesRewardsList[passesConfig.MaxLevel].id]
    this.lastDayId = passesReward.Id
    period = DataMgr.Player.passesMissionsMultiple[this.permitPassesId].period[passesReward.TaskId]
    goods = ConfigMgr.Config.itemMap[passesReward.FreeReward[1].id]
    this.lastDayFreeId = goods.id
    this.vm.data.lastDayFreeRare = ConfigHelper.GetRareSprite(goods.rare)
    this.vm.data.lastDayFreeIcon = ConfigHelper.GetItemTexture(goods.id)
    this.vm.data.lastDayFreeCount = tostring(passesReward.FreeReward[1].count)
    this.vm.data.lastDayFreeAlready = passesRewardsMultiple[passesReward.Id].freeReceiveTime ~= 0
    this.lastDayFreeCanGet = period.completed and period.current >= period.target and passesRewardsMultiple[passesReward.Id].freeReceiveTime == 0
    
    goods = ConfigMgr.Config.itemMap[passesReward.PayReward[1].id]
    if this.allPayReward[goods.id] == nil then
        this.allPayReward[goods.id] = {id = goods.id,count = passesReward.PayReward[1].count}
    else
        this.allPayReward[goods.id].count = this.allPayReward[goods.id].count + passesReward.PayReward[1].count
    end
    this.lastDayCollectFeeId = goods.id
    this.vm.data.lastDayCollectFeeRare = ConfigHelper.GetRareSprite(goods.rare)
    this.vm.data.lastDayCollectFeeIcon = ConfigHelper.GetItemTexture(goods.id)
    this.vm.data.lastDayCollectFeeCount = tostring(passesReward.PayReward[1].count)
    this.vm.data.lastDayCollectFeeAlready = passesRewardsMultiple[passesReward.Id].payReceiveTime ~= 0
    this.vm.data.lastDayCollectFeeSuo = not this.permitIsPay
    this.lastDayCollectFeeCanGet = this.permitIsPay and period.completed and period.current >= period.target and passesRewardsMultiple[passesReward.Id].payReceiveTime == 0
    this.vm.data.thsLastDayCanGet = this.lastDayFreeCanGet or this.lastDayCollectFeeCanGet
end


this.SetGiftData = function()
    if TableIsNull(this.giftList) then
       return 
    end
    local charge = nil
    local buyCount = 0
    for i = 1, #this.vm.data.giftItem do
        buyCount = 0
        charge = ConfigMgr.Config.charge[this.giftList[i]]
        local hasBuy = DataMgr.Player.shop.records[charge.Id]
        if hasBuy ~= nil then
            buyCount = hasBuy
        end
        if charge.ChargeGroup ~= nil and charge.ChargeGroup ~= "" then
            chargeChanel = ConfigHelper.GetChargeChannel(charge.ChargeGroup)
            if i == 1 then
this.vm.data.giftItem[i].giftNameText = ConfigMgr.LangGlobal("29739")
            elseif i == 2 then
this.vm.data.giftItem[i].giftNameText = ConfigMgr.LangGlobal("29740")
            end
            this.vm.data.giftItem[i].buyText = ConfigHelper.GetGoodsPriceStr(charge.Id)
            this.vm.data.giftItem[i].giftCount = ConfigMgr.LangGlobal("29744")..buyCount.."/"..charge.RefreshCount
            this.vm.data.giftItem[i].soldOut = buyCount >= charge.RefreshCount
            this.vm.data.giftItem[i].soldOutText = ConfigMgr.LangGlobal("29745")
            if not TableIsNull(charge.Reward) then
                this.SetGiftGoods(charge.Reward,i)
            end
        end
    end
end
this.SetGiftGoods = function(reward,index)
    local tempData,tempList = nil,{}
    local goods = nil
    for i = 1, #reward do
        goods = ConfigMgr.Config.itemMap[reward[i].id]
        if index == 1 then
            tempData = {rare_1 = ConfigHelper.GetRareSprite(goods.rare),icon_1 = ConfigHelper.GetItemTexture(goods.id),
                        name_1 = LuaMgr.GetLangText(goods.nameLan),count_1 = "X"..reward[i].count}
            this.tableInsert(tempList,tempData)
        elseif index == 2 then
            tempData = {rare_2 = ConfigHelper.GetRareSprite(goods.rare),icon_2 = ConfigHelper.GetItemTexture(goods.id),
                        name_2 = LuaMgr.GetLangText(goods.nameLan),count_2 = "X"..reward[i].count}
            this.tableInsert(tempList,tempData)
        end
    end
    if index == 1 then
        this.vm.data.giftReward_1 = tempList
    elseif index == 2 then
        this.vm.data.giftReward_2 = tempList
    end
end
this.PermitPopup = function(isShow)
    if isShow then
        this.vm.data.buyTitle = ConfigMgr.LangGlobal("29742")
        this.vm.data.nowAcquireText = ConfigMgr.LangGlobal("29746")
        this.vm.data.unlockAcquireText = ConfigMgr.LangGlobal("29747")
        local charge = ConfigMgr.Config.charge[this.chargeId]
        if TableIsNull(charge) then
            return
        end
        if charge.ChargeGroup ~= nil and charge.ChargeGroup ~= "" then
            this.vm.data.buyBtnText = ConfigHelper.GetGoodsPriceStr(charge.Id)
            if not TableIsNull(charge.Reward) then
                if TableIsNull(this.nowRewardList) then
                    this.nowRewardList = {}
                end
                local itemConfig = nil
                for i = 1, #charge.Reward do
                    itemConfig = table.Copy(ConfigMgr.Config.itemMap[charge.Reward[i].id])
                    if TableIsNull(itemConfig) then return end
                    if #this.nowRewardList < i then
                        this.tableInsert(this.nowRewardList,GoodsDataItem.New(this.nowReward))
                    end
                    itemConfig["count0"] = charge.Reward[i].count
                    this.nowRewardList[i]:SetData(i,itemConfig,1,false,Vector3(0.8,0.8,0.8),false)
                end
            end
            if not TableIsNull(this.allPayReward) then
                if TableIsNull(this.unlockRewardList) then
                    this.unlockRewardList = {}
                end
                local itemConfig = nil
                local index = 1
                for key,value in pairs(this.allPayReward) do
                    itemConfig = table.Copy(ConfigMgr.Config.itemMap[key])
                    if TableIsNull(itemConfig) then return end
                    if #this.unlockRewardList < index then
                        this.tableInsert(this.unlockRewardList,GoodsDataItem.New(this.unlockReward))
                    end
                    itemConfig["count0"] = value.count
                    this.unlockRewardList[index]:SetData(index,itemConfig,1,false,Vector3(0.8,0.8,0.8),false)
                    index = index + 1
                end
            end
        end
    end
    this.vm.data.buyGiftPopup = isShow
end
this.ClearPermitReward = function()
    if not TableIsNull(this.nowRewardList) then
        for i = 1, #this.nowRewardList do
            this.nowRewardList[i]:Clear()
        end
        this.nowRewardList = nil
    end
    if not TableIsNull(this.unlockRewardList) then
        for i = 1, #this.unlockRewardList do
            this.unlockRewardList[i]:Clear()
        end
        this.unlockRewardList = nil
        this.allPayReward = nil
    end
end


this.UpdateMission = function(args)
    this.GetMissionData()
    this.SetMissionData(this.dayIndex)
    this.GetProgressBarData()
    this.SetProgressBar()
    this.RefreshRed()
end


this.OpenRewardPopup = function(index)
    local missionId = this.phaseData[index].id
    local tempList = ConfigMgr.Config.BackPlayerTaskMap[missionId].rewards
    if TableIsNull(tempList) then
        return
    end
    if TableIsNull(this.rewardList) then
        this.rewardList = {}
    end
    local itemConfig = nil
    for i = 1, #tempList do
        itemConfig = table.Copy(ConfigMgr.Config.itemMap[tempList[i].itemId])
        if TableIsNull(itemConfig) then return end
        if #this.rewardList < i then
            this.tableInsert(this.rewardList,GoodsDataItem.New(this.rewardRoot))
        end
        itemConfig["count0"] = tempList[i].count
        this.rewardList[i]:SetData(i,itemConfig,1,false,Vector3(0.6,0.6,0.6),false)
    end
    for i = #tempList + 1, #this.rewardList do
        this.rewardList[i]:Hide()
    end
    this.vm.data.rewardPost = Vector2(this.postList[index],-187)
    this.vm.data.rewardPopup = true
end
this.ClearReward = function()
    if TableIsNull(this.rewardList) then return end
    for i = 1, #this.rewardList do
        this.rewardList[i]:Clear()
    end
    this.rewardList = nil
end

this.GetReward = function(id,tab,callBack)
    DataExHelper.EX_ComeBackComplete(id,tab,callBack)
end


this.GetUIRootNode = function()
    this.missionScroll = UIScrollView.New(this.vm.behaviour.transform:Find("root/_Middle/Mission/MissionList").gameObject)
    this.missionTemplate = this.vm.behaviour.transform:Find("template/MissionItem").gameObject
    this.rewardRoot = this.vm.behaviour.transform:Find("root/_Middle/RewardPopup/ListContent"):GetComponent("Transform")
    this.nowReward = this.vm.behaviour.transform:Find("root/_Middle/BuyGiftPopup/Bg/NowReward"):GetComponent("Transform")
    this.unlockReward = this.vm.behaviour.transform:Find("root/_Middle/BuyGiftPopup/Bg/UnlockReward"):GetComponent("Transform")

    local parentTran = this.vm.behaviour.transform:Find("root/_Middle/SignIn/SignInList"):GetComponent("Transform")
    local node = {
        canGet = {path = "CanGet",type = "GameObject"},
        numText = {path = "Num",type = "Text"},
        rare = {path = "Rare",type = "Image"},
        icon = {path = "Rare/Icon",type = "RawImage"},
        countText = {path = "Rare/Count/Text",type = "Text"},
        nameText = {path = "Name",type = "Text"},
        complete = {path = "Complete",type = "GameObject"},
    }
    local object,objectName,tempNode = nil,"",{}
    for i = 1, parentTran.childCount do
        objectName = "SignInItem"..i
        object = parentTran:Find(objectName).gameObject
        tempNode = {}
        UITool.Parse(object,tempNode,node)
        this.tableInsert(this.signInRootUI,i,tempNode)
    end
    object,objectName,tempNode = nil,nil,nil
end
this.SortSignIn = function(item1,item2)
    return item1.target < item2.target
end
this.SortMission = function(item1,item2)
    if item1.completed == item2.completed then
        if item1.current / MissionHelper.GetTargetCount(item1.id) ~= item2.current / MissionHelper.GetTargetCount(item2.id) then
            return item1.current / MissionHelper.GetTargetCount(item1.id) > item2.current / MissionHelper.GetTargetCount(item2.id)
        else
            return item1.id < item2.id
        end
    else
        return not item1.completed and item2.completed
    end
end
this.Back = function()
    LuaMgr.Back("backPlayer")
end

this.OnAskLevelReward = function(pid,ptype)
    local askData={
        passesID=this.permitPassesId,
        id=pid,
        type=ptype,
    }
    ApiMgr.Request("passes/get_level_award",askData,true,function(result)
        local re=json.decode(result);
        local data=json.encode(re.result);
        LuaMgr.ShowItemRewared(data);
        this.SetPermitData()
        this.RefreshRed()
    end,nil,true)
end

this.PayOrder=function(data)
    if data.Length==2 then
        local reChargeId=tostring(data[0]);
        this.order=tostring(data[1]);
        if this.chargeId ~= reChargeId then return end
        if LuaMgr.GetPlatform()~="EDITOR" then return end;
        LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
        LuaMgr.AddTimer(TimerConst.FristPayRechargeStatus,this.OnTimer,1,100,true);
    end
end

this.OnTimer=function()
    local askData={order=this.order}
    ApiMgr.Request("check_recharge_status", askData, true, function(result)
        local re=json.decode(result);
        if re.result.status==2 then
            LuaMgr.RemoveTimer(TimerConst.FristPayRechargeStatus)
            local rewards=re.result.rewards;
            if rewards~=nil then
                local data=json.encode(rewards);
                LuaMgr.ShowItemRewared(data);
            end
            paying=false;
            if this.curLabel == this.labelEnum.Permit then
                this.RefreshRed()
                this.SetPermitData()
            elseif this.curLabel == this.labelEnum.Gift then
                this.SetGiftData()
            end
        end

    end, nil, true);
end

this.OnPayResult=function(data)
    if data.Length==1 then
        if this.order~=nil and this.order~=tostring(data[0]) then return end;
        paying=false;
    end
end
this.OnPaySuccess=function(data)
    if data.Length==1 then
        if  this.order~=nil and this.order~=tostring(data[0]) then return end;
        if this.curLabel == this.labelEnum.Permit then
            this.RefreshRed()
            this.SetPermitData()
        elseif this.curLabel == this.labelEnum.Gift then
            this.SetGiftData()
        end
    end
end
return vm({
    data = data,
    command = command,
    hook = hook
})