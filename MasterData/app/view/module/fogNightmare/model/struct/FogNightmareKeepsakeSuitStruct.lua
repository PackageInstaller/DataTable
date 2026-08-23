local FogNightmareKeepsakeSuitStruct = class("FogNightmareKeepsakeSuitStruct")
local var_0_2 = g.core.config.fog_seal_suit_info

function FogNightmareKeepsakeSuitStruct:ctor(arg_1_1)
	self._cfg = arg_1_1
	self._activeKeepsakeList = {}
	self._activeNum = 0
	self._effectInfoList = {}

	self:_initEffectInfo()
end

function FogNightmareKeepsakeSuitStruct:_initEffectInfo()
	self._effectInfoList = {}

	local var_2_0 = 1
	local var_2_1 = 0

	while var_0_2.hasKey("effect_need_" .. 1) do
		local var_2_2 = {
			power = self._cfg["effect_power_" .. var_2_0],
			effectType = self._cfg["effect_type_" .. var_2_0],
			effectValue = self._cfg["effect_value_" .. var_2_0],
			targetNum = self._cfg["effect_need_" .. 1],
			desTxt = self._cfg["effect_des_" .. var_2_0]
		}

		if self._cfg["effect_need_" .. 1] > 0 then
			self._effectInfoList[#self._effectInfoList + 1] = var_2_2
			var_2_1 = var_2_1 + var_2_2.power
			var_2_2.totalPower = var_2_1
		end

		var_2_0 = var_2_0 + 1
	end
end

function FogNightmareKeepsakeSuitStruct:getCfg()
	return self._cfg
end

function FogNightmareKeepsakeSuitStruct:addActiveKeepsake(arg_4_1)
	table.insert(self._activeKeepsakeList, arg_4_1)

	local var_4_1

	var_4_1, self._activeNum = self:getActiveInfo(#self._activeKeepsakeList)
end

function FogNightmareKeepsakeSuitStruct:removeActiveKeepsake(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self._activeKeepsakeList) do
		if iter_5_1 == arg_5_1 then
			table.remove(self._activeKeepsakeList, iter_5_0)

			break
		end
	end

	local var_5_1

	var_5_1, self._activeNum = self:getActiveInfo(#self._activeKeepsakeList)
end

function FogNightmareKeepsakeSuitStruct:removeAllKeepsake()
	self._activeKeepsakeList = {}

	local var_6_1

	var_6_1, self._activeNum = self:getActiveInfo(#self._activeKeepsakeList)
end

function FogNightmareKeepsakeSuitStruct:replaceActiveKeepsake(arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(self._activeKeepsakeList) do
		if iter_7_1 == arg_7_1 then
			self._activeKeepsakeList[iter_7_0] = arg_7_2

			break
		end
	end
end

function FogNightmareKeepsakeSuitStruct:getAllEffectInfo()
	return self._effectInfoList
end

function FogNightmareKeepsakeSuitStruct:getActiveInfo(arg_9_1)
	local var_9_0
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(self._effectInfoList) do
		if arg_9_1 >= iter_9_1.targetNum then
			var_9_0 = iter_9_1
			var_9_1 = iter_9_0
		else
			break
		end
	end

	return var_9_0, var_9_1
end

function FogNightmareKeepsakeSuitStruct:getEffectInfoByIndex(arg_10_1)
	arg_10_1 = not arg_10_1 and 1 or math.min(#self._effectInfoList, arg_10_1)

	return self._effectInfoList[arg_10_1]
end

function FogNightmareKeepsakeSuitStruct:getCurActiveInfo()
	local var_11_0 = {}

	for iter_11_0 = 1, self._activeNum do
		var_11_0[iter_11_0] = self._effectInfoList[iter_11_0]
	end

	return var_11_0
end

function FogNightmareKeepsakeSuitStruct:getPower()
	return (self._effectInfoList[self._activeNum] or nil) and self._effectInfoList[self._activeNum].totalPower
end

function FogNightmareKeepsakeSuitStruct:getActiveEffectInfos()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self._effectInfoList) do
		if iter_13_0 > self._activeNum then
			break
		end

		var_13_0[iter_13_1.effectType] = (var_13_0[iter_13_1.effectType] or 0) + iter_13_1.effectValue
	end

	return var_13_0
end

function FogNightmareKeepsakeSuitStruct:getActiveNum()
	return self._activeNum
end

function FogNightmareKeepsakeSuitStruct:getActiveKeepsakeNum()
	return #self._activeKeepsakeList
end

return FogNightmareKeepsakeSuitStruct
