local EnemyNavigator = class("EnemyNavigator", import("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

EnemyNavigator.SkillDistance = 7

function EnemyNavigator:InitUI(arg_1_1)
	EnemyNavigator.super.InitUI(self, arg_1_1)

	self.hp = arg_1_1.hp or 2
	self.hpMax = self.hp
	self.speed = arg_1_1.speed or 3
	self.skillCD = 0
	self.skillDis = 0
	self.rate = arg_1_1.rate or 2

	return
end

local var_0_1 = {
	x = "y",
	y = "x"
}

function EnemyNavigator:TimeUpdate(arg_2_1)
	if self.skillDis > 0 then
		local var_2_0 = self.dir * (self:GetSpeedDis() * arg_2_1 * self.rate)
		local var_2_1 = self.realPos - self.pos
		local var_2_2

		if var_2_0.x ~= 0 then
			var_2_2 = "x"
		elseif var_2_0.y ~= 0 then
			var_2_2 = "y"
		else
			assert(false)
		end

		local var_2_4 = var_0_1[var_2_2]
		local var_2_5 = true
		local var_2_6 = {}

		local function var_2_7(arg_3_0)
			local var_3_0, var_3_1 = self.responder:GetCellPassability(arg_3_0)

			if not var_3_0 then
				if var_3_1 and isa(var_3_1, ObjectBreakable) then
					table.insert(var_2_6, var_3_1)
				else
					var_2_5 = false
				end
			end

			return
		end

		if var_2_1[var_2_2] * (var_2_1[var_2_2] + var_2_0[var_2_2]) <= 0 then
			local var_2_8 = NewPos(self.pos.x, self.pos.y)

			var_2_8[var_2_2] = var_2_8[var_2_2] + (var_2_0[var_2_2] < 0 and -1 or 1)

			var_2_7(var_2_8)

			if var_2_5 and var_2_1[var_2_4] ~= 0 then
				var_2_8[var_2_4] = var_2_8[var_2_4] + (var_2_1[var_2_4] < 0 and -1 or 1)

				var_2_7(var_2_8)
			end
		end

		if var_2_5 then
			for iter_2_0, iter_2_1 in ipairs(var_2_6) do
				self:Calling("break", {}, iter_2_1)
			end

			self.skillDis = self.skillDis - math.abs(var_2_0[var_2_2])
		end

		if not var_2_5 or self.skillDis <= 0 then
			var_2_0[var_2_2] = -var_2_1[var_2_2]
			self.skillDis = 0

			self:PlayAnim("Attack3_" .. self.assaultMark)
		end

		self:MoveUpdate(var_2_0)
		self:TimeTrigger(arg_2_1)
	else
		EnemyNavigator.super.TimeUpdate(self, arg_2_1)
	end

	return
end

local var_0_3 = {
	S = {
		0,
		1
	},
	E = {
		1,
		0
	},
	N = {
		0,
		-1
	},
	W = {
		-1,
		0
	}
}

function EnemyNavigator:TimeTrigger(arg_4_1)
	EnemyNavigator.super.TimeTrigger(self, arg_4_1)

	self.skillCD = self.skillCD - arg_4_1

	if not self.lock and self.skillCD <= 0 and self.responder:SearchRyza(self, self.search) and (self.pos.x - self.responder.reactorRyza.pos.x) * (self.pos.y - self.responder.reactorRyza.pos.y) == 0 then
		self.skillCD = 10
		self.skillDis = self.SkillDistance
		self.assaultMark = string.split(self.status, "_")[2]
		self.dir = NewPos(unpack(var_0_3[self.assaultMark]))

		self:PlayAnim("Attack1_" .. self.assaultMark)
	end

	return
end

return EnemyNavigator
