ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleFormulas
local var_0_3 = class("BattleEnvironmentBehaviourSpawn", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourSpawn = var_0_3
var_0_3.__name = "BattleEnvironmentBehaviourSpawn"

function var_0_3.Ctor(arg_1_0)
	arg_1_0._moveEndTime = nil
	arg_1_0._targetIndex = 0

	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.SetTemplate(arg_2_0, arg_2_1)
	var_0_3.super.SetTemplate(arg_2_0, arg_2_1)

	arg_2_0._content = arg_2_1.content
	arg_2_0._route = arg_2_1.route or {}
	arg_2_0._reloadTime = arg_2_1.reload_time
	arg_2_0._rounds = arg_2_1.rounds

	return
end

function var_0_3.doBehaviour(arg_3_0)
	arg_3_0._targetIndex = arg_3_0._targetIndex + 1

	if arg_3_0._targetIndex <= arg_3_0._rounds then
		local var_3_0 = var_0.Battle.BattleDataProxy.GetInstance()
		local var_3_1 = arg_3_0._unit._aoeData:GetPosition()
		local var_3_2 = Clone(arg_3_0._content)

		if arg_3_0._route[arg_3_0._targetIndex] then
			table.merge(var_3_2, arg_3_0._route[arg_3_0._targetIndex])
		end

		local var_3_3 = var_3_2.count
		local var_3_4 = var_3_2.child_prefab
		local var_3_5

		if arg_3_0._unit._aoeData:GetAreaType() == var_0_0.AreaType.CUBE then
			local var_3_6, var_3_7 = unpack(var_3_2.child_prefab.cld_data)

			var_3_5 = arg_3_0.GenerateRandomRectanglePosition(arg_3_0._unit._aoeData:GetWidth(), arg_3_0._unit._aoeData:GetHeight(), var_3_3, math.max(var_3_6, var_3_7 or 0))
		elseif arg_3_0._unit._aoeData:GetAreaType() == var_0_0.AreaType.COLUMN then
			local var_3_8, var_3_9 = unpack(var_3_2.child_prefab.cld_data)

			var_3_5 = arg_3_0.GenerateRandomCirclePosition(arg_3_0._unit._aoeData:GetRange(), var_3_3, math.max(var_3_8, var_3_9 or 0))
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
					arg_3_0.PlayAlert(var_3_2.alert, var_3_5[iter_4_0])
				end

				arg_3_0:RemoveAlertTimer()

				local var_4_0 = var_3_2.alert.delay or 1

				arg_3_0._alertTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", 1, var_4_0, arg_4_0, true)

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
		var_0_3.super.doBehaviour(arg_3_0)
	else
		arg_3_0:doExpire()
	end

	return
end

function var_0_3.RemoveAlertTimer(arg_6_0)
	if arg_6_0._alertTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_6_0._alertTimer)
	end

	arg_6_0._alertTimer = nil

	return
end

function var_0_3.PlayAlert(arg_7_0, arg_7_1)
	if not arg_7_0.alert_fx then
		return
	end

	local var_7_0 = var_0.Battle.BattleFXPool.GetInstance():GetFX(arg_7_0.alert_fx)
	local var_7_1 = 0

	if pg.effect_offset[arg_7_0.alert_fx] and pg.effect_offset[arg_7_0.alert_fx].y_scale == true then
		var_7_1 = arg_7_0.range
	end

	var_7_0.transform.localScale = Vector3(arg_7_0.range, var_7_1, arg_7_0.range)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_7_0, arg_7_1)

	return
end

local var_0_4 = math

function var_0_3.GenerateRandomRectanglePosition(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = var_0_4.ceil(var_0_4.sqrt(arg_8_2))

	for iter_8_0 = 1, var_8_0 * var_8_0 do
		table.insert({}, {
			weight = 65536,
			rst = iter_8_0
		})
	end

	for iter_8_1 = 1, arg_8_2 do
		local var_8_1 = var_0_2.WeightRandom({})

		;({})[var_8_1].weight = 0

		local var_8_2 = var_0_4.floor((var_8_1 - 1) / var_8_0)

		for iter_8_2 = 0, var_8_0 - 1 do
			({})[var_8_2 * var_8_0 + iter_8_2 + 1].weight = ({})[var_8_2 * var_8_0 + iter_8_2 + 1].weight / 2
		end

		for iter_8_3 = 0, var_8_0 - 1 do
			({})[var_8_1 - var_8_2 * var_8_0 + iter_8_3 * var_8_0].weight = ({})[var_8_1 - var_8_2 * var_8_0 + iter_8_3 * var_8_0].weight / 2
		end

		arg_8_3 = arg_8_3 / 2

		local var_8_3 = (var_8_1 - var_8_2 * var_8_0 - 1 - var_8_0 / 2) * (arg_8_0 / var_8_0) + var_0_4.random(1, 1000) / 1000 * (arg_8_0 / var_8_0 - 2 * arg_8_3)
		local var_8_4 = (var_8_2 - var_8_0 / 2) * (arg_8_1 / var_8_0) + var_0_4.random(1, 1000) / 1000 * (arg_8_1 / var_8_0 - 2 * arg_8_3)

		table.insert({}, Vector3(var_8_3 + arg_8_3, 0, var_8_4 + arg_8_3))
	end

	return {}
end

local var_0_5 = {
	Vector2(0, 0),
	Vector2(-0.66, 0),
	Vector2(-0.33, 0.58),
	Vector2(0.33, 0.58),
	Vector2(0.66, 0),
	Vector2(0.33, -0.58),
	Vector2(-0.33, -0.58)
}

function var_0_3.GenerateRandomCirclePosition(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 1
	local var_9_1 = 1
	local var_9_2 = arg_9_0

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

	for iter_9_1 = 1, arg_9_1 do
		local var_9_4 = var_0_2.WeightRandom(var_9_3)

		var_9_3[var_9_4].weight = 0

		local var_9_5 = var_9_4 - 1
		local var_9_6 = 1
		local var_9_7 = Vector2(0, 0)
		local var_9_8 = var_9_2

		for iter_9_2 = var_9_0, 2, -1 do
			var_9_5 = var_0_4.floor(var_9_5 / 7)
			var_9_8 = var_9_8 * 3

			var_9_7:Add(var_9_8 * var_0_5[var_9_5 - var_9_5 * 7 + 1])

			var_9_6 = var_9_6 * 7

			if iter_9_2 > 2 and iter_9_2 == var_9_0 then
				for iter_9_3 = var_9_5 * var_9_6 + 1, var_9_5 * var_9_6 + var_9_6 do
					var_9_3[iter_9_3].weight = var_9_3[iter_9_3].weight / 2
				end
			end
		end

		local var_9_9 = var_0_4.random(1, 360)
		local var_9_10 = var_0_4.random(1, 1000) / 1000 * var_0_4.max(var_9_2 - arg_9_2, 0)

		var_9_7:Add(Vector2(var_9_10 * var_0_4.cos(var_9_9), var_9_10 * var_0_4.sin(var_9_9)))
		table.insert({}, Vector3(var_9_7.x, 0, var_9_7.y))
	end

	return {}
end

function var_0_3.Dispose(arg_10_0)
	arg_10_0:RemoveAlertTimer()
	table.clear(arg_10_0)
	var_0_3.super.Dispose(arg_10_0)

	return
end

return
