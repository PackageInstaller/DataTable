local CultivateData = require("app.view.module.cultivate.model.CultivateData")
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local CultivateDataMgr = class("CultivateDataMgr")

function CultivateDataMgr:ctor()
	self:initData()
end

function CultivateDataMgr:initData()
	self._actData = {}
end

function CultivateDataMgr:startCultivateAct(arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_1.activity_id

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CULTIVATE_ACTIVITY) then
		g.core.network.GameNetProxy:send_C2S_CultivateActivity_GetInfo({
			activity_id = var_3_0
		})
	end

	if not self._actData[var_3_0] then
		self._actData[var_3_0] = CultivateData.new(arg_3_1)
	else
		self._actData[var_3_0]:initData(arg_3_1)
	end
end

function CultivateDataMgr:getActEndTime(arg_4_1)
	if self._actData[arg_4_1] then
		return self._actData[arg_4_1]:getEndTime()
	end

	return 0
end

function CultivateDataMgr:hasActivityHasFreeGift()
	for iter_5_0, iter_5_1 in pairs(self._actData) do
		if iter_5_1 and iter_5_1:isInNormalOpenTime() and iter_5_1:hasGift() then
			return true
		end
	end

	return false
end

function CultivateDataMgr:isActivityOpen(arg_6_1)
	if self._actData[arg_6_1] then
		return self._actData[arg_6_1]:isInNormalOpenTime()
	end

	return false
end

function CultivateDataMgr:hasActivityOpen()
	for iter_7_0, iter_7_1 in pairs(self._actData) do
		if iter_7_1 and iter_7_1:isInNormalOpenTime() and iter_7_1:hasGift() and not iter_7_1:isWitchActivity() then
			return true
		end
	end

	return false
end

function CultivateDataMgr:hasWitchActivityOpen()
	for iter_8_0, iter_8_1 in pairs(self._actData) do
		if iter_8_1 and iter_8_1:isInNormalOpenTime() and iter_8_1:hasGift() and iter_8_1:isWitchActivity() then
			return true
		end
	end

	return false
end

function CultivateDataMgr:getCulActivityLocationAct(arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self._actData) do
		if iter_9_1:getLocationId() == arg_9_1 then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function CultivateDataMgr:getResDirId(arg_10_1)
	local var_10_0 = g.core.config.cultivate_activity_display_info.fetch(arg_10_1)

	if var_10_0 then
		return var_10_0.resource_file
	end

	return arg_10_1
end

function CultivateDataMgr:getCultivateData(arg_11_1)
	return self._actData[arg_11_1]
end

function CultivateDataMgr:getOpenCultivateDataAndId(arg_12_1)
	for iter_12_0, iter_12_1 in pairs(self._actData) do
		if self:isActOpen(iter_12_0) and iter_12_1:getActivityCfg().type == arg_12_1 then
			return iter_12_1, iter_12_0, iter_12_1:isInNormalOpenTime()
		end
	end
end

function CultivateDataMgr:updateActive(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1.list) do
		self:startCultivateAct(iter_13_1)
	end
end

function CultivateDataMgr:onS2CRedPoint(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1 or {}) do
		iter_14_1.activity.has_red_point = iter_14_1.award

		self:startCultivateAct(iter_14_1.activity)
	end
end

function CultivateDataMgr:updateActiveData(arg_15_1)
	if self._actData[arg_15_1.activity_id] then
		self._actData[arg_15_1.activity_id]:updateActivityData(arg_15_1)
	end
end

function CultivateDataMgr:isActOpen(arg_16_1)
	if self._actData[arg_16_1] then
		if self._actData[arg_16_1]:getActivityCfg().type == CultivateConst.ACTIVITY_TYPE.WITCH then
			if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WITCH_ACTIVITY) then
				return false
			end
		elseif not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CULTIVATE_ACTIVITY) then
			return false
		end

		return self._actData[arg_16_1]:isInActivityShowTime()
	end
end

function CultivateDataMgr:checkPreciousActIsOpen(arg_17_1)
	if self._actData[arg_17_1] then
		if self._actData[arg_17_1]:getActivityCfg().type == CultivateConst.ACTIVITY_TYPE.WITCH then
			if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WITCH_ACTIVITY) then
				return false, 0
			end
		elseif not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CULTIVATE_ACTIVITY) then
			return false, 0
		end

		return self._actData[arg_17_1]:checkPreciousActIsOpen()
	end

	return false, 0
end

function CultivateDataMgr:hasDailyTaskReward(arg_18_1)
	if self._actData[arg_18_1.actValue] then
		if not self._actData[arg_18_1.actValue]:isInNormalOpenTime() then
			return false
		end

		if not self._actData[arg_18_1.actValue]:isGetInfo() then
			return self._actData[arg_18_1.actValue]:hasSvrRedPoint()
		end

		return self._actData[arg_18_1.actValue]:getTaskData():isHasTaskCanReward(CultivateConst.TASK_TYPE.DAILY_TASK)
	end

	return false
end

function CultivateDataMgr:hasAchievementTaskReward(arg_19_1)
	if self._actData[arg_19_1.actValue] then
		if not self._actData[arg_19_1.actValue]:isInNormalOpenTime() then
			return false
		end

		return self._actData[arg_19_1.actValue]:getTaskData():isHasTaskCanReward(CultivateConst.TASK_TYPE.ACHIEVEMENT_TASK)
	end

	return false
end

function CultivateDataMgr:canUnlockPassCard(arg_20_1)
	local var_20_0 = arg_20_1.actValue

	if self._actData[arg_20_1.actValue] then
		if not self._actData[var_20_0]:isInNormalOpenTime() then
			return false
		end

		return not self._actData[var_20_0]:getPassCardData():isPassCardOpen() and self._actData[var_20_0]:getPassCardData():isCanActivePassCard()
	end

	return false
end

function CultivateDataMgr:canGetPassCardReward(arg_21_1)
	if self._actData[arg_21_1.actValue] then
		if not self._actData[arg_21_1.actValue]:isInNormalOpenTime() then
			return false
		end

		return #self._actData[arg_21_1.actValue]:getPassCardData():getMulFreeRewards() > 0
	end

	return false
end

function CultivateDataMgr:isNewActivityShop(arg_22_1)
	self._cacheMap = self._cacheMap or g.core.common.Storage:load("cultivate_act_cache.json") or {}

	if self._cacheMap[arg_22_1.actValue] then
		return false
	end

	return true
end

function CultivateDataMgr:saveNewActivityShop(arg_23_1)
	self._cacheMap = self._cacheMap or {}
	self._cacheMap[arg_23_1] = true

	g.core.common.Storage:save("cultivate_act_cache.json", self._cacheMap)
end

return CultivateDataMgr
