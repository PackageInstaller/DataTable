local SVBossProgress = class("SVBossProgress", import("view.base.BaseSubView"))

SVBossProgress.HideView = "SVBossProgress.HideView"

function SVBossProgress:getUIName()
	return "SVBossProgress"
end

function SVBossProgress:OnLoaded()
	return
end

function SVBossProgress:OnInit()
	self.rtFrame = self._tf:Find("frame")
	self.rtPanel = self.rtFrame:Find("buff_panel/buff_bg")
	self.rtInfo = self.rtFrame:Find("buff_panel/info")

	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	return
end

function SVBossProgress:OnDestroy()
	return
end

function SVBossProgress:Show()
	setLocalScale(self.rtFrame, Vector3(0.5, 0.5, 0.5))
	LeanTween.cancel(go(self.rtFrame))
	LeanTween.scale(self.rtFrame, Vector3.one, 0.15)
	setActive(self._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SVBossProgress:Hide()
	LeanTween.cancel(go(self.rtFrame))
	setActive(self._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	self:emit(SVBossProgress.HideView, self.callback)

	return
end

function SVBossProgress:Setup(arg_8_1, arg_8_2)
	self.callback = arg_8_2

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.drops) do
		var_8_0 = var_8_0 + iter_8_1.count
	end

	setText(self._tf:Find("frame/buff_panel/info/name"), i18n("world_boss_drop_title"))
	setText(self._tf:Find("frame/buff_panel/info/value_before"), arg_8_1.total - var_8_0)
	setText(self._tf:Find("frame/buff_panel/info/value"), arg_8_1.total)

	return
end

return SVBossProgress
