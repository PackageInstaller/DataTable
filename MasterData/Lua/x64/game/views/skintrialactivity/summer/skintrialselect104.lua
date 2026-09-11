local SkinTrialSelect104 = class("SkinTrialSelect104", SkinTrialActivitySelectView)

function SkinTrialSelect104:UIName()
	return "UI/VersionUI/SummerUI/SummerSkinTrialUI_" .. self.params_.skinTrialID
end

function SkinTrialSelect104:OnEnter()
	if self.params_.canPlayTimeLine == true and self.director_ ~= nil then
		self.params_.canPlayTimeLine = false
		self.director_.time = 0

		self.director_:Play()
	end

	SkinTrialSelect104.super.OnEnter(self)
end

function SkinTrialSelect104:OnExit()
	self.director_:Stop()
	SkinTrialSelect104.super.OnExit(self)
end

return SkinTrialSelect104
