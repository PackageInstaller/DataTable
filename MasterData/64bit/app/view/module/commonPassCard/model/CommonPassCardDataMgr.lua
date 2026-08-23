local var_0_0 = g.core.config.common_passcard_info
local CommonPassCardDataMgr = class("CommonPassCardDataMgr")

function CommonPassCardDataMgr:ctor()
	self:initData()
end

function CommonPassCardDataMgr:initData()
	self._commonPassCardDataDict = {}
end

function CommonPassCardDataMgr:_registerPassCardData(arg_3_1)
	if self._commonPassCardDataDict[arg_3_1] then
		return
	end

	self._commonPassCardDataDict[arg_3_1] = require("app.view.module.commonPassCard.model.CommonPassCardData").new(arg_3_1)
end

function CommonPassCardDataMgr:getPassCardData(arg_4_1)
	if not arg_4_1 then
		return
	end

	if not self._commonPassCardDataDict[arg_4_1] then
		self:_registerPassCardData(arg_4_1)
	end

	return self._commonPassCardDataDict[arg_4_1]
end

function CommonPassCardDataMgr:onS2CFlushRedPoint(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1.common_passcard_hints or {}) do
		local var_5_1 = self:getPassCardData(iter_5_1.id)

		if var_5_1 then
			var_5_1:onS2CRedPoint(iter_5_1)
		end
	end
end

function CommonPassCardDataMgr:hasLevelAwardCanGet(arg_6_1)
	local var_6_0 = self:getPassCardData(arg_6_1.activityId)

	if not var_6_0 then
		return false
	end

	return var_6_0:hasPassCardLevelReward()
end

function CommonPassCardDataMgr:hasTaskAwardCanGet(arg_7_1)
	local var_7_0 = self:getPassCardData(arg_7_1.activityId)

	if not var_7_0 then
		return false
	end

	return var_7_0:hasPassCardTaskReward()
end

function CommonPassCardDataMgr:getCommonPassCardActIdByFunctionId(arg_8_1)
	for iter_8_0, iter_8_1 in var_0_0.ipairs() do
		if iter_8_1.function_id == arg_8_1 then
			return iter_8_1.id
		end
	end
end

return CommonPassCardDataMgr
