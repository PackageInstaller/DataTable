local SVGlobalBuff = class("SVGlobalBuff", import("view.base.BaseSubView"))

SVGlobalBuff.HideView = "SVGlobalBuff.HideView"

function SVGlobalBuff:getUIName()
	return "SVGlobalBuff"
end

function SVGlobalBuff:OnLoaded()
	return
end

function SVGlobalBuff:OnInit()
	self.rtFrame = self._tf:Find("frame")
	self.rtPanel = self.rtFrame:Find("buff_panel/buff_bg")
	self.rtInfo = self.rtFrame:Find("buff_panel/info")

	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_CANCEL)

	return
end

function SVGlobalBuff:OnDestroy()
	return
end

function SVGlobalBuff:Show()
	setLocalScale(self.rtFrame, Vector3(0.5, 0.5, 0.5))
	LeanTween.cancel(go(self.rtFrame))
	LeanTween.scale(self.rtFrame, Vector3.one, 0.15)
	setActive(self._tf, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function SVGlobalBuff:Hide()
	LeanTween.cancel(go(self.rtFrame))
	setActive(self._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	self:emit(SVGlobalBuff.HideView, self.callback)

	return
end

function SVGlobalBuff:Setup(arg_8_1, arg_8_2)
	self.callback = arg_8_2

	eachChild(self.rtPanel, function(arg_9_0)
		setActive(arg_9_0, arg_9_0.name == tostring(arg_8_1.id))

		return
	end)

	local var_8_0 = WorldBuff.New()

	var_8_0:Setup({
		id = arg_8_1.id,
		floor = arg_8_1.before
	})
	setText(self.rtInfo:Find("name"), var_8_0.config.name)
	setText(self.rtInfo:Find("value_before"), var_8_0:GetFloor())
	var_8_0:AddFloor(arg_8_1.floor)
	setText(self.rtInfo:Find("value"), var_8_0:GetFloor())

	return
end

return SVGlobalBuff
