local var_0_0 = require("app.view.module.newYearWish.const.NewYearWishConst").ResultPopType
local var_0_1 = g.core.model.User.newYearWishData
local WishResultPop = class("WishResultPop", require("app.fairyGUI.newYearWish.UI_WishResultPop_1"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/newYearWish/newYearWish",
		pkgName = "newYearWish",
		isFullScreen = true,
		resName = var_0_1:getWishResultPopResName()
	}, ...)
end)

function WishResultPop:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.endcall then
		self._closeCallBack = arg_2_1.endcall
	end

	self.m_unsignBtn:addClickListener(handler(self, self._onClickBtn))
	self.m_viewTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowViewChanged))
	self.m_shareBtnComp:setCallback(handler(self, self._onShareClick))
	self.m_shareBtnComp:setShowAwardState(0)
end

function WishResultPop:onLoad()
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

function WishResultPop:_onShowViewChanged()
	self.m_viewComp:updateView()
end

function WishResultPop:_onClickBtn()
	if self.m_viewTypeController:getSelectedIndex() == var_0_0.AWARD then
		self.m_viewTypeController:setSelectedIndex(var_0_0.UNSIGN)
	else
		self.m_viewTypeController:setSelectedIndex(var_0_0.AWARD)
	end
end

function WishResultPop:_onShareClick()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	self.m_viewTypeController:setSelectedIndex(var_0_0.SHARE)

	self._bg = self._bg or self:addBg((var_0_1:getShareBgPath()))

	self._bg:setVisible(true)

	local var_6_0 = cc.utils:captureNode(self)

	var_6_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_6_0:release()
	self._bg:setVisible(false)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_ACTIVITY_LAYER, {
		shareType = var_0_1:getShareType()
	})
	self.m_viewTypeController:setSelectedIndex(var_0_0.UNSIGN)
end

function WishResultPop:_onCrossDay()
	self:_onClickClose()
end

function WishResultPop:_recvChargeInfo(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3.gift then
		g.core.module.ModuleManager:awardSummary(arg_8_3.gift.awards or {})
		self.m_viewComp:updateView()
	end
end

function WishResultPop:_recvGetReward(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_9_3.awards, false)
	end

	self.m_viewComp:updateView()
end

function WishResultPop:_onClickClose()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self.onCloseAnimPlayEnd))
end

function WishResultPop:onCloseAnimPlayEnd()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function WishResultPop:uniqueStyleOutTrans(arg_12_1)
	self.m_backTransition:play(arg_12_1)
end

function WishResultPop:homeLayerAutoPopup()
	if self._closeCallBack then
		self._closeCallBack()

		self._closeCallBack = nil
	end
end

return WishResultPop
