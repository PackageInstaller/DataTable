local Dorm3dDancePhotoWindow = class("Dorm3dDancePhotoWindow", import("..Dorm3dGameBaseSubView"))

function Dorm3dDancePhotoWindow:Init()
	self.parentTf = self._tf.parent
	self.imageTf = self._tf:Find("border/mask/image")
	self.maskTf = self._tf:Find("border/mask")
	self.frameTf = self._tf:Find("border")

	onButton(self, self._tf:Find("btn_save"), function()
		self.contextData.onSaveImage(self.frameTf)

		return
	end, SFX_DORM_CLICK)
	onButton(self, self._tf, function()
		self:CloseWindow()

		return
	end, SFX_DORM_CLICK)

	return
end

function Dorm3dDancePhotoWindow:Flush(arg_4_1, arg_4_2)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self.contextData.onShowRealImage(arg_4_1, self.imageTf, self.maskTf)
	setActive(self._tf:Find("btn_save"), not arg_4_2)

	if arg_4_2 then
		self.tId = LeanTween.delayedCall(1, System.Action(function()
			self:CloseWindow()

			return
		end)).uniqueId
	end

	return
end

function Dorm3dDancePhotoWindow:CloseWindow()
	if self.tId then
		LeanTween.cancel(self.tId)

		self.tId = nil
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.parentTf)
	self:Hide()
	self.contextData.onHide()

	return
end

function Dorm3dDancePhotoWindow:Dispose()
	if isActive(self._tf) then
		self:CloseWindow()
	end

	return
end

return Dorm3dDancePhotoWindow
