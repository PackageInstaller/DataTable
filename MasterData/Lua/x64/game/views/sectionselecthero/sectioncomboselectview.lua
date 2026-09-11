local SectionComboSelectView = class("SectionComboSelectView", ReduxView)

function SectionComboSelectView:UIName()
	return "Widget/System/Formation/FormationSkillPopUPUI"
end

function SectionComboSelectView:UIParent()
	return manager.ui.uiPop.transform
end

function SectionComboSelectView:Init()
	self:InitUI()
	self:AddListener()
end

function SectionComboSelectView:InitUI()
	self:BindCfgUI()

	self.skillItemList_ = {}
	self.chooseSkillHandler_ = handler(self, self.OnChooseSkill)
end

function SectionComboSelectView:GetComboSkillItemView()
	return SectionComboSelectItem
end

function SectionComboSelectView:AddListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function SectionComboSelectView:OnEnter()
	self.heroList_ = self.params_.heroList
	self.trialHeroList_ = self.params_.trailList
	self.stageType_ = self.params_.stageType
	self.stageID_ = self.params_.stageID
	self.sectionProxy_ = self.params_.targetSectionProxy
	self.customComboSkillID_ = self.params_.customComboSkillID
	self.comboSkillID_ = self.params_.customComboSkillID or self.params_.comboSkillID

	self:RefreshUI()
end

function SectionComboSelectView:RefreshUI()
	self.comboSkillIDList_ = self:GetComboSkillList()

	for iter_9_0, iter_9_1 in ipairs(self.comboSkillIDList_) do
		if not self.skillItemList_[iter_9_0] then
			self.skillItemList_[iter_9_0] = self:GetComboSkillItemView().New((Object.Instantiate(self.skillItemGo_, self.contentTrans_)))

			self.skillItemList_[iter_9_0]:RegistChooseCallback(self.chooseSkillHandler_)
		end

		self.skillItemList_[iter_9_0]:SetData(self.stageType_, self.stageID_, iter_9_1, self.comboSkillID_ == iter_9_1, self.heroList_)
	end

	for iter_9_2 = #self.comboSkillIDList_ + 1, #self.skillItemList_ do
		self.skillItemList_[iter_9_2]:Show(false)
	end
end

function SectionComboSelectView:GetComboSkillList()
	if self.comboSkillID_ == self.customComboSkillID_ then
		return {
			self.comboSkillID_
		}
	else
		return ComboSkillTools.GetComboSkillList(self.heroList_, true)
	end
end

function SectionComboSelectView:Dispose()
	for iter_11_0, iter_11_1 in ipairs(self.skillItemList_) do
		iter_11_1:Dispose()
	end

	self.skillItemList_ = nil

	SectionComboSelectView.super.Dispose(self)
end

function SectionComboSelectView:OnShowComboSkillDesc()
	FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)
	end, 1, 1):Start()
end

function SectionComboSelectView:OnChooseSkill(arg_14_1)
	self:SetComboSkillID(arg_14_1)
	manager.notify:CallUpdateFunc(COMBO_SKILL_SELECT, arg_14_1)
	manager.notify:Invoke(COMBO_SKILL_SELECT, arg_14_1)
end

function SectionComboSelectView:SetComboSkillID(arg_15_1)
	self.sectionProxy_:SetComboSkillID(arg_15_1)
end

return SectionComboSelectView
