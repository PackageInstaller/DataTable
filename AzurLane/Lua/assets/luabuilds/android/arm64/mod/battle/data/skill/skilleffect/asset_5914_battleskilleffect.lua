ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas
local var_0_2 = var_0.Battle.BattleUnitEvent
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleSkillEffect = var_0_10004("BattleSkillEffect")
var_0.Battle.BattleSkillEffect.__name = "BattleSkillEffect"

local var_0_4 = var_0.Battle.BattleSkillEffect

function var_0_4.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tempData = arg_1_1
	arg_1_0._type = arg_1_0._tempData.type

	local var_1_0

	if not arg_1_0._tempData.target_choise then
		var_1_0 = "TargetNull"
	end

	arg_1_0._targetChoise = var_1_0
	arg_1_0._casterAniEffect = arg_1_0._tempData.casterAniEffect
	arg_1_0._targetAniEffect = arg_1_0._tempData.targetAniEffect

	local var_1_1

	if not arg_1_0._tempData.arg_list.delay then
		var_1_1 = 0
	end

	arg_1_0._delay = var_1_1
	arg_1_0._lastEffectTarget = {}
	arg_1_0._timerList = {}
	arg_1_0._timerIndex = 0
	arg_1_0._level = arg_1_2

	return
end

function var_0_4.SetCommander(arg_2_0, arg_2_1)
	arg_2_0._commander = arg_2_1

	return
end

