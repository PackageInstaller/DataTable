ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

singletonClass = var_0_10002
var_0_1.BattleAntiAirBulletFactory = var_0_10002("BattleAntiAirBulletFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleAntiAirBulletFactory.__name = "BattleAntiAirBulletFactory"

local var_0_2 = var_0.Battle.BattleAntiAirBulletFactory

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	arg_1_0._tmpTimerList = {}

	return
end

function var_0_2.NeutralizeBullet(arg_2_0)
	pairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0._tmpTimerList) do
		pg = var_1_10006

		local var_2_0 = var_1_10006.TimeMgr.GetInstance()

		var_1_10006.RemoveBattleTimer(var_2_0, iter_2_1)

		var_1_10006 = arg_2_0._tmpTimerList
		var_1_10006[iter_2_1] = nil
	end

	return
end

function var_0_2.CreateBullet(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = arg_3_2:GetTemplate().hit_type
	local var_3_1 = arg_3_0:GetDataProxy()

	if not arg_3_2:GetDirectHitUnit() then
		var_3_1:RemoveBulletUnit(arg_3_2:GetUniqueID())

		return
	end

	local var_3_2 = var_9:GetUniqueID()
	local var_3_3 = arg_3_0:GetSceneMediator()

	if var_11.GetAircraft(var_3_3, var_3_2) == nil then
		var_3_1:RemoveBulletUnit(arg_3_2:GetUniqueID())

		return
	end

	local var_3_4 = var_11:GetPosition()
	local var_3_5 = var_12.Clone(var_3_4)
	local var_3_6 = var_3_0.range

	local function var_3_7(arg_4_0)
		local var_4_0 = {}

		ipairs = var_2_10002

		for iter_4_0, iter_4_1 in var_2_10002(arg_4_0) do
			if iter_4_1.Active then
				local var_4_1 = arg_3_0
				local var_4_2 = var_7.GetSceneMediator(var_4_1)

				if var_7.GetAircraft(var_4_2, iter_4_1.UID) then
					local var_4_3 = var_7:GetUnitData()

					if var_8.IsVisitable(var_4_3) then
						var_4_0[#var_4_0 + 1] = var_8
					end
				end
			end
		end

		local var_4_4 = var_3_1

		var_2.HandleMeteoDamage(var_4_4, arg_3_2, var_4_0)

		return
	end

	local function var_3_8()
		local var_5_0 = var_3_1
		local var_5_1 = var_0.SpawnColumnArea
		local var_5_2 = arg_3_2
		local var_5_3 = var_3.GetEffectField(var_5_2)
		local var_5_4 = arg_3_2

		var_5_1(var_5_0, var_5_3, var_4.GetIFF(var_5_4), var_3_5, var_3_6, var_3_0.time, var_3_7)

		local var_5_5 = var_3_1
		local var_5_6 = var_0.RemoveBulletUnit
		local var_5_7 = arg_3_2

		var_5_6(var_5_5, var_3.GetUniqueID(var_5_7))

		return
	end

	local function var_3_9()
		local var_6_0
		local var_6_1 = var_0

		if var_1.IsAlive(var_6_1) and var_0 then
			local var_6_2 = var_0
			local var_6_3 = var_1.GetPosition(var_6_2)
			local var_6_4 = var_1.Clone(var_6_3)
			local var_6_5 = var_1.Add

			Vector3 = var_2_10004
			math = var_2_10006

			local var_6_6 = var_2_10006.random(var_3_6) - var_3_6 * 0.5
			local var_6_7 = 0

			math = var_8
			var_3_5 = var_6_5(var_6_4, var_2_10004(var_6_6, var_6_7, var_8.random(var_3_6) - var_3_6 * 0.5))
		else
			var_6_0 = var_3_5
		end

		local var_6_8 = arg_3_0
		local var_6_9 = var_1.GetFXPool(var_6_8)
		local var_6_10 = var_1.GetFX
		local var_6_11 = arg_3_2
		local var_6_12, var_6_13 = var_6_10(var_6_9, var_4.GetTemplate(var_6_11).hit_fx)

		pg = var_6_9

		local var_6_14 = var_6_9.EffectMgr.GetInstance()

		var_3.PlayBattleEffect(var_6_14, var_6_12, var_6_13:Add(var_6_0), true)

		return
	end

	local var_3_10
	local var_3_11

	local function var_3_12()
		if arg_3_4 == nil then
			var_3_8()
		else
			local var_7_0 = arg_3_0

			var_0.PlayFireFX(var_7_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, var_3_11)
		end

		return
	end

	function var_3_11()
		if arg_3_0._tmpTimerList[var_3_10] ~= nil then
			var_3_12()
			var_3_9()
		else
			var_3_8()
		end

		return
	end

	local function var_3_13()
		pg = var_2_10000

		local var_9_0 = var_2_10000.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_9_0, var_3_10)

		arg_3_0._tmpTimerList[var_3_10] = nil
		var_3_10 = nil

		return
	end

	pg = var_1_10021

	local var_3_14 = var_1_10021.TimeMgr.GetInstance()

	var_3_10 = var_21.AddBattleTimer(var_3_14, "antiAirTimer", -1, 0.5, var_3_13, true)
	arg_3_0._tmpTimerList[var_3_10] = var_3_10

	var_3_12()

	return
end

return
