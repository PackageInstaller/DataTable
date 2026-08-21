ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleFormulas
local var_0_2 = ys.Battle.BattleUnitEvent

ys.Battle.BattleSkillEffect = class("BattleSkillEffect")
ys.Battle.BattleSkillEffect.__name = "BattleSkillEffect"

function ys.Battle.BattleSkillEffect.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tempData = arg_1_1
	arg_1_0._type = arg_1_0._tempData.type
	arg_1_0._targetChoise = arg_1_0._tempData.target_choise or "TargetNull"
	arg_1_0._casterAniEffect = arg_1_0._tempData.casterAniEffect
	arg_1_0._targetAniEffect = arg_1_0._tempData.targetAniEffect
	arg_1_0._delay = arg_1_0._tempData.arg_list.delay or 0
	arg_1_0._lastEffectTarget = {}
	arg_1_0._timerList = {}
	arg_1_0._timerIndex = 0
	arg_1_0._level = arg_1_2

	return
end

function ys.Battle.BattleSkillEffect.SetCommander(arg_2_0, arg_2_1)
	arg_2_0._commander = arg_2_1

	return
end

function ys.Battle.BattleSkillEffect.Effect(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 and #arg_3_2 > 0 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
			arg_3_0:AniEffect(arg_3_1, iter_3_1)
			arg_3_0:DataEffect(arg_3_1, iter_3_1, arg_3_3)
		end
	else
		arg_3_0:DataEffectWithoutTarget(arg_3_1, arg_3_3)
	end

	return
end

function ys.Battle.BattleSkillEffect.IsFinaleEffect(arg_4_0)
	return false
end

function ys.Battle.BattleSkillEffect.SetFinaleCallback(arg_5_0, arg_5_1)
	arg_5_0._finaleCallback = arg_5_1

	return
end

function ys.Battle.BattleSkillEffect.AniEffect(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2:GetPosition()
	local var_6_1 = arg_6_1:GetPosition()

	if arg_6_0._casterAniEffect and arg_6_0._casterAniEffect ~= "" then
		local var_6_2 = arg_6_0._casterAniEffect
		local var_6_3

		if arg_6_0._casterAniEffect.posFun then
			function var_6_3(arg_7_0)
				return var_6_2.posFun(var_6_1, var_6_0, arg_7_0)
			end
		end

		arg_6_1:DispatchEvent(var_0_0.Event.New(var_0_2.ADD_EFFECT, {
			effect = arg_6_0._casterAniEffect.effect,
			offset = arg_6_0._casterAniEffect.offset,
			posFun = var_6_3
		}))
	end

	if arg_6_0._targetAniEffect and arg_6_0._targetAniEffect ~= "" then
		local var_6_4 = arg_6_0._targetAniEffect
		local var_6_5

		if arg_6_0._targetAniEffect.posFun then
			function var_6_5(arg_8_0)
				return var_6_4.posFun(var_6_1, var_6_0, arg_8_0)
			end
		end

		arg_6_2:DispatchEvent(var_0_0.Event.New(var_0_2.ADD_EFFECT, {
			effect = arg_6_0._targetAniEffect.effect,
			offset = arg_6_0._targetAniEffect.offset,
			posFun = var_6_5
		}))
	end

	return
end

function ys.Battle.BattleSkillEffect.DataEffect(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0._delay > 0 then
		local var_9_0
		local var_9_1 = arg_9_0._timerIndex + 1

		arg_9_0._timerIndex = arg_9_0._timerIndex + 1
		arg_9_0._timerList[arg_9_0._timerIndex + 1] = pg.TimeMgr.GetInstance():AddBattleTimer("BattleSkill", -1, arg_9_0._delay, function()
			if arg_9_1 and arg_9_1:IsAlive() then
				arg_9_0:DoDataEffect(arg_9_1, arg_9_2, arg_9_3)
			end

			pg.TimeMgr.GetInstance():RemoveBattleTimer(var_9_0)

			arg_9_0._timerList[var_9_1] = nil

			return
		end, true)
	else
		arg_9_0:DoDataEffect(arg_9_1, arg_9_2, arg_9_3)
	end

	return
end

function ys.Battle.BattleSkillEffect.DoDataEffect(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return
end

function ys.Battle.BattleSkillEffect.DataEffectWithoutTarget(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._delay > 0 then
		local var_12_0
		local var_12_1 = arg_12_0._timerIndex + 1

		arg_12_0._timerIndex = arg_12_0._timerIndex + 1
		arg_12_0._timerList[arg_12_0._timerIndex + 1] = pg.TimeMgr.GetInstance():AddBattleTimer("BattleSkill", -1, arg_12_0._delay, function()
			if arg_12_1 and arg_12_1:IsAlive() then
				arg_12_0:DoDataEffectWithoutTarget(arg_12_1, arg_12_2)
			end

			pg.TimeMgr.GetInstance():RemoveBattleTimer(var_12_0)

			arg_12_0._timerList[var_12_1] = nil

			return
		end, true)
	else
		arg_12_0:DoDataEffectWithoutTarget(arg_12_1, arg_12_2)
	end

	return
end

function ys.Battle.BattleSkillEffect.DoDataEffectWithoutTarget(arg_14_0, arg_14_1, arg_14_2)
	return
end

function ys.Battle.BattleSkillEffect.GetTarget(arg_15_0, arg_15_1, arg_15_2)
	if type(arg_15_0._targetChoise) == "string" then
		if arg_15_0._targetChoise == "TargetSameToLastEffect" then
			return arg_15_2._lastEffectTarget
		else
			return var_0_0.Battle.BattleTargetChoise[arg_15_0._targetChoise](arg_15_1, arg_15_0._tempData.arg_list)
		end
	elseif type(arg_15_0._targetChoise) == "table" then
		local var_15_0

		for iter_15_0, iter_15_1 in ipairs(arg_15_0._targetChoise) do
			var_15_0 = var_0_0.Battle.BattleTargetChoise[iter_15_1](arg_15_1, arg_15_0._tempData.arg_list, var_15_0)
		end

		return var_15_0
	end

	return
end

function ys.Battle.BattleSkillEffect.Interrupt(arg_16_0)
	return
end

function ys.Battle.BattleSkillEffect.Clear(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._timerList) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_17_1)

		arg_17_0._timerList[iter_17_0] = nil
	end

	arg_17_0._commander = nil

	return
end

function ys.Battle.BattleSkillEffect.calcCorrdinate(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0

	if arg_18_0.absoulteCorrdinate then
		var_18_0 = Vector3(arg_18_0.absoulteCorrdinate.x, 0, arg_18_0.absoulteCorrdinate.z)
	elseif arg_18_0.absoulteRandom then
		var_18_0 = var_0_1.RandomPos(arg_18_0.absoulteRandom)
	elseif arg_18_0.casterRelativeCorrdinate then
		local var_18_1 = arg_18_1:GetIFF()
		local var_18_2 = arg_18_1:GetPosition()

		var_18_0 = Vector3(var_18_1 * arg_18_0.casterRelativeCorrdinate.hrz + var_18_2.x, 0, var_18_1 * arg_18_0.casterRelativeCorrdinate.vrt + var_18_2.z)
	elseif arg_18_0.casterRelativeRandom then
		local var_18_3 = arg_18_1:GetIFF()
		local var_18_4 = arg_18_1:GetPosition()

		var_18_0 = var_0_1.RandomPos({
			X1 = var_18_3 * arg_18_0.casterRelativeRandom.front + var_18_4.x,
			X2 = var_18_3 * arg_18_0.casterRelativeRandom.rear + var_18_4.x,
			Z1 = arg_18_0.casterRelativeRandom.upper + var_18_4.z,
			Z2 = arg_18_0.casterRelativeRandom.lower + var_18_4.z
		})
	elseif arg_18_0.targetRelativeCorrdinate then
		if arg_18_2 then
			local var_18_5 = arg_18_2:GetIFF()
			local var_18_6 = arg_18_2:GetPosition()

			var_18_0 = Vector3(var_18_5 * arg_18_0.targetRelativeCorrdinate.hrz + var_18_6.x, 0, var_18_5 * arg_18_0.targetRelativeCorrdinate.vrt + var_18_6.z)
		end
	elseif arg_18_0.targetRelativeRandom and arg_18_2 then
		local var_18_7 = arg_18_2:GetIFF()
		local var_18_8 = arg_18_2:GetPosition()

		var_18_0 = var_0_1.RandomPos({
			X1 = var_18_7 * arg_18_0.targetRelativeRandom.front + var_18_8.x,
			X2 = var_18_7 * arg_18_0.targetRelativeRandom.rear + var_18_8.x,
			Z1 = arg_18_0.targetRelativeRandom.upper + var_18_8.z,
			Z2 = arg_18_0.targetRelativeRandom.lower + var_18_8.z
		})
	end

	return var_18_0
end

function ys.Battle.BattleSkillEffect.GetDamageSum(arg_19_0)
	return 0
end

return
