local var_0_0 = loadCfg("core.config.cfg.knight_info")
local var_0_1 = {
	isInitIndex = false,
	indexByAdvIdStar = {}
}

function var_0_1._initIndex()
	for iter_1_0 = 1, var_0_0.getLength() do
		local var_1_0 = var_0_0.indexOf(iter_1_0)

		if var_1_0.put == 1 then
			var_0_1.indexByAdvIdStar[var_1_0.advance_id] = var_0_1.indexByAdvIdStar[var_1_0.advance_id] or {}
			var_0_1.indexByAdvIdStar[var_1_0.advance_id][var_1_0.star] = var_1_0
		end
	end

	var_0_1.isInitIndex = true
end

function var_0_1._checkInitIndex()
	if not var_0_1.isInitIndex then
		var_0_1._initIndex()
	end
end

function var_0_1.getKnightByAdvIdStar(arg_3_0, arg_3_1)
	var_0_1._checkInitIndex()

	if var_0_1.indexByAdvIdStar[arg_3_0] and var_0_1.indexByAdvIdStar[arg_3_0][arg_3_1] then
		return var_0_1.indexByAdvIdStar[arg_3_0][arg_3_1]
	end

	return nil
end

return var_0_1
