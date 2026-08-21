ys = ys or {}

local var_0_2 = ys.Battle.BattleDataFunction
local var_0_3 = class("BattleEnvironmentUnit")

ys.Battle.BattleEnvironmentUnit = var_0_3
var_0_3.__name = "BattleEnvironmentUnit"

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._uid = arg_1_1

	return
end

function var_0_3.ConfigCallback(arg_2_0, arg_2_1)
	arg_2_0._callback = arg_2_1

	return
end

function var_0_3.GetUniqueID(arg_3_0)
	return arg_3_0._uid
end

function var_0_3.SetTemplate(arg_4_0, arg_4_1)
	arg_4_0._template = arg_4_1

	arg_4_0:initBehaviours()

	return
end

function var_0_3.SetAOEData(arg_5_0, arg_5_1)
	arg_5_0._expireTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime() + arg_5_0._template.life_time
	arg_5_0._aoeData = arg_5_1

	return
end

function var_0_3.GetAOEData(arg_6_0)
	return arg_6_0._aoeData
end

function var_0_3.GetBehaviours(arg_7_0)
	return arg_7_0._behaviours
end

function var_0_3.GetTemplate(arg_8_0)
	return arg_8_0._template
end

function var_0_3.UpdateFrequentlyCollide(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._behaviours) do
		iter_9_1:UpdateCollideUnitList(arg_9_1)
	end

	return
end

function var_0_3.Update(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._behaviours) do
		iter_10_1:OnUpdate()
	end

	return
end

function var_0_3.IsExpire(arg_11_0, arg_11_1)
	return arg_11_1 > arg_11_0._expireTimeStamp
end

function var_0_3.Dispose(arg_12_0)
	if arg_12_0._callback then
		arg_12_0._callback()
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._behaviours) do
		iter_12_1:Dispose()
	end

	return
end

function var_0_3.initBehaviours(arg_13_0)
	arg_13_0._behaviours = {}

	for iter_13_0, iter_13_1 in ipairs(var_0_2.GetEnvironmentBehaviour(arg_13_0._template.behaviours).behaviour_list) do
		local var_13_0 = var_0.Battle.BattleEnvironmentBehaviour.CreateBehaviour(iter_13_1)

		var_13_0:SetUnitRef(arg_13_0)
		var_13_0:SetTemplate(iter_13_1)
		table.insert(arg_13_0._behaviours, var_13_0)
	end

	return
end

return