function var_0_4.Effect(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 and #arg_3_2 > 0 then
		ipairs = var_4

		for iter_3_0, iter_3_1 in var_4(arg_3_2) do
			arg_3_0:AniEffect(arg_3_1, iter_3_1)
			arg_3_0:DataEffect(arg_3_1, iter_3_1, arg_3_3)
		end
	else
		arg_3_0:DataEffectWithoutTarget(arg_3_1, arg_3_3)
	end

	return
end

function var_0_4.IsFinaleEffect(arg_4_0)
	return false
end

function var_0_4.SetFinaleCallback(arg_5_0, arg_5_1)
	arg_5_0._finaleCallback = arg_5_1

	return
end

function var_0_4.AniEffect(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2:GetPosition()
	local var_6_1 = arg_6_1:GetPosition()

	if arg_6_0._casterAniEffect and arg_6_0._casterAniEffect ~= "" then
		local var_6_2 = arg_6_0._casterAniEffect
		local var_6_3

		if var_6_2.posFun then
			function var_6_3(arg_7_0)
				return var_6_2.posFun(var_6_1, var_6_0, arg_7_0)
			end
		end

		local var_6_4 = {
			effect = var_6_2.effect,
			offset = var_6_2.offset,
			posFun = var_6_3
		}

		arg_6_1:DispatchEvent(var_0.Event.New(var_0_2.ADD_EFFECT, var_6_4))
	end

	if arg_6_0._targetAniEffect and arg_6_0._targetAniEffect ~= "" then
		local var_6_5 = arg_6_0._targetAniEffect
		local var_6_6

		if var_6_5.posFun then
			function var_6_6(arg_8_0)
				return var_6_5.posFun(var_6_1, var_6_0, arg_8_0)
			end
		end

		local var_6_7 = {
			effect = var_6_5.effect,
			offset = var_6_5.offset,
			posFun = var_6_6
		}

		arg_6_2:DispatchEvent(var_0.Event.New(var_0_2.ADD_EFFECT, var_6_7))
	end

	return
end

function var_0_4.DataEffect(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0._delay > 0 then
		local var_9_0

		arg_9_0._timerIndex = arg_9_0._timerIndex + 1

		local function var_9_1()
			if arg_9_1 then
				local var_10_0 = arg_9_1

				if var_0.IsAlive(var_10_0) then
					local var_10_1 = arg_9_0

					var_0.DoDataEffect(var_10_1, arg_9_1, arg_9_2, arg_9_3)
				end
			end

			pg = var_0

			local var_10_2 = var_0.TimeMgr.GetInstance()

			var_0.RemoveBattleTimer(var_10_2, var_9_0)

			arg_9_0._timerList[var_0] = nil

			return
		end

		pg = var_1_10007

		local var_9_2 = var_1_10007.TimeMgr.GetInstance()

		var_9_0 = var_7.AddBattleTimer(var_9_2, "BattleSkill", -1, arg_9_0._delay, var_9_1, true)
		arg_9_0._timerList[var_5] = var_9_0
	else
		arg_9_0:DoDataEffect(arg_9_1, arg_9_2, arg_9_3)
	end

	return
end

function var_0_4.DoDataEffect(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return
end

function var_0_4.DataEffectWithoutTarget(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._delay > 0 then
		local var_12_0

		arg_12_0._timerIndex = arg_12_0._timerIndex + 1

		local function var_12_1()
			if arg_12_1 then
				local var_13_0 = arg_12_1

				if var_0.IsAlive(var_13_0) then
					local var_13_1 = arg_12_0

					var_0.DoDataEffectWithoutTarget(var_13_1, arg_12_1, arg_12_2)
				end
			end

			pg = var_0

			local var_13_2 = var_0.TimeMgr.GetInstance()

			var_0.RemoveBattleTimer(var_13_2, var_12_0)

			arg_12_0._timerList[var_0] = nil

			return
		end

		pg = var_1_10006

		local var_12_2 = var_1_10006.TimeMgr.GetInstance()

		var_12_0 = var_6.AddBattleTimer(var_12_2, "BattleSkill", -1, arg_12_0._delay, var_12_1, true)
		arg_12_0._timerList[var_4] = var_12_0
	else
		arg_12_0:DoDataEffectWithoutTarget(arg_12_1, arg_12_2)
	end

	return
end

function var_0_4.DoDataEffectWithoutTarget(arg_14_0, arg_14_1, arg_14_2)
	return
end

function var_0_4.GetTarget(arg_15_0, arg_15_1, arg_15_2)
	type = var_1_10003

	if var_1_10003(arg_15_0._targetChoise) == "string" then
		if arg_15_0._targetChoise == "TargetSameToLastEffect" then
			return arg_15_2._lastEffectTarget
		else
			return var_0.Battle.BattleTargetChoise[arg_15_0._targetChoise](arg_15_1, arg_15_0._tempData.arg_list)
		end
	else
		type = var_3

		if var_3(arg_15_0._targetChoise) == "table" then
			local var_15_0

			ipairs = var_1_10004

			for iter_15_0, iter_15_1 in var_1_10004(arg_15_0._targetChoise) do
				var_15_0 = var_0.Battle.BattleTargetChoise[iter_15_1](arg_15_1, arg_15_0._tempData.arg_list, var_15_0)
			end

			return var_15_0
		end
	end

	return
end

function var_0_4.Interrupt(arg_16_0)
	return
end

function var_0_4.Clear(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0._timerList) do
		pg = var_1_10006

		local var_17_0 = var_1_10006.TimeMgr.GetInstance()

		var_1_10006.RemoveBattleTimer(var_17_0, iter_17_1)

		var_1_10006 = arg_17_0._timerList
		var_1_10006[iter_17_0] = nil
	end

	arg_17_0._commander = nil

	return
end

function var_0_4.calcCorrdinate(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0

	if arg_18_0.absoulteCorrdinate then
		Vector3 = var_4
		var_18_0 = var_4(arg_18_0.absoulteCorrdinate.x, 0, arg_18_0.absoulteCorrdinate.z)
	elseif arg_18_0.absoulteRandom then
		var_18_0 = var_0_1.RandomPos(arg_18_0.absoulteRandom)
	elseif arg_18_0.casterRelativeCorrdinate then
		local var_18_1 = arg_18_1:GetIFF()
		local var_18_2 = arg_18_1:GetPosition()
		local var_18_3 = var_18_1 * arg_18_0.casterRelativeCorrdinate.hrz + var_18_2.x
		local var_18_4 = var_18_1 * arg_18_0.casterRelativeCorrdinate.vrt + var_18_2.z

		Vector3 = var_8
		var_18_0 = var_8(var_18_3, 0, var_18_4)
	elseif arg_18_0.casterRelativeRandom then
		local var_18_5 = arg_18_1:GetIFF()
		local var_18_6 = arg_18_1:GetPosition()
		local var_18_7 = {
			X1 = var_18_5 * arg_18_0.casterRelativeRandom.front + var_18_6.x,
			X2 = var_18_5 * arg_18_0.casterRelativeRandom.rear + var_18_6.x,
			Z1 = arg_18_0.casterRelativeRandom.upper + var_18_6.z,
			Z2 = arg_18_0.casterRelativeRandom.lower + var_18_6.z
		}

		var_18_0 = var_0_1.RandomPos(var_18_7)
	elseif arg_18_0.targetRelativeCorrdinate then
		if arg_18_2 then
			local var_18_8 = arg_18_2:GetIFF()
			local var_18_9 = arg_18_2:GetPosition()
			local var_18_10 = var_18_8 * arg_18_0.targetRelativeCorrdinate.hrz + var_18_9.x
			local var_18_11 = var_18_8 * arg_18_0.targetRelativeCorrdinate.vrt + var_18_9.z

			Vector3 = var_8
			var_18_0 = var_8(var_18_10, 0, var_18_11)
		end
	elseif arg_18_0.targetRelativeRandom and arg_18_2 then
		local var_18_12 = arg_18_2:GetIFF()
		local var_18_13 = arg_18_2:GetPosition()
		local var_18_14 = {
			X1 = var_18_12 * arg_18_0.targetRelativeRandom.front + var_18_13.x,
			X2 = var_18_12 * arg_18_0.targetRelativeRandom.rear + var_18_13.x,
			Z1 = arg_18_0.targetRelativeRandom.upper + var_18_13.z,
			Z2 = arg_18_0.targetRelativeRandom.lower + var_18_13.z
		}

		var_18_0 = var_0_1.RandomPos(var_18_14)
	end

	return var_18_0
end

function var_0_4.GetDamageSum(arg_19_0)
	return 0
end

return
