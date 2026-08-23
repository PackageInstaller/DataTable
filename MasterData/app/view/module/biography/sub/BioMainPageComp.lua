local var_0_0 = g.core.model.User.bioData
local BioMainPageComp = class("BioMainPageComp", require("app.fairyGUI.biography.UI_BioMainPageComp"))

function BioMainPageComp:ctor(arg_1_1)
	self._lastLandIndex = nil
	self._needPlayOpenIndex = nil
	self._needPlayOpenItem = nil
	self._landArr = var_0_0:getLands()

	for iter_1_0 = 1, #self._landArr do
		self.m_pageController:addPage(iter_1_0, "")
	end

	self.m_pageController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onPageChanged))
	self.m_pageController:setSelectedIndex(0)
	self.m_pageList:setIniter()
	self.m_pageList:setItemRenderer(handler(self, self._onRenderPage))
	self.m_pageList:addEventListener(fgui.UIEventType.ScrollEnd, handler(self, self._onListScrollEnd))
	self.m_pageList:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_pageList:getScrollPane():cancelDragging()
end

function BioMainPageComp:update()
	if self._lastLandIndex == nil then
		self:_initLandPageList()
	else
		self:_checkLandPageList()
	end
end

function BioMainPageComp:_onRenderPage(arg_3_1, arg_3_2)
	if arg_3_1 + 1 == self._needPlayOpenIndex then
		self._needPlayOpenItem = arg_3_2
	end

	arg_3_2:updatePageView(self._landArr[arg_3_1 + 1])
end

function BioMainPageComp:_onListScrollEnd()
	self:dispatchCompEvent("EVENT_BIOMAIN_PAGE_SCROLLEND", {
		pageIndex = self.m_pageController:getSelectedIndex()
	})

	if self._needPlayOpenItem then
		self._needPlayOpenItem:playFirstChapterOpen()

		self._needPlayOpenItem = nil
	end
end

function BioMainPageComp:_initLandPageList()
	local var_5_0 = var_0_0:getCurLandIndex()

	self._lastLandIndex = var_5_0

	self.m_pageList:setNumItems(var_5_0)
	self.m_pageList:scrollToView(var_5_0 - 1)
end

function BioMainPageComp:_checkLandPageList()
	local var_6_0 = var_0_0:getCurLandIndex()

	if var_6_0 > self._lastLandIndex then
		self._needPlayOpenIndex = var_6_0

		self.m_pageList:setNumItems(var_6_0)
		self.m_pageList:scrollToView(var_6_0 - 1, true)

		self._lastLandIndex = var_6_0
		self._needPlayOpenIndex = nil
	else
		self.m_pageList:setNumItems(var_6_0)
	end
end

function BioMainPageComp:_onPageChanged()
	self:dispatchCompEvent("EVENT_BIOMAIN_PAGE_CHANGED", {
		pageIndex = self.m_pageController:getSelectedIndex()
	})
end

function BioMainPageComp:scrollCurPage(arg_8_1, arg_8_2)
	local var_8_0 = self.m_pageList:getChildAt(arg_8_1)
	local var_8_1 = arg_8_2 == "right" and self.m_pageList:getChildAt(arg_8_1 - 1) or (arg_8_2 ~= "left" or true) and nil

	self.m_pageList:getChildAt(arg_8_1 + 1):playSwitchTransition("out", handler(self, function()
		self.m_pageList:scrollToView(arg_8_1)
		var_8_0:playSwitchTransition("enter")
	end))
end

function BioMainPageComp:getCurPageIndex()
	return self.m_pageController:getSelectedIndex()
end

function BioMainPageComp:_onTouchBegin(arg_11_1)
	self:dispatchCompEvent("MAP_COMP_CLOSE")
end

return BioMainPageComp
