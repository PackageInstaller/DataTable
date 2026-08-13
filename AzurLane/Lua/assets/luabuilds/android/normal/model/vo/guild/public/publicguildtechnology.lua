class = var_0_10000

local var_0_0 = "PublicGuildTechnology"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..GuildTechnology"))

function var_0_1.GetConsume(arg_1_0)
	local var_1_0 = arg_1_0:getConfig("contribution_consume")
	local var_1_1 = arg_1_0:getConfig("gold_consume")

	return var_1_0 * arg_1_0:getConfig("contribution_multiple"), var_1_1 * var_3
end

return var_0_1
