local SectionComboSelectItem = class("SectionComboSelectItem", ReduxView)

function SectionComboSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SectionComboSelectItem:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.heroItemList_) do
		iter_2_1:Dispose()
	end

	self.heroItemList_ = nil
	self.chooseCallback_ = nil

	SectionComboSelectItem.super.Dispose(self)
end

function SectionComboSelectItem:Init()
	self:InitUI()
	self:AddListener()
end

function SectionComboSelectItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerExCollection_:GetController("state")
	self.selectController_ = self.btnControllerExCollection_:GetController("select")
	self.heroItemList_ = {}
end

function SectionComboSelectItem:AddListener()
	self:AddBtnListener(self.buttonSelect_, nil, function()
		if self.comboSkillID_ ~= 0 and not self.canUse_ then
			return
		end

		self.chooseCallback_(self.comboSkillID_)
		self:Back()
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		if self.comboSkillID_ == 0 then
			return
		end

		self:SwitchDescDisplay()
	end)
end

function SectionComboSelectItem:RegistChooseCallback(arg_8_1)
	self.chooseCallback_ = arg_8_1
end

function SectionComboSelectItem:SetData(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	self:Show(true)

	self.stageType_ = arg_9_1
	self.stageID_ = arg_9_2
	self.comboSkillID_ = arg_9_3
	self.isSelect_ = arg_9_4
	self.heroList_ = arg_9_5
	self.canUse_ = self:CanUse()

	self:RefreshUI()
end

function SectionComboSelectItem:RefreshUI()
	local var_10_0 = self.comboSkillID_ == 0

	if self.comboSkillID_ ~= 0 then
		self:RefreshInfo()
	end

	self.isOpeningDesc_ = false

	self:UpdateDescVisibe()
	self.stateController_:SetSelectedState(tostring(not var_10_0))
	self:RefreshSelect()
end

function SectionComboSelectItem:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function SectionComboSelectItem:CanUse()
	if self.comboSkillID_ == 0 then
		return true
	end

	for iter_12_0, iter_12_1 in ipairs(ComboSkillCfg[self.comboSkillID_].cooperate_role_ids) do
		if not table.keyof(self.heroList_, iter_12_1) then
			return false
		end
	end

	return true
end

function SectionComboSelectItem:RefreshInfo()
	self.textLv_.text = GetTips("LEVEL") .. string.format("%s", (ComboSkillData:GetCurComboSkillLevel(self.comboSkillID_)))
	self.titleText_.text = GetI18NText(HeroSkillCfg[ComboSkillCfg[self.comboSkillID_].skill_id].name)
	self.skillIcon.sprite = getSpriteViaConfig("ComboSkill", ComboSkillCfg[self.comboSkillID_].skill_id)

	local var_13_0 = deepClone(ComboSkillCfg[self.comboSkillID_].cooperate_role_ids)

	CommonTools.UniversalSortEx(var_13_0, {
		ascend = true,
		map = function(arg_14_0)
			return arg_14_0
		end
	})

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		self.heroItemList_[iter_13_0] = self.heroItemList_[iter_13_0] or SectionSmallHeroItem.New((Object.Instantiate(self.heroItemGo_, self.heroContentTrans_)))

		self.heroItemList_[iter_13_0]:SetData(iter_13_1)
		self.heroItemList_[iter_13_0]:RefreshValid(table.keyof(self.heroList_, iter_13_1) ~= nil)
	end

	for iter_13_2 = #ComboSkillCfg[self.comboSkillID_].cooperate_role_ids + 1, 3 do
		if self.heroItemList_[iter_13_2] then
			self.heroItemList_[iter_13_2]:Show(false)
		end
	end
end

function SectionComboSelectItem:RefreshSelect()
	if self.canUse_ then
		if self.isSelect_ then
			self.selectController_:SetSelectedState("true")
		else
			self.selectController_:SetSelectedState("false")
		end
	else
		self.selectController_:SetSelectedState("none")
	end
end

function SectionComboSelectItem:UpdateDesc()
	self.descText_.text = GetI18NText(GetCfgDescription(HeroSkillCfg[ComboSkillCfg[self.comboSkillID_].skill_id].desc[1], ComboSkillData:GetCurComboSkillLevel(self.comboSkillID_), 2, ComboSkillCfg[self.comboSkillID_].maxLevel))
end

function SectionComboSelectItem:SwitchDescDisplay()
	self.isOpeningDesc_ = not self.isOpeningDesc_

	if self.isOpeningDesc_ then
		self:UpdateDesc()
	end

	self:UpdateDescVisibe()
end

function SectionComboSelectItem:UpdateDescVisibe()
	SetActive(self.descGo_, self.isOpeningDesc_)
end

return SectionComboSelectItem
