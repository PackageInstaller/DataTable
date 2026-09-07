local CourtYardThemeOwner = class("CourtYardThemeOwner", import("model.vo.Player"))

function CourtYardThemeOwner:GetName()
	if getProxy(PlayerProxy):getRawData():ShouldCheckCustomName() then
		return i18n("nodisplay_player_home_share")
	else
		return CourtYardThemeOwner.super.GetName(self)
	end

	return
end

return CourtYardThemeOwner
