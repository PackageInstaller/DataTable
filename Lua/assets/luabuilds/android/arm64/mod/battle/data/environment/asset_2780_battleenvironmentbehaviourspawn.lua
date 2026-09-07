ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleFormulas
local BattleEnvironmentBehaviourSpawn = class("BattleEnvironmentBehaviourSpawn", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourSpawn = BattleEnvironmentBehaviourSpawn
BattleEnvironmentBehaviourSpawn.__name = "BattleEnvironmentBehaviourSpawn"

function BattleEnvironmentBehaviourSpawn:Ctor()
	self._moveEndTime = nil
	self._targetIndex = 0

	BattleEnvironmentBehaviourSpawn.super.Ctor(self)

	return
end

function BattleEnvironmentBehaviourSpawn:SetTemplate(arg_2_1)
	BattleEnvironmentBehaviourSpawn.super.SetTemplate(self, arg_2_1)

	self._content = arg_2_1.content
	self._route = arg_2_1.route or {}
	self._reloadTime = arg_2_1.reload_time
	self._rounds = arg_2_1.rounds

	return
end

function BattleEnvironmentBehaviourSpawn:doBehaviour()
	self._targetIndex = self._targetIndex + 1

	if self._targetIndex <= self._rounds then
		local var_3_0 = var_0_0.Battle.BattleDataProxy.GetInstance()
		local var_3_1 = self._unit._aoeData:GetPosition()
		local var_3_2 = Clone(self._content)

		if self._route[self._targetIndex] then
			table.merge(var_3_2, self._route[self._targetIndex])
		end

		local var_3_3 = var_3_2.count
		local var_3_4 = var_3_2.child_prefab
		local var_3_5

		if self._unit._aoeData:GetAreaType() == var_0_1.AreaType.CUBE then
			local var_3_6, var_3_7 = unpack(var_3_2.child_prefab.cld_data)

			var_3_5 = self.GenerateRandomRectanglePosition(self._unit._aoeData:GetWidth(), self._unit._aoeData:GetHeight(), var_3_3, math.max(var_3_6, var_3_7 or 0))
		elseif self._unit._aoeData:GetAreaType() == var_0_1.AreaType.COLUMN then
			local var_3_8, var_3_9 = unpack(var_3_2.child_prefab.cld_data)

			var_3_5 = self.GenerateRandomCirclePosition(self._unit._aoeData:GetRange(), var_3_3, math.max(var_3_8, var_3_9 or 0))
		end

		for iter_3_0 = 1, var_3_3 do
			var_3_5[iter_3_0] = var_3_5[iter_3_0] + var_3_1
		end

		seriesAsync({
			function(arg_4_0)
				if not var_3_2.alert then
					arg_4_0()

					return
				end

				for iter_4_0 = 1, var_3_3 do
					self.PlayAlert(var_3_2.alert, var_3_5[iter_4_0])
				end

				self:RemoveAlertTimer()

				self._alertTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", 1, var_3_2.alert.delay or 1, arg_4_0, true)

				return
			end,
			function(arg_5_0)
				for iter_5_0 = 1, var_3_3 do
					local var_5_0 = Clone(var_3_4)

					var_5_0.coordinate = {
						var_3_5[iter_5_0].x,
						var_3_5[iter_5_0].y,
						var_3_5[iter_5_0].z
					}

					var_3_0:SpawnEnvironment(var_5_0)
				end

				return
			end
		})
		BattleEnvironmentBehaviourSpawn.super.doBehaviour(self)
	else
		self:doExpire()
	end

	return
end

function BattleEnvironmentBehaviourSpawn:RemoveAlertTimer()
	if self._alertTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._alertTimer)
	end

	self._alertTimer = nil

	return
end

function BattleEnvironmentBehaviourSpawn:PlayAlert(arg_7_1)
	if not self.alert_fx then
		return
	end

	local var_7_0 = var_0_0.Battle.BattleFXPool.GetInstance():GetFX(self.alert_fx)

	var_7_0.transform.localScale = Vector3(self.range, (pg.effect_offset[self.alert_fx] and pg.effect_offset[self.alert_fx].y_scale == true or nil) and self.range, self.range)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_7_0, arg_7_1)

	return
end

local var_0_5 = math

