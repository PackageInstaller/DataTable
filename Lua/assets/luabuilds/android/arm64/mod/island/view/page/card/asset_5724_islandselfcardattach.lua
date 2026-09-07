local IslandSelfCardAttach = class("IslandSelfCardAttach", import(".external.IslandSelfCardLayer"))

function IslandSelfCardAttach:didEnter()
	IslandSelfCardAttach.super.didEnter(self)
	onNextTick(function()
		self:ExtraHandle()

		return
	end)

	return
end

function IslandSelfCardAttach:ExtraHandle()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IslandSelfCardAttach:closeView()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.contextData.container)
	self.contextData.onClose()

	return
end

return IslandSelfCardAttach
