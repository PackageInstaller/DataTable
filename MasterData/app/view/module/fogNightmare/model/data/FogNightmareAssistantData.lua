local var_0_0 = g.core.model.User.fogNightmareData
local SpecialKnightStruct = require("app.view.module.knight.model.SpecialKnightStruct")
local FogNightmareAssistantData = class("FogNightmareAssistantData")

function FogNightmareAssistantData:ctor()
	self._allHelperData = {}
	self._groupHelperData = {}
	self._specialKnights = {}
end

function FogNightmareAssistantData:initData()
	self._serverHelperList = {}
	self._totalKnights = 0
	self._selfHelperDict = {}
	self._useKnightIdDict = {}
	self._useKnights = 0
	self._isInitProto = false
end

function FogNightmareAssistantData:onS2CFriendHelperGetKnights(arg_3_1)
	self._totalKnights = arg_3_1.total_knights or 0
	self._serverHelperList = arg_3_1.helper or {}

	self:updateHelperData(self._serverHelperList)
end

function FogNightmareAssistantData:clearFriendHelper()
	self._serverHelperList = {}

	self:updateHelperData(self._serverHelperList)
end

function FogNightmareAssistantData:onS2CFriendHelperSetKnights(arg_5_1)
	self._selfHelperDict = {}
	self._useKnightIdDict = {}
	self._useKnights = 0

	for iter_5_0, iter_5_1 in pairs(arg_5_1.setting or {}) do
		self._selfHelperDict[iter_5_1.indice] = iter_5_1.id

		if iter_5_1.id > 0 then
			self._useKnightIdDict[iter_5_1.id] = true
			self._useKnights = self._useKnights + 1
		end
	end
end

function FogNightmareAssistantData:updateHelperData(arg_6_1)
	self._allHelperData = {}
	self._groupHelperData = {}

	local var_6_0 = var_0_0:getFormationData()

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_1 = g.core.config.knight_info.get(iter_6_1.base_id)
		local var_6_2 = SpecialKnightStruct.new()

		var_6_2:setInfoByFriendAssistantData(iter_6_1)
		table.insert(self._allHelperData, {
			svrHelperData = iter_6_1,
			cfg = g.core.config.knight_info.get(iter_6_1.base_id),
			quality = var_6_1.quality,
			star = var_6_1.star,
			group = var_6_1.group,
			struct = var_6_2,
			name = var_6_2:getOwner().name,
			serverName = var_6_2:getOwner().server_name,
			sid = var_6_2:getOwner().sid,
			hasSameLineUp = var_6_0:isHasKnightInKnightPool(iter_6_1.id)
		})
	end

	table.sort(self._allHelperData, function(arg_7_0, arg_7_1)
		if arg_7_0.quality ~= arg_7_1.quality then
			return arg_7_0.quality > arg_7_1.quality
		end

		if arg_7_0.star ~= arg_7_1.star then
			return arg_7_0.star > arg_7_1.star
		end

		if arg_7_0.svrHelperData.id ~= arg_7_1.svrHelperData.id then
			return arg_7_0.svrHelperData.id > arg_7_1.svrHelperData.id
		end

		return false
	end)

	for iter_6_2, iter_6_3 in ipairs(self._allHelperData) do
		self._groupHelperData[iter_6_3.group] = self._groupHelperData[iter_6_3.group] or {}

		table.insert(self._groupHelperData[iter_6_3.group], iter_6_3)
	end
end

function FogNightmareAssistantData:getOtherHelperByGroup(arg_8_1)
	if arg_8_1 == 0 then
		return self._allHelperData
	else
		return self._groupHelperData[arg_8_1] or {}
	end
end

function FogNightmareAssistantData:getSelfHelperKnights()
	return self._selfHelperDict
end

function FogNightmareAssistantData:getSelfUseHelperCount()
	return self._useKnights
end

function FogNightmareAssistantData:isUseKnightById(arg_11_1)
	return self._useKnightIdDict[arg_11_1] == true
end

function FogNightmareAssistantData:setIsInitProto()
	self._isInitProto = true
end

function FogNightmareAssistantData:getIsInitProto()
	return self._isInitProto
end

function FogNightmareAssistantData:getCurSelAssistantKnight()
	return self._specialKnights or {}
end

function FogNightmareAssistantData:setAssistantEmpty()
	self._specialKnights = nil
end

function FogNightmareAssistantData:setCurSelAssistantKnight(arg_16_1)
	self._specialKnights = arg_16_1
end

function FogNightmareAssistantData:updateLineUpKnights(arg_17_1)
	return
end

return FogNightmareAssistantData
