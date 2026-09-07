local EffectLaser = class("EffectLaser", import("view.miniGame.gameView.RyzaMiniGame.effect.TargetEffect"))

function EffectLaser:GetBaseOrder()
	if self.mark == "N" then
		return EffectLaser.super.GetBaseOrder(self)
	else
		return 500
	end

	return
end

function EffectLaser:InitUI(arg_2_1)
	self.mark = arg_2_1.mark

	self:UpdatePos(self.pos)

	local var_2_0 = self._tf:Find("scale/" .. self.mark)

	setActive(var_2_0, true)
	var_2_0:Find("base"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:Destroy()

		return
	end)

	if self.responder:CollideRyza(self) then
		self:Calling("hit", {
			1,
			self.realPos
		}, MoveRyza)
	end

	return
end

function EffectLaser:GetCollideRange()
	local var_4_0

	switch(self.mark, {
		N = function()
			var_4_0 = {
				{
					-0.5,
					0.5
				},
				{
					-25,
					-0.5
				}
			}

			return
		end,
		S = function()
			var_4_0 = {
				{
					-0.5,
					0.5
				},
				{
					0.5,
					25
				}
			}

			return
		end,
		W = function()
			var_4_0 = {
				{
					-25,
					-0.5
				},
				{
					-0.5,
					0.5
				}
			}

			return
		end,
		E = function()
			var_4_0 = {
				{
					0.5,
					25
				},
				{
					-0.5,
					0.5
				}
			}

			return
		end
	})

	return {
		nil
	}
end

return EffectLaser
