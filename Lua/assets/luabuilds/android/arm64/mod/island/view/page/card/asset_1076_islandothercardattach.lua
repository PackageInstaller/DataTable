local IslandOtherCardAttach = class("IslandOtherCardAttach", import(".external.IslandOtherCardLayer"))

function IslandOtherCardAttach:didEnter()
	IslandOtherCardAttach.super.didEnter(self)
	onNextTick(function()
		self:ExtraHandle()

		return
	end)

	return
end

function IslandOtherCardAttach:ExtraHandle()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IslandOtherCardAttach:closeView()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.contextData.container)
	self.contextData.onClose()

	return
end

return IslandOtherCardAttach
