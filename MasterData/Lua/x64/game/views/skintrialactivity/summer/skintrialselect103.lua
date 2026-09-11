local SkinTrialSelect103 = class("SkinTrialSelect103", SkinTrialActivitySelectView)

function SkinTrialSelect103:UIName()
	return "UI/VersionUI/SummerUI/SummerSkinTrialUI_" .. self.params_.skinTrialID
end

function SkinTrialSelect103:OnEnter()
	if self.params_.canPlayTimeLine == true and self.director_ ~= nil then
		self.params_.canPlayTimeLine = false
		self.director_.time = 0

		self.director_:Play()
	end

	SkinTrialSelect103.super.OnEnter(self)
end

function SkinTrialSelect103:OnExit()
	self.director_:Stop()
	SkinTrialSelect103.super.OnExit(self)
end

return SkinTrialSelect103
