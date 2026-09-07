local MainBannerView4Mellow = class("MainBannerView4Mellow", import("...theme_classic.view.MainBannerView"))

function MainBannerView4Mellow:Ctor(arg_1_1, arg_1_2)
	MainBannerView4Mellow.super.Ctor(self, arg_1_1, arg_1_2)

	self.scrollSnap = BannerScrollRect4Mellow.New(findTF(arg_1_1, "mask/content"), findTF(arg_1_1, "dots"))

	return
end

function MainBannerView4Mellow:GetDirection()
	return Vector2.zero
end

return MainBannerView4Mellow
