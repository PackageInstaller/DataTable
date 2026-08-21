ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffDeath = class("BattleBuffDeath", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffDeath.__name = "BattleBuffDeath"

local var_0_1 = ys.Battle.BattleBuffDeath

function ys.Battle.BattleBuffDeath.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffDeath.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._tempData.arg_list.time then
		arg_2_0._time = arg_2_0._tempData.arg_list.time + pg.TimeMgr.GetInstance():GetCombatTime()
	end

	arg_2_0._maxX = arg_2_0._tempData.arg_list.maxX
	arg_2_0._minX = arg_2_0._tempData.arg_list.minX
	arg_2_0._maxY = arg_2_0._tempData.arg_list.maxY
	arg_2_0._minY = arg_2_0._tempData.arg_list.minY
	arg_2_0._countType = arg_2_0._tempData.arg_list.countType
	arg_2_0._instantkill = arg_2_0._tempData.arg_list.instant_kill

	return
end

function ys.Battle.BattleBuffDeath.onAttach(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0._instantkill then
		arg_3_0:DoDead(arg_3_1)
	end

	return
end

function ys.Battle.BattleBuffDeath.onUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0._time and arg_4_3.timeStamp > arg_4_0._time then
		arg_4_1:SetDeathReason(var_0_0.Battle.BattleConst.UnitDeathReason.DESTRUCT)
		arg_4_0:DoDead(arg_4_1)
	else
		local var_4_0 = arg_4_1:GetPosition()

		if arg_4_0._maxX and var_4_0.x >= arg_4_0._maxX then
			arg_4_1:SetDeathReason(var_0_0.Battle.BattleConst.UnitDeathReason.LEAVE)
			arg_4_0:DoDead(arg_4_1)
		elseif arg_4_0._minX and var_4_0.x <= arg_4_0._minX then
			arg_4_1:SetDeathReason(var_0_0.Battle.BattleConst.UnitDeathReason.LEAVE)
			arg_4_0:DoDead(arg_4_1)
		elseif arg_4_0._maxY and var_4_0.z >= arg_4_0._maxY then
			arg_4_1:SetDeathReason(var_0_0.Battle.BattleConst.UnitDeathReason.LEAVE)
			arg_4_0:DoDead(arg_4_1)
		elseif arg_4_0._minY and var_4_0.z <= arg_4_0._minY then
			arg_4_1:SetDeathReason(var_0_0.Battle.BattleConst.UnitDeathReason.LEAVE)
			arg_4_0:DoDead(arg_4_1)
		end
	end

	return
end

function ys.Battle.BattleBuffDeath.onBattleBuffCount(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_3.countType == arg_5_0._countType then
		arg_5_0:DoDead(arg_5_1)
	end

	return
end

function ys.Battle.BattleBuffDeath.DoDead(arg_6_0, arg_6_1)
	arg_6_1:SetCurrentHP(0)
	arg_6_1:DeadAction()

	return
end

return
