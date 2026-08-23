local var_0_0 = g.core.model.User.knightSoulData
local var_0_1 = g.core.const.ConstMgr.KnightSoulConst
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.module.ModuleManager
local KnightSoulBookLayer = class("KnightSoulBookLayer", require("app.fairyGUI.knightSoul.UI_KnightSoulBookLayer"), function()
	return fgui.GComponent:create({
		resName = "KnightSoulBookLayer",
		pkgName = "knightSoul",
		isFullScreen = true,
		pkgPath = "ui/knightSoul/knightSoul"
	}, ...)
end)

function KnightSoulBookLayer:ctor(arg_2_1)
	self._chapterId = arg_2_1.chapterId
	self._attrList = {}
	self._curSelectedAttr = var_0_1.SEARCH_TYPE.ALL
	self._curBookIndex = 1
	self._showBookList = {}
	self._bookStruct = nil
	self._bookStatus = var_0_1.BOOK_STATUS.ACTIVATE_UNABLE

	self:_initListener()
	self:_initView()
end

function KnightSoulBookLayer:_initListener()
	self.m_honorBtn:addClickListener(handler(self, self._onClickHonorBtn))
	self.m_recruitBtn:addClickListener(handler(self, self._onClickRecruitBtn))
	self.m_bagBtn:addClickListener(handler(self, self._onClickBagBtn))
	self.m_touchComp:addClickListener(handler(self, self._onClickTouchComp))
	self.m_activateBtn:addClickListener(handler(self, self._onClickActivateBtn))
	self.m_recycleBtn:addClickListener(handler(self, self._onClickRecycleBtn))
	self.m_quickSelBtn:addClickListener(handler(self, self._onClickQuickSelBtn))
	self:addListen(self.m_bookComp)
	self:addListen(self.m_selectComp)
end

function KnightSoulBookLayer:_initView()
	self:addBg("bg/knightSoul/bg_mingxing_main1.jpg")

	self._attrList = var_0_0:getBookAllAttrListByChapterId(self._chapterId)

	self.m_selectComp:updateSelectComp(self._attrList, self._curSelectedAttr)
	self:_setScreenStatus(false)
	self.m_topBarComp:setResInfoById(var_0_1.TOP_BAR_ID)
end

function KnightSoulBookLayer:_updateComp()
	self._showBookList = var_0_0:getBookListByChapterIdAndAttrType(self._chapterId, self._curSelectedAttr)

	var_0_0:sortBookList(self._showBookList)

	if self._bookStruct then
		self._curBookIndex = self:_getBookIndexByBookId(self._bookStruct:getId())
	end

	self._bookStruct = self._showBookList[self._curBookIndex]
	self._bookStatus = self._bookStruct:getStatusIndex()

	self.m_bookComp:updateBookComp(self._showBookList, self._curBookIndex)
	self.m_bookComp:scrollTo(self._curBookIndex)
	self.m_detailComp:updateDetailComp(self._bookStruct)
	self.m_cardListComp:updateKnightCard(self._bookStruct, self._bookStatus)
	self:_updateBtnView()
end

function KnightSoulBookLayer:_updateBtnView()
	self.m_isMaxStarController:setSelectedIndex(0)

	local var_6_0 = not self._bookStruct:isActivate() or self._bookStruct:getStarNum() > 0 or self._bookStruct:isOpenStarUp()

	self.m_activateBtn:setVisible(var_6_0)
	self.m_hasStarController:setSelectedIndex(var_6_0 and 1 or 0)

	if self._bookStatus == var_0_1.BOOK_STATUS.ACTIVATE_UNABLE then
		self.m_activateBtn:setTitle(g.core.lang:get(410602))
	elseif self._bookStatus == var_0_1.BOOK_STATUS.ACTIVATE_ABLE then
		self.m_activateBtn:setTitle(g.core.lang:get(410602))
	elseif self._bookStatus == var_0_1.BOOK_STATUS.NOT_MAX_STAR then
		self.m_activateBtn:setTitle(g.core.lang:get(410603))
	elseif self._bookStatus == var_0_1.BOOK_STATUS.STAR_UP_ABLE then
		self.m_activateBtn:setTitle(g.core.lang:get(410603))
	elseif self._bookStatus == var_0_1.BOOK_STATUS.MAX_STAR then
		self.m_isMaxStarController:setSelectedIndex(1)
	end

	local var_6_1 = self.m_activateBtn:getChild("redPointComp")

	var_6_1:setId(721)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = var_6_1,
		customData = {
			bookStruct = self._bookStruct
		}
	})
	self.m_recycleBtn:setVisible(self._bookStruct:isActivate() and self._bookStruct:getStarNum() > 0)
	self:_updateQuickSelBtn()
