local EquipSiftShopItem = class("EquipSiftShopItem", ReduxView)

function EquipSiftShopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function EquipSiftShopItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function EquipSiftShopItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controllerEx_:GetController("state")
end

function EquipSiftShopItem:AddUIListener()
	self:AddBtnListener(self.button_, nil, function()
		self.callback(self.id, self.stateController)
	end)
end

function EquipSiftShopItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.id = arg_6_1
	self.cfg = EquipSuitCfg[arg_6_1]
	self.selectTable = arg_6_2
	self.callback = arg_6_3
	self.isClickClean = arg_6_4

	self:UpdateView()
end

function EquipSiftShopItem:UpdateView()
	self.name_.text = GetI18NText(self.cfg.name)

	SetSpriteWithoutAtlasAsync(self.icon_, SpritePathCfg.EquipIcon_s.path .. self.cfg.icon)
	self.stateController:SetSelectedState(self.selectTable[self.id] and "select" or "false")

	if self.isClickClean then
		self.stateController:SetSelectedState("false")
	end
end

function EquipSiftShopItem:UpdateTimerView()
	return
end

function EquipSiftShopItem:RegistCallBack()
	return
end

function EquipSiftShopItem:OnEnter()
	return
end

function EquipSiftShopItem:OnExit()
	return
end

function EquipSiftShopItem:Dispose()
	EquipSiftShopItem.super.Dispose(self)
end

return EquipSiftShopItem
