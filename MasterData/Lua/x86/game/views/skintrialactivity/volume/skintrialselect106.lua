local SkinTrialSelect106 = class("SkinTrialSelect106", SkinTrialActivitySelectView)

function SkinTrialSelect106:UIName()
	return "UI/VolumeIIIUI/VolumeSkinTrialUI_" .. self.params_.skinTrialID
end

function SkinTrialSelect106:RefreshUI()
	self:RefreshReward()
end

function SkinTrialSelect106:OnEnter()
	if self.params_.canPlayAnim == true and self.animator_ ~= nil then
		self.params_.canPlayAnim = false

		self.animator_:Play("VolumeSkinTrialUI_106_02", -1, 0)
	else
		self.animator_:Play("VolumeSkinTrialUI_106_01", -1, 0)
	end

	SkinTrialSelect106.super.OnEnter(self)

	self.skinDescText_.text = GetI18NText(SkinCfg[HeroStandardSystemCfg[ActivitySkinTrialCfg[self.skinTrialID_].trial_id].skin_id].desc)
end

return SkinTrialSelect106
