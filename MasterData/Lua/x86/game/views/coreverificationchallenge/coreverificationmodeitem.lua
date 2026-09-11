local CoreVerificationModeItem = class("CoreVerificationModeItem", ReduxView)

function CoreVerificationModeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationModeItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationModeItem:InitUI()
	self:BindCfgUI()

	self.clearController_ = self.conEx_:GetController("clear")
	self.selectController_ = self.conEx_:GetController("select")
end

function CoreVerificationModeItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:CallUpdateFunc(CORE_VERIFICATION_CHALLENGE_SWITCH_MODE, self.activityId_)
	end)
end

function CoreVerificationModeItem:SetData(arg_6_1, arg_6_2)
	self:UnBindRedPoint()

	self.activityId_ = arg_6_2

	local var_6_0 = CoreVerificationChallengeTools.GetChallengeStageCfg(arg_6_2)

	if var_6_0 then
		self.img_.spriteAsync = string.format("%s%s", "TextureConfig/BossAttribute_new/", var_6_0.stage_img)
	end

	local var_6_1 = CoreVerificationChallengeTools.GetChallengeStage(arg_6_2)

	if var_6_1.max_challenge_value and var_6_1.max_challenge_value > 0 then
		self.clearController_:SetSelectedState("state1")
	else
		self.clearController_:SetSelectedState("state0")
	end

	self:BindRedPoint()
end

function CoreVerificationModeItem:SetSelect(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "state1" or "state0")
end

function CoreVerificationModeItem:BindRedPoint()
	if self.activityId_ then
		manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, self.activityId_))
	end
end

function CoreVerificationModeItem:UnBindRedPoint()
	if self.activityId_ then
		manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, self.activityId_))
	end
end

function CoreVerificationModeItem:Dispose()
	self:UnBindRedPoint()
	CoreVerificationModeItem.super.Dispose(self)
end

return CoreVerificationModeItem
