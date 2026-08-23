local var_0_0 = g.core.model.User.warriorsOfFateData
local WarriorsConst = require("app.view.module.warriorsOfFate.const.WarriorsConst")
local WarriorsMainComp = class("WarriorsMainComp", require("app.fairyGUI.warriorsOfFate.UI_WarriorsMainComp"))

function WarriorsMainComp:ctor(arg_1_1)
	self.m_pageListPane = self.m_pageList:getScrollPane()
	self.m_pageListGap = self.m_pageList:getColumnGap()
	self.m_visible = false
	self._isFirstEnter = true

	self:_bindCommonEvents()
	self:addBg("bg/warriors/bg_lzzm_weidayiwusuipian.jpg", false)
	self.m_pageList:setVirtual(self)
	self.m_pageList:doFairyBatching(false)
	self.m_pageList:setItemRendererAsync(handler(self, self._onPageListRenderer), 0.02, false)
	self:setSize(display.width, display.height)
	self:addListen(self.m_pageList)
end

function WarriorsMainComp:init(arg_2_1)
	self.m_type = arg_2_1 or WarriorsConst.MAIN

	self:_createBgEffect()
	self:_bindPageControl()
end

function WarriorsMainComp:onLoad()
	self:_bindNetEvents()
end

function WarriorsMainComp:_bindPageControl()
	for iter_4_0 = 1, #var_0_0:getLandInfos(self.m_type) do
		self.m_pageController:addPage(iter_4_0, "")
	end

	self.m_pageController:setSelectedIndex(0)
end

function WarriorsMainComp:onUnload()
	if self._popHandel then
		self:cancelSchedule(self._popHandel)

		self._popHandel = nil
	end
end

function WarriorsMainComp:_createBgEffect()
	for iter_6_0 = 1, 2 do
		local var_6_0 = {
			y = 0,
			name = "eff_ui_warriorsOfFate_bg",
			isLoop = true,
			anim = "play",
			x = 0
		}

		self:newScheduleOnce(function()
			self["m_eff_bg" .. tostring(iter_6_0)]:addEffectSpine(var_6_0)
		end, (iter_6_0 - 1) / 30)
	end
end

function WarriorsMainComp:setVisibility(arg_8_1)
	self:setVisible(arg_8_1)

	self._visible = arg_8_1
end

function WarriorsMainComp:updateComp(arg_9_1)
	if not self._visible then
		return
	end

	self:dispatchCompEvent("WarriorsComp_Map", {
		event = "SET_TYPE",
		type = self.m_type
	})
	self:_initPageList()
	self:_updateProgress()

	if not self._isInit or arg_9_1.scrollActivate then
		self._isInit = true

		self:_scrollToNextLand(arg_9_1)
	else
		self:_setLandMap(self._lastLandIndex)
	end

	self:dispatchCompEvent("WarriorsComp_Arrow", {
		landIndex = self:_getMinDisChapterID(),
		landNum = var_0_0:getActLandNum(self.m_type)
	})
end

function WarriorsMainComp:_bindNetEvents()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SCROLL_INFO, handler(self, self._onScrollInfo), self)
end

function WarriorsMainComp:_bindCommonEvents()
	self.m_pageList:addEventListener(fgui.UIEventType.ScrollEnd, handler(self, self._onScrollPageListEnd))
	self.m_pageList:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_pageList:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function WarriorsMainComp:_onPageListRenderer(arg_12_1, arg_12_2)
	arg_12_2:updatePage(arg_12_1, self.m_type)
end

function WarriorsMainComp:_getCurrentLandIndex()
	return (var_0_0:getActLandNum(self.m_type))
end

function WarriorsMainComp:_onScrollPageListEnd()
	local var_14_0 = self:_getMinDisChapterID()

	self:dispatchCompEvent("WarriorsComp_Arrow", {
		landIndex = var_14_0,
		landNum = var_0_0:getActLandNum(self.m_type)
	})
	self:_setLandMap(var_14_0 + 1)
end

function WarriorsMainComp:_onTouchBegin(arg_15_1)
	self:dispatchCompEvent("WarriorsComp_Map", {
		event = "CLOSE"
	})

	if arg_15_1 then
		self._startPosX = arg_15_1:getInput():getTouch():getLocationInView().x

		return
	end

	self._startPosX = nil
end

function WarriorsMainComp:_onTouchEnd(arg_16_1)
	if self._startPosX and self._pageNum then
		if arg_16_1:getInput():getTouch():getLocationInView().x - self._startPosX <= -200 and self:_getMinDisChapterID() >= self._pageNum - 1 then
			if self._pageNum >= #var_0_0:getLandInfos(self.m_type) then
				g.core.module.ModuleManager:tip(g.core.lang:get(105015))
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(105016))
			end
		end

		self._startPosX = nil
	end
end

function WarriorsMainComp:_isCompleteLand(arg_17_1)
	local var_17_0 = #var_0_0:getActChaptersByLand(self.m_type, arg_17_1)
	local var_17_1 = #var_0_0:getChaptersByLand(self.m_type, arg_17_1)

	return var_17_1 <= var_17_0, var_17_0 / var_17_1, var_17_0, var_17_1
end

