ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

singletonClass = var_0_10002
var_0_1.BattleAntiSeaBulletFactory = var_0_10002("BattleAntiSeaBulletFactory", var_0.Battle.BattleBulletFactory)
var_0.Battle.BattleAntiSeaBulletFactory.__name = "BattleAntiSeaBulletFactory"

local var_0_2 = var_0.Battle.BattleAntiSeaBulletFactory

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

	if not var_11.GetCharacter(var_3_3, var_3_2) then
		var_3_1:RemoveBulletUnit(arg_3_2:GetUniqueID())

		return
	end

	local var_3_4 = var_3_0.range
	local var_3_5
	local var_3_6
	local var_3_7

	local function var_3_8()
		if var_3_5 then
			local var_4_0
			local var_4_1 = var_0
			local var_4_2 = var_1.GetPosition(var_4_1)
			local var_4_3 = var_1.Clone(var_4_2)
			local var_4_4 = var_0

			if var_2.IsAlive(var_4_4) and var_0 then
				local var_4_5 = var_4_3
				local var_4_6 = var_4_3.Add

				Vector3 = var_2_10005
				math = var_2_10007

				local var_4_7 = var_2_10007.random(var_3_4) - var_3_4 * 0.5
				local var_4_8 = 0

				math = var_9
				var_4_0 = var_4_6(var_4_5, var_2_10005(var_4_7, var_4_8, var_9.random(var_3_4) - var_3_4 * 0.5))
			else
				var_4_0 = var_4_3
			end

			local var_4_9 = arg_3_0
			local var_4_10 = var_2.GetFXPool(var_4_9)
			local var_4_11 = var_2.GetFX
			local var_4_12 = arg_3_2
			local var_4_13, var_4_14 = var_4_11(var_4_10, var_5.GetTemplate(var_4_12).hit_fx)

			pg = var_4_10

			local var_4_15 = var_4_10.EffectMgr.GetInstance()

			var_4.PlayBattleEffect(var_4_15, var_4_13, var_4_14:Add(var_4_0), true)
		end

		return
	end

	local function var_3_9()
		local var_5_0 = var_0
		local var_5_3

		if var_0.IsAlive(var_5_0) then
			local var_5_1 = var_3_1

			var_5_3.HandleDamage(var_5_1, arg_3_2, var_0)

			local var_5_2 = var_3_1

			var_5_3 = var_5_3.RemoveBulletUnit

			local var_5_4 = arg_3_2

			var_5_3(var_5_2, var_3.GetUniqueID(var_5_4))
		end

		pg = var_5_3

		local var_5_5 = var_5_3.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_5_5, var_3_5)

		arg_3_0._tmpTimerList[var_3_5] = nil
		var_3_5 = nil

		return
	end

	pg = var_1_10018

	local var_3_10 = var_1_10018.TimeMgr.GetInstance()

	var_3_5 = var_18.AddBattleTimer(var_3_10, "antiAirTimer", 0, 0.5, var_3_9, true)
	arg_3_0._tmpTimerList[var_3_5] = var_3_5

	if arg_3_4 ~= nil then
		arg_3_0:PlayFireFX(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, nil)

		pg = var_18

		local var_3_11 = var_18.TimeMgr.GetInstance()
		local var_3_12 = var_18.AddBattleTimer(var_3_11, "showHitFXTimer", -1, 0.1, var_3_8, true)

		arg_3_0._tmpTimerList[var_3_12] = var_3_12

		var_3_8()
	else
		var_3_1:HandleDamage(arg_3_2, var_9)
		var_3_1:RemoveBulletUnit(arg_3_2:GetUniqueID())
	end

	return
end

return
