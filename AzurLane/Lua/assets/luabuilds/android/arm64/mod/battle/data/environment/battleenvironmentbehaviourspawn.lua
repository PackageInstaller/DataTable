ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle.BattleFormulas

class = var_0_10004

local var_0_4 = var_0_10004("BattleEnvironmentBehaviourSpawn", var_0.Battle.BattleEnvironmentBehaviour)

var_0.Battle.BattleEnvironmentBehaviourSpawn = var_0_4
var_0_4.__name = "BattleEnvironmentBehaviourSpawn"

function var_0_4.Ctor(arg_1_0)
	arg_1_0._moveEndTime = nil
	arg_1_0._targetIndex = 0

	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.SetTemplate(arg_2_0, arg_2_1)
	var_0_4.super.SetTemplate(arg_2_0, arg_2_1)

	arg_2_0._content = arg_2_1.content

	local var_2_0

	if not arg_2_1.route then
		var_2_0 = {}
	end

	arg_2_0._route = var_2_0
	arg_2_0._reloadTime = arg_2_1.reload_time
	arg_2_0._rounds = arg_2_1.rounds

	return
end

function var_0_4.doBehaviour(arg_3_0)
	arg_3_0._targetIndex = arg_3_0._targetIndex + 1

	if arg_3_0._targetIndex <= arg_3_0._rounds then
		local var_3_0 = arg_3_0._route[arg_3_0._targetIndex]
		local var_3_1 = var_0.Battle.BattleDataProxy.GetInstance()
		local var_3_2 = arg_3_0._unit._aoeData
		local var_3_3 = var_3.GetPosition(var_3_2)

		Clone = var_1_10005

		local var_3_4 = var_1_10005(arg_3_0._content)

		if var_3_0 then
			table = var_3_2

			var_3_2.merge(var_3_4, var_3_0)
		end

		local var_3_5 = var_3_4.count
		local var_3_6 = var_3_4.child_prefab
		local var_3_7

		if var_3:GetAreaType() == var_0_1.AreaType.CUBE then
			unpack = var_9

			local var_3_8, var_3_9 = var_9(var_3_6.cld_data)
			local var_3_10 = arg_3_0.GenerateRandomRectanglePosition
			local var_3_11 = var_3:GetWidth()
			local var_3_12 = var_3
			local var_3_13 = var_3.GetHeight(var_3_12)
			local var_3_14 = var_3_5

			math = var_3_12
			var_3_7 = var_3_10(var_3_11, var_3_13, var_3_14, var_3_12.max(var_3_8, var_3_9 or 0))
		elseif var_3:GetAreaType() == var_0_1.AreaType.COLUMN then
			unpack = var_9

			local var_3_15, var_3_16 = var_9(var_3_6.cld_data)
			local var_3_17 = arg_3_0.GenerateRandomCirclePosition
			local var_3_18 = var_3
			local var_3_19 = var_3.GetRange(var_3_18)
			local var_3_20 = var_3_5

			math = var_3_18
			var_3_7 = var_3_17(var_3_19, var_3_20, var_3_18.max(var_3_15, var_3_16 or 0))
		end

		for iter_3_0 = 1, var_3_5 do
			var_3_7[iter_3_0] = var_3_7[iter_3_0] + var_3_3
		end

		seriesAsync = var_9

		var_9({
			function(arg_4_0)
				if not var_3_4.alert then
					arg_4_0()

					return
				end

				for iter_4_0 = 1, var_3_5 do
					local var_4_0 = var_3_7[iter_4_0]

					arg_3_0.PlayAlert(var_3_4.alert, var_4_0)
				end

				local var_4_1 = arg_3_0

				var_1.RemoveAlertTimer(var_4_1)

				local var_4_2 = arg_3_0

				pg = var_2

				local var_4_3 = var_2.TimeMgr.GetInstance()
				local var_4_4 = var_2.AddBattleTimer
				local var_4_5 = ""
				local var_4_6 = 1
				local var_4_7

				if not var_3_4.alert.delay then
					var_4_7 = 1
				end

				var_4_2._alertTimer = var_4_4(var_4_3, var_4_5, var_4_6, var_4_7, arg_4_0, true)

				return
			end,
			function(arg_5_0)
				for iter_5_0 = 1, var_3_5 do
					Clone = var_2_10005
					var_2_10005 = var_2_10005(var_3_6)

					local var_5_0 = var_3_7[iter_5_0]

					var_2_10005.coordinate = {
						var_5_0.x,
						var_5_0.y,
						var_5_0.z
					}

					local var_5_1 = var_3_1

					var_7.SpawnEnvironment(var_5_1, var_2_10005)
				end

				return
			end
		})
		var_0_4.super.doBehaviour(arg_3_0)
	else
		arg_3_0:doExpire()
	end

	return
end

function var_0_4.RemoveAlertTimer(arg_6_0)
	if arg_6_0._alertTimer then
		pg = var_1

		local var_6_0 = var_1.TimeMgr.GetInstance()

		var_1.RemoveBattleTimer(var_6_0, arg_6_0._alertTimer)
	end

	arg_6_0._alertTimer = nil

	return
end