function WarriorsMainComp:_onScrollInfo()
	if not self._visible then
		return
	end

	self:updateComp({
		isSlide = false
	})
	self:dispatchCompEvent("WarriorsComp_Arrow", {
		landIndex = self:_getMinDisChapterID(),
		landNum = var_0_0:getActLandNum(self.m_type)
	})
end

function WarriorsMainComp:_getMinDisChapterID()
	return (math.floor(self.m_pageListPane:getPercX() / (1 / (self.m_pageList:getNumItems() - 1)) + 0.5))
end

function WarriorsMainComp:_initPageList()
	self._pageNum = var_0_0:getActLandNum(self.m_type) or 0

	self.m_pageList:setNumItems(self._pageNum)
end

function WarriorsMainComp:_scrollToNextLand(arg_21_1)
	local var_21_0 = true

	if arg_21_1 then
		var_21_0 = arg_21_1.isSlide
	end

	local var_21_1 = self:_getCurrentLandIndex()

	if var_21_0 then
		if var_21_1 <= self._pageNum then
			self._isInToNextChapter = true

			self:runFGAction((fgui.FSequence:create({
				fgui.FCallFunc:create(handler(self, function()
					if self._isFirstEnter then
						self.m_pageList:scrollToView(var_21_1 - 1, false)

						self._isFirstEnter = false
					else
						self:onClickRightArrow()
					end

					self:_setLandMap(var_21_1)
				end)),
				fgui.FCallFunc:create(handler(self, function()
					self._isInToNextChapter = false
				end))
			})))
		end
	else
		if self._isFirstEnter then
			self.m_pageList:scrollToView(var_21_1 - 1, false)

			self._isFirstEnter = false
		else
			self:onClickRightArrow()
		end

		self:_setLandMap(var_21_1)
	end
end

function WarriorsMainComp:selectLand(arg_24_1, arg_24_2)
	self:_setLandMap(arg_24_1 + 1)

	local var_24_0 = self.m_pageList:getChildAt(0)
	local var_24_1

	if arg_24_1 < arg_24_2 then
		var_24_0:playSwitchTransition("right", true)
		self:newScheduleOnce(function()
			self.m_pageList:scrollToView(arg_24_1)
			self.m_pageList:getChildAt(0):playSwitchTransition("left")
		end, WarriorsConst.delayTimeToSwitchTransition)
	else
		var_24_0:playSwitchTransition("left", true)
		self:newScheduleOnce(function()
			self.m_pageList:scrollToView(arg_24_1)
			self.m_pageList:getChildAt(0):playSwitchTransition("right")
		end, WarriorsConst.delayTimeToSwitchTransition)

		var_24_1 = {
			landIndex = arg_24_1 + 1
		}
	end

	var_24_1.landNum = var_0_0:getActLandNum(self.m_type)

	self:dispatchCompEvent("WarriorsComp_Arrow", var_24_1)
end

function WarriorsMainComp:getCurrentPageId()
	return self:_getMinDisChapterID() + 1
end

function WarriorsMainComp:_updateProgress()
	local var_28_0, var_28_1, var_28_2 = var_0_0:getCurrentActStage(self.m_type)

	self:dispatchCompEvent("WarriorsComp_Progress", {
		type = self.m_type,
		stageId = var_28_2,
		actChapterNum = var_28_0,
		chapterNum = var_28_1
	})
end

function WarriorsMainComp:onClickLeftArrow()
	if self._isInToNextChapter then
		return
	end

	local var_29_0 = self.m_pageController:getSelectedIndex()

	self:dispatchCompEvent("WarriorsComp_Arrow", {
		landIndex = var_29_0 - 1,
		landNum = var_0_0:getActLandNum(self.m_type)
	})

	if var_29_0 > 0 then
		self.m_bg_leftTransition:play()
		self.m_pageList:getChildAt(0):playSwitchTransition("right", true)
		self:newScheduleOnce(function()
			self.m_pageList:scrollToView(var_29_0 - 1, false)

			local var_30_0 = self.m_pageList:getChildAt(0)

			if var_30_0 then
				var_30_0:playSwitchTransition("left")
			end

			self:_setLandMap(var_29_0)
		end, WarriorsConst.delayTimeToSwitchTransition)
	end
end

function WarriorsMainComp:onClickRightArrow()
	if self._isInToNextChapter then
		return
	end

	local var_31_0 = self.m_pageController:getSelectedIndex()

	if self._pageNum and var_31_0 + 1 < self._pageNum then
		self:dispatchCompEvent("WarriorsComp_Arrow", {
			landIndex = var_31_0 + 1,
			landNum = var_0_0:getActLandNum(self.m_type)
		})
		self.m_bg_rightTransition:play()
		self.m_pageList:getChildAt(0):playSwitchTransition("left", true)
		self:newScheduleOnce(function()
			self.m_pageList:scrollToView(var_31_0 + 1, false)

			local var_32_0 = self.m_pageList:getChildAt(0)

			if var_32_0 then
				var_32_0:playSwitchTransition("right")
			end

			self:_setLandMap(var_31_0 + 2)
		end, WarriorsConst.delayTimeToSwitchTransition)
	end
end

function WarriorsMainComp:_setLandMap(arg_33_1)
	self:dispatchCompEvent("WarriorsComp_Map", {
		event = "SET_ONFOCUS",
		landIndex = arg_33_1 - 1
	})

	self._lastLandIndex = arg_33_1
end

return WarriorsMainComp
