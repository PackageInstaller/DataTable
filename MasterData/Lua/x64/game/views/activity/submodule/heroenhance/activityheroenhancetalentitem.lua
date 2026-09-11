local ActivityHeroEnhanceTalentItem = class("ActivityHeroEnhanceTalentItem", ReduxView)

function ActivityHeroEnhanceTalentItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityHeroEnhanceTalentItem:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.selController_ = self.controller_:GetController("select")
	self.lockController_ = self.controller_:GetController("lock")
	self.addController_ = self.controller_:GetController("add")
	self.useController_ = self.controller_:GetController("use")
	self.effectController_ = self.controller_:GetController("effect")
	self.textNameController_ = self.controller_:GetController("textName")
end

function ActivityHeroEnhanceTalentItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.onClickHandler_ then
			self.onClickHandler_(self.talentId_)
		end
	end)
end

function ActivityHeroEnhanceTalentItem:SetMainTag(arg_5_1)
	self.mainTag_ = arg_5_1
end

function ActivityHeroEnhanceTalentItem:SetData(arg_6_1, arg_6_2)
	self.activityId_ = arg_6_1
	self.talentId_ = arg_6_2
end

function ActivityHeroEnhanceTalentItem:SetSelected(arg_7_1)
	self.selected_ = arg_7_1
end

function ActivityHeroEnhanceTalentItem:SetUsed(arg_8_1)
	self.used_ = arg_8_1
end

function ActivityHeroEnhanceTalentItem:SetLock(arg_9_1)
	self.locked_ = arg_9_1
end

function ActivityHeroEnhanceTalentItem:SetFirstAddFlag(arg_10_1)
	self.isFirstAdd_ = arg_10_1
end

function ActivityHeroEnhanceTalentItem:SetClickHandler(arg_11_1)
	self.onClickHandler_ = arg_11_1
end

local var_0_1 = {
	"Ⅰ",
	"Ⅱ",
	"Ⅲ",
	"Ⅳ",
	"Ⅴ",
	"Ⅵ",
	"Ⅶ",
	"Ⅷ",
	"Ⅸ"
}

function ActivityHeroEnhanceTalentItem:RefreshUI()
	if self.talentId_ then
		self.affixImage_.sprite = getAffixSprite({
			TalentTreeCfg[self.talentId_].affix_id
		})

		if self.affixNameText_ then
			self.affixNameText_.text = GetI18NText(TalentTreeCfg[self.talentId_].name)
		end

		if self.textNameController_ then
			self.textNameController_:SetSelectedState("true")
		end

		self.affixLevelText_.text = var_0_1[table.indexof(ActivityHeroEnhanceTools.GetCfgTalentListByStage(ActivityHeroEnhanceTools.GetCfgByTalentId(self.activityId_, self.talentId_), TalentTreeCfg[self.talentId_].stage), self.talentId_)]

		SetActive(self.affixLevelGo_, true)
		self.addController_:SetSelectedState("false")
	else
		if self.affixNameText_ then
			self.affixNameText_.text = ""
		end

		if self.textNameController_ then
			self.textNameController_:SetSelectedState("false")
		end

		SetActive(self.affixLevelGo_, false)
		self.addController_:SetSelectedState("true")
	end

	if self.effectController_ then
		if self.isFirstAdd_ then
			self.effectController_:SetSelectedState("firstAdd")
		else
			self.effectController_:SetSelectedState("none")
		end
	end

	self.selController_:SetSelectedState(self.selected_ and "true" or "false")
	self.useController_:SetSelectedState(self.used_ and "true" or "false")

	if self.locked_ then
		if self.mainTag_ and self.waitForPlayAnim_ and self.activityId_ and not getData("heroEnhanceTalentUnlock" .. self.activityId_, tostring(self.talentId_)) then
			saveData("heroEnhanceTalentUnlock" .. self.activityId_, tostring(self.talentId_), true)
			self.lockController_:SetSelectedState("true")
			FrameTimer.New(function()
				self:PlayAnim(function()
					self.lockController_:SetSelectedState("false")

					self.waitForPlayAnim_ = false
				end)
			end, 1, 1):Start()
		else
			self.lockController_:SetSelectedState(self.locked_ and "true" or "false")
		end
	else
		self.lockController_:SetSelectedState(self.locked_ and "true" or "false")
	end

	if self.isResult and not self.talentId_ then
		self.lockController_:SetSelectedState("true")
	end
end

function ActivityHeroEnhanceTalentItem:SetResult()
	self.isResult = true
end

function ActivityHeroEnhanceTalentItem:SetPlayAnim(arg_16_1, arg_16_2)
	self.waitForPlayAnim_ = arg_16_1
	self.playAnimCallback_ = arg_16_2
end

function ActivityHeroEnhanceTalentItem:PlayAnim(arg_17_1)
	self.animator_:Play("UI_jiesuo_01", 0, 0)

	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	self.aniTimer_ = Timer.New(function()
		if self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.6 then
			if self.aniTimer_ then
				self.aniTimer_:Stop()

				self.aniTimer_ = nil
			end

			if arg_17_1 then
				arg_17_1()
			end

			if self.playAnimCallback_ then
				self.playAnimCallback_()

				self.playAnimCallback_ = nil
			end

			manager.ui:UIEventEnabledByUI(true, false)
		end
	end, 0.033, -1)

	manager.ui:UIEventEnabledByUI(false, true)
	self.aniTimer_:Start()
end

function ActivityHeroEnhanceTalentItem:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	ActivityHeroEnhanceTalentItem.super.Dispose(self)
end

return ActivityHeroEnhanceTalentItem
