ys = ys or {}

local var_0_0 = ys.Battle.BattleBuffEvent
local var_0_1 = ys.Battle.BattleConst.BuffEffectType
local var_0_2 = ys.Battle.BattleConfig
local var_0_3 = class("BattleBuffUnit")

ys.Battle.BattleBuffUnit = var_0_3
var_0_3.__name = "BattleBuffUnit"
var_0_3.DEFAULT_ANI_FX_CONFIG = {
	effect = "jineng",
	offset = {
		0,
		-2,
		0
	}
}

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
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
	arg_1_0._stackCap = arg_1_0._tempData.stack_cap or arg_1_0._tempData.stack

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._tempData.effect_list) do
		local var_1_0 = var_0.Battle[iter_1_1.type].New(iter_1_1)

		arg_1_0._effectList[iter_1_0] = var_1_0

		for iter_1_2, iter_1_3 in ipairs(iter_1_1.trigger) do
			local var_1_1 = arg_1_0._triggerSearchTable[iter_1_3]

			if arg_1_0._triggerSearchTable[iter_1_3] == nil then
				var_1_1 = {}
				arg_1_0._triggerSearchTable[iter_1_3] = {}
			end

			var_1_1[#var_1_1 + 1] = var_1_0
		end
	end

	return
end

function var_0_3.GetTriggerPriority(arg_2_0, arg_2_1)
	local var_2_0 = math.huge

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._tempData.effect_list) do
		local var_2_1 = var_0_2.TRIGGER_PRIORITY[arg_2_1][iter_2_1.type] or var_0_2.TRIGGER_PRIORITY_LOWEST

		var_2_0 = math.min(var_2_0, var_2_1)
	end

	return var_2_0
end

function var_0_3.SetTemplate(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._tempData = var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_3_1, arg_3_2)

	return
end

function var_0_3.Attach(arg_4_0, arg_4_1)
	arg_4_0._owner = arg_4_1
	arg_4_0._stack = 1

	arg_4_0:SetArgs(arg_4_1)
	arg_4_0:onTrigger(var_0_1.ON_ATTACH, arg_4_1)
	arg_4_0:SetRemoveTime()

	return
end

function var_0_3.Stack(arg_5_0, arg_5_1)
	arg_5_0._stack = math.min(arg_5_0._stack + 1, arg_5_0._tempData.stack)

	arg_5_0:onTrigger(var_0_1.ON_STACK, arg_5_1)
	arg_5_0:SetRemoveTime()

	return
end

function var_0_3.SetOrb(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._effectList) do
		iter_6_1:SetOrb(arg_6_0, arg_6_1, arg_6_2)
	end

	return
end

function var_0_3.SetOrbDuration(arg_7_0, arg_7_1)
	arg_7_0._time = arg_7_1 + arg_7_0._time

	return
end

function var_0_3.SetOrbLevel(arg_8_0, arg_8_1)
	arg_8_0._level = arg_8_1

	return
end

function var_0_3.SetGroupLevel(arg_9_0, arg_9_1)
	arg_9_0._groupLevel = arg_9_1

	return
end

function var_0_3.GetGroupLevel(arg_10_0)
	return arg_10_0._groupLevel or 1
end

function var_0_3.SetInfection(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._effectList) do
		if iter_11_1.SetInfection then
			iter_11_1:SetInfection(arg_11_1)
		end
	end

	return
end

function var_0_3.SetCommander(arg_12_0, arg_12_1)
	arg_12_0._commander = arg_12_1

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._effectList) do
		iter_12_1:SetCommander(arg_12_1)
	end

	return
end

function var_0_3.GetEffectList(arg_13_0)
	return arg_13_0._effectList
end

function var_0_3.GetCommander(arg_14_0)
	return arg_14_0._commander
end

