local ReversePacmanRoleControl = class("ReversePacmanRoleControl")
local var_0_1 = 0.12
local var_0_2 = 0.05
local var_0_3 = 1
local var_0_4 = 0.15
local var_0_5 = 1.4
local var_0_6 = 0.9
local var_0_7 = 0.2
local var_0_8 = 0.04
local var_0_9 = 1
local var_0_10 = 1

function ReversePacmanRoleControl:Ctor(arg_1_1, arg_1_2)
	self.binder = arg_1_1
	self._tf = arg_1_2
	self._tpls = self._tf:Find("tpls")
	self.container = self._tf:Find("map/roles")

	return
end

function ReversePacmanRoleControl:SetUp(arg_2_1, arg_2_2, arg_2_3)
	self.shipIds = arg_2_1
	self.map = arg_2_2
	self.gameEnded = false
	self.gameTime = 0
	self.graphVersion = 0
	self.monsterVersion = 0
	self.shipMoveVersion = 0
	self.monsterMoveVersion = 0
	self.nearestTargetCache = {}
	self.monsterThreatFieldCache = nil
	self.shipTriggerStates = {}
	self.aliveMonsterCacheVersion = -1
	self.aliveMonsterCache = nil
	self.lastShipPerformanceEmitTime = nil
	self.eduBuffCnt = arg_2_3
	self.eduBuffMul = math.pow(tonumber(pg.activity_chasing_skill[ReversePacmanConst.BUFF_EDU].param), self.eduBuffCnt)
	self.ships = {}

	for iter_2_0, iter_2_1 in ipairs(self.map:GetDeployPoints()) do
		if self.shipIds[iter_2_0] and self.shipIds[iter_2_0] ~= 0 then
			local var_2_0 = cloneTplTo(self._tpls:Find("ship"), self.container, "ship_" .. iter_2_0 .. "_" .. self.shipIds[iter_2_0])

			setLocalPosition(var_2_0, self.map:GetLocalPosInMap(iter_2_1.x, iter_2_1.y))
			table.insert(self.ships, (ReversePacmanRole.New(self.binder, var_2_0, {
				type = ReversePacmanConst.ROLE.SHIP,
				id = self.shipIds[iter_2_0],
				nodeId = self.map:GetNodeIdByPos(iter_2_1.x, iter_2_1.y),
				eduBuffMul = self.eduBuffMul
			})))
		end
	end

	self.monsters = {}

	for iter_2_2, iter_2_3 in ipairs(self.map:GetSpawnPoints()) do
		local var_2_1 = cloneTplTo(self._tpls:Find("monster"), self.container, "monister_" .. iter_2_2 .. "_" .. iter_2_3.monsterConfigId)

		setLocalPosition(var_2_1, self.map:GetLocalPosInMap(iter_2_3.x, iter_2_3.y))
		table.insert(self.monsters, (ReversePacmanRole.New(self.binder, var_2_1, {
			type = ReversePacmanConst.ROLE.MONSTER,
			id = iter_2_3.monsterConfigId,
			nodeId = self.map:GetNodeIdByPos(iter_2_3.x, iter_2_3.y)
		})))
	end

	if not self._graphChangedListenerAdded then
		self._graphChangedListenerAdded = true

		self.binder:bind(ReversePacmanConst.EVENT.GRAPH_CHANGED, function()
			self.graphVersion = (self.graphVersion or 0) + 1
			self.aliveMonsterCacheVersion = -1
			self.aliveMonsterCache = nil
			self.monsterThreatFieldCache = nil

			for iter_3_0, iter_3_1 in ipairs(self.ships) do
				iter_3_1:RequestReplan()
			end

			for iter_3_2, iter_3_3 in ipairs(self.monsters) do
				iter_3_3:RequestReplan()
			end

			return
		end)
	end

	return
end

function ReversePacmanRoleControl:SetGameEnded(arg_4_1)
	self.gameEnded = not not arg_4_1

	return
end

function ReversePacmanRoleControl:GetShipTriggerState(arg_5_1)
	self.shipTriggerStates = self.shipTriggerStates or {}
	self.shipTriggerStates[arg_5_1] = self.shipTriggerStates[arg_5_1] or {}

	return self.shipTriggerStates[arg_5_1]
end

