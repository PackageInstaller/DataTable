local WindowMaterialItem = class("WindowMaterialItem", import("game.extend.ReduxView"))

function WindowMaterialItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.materialType_ = arg_1_2

	self:Init()
end

function WindowMaterialItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
	self:RefreshText()
	self:InitIcon()

	self.isCanAdd_ = true
	self.isCanClick_ = false

	self:AddBtnListener(nil, nil, "OnClick")
	self:RegistEventListener(MATERIAL_MODIFY, handler(self, self.UpdateMaterial))
end

function WindowMaterialItem:UpdateMaterial(arg_3_1)
	if arg_3_1 == self.materialType_ then
		self:RefreshText()
	end
end

function WindowMaterialItem:OnClick()
	if self.isCanAdd_ or self.isCanClick_ then
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "_" .. self.class.__cname, string.format("%d", self.materialType_))
		ShowPopItem(POP_SOURCE_ITEM, {
			self.materialType_
		})
	end
end

function WindowMaterialItem:CloseOther()
	local var_5_0 = false

	for iter_5_0, iter_5_1 in ipairs((gameContext:GetAllOpenRoute())) do
		if iter_5_1 == "currencyBuyGold" or iter_5_1 == "diamondExchange" or iter_5_1 == "currencyBuyFatigue" then
			var_5_0 = true
		end
	end

	if var_5_0 then
		JumpTools.Back()
	end
end

function WindowMaterialItem:UnBindListener()
	self:RemoveAllEventListener()
end

function WindowMaterialItem:Dispose()
	self:RemoveListeners()
	self:RemoveAllListeners()
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil

	WindowMaterialItem.super.Dispose(self)
end

function WindowMaterialItem:InitUI()
	self:BindCfgUI()
end

function WindowMaterialItem:AddListeners()
	self:AddBtnListener(self.buttonIcon_, nil, function()
		manager.notify:Invoke(WINDOW_BAR_INFO, self.materialType_, self.gameObject_)
	end)
end

function WindowMaterialItem:RemoveListeners()
	return
end

function WindowMaterialItem:SetCanAdd(arg_12_1)
	if self.isCanAdd_ == arg_12_1 then
		return
	end

	self.isCanAdd_ = arg_12_1

	SetActive(self.add_, arg_12_1)
end

function WindowMaterialItem:SetCanClick(arg_13_1)
	self.isCanClick_ = arg_13_1
end

function WindowMaterialItem:SetActive(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)

	if arg_14_1 then
		self:RegistEventListener(MATERIAL_MODIFY, handler(self, self.UpdateMaterial))
		self:RefreshText()
		self.transform_:SetAsLastSibling()
	end
end

function WindowMaterialItem:RefreshText()
	self.text_.text = NumberTools.RetractNumberForWindBar(self:GetCnt())
end

function WindowMaterialItem:InitIcon()
	self.icon_.sprite = ItemTools.getItemLittleSprite(self.materialType_)
end

function WindowMaterialItem:GetCnt()
	if self.materialType_ == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
		return CommunityData:GetCurrenyA()
	end

	return ItemTools.getItemNum(self.materialType_)
end

function WindowMaterialItem:Dispose()
	WindowMaterialItem.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return WindowMaterialItem
