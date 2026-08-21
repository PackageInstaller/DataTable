local var_0_0 = class("FriendDorm", import(".Dorm"))

function var_0_0.GetName(arg_1_0)
	if getProxy(PlayerProxy):getRawData():ShouldCheckCustomName() then
		return i18n("nodisplay_player_home_name")
	else
		return var_0_0.super.GetName(arg_1_0)
	end

	return
end

return var_0_0
