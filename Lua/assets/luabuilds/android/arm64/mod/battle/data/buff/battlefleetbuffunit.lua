ys = ys or {}

local var_0_1 = ys.Battle.BattleConst.BuffEffectType
local var_0_2 = class("BattleFleetBuffUnit")

ys.Battle.BattleFleetBuffUnit = var_0_2
var_0_2.__name = "BattleFleetBuffUnit"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_2 = arg_1_2 or 1
	arg_1_0._id = arg_1_1
	arg_1_0._tempData = var_0.Battle.BattleDataFunction.GetBuffTemplate(arg_1_1, arg_1_2)
	arg_1_0._time = arg_1_0._tempData.time
	arg_1_0._RemoveTime = 0
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

function var_0_2.SetArgs(arg_2_0, arg_2_1)
	arg_2_0._host = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._effectList) do
		iter_2_1:SetArgs(arg_2_1, arg_2_0)
	end

	return
end

function var_0_2.setRemoveTime(arg_3_0)
	arg_3_0._RemoveTime = pg.TimeMgr.GetInstance():GetCombatTime() + arg_3_0._time
	arg_3_0._cancelTime = nil

	return
end

function var_0_2.Attach(arg_4_0, arg_4_1)
	arg_4_0._stack = 1

	arg_4_0:SetArgs(arg_4_1)
	arg_4_0:onTrigger(var_0_1.ON_ATTACH, arg_4_1)
	arg_4_0:setRemoveTime()

	return
end

function var_0_2.Stack(arg_5_0, arg_5_1)
	arg_5_0._stack = math.min(arg_5_0._stack + 1, arg_5_0._tempData.stack)

	arg_5_0:onTrigger(var_0_1.ON_STACK, arg_5_1)
	arg_5_0:setRemoveTime()

	return
end

function var_0_2.UpdateStack(arg_6_0, arg_6_1, arg_6_2)
	return
end

function var_0_2.Remove(arg_7_0)
	arg_7_0:onTrigger(var_0_1.ON_REMOVE, arg_7_0._host)

	arg_7_0._host:GetFleetBuffList()[arg_7_0._id] = nil

	arg_7_0:Clear()

	return
end

function var_0_2.Update(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0:IsTimeToRemove(arg_8_2) then
		arg_8_0:Remove()
	else
		arg_8_0:onTrigger(var_0_1.ON_UPDATE, arg_8_1, arg_8_2)
	end

	return
end

function var_0_2.onTrigger(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0._triggerSearchTable[arg_9_1] == nil or #arg_9_0._triggerSearchTable[arg_9_1] == 0 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._triggerSearchTable[arg_9_1]) do
		assert(type(iter_9_1[arg_9_1]) == "function", "fleet buff效果的触发函数缺失,buff id:>>" .. arg_9_0._id .. "<<, trigger:>>" .. arg_9_1 .. "<<")

		if iter_9_1:IsActive() then
			iter_9_1:NotActive()
			iter_9_1:Trigger(arg_9_1, arg_9_2, arg_9_0, arg_9_3)
			iter_9_1:SetActive()
		end
	end

	return
end

function var_0_2.IsTimeToRemove(arg_10_0, arg_10_1)
	if arg_10_0._time == 0 then
		return false
	else
		return arg_10_1 >= arg_10_0._RemoveTime
	end

	return
end

function var_0_2.IsActive(arg_11_0)
	return arg_11_0._isActive
end

function var_0_2.SetActive(arg_12_0)
	arg_12_0._isActive = true

	return
end

function var_0_2.NotActive(arg_13_0)
	arg_13_0._isActive = false

	return
end

function var_0_2.GetCaster(arg_14_0)
	return nil
end

function var_0_2.GetID(arg_15_0)
	return arg_15_0._id
end

function var_0_2.GetLv(arg_16_0)
	return 1
end

function var_0_2.Clear(arg_17_0)
	arg_17_0._host = nil

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._effectList) do
		iter_17_1:Clear()
	end

	return
end

return