end

function KnightSoulBookLayer:_setScreenStatus(arg_7_1)
	self.m_selectComp:setVisible(arg_7_1)
	self.m_touchComp:setVisible(arg_7_1)
end

function KnightSoulBookLayer:_onClickHonorBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.knightSoul.view.KnightSoulAchievementPop").new(), {
		touchDisappear = true
	})
end

function KnightSoulBookLayer:_onClickRecruitBtn()
	local var_9_0 = g.core.config.source_route_info.get(g.core.config.ksoul_book_chapter_info.get(self._chapterId).route)

	var_0_4:pushModule(g.view.entrance.RECRUIT, {
		route1 = var_9_0.route_value_1,
		route2 = var_9_0.route_value_2
	})
end

function KnightSoulBookLayer:_onClickBagBtn()
	var_0_4:pushModule(g.view.entrance.KNIGHT_SOUL_BAG_LAYER)
end

function KnightSoulBookLayer:_onClickTouchComp()
	self:_setScreenStatus(false)
	self.m_bookComp:resetSearchBtn()
end

function KnightSoulBookLayer:_onClickActivateBtn()
	if not self._bookStruct then
		return
	end

	if self._bookStatus == var_0_1.BOOK_STATUS.ACTIVATE_UNABLE then
		var_0_4:tip(g.core.lang:get(410608))
	elseif self._bookStatus == var_0_1.BOOK_STATUS.MAX_STAR then
		var_0_4:tip(g.core.lang:get(410612))
	elseif self._bookStatus == var_0_1.BOOK_STATUS.ACTIVATE_ABLE then
		self.m_activateBtn:setTouchable(false)
		g.core.network.GameNetProxy:send_C2S_KSoul_BookActivate({
			book_id = self._bookStruct:getId(),
			chapter_id = self._chapterId
		})
		self.m_cardListComp:playActivateAnim(handler(self, self._onActivateAnimEnd))
	else
		local var_12_0 = require("app.view.module.knightSoul.view.KnightSoulUpPop").new

		var_0_4:pushPopup((require("app.view.module.knightSoul.view.KnightSoulUpPop").new({
			bookStruct = self._bookStruct,
			bookStatus = self._bookStatus
		})))
	end
end

function KnightSoulBookLayer:_onClickRecycleBtn()
	var_0_4:pushPopup((require("app.view.module.knightSoul.view.KnightSoulUnloadPop").new({
		bookStruct = self._bookStruct
	})))
end

function KnightSoulBookLayer:_onClickQuickSelBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.knightSoul.view.KnightSoulQuickSelPop").new({
		ksIdList = self._bookStruct:getNextNeedBagHaveKSoulIdList(true)
	}), {
		touchDisappear = true
	})
end

