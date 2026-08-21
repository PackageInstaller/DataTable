ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffCastSkill = class("BattleBuffCastSkill", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffCastSkill.__name = "BattleBuffCastSkill"

local var_0_1 = ys.Battle.BattleBuffCastSkill

ys.Battle.BattleBuffCastSkill.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_CASTER

function ys.Battle.BattleBuffCastSkill.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0._castCount = 0
	arg_1_0._fireSkillDMGSum = 0

	return
end

function ys.Battle.BattleBuffCastSkill.GetEffectType(arg_2_0)
	return var_0_1.FX_TYPE
end

function ys.Battle.BattleBuffCastSkill.GetGroupData(arg_3_0)
	return arg_3_0._group
end

function ys.Battle.BattleBuffCastSkill.SetArgs(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._level = arg_4_2:GetLv()

	local var_4_0 = arg_4_0._tempData.arg_list

	arg_4_0._skill_id = arg_4_0._tempData.arg_list.skill_id
	arg_4_0._target = var_4_0.target or "TargetSelf"
	arg_4_0._check_target = var_4_0.check_target
	arg_4_0._check_weapon = var_4_0.check_weapon
	arg_4_0._check_spweapon = var_4_0.check_spweapon
	arg_4_0._check_target_gap = var_4_0.check_target_gap
	arg_4_0._time = var_4_0.time or 0

	local var_4_1 = pg.TimeMgr.GetInstance():GetCombatTime()

	arg_4_0._nextEffectTime = var_4_0.initialCD and var_4_1 or var_4_1 + arg_4_0._time
	arg_4_0._minTargetNumber = var_4_0.minTargetNumber or 0
	arg_4_0._maxTargetNumber = var_4_0.maxTargetNumber or 10000
	arg_4_0._minWeaponNumber = var_4_0.minWeaponNumber or 0
	arg_4_0._maxWeaponNumber = var_4_0.maxWeaponNumber or 10000
	arg_4_0._rant = var_4_0.rant or 10000
	arg_4_0._streak = var_4_0.streakRange
	arg_4_0._dungeonTypeList = var_4_0.dungeonTypeList
	arg_4_0._effectAttachData = var_4_0.effectAttachData
	arg_4_0._repeatCount = var_4_0.repeat_count or 1
	arg_4_0._attrConsumeRepeat = var_4_0.fleetAttrConsume
	arg_4_0._group = var_4_0.group
	arg_4_0._srcBuff = arg_4_2

	return
end

function ys.Battle.BattleBuffCastSkill.onBulletCreate(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0:equipIndexRequire(arg_5_3.equipIndex) then
		return
	end

	arg_5_3._bullet:SetBuffFun(arg_5_0._tempData.arg_list.bulletTrigger, function(arg_6_0, arg_6_1)
		if arg_6_0 and arg_6_0:IsAlive() then
			arg_5_0:castSkill(arg_6_0, arg_6_1)
		end

		return
	end)

	return
end

function ys.Battle.BattleBuffCastSkill.onTrigger(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return (arg_7_0:castSkill(arg_7_1, arg_7_3, arg_7_2))
end

function ys.Battle.BattleBuffCastSkill.castSkill(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if arg_8_0:IsInCD(var_8_0) then
		return "overheat"
	end

	if not var_0_0.Battle.BattleFormulas.IsHappen(arg_8_0._rant) then
		return "chance"
	end

	if arg_8_0._check_target then
		local var_8_1 = arg_8_0:getTargetList(arg_8_1, arg_8_0._check_target, arg_8_0._tempData.arg_list)

		if not var_8_1 then
			return "check target none"
		end

		local var_8_2 = #var_8_1

		if #var_8_1 < arg_8_0._minTargetNumber then
			return "check target min"
		end

		if var_8_2 > arg_8_0._maxTargetNumber then
			return "check target max"
		end
	end

	if arg_8_0._check_target_gap then
		local var_8_3 = math.abs(#arg_8_0:getTargetList(arg_8_1, arg_8_0._check_target_gap[1].target, arg_8_0._check_target_gap[1].arg) - #arg_8_0:getTargetList(arg_8_1, arg_8_0._check_target_gap[2].target, arg_8_0._check_target_gap[2].arg))

		if var_8_3 < arg_8_0._minTargetNumber then
			return "check target gap min"
		end

		if var_8_3 > arg_8_0._maxTargetNumber then
			return "check target gap max"
		end
	end

	if arg_8_0._check_weapon then
		local var_8_4 = #var_0_1.GetEquipmentList(arg_8_1, arg_8_0._tempData.arg_list)

		if var_8_4 < arg_8_0._minWeaponNumber then
			return "check weapon min"
		end

		if var_8_4 > arg_8_0._maxWeaponNumber then
			return "check weapon max"
		end
	end

	if arg_8_0._check_spweapon and not var_0_1.FilterSpWeapon(arg_8_1, arg_8_0._tempData.arg_list) then
		return "check spweapon"
	end

	if arg_8_0._hpUpperBound or arg_8_0._hpLowerBound then
		local var_8_5 = (not arg_8_2 or not arg_8_2.unit) and arg_8_1:GetHPRate() or arg_8_2.unit:GetHPRate()

		if not arg_8_0:hpIntervalRequire(var_8_5) then
			return "check hp"
		end
	end

	if arg_8_0._attrInterval and not arg_8_0:attrIntervalRequire((var_0_0.Battle.BattleAttr.GetBase(arg_8_1, arg_8_0._attrInterval))) then
		return "check interval"
	end

	if arg_8_0._streak and not var_0_1.GetWinningStreak(arg_8_0._streak) then
		return "check winning streak"
	end

	if arg_8_0._dungeonTypeList and not var_0_1.GetDungeonType(arg_8_0._dungeonTypeList) then
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

	local var_8_6 = arg_8_0:getTargetList(arg_8_1, arg_8_0._target, arg_8_0._tempData.arg_list)

	var_0_1.super.onTrigger(arg_8_0, arg_8_1)

	for iter_8_0, iter_8_1 in ipairs(var_8_6) do
		local var_8_7 = true

		if arg_8_0._group then
			for iter_8_2, iter_8_3 in pairs((iter_8_1:GetBuffList())) do
				for iter_8_4, iter_8_5 in ipairs(iter_8_3._effectList) do
					if iter_8_5:GetEffectType() == var_0_1.FX_TYPE and iter_8_5:GetGroupData() then
						local var_8_8 = iter_8_5:GetGroupData()

						if var_8_8.id == arg_8_0._group.id and var_8_8.level > arg_8_0._group.level then
							var_8_7 = false

							break
						end
					end
				end
			end
		end

		if var_8_7 then
			local var_8_9 = arg_8_0._attrConsumeRepeat and arg_8_0:fleetAttrRepeatConsume(arg_8_0._attrConsumeRepeat) or arg_8_0:repeatCountParse(arg_8_0._repeatCount)

			if var_8_9 == -1 then
				var_8_9 = srcBuff:GetStack()
			end

			for iter_8_6 = 1, var_8_9 do
				arg_8_0:spell(iter_8_1, arg_8_2)
			end
		end
	end

	arg_8_0:enterCoolDown(var_8_0)

	return
end

function ys.Battle.BattleBuffCastSkill.IsInCD(arg_9_0, arg_9_1)
	return arg_9_1 < arg_9_0._nextEffectTime
end

function ys.Battle.BattleBuffCastSkill.spell(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._skill = arg_10_0._skill or var_0_0.Battle.BattleSkillUnit.GenerateSpell(arg_10_0._skill_id, arg_10_0._level, arg_10_1, attData)

	if arg_10_2 and arg_10_2.target then
		arg_10_0._skill:SetTarget({
			arg_10_2.target
		})
	end

	arg_10_0._skill:Cast(arg_10_1, arg_10_0._commander)

	arg_10_0._castCount = arg_10_0._castCount + 1

	return
end

function ys.Battle.BattleBuffCastSkill.enterCoolDown(arg_11_0, arg_11_1)
	if arg_11_0._time and arg_11_0._time > 0 then
		arg_11_0._nextEffectTime = arg_11_1 + arg_11_0._time
	end

	return
end

function ys.Battle.BattleBuffCastSkill.Interrupt(arg_12_0)
	var_0_1.super.Interrupt(arg_12_0)

	if arg_12_0._skill then
		arg_12_0._skill:Interrupt()
	end

	return
end

function ys.Battle.BattleBuffCastSkill.Clear(arg_13_0)
	var_0_1.super.Clear(arg_13_0)

	if arg_13_0._skill then
		arg_13_0._skill:Clear()

		arg_13_0._skill = nil
	end

	return
end

function ys.Battle.BattleBuffCastSkill.BuffAttachDataCondition(arg_14_0, arg_14_1)
	local var_14_0 = true

	for iter_14_0, iter_14_1 in ipairs((arg_14_1:GetEffectList())) do
		for iter_14_2, iter_14_3 in ipairs(arg_14_0._effectAttachData) do
			local var_14_1 = var_0_0.Battle.BattleFormulas.parseCompareBuffAttachData(iter_14_3, iter_14_1)

			var_14_0 = var_14_0 and var_14_1
		end
	end

	return var_14_0
end

function ys.Battle.BattleBuffCastSkill.GetWinningStreak(arg_15_0)
	local var_15_0 = var_0_0.Battle.BattleDataProxy.GetInstance():GetWinningStreak()
	local var_15_1 = arg_15_0[2]

	return arg_15_0[1] <= var_15_0 and var_15_0 < var_15_1
end

function ys.Battle.BattleBuffCastSkill.GetDungeonType(arg_16_0)
	return table.contains(arg_16_0, pg.expedition_data_template[var_0_0.Battle.BattleDataProxy.GetInstance():GetInitData().StageTmpId].type)
end

function ys.Battle.BattleBuffCastSkill.GetEquipmentList(arg_17_0, arg_17_1)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs((arg_17_0:GetEquipment())) do
		var_17_0[iter_17_0] = iter_17_1
	end

	local var_17_1 = #var_17_0

	while var_17_1 > 0 do
		local var_17_2 = true

		if not var_17_0[var_17_1].equipment then
			var_17_2 = false
		else
			local var_17_3 = var_0_0.Battle.BattleDataFunction.GetEquipDataTemplate(var_17_0[var_17_1].equipment.id)

			if arg_17_1.weapon_group and not table.contains(arg_17_1.weapon_group, var_17_3.group) then
				var_17_2 = false
			end

			if arg_17_1.index and not table.contains(arg_17_1.index, var_17_1) then
				var_17_2 = false
			end

			if arg_17_1.type and not table.contains(arg_17_1.type, var_17_3.type) then
				var_17_2 = false
			end

			if arg_17_1.label then
				local var_17_4 = var_0_0.Battle.BattleDataFunction.GetWeaponDataFromID(var_17_0[var_17_1].equipment.id).label

				for iter_17_2, iter_17_3 in ipairs(arg_17_1.label) do
					if not table.contains(var_17_4, iter_17_3) then
						var_17_2 = false

						break
					end
				end
			end
		end

		if not var_17_2 then
			table.remove(var_17_0, var_17_1)
		end

		var_17_1 = var_17_1 - 1
	end

	return var_17_0
end

function ys.Battle.BattleBuffCastSkill.FilterSpWeapon(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:GetSpWeapon()
	local var_18_1 = true

	;(function()
		if not var_18_0 then
			var_18_1 = false

			return
		end

		local var_19_0 = var_0_0.Battle.BattleDataFunction.GetSpWeaponDataFromID(var_18_0:GetConfigID())

		if arg_18_1.type and not table.contains(arg_18_1.type, var_19_0.type) then
			var_18_1 = false
		end

		if arg_18_1.label then
			for iter_19_0, iter_19_1 in ipairs(arg_18_1.label) do
				if not table.contains(var_19_0.label, iter_19_1) then
					var_18_1 = false

					return
				end
			end
		end

		return
	end)()

	return var_18_1 and var_18_0 or nil
end

function ys.Battle.BattleBuffCastSkill.GetCastCount(arg_20_0)
	return arg_20_0._castCount
end

function ys.Battle.BattleBuffCastSkill.GetSkillFireDamageSum(arg_21_0)
	local var_21_0 = arg_21_0._skill and arg_21_0._skill:GetDamageSum() or 0

	arg_21_0._fireSkillDMGSum = math.max(var_21_0, arg_21_0._fireSkillDMGSum)

	return arg_21_0._fireSkillDMGSum
end

return
