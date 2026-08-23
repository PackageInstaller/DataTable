local var_0_0 = g.core.config.red_point_style_info
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = 0.03
local var_0_3 = g.core.model.User.CampaignData
local var_0_4 = g.core.common.Scheduler
local CampaignLayer = class("CampaignLayer", require("app.fairyGUI.campaign.UI_CampaignLayer"), function()
	return fgui.GComponent:create({
		resName = "CampaignLayer",
		pkgName = "campaign",
		isFullScreen = true,
		pkgPath = "ui/campaign/campaign"
	}, ...)
end)

function CampaignLayer:ctor(arg_2_1)
	self._scrollListenerEnable = false
	self._firstCloseModuleTime = -1
	self._init = false
	self._downTimeScheduler = nil
	self._updateArrowRedPointTimer = nil
	self._entranceStructArr = {}

	self:addBg("bg/common/pic_yht_beijing.jpg", false)
	self.m_topBarComp:setResInfoById(59)
	self:_initListView()
	self.m_leftArrowBtn:addClickListener(handler(self, self._onClickLeftArrowBtn))
	self.m_rightArrowBtn:addClickListener(handler(self, self._onClickRightArrowBtn))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	var_0_4:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
end

function CampaignLayer:_initListView()
	local var_4_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_4_1 = self.m_scrollList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_4_0.x > 0 then
		var_4_1 = var_4_1 - var_4_0.x * 2
	end

	self.m_scrollList:setWidth(var_4_1)
	self.m_scrollList:setVirtual()
	self.m_scrollList:doFairyBatching(false)
	self.m_scrollList:setItemRendererAsync1(handler(self, self._onListRenderer), 0.02, false)
	self.m_scrollList:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onScroll))
	self.m_scrollList:addEventListener(fgui.UIEventType.ScrollEnd, handler(self, self._onScrollEnd))
	self.m_scrollList:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function CampaignLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_NOTICEACTIVITY, self._updateView, self)
	g.core.sound.SoundManager:playMusic(var_0_1.SoundConst.BGM.MUSIC_MAIN_MENU)
	self:_updateView()

	self._firstCloseModuleTime = var_0_3:getFirstCloseTime()

	if self._firstCloseModuleTime ~= -1 then
		self._downTimeScheduler = self:newSchedule(handler(self, self._onSecSchedule), 1)

		self:_onSecSchedule()
	end
end

function CampaignLayer:_onCrossDay()
	if self._downTimeScheduler then
		self:cancelSchedule(self._downTimeScheduler)

		self._downTimeScheduler = nil
	end

	self._firstCloseModuleTime = var_0_3:getFirstCloseTime()

	if self._firstCloseModuleTime ~= -1 then
		self._downTimeScheduler = self:newSchedule(handler(self, self._onSecSchedule), 1)

		self:_onSecSchedule()
	end
end

