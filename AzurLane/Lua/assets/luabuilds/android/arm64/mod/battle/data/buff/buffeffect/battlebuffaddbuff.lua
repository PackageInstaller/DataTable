ys = ys or {}

local var_0_0 = ys.Battle.BattleDataFunction
local var_0_1 = ys.Battle.BattleFormulas
local var_0_2 = class("BattleBuffAddBuff", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddBuff = var_0_2
var_0_2.__name = "BattleBuffAddBuff"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0.Battle.BattleBuffAddBuff.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._buff_id = arg_2_0._tempData.arg_list.buff_id
	arg_2_0._level = arg_2_0._tempData.arg_list.buff_level or arg_2_2:GetLv()
	arg_2_0._target = arg_2_0._tempData.arg_list.target or "TargetSelf"
	arg_2_0._time = arg_2_0._tempData.arg_list.time or 0
	arg_2_0._rant = arg_2_0._tempData.arg_list.rant or 10000
	arg_2_0._nextEffectTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_2_0._time
	arg_2_0._check_target = arg_2_0._tempData.arg_list.check_target
	arg_2_0._minTargetNumber = arg_2_0._tempData.arg_list.minTargetNumber or 0
	arg_2_0._maxTargetNumber = arg_2_0._tempData.arg_list.maxTargetNumber or 10000
	arg_2_0._isBuffStackByCheckTarget = arg_2_0._tempData.arg_list.isBuffStackByCheckTarget
	arg_2_0._countType = arg_2_0._tempData.arg_list.countType
	arg_2_0._weaponType = arg_2_0._tempData.arg_list.weaponType
	arg_2_0._repeatCount = arg_2_0._tempData.arg_list.repeat_count or 1
	arg_2_0._attrConsumeRepeat = arg_2_0._tempData.arg_list.fleetAttrConsume

	return
end

function var_0_2.onUpdate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.timeStamp >= arg_3_0._nextEffectTime then
		arg_3_0:AddBuff(arg_3_1, arg_3_3, arg_3_2)

		arg_3_0._nextEffectTime = arg_3_3.timeStamp + arg_3_0._time
	end

	return
end

function var_0_2.onBulletHit(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0:equipIndexRequire(arg_4_3.equipIndex) then
		return
	end

	local var_4_0 = arg_4_3.target

	if (not arg_4_0._weaponType or arg_4_3.weaponType == arg_4_0._weaponType) and var_4_0:IsAlive() then
		arg_4_0:attachBuff(arg_4_0._buff_id, arg_4_0._level, var_4_0, arg_4_2)
	end

	return
end

function var_0_2.onBulletCreate(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0, var_5_1

	if not arg_5_0:equipIndexRequire(arg_5_3.equipIndex) then
		do return end

		var_5_0 = arg_5_0._buff_id
		var_5_1 = arg_5_0._level
	end

	arg_5_3._bullet:SetBuffFun(arg_5_0._tempData.arg_list.bulletTrigger, function(arg_6_0, arg_6_1)
		arg_5_0:attachBuff(var_5_0, var_5_1, arg_6_0, arg_5_2)

		return
	end)

	return
end

function var_0_2.onTrigger(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_2.super.onTrigger(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:AddBuff(arg_7_1, arg_7_3, arg_7_2)

	return
end

function var_0_2.AddBuff(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0:commanderRequire(arg_8_1, arg_8_0._tempData.arg_list) then
		return
	end

	if not arg_8_0:ammoRequire(arg_8_1) then
		return
	end

	if arg_8_0._check_target then
		local var_8_0 = #arg_8_0:getTargetList(arg_8_1, arg_8_0._check_target, arg_8_0._tempData.arg_list, arg_8_2)

		if var_8_0 >= arg_8_0._minTargetNumber and var_8_0 <= arg_8_0._maxTargetNumber then
			for iter_8_0, iter_8_1 in ipairs((arg_8_0:getTargetList(arg_8_1, arg_8_0._target, arg_8_0._tempData.arg_list, arg_8_2))) do
				if arg_8_0._isBuffStackByCheckTarget then
					iter_8_1:SetBuffStack(arg_8_0._buff_id, arg_8_0._level, var_8_0)
				else
					arg_8_0:attachBuff(arg_8_0._buff_id, arg_8_0._level, iter_8_1, arg_8_3)
				end
			end
		end
	else
		for iter_8_2, iter_8_3 in ipairs((arg_8_0:getTargetList(arg_8_1, arg_8_0._target, arg_8_0._tempData.arg_list, arg_8_2))) do
			arg_8_0:attachBuff(arg_8_0._buff_id, arg_8_0._level, iter_8_3, arg_8_3)
		end
	end

	return
end

function var_0_2.attachBuff(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = var_0_0.GetBuffTemplate(arg_9_1).effect_list
	local var_9_1

	if #var_9_0 == 1 and var_9_0[1].type == "BattleBuffDOT" then
		if var_0_1.CaclulateDOTPlace(arg_9_0._rant, var_9_0[1], arg_9_0._caster, arg_9_3) then
			var_9_1 = var_0.Battle.BattleBuffUnit.New(arg_9_1, nil, arg_9_0._caster)

			var_9_1:SetOrb(arg_9_0._caster, 1)
		end
	elseif var_0_1.IsHappen(arg_9_0._rant) then
		var_9_1 = var_0.Battle.BattleBuffUnit.New(arg_9_1, arg_9_2, arg_9_0._caster)
	end

	if var_9_1 then
		var_9_1:SetCommander(arg_9_0._commander)

		local var_9_2 = arg_9_0._attrConsumeRepeat and arg_9_0:fleetAttrRepeatConsume(arg_9_0._attrConsumeRepeat) or arg_9_0:repeatCountParse(arg_9_0._repeatCount)

		if var_9_2 == -1 then
			var_9_2 = arg_9_4:GetStack()
		end

		for iter_9_0 = 1, var_9_2 do
			arg_9_3:AddBuff(var_9_1)
		end
	end

	return
end

function var_0_2.Dispose(arg_10_0)
	var_0.Battle.BattleBuffAddBuff.super:Dispose()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_10_0._timer)

	arg_10_0._timer = nil

	return
end

return
