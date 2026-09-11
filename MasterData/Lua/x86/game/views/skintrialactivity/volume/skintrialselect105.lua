local SkinTrialSelect105 = class("SkinTrialSelect105", SkinTrialActivitySelectView)

function SkinTrialSelect105:UIName()
	return "UI/VolumeIIIUI/VolumeSkinTrialUI_" .. self.params_.skinTrialID
end

function SkinTrialSelect105:RefreshUI()
	self:RefreshReward()
end

function SkinTrialSelect105:OnEnter()
	if self.params_.canPlayAnim == true and self.animator_ ~= nil then
		self.params_.canPlayAnim = false

		self.animator_:Play("VolumeSkinTrialUI_105_02", -1, 0)
	else
		self.animator_:Play("VolumeSkinTrialUI_105_01", -1, 0)
	end

	SkinTrialSelect105.super.OnEnter(self)

	self.skinDescText_.text = GetI18NText(SkinCfg[HeroStandardSystemCfg[ActivitySkinTrialCfg[self.skinTrialID_].trial_id].skin_id].desc)
end

return SkinTrialSelect105
