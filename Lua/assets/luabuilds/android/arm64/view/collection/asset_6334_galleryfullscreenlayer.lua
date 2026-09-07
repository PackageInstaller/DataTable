local GalleryFullScreenLayer = class("GalleryFullScreenLayer", import("..base.BaseUI"))

function GalleryFullScreenLayer:getUIName()
	return "GalleryViewUI"
end

function GalleryFullScreenLayer:init()
	self:findUI()
	self:initData()
	self:addListener()

	return
end

function GalleryFullScreenLayer:didEnter()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	self:updatePicImg()

	return
end

function GalleryFullScreenLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function GalleryFullScreenLayer:onBackPressed()
	if not self.isShowing then
		self:closeView()
	end

	return
end

function GalleryFullScreenLayer:findUI()
	self.bg = self._tf:Find("BG")
	self.picImg = self._tf:Find("Pic")

	return
end

function GalleryFullScreenLayer:initData()
	self.picID = self.contextData.picID

	return
end

function GalleryFullScreenLayer:addListener()
	onButton(self, self.bg, function()
		if not self.isShowing then
			self:closeView()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.picImg, function()
		if not self.isShowing then
			self:closeView()
		end

		return
	end, SFX_PANEL)

	return
end

function GalleryFullScreenLayer:updatePicImg()
	setImageSprite(self.picImg, LoadSprite(GalleryConst.PIC_PATH_PREFIX .. pg.gallery_config[self.picID].illustration, pg.gallery_config[self.picID].illustration))

	self.isShowing = true

	LeanTween.value(go(self.picImg), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_12_0)
		setImageAlpha(self.picImg, arg_12_0)

		return
	end)):setOnComplete(System.Action(function()
		self.isShowing = false

		setImageAlpha(self.picImg, 1)

		return
	end))

	return
end

return GalleryFullScreenLayer
