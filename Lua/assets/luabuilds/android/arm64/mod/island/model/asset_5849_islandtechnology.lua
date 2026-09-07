local IslandTechnology = class("IslandTechnology", import("model.vo.BaseVO"))

IslandTechnology.STATUS = {
	STUDYING = "studying",
	NORMAL = "normal",
	RECEIVE = "receive",
	FINISHED = "finished",
	LOCK = "lock",
	UNLOCK = "unlock"
}
IslandTechnology.UNLOCK_TYPE = {
	FINISH_TASK = 1,
	LEVEL = 0,
	EXIST_ABILITY = 2,
	FINISH_TECHNOLOGY = 3
}

function IslandTechnology:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.configId = arg_1_1
	self.finishedCnt = arg_1_2 or 0

	return
end

function IslandTechnology:SetFinishedCnt(arg_2_1)
	self.finishedCnt = arg_2_1

	return
end

function IslandTechnology:AddFinishedCnt()
	self.finishedCnt = self.finishedCnt + 1

	if self.finishedCnt == 1 then
		IslandAchievementHelper.OnFinishTechnolog(self.id)
		IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.TECHNOLOGY)
	end

	return
end

function IslandTechnology:GetFinishedCnt()
	return self.finishedCnt
end

function IslandTechnology:bindConfigTable()
	return pg.island_technology_template
end

function IslandTechnology:IsAutoType()
	return self:getConfig("auto_finish") == 0
end

function IslandTechnology:CheckFinishImmd()
	return self:IsUnlock() and self:IsAutoType() and self.finishedCnt == 0
end

function IslandTechnology:GetFormulaId()
	return self:getConfig("formula_id")
end

function IslandTechnology:IsOnceType()
	return self:getConfig("tech_repeat")[1] == 0
end

function IslandTechnology:IsNoLimitType()
	return not self:IsOnceType() and self:getConfig("tech_repeat")[2] == 0
end

function IslandTechnology:GetMaxFinishedCnt()
	return self:IsOnceType() and 1 or self:getConfig("tech_repeat")[2]
end

function IslandTechnology:CheckRemainCnt()
	return self:IsNoLimitType() or self:GetMaxFinishedCnt() - self.finishedCnt > 0
end

function IslandTechnology:GetAbilityId()
	return pg.island_formula[self:GetFormulaId()].unlock_type
end

function IslandTechnology:IsUnlock()
	local var_14_0 = self:GetAbilityId()

	return var_14_0 == 0 or getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(var_14_0)
end

function IslandTechnology:GetCostItems()
	local var_15_0 = {}

	underscore.each(pg.island_formula[self:GetFormulaId()].commission_cost, function(arg_16_0)
		table.insert(var_15_0, Drop.New({
			type = DROP_TYPE_ISLAND_ITEM,
			id = arg_16_0[1],
			count = arg_16_0[2]
		}))

		return
	end)

	return var_15_0
end

function IslandTechnology:CanUnlock()
	if getProxy(IslandProxy):GetIsland():GetLevel() < self:getConfig("island_level") then
		return false
	end

	local var_17_0 = self:getConfig("sys_unlock")

	if var_17_0 == "" or #var_17_0 == 0 then
		return true
	end

	return underscore.all(var_17_0, function(arg_18_0)
		return self:MatchCondition(arg_18_0)
	end)
end

function IslandTechnology:MatchCondition(arg_19_1)
	local var_19_0 = arg_19_1[2]

	return switch(arg_19_1[1], {
		[IslandTechnology.UNLOCK_TYPE.LEVEL] = function()
			return getProxy(IslandProxy):GetIsland():GetLevel() >= self:getConfig("island_level")
		end,
		[IslandTechnology.UNLOCK_TYPE.FINISH_TASK] = function()
			return getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(var_19_0)
		end,
		[IslandTechnology.UNLOCK_TYPE.EXIST_ABILITY] = function()
			return getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(var_19_0)
		end,
		[IslandTechnology.UNLOCK_TYPE.FINISH_TECHNOLOGY] = function()
			return getProxy(IslandProxy):GetIsland():GetTechnologyAgency():IsFinishedTech(var_19_0)
		end
	}, function()
		return false
	end)
end

function IslandTechnology:GetStatus()
	if not self:IsUnlock() then
		return (self:CanUnlock() or nil) and (IslandTechnology.STATUS.UNLOCK or IslandTechnology.STATUS.LOCK)
	end

	local var_25_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetDelegationSlotDataByTechId(self.id)

	if var_25_0 then
		return (var_25_0:GetSlotRewardData() or nil) and (IslandTechnology.STATUS.RECEIVE or IslandTechnology.STATUS.STUDYING)
	else
		return (self:CheckRemainCnt() or nil) and (IslandTechnology.STATUS.NORMAL or IslandTechnology.STATUS.FINISHED)
	end

	return
end

function IslandTechnology:GetSlotId()
	local var_26_0 = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetDelegationSlotDataByTechId(self.id)

	return var_26_0 and var_26_0.id
end

function IslandTechnology:GetUnlockText()
	local var_27_0 = self[2]

	return switch(self[1], {
		[IslandTechnology.UNLOCK_TYPE.LEVEL] = function()
			return i18n("island_tech_unlock_tip0", var_27_0)
		end,
		[IslandTechnology.UNLOCK_TYPE.FINISH_TASK] = function()
			return i18n("island_tech_unlock_tip1", pg.island_task[var_27_0].name)
		end,
		[IslandTechnology.UNLOCK_TYPE.EXIST_ABILITY] = function()
			return i18n("island_tech_unlock_tip2", pg.island_ability_template[var_27_0].unlock_text)
		end,
		[IslandTechnology.UNLOCK_TYPE.FINISH_TECHNOLOGY] = function()
			return i18n("island_tech_unlock_tip3", pg.island_technology_template[var_27_0].tech_name)
		end
	})
end

return IslandTechnology
