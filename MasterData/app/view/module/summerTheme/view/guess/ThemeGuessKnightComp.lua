local var_0_0 = 5
local ThemeGuessKnightComp = class("ThemeGuessKnightComp", require("app.fairyGUI.summerThemeGame.UI_ThemeGuessKnightComp"))

function ThemeGuessKnightComp:ctor()
	self._initPos = self.m_mask:getPosition()
end

function ThemeGuessKnightComp:changeKnight(arg_2_1)
	self._defaultCfg = arg_2_1

	self:onChangeKnight()
end

function ThemeGuessKnightComp:onChangeKnight()
	self.m_knightHolderComp:getChild("knightImg"):setURL(g.core.common.Path:getMiddleKnightPicById(self._defaultCfg.res))

	self._curRange = self._defaultCfg.initial_range
	self._perAddRange = self._defaultCfg.enlarge_range

	self.m_errorImg:setSize(cc.size(self._curRange + var_0_0, self._curRange + var_0_0))
	self.m_errorImg:setPosition(cc.pAdd(self._initPos, cc.p(-self._defaultCfg.x_pos * 0.7, -self._defaultCfg.y_pos * 0.7)))
end

function ThemeGuessKnightComp:onDefaultSelection()
	if self._curRange and self._perAddRange then
		self._curRange = self._curRange + self._perAddRange

		self.m_mask:setSize(cc.size(self._curRange, self._curRange))
		self.m_errorImg:setSize(cc.size(self._curRange + var_0_0, self._curRange + var_0_0))
		self.m_errorAnimTransition:play()
	end
end

function ThemeGuessKnightComp:showAll()
	self._curRange = 99999

	self.m_mask:setSize(cc.size(99999, 99999))
end

return ThemeGuessKnightComp
