local FishingBuyView = class("FishingBuyView", ReduxView)

function FishingBuyView:UIName()
	return "UI/Fishing/FishingBuyUI"
end

function FishingBuyView:UIParent()
	return manager.ui.uiPop.transform
end

function FishingBuyView:OnCtor()
	return
end

function FishingBuyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishingBuyView:InitUI()
	self:BindCfgUI()

	self.slider_ = LuaSlider.New(self.sliderGo_)
end

function FishingBuyView:AddUIListener()
	self.slider_:SetNumChangeHandler(function(arg_7_0)
		self:UpdateView()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.okBtn_, nil, function()
		local var_9_0 = self.slider_:GetSelectedNum()

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN) < self.cfg_.price * var_9_0 then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

			return
		end

		FishingAction.FishingBuyFish(ActivityConst.SUMMER_FISHING, self.params_.fishId, var_9_0)
	end)
end

function FishingBuyView:AddEventListeners()
	self:RegistEventListener(FISHING_BUY_SUCCESS, function()
		self:Back()
	end)
end

function FishingBuyView:UpdateView()
	self.buyNumLabel_.text = self.slider_:GetSelectedNum()
	self.useText_.text = self.cfg_.price * self.slider_:GetSelectedNum()
	self.getText_.text = self.slider_:GetSelectedNum()
	self.maxNum_ = 10000

	if self.cfg_.price ~= nil and self.cfg_.price ~= 0 then
		self.maxNum_ = math.floor(ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN) / self.cfg_.price)
	end
end

function FishingBuyView:OnTop()
	self:UpdateBar()
end

function FishingBuyView:UpdateBar()
	self:ShowDefaultBar()
end

function FishingBuyView:OnEnter()
	self:AddEventListeners()

	self.cfg_ = RareFishCfg[self.params_.fishId]
	self.icon1_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
	self.icon2_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/Fishing/RareFishIcon/%d", self.params_.fishId))
	self.useNameText_.text = ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
	self.getNameText_.text = GetI18NText(RareFishCfg[self.params_.fishId].name)

	self:UpdateView()
	self.slider_:SetData(1, self.maxNum_)
end

function FishingBuyView:OnExit()
	self:RemoveAllEventListener()

	if self.slider_ then
		self.slider_:Reset()
	end
end

function FishingBuyView:OnMainHomeViewTop()
	return
end

function FishingBuyView:Dispose()
	if self.slider_ then
		self.slider_:Dispose()

		self.slider_ = nil
	end

	FishingBuyView.super.Dispose(self)
end

return FishingBuyView
