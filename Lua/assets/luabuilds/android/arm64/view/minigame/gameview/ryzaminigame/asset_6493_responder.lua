local Responder = class("Responder")
local var_0_1 = {
	__index = function(self, arg_1_1)
		self[arg_1_1] = {}

		return self[arg_1_1]
	end
}

function Responder:Ctor(arg_2_1)
	self.binder = arg_2_1

	return
end

function Responder:reset()
	if self.map then
		for iter_3_0, iter_3_1 in pairs(self.map) do
			underscore.each(iter_3_1, function(arg_4_0)
				Destroy(arg_4_0._tf)

				return
			end)
		end
	end

	self.timeRiver = {}
	self.fireList = {}
	self.eventRange = {}
	self.map = setmetatable({}, var_0_1)
	self.findingResult = {}
	self.reactorRyza = nil
	self.enemyCount = 0

	return
end

function Responder:AddListener(arg_5_1, arg_5_2, arg_5_3)
	self.eventRange[arg_5_1] = self.eventRange[arg_5_1] or setmetatable({}, var_0_1)

	for iter_5_0, iter_5_1 in ipairs(arg_5_3) do
		table.insert(self.eventRange[arg_5_1][tostring(arg_5_2.pos + iter_5_1)], arg_5_2)
	end

	return
end

