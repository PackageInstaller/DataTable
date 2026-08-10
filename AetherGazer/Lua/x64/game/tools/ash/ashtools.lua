return {
	GetTypeLevels = function(arg_1_0, arg_1_1)
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in ipairs(AshShootStageCfg.all) do
			if AshShootStageCfg[iter_1_1].stage_group == arg_1_1 then
				table.insert(var_1_0, iter_1_1)
			end
		end

		return var_1_0
	end
}
