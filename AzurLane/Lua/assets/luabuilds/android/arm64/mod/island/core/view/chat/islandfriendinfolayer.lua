local var_0_0 = class("IslandFriendInfoLayer", import("view.friend.FriendInfoLayer"))

function var_0_0.getUIName(arg_1_0)
	return "IslandFriendInfoUI"
end

function var_0_0.GetBtnTags(arg_2_0)
	return {
		"OPEN_RESUME",
		"OPEND_FRIEND",
		"OPEN_ISLAND_CARD",
		"TOGGLE_BLACK",
		"OPEN_INFORM"
	}
end

return var_0_0
