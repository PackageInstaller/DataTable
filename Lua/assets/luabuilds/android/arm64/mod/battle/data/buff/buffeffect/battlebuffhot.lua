ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffHOT = class("BattleBuffHOT", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffHOT.__name = "BattleBuffHOT"

function ys.Battle.BattleBuffHOT.Ctor(arg_1_0, arg_1_1)
	var_0_0.Battle.BattleBuffHOT.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffHOT.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._number = arg_2_0._tempData.arg_list.number or 0
	arg_2_0._numberBase = arg_2_0._number
	arg_2_0._time = arg_2_0._tempData.arg_list.time or 0
	arg_2_0._nextEffectTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_2_0._time
	arg_2_0._maxHPRatio = arg_2_0._tempData.arg_list.maxHPRatio or 0
	arg_2_0._currentHPRatio = arg_2_0._tempData.arg_list.currentHPRatio or 0
	arg_2_0._incorruptible = arg_2_0._tempData.arg_list.incorrupt

	return
end

function ys.Battle.BattleBuffHOT.onStack(arg_3_0, arg_3_1, arg_3_2)
	return
end

function ys.Battle.BattleBuffHOT.onUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.timeStamp >= arg_4_0._nextEffectTime then
		arg_4_1:UpdateHP(arg_4_0:CalcNumber(arg_4_1, arg_4_2), {
			isMiss = false,
			isCri = false,
			isHeal = true,
			incorrupt = arg_4_0._incorruptible
		})

		if arg_4_1:IsAlive() then
			arg_4_0._nextEffectTime = arg_4_0._nextEffectTime + arg_4_0._time
		end
	end

	return
end

function ys.Battle.BattleBuffHOT.onRemove(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1:UpdateHP(arg_5_0:CalcNumber(arg_5_1, arg_5_2), {
		isMiss = false,
		isCri = false,
		isHeal = true,
		incorrupt = arg_5_0._incorruptible
	})

	return
end

function ys.Battle.BattleBuffHOT.CalcNumber(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0, var_6_1 = arg_6_1:GetHP()

	return (math.floor(math.max(0, var_6_0 * arg_6_0._currentHPRatio + var_6_1 * arg_6_0._maxHPRatio + arg_6_0._number) * arg_6_2._stack * arg_6_1:GetAttrByName("healingRate")))
end

return
