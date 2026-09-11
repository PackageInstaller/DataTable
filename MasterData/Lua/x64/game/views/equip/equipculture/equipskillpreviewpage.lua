local EquipSkillPreviewPage = class("EquipSkillPreviewPage", ReduxView)

function EquipSkillPreviewPage:UIName()
	return "Widget/System/Hero_equip/Develop/EnchantPopUPUI"
end

function EquipSkillPreviewPage:UIParent()
	return manager.ui.uiPop.transform
end

function EquipSkillPreviewPage:Init()
	self.titleHieght_ = 75
	self.itemHeight_ = 156

	self:InitUI()
	self:AddUIListeners()
	EquipSkillPreviewPage.super.Init(self)
end

function EquipSkillPreviewPage:InitUI()
	self:BindCfgUI()

	self.enchantList_ = EquipSkillCfg.get_id_list_by_skill_type[EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT]

	self:InitPreview()

	self.attackScrollHelper_ = LuaList.New(handler(self, self.IndexAttackItem), self.skillListGo_1, EnchantSkillItem)
	self.defenceScrollHelper_ = LuaList.New(handler(self, self.IndexDefenceItem), self.skillListGo_2, EnchantSkillItem)
	self.subScrollHelper_ = LuaList.New(handler(self, self.IndexSubItem), self.skillListGo_3, EnchantSkillItem)
end

function EquipSkillPreviewPage:InitPreview()
	self.skillList_ = {
		{},
		{},
		{}
	}
	self.skillLine_ = {}

	for iter_5_0, iter_5_1 in ipairs(self.enchantList_) do
		table.insert(self.skillList_[EquipSkillCfg[iter_5_1].type], iter_5_1)
	end

	for iter_5_2, iter_5_3 in ipairs(self.skillList_) do
		self.skillLine_[iter_5_2] = math.ceil(#iter_5_3 / 2)
	end

	for iter_5_4 = 1, 3 do
		self["skillRect_" .. iter_5_4].transform:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, self.titleHieght_ + self.itemHeight_ * self.skillLine_[iter_5_4])
		self["skillListGo_" .. iter_5_4].transform:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, self.itemHeight_ * self.skillLine_[iter_5_4])
	end
end

function EquipSkillPreviewPage:IndexAttackItem(arg_6_1, arg_6_2)
	local var_6_0 = {
		id = self.skillList_[1][arg_6_1]
	}

	var_6_0.num = 1
	var_6_0.preview = true

	arg_6_2:RefreshData(var_6_0)
end

function EquipSkillPreviewPage:IndexDefenceItem(arg_7_1, arg_7_2)
	local var_7_0 = {
		id = self.skillList_[2][arg_7_1]
	}

	var_7_0.num = 1
	var_7_0.preview = true

	arg_7_2:RefreshData(var_7_0)
end

function EquipSkillPreviewPage:IndexSubItem(arg_8_1, arg_8_2)
	local var_8_0 = {
		id = self.skillList_[3][arg_8_1]
	}

	var_8_0.num = 1
	var_8_0.preview = true

	arg_8_2:RefreshData(var_8_0)
end

function EquipSkillPreviewPage:OnEnter()
	self.attackScrollHelper_:StartScroll(#self.skillList_[1])
	self.defenceScrollHelper_:StartScroll(#self.skillList_[2])
	self.subScrollHelper_:StartScroll(#self.skillList_[3])
end

function EquipSkillPreviewPage:AddUIListeners()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:Back()
	end)
end

function EquipSkillPreviewPage:Dispose()
	self:RemoveAllListeners()
	self.attackScrollHelper_:Dispose()
	self.defenceScrollHelper_:Dispose()
	self.subScrollHelper_:Dispose()
	EquipSkillPreviewPage.super.Dispose(self)
end

return EquipSkillPreviewPage
