local NewComboSkillInfoView = class("NewComboSkillInfoView", ReduxView)

function NewComboSkillInfoView:UIName()
	return "Widget/System/Hero_skill/HeroSkillPopUPUI"
end

function NewComboSkillInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function NewComboSkillInfoView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.comboSkillList = {}
end

function NewComboSkillInfoView:AddListeners()
	self:AddBtnListener(nil, self.backBtn_, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.viewBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("video_play_comboskill_heroskill")
		DestroyLua()

		HeroCooperationBridge.entrance = ViewConst.SYSTEM_ID.HERO_SKILL
		HeroCooperationBridge.heroId = self.heroId

		CooperateSkillBridge.Launcher()
	end)
end

function NewComboSkillInfoView:CreatComboSkill(arg_7_1)
	self.comboSkillList[arg_7_1] = NewComboSkillItem.New(arg_7_1 == 1 and self.empoweringskillGo_ or Object.Instantiate(self.empoweringskillGo_, self.contentTrs_))

	return self.comboSkillList[arg_7_1]
end

function NewComboSkillInfoView:OnEnter()
	self.heroId = self.params_.heroID

	self:UpdateSkillList()
end

function NewComboSkillInfoView:UpdateSkillList()
	self.comboSkillList_ = ComboSkillTools.GetHeroComboSkill(self.params_.heroID)

	for iter_9_0, iter_9_1 in pairs(self.comboSkillList) do
		SetActive(iter_9_1.gameObject_, false)
	end

	for iter_9_2, iter_9_3 in pairs(self.comboSkillList_) do
		local var_9_0 = self.comboSkillList[iter_9_2] or self:CreatComboSkill(iter_9_2)

		SetActive(var_9_0.gameObject_, true)
		var_9_0:RefreshUI(iter_9_3, self.heroId)
	end
end

function NewComboSkillInfoView:OnExit()
	return
end

function NewComboSkillInfoView:Dispose()
	for iter_11_0, iter_11_1 in pairs(self.comboSkillList) do
		if iter_11_1 then
			iter_11_1:Dispose()
		end
	end

	NewComboSkillInfoView.super.Dispose(self)
end

return NewComboSkillInfoView
