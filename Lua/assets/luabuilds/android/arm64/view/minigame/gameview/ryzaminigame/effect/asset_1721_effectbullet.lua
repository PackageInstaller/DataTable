local EffectBullet = class("EffectBullet", import("view.miniGame.gameView.RyzaMiniGame.effect.TargetEffect"))

function EffectBullet:GetBaseOrder()
	if self.mark == "N" then
		return EffectBullet.super.GetBaseOrder(self)
	else
		return 500
	end

	return
end

function EffectBullet:InTimeRiver()
	return true
end

local var_0_1 = {
	S = {
		0,
		1
	},
	N = {
		0,
		-1
	},
	E = {
		1,
		0
	},
	W = {
		-1,
		0
	}
}

function EffectBullet:InitUI(arg_3_1)
	self.mark = arg_3_1.mark

	self._tf:Find("Image"):GetComponent(typeof(Animator)):Play("Bullet_" .. self.mark)

	self.dir = NewPos(unpack(var_0_1[self.mark]))

	return
end

function EffectBullet:GetSpeedDis()
	return 2
end

function EffectBullet:TimeUpdate(arg_5_1)
	local var_5_0 = self.dir * self:GetSpeedDis() * arg_5_1

	if not self.responder:InRange(self.realPos + var_5_0) then
		self:Destroy()

		return
	end

	self:MoveUpdate(var_5_0)
	self:TimeTrigger(arg_5_1)

	return
end

function EffectBullet:MoveUpdate(arg_6_1)
	if arg_6_1.x == 0 and arg_6_1.y == 0 then
		return arg_6_1
	end

	self.realPos = self.realPos + arg_6_1

	self:UpdatePosition()

	local var_6_0 = self.realPos - self.pos + arg_6_1

	if math.abs((self.realPos - self.pos + arg_6_1).x) >= 0.5 or math.abs(var_6_0.y) >= 0.5 then
		var_6_0.x = math.abs(var_6_0.x) < 0.5 and 0 or var_6_0.x < 0 and -1 or 1
		var_6_0.y = math.abs(var_6_0.y) < 0.5 and 0 or var_6_0.y < 0 and -1 or 1

		self:UpdatePos(self.pos + var_6_0)
	end

	return
end

function EffectBullet:UpdatePos(arg_7_1)
	self.responder:UpdatePos(self, arg_7_1)
	EffectBullet.super.UpdatePos(self, arg_7_1)

	return
end

function EffectBullet:TimeTrigger(arg_8_1)
	if self.responder:CollideRyza(self) then
		self:Calling("hit", {
			1,
			self.realPos
		}, MoveRyza)
		self:Destroy()
	end

	return
end

function EffectBullet:GetCollideRange()
	local var_9_0 = {
		{
			-0.1875,
			0.1875
		},
		{
			-0.1875,
			0.1875
		}
	}

	if self.dir.x < 0 then
		var_9_0[1] = {
			-0.5,
			0.25
		}
	elseif self.dir.x > 0 then
		var_9_0[1] = {
			-0.25,
			0.5
		}
	elseif self.dir.y < 0 then
		var_9_0[2] = {
			-0.5,
			0.25
		}
	elseif self.dir.y > 0 then
		var_9_0[1] = {
			-0.25,
			0.5
		}
	else
		assert(false)
	end

	return {
		var_9_0
	}
end

return EffectBullet
