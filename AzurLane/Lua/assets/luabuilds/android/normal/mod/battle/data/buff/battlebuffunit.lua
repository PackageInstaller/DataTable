ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleBuffEvent
local var_0_2 = var_0.Battle.BattleConst.BuffEffectType
local var_0_3 = var_0.Battle.BattleConfig

class = var_0_10004

local var_0_4 = var_0_10004("BattleBuffUnit")

var_0.Battle.BattleBuffUnit = var_0_4
var_0_4.__name = "BattleBuffUnit"
var_0_4.DEFAULT_ANI_FX_CONFIG = {
	effect = "jineng",
	offset = {
		0,
		-2,
		0
	}
}

function var_0_4.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_2 = arg_1_2 or 1
	arg_1_0._id = arg_1_1

	arg_1_0:SetTemplate(arg_1_1, arg_1_2)

	arg_1_0._time = arg_1_0._tempData.time
	arg_1_0._RemoveTime = 0
	arg_1_0._effectList = {}
	arg_1_0._triggerSearchTable = {}
	arg_1_0._level = arg_1_2
	arg_1_0._caster = arg_1_3
	arg_1_0._forceStack = arg_1_0._tempData.force_stack

	local var_1_0

	if not arg_1_0._tempData.stack_cap then
		var_1_0 = arg_1_0._tempData.stack
	end

	arg_1_0._stackCap = var_1_0
	ipairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(arg_1_0._tempData.effect_list) do
		local var_1_1 = var_0.Battle[iter_1_1.type].New(iter_1_1)

		arg_1_0._effectList[iter_1_0] = var_1_1

		local var_1_2 = iter_1_1.trigger

		ipairs = var_1_10011

		for iter_1_2, iter_1_3 in var_1_10011(var_1_2) do
			local var_1_3

			if arg_1_0._triggerSearchTable[iter_1_3] == nil then
				var_1_3 = {}
				arg_1_0._triggerSearchTable[iter_1_3] = var_1_3
			end

			var_1_3[#var_1_3 + 1] = var_1_1
		end
	end

	return
end

function var_0_4.GetTriggerPriority(arg_2_0, arg_2_1)
	local var_2_0 = var_0_3.TRIGGER_PRIORITY[arg_2_1]

	math = var_1_10003

	local var_2_1 = var_1_10003.huge

	ipairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(arg_2_0._tempData.effect_list) do
		local var_2_2

		if not var_2_0[iter_2_1.type] then
			var_2_2 = var_0_3.TRIGGER_PRIORITY_LOWEST
		end

		math = var_1_10010
		var_2_1 = var_1_10010.min(var_2_1, var_2_2)
	end

	return var_2_1
end

function var_0_4.SetTemplate(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._tempData = var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_3_1, arg_3_2)

	return
end

function var_0_4.Attach(arg_4_0, arg_4_1)
	arg_4_0._owner = arg_4_1
	arg_4_0._stack = 1

	arg_4_0:SetArgs(arg_4_1)
	arg_4_0:onTrigger(var_0_2.ON_ATTACH, arg_4_1)
	arg_4_0:SetRemoveTime()

	return
end

function var_0_4.Stack(arg_5_0, arg_5_1)
	math = var_1_10002
	arg_5_0._stack = var_1_10002.min(arg_5_0._stack + 1, arg_5_0._tempData.stack)

	arg_5_0:onTrigger(var_0_2.ON_STACK, arg_5_1)
	arg_5_0:SetRemoveTime()

	return
end

function var_0_4.SetOrb(arg_6_0, arg_6_1, arg_6_2)
	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0._effectList) do
		iter_6_1:SetOrb(arg_6_0, arg_6_1, arg_6_2)
	end

	return
end

function var_0_4.SetOrbDuration(arg_7_0, arg_7_1)
	arg_7_0._time = arg_7_1 + arg_7_0._time

	return
end

function var_0_4.SetOrbLevel(arg_8_0, arg_8_1)
	arg_8_0._level = arg_8_1

	return
end

function var_0_4.SetGroupLevel(arg_9_0, arg_9_1)
	arg_9_0._groupLevel = arg_9_1

	return
end

function var_0_4.GetGroupLevel(arg_10_0)
	local var_10_0

	if not arg_10_0._groupLevel then
		var_10_0 = 1
	end

	return var_10_0
end

function var_0_4.SetInfection(arg_11_0, arg_11_1)
	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0._effectList) do
		if iter_11_1.SetInfection then
			iter_11_1:SetInfection(arg_11_1)
		end
	end

	return
end

function var_0_4.SetCommander(arg_12_0, arg_12_1)
	arg_12_0._commander = arg_12_1
	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0._effectList) do
		iter_12_1:SetCommander(arg_12_1)
	end

	return
