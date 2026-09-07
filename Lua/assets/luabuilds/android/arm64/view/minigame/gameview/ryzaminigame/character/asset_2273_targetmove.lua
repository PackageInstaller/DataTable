local TargetMove = class("TargetMove", import("view.miniGame.gameView.RyzaMiniGame.Reactor"))

function TargetMove:GetBaseOrder()
	return 2
end

function TargetMove:InTimeRiver()
	return true
end

function TargetMove:Init(arg_3_1)
	self.rtScale = self._tf:Find("scale")

	TargetMove.super.Init(self, arg_3_1)

	return
end

function TargetMove:UpdatePos(arg_4_1)
	self.responder:UpdatePos(self, arg_4_1)

	for iter_4_0, iter_4_1 in pairs(self.rangeDic) do
		self.responder:RemoveListener(iter_4_0, self, iter_4_1)
	end

	self:Calling("leave", {
		self
	}, {
		{
			0,
			0
		}
	})
	TargetMove.super.UpdatePos(self, arg_4_1)

	for iter_4_2, iter_4_3 in pairs(self.rangeDic) do
		self.responder:AddListener(iter_4_2, self, iter_4_3)
	end

	self:Calling("move", {
		self
	}, {
		{
			0,
			0
		}
	})

	return
end

function TargetMove:SetHide(arg_5_1)
	self.hide = arg_5_1

	self.responder:UpdateHide(self, arg_5_1)

	return
end

function TargetMove:GetSpeed()
	return self.speed
end

TargetMove.SpeedDistance = {
	[0] = 3.5,
	4,
	4.5,
	5,
	5.5,
	6,
	6.3,
	6.5
}

function TargetMove:GetSpeedDis()
	return self.SpeedDistance[self:GetSpeed()]
end

function TargetMove:TimeUpdate(arg_8_1)
	self:MoveUpdate(NewPos(0, 0))

	return
end

function TargetMove:MoveUpdate(arg_9_1)
	if arg_9_1.x == 0 and arg_9_1.y == 0 then
		return arg_9_1
	end

	self.realPos = self.realPos + arg_9_1

	self:UpdatePosition()

	local var_9_0 = self.realPos - self.pos

	for iter_9_0, iter_9_1 in ipairs({
		"x",
		"y"
	}) do
		var_9_0[iter_9_1] = math.abs(var_9_0[iter_9_1]) > 0.5 and (var_9_0[iter_9_1] < 0 and -1 or 1) or 0
	end

	if var_9_0.x ~= 0 or var_9_0.y ~= 0 then
		self:UpdatePos(self.pos + var_9_0)
	end

	return
end

local var_0_1 = {
	x = "y",
	y = "x"
}

function TargetMove:MoveDelta(arg_10_1, arg_10_2)
	if arg_10_1.x == 0 and arg_10_1.y == 0 or arg_10_2 == 0 then
		return NewPos(0, 0)
	end

	local function var_10_0(arg_11_0)
		if (arg_11_0 - self.realPos).x * (arg_11_0 - self.realPos).x < 1 and (arg_11_0 - self.realPos).y * (arg_11_0 - self.realPos).y < 1 then
			return true
		else
			return self.responder:GetCellPassability(arg_11_0)
		end

		return
	end

	local var_10_1 = {
		x = {
			0,
			0
		},
		y = {
			0,
			0
		}
	}

	for iter_10_0, iter_10_1 in ipairs({
		"x",
		"y"
	}) do
		for iter_10_2, iter_10_3 in ipairs({
			-1,
			1
		}) do
			local var_10_2 = NewPos(self.pos.x, self.pos.y)

			var_10_2[iter_10_1] = var_10_2[iter_10_1] + iter_10_3

			if var_10_0(var_10_2) then
				var_10_1[iter_10_1][iter_10_2] = var_10_1[iter_10_1][iter_10_2] + iter_10_3
			end
		end
	end

	local var_10_3 = self.realPos - self.pos
	local var_10_4 = self.realPos - self.pos + arg_10_1 * arg_10_2

	var_10_4.x = math.clamp((self.realPos - self.pos + arg_10_1 * arg_10_2).x, unpack(var_10_1.x))
	var_10_4.y = math.clamp(var_10_4.y, unpack(var_10_1.y))

	if var_10_4.x == 0 and var_10_4.y == 0 then
		return var_10_4 - var_10_3
	elseif var_10_4.x == 0 then
		var_10_4.y = math.clamp(var_10_3.y + arg_10_1.y * arg_10_2, unpack(var_10_1.y))

		return var_10_4 - var_10_3
	elseif var_10_4.y == 0 then
		var_10_4.x = math.clamp(var_10_3.x + arg_10_1.x * arg_10_2, unpack(var_10_1.x))

		return var_10_4 - var_10_3
	elseif not var_10_0((NewPos(self.pos.x + (var_10_4.x < 0 and -1 or 1), self.pos.y + (var_10_4.y < 0 and -1 or 1)))) then
		local var_10_5 = arg_10_1.y * arg_10_1.y > arg_10_1.x * arg_10_1.x and "y" or "x"
		local var_10_6 = var_0_1[arg_10_1.y * arg_10_1.y > arg_10_1.x * arg_10_1.x and "y" or "x"]
		local var_10_7 = NewPos(0, 0)

		if var_10_3[var_0_1[arg_10_1.y * arg_10_1.y > arg_10_1.x * arg_10_1.x and "y" or "x"]] * var_10_3[var_0_1[arg_10_1.y * arg_10_1.y > arg_10_1.x * arg_10_1.x and "y" or "x"]] > arg_10_2 * arg_10_2 then
			var_10_7[var_10_5] = -var_10_3[var_10_5]
			var_10_7[var_10_6] = (-var_10_3[var_10_6] < 0 and -1 or 1) * math.sqrt(arg_10_2 * arg_10_2 - var_10_7[var_10_5] * var_10_7[var_10_5])
		else
			var_10_7[var_10_6] = -var_10_3[var_10_6]
			var_10_7[var_10_5] = (arg_10_1[var_10_5] < 0 and -1 or 1) * math.sqrt(arg_10_2 * arg_10_2 - var_10_7[var_10_6] * var_10_7[var_10_6])
		end

		local var_10_8 = var_10_3 + var_10_7

		var_10_8.x = math.clamp((var_10_3 + var_10_7).x, unpack(var_10_1.x))
		var_10_8.y = math.clamp(var_10_8.y, unpack(var_10_1.y))

		return var_10_8 - var_10_3
	else
		return arg_10_1 * arg_10_2
	end

	return
end

function TargetMove:GetMoveInfo()
	local var_12_1 = NewPos(0, 0)
end

function TargetMove:GetCollideRange()
	return {
		{
			{
				-0.5,
				0.5
			},
			{
				-0.5,
				0.5
			}
		}
	}
end

TargetMove.loopDic = {}

function TargetMove:PlayAnim(arg_14_1)
	if self.status ~= arg_14_1 then
		self.status = arg_14_1

		if not self.loopDic[string.split(arg_14_1, "_")[1]] then
			self.lock = true
		end

		self.mainTarget:GetComponent(typeof(Animator)):Play(arg_14_1)
	end

	return
end

return TargetMove
