local var_0_0 = g.core.model.User.warriorsOfFateData
local WarriorsConst = require("app.view.module.warriorsOfFate.const.WarriorsConst")
local WarriorsGeneralComp = class("WarriorsGeneralComp", require("app.fairyGUI.warriorsOfFate.UI_WarriorsGeneralComp"))

function WarriorsGeneralComp:ctor(arg_1_1)
	self.m_pageListPane = self.m_pageList:getScrollPane()
	self.m_pageListGap = self.m_pageList:getColumnGap()
	self.m_visible = false

	self:_bindCommonEvents()
	self:addBg("bg/warriors/bg_lzzm_jibanjiyi.jpg", false)
	self.m_pageList:setIniter()
	self.m_pageList:setItemRendererAsync1(handler(self, self._onPageListRenderer), 0.02, false)
	self:setSize(display.width, display.height)
	self:addListen(self.m_pageList)
end

function WarriorsGeneralComp:init(arg_2_1)
	self.m_type = arg_2_1 or WarriorsConst.MAIN

	self:_bindNetEvents()
end

function WarriorsGeneralComp:onLoad()
	self:_bindNetEvents()
end

function WarriorsGeneralComp:setVisibility(arg_4_1)
	self:setVisible(arg_4_1)

	self._visible = arg_4_1
end

function WarriorsGeneralComp:updateComp(arg_5_1)
	if not self._visible then
		return
	end

	self:dispatchCompEvent("WarriorsComp_Map", {
		event = "SET_TYPE",
		type = self.m_type
	})
	self:_initPageList()
	self:_updateProgress()

	if not self._isInit or arg_5_1.scrollActivate then
		self._isInit = true

		self:_scrollToNextLand(arg_5_1)
	else
		self:_setLandMap(self._lastLandIndex)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	self:dispatchCompEvent("WarriorsComp_Arrow", {
		landIndex = self:_getMinDisChapterID(),
		landNum = var_0_0:getActLandNum(self.m_type)
	})
end

function WarriorsGeneralComp:_bindNetEvents()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SCROLL_INFO, handler(self, self._onScrollInfo), self)
end

function WarriorsGeneralComp:_bindCommonEvents()
	self.m_pageList:addEventListener(fgui.UIEventType.ScrollEnd, handler(self, self._onScrollPageListEnd))
	self.m_pageList:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_pageList:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function WarriorsGeneralComp:_onPageListRenderer(arg_8_1, arg_8_2)
	arg_8_2:updatePage(arg_8_1, self.m_type)
end

function WarriorsGeneralComp:_getCurrentLandIndex()
	return (var_0_0:getActLandNum(self.m_type))
end

function WarriorsGeneralComp:_onScrollPageListEnd()
	local var_10_0 = self:_getMinDisChapterID()

	self:dispatchCompEvent("WarriorsComp_Arrow", {
		landIndex = var_10_0,
		landNum = var_0_0:getActLandNum(self.m_type)
	})
	self:_setLandMap(var_10_0 + 1)
end

function WarriorsGeneralComp:_onTouchBegin(arg_11_1)
	self:dispatchCompEvent("WarriorsComp_Map", {
		event = "CLOSE"
	})

	if arg_11_1 then
		self._startPosX = arg_11_1:getInput():getTouch():getLocationInView().x

		return
	end

	self._startPosX = nil
end

function WarriorsGeneralComp:_onTouchEnd(arg_12_1)
	if self._startPosX and self._pageNum then
		if arg_12_1:getInput():getTouch():getLocationInView().x - self._startPosX <= -200 and self:_getMinDisChapterID() >= self._pageNum - 1 then
			if self._pageNum >= #var_0_0:getLandInfos(self.m_type) then
				g.core.module.ModuleManager:tip(g.core.lang:get(105015))
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(105016))
			end
		end

		self._startPosX = nil
	end
end

function WarriorsGeneralComp:_isCompleteLand(arg_13_1)
	local var_13_0 = #var_0_0:getActChaptersByLand(self.m_type, arg_13_1)
	local var_13_1 = #var_0_0:getChaptersByLand(self.m_type, arg_13_1)

	return var_13_1 <= var_13_0, var_13_0 / var_13_1, var_13_0, var_13_1
