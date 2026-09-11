local DiamondExchangeView = class("DiamondExchangeView", ReduxView)

function DiamondExchangeView:UIName()
	return "UI/DiamondExchangeUI"
end

function DiamondExchangeView:UIParent()
	return manager.ui.uiPop.transform
end

function DiamondExchangeView:OnCtor()
	self.selector_ = createStructuredSelector({
		rmb = function(arg_4_0)
			return CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RMB)
		end,
		diamond = function(arg_5_0)
			return CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
		end
	})
end

function DiamondExchangeView:InitUI()
	self.showText_ = self:FindCom("Text", "textbg/text")
	self.icon1_ = self:FindCom("Image", "panel/message/icon1")
	self.icon2_ = self:FindCom("Image", "panel/message/icon2")
	self.use_ = self:FindCom("Text", "panel/message/use")
	self.get_ = self:FindCom("Text", "panel/message/get")
	self.select_ = self:FindCom("Text", "panel/message/numbg/select")
	self.selectGo_ = self:FindGo("panel/message/numbg/select")
	self.selectInputGo_ = self:FindGo("panel/message/numbg/select_input")
	self.selectInput_ = self:FindCom("InputField", "panel/message/numbg/select_input")
end

function DiamondExchangeView:AddUIListener()
	self:AddBtnListener("bgmask", nil, function()
		self:Back()
	end)
	self:AddBtnListenerScale("btn_ok", nil, function()
		if self.model_.rmb == 0 then
			ShowMessageBox({
				content = "秘钻不足，是否前往秘钻投资商店购买？",
				title = GetTips("PROMPT"),
				OkCallback = function()
					return
				end,
				CancelCallback = function()
					return
				end
			})
		end

		if self.selectNum_ == 0 then
			return
		end

		CurrencyAction.BuyDiamond(self.selectNum_)
	end)
	self:AddBtnListenerScale("btn_cancel", nil, function()
		self:Back()
	end)
	self:AddPressingByTimeListener(self:FindGo("panel/message/numbg/add"), 3, 0.5, 0.2, function()
		if self.selectNum_ < self.model_.rmb then
			self.selectNum_ = self.selectNum_ + 1

			self:RefreshTexts()

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self:FindGo("panel/message/numbg/cut"), 3, 0.5, 0.2, function()
		if self.selectNum_ > 1 then
			self.selectNum_ = self.selectNum_ - 1

			self:RefreshTexts()

			return true
		end

		return false
	end)
	self:AddBtnListenerScale("panel/message/numbg/max", nil, function()
		self.selectNum_ = self.model_.rmb

		if self.selectNum_ <= 0 then
			self.selectNum_ = 1
		end

		self:RefreshTexts()
	end)
	self:AddBtnListener("panel/message/numbg/select", nil, function()
		self.selectInput_.text = self.selectNum_

		SetActive(self.selectInputGo_, true)
		SetActive(self.selectGo_, false)
		self.selectInput_:ActivateInputField()
	end)
	self.selectInput_.onEndEdit:AddListener(function()
		local var_17_0 = tonumber(self.selectInput_.text) or 0

		if var_17_0 > self.model_.rmb then
			var_17_0 = self.model_.rmb
		end

		if var_17_0 <= 0 then
			var_17_0 = 1
		end

		self.selectNum_ = var_17_0

		SetActive(self.selectInputGo_, false)
		SetActive(self.selectGo_, true)
		self:RefreshTexts()
	end)
end

function DiamondExchangeView:Render()
	return
end

function DiamondExchangeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DiamondExchangeView:OnEnter()
	self.model_ = self.selector_.compute(gameStore.getState())
	self.selectNum_ = 1

	self:RefreshTexts()
end

function DiamondExchangeView:RefreshTexts()
	self.use_.text = self.selectNum_
	self.get_.text = self.selectNum_
	self.select_.text = self.selectNum_
	self.showText_.text = GetI18NText(string.format("是否消耗%d个秘钻兑换%d个虹晶?", self.selectNum_, self.selectNum_))
end

function DiamondExchangeView:OnBuyDiamond(arg_22_1, arg_22_2)
	if arg_22_1.result == 0 then
		self:Back()
		ShowTips("TRANSACTION_SUCCESS")
	end
end

function DiamondExchangeView:Dispose()
	self:RemoveAllListeners()
	DiamondExchangeView.super.Dispose(self)
end

return DiamondExchangeView
