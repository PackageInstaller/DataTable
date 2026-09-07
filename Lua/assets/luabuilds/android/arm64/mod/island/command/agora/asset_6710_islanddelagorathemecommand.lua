local IslandDelAgoraThemeCommand = class("IslandDelAgoraThemeCommand", pm.SimpleCommand)

function IslandDelAgoraThemeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	print("del------------->", var_1_0)
	getProxy(IslandProxy):GetIsland():GetAgoraAgency():DelTheme(var_1_0)
	self:sendNotification(GAME.ISLAND_DEL_AGORA_THEME_DONE)

	return
end

return IslandDelAgoraThemeCommand
