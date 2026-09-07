local MainEducateCharIcon = class("MainEducateCharIcon", import(".MainBaseIcon"))

function MainEducateCharIcon:Ctor(arg_1_1)
	MainEducateCharIcon.super.Ctor(self, arg_1_1)

	self.iconTr = arg_1_1:Find("icon")
	self.iconImg = self.iconTr:GetComponent(typeof(Image))

	return
end

function MainEducateCharIcon:Load(arg_2_1)
	setActive(self.iconTr, true)
	GetImageSpriteFromAtlasAsync("SquareIcon/" .. arg_2_1, "", self.iconTr, true)

	return
end

function MainEducateCharIcon:Unload()
	setActive(self.iconTr, false)

	self.iconImg.sprite = nil

	return
end

return MainEducateCharIcon