function BattleEnvironmentBehaviourSpawn:GenerateRandomRectanglePosition(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = var_0_5.ceil(var_0_5.sqrt(arg_8_2))
	local var_8_1 = {}

	for iter_8_0 = 1, var_8_0 * var_8_0 do
		table.insert(var_8_1, {
			weight = 65536,
			rst = iter_8_0
		})
	end

	local var_8_2 = {}

	for iter_8_1 = 1, arg_8_2 do
		local var_8_3 = var_0_3.WeightRandom(var_8_1)

		var_8_1[var_8_3].weight = 0

		local var_8_4 = var_0_5.floor((var_8_3 - 1) / var_8_0)

		for iter_8_2 = 0, var_8_0 - 1 do
			var_8_1[var_8_4 * var_8_0 + iter_8_2 + 1].weight = var_8_1[var_8_4 * var_8_0 + iter_8_2 + 1].weight / 2
		end

		for iter_8_3 = 0, var_8_0 - 1 do
			var_8_1[var_8_3 - var_8_4 * var_8_0 + iter_8_3 * var_8_0].weight = var_8_1[var_8_3 - var_8_4 * var_8_0 + iter_8_3 * var_8_0].weight / 2
		end

		arg_8_3 = arg_8_3 / 2

		table.insert(var_8_2, Vector3((var_8_3 - var_8_4 * var_8_0 - 1 - var_8_0 / 2) * (self / var_8_0) + var_0_5.random(1, 1000) / 1000 * (self / var_8_0 - 2 * arg_8_3) + arg_8_3, 0, (var_8_4 - var_8_0 / 2) * (arg_8_1 / var_8_0) + var_0_5.random(1, 1000) / 1000 * (arg_8_1 / var_8_0 - 2 * arg_8_3) + arg_8_3))
	end

	return var_8_2
end

local var_0_6 = {
	Vector2(0, 0),
	Vector2(-0.66, 0),
	Vector2(-0.33, 0.58),
	Vector2(0.33, 0.58),
	Vector2(0.66, 0),
	Vector2(0.33, -0.58),
	Vector2(-0.33, -0.58)
}

function BattleEnvironmentBehaviourSpawn:GenerateRandomCirclePosition(arg_9_1, arg_9_2)
	local var_9_0 = 1
	local var_9_1 = 1
	local var_9_2 = self

	while var_9_1 < arg_9_1 do
		var_9_1 = var_9_1 * 7
		var_9_0 = var_9_0 + 1
		var_9_2 = var_9_2 / 3
	end

	local var_9_3 = {}

	for iter_9_0 = 1, var_9_1 do
		table.insert(var_9_3, {
			weight = 256,
			rst = iter_9_0
		})
	end

	local var_9_4 = {}

	for iter_9_1 = 1, arg_9_1 do
		local var_9_5 = var_0_3.WeightRandom(var_9_3)

		var_9_3[var_9_5].weight = 0

		local var_9_6 = var_9_5 - 1
		local var_9_7 = 1
		local var_9_8 = Vector2(0, 0)
		local var_9_9 = var_9_2

		for iter_9_2 = var_9_0, 2, -1 do
			var_9_6 = var_0_5.floor(var_9_6 / 7)
			var_9_9 = var_9_9 * 3

			var_9_8:Add(var_9_9 * var_0_6[var_9_6 - var_9_6 * 7 + 1])

			var_9_7 = var_9_7 * 7

			if iter_9_2 > 2 and iter_9_2 == var_9_0 then
				for iter_9_3 = var_9_6 * var_9_7 + 1, var_9_6 * var_9_7 + var_9_7 do
					var_9_3[iter_9_3].weight = var_9_3[iter_9_3].weight / 2
				end
			end
		end

		local var_9_10 = var_0_5.random(1, 360)
		local var_9_11 = var_0_5.random(1, 1000) / 1000 * var_0_5.max(var_9_2 - arg_9_2, 0)

		var_9_8:Add(Vector2(var_9_11 * var_0_5.cos(var_9_10), var_9_11 * var_0_5.sin(var_9_10)))
		table.insert(var_9_4, Vector3(var_9_8.x, 0, var_9_8.y))
	end

	return var_9_4
end

function BattleEnvironmentBehaviourSpawn:Dispose()
	self:RemoveAlertTimer()
	table.clear(self)
	BattleEnvironmentBehaviourSpawn.super.Dispose(self)

	return
end

return
