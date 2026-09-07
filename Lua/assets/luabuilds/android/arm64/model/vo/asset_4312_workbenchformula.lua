local WorkBenchFormula = class("WorkBenchFormula", import("model.vo.BaseVO"))

function WorkBenchFormula:bindConfigTable()
	return pg.activity_workbench_recipe
end

function WorkBenchFormula:Ctor(...)
	WorkBenchFormula.super.Ctor(self, ...)

	self.times = self.times or 0
	self.unlock = true

	return
end

function WorkBenchFormula:GetName()
	return self:getConfig("name")
end

function WorkBenchFormula:GetIconPath()
	return self:getConfig("icon")
end

function WorkBenchFormula:GetLockLimit()
	return FilterVarchar(self:getConfig("recipe_lock"))
end

function WorkBenchFormula:GetLockDesc()
	return (self:getConfig("lock_display"))
end

function WorkBenchFormula:BuildFromActivity()
	self.unlock = (function()
		local var_8_0 = self:GetLockLimit()

		if var_8_0 and var_8_0[1] == 1 then
			local var_8_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2)

			assert(var_8_1)

			return var_8_1:GetBuildingLevel(var_8_0[2]) >= var_8_0[3]
		end

		return true
	end)()

	local var_7_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORKBENCH)

	assert(var_7_0)

	self.times = var_7_0:GetFormulaUseCount(self:GetConfigID())

	return
end

function WorkBenchFormula:IsUnlock()
	return self.unlock
end

function WorkBenchFormula:GetMaxLimit()
	return self:getConfig("item_num")
end

function WorkBenchFormula:SetUsedCount(arg_11_1)
	self.times = arg_11_1

	return
end

function WorkBenchFormula:GetUsedCount()
	return self.times
end

function WorkBenchFormula:IsAvaliable()
	return self:GetMaxLimit() <= 0 or self:GetUsedCount() < self:GetMaxLimit()
end

function WorkBenchFormula:GetProduction()
	return self:getConfig("item_id")
end

function WorkBenchFormula:GetMaterials()
	return self:getConfig("recipe")
end

return WorkBenchFormula
