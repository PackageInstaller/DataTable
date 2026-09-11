local ItemExchangeView = class("ItemExchangeView", ReduxView)

function ItemExchangeView:UIName()
	return "UI/PopUp/XH2ndRecharge"
end

function ItemExchangeView:UIParent()
	return manager.ui.uiPop.transform
end

function ItemExchangeView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.refreshVitalityHandler_ = handler(self, self.RefreshVitality)
	self.okController_ = ControllerUtil.GetController(self.okBtn_.transform, "enabled")
end

function ItemExchangeView:OnEnter()
	self.exchangeID_ = self.params_.exchangeID
	self.maxCnt_ = self.params_.maxCnt

	self:CalcMaxCnt()
	self:InitExchangeCurrency()
	self:RefreshVitality()
	self:RefreshCountdown()
	manager.notify:RegistListener(CURRENCY_UPDATE, self.refreshVitalityHandler_)
end

function ItemExchangeView:OnExit()
	self:StopTimer()
	manager.notify:RemoveListener(CURRENCY_UPDATE, self.refreshVitalityHandler_)
end

function ItemExchangeView:Dispose()
	ItemExchangeView.super.Dispose(self)

	self.refreshVitalityHandler_ = nil
end

function ItemExchangeView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		local var_9_0 = tonumber(self.cntText_.text)

		if var_9_0 > self.uiMaxCnt_ then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(ItemExchangeCfg[self.exchangeID_].cost[1][1])))

			return
		end

		CurrencyAction.ExchangeItem(self.exchangeID_, var_9_0, function(arg_10_0)
			ShowTips("EXCHANGE_SUCCESS")
			self:Back()
		end)
	end)
	self:AddBtnListener(self.addBtn_, nil, function()
		local var_11_0 = tonumber(self.cntText_.text)

		if var_11_0 + 1 <= self.uiMaxCnt_ then
			self.cntText_.text = var_11_0 + 1

			self:RefreshExchangeCurrenty()
		end
	end)
	self:AddBtnListener(self.subBtn_, nil, function()
		local var_12_0 = tonumber(self.cntText_.text)

		if var_12_0 > 1 then
			self.cntText_.text = var_12_0 - 1

			self:RefreshExchangeCurrenty()
		end
	end)
	self:AddBtnListener(self.maxBtn_, nil, function()
		self.cntText_.text = self.uiMaxCnt_ < 1 and 1 or self.uiMaxCnt_

		self:RefreshExchangeCurrenty()
	end)
end

function ItemExchangeView:CalcMaxCnt()
	self.uiMaxCnt_ = self.maxCnt_

	for iter_14_0, iter_14_1 in ipairs(ItemExchangeCfg[self.exchangeID_].cost) do
		local var_14_0 = math.floor(ItemTools.getItemNum(iter_14_1[1]) / iter_14_1[2])

		if var_14_0 < self.uiMaxCnt_ then
			self.uiMaxCnt_ = var_14_0
		end
	end
end

function ItemExchangeView:InitExchangeCurrency()
	local var_15_0 = ItemExchangeCfg[self.exchangeID_].cost[1][1]

	self.leftIconImage_.sprite = ItemTools.getItemLittleSprite(ItemExchangeCfg[self.exchangeID_].cost[1][1])
	self.leftNameText_.text = ItemTools.getItemName(var_15_0)
	self.leftCntText_.text = ItemExchangeCfg[self.exchangeID_].cost[1][2]
	self.rightIconImage_.sprite = ItemTools.getItemLittleSprite(ItemExchangeCfg[self.exchangeID_].item_id)
	self.rightNameText_.text = ItemTools.getItemName(ItemExchangeCfg[self.exchangeID_].item_id)
	self.rightCntText_.text = 1
	self.cntText_.text = 1

	SetActive(self.currentyPanel_, var_15_0 == CurrencyConst.CURRENCY_TYPE_VITALITY)
end

function ItemExchangeView:RefreshExchangeCurrenty()
	local var_16_0 = tonumber(self.cntText_.text)

	self.leftCntText_.text = var_16_0 * ItemExchangeCfg[self.exchangeID_].cost[1][2]
	self.rightCntText_.text = var_16_0
	self.subBtn_.interactable = var_16_0 > 1
	self.addBtn_.interactable = var_16_0 < self.uiMaxCnt_
	self.maxBtn_.interactable = var_16_0 < self.uiMaxCnt_
end

function ItemExchangeView:RefreshVitality()
	local var_17_0 = GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max
	local var_17_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)

	self.vitalityCntText_.text = string.format("%s/%s", var_17_1, var_17_0)

	local var_17_2 = var_17_1 < var_17_0

	SetActive(self.singleCdGo_, var_17_1 < var_17_0)
	SetActive(self.allCdGo_, var_17_2)
	self:CalcMaxCnt()
	self.okController_:SetSelectedState(tostring(self.uiMaxCnt_ > 0))
	self:RefreshExchangeCurrenty()
end

function ItemExchangeView:during()
	local var_18_0

	if CurrencyData:GetLastFatigueRecoverTime() ~= 0 or not (GameSetting.fatigue_recovery.value[1] * 60) then
		::label_18_0::

		var_18_0 = GameSetting.fatigue_recovery.value[1] * 60 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % (GameSetting.fatigue_recovery.value[1] * 60)
	end

	return var_18_0
end

function ItemExchangeView:RefreshCountdown()
	self:StopTimer()

	local var_19_0 = self:during()
	local var_19_1 = GameSetting.fatigue_recovery.value[1] * 60
	local var_19_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	local var_19_3 = GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max
	local var_19_4 = (var_19_3 - var_19_2 - 1) * (GameSetting.fatigue_recovery.value[1] * 60) + var_19_0

	self.singleCdText_.text = string.format("%02d:%02d:%02d", math.floor(var_19_0 / 3600), math.floor(var_19_0 % 3600 / 60), var_19_0 % 60)
	self.allCdText_.text = string.format("%02d:%02d:%02d", math.floor(((var_19_3 - var_19_2 - 1) * (GameSetting.fatigue_recovery.value[1] * 60) + var_19_0) / 3600), math.floor(((var_19_3 - var_19_2 - 1) * (GameSetting.fatigue_recovery.value[1] * 60) + var_19_0) % 3600 / 60), ((var_19_3 - var_19_2 - 1) * (GameSetting.fatigue_recovery.value[1] * 60) + var_19_0) % 60)
	self.timer_ = Timer.New(function()
		var_19_0 = self:during()
		var_19_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		var_19_4 = (var_19_3 - var_19_2 - 1) * var_19_1 + var_19_0
		self.singleCdText_.text = string.format("%02d:%02d:%02d", math.floor(var_19_0 / 3600), math.floor(var_19_0 % 3600 / 60), var_19_0 % 60)
		self.allCdText_.text = string.format("%02d:%02d:%02d", math.floor(var_19_4 / 3600), math.floor(var_19_4 % 3600 / 60), var_19_4 % 60)

		if var_19_0 <= 0 then
			self:StopTimer()
		end
	end, 0.2, -1)

	self.timer_:Start()
end

function ItemExchangeView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ItemExchangeView
