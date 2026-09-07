local EnemyConductor = class("EnemyConductor", import("view.miniGame.gameView.RyzaMiniGame.character.MoveEnemy"))

EnemyConductor.ConfigShildList = {
	2,
	0,
	0,
	0
}
EnemyConductor.BlockRange = 1

local var_0_1 = {
	"S",
	"E",
	"N",
	"W"
}

function EnemyConductor:InitUI(arg_1_1)
	self.shieldCount = underscore.rest(self.ConfigShildList, 1)
	self.rtShieldDic = {
		S = self.rtScale:Find("front/Shield_S"),
		E = self.rtScale:Find("front/Shield_E"),
		N = self.rtScale:Find("back/Shield_N"),
		W = self.rtScale:Find("front/Shield_W")
	}

	for iter_1_0, iter_1_1 in ipairs({
		"front",
		"back"
	}) do
		eachChild(self.rtScale:Find(iter_1_1), function(arg_2_0)
			arg_2_0:Find("Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
				setActive(arg_2_0:Find("Image"), false)
				setActive(arg_2_0, false)
				setImageAlpha(arg_2_0, 1)

				return
			end)
			arg_2_0:Find("Protect"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
				setActive(arg_2_0:Find("Protect"), false)

				if self.shieldCount[(table.indexof(var_0_1, string.split(arg_2_0.name, "_")[2]) - table.indexof(var_0_1, self.statusMark) + 4) % 4 + 1] <= 0 then
					setImageAlpha(arg_2_0, 0)
					setActive(arg_2_0:Find("Image"), true)
				end

				return
			end)

			return
		end)
	end

	EnemyConductor.super.InitUI(self, arg_1_1)

	self.hp = arg_1_1.hp or 2
	self.hpMax = self.hp
	self.speed = arg_1_1.speed or 3

	return
end

function EnemyConductor:InitRegister(arg_5_1)
	EnemyConductor.super.InitRegister(self, arg_5_1)
	self:Register("block", function(arg_6_0)
		self.shieldCount[arg_6_0] = self.shieldCount[arg_6_0] - 1

		setActive(self.rtShieldDic[var_0_1[(table.indexof(var_0_1, self.statusMark) + arg_6_0 + 2) % 4 + 1]]:Find("Protect"), true)

		return
	end, {})

	return
end

function EnemyConductor:CheckBlock(arg_7_1, arg_7_2, arg_7_3)
	if self.pos.x == arg_7_1.x and self.pos.y == arg_7_1.y then
		return
	elseif self.pos.x == arg_7_1.x and math.clamp(self.pos.y - arg_7_1.y, -arg_7_2[3], arg_7_2[1]) == self.pos.y - arg_7_1.y or self.pos.y == arg_7_1.y and math.clamp(self.pos.x - arg_7_1.x, -arg_7_2[4], arg_7_2[2]) == self.pos.x - arg_7_1.x then
		local var_7_0

		if arg_7_1.x < self.pos.x then
			var_7_0 = "W"
		elseif arg_7_1.x > self.pos.x then
			var_7_0 = "E"
		elseif arg_7_1.y < self.pos.y then
			var_7_0 = "N"
		elseif arg_7_1.y > self.pos.y then
			var_7_0 = "S"
		else
			assert(false)
		end

		local var_7_1 = (table.indexof(var_0_1, var_7_0) - table.indexof(var_0_1, self.statusMark) + 4) % 4 + 1

		if self.shieldCount[var_7_1] > 0 then
			local var_7_2 = (table.indexof(var_0_1, var_7_0) + 1) % 4 + 1

			arg_7_2[var_7_2] = math.max(math.max(math.abs(self.pos.x - arg_7_1.x), math.abs(self.pos.y - arg_7_1.y)) - self.BlockRange, 0)
			arg_7_3[var_7_2] = {
				self,
				var_7_1
			}
		end
	end

	return
end

function EnemyConductor:PlayAnim(arg_8_1)
	EnemyConductor.super.PlayAnim(self, arg_8_1)

	if self.statusMark ~= string.split(self.status, "_")[2] then
		self.statusMark = string.split(self.status, "_")[2]

		self:UpdateShieldDisplay()
	end

	return
end

function EnemyConductor:UpdateShieldDisplay()
	local var_9_0 = table.indexof(var_0_1, self.statusMark)

	for iter_9_0 = 0, 3 do
		local var_9_1 = self.rtShieldDic[var_0_1[(var_9_0 - 1 + iter_9_0) % 4 + 1]]

		eachChild(self.rtShieldDic[var_0_1[(var_9_0 - 1 + iter_9_0) % 4 + 1]], function(arg_10_0)
			setActive(arg_10_0, false)

			return
		end)
		setImageAlpha(var_9_1, 1)
		setActive(var_9_1, self.shieldCount[iter_9_0 + 1] > 0)
	end

	return
end

return EnemyConductor
