local EquipExchangeItem = class("EquipExchangeItem", ShopItemBase)

function EquipExchangeItem:Init()
	self:InitUI()
end

function EquipExchangeItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.bgController = self.controller_:GetController("bg")
	self.starController = self.controller_:GetController("star")
	self.selectController = self.controller_:GetController("sel")
end

function EquipExchangeItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self.callback(self.data, self.index, self)
	end)
end

function EquipExchangeItem:SetData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.data = arg_5_1
	self.suitData = arg_5_1[1]

	if self.suitData == nil then
		return
	end

	self.shopCfg = getShopCfg(self.suitData.id)
	self.equipCfg = EquipCfg[self.shopCfg.give_id]
	self.equipData = arg_5_4
	self.index = arg_5_2
	self.callback = arg_5_3

	self:UpdateView()
end

function EquipExchangeItem:UpdateView()
	local var_6_0, var_6_1, var_6_2 = ShopTools.GetPrice(self.suitData.id)

	self.priceText_.text = var_6_0

	local var_6_3 = self.shopCfg.cost_id

	if self.shopCfg.cost_id == 0 then
		var_6_3 = self.shopCfg.cheap_cost_id
	end

	if self.equipData ~= nil and self.equipData[1].id == self.data[1].id then
		self.selectController:SetSelectedState("true")
	else
		self.selectController:SetSelectedState("false")
	end

	self.costIcon_.sprite = ItemTools.getItemLittleSprite(var_6_3)
	self.nameText_.text = GetI18NText(EquipSuitCfg[self.equipCfg.suit].name)
	self.icon_.sprite = getSpriteViaConfig("EquipIcon_s", EquipSuitCfg[self.equipCfg.suit].icon)

	self.starController:SetSelectedState(self.equipCfg.starlevel)
	self.bgController:SetSelectedState(self.equipCfg.starlevel)
end

function EquipExchangeItem:OnEnter()
	self:UpdateView()
end

function EquipExchangeItem:OnExit()
	return
end

function EquipExchangeItem:Dispose()
	EquipExchangeItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return EquipExchangeItem
