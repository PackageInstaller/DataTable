local var_0_0 = class("PublicGuildTechnology", import("..GuildTechnology"))

function var_0_0.GetConsume(arg_1_0)
	local var_1_0 = arg_1_0:getConfig("contribution_multiple")

	return arg_1_0:getConfig("contribution_consume") * var_1_0, arg_1_0:getConfig("gold_consume") * var_1_0
end

return var_0_0
