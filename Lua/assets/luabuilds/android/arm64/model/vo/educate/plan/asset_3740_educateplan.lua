local EducatePlan = class("EducatePlan", import("model.vo.BaseVO"))

EducatePlan.RARITY2BG = {
	"plan_icon_grey",
	"plan_icon_purple",
	"plan_icon_yellow"
}
EducatePlan.TYPE_SCHOOL = 1
EducatePlan.TYPE_INTEREST = 2
EducatePlan.TYPE_COMMUNITY = 3
EducatePlan.TYPE_FREETIME = 4
EducatePlan.TYPE_FREETIME_2 = 5

function EducatePlan:bindConfigTable()
	return pg.child_plan
end

function EducatePlan:Ctor(arg_2_1)
	self.id = arg_2_1
	self.configId = self.id

	return
end

function EducatePlan:GetIconBgName()
	return EducatePlan.RARITY2BG[self:getConfig("rare")]
end

function EducatePlan:IsInStage(arg_4_1)
	return #self:getConfig("stage") == 0 or table.contains(self:getConfig("stage"), arg_4_1)
end

function EducatePlan:GetType()
	if self:getConfig("type") == EducatePlan.TYPE_FREETIME_2 then
		return EducatePlan.TYPE_FREETIME
	end

	return self:getConfig("type")
end

function EducatePlan:IsInTime(arg_6_1, arg_6_2)
	return underscore.any(self:getConfig("time"), function(arg_7_0)
		return arg_7_0[1] == arg_6_1 and arg_7_0[2] == arg_6_2
	end)
end

function EducatePlan:IsShow(arg_8_1, arg_8_2, arg_8_3)
	return self:IsInStage(arg_8_1) and self:IsInTime(arg_8_2, arg_8_3)
end

function EducatePlan:IsMatchAttr(arg_9_1)
	return underscore.all(self:getConfig("ability"), function(arg_10_0)
		return arg_9_1:GetAttrById(arg_10_0[2]) >= arg_10_0[3]
	end)
end

function EducatePlan:ExistNextPlanCanFill(arg_11_1)
	local var_11_0 = self:getConfig("pre_next")
	local var_11_2
	local var_11_1

	if var_11_0 == 0 then
		do return false end

		var_11_1 = getProxy(EducateProxy):GetPlanProxy()
		var_11_2 = EducatePlan.New(var_11_0)
	end

	return pg.child_plan[var_11_0].pre[2] <= var_11_1:GetHistoryCntById(self.id) and var_11_2:IsMatchAttr(arg_11_1)
end

function EducatePlan:IsMatchPre(arg_12_1)
	local var_12_0 = self:getConfig("pre")

	if #var_12_0 == 0 then
		return true
	end

	return arg_12_1 >= var_12_0[2]
end

function EducatePlan:GetCost()
	local var_13_0 = self:getConfig("cost_resource1")
	local var_13_1 = self:getConfig("cost_resource2")
	local var_13_2 = self:getConfig("cost_resource3")
end

function EducatePlan:GetResult()
	return self:getConfig("result_display")
end

function EducatePlan:CheckResult(arg_15_1, arg_15_2)
	return underscore.any(self:GetResult(), function(arg_16_0)
		return arg_16_0[1] == arg_15_1 and arg_16_0[2] == arg_15_2 and arg_16_0[3] > 0
	end)
end

function EducatePlan:CheckResultBySubType(arg_17_1, arg_17_2)
	return underscore.any(self:GetResult(), function(arg_18_0)
		return arg_18_0[1] == arg_17_1 and EducateHelper.IsMatchSubType(arg_17_2, arg_18_0[2]) and arg_18_0[3] > 0
	end)
end

function EducatePlan:GetAttrResultValue(arg_19_1)
	local var_19_0 = underscore.select(self:GetResult(), function(arg_20_0)
		return arg_20_0[1] == EducateConst.DROP_TYPE_ATTR and arg_20_0[2] == arg_19_1 and arg_20_0[3] > 0
	end)

	return (var_19_0 or nil) and (var_19_0[3] or 0)
end

function EducatePlan:GetDropInfo()
	local var_21_0 = {}

	underscore.each(self:GetResult(), function(arg_22_0)
		table.insert(var_21_0, Drop.New({
			type = arg_22_0[1],
			id = arg_22_0[2],
			number = arg_22_0[3]
		}))

		return
	end)

	return var_21_0
end

function EducatePlan:GetPerformance()
	return self:getConfig("performance")
end

return EducatePlan
