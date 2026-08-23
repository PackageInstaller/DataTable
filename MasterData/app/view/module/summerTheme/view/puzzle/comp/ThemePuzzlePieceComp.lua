local ThemePuzzlePieceComp = class("ThemePuzzlePieceComp", require("app.fairyGUI.summerThemeGame.UI_ThemePuzzlePieceComp"))

function ThemePuzzlePieceComp:ctor()
	self.m_pieceList:setVirtual(self)
	self.m_pieceList:setItemRenderer(handler(self, self._onItemRenderer))

	self._allPieceSet = {}
end

function ThemePuzzlePieceComp:updateView(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1.group then
		self._group = arg_2_1.group
	end

	if arg_2_1.ctrlIdx then
		self._ctrlIdx = arg_2_1.ctrlIdx
	end

	if arg_2_1.allPieceSet then
		self._allPieceSet = arg_2_1.allPieceSet
	end

	self.m_pieceList:setNumItems(#self._allPieceSet)
	self.m_pieceList:transitionShowCells("enter_up", 0.1)
end

function ThemePuzzlePieceComp:_onItemRenderer(arg_3_1, arg_3_2)
	if self._allPieceSet[arg_3_1 + 1] then
		arg_3_2:update({
			info = self._allPieceSet[arg_3_1 + 1],
			ctrlIdx = self._ctrlIdx,
			cellIdx = arg_3_1 + 1
		})
	end
end

function ThemePuzzlePieceComp:getGuildComp()
	if self.m_pieceList:numChildren() > 1 then
		return self.m_pieceList:getChildAt(0)
	end

	return nil
end

function ThemePuzzlePieceComp:setListScrollEnabled(arg_5_1)
	self.m_pieceList:setScrollEnabled(arg_5_1)
end

function ThemePuzzlePieceComp:onLoad()
	return
end

function ThemePuzzlePieceComp:onUnload()
	return
end

return ThemePuzzlePieceComp
