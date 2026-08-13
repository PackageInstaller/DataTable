ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleBuffEvent
local var_0_2 = var_0.Battle.BattleConst.BuffEffectType
local var_0_3 = var_0.Battle.BattleCardPuzzleFormulas

class = var_0_10004

local var_0_4 = var_0_10004("BattleCardPuzzleFleetBuffUnit")

var_0.Battle.BattleCardPuzzleFleetBuffUnit = var_0_4
var_0_4.__name = "BattleCardPuzzleFleetBuffUnit"

function var_0_4.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_2 = arg_1_2 or 1
	arg_1_0._id = arg_1_1
	arg_1_0._tempData = var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_1_1, arg_1_2)
	arg_1_0._effectList = {}
	arg_1_0._triggerSearchTable = {}
	arg_1_0._level = arg_1_2
	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_0._tempData.effect_list) do
		local var_1_0 = var_0.Battle[iter_1_1.type].New(iter_1_1)

		arg_1_0._effectList[iter_1_0] = var_1_0

		local var_1_1 = iter_1_1.trigger

		ipairs = var_10

		for iter_1_2, iter_1_3 in var_10(var_1_1) do
			local var_1_2

			if arg_1_0._triggerSearchTable[iter_1_3] == nil then
				var_1_2 = {}
				arg_1_0._triggerSearchTable[iter_1_3] = var_1_2
			end

			var_1_2[#var_1_2 + 1] = var_1_0
		end
	end

	arg_1_0:SetActive()

	return
end

function var_0_4.IsResponTo(arg_2_0, arg_2_1)
	if arg_2_0._triggerSearchTable[arg_2_1] ~= nil and #var_2 > 0 then
		return true
	end

	return false
end

function var_0_4.SetArgs(arg_3_0, arg_3_1)
	arg_3_0._host = arg_3_1
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0._effectList) do
		iter_3_1:SetArgs(arg_3_1, arg_3_0)
	end

	return
end

function var_0_4.setRemoveTime(arg_4_0)
	if arg_4_0._tempData.time == nil then
		return
	end

	local var_4_0 = arg_4_0._tempData.time

	type = var_1_10002

	local var_4_1

	if var_1_10002(var_4_0) == "string" then
		math = var_4_1
		var_4_1 = var_4_1.max

		local var_4_2 = 0
		local var_4_3 = var_0_3.parseFormula
		local var_4_4 = var_4_0
		local var_4_5 = arg_4_0._host

		arg_4_0._duration = var_4_1(var_4_2, var_4_3(var_4_4, var_8.GetAttrManager(var_4_5)))
	else
		arg_4_0._duration = var_4_0
	end

	pg = var_4_1

	local var_4_6 = var_4_1.TimeMgr.GetInstance()

	arg_4_0._expireTimeStamp = var_2.GetCombatTime(var_4_6) + arg_4_0._duration

	return
end

function var_0_4.Attach(arg_5_0, arg_5_1)
	arg_5_0._stack = 1

	arg_5_0:SetArgs(arg_5_1)
	arg_5_0:onTrigger(var_0_2.ON_ATTACH)
	arg_5_0:setRemoveTime()

	return
end

function var_0_4.Stack(arg_6_0)
	if arg_6_0._tempData.stack == 0 then
		arg_6_0._stack = arg_6_0._stack + 1
	else
		math = var_1
		arg_6_0._stack = var_1.min(arg_6_0._stack + 1, arg_6_0._tempData.stack)
	end

	arg_6_0:onTrigger(var_0_2.ON_STACK)
	arg_6_0:setRemoveTime()

	return
end

function var_0_4.InitStack(arg_7_0)
	return
end

function var_0_4.UpdateStack(arg_8_0, arg_8_1)
	return
end

function var_0_4.Remove(arg_9_0)
	arg_9_0:onTrigger(var_0_2.ON_REMOVE)

	local var_9_0 = arg_9_0._host
	local var_9_1 = var_1.GetBuffManager(var_9_0)

	var_1.GetCardPuzzleBuffList(var_9_1)[arg_9_0._id] = nil

	arg_9_0:Clear()

	return
end

function var_0_4.Update(arg_10_0, arg_10_1)
	if arg_10_0:IsExpire(arg_10_1) then
		arg_10_0:Remove()
	else
		arg_10_0:onTrigger(var_0_2.ON_UPDATE, arg_10_1)
	end

	return
end

function var_0_4.onTrigger(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._triggerSearchTable[arg_11_1] == nil or #var_3 == 0 then
		return
	end

	ipairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(var_3) do
		assert = var_1_10009
		type = var_1_10011
		var_1_10011 = var_1_10011(iter_11_1[arg_11_1]) == "function"

		var_1_10009(var_1_10011, "fleet buff效果的触发函数缺失,buff id:>>" .. arg_11_0._id .. "<<, trigger:>>" .. arg_11_1 .. "<<")

		var_1_10011 = iter_11_1

		if iter_11_1.IsActive(var_1_10011) then
			var_1_10011 = iter_11_1

			iter_11_1.NotActive(var_1_10011)

			var_1_10011 = iter_11_1

			iter_11_1.Trigger(var_1_10011, arg_11_1, arg_11_2)

			var_1_10011 = iter_11_1

			iter_11_1.SetActive(var_1_10011)
		end
	end

	return
end

function var_0_4.IsExpire(arg_12_0, arg_12_1)
	if arg_12_0._expireTimeStamp == nil then
		return false
	else
		return arg_12_1 >= arg_12_0._expireTimeStamp
	end

	return
end

function var_0_4.IsActive(arg_13_0)
	return arg_13_0._isActive
end

function var_0_4.SetActive(arg_14_0)
	arg_14_0._isActive = true

	return
end

function var_0_4.NotActive(arg_15_0)
	arg_15_0._isActive = false

	return
end

function var_0_4.GetCaster(arg_16_0)
	return nil
end

function var_0_4.GetID(arg_17_0)
	return arg_17_0._id
end

function var_0_4.GetStack(arg_18_0)
	return arg_18_0._stack
end

function var_0_4.GetLv(arg_19_0)
	return 1
end

function var_0_4.GetDurationRate(arg_20_0)
	if arg_20_0._expireTimeStamp == nil then
		return 1
	else
		pg = var_1

		local var_20_0 = var_1.TimeMgr.GetInstance()
		local var_20_1 = var_1.GetCombatTime(var_20_0)

		return (arg_20_0._expireTimeStamp - var_20_1) / arg_20_0._duration
	end

	return
end

function var_0_4.Clear(arg_21_0)
	arg_21_0._host = nil
	ipairs = var_1

	for iter_21_0, iter_21_1 in var_1(arg_21_0._effectList) do
		iter_21_1:Clear()
	end

	return
end

return
