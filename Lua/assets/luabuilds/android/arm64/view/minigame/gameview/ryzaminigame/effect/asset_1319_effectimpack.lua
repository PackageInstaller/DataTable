local EffectImpack = class("EffectImpack", import("view.miniGame.gameView.RyzaMiniGame.effect.TargetEffect"))

function EffectImpack:InitUI(arg_1_1)
	self._tf:Find("Lockon"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(self._tf:Find("Lockon"), false)
		setActive(self._tf:Find("impack"), true)

		return
	end)

	local var_1_0 = self._tf:Find("impack"):GetComponent(typeof(DftAniEvent))

	var_1_0:GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		if self.responder:CollideRyza(self) then
			self:Calling("hit", {
				1,
				self.realPos
			}, MoveRyza)
		end

		return
	end)
	var_1_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:Destroy()

		return
	end)

	return
end

return EffectImpack
