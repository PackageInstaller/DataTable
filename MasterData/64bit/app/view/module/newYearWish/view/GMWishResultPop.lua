local var_0_0 = require("app.view.module.newYearWish.const.NewYearWishConst").ResultPopType
local var_0_1 = g.core.model.User.newYearWishData
local NewYearWishConst = require("app.view.module.newYearWish.const.NewYearWishConst")
local var_0_3 = g.core.common.Path
local GMWishResultPop = class("GMWishResultPop", require("app.fairyGUI.newYearWish.UI_GMWishResultPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/newYearWish/newYearWish",
		resName = "GMWishResultPop",
		pkgName = "newYearWish",
		isFullScreen = true
	}, ...)
end)

function GMWishResultPop:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.endcall then
		self._closeCallBack = arg_2_1.endcall
	end

	self.m_unsignBtn:addClickListener(handler(self, self._onClickBtn))
	self.m_viewTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowViewChanged))
	self.m_shareBtnComp:setCallback(handler(self, self._onShareClick))
	self.m_shareBtnComp:setShowAwardState(0)
	self.m_touchArea:setSize(display.width, display.height)
	self.m_touchArea:addClickListener(handler(self, self._onClickClose))
	self:_initView()
end

function GMWishResultPop:_initView()
	local var_3_0 = var_0_1:getResId()
	local var_3_1 = var_0_3:getGMWishResultPopRes(var_3_0) .. NewYearWishConst.GM_COLOR_TYPE[var_3_0]

	for iter_3_0 = 1, 4 do
		self["m_decoration" .. iter_3_0]:setURL(var_3_1 .. NewYearWishConst.GM_RES_NAME.DECORATION .. iter_3_0 .. ".png")
	end

	self.m_ribbon:setURL(var_3_1 .. NewYearWishConst.GM_RES_NAME.RIBBON .. "2.png")
end

function GMWishResultPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, self._recvChargeInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_YEAR_WISH_AWARD, self._recvGetReward, self)

	if var_0_1:hasAwardCanGet() then
		g.core.network.GameNetProxy:send_C2S_NewYearWish_Award({})
	else
		self.m_viewComp:updateView()
	end

	self.m_enterTransition:play()
end

function GMWishResultPop:_onShowViewChanged()
	self.m_viewComp:updateView()
end

function GMWishResultPop:_onClickBtn()
	if self.m_viewTypeController:getSelectedIndex() == var_0_0.AWARD then
		self.m_viewTypeController:setSelectedIndex(var_0_0.UNSIGN)
		self.m_unsignBtn:refreshTitleRes()
	else
		self.m_viewTypeController:setSelectedIndex(var_0_0.AWARD)
		self.m_unsignBtn:refreshTitleRes()
	end
end

function GMWishResultPop:_onShareClick()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	self.m_viewTypeController:setSelectedIndex(var_0_0.SHARE)

	self._bg = self._bg or self:addBg((var_0_1:getShareBgPath()))

	self._bg:setVisible(true)

	local var_7_0 = cc.utils:captureNode(self)

	var_7_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_7_0:release()
	self._bg:setVisible(false)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_ACTIVITY_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_ACTIVITY_TYPE.SHARE_NEW_YEAR_WISH
	})
	self.m_viewTypeController:setSelectedIndex(var_0_0.UNSIGN)
end

function GMWishResultPop:_onCrossDay()
	self:_onClickClose()
end

function GMWishResultPop:_recvChargeInfo(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.gift then
		g.core.module.ModuleManager:awardSummary(arg_9_3.gift.awards or {})
		self.m_viewComp:updateView()
	end
end

function GMWishResultPop:_recvGetReward(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_10_3.awards, false)
	end

	self.m_viewComp:updateView()
end

function GMWishResultPop:_onClickClose()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self.onCloseAnimPlayEnd))
end

function GMWishResultPop:onCloseAnimPlayEnd()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	self:homeLayerAutoPopup()
end

function GMWishResultPop:uniqueStyleOutTrans(arg_13_1)
	self.m_backTransition:play(arg_13_1)
end

function GMWishResultPop:homeLayerAutoPopup()
	if self._closeCallBack then
		self._closeCallBack()

		self._closeCallBack = nil
	end
end

return GMWishResultPop
