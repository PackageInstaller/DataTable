local EquipAttributeItem = class("EquipAttributeItem", ReduxView)

function EquipAttributeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function EquipAttributeItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function EquipAttributeItem:InitUI()
	self:BindCfgUI()

	self.levelText_ = {}

	for iter_3_0 = 1, 6 do
		self.levelText_[iter_3_0] = self["lv_" .. iter_3_0]
	end
end

function EquipAttributeItem:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_({
				id = self.attrID_,
				num = self.skillSum_
			})
		end
	end)
end

function EquipAttributeItem:RefreshUI(arg_6_1, arg_6_2, arg_6_3)
	self.attrID_ = arg_6_1
	self.data_ = arg_6_2
	self.isAdd_ = arg_6_3

	self:RefreshAttr()
end

function EquipAttributeItem:RefreshAttr()
	local var_7_0 = 0
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(self.data_) do
		var_7_0 = var_7_0 + iter_7_1.level
		var_7_1[iter_7_1.pos] = (var_7_1[iter_7_1.pos] or 0) + iter_7_1.level
	end

	for iter_7_2 = 1, 6 do
		if var_7_1[iter_7_2] then
			self.levelText_[iter_7_2].text = var_7_1[iter_7_2] or ""
		end
	end

	local var_7_3 = EquipSkillCfg[self.attrID_]
	local var_7_4 = var_7_0 + (self.isAdd_ and 1 or 0)

	if var_7_0 + (self.isAdd_ and 1 or 0) >= EquipSkillCfg[self.attrID_].lvmax then
		self.skillSum_ = var_7_3.lvmax or var_7_4
	end

	self.icon_.sprite = getEquipSkillSprite(self.attrID_)
	self.name_.text = GetI18NText(var_7_3.name)
	self.desc_.text = GetCfgDescriptionWithValue(var_7_3.desc[1], var_7_3.upgrade / var_7_3.percent * self.skillSum_)
	self.level_.text = self.isAdd_ and "<color=#FF9500>" .. var_7_4 .. "</color>/" .. var_7_3.lvmax or var_7_4 .. "/" .. var_7_3.lvmax
end

function EquipAttributeItem:RegistCallBack(arg_8_1)
	self.clickFunc_ = arg_8_1
end

function EquipAttributeItem:OnExit()
	return
end

function EquipAttributeItem:Dispose()
	self:RemoveAllListeners()
	EquipAttributeItem.super.Dispose(self)
end

return EquipAttributeItem