end

function WarriorsGeneralComp:_onScrollInfo()
	if not self._visible then
		return
	end

	self:updateComp({
		isSlide = false
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	self:dispatchCompEvent("WarriorsComp_Arrow", {
		landIndex = self:_getMinDisChapterID(),
		landNum = var_0_0:getActLandNum(self.m_type)
	})
end

function WarriorsGeneralComp:_getMinDisChapterID()
	return (math.floor(self.m_pageListPane:getPercX() / (1 / (self.m_pageList:getNumItems() - 1)) + 0.5))
end

function WarriorsGeneralComp:_initPageList()
	self._pageNum = var_0_0:getActLandNum(self.m_type) or 0

	self.m_pageList:setNumItems(self._pageNum)
end

function WarriorsGeneralComp:_scrollToNextLand(arg_17_1)
	local var_17_0 = true

	if arg_17_1 then
		var_17_0 = arg_17_1.isSlide
	end

	local var_17_1 = self:_getCurrentLandIndex()

	if var_17_0 then
		if var_17_1 <= self._pageNum then
			self._isInToNextChapter = true

			self:runFGAction((fgui.FSequence:create({
				fgui.FDelayTime:create(WarriorsConst.delayTimeToNextChapter),
				fgui.FCallFunc:create(handler(self, function()
					self.m_pageList:scrollToView(var_17_1 - 1, true)
					self:_setLandMap(var_17_1)
				end)),
				fgui.FCallFunc:create(handler(self, function()
					self._isInToNextChapter = false
				end))
			})))
		end
	else
		self.m_pageList:scrollToView(var_17_1 - 1, false)
		self:_setLandMap(var_17_1)
	end
end

function WarriorsGeneralComp:selectLand(arg_20_1)
	self:_setLandMap(arg_20_1 + 1)
	self.m_pageList:scrollToView(arg_20_1)
	self:dispatchCompEvent("WarriorsComp_Arrow", {
		landIndex = arg_20_1 + 1,
		landNum = var_0_0:getActLandNum(self.m_type)
	})
end

function WarriorsGeneralComp:getCurrentPageId()
	return self:_getMinDisChapterID() + 1
end

function WarriorsGeneralComp:_updateProgress()
	local var_22_0, var_22_1, var_22_2 = var_0_0:getCurrentActStage(self.m_type)

	self:dispatchCompEvent("WarriorsComp_Progress", {
		type = self.m_type,
		stageId = var_22_2,
		actChapterNum = var_22_0,
		chapterNum = var_22_1
	})
end

function WarriorsGeneralComp:onClickLeftArrow()
	if self._isInToNextChapter then
		return
	end

	self:stopAllFGActions()

	local var_23_0 = self:_getMinDisChapterID()

	if var_23_0 - 1 >= 0 then
		self.m_pageList:scrollToView(var_23_0 - 1, true)
		self:_setLandMap(var_23_0)
		self:dispatchCompEvent("WarriorsComp_Arrow", {
			landIndex = self:_getMinDisChapterID(),
			landNum = var_0_0:getActLandNum(self.m_type)
		})
	end
end

function WarriorsGeneralComp:onClickRightArrow()
	if self._isInToNextChapter then
		return
	end

	self:stopAllFGActions()

	local var_24_0 = self:_getMinDisChapterID()

	if self._pageNum and var_24_0 + 1 < self._pageNum then
		self.m_pageList:scrollToView(var_24_0 + 1, true)
		self:_setLandMap(var_24_0 + 2)
		self:dispatchCompEvent("WarriorsComp_Arrow", {
			landIndex = self:_getMinDisChapterID(),
			landNum = var_0_0:getActLandNum(self.m_type)
		})
	end
end

function WarriorsGeneralComp:_setLandMap(arg_25_1)
	self:dispatchCompEvent("WarriorsComp_Map", {
		event = "SET_ONFOCUS",
		landIndex = arg_25_1 - 1
	})

	self._lastLandIndex = arg_25_1
end

return WarriorsGeneralComp
