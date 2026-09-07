local PublicGuildTechnology = class("PublicGuildTechnology", import("..GuildTechnology"))

function PublicGuildTechnology:GetConsume()
	local var_1_0 = self:getConfig("contribution_multiple")

	return self:getConfig("contribution_consume") * var_1_0, self:getConfig("gold_consume") * var_1_0
end

return PublicGuildTechnology
