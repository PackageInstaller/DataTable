local NewEducatePlan = class("NewEducatePlan", import("model.vo.BaseVO"))

NewEducatePlan.TYPE = {
	OTHER = 2,
	STUDY = 1
}
NewEducatePlan.TYPE2NAME = {
	[NewEducatePlan.TYPE.STUDY] = i18n("child2_plan_type1"),
	[NewEducatePlan.TYPE.OTHER] = i18n("child2_plan_type2")
}

function NewEducatePlan:bindConfigTable()
	return pg.child2_plan
end

function NewEducatePlan:Ctor(arg_2_1, arg_2_2)
	self.id = arg_2_1
	self.configId = self.id
	self.isExtraPlan = arg_2_2

	return
end

function NewEducatePlan:IsShow()
	return self:getConfig("is_show") == 1
end

function NewEducatePlan:GetCostShowInfos()
	return NewEducateHelper.Config2Drops(self:getConfig("cost"))
end

function NewEducatePlan:GetCostWithBenefit(arg_5_1)
	local var_5_0 = {}

	if arg_5_1[self.id] then
		for iter_5_0, iter_5_1 in ipairs(self:GetCostShowInfos()) do
			local var_5_1 = Clone(iter_5_1)

			if arg_5_1[self.id][iter_5_1.type] then
				if arg_5_1[self.id][iter_5_1.type][iter_5_1.id] then
					var_5_1.number = NewEducateHelper.GetBenefitValue(iter_5_1.number, arg_5_1[self.id][iter_5_1.type][iter_5_1.id])
				end
			end

			table.insert(var_5_0, var_5_1)
		end

		return var_5_0
	else
		return self:GetCostShowInfos()
	end

	return
end

function NewEducatePlan:GetAwardShowInfos()
	return NewEducateHelper.Config2Drops(self:getConfig("result_display"))
end

function NewEducatePlan:GetNextId()
	return underscore.detect(pg.child2_plan.get_id_list_by_group_id[self:getConfig("group_id")], function(arg_8_0)
		return pg.child2_plan[arg_8_0].level == self:getConfig("level") + 1
	end)
end

function NewEducatePlan:GetUpgradeConditions(arg_9_1)
	return underscore.select(arg_9_1:GetConditionIdsFromComplex((self:getConfig("level_condition"))), function(arg_10_0)
		return pg.child2_condition[arg_10_0].type == NewEducateConst.CONDITION_TYPE.DROP and pg.child2_condition[arg_10_0].param[1] == NewEducateConst.DROP_TYPE.ATTR
	end) or {}
end

function NewEducatePlan:IsExtraPlan()
	return self.isExtraPlan
end

function NewEducatePlan:GetAwardBg()
	return self:getConfig("type") == NewEducatePlan.TYPE.STUDY and "desc_bg_orange" or "desc_bg_purple"
end

return NewEducatePlan
