ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffCastSkill = var_0_10002("BattleBuffCastSkill", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffCastSkill.__name = "BattleBuffCastSkill"

local var_0_2 = var_0.Battle.BattleBuffCastSkill

var_0_2.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TYPE_CASTER

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._castCount = 0
	arg_1_0._fireSkillDMGSum = 0

	return
end

function var_0_2.GetEffectType(arg_2_0)
	return var_0_2.FX_TYPE
end

function var_0_2.GetGroupData(arg_3_0)
	return arg_3_0._group
end

function var_0_2.SetArgs(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._level = arg_4_2:GetLv()
	arg_4_0._skill_id = arg_4_0._tempData.arg_list.skill_id

	local var_4_0

	if not var_3.target then
		var_4_0 = "TargetSelf"
	end

	arg_4_0._target = var_4_0
	arg_4_0._check_target = var_3.check_target
	arg_4_0._check_weapon = var_3.check_weapon
	arg_4_0._check_spweapon = var_3.check_spweapon
	arg_4_0._check_target_gap = var_3.check_target_gap

	local var_4_1

	if not var_3.time then
		var_4_1 = 0
	end

	arg_4_0._time = var_4_1
	pg = var_4_1

	local var_4_2 = var_4_1.TimeMgr.GetInstance()
	local var_4_3 = var_4.GetCombatTime(var_4_2)

	if var_3.initialCD then
		arg_4_0._nextEffectTime = var_4_3
	else
		arg_4_0._nextEffectTime = var_4_3 + arg_4_0._time
	end

	local var_4_4

	if not var_3.minTargetNumber then
		var_4_4 = 0
	end

	arg_4_0._minTargetNumber = var_4_4

	local var_4_5

	if not var_3.maxTargetNumber then
		var_4_5 = 10000
	end

	arg_4_0._maxTargetNumber = var_4_5

	local var_4_6

	if not var_3.minWeaponNumber then
		var_4_6 = 0
	end

	arg_4_0._minWeaponNumber = var_4_6

	local var_4_7

	if not var_3.maxWeaponNumber then
		var_4_7 = 10000
	end

	arg_4_0._maxWeaponNumber = var_4_7

	local var_4_8

	if not var_3.rant then
		var_4_8 = 10000
	end

	arg_4_0._rant = var_4_8
	arg_4_0._streak = var_3.streakRange
	arg_4_0._dungeonTypeList = var_3.dungeonTypeList
	arg_4_0._effectAttachData = var_3.effectAttachData

	local var_4_9

	if not var_3.repeat_count then
		var_4_9 = 1
	end

	arg_4_0._repeatCount = var_4_9
	arg_4_0._attrConsumeRepeat = var_3.fleetAttrConsume
	arg_4_0._group = var_3.group
	arg_4_0._srcBuff = arg_4_2

	return
end

function var_0_2.onBulletCreate(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0:equipIndexRequire(arg_5_3.equipIndex) then
		return
	end

	local var_5_0 = arg_5_3._bullet
	local var_5_1 = arg_5_0._tempData.arg_list.bulletTrigger

	local function var_5_2(arg_6_0, arg_6_1)
		if arg_6_0 and arg_6_0:IsAlive() then
			local var_6_0 = arg_5_0

			var_2.castSkill(var_6_0, arg_6_0, arg_6_1)
		end

		return
	end

	var_5_0:SetBuffFun(var_5_1, var_5_2)

	return
end

function var_0_2.onTrigger(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return (arg_7_0:castSkill(arg_7_1, arg_7_3, arg_7_2))
end

function var_0_2.castSkill(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	pg = var_1_10004

	local var_8_0 = var_1_10004.TimeMgr.GetInstance()
	local var_8_1 = var_4.GetCombatTime(var_8_0)

	if arg_8_0:IsInCD(var_8_1) then
		return "overheat"
	end

	if not var_0.Battle.BattleFormulas.IsHappen(arg_8_0._rant) then
		return "chance"
	end

	if arg_8_0._check_target then
		if not arg_8_0:getTargetList(arg_8_1, arg_8_0._check_target, arg_8_0._tempData.arg_list) then
			return "check target none"
		end

		if #var_5 < arg_8_0._minTargetNumber then
			return "check target min"
		end

		if var_6 > arg_8_0._maxTargetNumber then
			return "check target max"
		end
	end

	if arg_8_0._check_target_gap then
		local var_8_2 = arg_8_0:getTargetList(arg_8_1, arg_8_0._check_target_gap[1].target, arg_8_0._check_target_gap[1].arg)
		local var_8_3 = arg_8_0
		local var_8_4 = arg_8_0.getTargetList(var_8_3, arg_8_1, arg_8_0._check_target_gap[2].target, arg_8_0._check_target_gap[2].arg)

		math = var_8_3

		if var_8_3.abs(#var_8_2 - #var_8_4) < arg_8_0._minTargetNumber then
			return "check target gap min"
		end

		if var_7 > arg_8_0._maxTargetNumber then
			return "check target gap max"
		end
	end

	if arg_8_0._check_weapon then
		if #var_0_2.GetEquipmentList(arg_8_1, arg_8_0._tempData.arg_list) < arg_8_0._minWeaponNumber then
			return "check weapon min"
		end

		if var_6 > arg_8_0._maxWeaponNumber then
			return "check weapon max"
		end
	end

	if arg_8_0._check_spweapon and not var_0_2.FilterSpWeapon(arg_8_1, arg_8_0._tempData.arg_list) then
		return "check spweapon"
	end

	if arg_8_0._hpUpperBound or arg_8_0._hpLowerBound then
		local var_8_5

		if not arg_8_2 or not arg_8_2.unit then
			var_8_5 = arg_8_1:GetHPRate()
		else
			local var_8_6 = arg_8_2.unit

			var_8_5 = var_6.GetHPRate(var_8_6)
		end

		if not arg_8_0:hpIntervalRequire(var_8_5) then
			return "check hp"
		end
	end

	if arg_8_0._attrInterval then
		local var_8_7 = var_0.Battle.BattleAttr.GetBase(arg_8_1, arg_8_0._attrInterval)

		if not arg_8_0:attrIntervalRequire(var_8_7) then
			return "check interval"
		end
	end

	if arg_8_0._streak and not var_0_2.GetWinningStreak(arg_8_0._streak) then
		return "check winning streak"
	end

	if arg_8_0._dungeonTypeList and not var_0_2.GetDungeonType(arg_8_0._dungeonTypeList) then
		return "check dungeon"
	end

	if arg_8_0._effectAttachData and not arg_8_0:BuffAttachDataCondition(arg_8_3) then
		return "check attach data"
	end

	if arg_8_0._fleetAttrRequire and arg_8_2 and not arg_8_0:fleetAttrRequire(arg_8_1, arg_8_2.attr) then
		return "check fleet attr"
	end

	if arg_8_0._fleetAttrRequire then
		if arg_8_2 then
			if not arg_8_0:fleetAttrRequire(arg_8_1, arg_8_2.attr) then
				return
			end
		elseif not arg_8_0:fleetAttrRequire(arg_8_1) then
			return "check fleet attr"
		end
	end

	if arg_8_0._fleetAttrDeltaRequire and arg_8_2 and not arg_8_0:fleetAttrDelatRequire(arg_8_2.delta) then
		return "check fleet attr delta"
	end

	if not arg_8_0:stackRequire(arg_8_3) then
		return "check buff stack"
	end

	local var_8_8 = arg_8_0:getTargetList(arg_8_1, arg_8_0._target, arg_8_0._tempData.arg_list)

	var_0_2.super.onTrigger(arg_8_0, arg_8_1)

	ipairs = var_6

	for iter_8_0, iter_8_1 in var_6(var_8_8) do
		local var_8_9 = true

		if arg_8_0._group then
			local var_8_10 = iter_8_1
			local var_8_11 = iter_8_1.GetBuffList(var_8_10)

			pairs = var_8_10

			for iter_8_2, iter_8_3 in var_8_10(var_8_11) do
				ipairs = var_1_10018

				for iter_8_4, iter_8_5 in var_1_10018(iter_8_3._effectList) do
					if iter_8_5:GetEffectType() == var_0_2.FX_TYPE and iter_8_5:GetGroupData() and iter_8_5:GetGroupData().id == arg_8_0._group.id and var_23.level > arg_8_0._group.level then
						var_8_9 = false

						break
					end
				end
			end
		end

		if var_8_9 then
			local var_8_12

			if arg_8_0._attrConsumeRepeat then
				var_8_12 = arg_8_0:fleetAttrRepeatConsume(arg_8_0._attrConsumeRepeat)
			else
				var_8_12 = arg_8_0:repeatCountParse(arg_8_0._repeatCount)
			end

			if var_8_12 == -1 then
				srcBuff = var_13
				var_8_12 = var_13:GetStack()
			end

			for iter_8_6 = 1, var_8_12 do
				var_1_10018 = arg_8_0

				arg_8_0.spell(var_1_10018, iter_8_1, arg_8_2)
			end
		end
	end

	arg_8_0:enterCoolDown(var_8_1)

	return
end

function var_0_2.IsInCD(arg_9_0, arg_9_1)
	return arg_9_1 < arg_9_0._nextEffectTime
end

function var_0_2.spell(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if not arg_10_0._skill then
		var_10_0 = var_0.Battle.BattleSkillUnit.GenerateSpell

		local var_10_1 = arg_10_0._skill_id
		local var_10_2 = arg_10_0._level
		local var_10_3 = arg_10_1

		attData = var_1_10007
		var_10_0 = var_10_0(var_10_1, var_10_2, var_10_3, var_1_10007)
	end

	arg_10_0._skill = var_10_0

	if arg_10_2 and arg_10_2.target then
		local var_10_4 = arg_10_0._skill

		var_3.SetTarget(var_10_4, {
			arg_10_2.target
		})
	end

	local var_10_5 = arg_10_0._skill

	var_3.Cast(var_10_5, arg_10_1, arg_10_0._commander)

	arg_10_0._castCount = arg_10_0._castCount + 1

	return
end

function var_0_2.enterCoolDown(arg_11_0, arg_11_1)
	if arg_11_0._time and arg_11_0._time > 0 then
		arg_11_0._nextEffectTime = arg_11_1 + arg_11_0._time
	end

	return
end

function var_0_2.Interrupt(arg_12_0)
	var_0_2.super.Interrupt(arg_12_0)

	if arg_12_0._skill then
		local var_12_0 = arg_12_0._skill

		var_1.Interrupt(var_12_0)
	end

	return
end

function var_0_2.Clear(arg_13_0)
	var_0_2.super.Clear(arg_13_0)

	if arg_13_0._skill then
		local var_13_0 = arg_13_0._skill

		var_1.Clear(var_13_0)

		arg_13_0._skill = nil
	end

	return
end

function var_0_2.BuffAttachDataCondition(arg_14_0, arg_14_1)
	local var_14_0 = true
	local var_14_1 = arg_14_1
	local var_14_2 = arg_14_1.GetEffectList(var_14_1)

	ipairs = var_14_1

	for iter_14_0, iter_14_1 in var_14_1(var_14_2) do
		ipairs = var_1_10009

		for iter_14_2, iter_14_3 in var_1_10009(arg_14_0._effectAttachData) do
			local var_14_3 = var_0.Battle.BattleFormulas.parseCompareBuffAttachData(iter_14_3, iter_14_1)

			var_14_0 = var_14_0 and var_14_3
		end
	end

	return var_14_0
end

function var_0_2.GetWinningStreak(arg_15_0)
	local var_15_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_15_1 = var_1.GetWinningStreak(var_15_0)
	local var_15_2 = arg_15_0[1]
	local var_15_3 = arg_15_0[2]

	return var_15_2 <= var_15_1 and var_15_1 < var_15_3
end

function var_0_2.GetDungeonType(arg_16_0)
	local var_16_0 = var_0.Battle.BattleDataProxy.GetInstance()
	local var_16_1 = var_1.GetInitData(var_16_0).StageTmpId

	pg = var_16_0

	local var_16_2 = var_16_0.expedition_data_template[var_16_1].type

	table = var_1_10003

	return var_1_10003.contains(arg_16_0, var_16_2)
end

function var_0_2.GetEquipmentList(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:GetEquipment()
	local var_17_1 = {}

	ipairs = var_1_10004

	for iter_17_0, iter_17_1 in var_1_10004(var_17_0) do
		var_17_1[iter_17_0] = iter_17_1
	end

	local var_17_2 = #var_17_1

	while var_17_2 > 0 do
		local var_17_3 = var_17_1[var_17_2].equipment
		local var_17_4 = true

		if not var_17_3 then
			var_17_4 = false
		else
			iter_17_0 = var_0.Battle.BattleDataFunction.GetEquipDataTemplate(var_17_3.id)

			if arg_17_1.weapon_group then
				table = var_8

				if not var_8.contains(arg_17_1.weapon_group, iter_17_0.group) then
					var_17_4 = false
				end
			end

			if arg_17_1.index then
				table = var_8

				if not var_8.contains(arg_17_1.index, var_17_2) then
					var_17_4 = false
				end
			end

			if arg_17_1.type then
				table = var_8

				if not var_8.contains(arg_17_1.type, iter_17_0.type) then
					var_17_4 = false
				end
			end

			if arg_17_1.label then
				local var_17_5 = var_0.Battle.BattleDataFunction.GetWeaponDataFromID(var_17_3.id).label

				ipairs = var_9

				for iter_17_2, iter_17_3 in var_9(arg_17_1.label) do
					table = var_1_10014

					if not var_1_10014.contains(var_17_5, iter_17_3) then
						var_17_4 = false

						break
					end
				end
			end
		end

		if not var_17_4 then
			table = iter_17_0

			iter_17_0.remove(var_17_1, var_17_2)
		end

		var_17_2 = var_17_2 - 1
	end

	return var_17_1
end

function var_0_2.FilterSpWeapon(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:GetSpWeapon()
	local var_18_1 = true

	;(function()
		if not var_18_0 then
			var_18_1 = false

			return
		end

		local var_19_0 = var_0.Battle.BattleDataFunction.GetSpWeaponDataFromID
		local var_19_1 = var_18_0
		local var_19_2 = var_19_0(var_1.GetConfigID(var_19_1))

		if arg_18_1.type then
			table = var_1

			if not var_1.contains(arg_18_1.type, var_19_2.type) then
				var_18_1 = false
			end
		end

		if arg_18_1.label then
			ipairs = var_1

			for iter_19_0, iter_19_1 in var_1(arg_18_1.label) do
				table = var_2_10006

				if not var_2_10006.contains(var_19_2.label, iter_19_1) then
					var_18_1 = false

					return
				end
			end
		end

		return
	end)()

	return var_18_1 and var_18_0 or nil
end

function var_0_2.GetCastCount(arg_20_0)
	return arg_20_0._castCount
end

function var_0_2.GetSkillFireDamageSum(arg_21_0)
	math = var_1_10001

	local var_21_0 = var_1_10001.max

	if arg_21_0._skill then
		local var_21_1 = arg_21_0._skill
		local var_21_2

		if not var_2.GetDamageSum(var_21_1) then
			var_21_2 = 0
		end

		arg_21_0._fireSkillDMGSum = var_21_0(var_21_2, arg_21_0._fireSkillDMGSum)

		return arg_21_0._fireSkillDMGSum
	end
end

return
