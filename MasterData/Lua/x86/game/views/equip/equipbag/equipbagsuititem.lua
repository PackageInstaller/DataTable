local EquipBagSuitItem = class("EquipBagSuitItem", ReduxView)

function EquipBagSuitItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function EquipBagSuitItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(nil, nil, "OnClick")

	self.recommendController_ = self.transform_:GetComponent("ControllerExCollection"):GetController("recommend")
	self.selectController_ = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function EquipBagSuitItem:RefreshData(arg_3_1, arg_3_2)
	local var_3_0

	if EquipRecommendCfg[arg_3_1] then
		var_3_0 = EquipRecommendCfg[arg_3_1].suit_list or {}
	end

	self.data = arg_3_2
	self.ids = {}

	if table.indexof(var_3_0, arg_3_2) then
		self.recommendController_:SetSelectedIndex(0)
	else
		self.recommendController_:SetSelectedIndex(1)
	end

	local var_3_1 = EquipSuitCfg[arg_3_2]

	SetSpriteWithoutAtlasAsync(self.icon_, SpritePathCfg.EquipIcon_s.path .. EquipSuitCfg[arg_3_2].icon)

	self.name_.text = GetI18NText(var_3_1.name)

	table.insert(self.ids, arg_3_2)
end

function EquipBagSuitItem:RefreshPos(arg_4_1, arg_4_2)
	self.num_ = 0

	for iter_4_0, iter_4_1 in ipairs(self.ids) do
		self.num_ = self.num_ + EquipTools.GetSuitEquipNum(iter_4_1, nil, arg_4_1, arg_4_2)
	end

	self:SetBottomText()
end

function EquipBagSuitItem:SetBottomText()
	self.numText_.text = self.num_
end

function EquipBagSuitItem:Dispose()
	self.clickFunc = nil

	EquipBagSuitItem.super.Dispose(self)
end

function EquipBagSuitItem:OnClick()
	if self.clickFunc and self.num_ ~= 0 then
		self.clickFunc(self.data)
	end
end

function EquipBagSuitItem:SetSelect(arg_8_1)
	if self.num_ == 0 then
		self.selectController_:SetSelectedIndex(2)
	elseif arg_8_1 then
		self.selectController_:SetSelectedIndex(1)
	else
		self.selectController_:SetSelectedIndex(0)
	end
end

function EquipBagSuitItem:RegistCallBack(arg_9_1)
	self.clickFunc = arg_9_1
end

return EquipBagSuitItem