function var_0_4.PlayAlert(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.range

	if not arg_7_0.alert_fx then
		return
	end

	local var_7_1 = var_0.Battle.BattleFXPool.GetInstance()
	local var_7_2 = var_4.GetFX(var_7_1, var_3).transform
	local var_7_3 = 0

	pg = var_7

	if var_7.effect_offset[var_3] and var_7[var_3].y_scale == true then
		var_7_3 = var_7_0
	end

	Vector3 = var_8
	var_7_2.localScale = var_8(var_7_0, var_7_3, var_7_0)
	pg = var_8

	local var_7_4 = var_8.EffectMgr.GetInstance()

	var_8.PlayBattleEffect(var_7_4, var_4, arg_7_1)

	return
end

math = var_5

function var_0_4.GenerateRandomRectanglePosition(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = var_0.ceil(var_0.sqrt(arg_8_2))
	local var_8_1 = {}

	for iter_8_0 = 1, var_8_0 * var_8_0 do
		table = var_1_10010

		var_1_10010.insert(var_8_1, {
			weight = 65536,
			rst = iter_8_0
		})
	end

	local var_8_2 = {}

	for iter_8_1 = 1, arg_8_2 do
		var_8_1[var_0_3.WeightRandom(var_8_1)].weight = 0

		local var_8_3 = var_0.floor((var_11 - 1) / var_8_0) * var_8_0

		for iter_8_2 = 0, var_8_0 - 1 do
			var_8_1[var_8_3 + iter_8_2 + 1].weight = var_8_1[var_8_3 + iter_8_2 + 1].weight / 2
		end

		local var_8_4 = var_11 - var_12 * var_8_0

		for iter_8_3 = 0, var_8_0 - 1 do
			var_8_1[var_8_4 + iter_8_3 * var_8_0].weight = var_8_1[var_8_4 + iter_8_3 * var_8_0].weight / 2
		end

		arg_8_3 = arg_8_3 / 2

		local var_8_5 = (var_8_4 - 1 - var_8_0 / 2) * (arg_8_0 / var_8_0) + var_0.random(1, 1000) / 1000 * (arg_8_0 / var_8_0 - 2 * arg_8_3) + arg_8_3
		local var_8_6 = (var_12 - var_8_0 / 2) * (arg_8_1 / var_8_0) + var_0.random(1, 1000) / 1000 * (arg_8_1 / var_8_0 - 2 * arg_8_3) + arg_8_3

		table = var_17

		local var_8_7 = var_17.insert
		local var_8_8 = var_8_2

		Vector3 = var_20

		var_8_7(var_8_8, var_20(var_8_5, 0, var_8_6))
	end

	return var_8_2
end

local var_0_5 = {}

Vector2 = var_7
var_0_5[1] = var_7(0, 0)
Vector2 = var_7
var_0_5[2] = var_7(-0.66, 0)
Vector2 = var_7
var_0_5[3] = var_7(-0.33, 0.58)
Vector2 = var_7
var_0_5[4] = var_7(0.33, 0.58)
Vector2 = var_7
var_0_5[5] = var_7(0.66, 0)
Vector2 = var_7
var_0_5[6] = var_7(0.33, -0.58)
Vector2 = var_7
var_0_5[7] = var_7(-0.33, -0.58)

function var_0_4.GenerateRandomCirclePosition(arg_9_0, arg_9_1, arg_9_2)
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
		table = var_1_10011

		var_1_10011.insert(var_9_3, {
			weight = 256,
			rst = iter_9_0
		})
	end

	local var_9_4 = {}

	for iter_9_1 = 1, arg_9_1 do
		var_9_3[var_0_3.WeightRandom(var_9_3)].weight = 0

		local var_9_5 = var_12 - 1
		local var_9_6 = 1

		Vector2 = var_1_10015
		var_1_10015 = var_1_10015(0, 0)

		local var_9_7 = var_9_2

		for iter_9_2 = var_9_0, 2, -1 do
			local var_9_8 = var_9_5 - var_0.floor(var_9_5 / 7) * 7

			var_9_7 = var_9_7 * 3

			var_1_10015:Add(var_9_7 * var_0_5[var_9_8 + 1])

			var_9_6 = var_9_6 * 7

			if iter_9_2 > 2 and iter_9_2 == var_9_0 then
				for iter_9_3 = var_9_5 * var_9_6 + 1, var_9_5 * var_9_6 + var_9_6 do
					var_9_3[iter_9_3].weight = var_9_3[iter_9_3].weight / 2
				end
			end
		end

		local var_9_9 = var_0.random(1, 360)
		local var_9_10 = var_0.random(1, 1000) / 1000 * var_0.max(var_9_2 - arg_9_2, 0)
		local var_9_11 = var_1_10015
		local var_9_12 = var_1_10015.Add

		Vector2 = var_22

		var_9_12(var_9_11, var_22(var_9_10 * var_0.cos(var_9_9), var_9_10 * var_0.sin(var_9_9)))

		table = var_9_12

		local var_9_13 = var_9_12.insert
		local var_9_14 = var_9_4

		Vector3 = var_22

		var_9_13(var_9_14, var_22(var_1_10015.x, 0, var_1_10015.y))
	end

	return var_9_4
end

function var_0_4.Dispose(arg_10_0)
	arg_10_0:RemoveAlertTimer()

	table = var_1

	var_1.clear(arg_10_0)
	var_0_4.super.Dispose(arg_10_0)

	return
end

return
