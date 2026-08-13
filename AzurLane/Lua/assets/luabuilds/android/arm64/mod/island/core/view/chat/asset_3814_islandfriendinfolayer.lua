class = var_0_10000

local var_0_0 = "IslandFriendInfoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.friend.FriendInfoLayer"))

function var_0_1.getUIName(arg_1_0)
	return "IslandFriendInfoUI"
end

function var_0_1.GetBtnTags(arg_2_0)
	return {
		"OPEN_RESUME",
		"OPEND_FRIEND",
		"OPEN_ISLAND_CARD",
		"TOGGLE_BLACK",
		"OPEN_INFORM"
	}
end

return var_0_1
