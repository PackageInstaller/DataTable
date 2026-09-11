local NewSectionComboSkillView = class("NewSectionComboSkillView", ReduxView)

function NewSectionComboSkillView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Show(true)
	self:Init()
end

function NewSectionComboSkillView:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.heroItemList_) do
		iter_2_1:Dispose()
	end

	self.heroItemList_ = nil

	NewSectionComboSkillView.super.Dispose(self)
end

function NewSectionComboSkillView:Init()
	self:InitUI()
	self:AddListener()
end

function NewSectionComboSkillView:InitUI()
	self:BindCfgUI()
	self:InitController()
	self:InitCallback()

	self.heroItemList_ = {}
end

function NewSectionComboSkillView:InitController()
	self.activeController_ = self.controllerExCollection_:GetController("active")
	self.stateController_ = self.controllerExCollection_:GetController("state")
end

function NewSectionComboSkillView:InitCallback()
	self.selectComboSkillHandler_ = handler(self, self.OnComboSkillSelect)
end

function NewSectionComboSkillView:AddListener()
	self:AddBtnListener(self.btn_, nil, function()
		if not self.sectionProxy_.canChangeComboSkill then
			ShowTips("CANNOT_CHANGE_COMBO_SKILL")

			return
		end

		self:ClickComboSkillBtn()
	end)
end

function NewSectionComboSkillView:ClickComboSkillBtn()
	JumpTools.OpenPageByJump("sectionComboSelect", {
		stageType = self.sectionProxy_.stageType,
		stageID = self.sectionProxy_.stageID,
		heroList = self.sectionProxy_:GetHeroIDList(),
		trialList = self.sectionProxy_:GetTrialIDList(),
		customComboSkillID = self.sectionProxy_.customComboSkill,
		comboSkillID = self.comboSkillID_,
		targetSectionProxy = self.sectionProxy_
	})
end

function NewSectionComboSkillView:SetProxy(arg_10_1)
	self.sectionProxy_ = arg_10_1
end

function NewSectionComboSkillView:OnEnter()
	self:AddEventListener()
end

function NewSectionComboSkillView:AddEventListener()
	self:RegistEventListener(COMBO_SKILL_SELECT, self.selectComboSkillHandler_)
end

function NewSectionComboSkillView:OnExit()
	self:RemoveAllEventListener()
end

function NewSectionComboSkillView:Refresh()
	self.comboSkillID_ = self:GetComboSkillID()

	self:RefreshActive()

	if self.sectionProxy_.needComboSkillPanel then
		self:RefreshState()
	end
end

function NewSectionComboSkillView:GetComboSkillID()
	return self.sectionProxy_:GetComboSkillID()
end

function NewSectionComboSkillView:RefreshActive()
	self.activeController_:SetSelectedState(tostring(self.sectionProxy_.needComboSkillPanel))
end

function NewSectionComboSkillView:RefreshState()
	if self.comboSkillID_ == 0 then
		self.stateController_:SetSelectedState("unEquip")
	else
		self.stateController_:SetSelectedState("equip")
		self:RefreshEquipUI()
	end
end

function NewSectionComboSkillView:RefreshEquipUI()
	self.skillIcon_.sprite = getSpriteViaConfig("ComboSkill", ComboSkillCfg[self.comboSkillID_].skill_id)
	self.titleText_.text = HeroSkillCfg[ComboSkillCfg[self.comboSkillID_].skill_id].name

	for iter_18_0, iter_18_1 in ipairs(ComboSkillCfg[self.comboSkillID_].cooperate_role_ids) do
		self.heroItemList_[iter_18_0] = self.heroItemList_[iter_18_0] or SectionSmallHeroItem.New((Object.Instantiate(self.heroItemGo_, self.heroContentTrans_)))

		self.heroItemList_[iter_18_0]:SetData(iter_18_1)
	end

	for iter_18_2 = #ComboSkillCfg[self.comboSkillID_].cooperate_role_ids + 1, 3 do
		if self.heroItemList_[iter_18_2] then
			self.heroItemList_[iter_18_2]:Show(false)
		end
	end
end

function NewSectionComboSkillView:GetCurComboSkill()
	return self.comboSkillID_ or 0
end

function NewSectionComboSkillView:Show(arg_20_1)
	SetActive(self.gameObject_, arg_20_1)
end

function NewSectionComboSkillView:OnComboSkillSelect()
	self:Refresh()
end

return NewSectionComboSkillView
