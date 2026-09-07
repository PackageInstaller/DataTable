local EffectFire = class("EffectFire", import("view.miniGame.gameView.RyzaMiniGame.effect.TargetEffect"))

function EffectFire:GetBaseOrder()
	return "floor"
end

local var_0_1 = {
	"S",
	"E",
	"N",
	"W"
}

function EffectFire:InitUI(arg_2_1)
	self.power = arg_2_1.power

	eachChild(self._tf, function(arg_3_0)
		setActive(arg_3_0, arg_3_0.name == "C")

		return
	end)

	local var_2_0 = self._tf:Find("C/Image"):GetComponent(typeof(DftAniEvent))

	var_2_0:SetTriggerEvent(function()
		self.triggerCount = defaultValue(self.triggerCount, 0) + 1

		switch(self.triggerCount, {
			function()
				local var_5_0, var_5_1, var_5_2 = self.responder:GetCrossFire(self.pos, self.power)

				for iter_5_0, iter_5_1 in ipairs(var_5_0) do
					local var_5_3 = self._tf:Find(var_0_1[iter_5_0])

					for iter_5_2 = var_5_3.childCount + 1, iter_5_1 do
						if iter_5_0 < 3 then
							cloneTplTo(var_5_3:Find("7"), var_5_3, iter_5_2):SetAsLastSibling()
						end
					end

					for iter_5_3 = 1, var_5_3.childCount do
						setActive(var_5_3:Find(iter_5_3), iter_5_3 <= iter_5_1)
					end

					setActive(var_5_3, true)
				end

				self:Calling("burn", {}, var_5_1)

				self.lenList = var_5_0

				self:Register("move", function(arg_6_0)
					self:Calling("burn", {}, arg_6_0)

					return
				end, var_5_1)

				for iter_5_4, iter_5_5 in pairs(var_5_2) do
					self:Calling("block", {
						iter_5_5[2]
					}, iter_5_5[1])
				end

				return
			end,
			function()
				self.lenList = nil

				self:Deregister("move")

				return
			end
		})

		return
	end)
	var_2_0:SetEndEvent(function()
		self:Destroy()

		return
	end)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-bomb")

	return
end

function EffectFire:GetCollideRange()
	if self.lenList then
		return {
			{
				{
					-0.5 - self.lenList[4],
					0.5 + self.lenList[2]
				},
				{
					-0.5,
					0.5
				}
			},
			{
				{
					-0.5,
					0.5
				},
				{
					-0.5 - self.lenList[3],
					0.5 + self.lenList[1]
				}
			}
		}
	else
		return {}
	end

	return
end

return EffectFire