function ReversePacmanRoleControl:GetAliveMonsters()
	if self.aliveMonsterCacheVersion == self.monsterVersion and self.aliveMonsterCache then
		return self.aliveMonsterCache
	end

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(self.monsters) do
		if iter_6_1:IsAlive() then
			var_6_0[#var_6_0 + 1] = iter_6_1
		end
	end

	self.aliveMonsterCacheVersion = self.monsterVersion
	self.aliveMonsterCache = var_6_0

	return var_6_0
end

function ReversePacmanRoleControl:FindNearestTarget(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	if self.nearestTargetCache[arg_7_1] and self.nearestTargetCache[arg_7_1].nodeId == arg_7_1.nodeId and self.nearestTargetCache[arg_7_1].graphVersion == (arg_7_3 or 0) and self.nearestTargetCache[arg_7_1].targetMoveVersion == (arg_7_4 or 0) and self.nearestTargetCache[arg_7_1].targetDeathVersion == (arg_7_5 or 0) and self.nearestTargetCache[arg_7_1].target and self.nearestTargetCache[arg_7_1].target:IsAlive() and self.nearestTargetCache[arg_7_1].target.nodeId then
		return self.nearestTargetCache[arg_7_1].target
	end

	local var_7_0 = self.map and self.map:GetRouteGraph()

	if not var_7_0 then
		return nil
	end

	local var_7_1 = var_7_0:GetDistanceField(arg_7_1.nodeId)
	local var_7_2
	local var_7_3

	for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
		if iter_7_1:IsAlive() then
			if iter_7_1.nodeId then
				if var_7_1[iter_7_1.nodeId] and (not var_7_3 or var_7_1[iter_7_1.nodeId] < var_7_3) then
					var_7_3 = var_7_1[iter_7_1.nodeId]
					var_7_2 = iter_7_1
				end
			end
		end
	end

	self.nearestTargetCache[arg_7_1] = {
		nodeId = arg_7_1.nodeId,
		graphVersion = arg_7_3 or 0,
		targetMoveVersion = arg_7_4 or 0,
		targetDeathVersion = arg_7_5 or 0,
		target = var_7_2
	}

	return var_7_2
end

function ReversePacmanRoleControl:Update(arg_8_1)
	if not self.map or self.gameEnded then
		return
	end

	self.gameTime = (self.gameTime or 0) + arg_8_1

	local var_8_0 = self:GetAliveMonsters()
	local var_8_1 = self.map:GetCanPickBuffs()

	for iter_8_0, iter_8_1 in ipairs(self.monsters) do
		if self.gameEnded then
			return
		end

		if iter_8_1:IsAlive() then
			iter_8_1:Update(arg_8_1)

			local var_8_2 = iter_8_1.nodeId

			if iter_8_1:NeedResetPath() or self:IsMonsterNextStepClaimed(iter_8_1) then
				iter_8_1:SetPath((self:GetScoreMaxPath(iter_8_1)))
			end

			iter_8_1:MoveAlongPath(arg_8_1, self.map)

			if iter_8_1.nodeId ~= var_8_2 then
				self.monsterMoveVersion = (self.monsterMoveVersion or 0) + 1
			end
		end
	end

	for iter_8_2, iter_8_3 in ipairs(self.ships) do
		if self.gameEnded then
			return
		end

		if iter_8_3:IsAlive() then
			iter_8_3:Update(arg_8_1)

			if iter_8_3:NeedResetPath() then
				local var_8_4 = self:FindNearestTarget(iter_8_3, var_8_0, self.graphVersion, self.monsterMoveVersion, self.monsterVersion)

				if var_8_4 then
					iter_8_3:SetPath((self:GetScoreMaxPath(iter_8_3, var_8_4)))
				end
			end

			iter_8_3:MoveAlongPath(arg_8_1, self.map)

			if iter_8_3.nodeId ~= iter_8_3.nodeId then
				self.shipMoveVersion = (self.shipMoveVersion or 0) + 1
			end

			if self.gameEnded then
				return
			end

			self:UpdateShipPerformanceTriggers(iter_8_3, var_8_0)

			if self.gameEnded then
				return
			end

			for iter_8_4, iter_8_5 in ipairs(var_8_0) do
				if self.gameEnded then
					return
				end

				if iter_8_5:IsAlive() and self:IsCatchable(iter_8_3, iter_8_5) then
					iter_8_5:Kill()

					self.monsterVersion = (self.monsterVersion or 0) + 1
					self.aliveMonsterCacheVersion = -1
					self.aliveMonsterCache = nil

					self:EmitShipPerformance(iter_8_3, iter_8_5, ReversePacmanConst.SHIP_PERFORMANCE_TYPE.CAPTURE)
					self.binder:emit(ReversePacmanConst.EVENT.CAPTURE, {
						ship = iter_8_3,
						monster = iter_8_5
					})

					if self.gameEnded then
						return
					end
				end
			end

			for iter_8_6, iter_8_7 in ipairs(var_8_1) do
				if self.gameEnded then
					return
				end

				if self:IsPickBuff(iter_8_3, iter_8_7) then
					iter_8_3:AddBuff(iter_8_7.id)
					self.binder:emit(ReversePacmanConst.EVENT.PICK, {
						ship = iter_8_3,
						buff = iter_8_7
					})

					if self.gameEnded then
						return
					end
				end
			end
		end
	end

	return
end

function ReversePacmanRoleControl:UpdateShipPerformanceTriggers(arg_9_1, arg_9_2)
	local var_9_0 = self:GetShipTriggerState(arg_9_1)
	local var_9_1
	local var_9_2

	if var_9_0.cachedPerformanceTarget and var_9_0.cachedPerformanceTarget.nodeId == arg_9_1.nodeId and var_9_0.cachedPerformanceTarget.pathIndex == arg_9_1.pathIndex and var_9_0.cachedPerformanceTarget.graphVersion == self.graphVersion and var_9_0.cachedPerformanceTarget.monsterMoveVersion == self.monsterMoveVersion and var_9_0.cachedPerformanceTarget.monsterDeathVersion == self.monsterVersion and var_9_0.cachedPerformanceTarget.target and var_9_0.cachedPerformanceTarget.target:IsAlive() then
		var_9_1 = var_9_0.cachedPerformanceTarget.target
		var_9_2 = var_9_0.cachedPerformanceTarget.dist
	else
		var_9_1, var_9_2 = self:FindNearestAliveMonsterByDistance(arg_9_1, arg_9_2)
	end

	if not var_9_1 then
		var_9_0.nearMonster = nil
		var_9_0.farMonster = nil

		return
	end

	if var_9_2 <= arg_9_1:GetPerformanceRange(ReversePacmanConst.SHIP_PERFORMANCE_TYPE.NEAR) then
		if var_9_0.nearMonster ~= var_9_1 then
			var_9_0.nearMonster = var_9_1

			if self:CanEmitShipPerformance(var_9_0, ReversePacmanConst.SHIP_PERFORMANCE_TYPE.NEAR) then
				var_9_0.lastEmitTime = var_9_0.lastEmitTime or {}
				var_9_0.lastEmitTime[ReversePacmanConst.SHIP_PERFORMANCE_TYPE.NEAR] = self.gameTime

				self:EmitShipPerformance(arg_9_1, var_9_1, ReversePacmanConst.SHIP_PERFORMANCE_TYPE.NEAR)
			end
		end
	else
		var_9_0.nearMonster = nil
	end

	if var_9_2 >= arg_9_1:GetPerformanceRange(ReversePacmanConst.SHIP_PERFORMANCE_TYPE.FAR) then
		if var_9_0.farMonster ~= var_9_1 then
			var_9_0.farMonster = var_9_1

			if self:CanEmitShipPerformance(var_9_0, ReversePacmanConst.SHIP_PERFORMANCE_TYPE.FAR) then
				var_9_0.lastEmitTime = var_9_0.lastEmitTime or {}
				var_9_0.lastEmitTime[ReversePacmanConst.SHIP_PERFORMANCE_TYPE.FAR] = self.gameTime

				self:EmitShipPerformance(arg_9_1, var_9_1, ReversePacmanConst.SHIP_PERFORMANCE_TYPE.FAR)
			end
		end
	else
		var_9_0.farMonster = nil
	end

	var_9_0.cachedPerformanceTarget = {
		nodeId = arg_9_1.nodeId,
		pathIndex = arg_9_1.pathIndex,
		graphVersion = self.graphVersion,
		monsterMoveVersion = self.monsterMoveVersion,
		monsterDeathVersion = self.monsterVersion,
		target = var_9_1,
		dist = var_9_2
	}

	return
end

function ReversePacmanRoleControl:CanEmitShipPerformance(arg_10_1, arg_10_2)
	arg_10_1.lastEmitTime = arg_10_1.lastEmitTime or {}

	local var_10_0 = self.lastShipPerformanceEmitTime

	if not arg_10_1.lastEmitTime[arg_10_2] then
		return not var_10_0 or self.gameTime - var_10_0 >= ReversePacmanConst.SHIP_PERFORMANCE_GLOBAL_COOLDOWN
	end

	if self.gameTime - arg_10_1.lastEmitTime[arg_10_2] < ReversePacmanConst.SHIP_PERFORMANCE_COOLDOWN then
		return false
	end

	return not var_10_0 or self.gameTime - var_10_0 >= ReversePacmanConst.SHIP_PERFORMANCE_GLOBAL_COOLDOWN
end

function ReversePacmanRoleControl:FindNearestAliveMonsterByDistance(arg_11_1, arg_11_2)
	local var_11_0
	local var_11_1

	for iter_11_0, iter_11_1 in ipairs(arg_11_2 or self.monsters) do
		if iter_11_1:IsAlive() then
			local var_11_2 = self:GetDistance(arg_11_1, iter_11_1)

			if not var_11_1 or var_11_2 < var_11_1 then
				var_11_1 = var_11_2
				var_11_0 = iter_11_1
			end
		end
	end

	return var_11_0, var_11_1
end

function ReversePacmanRoleControl:EmitShipPerformance(arg_12_1, arg_12_2, arg_12_3)
	self.lastShipPerformanceEmitTime = self.gameTime

	local var_12_0 = ReversePacmanConst.EVENT.SHIP_PERFORMANCE
	local var_12_1 = {
		type = arg_12_3,
		ship = arg_12_1,
		monster = arg_12_2,
		shipId = arg_12_1.id
	}

	if arg_12_2 then
		var_12_1.monsterId = arg_12_2.id or nil
	end

	var_12_1.distance = arg_12_2 and self:GetDistance(arg_12_1, arg_12_2) or nil

	self.binder:emit(var_12_0, var_12_1)

	return
end

function ReversePacmanRoleControl:CheckGameEnd()
	local var_13_0 = self.map

	if self.map then
		var_13_0 = self.map:GetRouteGraph()
	end

	return underscore.all(self.monsters, function(arg_14_0)
		return not arg_14_0:IsAlive() or self:IsMonsterTrapped(arg_14_0, var_13_0)
	end)
end

function ReversePacmanRoleControl:GetAliveMonsterCnt()
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(self.monsters) do
		if iter_15_1:IsAlive() then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function ReversePacmanRoleControl:GetCapturedMonsterCnt()
	return #self.monsters - self:GetAliveMonsterCnt()
end

function ReversePacmanRoleControl:GetMonsterCnt()
	return #self.monsters
end

function ReversePacmanRoleControl:GetShipCnt()
	return #self.ships
end

function ReversePacmanRoleControl:GetAliveShipCnt()
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(self.ships) do
		if iter_19_1:IsAlive() then
			var_19_0 = var_19_0 + 1
		end
	end

	return var_19_0
end

function ReversePacmanRoleControl:IsCellOccupied(arg_20_1)
	local var_20_0 = self.map:GetNodeIdByPos(arg_20_1.x, arg_20_1.y)

	if not var_20_0 then
		return false
	end

	return self:IsNodeOccupied(var_20_0)
end

function ReversePacmanRoleControl:IsNodeOccupied(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(self.ships) do
		if iter_21_1:IsAlive() and iter_21_1:IsOccupyingNode(arg_21_1) then
			return true
		end
	end

	for iter_21_2, iter_21_3 in ipairs(self.monsters) do
		if iter_21_3:IsAlive() and iter_21_3:IsOccupyingNode(arg_21_1) then
			return true
		end
	end

	return false
end

function ReversePacmanRoleControl:CheckAllMonstersTrapped()
	local var_22_0 = self.map and self.map:GetRouteGraph()

	if not var_22_0 or self:GetAliveMonsterCnt() <= 0 or self:GetAliveShipCnt() <= 0 then
		return false
	end

	for iter_22_0, iter_22_1 in ipairs(self.monsters) do
		if iter_22_1:IsAlive() and not self:IsMonsterTrapped(iter_22_1, var_22_0) then
			return false
		end
	end

	return true
end

function ReversePacmanRoleControl:IsMonsterTrapped(arg_23_1, arg_23_2)
	if not arg_23_1 or not arg_23_1.nodeId or not arg_23_2 then
		return false
	end

	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(self.ships) do
		if iter_23_1:IsAlive() and iter_23_1.nodeId then
			var_23_0[iter_23_1.nodeId] = true
		end
	end

	local var_23_1 = {}
	local var_23_2 = {
		arg_23_1.nodeId
	}
	local var_23_3 = 1

	var_23_1[arg_23_1.nodeId] = true

	local var_23_4 = 0

	while var_23_2[var_23_3] do
		var_23_3 = var_23_3 + 1
		var_23_4 = var_23_4 + 1

		if var_23_0[var_23_2[var_23_3]] then
			return false
		end

		for iter_23_2, iter_23_3 in ipairs(arg_23_2:GetNeighbors(var_23_2[var_23_3])) do
			if not var_23_1[iter_23_3] then
				var_23_1[iter_23_3] = true
				var_23_2[#var_23_2 + 1] = iter_23_3
			end
		end
	end

	local var_23_5 = arg_23_2.nodes
	local var_23_6

	if not arg_23_2.nodes then
		var_23_5 = {}
		var_23_6 = ReversePacmanConst.MONSTER_TRAP_MIN_COMPONENT_NODES
	end

	return var_23_4 <= math.max(var_23_6, math.ceil(#var_23_5 * ReversePacmanConst.MONSTER_TRAP_COMPONENT_RATIO))
end

function ReversePacmanRoleControl:GetScoreMaxPath(arg_24_1, arg_24_2)
	local var_24_0 = self.map:GetRouteGraph()

	if not var_24_0 or not arg_24_1 or not arg_24_1.nodeId then
		return {
			arg_24_1 and arg_24_1.nodeId
		}
	end

	local var_24_1 = var_24_0:GetNodeById(arg_24_1.nodeId)

	if not var_24_1 then
		return {
			arg_24_1.nodeId
		}
	end

	if self:IsEscapeMode(arg_24_1) then
		return self:BuildEscapePath(var_24_0, arg_24_1.nodeId, arg_24_1) or {
			arg_24_1.nodeId
		}
	end

	if not arg_24_2 or not arg_24_2.nodeId then
		return {
			arg_24_1.nodeId
		}
	end

	local var_24_2 = var_24_0:GetNodeById(arg_24_2.nodeId)

	if not var_24_2 then
		return {
			arg_24_1.nodeId
		}
	end

	local var_24_3 = arg_24_1._prevNodeId
	local var_24_4 = {}

	for iter_24_0, iter_24_1 in ipairs(var_24_1.neighbors) do
		if iter_24_1 ~= var_24_3 then
			var_24_4[#var_24_4 + 1] = iter_24_1
		end
	end

	if #var_24_4 == 0 then
		var_24_4 = var_24_1.neighbors
	end

	local var_24_5

	for iter_24_2, iter_24_3 in ipairs(var_24_4) do
		local var_24_6, var_24_7 = self:GetScore(iter_24_3, arg_24_1, arg_24_2, var_24_0)

		if -math.huge < var_24_6 - var_24_7 then
			var_24_5 = iter_24_3
		end
	end

	if not var_24_5 then
		return {
			arg_24_1.nodeId
		}
	end

	return var_24_0:FindPath(var_24_5, var_24_2.id) or {
		arg_24_1.nodeId
	}
end

function ReversePacmanRoleControl:IsEscapeMode(arg_25_1)
	return (arg_25_1:GetConfig("ai_target_weight") or 0) < 0
end

local function var_0_11(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if not arg_26_2 or arg_26_1[arg_26_2] or not arg_26_3:GetNodeById(arg_26_2) or arg_26_3:IsBuffBlockById(arg_26_2) then
		return
	end

	arg_26_1[arg_26_2] = true
	arg_26_0[#arg_26_0 + 1] = arg_26_2

	return
end

function ReversePacmanRoleControl:GetMonsterThreatDistanceField(arg_27_1)
	local var_27_0 = {}
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(self.ships) do
		if iter_27_1:IsAlive() then
			var_0_11(var_27_0, var_27_1, iter_27_1.nodeId, arg_27_1)
			var_0_11(var_27_0, var_27_1, iter_27_1.path and iter_27_1.path[iter_27_1.pathIndex], arg_27_1)
		end
	end

	local var_27_2 = (self.graphVersion or 0) .. ":" .. table.concat(var_27_0, ",")

	if self.monsterThreatFieldCache and self.monsterThreatFieldCache.signature == var_27_2 then
		return self.monsterThreatFieldCache.dist
	end

	local var_27_3 = {}
	local var_27_4 = {}

	for iter_27_2, iter_27_3 in ipairs(var_27_0) do
		var_27_3[iter_27_3] = 0
		var_27_4[#var_27_4 + 1] = iter_27_3
	end

	local var_27_5 = 1

	while var_27_4[var_27_5] do
		var_27_5 = var_27_5 + 1

		for iter_27_4, iter_27_5 in ipairs(arg_27_1:GetNeighbors(var_27_4[var_27_5])) do
			if var_27_3[iter_27_5] == nil then
				var_27_3[iter_27_5] = var_27_3[var_27_4[var_27_5]] + 1
				var_27_4[#var_27_4 + 1] = iter_27_5
			end
		end
	end

	self.monsterThreatFieldCache = {
		signature = var_27_2,
		dist = var_27_3
	}

	return var_27_3
end

function ReversePacmanRoleControl:IsMonsterNextStepClaimed(arg_28_1)
	if not arg_28_1 or not arg_28_1.path then
		return false
	end

	local var_28_0 = arg_28_1.path[arg_28_1.pathIndex]

	if not arg_28_1.path[arg_28_1.pathIndex] or var_28_0 == arg_28_1.nodeId then
		return false
	end

	local var_28_1 = self.map and self.map:GetRouteGraph()

	if not var_28_1 then
		return false
	end

	return self:GetMonsterThreatDistanceField(var_28_1)[var_28_0] == 0
end

function ReversePacmanRoleControl:AnalyzeMonsterEscapeBranch(arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = {
		[arg_29_2] = true,
		[arg_29_3] = true
	}
	local var_29_1 = {
		[arg_29_3] = arg_29_2
	}
	local var_29_2 = {
		arg_29_3
	}
	local var_29_3 = 1
	local var_29_4 = 0
	local var_29_5 = false

	while var_29_2[var_29_3] do
		var_29_3 = var_29_3 + 1
		var_29_4 = var_29_4 + 1

		for iter_29_0, iter_29_1 in ipairs(arg_29_1:GetNeighbors(var_29_2[var_29_3])) do
			if iter_29_1 == arg_29_2 then
				if var_29_2[var_29_3] ~= arg_29_3 then
					var_29_5 = true
				end
			elseif not var_29_0[iter_29_1] then
				var_29_0[iter_29_1] = true
				var_29_1[iter_29_1] = var_29_2[var_29_3]
				var_29_2[#var_29_2 + 1] = iter_29_1
			elseif var_29_1[var_29_2[var_29_3]] ~= iter_29_1 then
				var_29_5 = true
			end
		end
	end

	return var_29_4, var_29_5
end

function ReversePacmanRoleControl:GetMonsterTerrainScore(arg_30_1, arg_30_2)
	if not arg_30_2 then
		return 0
	end

	local var_30_0 = 0

	if arg_30_2.tag == ReversePacmanConst.TAG.CORRIDOR then
		var_30_0 = arg_30_1:GetConfig("ai_terrain2_weight") or 0
	elseif arg_30_2.tag == ReversePacmanConst.TAG.CORNER then
		var_30_0 = arg_30_1:GetConfig("ai_terrain3_weight") or 0
	elseif arg_30_2.tag == ReversePacmanConst.TAG.JUNCTION then
		var_30_0 = arg_30_1:GetConfig("ai_terrain1_weight") or 0
	end

	return var_30_0 * var_0_1
end

function ReversePacmanRoleControl:GetMonsterRandomScore(arg_31_1)
	local var_31_0 = arg_31_1:GetConfig("ai_random_weight")

	if not var_31_0 or var_31_0[1] == nil or var_31_0[2] == nil or var_31_0[1] > var_31_0[2] then
		return 0
	end

	local var_31_1 = math.ceil(var_31_0[1])
	local var_31_2 = math.floor(var_31_0[2])

	if var_31_2 < var_31_1 then
		return 0
	end

	return math.random(var_31_1, var_31_2) * var_0_2
end

local function var_0_12(arg_32_0, arg_32_1)
	arg_32_0[#arg_32_0 + 1] = arg_32_1

	local var_32_0 = #arg_32_0

	while var_32_0 > 1 do
		local var_32_1 = math.floor(var_32_0 / 2)
		local var_32_2 = arg_32_0[var_32_1]

		if not (arg_32_1.bottleneck > arg_32_0[var_32_1].bottleneck or arg_32_1.bottleneck == var_32_2.bottleneck and arg_32_1.length < var_32_2.length) then
			break
		end

		arg_32_0[var_32_0] = var_32_2
		var_32_0 = var_32_1
	end

	arg_32_0[var_32_0] = arg_32_1

	return
end

local function var_0_13(arg_33_0)
	local var_33_0 = table.remove(arg_33_0)

	if #arg_33_0 == 0 then
		return arg_33_0[1]
	end

	local var_33_1 = 1

	while true do
		if var_33_1 * 2 > #arg_33_0 then
			break
		end

		local var_33_2 = var_33_1 * 2 + 1
		local var_33_3 = var_33_1 * 2

		if var_33_1 * 2 + 1 <= #arg_33_0 then
			if arg_33_0[var_33_2].bottleneck > arg_33_0[var_33_1 * 2].bottleneck or arg_33_0[var_33_2].bottleneck == arg_33_0[var_33_1 * 2].bottleneck and arg_33_0[var_33_2].length < arg_33_0[var_33_1 * 2].length then
				var_33_3 = var_33_2
			end
		end

		local var_33_4 = arg_33_0[var_33_3]

		if var_33_0.bottleneck > arg_33_0[var_33_3].bottleneck or var_33_0.bottleneck == var_33_4.bottleneck and var_33_0.length <= var_33_4.length then
			break
		end

		arg_33_0[var_33_1] = var_33_4
		var_33_1 = var_33_3
	end

	arg_33_0[var_33_1] = var_33_0

	return arg_33_0[1]
end

function ReversePacmanRoleControl:GetMonsterFirstStepScore(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = (arg_34_4:GetConfig("ai_deadend_weight") or 0) * var_0_4
	local var_34_1, var_34_2 = self:AnalyzeMonsterEscapeBranch(arg_34_1, arg_34_2, arg_34_3)
	local var_34_3 = math.min(var_34_1, 32) / 32 * var_0_9

	if not var_34_2 then
		var_34_3 = var_34_3 - var_34_0 * (1 + 8 / math.max(3, var_34_1 + 2))
	end

	local var_34_4 = var_34_3 + self:GetMonsterTerrainScore(arg_34_4, arg_34_1:GetNodeById(arg_34_3)) + self:GetMonsterRandomScore(arg_34_4)

	if arg_34_3 == arg_34_4._prevNodeId then
		var_34_4 = var_34_4 - var_0_3
	end

	return var_34_4
end

function ReversePacmanRoleControl:BuildEscapePath(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_1:GetNeighbors(arg_35_2)

	if #var_35_0 == 0 then
		return {
			arg_35_2
		}
	end

	local var_35_1 = math.max(1, arg_35_1.height * arg_35_1.width)
	local var_35_2 = self:GetMonsterThreatDistanceField(arg_35_1)

	local function var_35_3(arg_36_0)
		return var_35_2[arg_36_0] or var_35_1
	end

	local var_35_4 = {}

	for iter_35_0, iter_35_1 in ipairs(var_35_0) do
		var_35_4[iter_35_1] = self:GetMonsterFirstStepScore(arg_35_1, arg_35_2, iter_35_1, arg_35_3)
	end

	local var_35_5 = {
		[arg_35_2] = var_35_3(arg_35_2)
	}
	local var_35_6 = {
		[arg_35_2] = 0
	}
	local var_35_7 = {}
	local var_35_8 = {}
	local var_35_9 = {}

	var_0_12(var_35_9, {
		length = 0,
		nodeId = arg_35_2,
		bottleneck = var_35_5[arg_35_2]
	})

	::label_35_0::

	local var_35_15

	if #var_35_9 > 0 then
		repeat
			local var_35_10 = var_0_13(var_35_9)
			local var_35_11 = var_35_10.nodeId

			if var_35_10.bottleneck == var_35_5[var_35_10.nodeId] and var_35_10.length == var_35_6[var_35_11] then
				for iter_35_2, iter_35_3 in ipairs(arg_35_1:GetNeighbors(var_35_11)) do
					local var_35_12 = var_35_3(iter_35_3)

					if var_35_12 > 0 then
						local var_35_13 = math.min(var_35_10.bottleneck, var_35_12)
						local var_35_14 = var_35_10.length + 1

						if var_35_5[iter_35_3] == nil or var_35_5[iter_35_3] < var_35_13 or var_35_13 == var_35_5[iter_35_3] and var_35_14 < var_35_6[iter_35_3] then
							var_35_5[iter_35_3] = var_35_13
							var_35_6[iter_35_3] = var_35_14
							var_35_7[iter_35_3] = var_35_11
							var_35_8[iter_35_3] = var_35_11 == arg_35_2 and iter_35_3 or var_35_8[var_35_11]

							var_0_12(var_35_9, {
								nodeId = iter_35_3,
								bottleneck = var_35_13,
								length = var_35_14
							})
						end
					end
				end
			end

			goto label_35_0
		until true

		var_35_15 = arg_35_3:GetConfig("ai_target_weight") or 0
	end

	local var_35_16 = 1 + math.min(1, math.abs(var_35_15) / 10)
	local var_35_17 = (arg_35_3:GetConfig("ai_deadend_weight") or 0) * var_0_4
	local var_35_18
	local var_35_19

	for iter_35_4, iter_35_5 in pairs(var_35_5) do
		if iter_35_4 ~= arg_35_2 then
			local var_35_20 = arg_35_1:GetNodeById(iter_35_4)
			local var_35_22 = iter_35_5 * var_35_16 * var_0_5 + var_35_3(iter_35_4) * var_0_6 + ((var_35_20 or nil) and (var_35_20.degree or 0)) * var_0_7 + (var_35_4[var_35_8[iter_35_4]] or 0) - var_35_6[iter_35_4] * var_0_8

			if var_35_20 and var_35_20.degree <= 1 then
				var_35_22 = var_35_22 - var_35_17
			end

			if iter_35_4 == arg_35_3._escapeDestinationNodeId then
				var_35_22 = var_35_22 + var_0_10
			end

			if not var_35_19 or var_35_19 < var_35_22 then
				var_35_19 = var_35_22
				var_35_18 = iter_35_4
			end
		end
	end

	if not var_35_18 then
		local var_35_23
		local var_35_24

		for iter_35_6, iter_35_7 in ipairs(var_35_0) do
			local var_35_26 = var_35_3(iter_35_7) * 100 + ((not var_35_4[iter_35_7] or nil) and 0)

			if not var_35_24 or var_35_24 < var_35_26 then
				var_35_24 = var_35_26
				var_35_23 = iter_35_7
			end
		end

		return var_35_23 and {
			arg_35_2,
			var_35_23
		} or {
			arg_35_2
		}
	end

	local var_35_27 = {}
	local var_35_28 = var_35_18

	while var_35_28 do
		table.insert(var_35_27, 1, var_35_28)

		if var_35_28 == arg_35_2 then
			break
		end

		var_35_28 = var_35_7[var_35_28]
	end

	if var_35_27[1] ~= arg_35_2 or #var_35_27 < 2 then
		return {
			arg_35_2,
			var_35_0[1]
		}
	end

	arg_35_3._escapeDestinationNodeId = var_35_18

	return var_35_27
end

function ReversePacmanRoleControl:GetProximityValue(arg_37_1, arg_37_2, arg_37_3)
	if not arg_37_3 then
		return 0
	end

	local var_37_0 = arg_37_1.height * arg_37_1.width
	local var_37_1 = arg_37_1:GetDistanceById(arg_37_2, arg_37_3)

	if not var_37_1 then
		return 0
	end

	return 1 - (var_37_1 + 1) / var_37_0
end

function ReversePacmanRoleControl:GetProximityScore(arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	if not arg_38_4 or arg_38_4 == 0 then
		return 0
	end

	return self:GetProximityValue(arg_38_1, arg_38_2, arg_38_3) * arg_38_4
end

function ReversePacmanRoleControl:GetScore(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	local var_39_0 = 0
	local var_39_1 = 0

	local function var_39_2(arg_40_0, arg_40_1)
		if not arg_40_1 or arg_40_1 == 0 then
			return
		end

		local var_40_0 = self:GetProximityValue(arg_39_4, arg_39_1, arg_40_0)

		if arg_40_1 >= 0 then
			var_39_0 = var_39_0 + var_40_0 * arg_40_1
		else
			var_39_1 = var_39_1 + var_40_0 * -arg_40_1
		end

		return
	end

	local function var_39_3(arg_41_0, arg_41_1)
		if not arg_41_1 or arg_41_1 == 0 then
			return
		end

		if arg_41_1 >= 0 then
			if arg_41_0 then
				var_39_0 = var_39_0 + arg_41_1
			end
		elseif arg_41_0 then
			var_39_1 = var_39_1 + -arg_41_1
		end

		return
	end

	var_39_2(arg_39_3.nodeId, arg_39_2:GetConfig("ai_target_weight"))

	local var_39_4 = arg_39_2:GetConfig("predict_offset") or 0

	var_39_2(arg_39_3:GetPredictNodeId(var_39_4), arg_39_2:GetConfig("ai_predict_weight"))
	var_39_2(arg_39_3:GetInterceptNodeId(var_39_4), arg_39_2:GetConfig("ai_intercept_weight"))
	var_39_3(arg_39_4:IsReachable(arg_39_1, arg_39_3.nodeId), arg_39_2:GetConfig("ai_deadend_weight"))
	var_39_2(self:FindNearestBuff(arg_39_1), arg_39_2:GetConfig("ai_pickup_weight"))

	local var_39_5 = arg_39_4:GetNodeById(arg_39_1).tag

	var_39_3(var_39_5 == ReversePacmanConst.TAG.CORRIDOR, arg_39_2:GetConfig("ai_terrain2_weight"))
	var_39_3(var_39_5 == ReversePacmanConst.TAG.CORNER, arg_39_2:GetConfig("ai_terrain3_weight"))
	var_39_3(var_39_5 == ReversePacmanConst.TAG.JUNCTION, arg_39_2:GetConfig("ai_terrain1_weight"))

	local var_39_6 = arg_39_2:GetConfig("ai_random_weight")

	return 0 + ((var_39_6 and var_39_6[1] and var_39_6[2] and var_39_6[1] <= var_39_6[2] or nil) and math.random(var_39_6[1], var_39_6[2]) * 0.1), var_39_1
end

function ReversePacmanRoleControl:FindNearestBuff(arg_42_1)
	local var_42_0 = self.map and self.map:GetRouteGraph()

	if not var_42_0 then
		return nil
	end

	local var_42_1 = var_42_0:GetDistanceField(arg_42_1)
	local var_42_2
	local var_42_3

	for iter_42_0, iter_42_1 in ipairs(self.map:GetCanPickBuffs()) do
		local var_42_4 = var_42_0:GetNodeByPos(iter_42_1.cell.x, iter_42_1.cell.y)

		if var_42_4 then
			if var_42_1[var_42_4.id] and (not var_42_3 or var_42_1[var_42_4.id] < var_42_3) then
				var_42_3 = var_42_1[var_42_4.id]
				var_42_2 = var_42_4.id
			end
		end
	end

	return var_42_2
end

function ReversePacmanRoleControl:IsCatchable(arg_43_1, arg_43_2)
	return self:GetDistance(arg_43_1, arg_43_2) <= arg_43_1:GetCaptureRadius() + arg_43_2:GetCaptureRadius()
end

function ReversePacmanRoleControl:GetDistance(arg_44_1, arg_44_2)
	return math.sqrt((arg_44_1.x - arg_44_2.x) * (arg_44_1.x - arg_44_2.x) + (arg_44_1.y - arg_44_2.y) * (arg_44_1.y - arg_44_2.y))
end

function ReversePacmanRoleControl:IsPickBuff(arg_45_1, arg_45_2)
	return self:GetDistance(arg_45_1, arg_45_2) <= arg_45_1:GetCaptureRadius() + ReversePacmanConst.GRID_SIZE.x / 2
end

function ReversePacmanRoleControl:Hide()
	for iter_46_0, iter_46_1 in ipairs(self.ships) do
		iter_46_1:Hide()
	end

	for iter_46_2, iter_46_3 in ipairs(self.monsters) do
		iter_46_3:Hide()
	end

	return
end

function ReversePacmanRoleControl:Dispose()
	for iter_47_0, iter_47_1 in ipairs(self.ships) do
		iter_47_1:Dispose()
	end

	for iter_47_2, iter_47_3 in ipairs(self.monsters) do
		iter_47_3:Dispose()
	end

	self.nearestTargetCache = nil
	self.shipTriggerStates = nil
	self.aliveMonsterCache = nil
	self.aliveMonsterCacheVersion = nil

	return
end

return ReversePacmanRoleControl
