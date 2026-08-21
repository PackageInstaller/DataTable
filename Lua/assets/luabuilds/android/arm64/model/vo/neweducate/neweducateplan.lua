local var_0_0 = class("NewEducatePlan", import("model.vo.BaseVO"))

var_0_0.TYPE = {
	OTHER = 2,
	STUDY = 1
}
var_0_0.TYPE2NAME = {
	[var_0_0.TYPE.STUDY] = i18n("child2_plan_type1"),
	[var_0_0.TYPE.OTHER] = i18n("child2_plan_type2")
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.child2_plan
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.configId = arg_2_0.id
	arg_2_0.isExtraPlan = arg_2_2

	return
end

function var_0_0.IsShow(arg_3_0)
	return arg_3_0:getConfig("is_show") == 1
end

function var_0_0.GetCostShowInfos(arg_4_0)
	return NewEducateHelper.Config2Drops(arg_4_0:getConfig("cost"))
end

function var_0_0.GetCostWithBenefit(arg_5_0, arg_5_1)
	if arg_5_1[arg_5_0.id] then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0:GetCostShowInfos()) do
			local var_5_0 = Clone(iter_5_1)

			if arg_5_1[arg_5_0.id][iter_5_1.type] then
				if arg_5_1[arg_5_0.id][iter_5_1.type][iter_5_1.id] then
					var_5_0.number = NewEducateHelper.GetBenefitValue(iter_5_1.number, arg_5_1[arg_5_0.id][iter_5_1.type][iter_5_1.id])
				end
			end

			table.insert({}, var_5_0)
		end

		return {}
	else
		return arg_5_0:GetCostShowInfos()
	end

	return
end

function var_0_0.GetAwardShowInfos(arg_6_0)
	return NewEducateHelper.Config2Drops(arg_6_0:getConfig("result_display"))
end

function var_0_0.GetNextId(arg_7_0)
	return underscore.detect(pg.child2_plan.get_id_list_by_group_id[arg_7_0:getConfig("group_id")], function(arg_8_0)
		return pg.child2_plan[arg_8_0].level == arg_7_0:getConfig("level") + 1
	end)
end

function var_0_0.GetUpgradeConditions(arg_9_0, arg_9_1)
	return underscore.select(arg_9_1:GetConditionIdsFromComplex((arg_9_0:getConfig("level_condition"))), function(arg_10_0)
		local var_10_0 = pg.child2_condition[arg_10_0]

		return pg.child2_condition[arg_10_0].type == NewEducateConst.CONDITION_TYPE.DROP and var_10_0.param[1] == NewEducateConst.DROP_TYPE.ATTR
	end) or {}
end

function var_0_0.IsExtraPlan(arg_11_0)
	return arg_11_0.isExtraPlan
end

function var_0_0.GetAwardBg(arg_12_0)
	return arg_12_0:getConfig("type") == var_0_0.TYPE.STUDY and "desc_bg_orange" or "desc_bg_purple"
end

return var_0_0
