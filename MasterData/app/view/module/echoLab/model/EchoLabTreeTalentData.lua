local var_0_0 = g.core.config.palace_altar_info
local EchoLabTalentStruct = require("app.view.module.echoLab.model.struct.EchoLabTalentStruct")
local EchoLabTreeTalentData = class("EchoLabTreeTalentData")

function EchoLabTreeTalentData:ctor()
	self._talentDict = {}
	self._talentKeyDict = {}
	self._bigTalentList = {}

	self:initData()
end

function EchoLabTreeTalentData:initData()
	self._talentDict = {}
	self._talentKeyDict = {}
	self._bigTalentList = {}

	for iter_2_0, iter_2_1 in var_0_0.ipairs() do
		local var_2_0 = self:getTalentById(iter_2_1.id, true)

		var_2_0:addInfo(iter_2_1)

		self._talentKeyDict[var_2_0:getXYKey()] = var_2_0

		if var_2_0:isBig() then
			table.insert(self._bigTalentList, var_2_0)
		end

		if iter_2_1.front_node_1 > 0 then
			local var_2_1 = self:getTalentById(iter_2_1.front_node_1, true)

			var_2_0:addPre(var_2_1)
			var_2_1:addNext(var_2_0)
		end

		if iter_2_1.front_node_2 > 0 then
			local var_2_2 = self:getTalentById(iter_2_1.front_node_2, true)

			var_2_0:addPre(var_2_2)
			var_2_2:addNext(var_2_0)
		end
	end

	table.sort(self._bigTalentList, self:_getSortFunc())
end

function EchoLabTreeTalentData:getTalentById(arg_3_1, arg_3_2)
	if not self._talentDict[arg_3_1] and arg_3_2 then
		self._talentDict[arg_3_1] = EchoLabTalentStruct.new(arg_3_1)
	end

	return self._talentDict[arg_3_1]
end

function EchoLabTreeTalentData:getTalentByXY(arg_4_1, arg_4_2)
	return self._talentKeyDict[arg_4_1 .. "_" .. arg_4_2]
end

function EchoLabTreeTalentData:getTalentDict()
	return self._talentDict
end

function EchoLabTreeTalentData:getMinNotActiveBigTalent()
	for iter_6_0, iter_6_1 in ipairs(self._bigTalentList) do
		if not iter_6_1:isActive() then
			return iter_6_1
		end
	end
end

function EchoLabTreeTalentData:getAllActiveAttrList()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self._talentDict) do
		if iter_7_1:isActive() then
			for iter_7_2, iter_7_3, iter_7_4 in iter_7_1:getInfo().gmatch({
				"affect_type_%d+",
				"affect_value_%d+"
			}, true) do
				if iter_7_4[1] > 0 then
					var_7_0[iter_7_4[1]] = not var_7_0[iter_7_4[1]] and iter_7_4[2] or var_7_0[iter_7_4[1]] + iter_7_4[2]
				end
			end
		end
	end

	return var_7_0
end

function EchoLabTreeTalentData:setTalentActive(arg_8_1)
	local var_8_0 = self:getTalentById(arg_8_1)

	if var_8_0 then
		var_8_0:setActive(true)
	end
end

function EchoLabTreeTalentData:_getSortFunc()
	return function(arg_10_0, arg_10_1)
		return arg_10_0:getGridX() < arg_10_1:getGridX()
	end
end

function EchoLabTreeTalentData:getTalentSortList()
	local var_11_0 = table.values(self:getTalentDict())

	table.sort(var_11_0, self:_getSortFunc())

	return var_11_0
end

function EchoLabTreeTalentData:hasCanActiveTalent(arg_12_1)
	if arg_12_1.talentId then
		return self:checkTalentCanActive(self:getTalentById(arg_12_1.talentId))
	else
		for iter_12_0, iter_12_1 in pairs(self._talentDict) do
			if self:checkTalentCanActive(iter_12_1) then
				return true
			end
		end
	end

	return false
end

function EchoLabTreeTalentData:checkTalentCanActive(arg_13_1)
	if not arg_13_1:isActive() and arg_13_1:preIsActive() then
		local var_13_0 = true

		for iter_13_0, iter_13_1, iter_13_2 in arg_13_1:getInfo().gmatch({
			"cost_type_%d+",
			"cost_value_%d+",
			"cost_size_%d+"
		}, true) do
			if iter_13_2[1] > 0 and g.core.model.User.bagData:getOwnNum(iter_13_2[1], iter_13_2[2]) < iter_13_2[3] then
				var_13_0 = false
			end
		end

		if var_13_0 then
			return true
		end
	end

	return false
end

return EchoLabTreeTalentData