function Responder:RemoveListener(arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_3 then
		return
	end

	local var_6_0 = self.eventRange[arg_6_1]

	for iter_6_0, iter_6_1 in ipairs(arg_6_3) do
		table.removebyvalue(var_6_0[tostring(arg_6_2.pos + iter_6_1)], arg_6_2)
	end

	return
end

local var_0_2 = {
	{
		0,
		1
	},
	{
		1,
		0
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	}
}

function Responder:InRange(arg_7_1)
	if arg_7_1.x < 0 or arg_7_1.y < 0 or arg_7_1.x >= self.binder.config.mapSize.x or arg_7_1.y >= self.binder.config.mapSize.y then
		return false
	else
		return true
	end

	return
end

function Responder:GetCrossFire(arg_8_1, arg_8_2)
	local var_8_0 = {
		0,
		0,
		0,
		0
	}

	for iter_8_0, iter_8_1 in ipairs(var_0_2) do
		for iter_8_2 = 1, arg_8_2 do
			local var_8_1 = self:GetFirePassability(arg_8_1 + NewPos(unpack(iter_8_1)) * iter_8_2)

			if var_8_1 < 2 then
				var_8_0[iter_8_0] = iter_8_2
			end

			if var_8_1 > 0 then
				break
			end
		end
	end

	local var_8_2 = {}

	for iter_8_3, iter_8_4 in ipairs(self.timeRiver) do
		if isa(iter_8_4, EnemyConductor) then
			iter_8_4:CheckBlock(arg_8_1, var_8_0, var_8_2)
		end
	end

	local var_8_3 = {
		{
			0,
			0
		}
	}

	for iter_8_5, iter_8_6 in ipairs(var_0_2) do
		for iter_8_7 = 1, var_8_0[iter_8_5] do
			table.insert(var_8_3, {
				iter_8_6[1] * iter_8_7,
				iter_8_6[2] * iter_8_7
			})
		end
	end

	return var_8_0, var_8_3, var_8_2
end

function Responder:getRangeList(arg_9_1, arg_9_2)
	return underscore.map(arg_9_2, function(arg_10_0)
		return arg_9_1.pos + NewPos(unpack(arg_10_0))
	end)
end

function Responder:EventCall(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if isa(arg_11_4, Reactor) then
		if arg_11_4 == MoveRyza then
			self.reactorRyza:React(arg_11_1, arg_11_2)
		else
			arg_11_4:React(arg_11_1, arg_11_2)
		end
	else
		local var_11_0 = self.eventRange[arg_11_1]

		if not self.eventRange[arg_11_1] then
			return
		end

		for iter_11_0, iter_11_1 in ipairs(self:getRangeList(arg_11_3, arg_11_4)) do
			for iter_11_2, iter_11_3 in ipairs(underscore.rest(var_11_0[tostring(iter_11_1)], 1)) do
				iter_11_3:React(arg_11_1, arg_11_2)
			end
		end
	end

	return
end

function Responder:CreateCall(arg_12_1)
	table.insert(self.map[tostring(arg_12_1.pos)], arg_12_1)

	if arg_12_1:InTimeRiver() then
		table.insert(self.timeRiver, arg_12_1)
	end

	if isa(arg_12_1, MoveRyza) then
		self.reactorRyza = arg_12_1
	elseif isa(arg_12_1, MoveEnemy) then
		self.enemyCount = defaultValue(self.enemyCount, 0) + 1
	elseif isa(arg_12_1, EffectFire) then
		table.insert(self.fireList, arg_12_1)
	end

	return
end

function Responder:DestroyCall(arg_13_1, arg_13_2)
	table.removebyvalue(self.map[tostring(arg_13_1.pos)], arg_13_1)

	if arg_13_1:InTimeRiver() then
		table.removebyvalue(self.timeRiver, arg_13_1)
	end

	self.binder:emit(RyzaMiniGameView.EVENT_DESTROY, arg_13_1, arg_13_2)

	if isa(arg_13_1, MoveEnemy) then
		self.enemyCount = self.enemyCount - 1

		if self.enemyCount == 0 then
			self:GameFinish(true)
		end
	elseif isa(arg_13_1, EffectFire) then
		table.removebyvalue(self.fireList, arg_13_1)
	end

	return
end

function Responder:GetCellPassability(arg_14_1)
	if not self:InRange(arg_14_1) then
		return false
	end

	for iter_14_0, iter_14_1 in ipairs(self.map[tostring(arg_14_1)]) do
		if not iter_14_1:CellPassability() then
			return false, iter_14_1
		end
	end

	return true
end

function Responder:GetFirePassability(arg_15_1)
	if not self:InRange(arg_15_1) then
		return 2
	end

	return underscore.reduce(self.map[tostring(arg_15_1)], 0, function(arg_16_0, arg_16_1)
		return math.max(arg_16_0, arg_16_1:FirePassability())
	end)
end

function Responder:GetCellCanBomb(arg_17_1)
	if not self:InRange(arg_17_1) then
		return false
	end

	return underscore.all(self.map[tostring(arg_17_1)], function(arg_18_0)
		return not isa(arg_18_0, ObjectBomb)
	end)
end

function Responder:TimeFlow(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(self.timeRiver) do
		iter_19_1:TimeUpdate(arg_19_1)
	end

	return
end

function Responder:Create(arg_20_1)
	self.binder:emit(RyzaMiniGameView.EVENT_CREATE, arg_20_1)

	return
end

function Responder:GetJoyStick()
	return NewPos(self.binder.uiMgr.hrz, -self.binder.uiMgr.vtc)
end

function Responder:RyzaBomb()
	self.reactorRyza:SetBomb()

	return
end

function Responder:GameFinish(arg_23_1)
	self.binder:emit(RyzaMiniGameView.EVENT_FINISH, arg_23_1)

	return
end

function Responder:WindowFocrus(arg_24_1)
	self.binder:emit(RyzaMiniGameView.EVENT_WINDOW_FOCUS, arg_24_1)

	return
end

function Responder:SyncStatus(arg_25_1, arg_25_2, arg_25_3)
	self.binder:emit(RyzaMiniGameView.EVENT_STATUS_SYNC, arg_25_1, arg_25_2, arg_25_3)

	return
end

function Responder:UpdateHide(arg_26_1, arg_26_2)
	self.binder:emit(RyzaMiniGameView.EVENT_UPDATE_HIDE, arg_26_1, arg_26_2)

	return
end

function Responder:UpdatePos(arg_27_1, arg_27_2)
	table.removebyvalue(self.map[tostring(arg_27_1.pos)], arg_27_1)
	table.insert(self.map[tostring(arg_27_2)], arg_27_1)

	return
end

local function var_0_3(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.range) do
		for iter_28_2, iter_28_3 in ipairs(arg_28_1.range) do
			local var_28_0 = {
				{},
				{}
			}

			for iter_28_4, iter_28_5 in ipairs(iter_28_1) do
				var_28_0[iter_28_4][1] = iter_28_5[1] - iter_28_3[iter_28_4][2]
				var_28_0[iter_28_4][2] = iter_28_5[2] - iter_28_3[iter_28_4][1]
			end

			if (arg_28_1.pos - arg_28_0.pos).x > var_28_0[1][1] and (arg_28_1.pos - arg_28_0.pos).x < var_28_0[1][2] and (arg_28_1.pos - arg_28_0.pos).y > var_28_0[2][1] and (arg_28_1.pos - arg_28_0.pos).y < var_28_0[2][2] then
				return true
			end
		end
	end

	return false
end

function Responder:Wayfinding(arg_29_1)
	if self.reactorRyza.hide or self:CollideRyza(arg_29_1) then
		self.findingResult[arg_29_1] = nil

		return {
			self.realPos
		}
	elseif self.findingResult[arg_29_1] then
		if self.findingResult[arg_29_1].ryzaPos == self.reactorRyza.pos and self.findingResult[arg_29_1].reactorPos == arg_29_1.pos then
			return self.findingResult[arg_29_1].path
		else
			self.findingResult[arg_29_1] = nil
		end
	end

	local var_29_0 = {
		arg_29_1.pos
	}
	local var_29_1 = {
		[tostring(arg_29_1.pos)] = 0
	}

	local function var_29_2(arg_30_0)
		local var_30_0 = {}

		while var_29_1[tostring(var_29_0[arg_30_0])] > 0 do
			table.insert(var_30_0, var_29_0[arg_30_0])

			arg_30_0 = var_29_1[tostring(var_29_0[arg_30_0])]
		end

		self.findingResult[arg_29_1] = {
			ryzaPos = self.reactorRyza.pos,
			reactorPos = arg_29_1.pos,
			path = var_30_0
		}

		return var_30_0
	end

	local var_29_3 = 0

	while var_29_3 < #var_29_0 do
		var_29_3 = var_29_3 + 1

		for iter_29_0, iter_29_1 in ipairs(var_0_2) do
			local var_29_5 = var_29_0[var_29_3] + NewPos(unpack(iter_29_1))

			if var_29_1[tostring(var_29_5)] == nil then
				if self:GetCellPassability(var_29_5) then
					var_29_1[tostring(var_29_5)] = var_29_3

					table.insert(var_29_0, var_29_5)

					if var_0_3({
						pos = self.reactorRyza.realPos,
						range = self.reactorRyza:GetCollideRange()
					}, {
						pos = var_29_5,
						range = arg_29_1:GetCollideRange()
					}) then
						return var_29_2(#var_29_0)
					end
				else
					var_29_1[tostring(var_29_5)] = false
				end
			end
		end

		for iter_29_2, iter_29_3 in ipairs(var_0_2) do
			local var_29_6 = NewPos(unpack(iter_29_3))
			local var_29_7 = NewPos(unpack(var_0_2[iter_29_2 % 4 + 1]))

			if var_29_1[tostring(var_29_0[var_29_3] + var_29_6)] and var_29_1[tostring(var_29_0[var_29_3] + var_29_7)] and var_29_1[tostring(var_29_0[var_29_3] + var_29_6 + var_29_7)] == nil and self:GetCellPassability(var_29_0[var_29_3] + var_29_6 + var_29_7) then
				var_29_1[tostring(var_29_0[var_29_3] + var_29_6 + var_29_7)] = var_29_3

				table.insert(var_29_0, var_29_0[var_29_3] + var_29_6 + var_29_7)

				if var_0_3({
					pos = self.reactorRyza.realPos,
					range = self.reactorRyza:GetCollideRange()
				}, {
					pos = var_29_0[var_29_3] + var_29_6 + var_29_7,
					range = arg_29_1:GetCollideRange()
				}) then
					return var_29_2(#var_29_0)
				end
			end
		end
	end

	return
end

function Responder:SearchRyza(arg_31_1, arg_31_2)
	if self.reactorRyza.hide then
		return false
	else
		return ((arg_31_1.realPos or arg_31_1.pos) - self.reactorRyza.realPos):SqrMagnitude() < arg_31_2 * arg_31_2
	end

	return
end

function Responder:CollideRyza(arg_32_1)
	return var_0_3({
		pos = self.reactorRyza.realPos,
		range = self.reactorRyza:GetCollideRange()
	}, {
		pos = arg_32_1.realPos,
		range = arg_32_1:GetCollideRange()
	})
end

function Responder:CollideFire(arg_33_1)
	return underscore.filter(self.fireList, function(arg_34_0)
		return var_0_3({
			pos = arg_34_0.pos,
			range = arg_34_0:GetCollideRange()
		}, {
			pos = arg_33_1.realPos,
			range = arg_33_1:GetCollideRange()
		})
	end)
end

return Responder
