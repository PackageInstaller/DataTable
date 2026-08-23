local FogNightmareKeepsakeStruct = class("FogNightmareKeepsakeStruct")
local var_0_2 = g.core.config.fog_seal_info
local var_0_3 = g.core.config.fog_seal_level_info

function FogNightmareKeepsakeStruct:ctor(arg_1_1)
	local var_1_0 = arg_1_1

	arg_1_1 = math.floor(arg_1_1)

	if var_1_0 ~= arg_1_1 then
		-- block empty
	end

	self.id = arg_1_1
	self._cfg = var_0_3.fetch(self.id)
	self._baseInfo = var_0_2.get(self._cfg.seal_id)
end

function FogNightmareKeepsakeStruct:getCfg()
	return self._cfg
end

function FogNightmareKeepsakeStruct:getBaseInfo()
	return self._baseInfo
end

function FogNightmareKeepsakeStruct:getAttr()
	local var_4_0 = {}
	local var_4_1 = 1

	while var_0_3.hasKey("affect_type_" .. var_4_1) do
		var_4_0[self._cfg["affect_type_" .. var_4_1]] = var_4_0[self._cfg["affect_type_" .. var_4_1]] and var_4_0[self._cfg["affect_type_" .. var_4_1]] + self._cfg["affect_value_" .. var_4_1] or self._cfg["affect_value_" .. var_4_1]
		var_4_1 = var_4_1 + 1
	end

	local var_4_2 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		if iter_4_0 > 0 and iter_4_1 > 0 then
			table.insert(var_4_2, {
				key = iter_4_0,
				value = iter_4_1
			})
		end
	end

	return var_4_2
end

function FogNightmareKeepsakeStruct:isMaxLevel()
	if self._isMax ~= nil then
		return self._isMax
	else
		for iter_5_0 = 1, var_0_3.getLength() do
			local var_5_0 = var_0_3.indexOf(iter_5_0)

			if self._cfg.seal_id == var_5_0.seal_id and var_5_0.level > self._cfg.level then
				self._isMax = false

				return false
			end
		end

		self._isMax = true

		return true
	end
end

function FogNightmareKeepsakeStruct:getPower()
	return self._cfg.power
end

return FogNightmareKeepsakeStruct
