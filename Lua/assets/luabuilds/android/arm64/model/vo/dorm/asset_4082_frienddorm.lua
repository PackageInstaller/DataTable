local FriendDorm = class("FriendDorm", import(".Dorm"))

function FriendDorm:GetName()
	if getProxy(PlayerProxy):getRawData():ShouldCheckCustomName() then
		return i18n("nodisplay_player_home_name")
	else
		return FriendDorm.super.GetName(self)
	end

	return
end

return FriendDorm
