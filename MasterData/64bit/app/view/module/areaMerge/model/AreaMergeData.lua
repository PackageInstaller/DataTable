local var_0_0 = g.core.const.ConstMgr.AreaMergeConst
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.config.guild_alliance_parameter_info
local var_0_3 = g.core.config.war_zone_name_info
local AreaMergeData = class("AreaMergeData")

function AreaMergeData:ctor()
	self:initData()
end

function AreaMergeData:initData()
	self._paramDay = var_0_2.get(23).parameter
	self._paramHour = var_0_2.get(24).parameter
	self._previewTs = 0
	self._startTime = 0
	self._mergeAreaTs = 0
	self._endTime = 0
	self._areas = {}
end

function AreaMergeData:onS2CAreaMergeInfo(arg_3_1)
	if arg_3_1.merge_area then
		self._previewTs = arg_3_1.merge_area.preview_time or 0
		self._startTime = arg_3_1.merge_area.start_time or 0
		self._mergeAreaTs = arg_3_1.merge_area.merge_time or 0
		self._areas = arg_3_1.merge_area.areas or {}
		self._endTime = var_0_1:getZeroClockSeconds(self._startTime) + self._paramDay * 86400 + self._paramHour * 3600
	end
end

function AreaMergeData:getMergeAreaStage()
	local var_4_0 = var_0_1:getTime()

	if var_4_0 >= self._previewTs and var_4_0 < self._startTime then
		return var_0_0.STAGE.PREVIEW
	elseif var_4_0 >= self._startTime and var_4_0 < self._endTime then
		return var_0_0.STAGE.MERGE
	else
		return var_0_0.STAGE.END
	end
end

function AreaMergeData:getMergeTime()
	return self._startTime
end

function AreaMergeData:getMergeAreaEndTime()
	return self._endTime
end

function AreaMergeData:isShowMergeTips()
	if g.core.model.User.allianceData:hasAlliance() then
		return self:getMergeAreaStage() ~= var_0_0.STAGE.END
	end

	return false
end

function AreaMergeData:getAllAreasName()
	self._areaName = {}

	if next(self._areas) then
		for iter_8_0, iter_8_1 in ipairs(self._areas) do
			table.insert(self._areaName, (var_0_3.fetch(iter_8_1) or {}).name or "")
		end
	end

	return table.concat(self._areaName, ";")
end

function AreaMergeData:getMergeAreaTips()
	local var_9_0 = self:getMergeAreaStage()

	if var_9_0 == var_0_0.STAGE.PREVIEW then
		return g.core.lang:get(430101)
	elseif var_9_0 == var_0_0.STAGE.MERGE then
		return g.core.lang:get(430102)
	end
end

return AreaMergeData
