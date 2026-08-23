local var_0_1 = g.core.const.ConstMgr.KnightSoulConst
local KnightSoulBookComp = class("KnightSoulBookComp", require("app.fairyGUI.knightSoul.UI_KnightSoulBookComp"))

function KnightSoulBookComp:ctor()
	self._chapterId = 0
	self._curSelectedAttr = var_0_1.SEARCH_TYPE.ALL
	self._curSelectedIndex = 0
	self._showBookList = {}
	self._curStruct = nil

	self.m_searchBtn:addClickListener(handler(self, self._onClickSearchBtn))
	self.m_bookList:setVirtual()
	self.m_bookList:setItemRenderer(handler(self, self._onRenderBookList))
	self.m_bookList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickBook))
end

function KnightSoulBookComp:updateBookComp(arg_2_1, arg_2_2)
	self._showBookList = arg_2_1

	self:_updateView()
	self.m_bookList:setSelectedIndex(arg_2_2 - 1)
end

function KnightSoulBookComp:resetSearchBtn()
	self.m_searchBtn:setSelected(false)
end

function KnightSoulBookComp:scrollTo(arg_4_1)
	self.m_bookList:scrollToView(arg_4_1 - 1)
end

function KnightSoulBookComp:_updateView()
	self.m_bookList:setNumItems(#self._showBookList)
end

function KnightSoulBookComp:_onClickSearchBtn()
	self:dispatchCompEvent("show_attr_list")
end

function KnightSoulBookComp:_onClickBook(arg_7_1)
	local var_7_0 = arg_7_1:getDataValue()

	self:dispatchCompEvent("change_selected_struct", {
		struct = self._showBookList[var_7_0 + 1],
		index = var_7_0 + 1
	})
end

function KnightSoulBookComp:_onRenderBookList(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._showBookList[arg_8_1 + 1])
end

return KnightSoulBookComp
