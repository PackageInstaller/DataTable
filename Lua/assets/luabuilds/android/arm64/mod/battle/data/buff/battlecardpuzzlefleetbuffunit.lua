ys = ys or {}

local var_0_1 = ys.Battle.BattleConst.BuffEffectType
local var_0_2 = ys.Battle.BattleCardPuzzleFormulas
local var_0_3 = class("BattleCardPuzzleFleetBuffUnit")

ys.Battle.BattleCardPuzzleFleetBuffUnit = var_0_3
var_0_3.__name = "BattleCardPuzzleFleetBuffUnit"

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_2 = arg_1_2 or 1
	arg_1_0._id = arg_1_1
	arg_1_0._tempData = var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_1_1, arg_1_2)
	arg_1_0._effectList = {}
	arg_1_0._triggerSearchTable = {}
	arg_1_0._level = arg_1_2

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

	arg_1_0:SetActive()

	return
end

function var_0_3.IsResponTo(arg_2_0, arg_2_1)
	if arg_2_0._triggerSearchTable[arg_2_1] ~= nil and #arg_2_0._triggerSearchTable[arg_2_1] > 0 then
		return true
	end

	return false
end

function var_0_3.SetArgs(arg_3_0, arg_3_1)
	arg_3_0._host = arg_3_1

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._effectList) do
		iter_3_1:SetArgs(arg_3_1, arg_3_0)
	end

	return
end

function var_0_3.setRemoveTime(arg_4_0)
	if arg_4_0._tempData.time == nil then
		return
	end

	local var_4_0 = arg_4_0._tempData.time

	arg_4_0._duration = type(arg_4_0._tempData.time) == "string" and math.max(0, var_0_2.parseFormula(var_4_0, arg_4_0._host:GetAttrManager())) or var_4_0

	local var_4_1 = pg.TimeMgr.GetInstance()

	arg_4_0._expireTimeStamp = var_4_1:GetCombatTime() + arg_4_0._duration

	return
end

function var_0_3.Attach(arg_5_0, arg_5_1)
	arg_5_0._stack = 1

	arg_5_0:SetArgs(arg_5_1)
	arg_5_0:onTrigger(var_0_1.ON_ATTACH)
	arg_5_0:setRemoveTime()

	return
end

function var_0_3.Stack(arg_6_0)
	arg_6_0._stack = arg_6_0._tempData.stack == 0 and arg_6_0._stack + 1 or math.min(arg_6_0._stack + 1, arg_6_0._tempData.stack)

	arg_6_0:onTrigger(var_0_1.ON_STACK)
	arg_6_0:setRemoveTime()

	return
end

function var_0_3.InitStack(arg_7_0)
	return
end

function var_0_3.UpdateStack(arg_8_0, arg_8_1)
	return
end

function var_0_3.Remove(arg_9_0)
	arg_9_0:onTrigger(var_0_1.ON_REMOVE)

	arg_9_0._host:GetBuffManager():GetCardPuzzleBuffList()[arg_9_0._id] = nil

	arg_9_0:Clear()

	return
end

function var_0_3.Update(arg_10_0, arg_10_1)
	if arg_10_0:IsExpire(arg_10_1) then
		arg_10_0:Remove()
	else
		arg_10_0:onTrigger(var_0_1.ON_UPDATE, arg_10_1)
	end

	return
end

function var_0_3.onTrigger(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._triggerSearchTable[arg_11_1] == nil or #arg_11_0._triggerSearchTable[arg_11_1] == 0 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._triggerSearchTable[arg_11_1]) do
		assert(type(iter_11_1[arg_11_1]) == "function", "fleet buff效果的触发函数缺失,buff id:>>" .. arg_11_0._id .. "<<, trigger:>>" .. arg_11_1 .. "<<")

		if iter_11_1:IsActive() then
			iter_11_1:NotActive()
			iter_11_1:Trigger(arg_11_1, arg_11_2)
			iter_11_1:SetActive()
		end
	end

	return
end

function var_0_3.IsExpire(arg_12_0, arg_12_1)
	if arg_12_0._expireTimeStamp == nil then
		return false
	else
		return arg_12_1 >= arg_12_0._expireTimeStamp
	end

	return
end

function var_0_3.IsActive(arg_13_0)
	return arg_13_0._isActive
end

function var_0_3.SetActive(arg_14_0)
	arg_14_0._isActive = true

	return
end

function var_0_3.NotActive(arg_15_0)
	arg_15_0._isActive = false

	return
end

function var_0_3.GetCaster(arg_16_0)
	return nil
end

function var_0_3.GetID(arg_17_0)
	return arg_17_0._id
end

function var_0_3.GetStack(arg_18_0)
	return arg_18_0._stack
end

function var_0_3.GetLv(arg_19_0)
	return 1
end

function var_0_3.GetDurationRate(arg_20_0)
	if arg_20_0._expireTimeStamp == nil then
		return 1
	else
		local var_20_0 = pg.TimeMgr.GetInstance()

		return (arg_20_0._expireTimeStamp - var_20_0:GetCombatTime()) / arg_20_0._duration
	end

	return
end

function var_0_3.Clear(arg_21_0)
	arg_21_0._host = nil

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._effectList) do
		iter_21_1:Clear()
	end

	return
end

return
