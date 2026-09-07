local BannerScrollRect4Mellow = class("BannerScrollRect4Mellow", import(".BannerScrollRect"))

function BannerScrollRect4Mellow:UpdateDotPosition(arg_1_1, arg_1_2)
	return
end

function BannerScrollRect4Mellow:TriggerDot(arg_2_1, arg_2_2)
	arg_2_1:GetComponent(typeof(LayoutElement)).minWidth = arg_2_2 and 45 or 10

	return
end

return BannerScrollRect4Mellow
