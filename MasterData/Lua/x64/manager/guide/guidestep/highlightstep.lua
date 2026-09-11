local HighLightStep = class("HighLightStep", ComponentStep)

function HighLightStep:Click()
	if self:Component() ~= nil then
		self:OnStepEnd()
	end
end

return HighLightStep
