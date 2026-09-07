local IslandBannerScrollRect = class("IslandBannerScrollRect", import("view.newMain.page.BannerScrollRect"))

function IslandBannerScrollRect:UpdateDotPosition(arg_1_1, arg_1_2)
	return
end

function IslandBannerScrollRect:TriggerDot(arg_2_1, arg_2_2)
	setActive(arg_2_1:Find("unsel"), not arg_2_2)
	setActive(arg_2_1:Find("sel"), arg_2_2)

	return
end

return IslandBannerScrollRect
