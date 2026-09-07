local BannerScrollRect4Dorm = class("BannerScrollRect4Dorm", import("view.newMain.page.BannerScrollRect"))

function BannerScrollRect4Dorm:UpdateDotPosition(arg_1_1, arg_1_2)
	return
end

function BannerScrollRect4Dorm:TriggerDot(arg_2_1, arg_2_2)
	arg_2_1:GetComponent(typeof(LayoutElement)).minWidth = arg_2_2 and 52 or 12

	return
end

return BannerScrollRect4Dorm
