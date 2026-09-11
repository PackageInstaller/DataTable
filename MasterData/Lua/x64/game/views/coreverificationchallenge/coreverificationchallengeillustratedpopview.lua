local CoreVerificationChallengeIllustratedPopView = class("CoreVerificationChallengeIllustratedPopView", ReduxView)

function CoreVerificationChallengeIllustratedPopView:UIName()
	return "Widget/System/Core_verification_new/Core_verification_BadgePopUI"
end

function CoreVerificationChallengeIllustratedPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CoreVerificationChallengeIllustratedPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationChallengeIllustratedPopView:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controller_:GetController("default0")
	self.showLvController_ = self.lvController_:GetController("showLv")
end

function CoreVerificationChallengeIllustratedPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("challenge_attribute_achie_hide")
		self:Back()
	end)
	self:AddBtnListener(self.lvBtn_1, nil, function()
		if self.bagdeCfg.level > 0 then
			self.bagdeCfg = CoreVerificationChallengeTools.GetIllustratedInfoByLevel(1, self.bagdeCfg.set_id)

			self:RefreshView()
			self.stateController_:SetSelectedIndex(0)
		end
	end)
	self:AddBtnListener(self.lvBtn_2, nil, function()
		if self.bagdeCfg.level > 0 then
			self.bagdeCfg = CoreVerificationChallengeTools.GetIllustratedInfoByLevel(2, self.bagdeCfg.set_id)

			self:RefreshView()
			self.stateController_:SetSelectedIndex(1)
		end
	end)
end

function CoreVerificationChallengeIllustratedPopView:OnEnter()
	self.bagdeCfg = self.params_.bagdeCfg
	self.cfg = self.params_.cfg
	self.params_.cfg = nil

	if self.bagdeCfg.level == 0 then
		self.showLvController_:SetSelectedIndex(0)
	elseif self.bagdeCfg.level == 1 then
		self.showLvController_:SetSelectedIndex(1)
		self.stateController_:SetSelectedIndex(0)
	else
		self.showLvController_:SetSelectedIndex(1)
		self.stateController_:SetSelectedIndex(1)
	end

	self:RefreshView()
end

function CoreVerificationChallengeIllustratedPopView:RefreshView()
	self.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", self.bagdeCfg.id))
	self.name_.text = self.bagdeCfg.name

	if ConditionCfg[self.bagdeCfg.unlock_condition].type == 11304 then
		self.condition_.text = string.format(GetI18NText(ConditionCfg[self.bagdeCfg.unlock_condition].desc), GetI18NText(CoreVerificationChallengeTools.GetModeCfgBySetId(self.bagdeCfg.set_id)[ConditionCfg[self.bagdeCfg.unlock_condition].params[1]].stage_name))
	elseif ConditionCfg[self.bagdeCfg.unlock_condition].type == 11305 then
		self.condition_.text = string.format(GetI18NText(ConditionCfg[self.bagdeCfg.unlock_condition].desc), GetI18NText(CoreVerificationChallengeTools.GetModeCfgBySetId(self.bagdeCfg.set_id)[ConditionCfg[self.bagdeCfg.unlock_condition].params[1]].stage_name), ConditionCfg[self.bagdeCfg.unlock_condition].params[2])
	elseif ConditionCfg[self.bagdeCfg.unlock_condition].type == 11306 then
		self.condition_.text = string.format(GetI18NText(ConditionCfg[self.bagdeCfg.unlock_condition].desc), GetI18NText(CoreVerificationChallengeTools.GetModeCfgBySetId(self.bagdeCfg.set_id)[ConditionCfg[self.bagdeCfg.unlock_condition].params[2]].stage_name))
	elseif ConditionCfg[self.bagdeCfg.unlock_condition].type == 11307 then
		self.condition_.text = string.format(GetI18NText(ConditionCfg[self.bagdeCfg.unlock_condition].desc), GetI18NText(CoreVerificationChallengeTools.GetModeCfgBySetId(self.bagdeCfg.set_id)[ConditionCfg[self.bagdeCfg.unlock_condition].params[1]].stage_name), ConditionCfg[self.bagdeCfg.unlock_condition].params[2])
	end

	if CoreVerificationChallengeData:IsUnlockIllustratedById(self.bagdeCfg.id) then
		self.time_.text = GetTips("COMPLETE_TIMES") .. manager.time:DescCTime(CoreVerificationChallengeData:GetIllustratedById(self.bagdeCfg.id).time, "!%Y.%m.%d")
		self.desc_.text = self.bagdeCfg.desc
	else
		self.time_.text = " "
		self.desc_.text = " "
	end
end

function CoreVerificationChallengeIllustratedPopView:OnExit()
	return
end

function CoreVerificationChallengeIllustratedPopView:Dispose()
	CoreVerificationChallengeIllustratedPopView.super.Dispose(self)
end

return CoreVerificationChallengeIllustratedPopView
