local AtelierCompositeResultView = class("AtelierCompositeResultView", import("view.base.BasePanel"))

function AtelierCompositeResultView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject
	self._tf = arg_1_1
	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	setActive(self._go, false)
	self:Init()

	return
end

function AtelierCompositeResultView:Init()
	setText(self._tf:Find("Window/CountBG/Tip"), i18n("ryza_composite_count"))

	return
end

function AtelierCompositeResultView:SetContextData(arg_3_1)
	self.contextData = arg_3_1

	return
end

function AtelierCompositeResultView:SetActivity(arg_4_1)
	self.activity = arg_4_1

	return
end

function AtelierCompositeResultView:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		self:HideCompositeResult()

		return
	end, SFX_CANCEL)

	return
end

function AtelierCompositeResultView:ShowCompositeResult(arg_7_1)
	setActive(self._go, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	if arg_7_1[1] == nil then
		return
	end

	self._parentClass:UpdateRyzaDrop(self._tf:Find("Window/Icon"), arg_7_1[1])
	setScrollText(self._tf:Find("Window/NameBG/Rect/Name"), arg_7_1[1]:getName())
	setText(self._tf:Find("Window/CountBG/Text"), arg_7_1[1].count)

	return
end

function AtelierCompositeResultView:HideCompositeResult()
	if not isActive(self._go) then
		return
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentClass._tf)
	setActive(self._go, false)
	self:PlayGuide()

	return true
end

function AtelierCompositeResultView:willExit()
	self:detach()

	return
end

function AtelierCompositeResultView:PlayGuide()
	if pg.NewStoryMgr.GetInstance():IsPlayed("NG0032") then
		pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0033", {
			2
		})
	end

	return
end

return AtelierCompositeResultView