function KnightSoulBookLayer:_updateQuickSelBtn()
	self.m_isShowQuickSelController:setSelectedIndex(self.m_activateBtn:isVisible() and (self._bookStatus == var_0_1.BOOK_STATUS.ACTIVATE_UNABLE or self._bookStatus == var_0_1.BOOK_STATUS.NOT_MAX_STAR) and #self._bookStruct:getNextNeedBagHaveKSoulIdList() > 0 and 1 or 0)
end

function KnightSoulBookLayer:_getBookIndexByBookId(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(self._showBookList) do
		if iter_16_1:getId() == arg_16_1 then
			return iter_16_0
		end
	end

	return 1
end

function KnightSoulBookLayer:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_K_SOUL_CHAPTERINFO, handler(self, self._onS2CChapterInfo), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_K_SOUL_BOOKACTIVATE, handler(self, self._onS2CBookActivate), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_K_SOUL_BOOKUPGRADE, handler(self, self._onS2CBookUpgrade), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_REBORN_EXECUTE, self._onReceiveRebornExecute, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_ITEM_USE, self._onItemUseRecv, self)
	g.core.network.GameNetProxy:send_C2S_KSoul_ChapterInfo({
		chapter_id = self._chapterId
	})
	self:_updateComp()
	self.m_enterTransition:play()
end

function KnightSoulBookLayer:_onS2CChapterInfo()
	if not tolua.isnull(self) and self._updateComp then
		self:_updateComp()
	end
end

function KnightSoulBookLayer:_onS2CBookActivate(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if not arg_19_4 then
		return
	end

	self._actContent = arg_19_4
end

function KnightSoulBookLayer:_onS2CBookUpgrade(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if not arg_20_4 then
		return
	end

	self.m_cardListComp:playActivateAnim()
	self:_onStarUpSuccess(arg_20_4)
end

function KnightSoulBookLayer:_onActivateAnimEnd()
	self:_onActivateSuccess()
	self.m_activateBtn:setTouchable(true)
end

function KnightSoulBookLayer:_onActivateSuccess()
	local var_22_0

	if not self._actContent then
		do return end

		var_22_0 = {
			autoDisappear = false,
			popType = 0
		}
	end

	var_22_0.bookStruct = var_0_0:getBookById(self._actContent.book_id)
	var_22_0.title = g.core.lang:get(410611)
	var_22_0.showComp = fgui.UIPackage:createObject("knightSoul", "KnightSoulActivateSuccessComp")
	var_22_0.func = handler(self, self._updateWithOutList)

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new(var_22_0), {
		ignoreTouch = true,
		blackOpacity = 0.7,
		withoutAni = true,
		touchDisappear = false
	})
end

function KnightSoulBookLayer:_updateWithOutList()
	self._bookStatus = self._bookStruct:getStatusIndex()

	self.m_bookComp:updateBookComp(self._showBookList, self._curBookIndex)
	self.m_detailComp:updateDetailComp(self._bookStruct)
	self.m_cardListComp:updateKnightCard(self._bookStruct, self._bookStatus)
	self:_updateBtnView()
end

function KnightSoulBookLayer:_onStarUpSuccess(arg_24_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		autoDisappear = false,
		popType = 1,
		bookStruct = self._bookStruct,
		title = g.core.lang:get(410619),
		func = handler(self, self._updateWithOutList),
		showComp = fgui.UIPackage:createObject("knightSoul", "KnightSoulActivateSuccessComp")
	}), {
		ignoreTouch = true,
		blackOpacity = 0.7,
		withoutAni = true,
		touchDisappear = false
	})
end

function KnightSoulBookLayer:_onReceiveRebornExecute(arg_25_1, arg_25_2, arg_25_3)
	var_0_4:awardSummary(arg_25_3.awards, false, nil, g.core.lang:get(103004))
	self:_updateComp()
end

function KnightSoulBookLayer:_onItemUseRecv(arg_26_1, arg_26_2, arg_26_3)
	self:_updateComp()
end

function KnightSoulBookLayer:receiveCompEvent(arg_27_1, arg_27_2)
	if arg_27_1 == "show_attr_list" then
		self.m_panelInTransition:play()
		self:_setScreenStatus(true)
	elseif arg_27_1 == "change_selected_struct" then
		self._bookStruct = arg_27_2.struct
		self._curBookIndex = arg_27_2.index
		self._bookStatus = self._bookStruct:getStatusIndex()

		self:_updateBtnView()
		self.m_detailComp:updateDetailComp(arg_27_2.struct)
		self.m_cardListComp:updateKnightCard(arg_27_2.struct, self._bookStatus)
		self.m_switchTransition:play()
		self.m_cardListComp:playSwitchAnim(#self._bookStruct:getNeedKnightSoulList())
	elseif arg_27_1 == "select_attr_finish" then
		self._curBookIndex = 1
		self._curSelectedAttr = arg_27_2.attrType

		self:_updateComp()
	elseif arg_27_1 == "reset_screen_status" then
		self:_setScreenStatus(false)
	end
end

return KnightSoulBookLayer
