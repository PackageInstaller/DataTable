local var_0_0 = g.core.const.ConstMgr.CampaignConst
local var_0_1 = g.core.const.ConstMgr.RedPointConst.STYLE.NEW_WORD
local var_0_2 = g.core.const.ConstMgr.RedPointConst.STYLE.NONE
local var_0_3 = g.core.model.User
local CampEntranceStruct = import(".CampEntranceStruct")
local CampaignData = class("CampaignData", require("app.core.model.BaseData"))

function CampaignData:ctor()
	self:initData()
end

function CampaignData:initData()
	self._entranceStructDict = {}
	self._playerList = {}
	self._jsonDict = nil

	self:_initEntranceStructDict()
end

function CampaignData:_initEntranceStructDict()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in g.core.config.play_des_info.ipairs() do
		local var_3_1 = CampEntranceStruct.new(iter_3_1)

		var_3_0[var_3_1.functionId] = var_3_1
	end

	self._entranceStructDict = var_3_0
end

function CampaignData:onS2CFlushRedPoint(arg_4_1)
	return
end

function CampaignData:getPosByCfgId(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs((self:getShowEntranceStructArr())) do
		if iter_5_1.functionId == arg_5_1 then
			return iter_5_0 - 1
		end
	end

	return 0
end

function CampaignData:getFirstCloseTime()
	local var_6_0 = -1

	for iter_6_0, iter_6_1 in ipairs((self:getShowEntranceStructArr())) do
		if iter_6_1.unlocked and (iter_6_1.limitTime or iter_6_1:isOpenLimitTimeMode()) then
			local var_6_1 = iter_6_1:getCDEndTimeStamp()

			if var_6_0 == -1 then
				var_6_0 = var_6_1
			elseif var_6_1 < var_6_0 then
				var_6_0 = var_6_1
			end
		end
	end

	return var_6_0
end

function CampaignData:_getEntranceSortFunc()
	return function(arg_8_0, arg_8_1)
		if arg_8_0.unlocked ~= arg_8_1.unlocked then
			return arg_8_0.unlocked
		end

		if arg_8_0.limitTime ~= arg_8_1.limitTime then
			return arg_8_0.limitTime
		end

		local var_8_0 = arg_8_0:isOpenLimitTimeMode()

		if var_8_0 ~= arg_8_1:isOpenLimitTimeMode() then
			return var_8_0
		end

		return arg_8_0.info.order < arg_8_1.info.order
	end
end

function CampaignData:getShowEntranceStructArr()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self._entranceStructDict) do
		iter_9_1:updateValue()

		if iter_9_1.show then
			table.insert(var_9_0, iter_9_1)
		end
	end

	table.sort(var_9_0, self:_getEntranceSortFunc())

	return var_9_0
end

function CampaignData:getNewestPlay()
	local var_10_0 = 0
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs((self:getShowEntranceStructArr())) do
		if iter_10_1.unlocked then
			local var_10_2, var_10_3 = self:isFuncEntranceShowRedPoint(iter_10_1.functionId)

			if var_10_2 and var_10_3 == var_0_1 then
				return iter_10_0
			elseif var_10_2 and var_10_3 ~= var_0_2 then
				if var_10_0 == 0 then
					var_10_0 = iter_10_0
				end
			elseif var_10_1 == 0 then
				var_10_1 = iter_10_0
			end
		end
	end

	if var_10_0 > 0 then
		return var_10_0
	end

	return var_10_1
end

function CampaignData:isFuncEntranceShowRedPoint(arg_11_1)
	if var_0_0.RED_POINT_ID[arg_11_1] and var_0_3.redPointData:isRedPointIdValid(var_0_0.RED_POINT_ID[arg_11_1]) then
		local var_11_0 = var_0_3.redPointData:getRedPointStruct(var_0_0.RED_POINT_ID[arg_11_1])

		if var_11_0 then
			local var_11_1 = var_11_0:getMeetConditionStruct(nil)

			if var_11_1 then
				return true, var_11_1:getStyle()
			end
		end
	end

	return false
end

function CampaignData:saveFuncFirstEnter(arg_12_1)
	self:_getJsonDict()[self:_getFuncEnterSaveKey(arg_12_1)] = 1

	self:_saveJson()
end

function CampaignData:isFuncHasEnter(arg_13_1)
	return checkbool(self:_getJsonDict()[self:_getFuncEnterSaveKey(arg_13_1)])
end

function CampaignData:_getFuncEnterSaveKey(arg_14_1)
	return "Campaign_" .. tostring(arg_14_1)
end

function CampaignData:_saveJson()
	g.core.common.Storage:save(var_0_0.JSON_NAME, (self:_getJsonDict()))
end

function CampaignData:_getJsonDict()
	local var_16_0 = self._jsonDict

	if not self._jsonDict then
		var_16_0 = g.core.common.Storage:load(var_0_0.JSON_NAME) or {}
		self._jsonDict = var_16_0
	end

	return var_16_0
end

return CampaignData
