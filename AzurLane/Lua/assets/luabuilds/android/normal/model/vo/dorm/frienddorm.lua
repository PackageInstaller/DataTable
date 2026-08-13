class = var_0_10000

local var_0_0 = "FriendDorm"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".Dorm"))

function var_0_1.GetName(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getRawData(var_1_0)

	if var_1.ShouldCheckCustomName(var_1_1) then
		i18n = var_1

		return var_1("nodisplay_player_home_name")
	else
		return var_0_1.super.GetName(arg_1_0)
	end

	return
end

return var_0_1
