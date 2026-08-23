local PreciousDevSuitComp = class("PreciousDevSuitComp", require("app.fairyGUI.precious.UI_PreciousDevSuitComp"))

function PreciousDevSuitComp:ctor()
	self._preciousSuit = nil

	self.m_suitNameComp:addClickListener(handler(self, self._onClickPreciousNameComp))
end

function PreciousDevSuitComp:updateSuitComp(arg_2_1)
	self._preciousSuit = arg_2_1.suit
	self._advId = arg_2_1.advanceId

	self.m_rotateComp:updateView(self._preciousSuit, self._advId)
	self.m_suitNameComp:updateSuitName(self._preciousSuit)
end

function PreciousDevSuitComp:playRotateEff()
	self.m_rotateComp:playEffect()
end

function PreciousDevSuitComp:_onClickPreciousNameComp()
	g.core.module.ModuleManager:pushModule(g.view.entrance.PRECIOUS_SUIT_DEV, {
		group = self._preciousSuit:getSuitGroup()
	})
end

return PreciousDevSuitComp