function var_0_3.UpdateStack(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._stack == arg_15_2 then
		return
	end

	arg_15_0._stack = math.min(arg_15_2, arg_15_0._tempData.stack)

	arg_15_0:onTrigger(var_0_1.ON_STACK, arg_15_1)
	arg_15_0:SetRemoveTime()
	arg_15_1:DispatchEvent(var_0.Event.New(var_0_0.BUFF_STACK, {
		unit_id = arg_15_1:GetUniqueID(),
		buff_id = arg_15_0._id,
		stack_count = arg_15_0._stack
	}))

	return
end

function var_0_3.Remove(arg_16_0, arg_16_1)
	arg_16_0._owner:DispatchEvent(var_0.Event.New(var_0_0.BUFF_REMOVE, {
		unit_id = arg_16_0._owner:GetUniqueID(),
		buff_id = arg_16_0._id
	}))
	arg_16_0:onTrigger(var_0_1.ON_REMOVE, arg_16_0._owner)
	arg_16_0:Clear()

	arg_16_0._owner:GetBuffList()[arg_16_0._id] = nil

	return
end

function var_0_3.Update(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0:IsTimeToRemove(arg_17_2) then
		arg_17_0:Remove(arg_17_2)
	else
		arg_17_0:onTrigger(var_0_1.ON_UPDATE, arg_17_1, {
			timeStamp = arg_17_2
		})
	end

	return
end

function var_0_3.SetArgs(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._effectList) do
		iter_18_1:SetCaster(arg_18_0._caster)
		iter_18_1:SetArgs(arg_18_1, arg_18_0)
	end

	return
end

function var_0_3.Trigger(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:GetBuffList() or {}
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		if iter_19_1._triggerSearchTable[arg_19_1] ~= nil and #iter_19_1._triggerSearchTable[arg_19_1] > 0 then
			var_19_1[#var_19_1 + 1] = iter_19_1
		end
	end

	var_0_3.sortTriggerBuff(var_19_1, arg_19_1)

	for iter_19_2, iter_19_3 in ipairs(var_19_1) do
		iter_19_3:onTrigger(arg_19_1, arg_19_0, arg_19_2)
	end

	return
end

function var_0_3.sortTriggerBuff(arg_20_0, arg_20_1)
	if not var_0_2.TRIGGER_PRIORITY[arg_20_1] then
		return arg_20_0
	end

	table.sort(arg_20_0, function(arg_21_0, arg_21_1)
		return arg_21_0:GetTriggerPriority(arg_20_1) < arg_21_1:GetTriggerPriority(arg_20_1)
	end)

	return
end

function var_0_3.DisptachSkillFloat(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_3.trigger == nil or table.contains(arg_22_3.trigger, arg_22_2) then
		local var_22_0

		if arg_22_3.painting and type(arg_22_3.painting) == "string" then
			var_22_0 = arg_22_3
		end

		local var_22_2 = arg_22_3.displayID or arg_22_0._id

		arg_22_1:DispatchSkillFloat(var_22_1(var_22_2), nil, var_22_0)

		local var_22_3

		if arg_22_3.castCV ~= false then
			var_22_3 = arg_22_3.castCV or "skill"
		end

		local var_22_4 = type(var_22_3)

		if var_22_4 == "string" then
			arg_22_1:DispatchVoice(var_22_3)
		elseif var_22_4 == "table" then
			local var_22_5, var_22_6, var_22_7 = ShipWordHelper.GetWordAndCV(var_22_3.skinID, var_22_3.key)

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_22_6)
		end

		arg_22_1:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.ADD_EFFECT, {
			effect = var_22_8.effect,
			offset = var_22_8.offset
		}))
	end

	return
end

function var_0_3.IsSubmarineSpecial(arg_23_0)
	local var_23_0 = arg_23_0._triggerSearchTable[var_0.Battle.BattleConst.BuffEffectType.ON_SUBMARINE_FREE_SPECIAL] or {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if iter_23_1:HaveQuota() then
			return true
		end
	end

	return false
end

function var_0_3.onTrigger(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_0._triggerSearchTable[arg_24_1] == nil or #arg_24_0._triggerSearchTable[arg_24_1] == 0 then
		return
	end

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._triggerSearchTable[arg_24_1]) do
		assert(type(iter_24_1[arg_24_1]) == "function", "buff效果的触发名字和触发函数不相符,buff id:>>" .. arg_24_0._id .. "<<, trigger:>>" .. arg_24_1 .. "<<")

		if iter_24_1:HaveQuota() and iter_24_1:IsActive() then
			iter_24_1:NotActive()
			iter_24_1:Trigger(arg_24_1, arg_24_2, arg_24_0, arg_24_3)

			local var_24_0 = iter_24_1:GetPopConfig()

			if var_24_0 then
				arg_24_0:DisptachSkillFloat(arg_24_2, arg_24_1, var_24_0)
			end

			iter_24_1:SetActive()
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

function var_0_3.SetRemoveTime(arg_25_0)
	local var_25_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	arg_25_0._buffStartTimeStamp = var_25_0
	arg_25_0._RemoveTime = var_25_0 + arg_25_0._time
	arg_25_0._cancelTime = nil

	return
end

function var_0_3.IsTimeToRemove(arg_26_0, arg_26_1)
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

function var_0_3.GetBuffLifeTime(arg_27_0)
	return arg_27_0._time
end

function var_0_3.GetBuffStartTime(arg_28_0)
	return arg_28_0._buffStartTimeStamp
end

function var_0_3.Interrupt(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0._effectList) do
		iter_29_1:Interrupt()
	end

	return
end

function var_0_3.Clear(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0._effectList) do
		iter_30_1:Clear()
	end

	return
end

function var_0_3.GetID(arg_31_0)
	return arg_31_0._id
end

function var_0_3.GetCaster(arg_32_0)
	return arg_32_0._caster
end

function var_0_3.GetLv(arg_33_0)
	return arg_33_0._level or 1
end

function var_0_3.GetDuration(arg_34_0)
	return arg_34_0._time
end

function var_0_3.GetStack(arg_35_0)
	return arg_35_0._stack or 1
end

function var_0_3.IsForceStack(arg_36_0)
	return arg_36_0._forceStack
end

function var_0_3.SetToCancel(arg_37_0, arg_37_1)
	if arg_37_1 then
		arg_37_0._cancelTime = arg_37_0._cancelTime or pg.TimeMgr.GetInstance():GetCombatTime() + arg_37_1
	else
		arg_37_0._isCancel = true
	end

	return
end

function var_0_3.Dispose(arg_38_0)
	arg_38_0._triggerSearchTable = nil
	arg_38_0._commander = nil

	return
end

return
