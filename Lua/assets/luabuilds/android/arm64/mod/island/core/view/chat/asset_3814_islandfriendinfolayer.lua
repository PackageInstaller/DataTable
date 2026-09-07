local IslandFriendInfoLayer = class("IslandFriendInfoLayer", import("view.friend.FriendInfoLayer"))

function IslandFriendInfoLayer:getUIName()
	return "IslandFriendInfoUI"
end

function IslandFriendInfoLayer:GetBtnTags()
	return {
		"OPEN_RESUME",
		"OPEND_FRIEND",
		"OPEN_ISLAND_CARD",
		"TOGGLE_BLACK",
		"OPEN_INFORM"
	}
end

return IslandFriendInfoLayer