function CampaignLayer:_onSecSchedule()
	if g.core.common.ServerTime:getTime() > self._firstCloseModuleTime then
		self._entranceStructArr = var_0_3:getShowEntranceStructArr()

		self.m_scrollList:setNumItems(#self._entranceStructArr)
		self:_updateArrowRedPoint()

		self._firstCloseModuleTime = var_0_3:getFirstCloseTime()

		if self._firstCloseModuleTime == -1 and self._downTimeScheduler then
			self:cancelSchedule(self._downTimeScheduler)

			self._downTimeScheduler = nil
		end
	else
		for iter_7_0, iter_7_1 in pairs((self.m_scrollList:getChildren())) do
			if iter_7_1.updateCDTxt then
				iter_7_1:updateCDTxt()
			end
		end
	end
end

function CampaignLayer:_updateView()
	self._entranceStructArr = var_0_3:getShowEntranceStructArr()

	self.m_scrollList:setNumItems(#self._entranceStructArr)

	if not self._init then
		self._init = true

		local var_8_0 = var_0_3:getNewestPlay()

		if g.core.guide.GuideProxy:isGuideRunning() then
			local var_8_1 = g.core.guide.GuideProxy:getNextListTargetItemIndex()

			if var_8_1 then
				var_8_0 = var_8_1
			end
		end

		if var_8_0 > 0 then
			self.m_scrollList:scrollToView(var_8_0 - 1)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
			var_0_4:newScheduleOnce(function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
			end, 0.5)
		else
			self.m_scrollList:scrollToView(0)
		end
	end

	self.m_scrollList:transitionShowCells("listCardAUiLeftIn", var_0_2, 1)

	self._updateArrowRedPointTimer = self:newScheduleOnce(handler(self, self._updateArrowRedPoint), var_0_2 * #self._entranceStructArr)
end

function CampaignLayer:_onListRenderer(arg_10_1, arg_10_2)
	arg_10_2:updateInfo(self._entranceStructArr[arg_10_1 + 1])
end

function CampaignLayer:_onScroll()
	if self._scrollListenerEnable then
		self:_updateArrowRedPoint()

		self._scrollListenerEnable = false
	end
end

function CampaignLayer:_onScrollEnd()
	self:_updateArrowRedPoint()
end

function CampaignLayer:_onTouchEnd()
	self:_updateArrowRedPoint()
end

function CampaignLayer:_onClickLeftArrowBtn()
	self.m_scrollList:scrollToView(0, true)

	self._scrollListenerEnable = true
end

function CampaignLayer:_onClickRightArrowBtn()
	self.m_scrollList:scrollToView(#self._entranceStructArr - 1, true)

	self._scrollListenerEnable = true
end

function CampaignLayer:onUnload()
	if self._downTimeScheduler then
		self:cancelSchedule(self._downTimeScheduler)

		self._downTimeScheduler = nil
	end

	if self._updateArrowRedPointTimer then
		self:cancelSchedule(self._updateArrowRedPointTimer)

		self._updateArrowRedPointTimer = nil
	end
end

function CampaignLayer:_getVisibleMinMaxItemLuaIdx()
	local var_17_0 = self.m_scrollList:localToGlobal(cc.p(0, 0)).x
	local var_17_1 = var_17_0 + self.m_scrollList:getWidth() + 20
	local var_17_2 = self.m_scrollList:numChildren() - 1

	for iter_17_0 = 0, var_17_2 do
		local var_17_3 = self.m_scrollList:getChildAt(iter_17_0)
		local var_17_4 = var_17_3:localToGlobal(cc.p(var_17_3:getWidth(), 0))

		if var_17_0 + 20 >= var_17_4.x then
			var_17_2 = math.max(iter_17_0 + 1, var_17_2)
		end

		if var_17_1 <= var_17_4.x then
			var_17_2 = math.min(iter_17_0 - 1, var_17_2)
		end
	end

	local var_17_5 = self.m_scrollList:childIndexToItemIndex(0) + 1
	local var_17_6 = self.m_scrollList:childIndexToItemIndex(var_17_2) + 1

	if var_17_6 <= var_17_5 then
		var_17_5 = 1
		var_17_6 = #self._entranceStructArr
	end

	return var_17_5, var_17_6
end

function CampaignLayer:_updateArrowRedPoint()
	local var_18_0, var_18_1 = self:_getVisibleMinMaxItemLuaIdx()

	if var_18_0 == 1 then
		self.m_leftArrowBtn:setVisible(false)
	else
		self.m_leftArrowBtn:setVisible(true)
		self.m_leftArrowBtn:setRedPointStyle((self:_getFuncEntranceShowRedPointStyle(1, var_18_0 - 1)))
	end

	if var_18_1 == #self._entranceStructArr then
		self.m_rightArrowBtn:setVisible(false)
	else
		self.m_rightArrowBtn:setVisible(true)
		self.m_rightArrowBtn:setRedPointStyle((self:_getFuncEntranceShowRedPointStyle(var_18_1 + 1, #self._entranceStructArr)))
	end
end

function CampaignLayer:_getFuncEntranceShowRedPointStyle(arg_19_1, arg_19_2)
	local var_19_0 = {}

	for iter_19_0 = arg_19_1, arg_19_2 do
		local var_19_1, var_19_2 = var_0_3:isFuncEntranceShowRedPoint(self._entranceStructArr[iter_19_0].functionId)

		if var_19_1 then
			table.insert(var_19_0, {
				show = var_19_1,
				style = var_19_2
			})
		end
	end

	if #var_19_0 > 1 then
		table.sort(var_19_0, function(arg_20_0, arg_20_1)
			return var_0_0.get(arg_20_0.style).sort_weight > var_0_0.get(arg_20_1.style).sort_weight
		end)
	end

	return (var_19_0[1] or {}).style or var_0_1.RedPointConst.STYLE.NONE
end

return CampaignLayer
