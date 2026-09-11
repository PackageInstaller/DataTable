local CivilizationSkillChooseItem = class("CivilizationSkillChooseItem", ReduxView)

function CivilizationSkillChooseItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CivilizationSkillChooseItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CivilizationSkillChooseItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.mainControllerEx_:GetController("select")
	self.cardController_ = self.mainControllerEx_:GetController("card")
	self.skillController_ = self.mainControllerEx_:GetController("bg02")
	self.newController_ = self.mainControllerEx_:GetController("new")
end

function CivilizationSkillChooseItem:AddUIListener()
	self:AddBtnListener(self.btnLook_, nil, function()
		if self.callback_ then
			self.callback_(self.skillID_)
		end
	end)
end

function CivilizationSkillChooseItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.type_ = arg_6_1
	self.skillID_ = arg_6_2
	self.callback_ = arg_6_3

	self:UpdateView()
end

function CivilizationSkillChooseItem:UpdateView()
	local var_7_0 = ActivityCivilizationFactorCfg[self.skillID_]

	if self.type_ == CivilizationGameConst.techType.TECH then
		self.cardController_:SetSelectedState("skill")

		self.skillTypeText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_2")
		self.skillTitleText_.text = var_7_0.name
		self.skillDescText_.text = var_7_0.description
		self.skillImg_.sprite = getSpriteViaConfig("CivilizationGame", var_7_0.icon)
	else
		self.cardController_:SetSelectedState("hex")

		local var_7_1 = 1

		for iter_7_0, iter_7_1 in ipairs(ActivityCivilizationHeroCfg.all) do
			var_7_1 = (table.indexof(ActivityCivilizationHeroCfg[iter_7_1].hex_skill_1, self.skillID_) or table.indexof(ActivityCivilizationHeroCfg[iter_7_1].hex_skill_2, self.skillID_) or table.indexof(ActivityCivilizationHeroCfg[iter_7_1].hex_skill_3, self.skillID_)) and iter_7_1
		end

		self.hexTypeText_.text = var_7_1 == 1 and GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_4") or GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_3")
		self.hexTitleText_.text = var_7_0.name
		self.hexDescText_.text = var_7_0.description
		self.hexImg_.sprite = getSpriteViaConfig("CivilizationGame", var_7_0.icon)
	end

	self.skillController_:SetSelectedState("state1")

	if var_7_0.associated_illustrations ~= 0 then
		self.skillController_:SetSelectedState("state2")

		self.skillIcon_.sprite = getSpriteViaConfig("CivilizationGame", ActivityCivilizationIlluCfg[var_7_0.associated_illustrations].picture)
		self.skillText_.text = ActivityCivilizationIlluCfg[var_7_0.associated_illustrations].name
	end

	local var_7_2 = ActivityCivilizationIlluCfg.get_id_list_by_target_id[self.skillID_]

	if ActivityCivilizationIlluCfg.get_id_list_by_target_id[self.skillID_] and var_7_2[1] then
		if table.indexof(CivilizationGameData:GetDataByPara("illu_list"), var_7_2[1]) then
			self.newController_:SetSelectedState("off")
		else
			self.newController_:SetSelectedState("on")
		end
	end
end

function CivilizationSkillChooseItem:GetID()
	return self.skillID_
end

function CivilizationSkillChooseItem:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function CivilizationSkillChooseItem:SetSelected(arg_10_1)
	self.selectController_:SetSelectedState(arg_10_1 and "on" or "off")
end

function CivilizationSkillChooseItem:Dispose()
	CivilizationSkillChooseItem.super.Dispose(self)
end

return CivilizationSkillChooseItem