end

function var_0_4.GetEffectList(arg_13_0)
	return arg_13_0._effectList
end

function var_0_4.GetCommander(arg_14_0)
	return arg_14_0._commander
end

function var_0_4.UpdateStack(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._stack == arg_15_2 then
		return
	end

	math = var_3
	arg_15_0._stack = var_3.min(arg_15_2, arg_15_0._tempData.stack)

	arg_15_0:onTrigger(var_0_2.ON_STACK, arg_15_1)
	arg_15_0:SetRemoveTime()

	local var_15_0 = {
		unit_id = arg_15_1:GetUniqueID(),
		buff_id = arg_15_0._id,
		stack_count = arg_15_0._stack
	}

	arg_15_1:DispatchEvent(var_0.Event.New(var_0_1.BUFF_STACK, var_15_0))

	return
end

function var_0_4.Remove(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._owner
	local var_16_1 = arg_16_0._id
	local var_16_2 = {
		unit_id = var_16_0:GetUniqueID(),
		buff_id = var_16_1
	}

	var_16_0:DispatchEvent(var_0.Event.New(var_0_1.BUFF_REMOVE, var_16_2))
	arg_16_0:onTrigger(var_0_2.ON_REMOVE, var_16_0)
	arg_16_0:Clear()

	var_16_0:GetBuffList()[var_16_1] = nil

	return
end

function var_0_4.Update(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0:IsTimeToRemove(arg_17_2) then
		arg_17_0:Remove(arg_17_2)
	else
		arg_17_0:onTrigger(var_0_2.ON_UPDATE, arg_17_1, {
			timeStamp = arg_17_2
		})
	end

	return
end

function var_0_4.SetArgs(arg_18_0, arg_18_1)
	ipairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0._effectList) do
		iter_18_1:SetCaster(arg_18_0._caster)
		iter_18_1:SetArgs(arg_18_1, arg_18_0)
	end

	return
end

function var_0_4.Trigger(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0

	if not arg_19_0:GetBuffList() then
		var_19_0 = {}
	end

	local var_19_1 = {}

	pairs = var_1_10005

	for iter_19_0, iter_19_1 in var_1_10005(var_19_0) do
		if iter_19_1._triggerSearchTable[arg_19_1] ~= nil and #var_10 > 0 then
			var_19_1[#var_19_1 + 1] = iter_19_1
		end
	end

	var_0_4.sortTriggerBuff(var_19_1, arg_19_1)

	ipairs = var_5

	for iter_19_2, iter_19_3 in var_5(var_19_1) do
		iter_19_3:onTrigger(arg_19_1, arg_19_0, arg_19_2)
	end

	return
end

function var_0_4.sortTriggerBuff(arg_20_0, arg_20_1)
	if not var_0_3.TRIGGER_PRIORITY[arg_20_1] then
		return arg_20_0
	end

	local var_20_0 = var_0_3.TRIGGER_PRIORITY[arg_20_1]

	table = var_1_10003

	var_1_10003.sort(arg_20_0, function(arg_21_0, arg_21_1)
		return arg_21_0:GetTriggerPriority(arg_20_1) < arg_21_1:GetTriggerPriority(arg_20_1)
	end)

	return
end

function var_0_4.DisptachSkillFloat(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_3.trigger ~= nil then
		table = var_4

		if var_4.contains(arg_22_3.trigger, arg_22_2) then
			local var_22_0

			if arg_22_3.painting then
				type = var_5

				if var_5(arg_22_3.painting) == "string" then
					var_22_0 = arg_22_3
				end
			end

			getSkillName = var_5

			local var_22_1

			if not arg_22_3.displayID then
				var_22_1 = arg_22_0._id
			end

			local var_22_2 = var_5(var_22_1)

			arg_22_1:DispatchSkillFloat(var_22_2, nil, var_22_0)

			local var_22_3

			if arg_22_3.castCV ~= false then
				var_22_3 = arg_22_3.castCV or "skill"
			end

			type = var_7

			if var_7(var_22_3) == "string" then
				arg_22_1:DispatchVoice(var_22_3)
			elseif var_7 == "table" then
				ShipWordHelper = var_8

				local var_22_4, var_22_5, var_22_6 = var_8.GetWordAndCV(var_22_3.skinID, var_22_3.key)

				pg = var_1_10011

				local var_22_7 = var_1_10011.CriMgr.GetInstance()

				var_11.PlaySoundEffect_V3(var_22_7, var_22_5)
			end

			local var_22_8

			if not arg_22_3.aniEffect then
				var_22_8 = var_0_4.DEFAULT_ANI_FX_CONFIG
			end

			local var_22_9 = {
				effect = var_22_8.effect,
				offset = var_22_8.offset
			}

			arg_22_1:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.ADD_EFFECT, var_22_9))
		end

		return
	end
end

function var_0_4.IsSubmarineSpecial(arg_23_0)
	local var_23_0

	if not arg_23_0._triggerSearchTable[var_0.Battle.BattleConst.BuffEffectType.ON_SUBMARINE_FREE_SPECIAL] then
		var_23_0 = {}
	end

	ipairs = var_2

	for iter_23_0, iter_23_1 in var_2(var_23_0) do
		if iter_23_1:HaveQuota() then
			return true
		end
	end

	return false
end

function var_0_4.onTrigger(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_0._triggerSearchTable[arg_24_1] == nil or #var_4 == 0 then
		return
	end

	ipairs = var_1_10005

	for iter_24_0, iter_24_1 in var_1_10005(var_4) do
		assert = var_1_10010
		type = var_1_10011
		var_1_10011 = var_1_10011(iter_24_1[arg_24_1]) == "function"

		var_1_10010(var_1_10011, "buff效果的触发名字和触发函数不相符,buff id:>>" .. arg_24_0._id .. "<<, trigger:>>" .. arg_24_1 .. "<<")

		var_1_10011 = iter_24_1

		if iter_24_1.HaveQuota(var_1_10011) then
			var_1_10011 = iter_24_1

			if iter_24_1.IsActive(var_1_10011) then
				var_1_10011 = iter_24_1

				iter_24_1.NotActive(var_1_10011)

				var_1_10011 = iter_24_1

				iter_24_1.Trigger(var_1_10011, arg_24_1, arg_24_2, arg_24_0, arg_24_3)

				var_1_10011 = iter_24_1

				if iter_24_1.GetPopConfig(var_1_10011) then
					arg_24_0:DisptachSkillFloat(arg_24_2, arg_24_1, var_1_10010)
				end

				iter_24_1:SetActive()
			end
		end

		if arg_24_0._isCancel then
			break
		end
	end

	if arg_24_0._isCancel then
		arg_24_0._isCancel = nil

		arg_24_0:Remove()
	end

	return
end

function var_0_4.SetRemoveTime(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.TimeMgr.GetInstance()

	arg_25_0._buffStartTimeStamp = var_1.GetCombatTime(var_25_0)
	arg_25_0._RemoveTime = var_1 + arg_25_0._time
	arg_25_0._cancelTime = nil

	return
end

function var_0_4.IsTimeToRemove(arg_26_0, arg_26_1)
	if arg_26_0._isCancel then
		return true
	elseif arg_26_0._cancelTime and arg_26_1 >= arg_26_0._cancelTime then
		return true
	elseif arg_26_0._time == 0 then
		return false
	else
		return arg_26_1 >= arg_26_0._RemoveTime
	end

	return
end

function var_0_4.GetBuffLifeTime(arg_27_0)
	return arg_27_0._time
end

function var_0_4.GetBuffStartTime(arg_28_0)
	return arg_28_0._buffStartTimeStamp
end

function var_0_4.Interrupt(arg_29_0)
	ipairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0._effectList) do
		iter_29_1:Interrupt()
	end

	return
end

function var_0_4.Clear(arg_30_0)
	ipairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0._effectList) do
		iter_30_1:Clear()
	end

	return
end

function var_0_4.GetID(arg_31_0)
	return arg_31_0._id
end

function var_0_4.GetCaster(arg_32_0)
	return arg_32_0._caster
end

function var_0_4.GetLv(arg_33_0)
	local var_33_0

	if not arg_33_0._level then
		var_33_0 = 1
	end

	return var_33_0
end

function var_0_4.GetDuration(arg_34_0)
	return arg_34_0._time
end

function var_0_4.GetStack(arg_35_0)
	local var_35_0

	if not arg_35_0._stack then
		var_35_0 = 1
	end

	return var_35_0
end

function var_0_4.IsForceStack(arg_36_0)
	return arg_36_0._forceStack
end

function var_0_4.SetToCancel(arg_37_0, arg_37_1)
	if arg_37_1 then
		if not arg_37_0._cancelTime then
			pg = var_2

			local var_37_0 = var_2.TimeMgr.GetInstance()

			arg_37_0._cancelTime = var_2.GetCombatTime(var_37_0) + arg_37_1
		end
	else
		arg_37_0._isCancel = true
	end

	return
end

function var_0_4.Dispose(arg_38_0)
	arg_38_0._triggerSearchTable = nil
	arg_38_0._commander = nil

	return
end

return
