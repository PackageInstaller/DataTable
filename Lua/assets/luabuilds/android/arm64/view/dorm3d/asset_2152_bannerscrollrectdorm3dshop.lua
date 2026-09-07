local BannerScrollRectDorm3dShop = class("BannerScrollRectDorm3dShop", import("view.newMain.page.BannerScrollRect"))

function BannerScrollRectDorm3dShop:UpdateDotPosition(arg_1_1, arg_1_2)
	return
end

function BannerScrollRectDorm3dShop:TriggerDot(arg_2_1, arg_2_2)
	setActive(arg_2_1:Find("short"), not arg_2_2)
	setActive(arg_2_1:Find("long"), arg_2_2)

	return
end

function BannerScrollRectDorm3dShop:GetItemChild(arg_3_1)
	if self.items[arg_3_1] then
		if arg_3_1 > self.total then
			self.total = arg_3_1
		end

		return self.items[arg_3_1]
	else
		return nil
	end

	return
end

return BannerScrollRectDorm3dShop
