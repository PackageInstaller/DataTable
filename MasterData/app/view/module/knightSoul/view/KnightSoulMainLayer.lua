local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.model.User.knightSoulData
local var_0_4 = g.core.const.ConstMgr.KnightSoulConst
local var_0_5 = g.core.config.ksoul_book_chapter_info
local KnightSoulMainLayer = class("KnightSoulMainLayer", require("app.fairyGUI.knightSoul.UI_KnightSoulMainLayer"), function()
	return fgui.GComponent:create({
		resName = "KnightSoulMainLayer",
		pkgPath = "ui/knightSoul/knightSoul",
		isFullScreen = true,
		pkgName = "knightSoul"
	}, ...)
end)

function KnightSoulMainLayer:ctor()
	self._chapterIdList = var_0_3:getChapterIdList()
	self._chapterNum = var_0_3:getChapterNum()

	self:_initListener()
	self:_initView()
	self.m_chapterList:setVirtual()
	self.m_chapterList:setItemRenderer(handler(self, self._onRenderChapterComp))
	self.m_chapterList:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_SOUL)
end

function KnightSoulMainLayer:_initListener()
	self.m_allAttrBtn:addClickListener(handler(self, self._onClickAllAttrBtn))
	self.m_honorRankBtn:addClickListener(handler(self, self._onClickHonorRankBtn))
	self.m_recruitBtn:addClickListener(handler(self, self._onClickRecruitBtn))
	self.m_bagBtn:addClickListener(handler(self, self._onClickBagBtn))
	self.m_rightBtn:addClickListener(handler(self, self._onClickRightBtn))
	self.m_leftBtn:addClickListener(handler(self, self._onClickLeftBtn))
	self.m_honorComp:addClickListener(handler(self, self._onClickHonorComp))
end

function KnightSoulMainLayer:_initView()
	self:addBg("bg/knightSoul/bg_mingxing_main1.jpg")
	self.m_topBarComp:setResInfoById(var_0_4.TOP_BAR_ID)
end

function KnightSoulMainLayer:_updateView()
	self.m_honorComp:updateHonorComp()
	self.m_chapterList:setNumItems(self._chapterNum)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_honorComp
	})
	self.m_chapterList:transitionShowCells("listCardAUiScaleIn", 0.03)
end

function KnightSoulMainLayer:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_K_SOUL_INFO, self._onS2CKsoulInfo, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_K_SOUL_HONORADVANCE, self._onS2CActivateHonor, self)
	g.core.network.GameNetProxy:send_C2S_KSoul_Info({})
	self.m_enterTransition:play()
end

function KnightSoulMainLayer:_onRenderChapterComp(arg_7_1, arg_7_2)
	arg_7_2:updateChapterComp({
		cfg = var_0_5.fetch(self._chapterIdList[arg_7_1 + 1])
	})
end

function KnightSoulMainLayer:_onClickAllAttrBtn()
	var_0_2:pushPopup(require("app.view.module.knightSoul.view.KnightSoulAllAttributePop").new(), {
		touchDisappear = true
	})
end

function KnightSoulMainLayer:_onClickHonorRankBtn()
	var_0_2:pushModule(g.view.entrance.KNIGHT_SOUL_RANK_LAYER)
end

function KnightSoulMainLayer:_onClickRecruitBtn()
	var_0_2:pushModule(g.view.entrance.RECRUIT, {
		route1 = g.core.const.ConstMgr.RecruitConst.RECRUIT_ROUTE_TYPE.ROUTE_TYPE_RECRUIT_TYPE,
		route2 = g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT
	})
end

function KnightSoulMainLayer:_onClickBagBtn()
	var_0_2:pushModule(g.view.entrance.KNIGHT_SOUL_BAG_LAYER)
end

function KnightSoulMainLayer:_onClickLeftBtn()
	self.m_chapterList:scrollToView(0, true)

	self._scrollListenerEnable = true
end

function KnightSoulMainLayer:_onClickRightBtn()
	self.m_chapterList:scrollToView(self._chapterNum - 1, true)

	self._scrollListenerEnable = true
end

function KnightSoulMainLayer:_onClickHonorComp()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.knightSoul.view.KnightSoulAchievementPop").new(), {
		touchDisappear = true
	})
end

function KnightSoulMainLayer:_onListScroll()
	local var_15_0 = self.m_chapterList:numChildren()
	local var_15_1 = true

	if self.m_chapterList:childIndexToItemIndex(0) == 0 and var_15_0 > 0 then
		local var_15_2 = self.m_chapterList:globalToLocal((self.m_chapterList:getChildAt(0):localToGlobal(cc.p(0, 0))))

		if var_15_2.x + 50 > 0 then
			var_15_1 = false
		elseif var_15_2.x < 50 then
			var_15_1 = true
		end
	end

	self.m_leftBtn:setVisible(var_15_1)

	local var_15_3 = true

	if self.m_chapterList:childIndexToItemIndex(var_15_0 - 1) == self._chapterNum - 1 then
		local var_15_4 = self.m_chapterList:getChildAt(var_15_0 - 1)
		local var_15_5 = self.m_chapterList:globalToLocal((var_15_4:localToGlobal(cc.p(var_15_4:getWidth(), 0))))

		if var_15_5.x < self.m_chapterList:getWidth() + 50 then
			var_15_3 = false
		elseif var_15_5.x > self.m_chapterList:getWidth() - 50 then
			var_15_3 = true
		end
	end

	self.m_rightBtn:setVisible(var_15_3)
end

function KnightSoulMainLayer:_checkRightBtnOnce()
	local var_16_0 = self.m_chapterList:numChildren()
	local var_16_1 = true

	if self.m_chapterList:childIndexToItemIndex(var_16_0 - 1) == self._chapterNum - 1 then
		local var_16_2 = self.m_chapterList:getChildAt(var_16_0 - 1)
		local var_16_3 = self.m_chapterList:globalToLocal((var_16_2:localToGlobal(cc.p(var_16_2:getWidth(), 0))))

		if var_16_3.x < self.m_chapterList:getWidth() + 50 then
			var_16_1 = false
		elseif var_16_3.x > self.m_chapterList:getWidth() - 50 then
			var_16_1 = true
		end
	end

	self.m_rightBtn:setVisible(var_16_1)
end

function KnightSoulMainLayer:_onS2CKsoulInfo()
	self:_updateView()
end

function KnightSoulMainLayer:_onS2CActivateHonor()
	self:_updateView()
end

return KnightSoulMainLayer
