local var_0_0 = g.core.model.User.releaseActivityData
local var_0_1 = g.core.const.ConstMgr.ReleaseActivityConst
local ReleaseActivityMainLayer = class("ReleaseActivityMainLayer", require("app.fairyGUI.release.UI_ReleaseActivityMainLayer"), function()
	return fgui.GComponent:create({
		resName = "ReleaseActivityMainLayer",
		pkgPath = "ui/release/release",
		isFullScreen = true,
		pkgName = "release"
	}, ...)
end)

function ReleaseActivityMainLayer:ctor()
	self:addBg("bg/releaseActivity/bg_wxmy_zhujiemianbg.jpg")

	self._isFirstEnter = true

	self:_initListener()
	self:_initMainView()
end

function ReleaseActivityMainLayer:_initListener()
	self.m_taskBtn:addClickListener(handler(self, self._onClickTaskBtn))
	self.m_giftBtn:addClickListener(handler(self, self._onClickGiftBtn))
	self.m_recordBtn:addClickListener(handler(self, self._onClickRecordBtn))
	self.m_previewComp:addClickListener(handler(self, self._onClickPreviewComp))
	self.m_clickIgnoreMask:addClickListener(handler(self, self._onClickIgnoreMask))
	self.m_clickIgnoreMask:setVisible(false)
end

function ReleaseActivityMainLayer:_initMainView()
	self._releaseInfo = var_0_0:getReleaseInfo()
	self._displayInfo = var_0_0:getActivityReleaseDisplayCfg()

	self.m_topBarComp:setResInfoById(self._displayInfo.interface_main)
	self.m_topBarComp:setTitle(self._releaseInfo.name)
	self.m_giftNameTxt:setText(self._displayInfo.gift_name)
	self.m_knightBtn:updateKnightBtn()
	g.core.model.User.releaseActivityData:saveNewActivityRelease()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.RELEASE_ACTIVITY)
	self.m_giftEff:addEffectSpine({
		isLoop = true,
		name = "eff_ui_release_boxglow"
	})
	self.m_enterTransition:play()
end

function ReleaseActivityMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RELEASE_GETINFO, self._updateMainView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RELEASE_DRAW, self._onS2CReleaseDraw, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RELEASE_GETREWARD, self._onS2CReleaseGetReward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, self._updateCostBtn, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETRECHARGE, self._updateCostBtn, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RELEASE_TASKAWARD, handler(self, self._updateCostBtn), self)
	g.core.network.GameNetProxy:send_C2S_Release_GetInfo({})
end

function ReleaseActivityMainLayer:_updateMainView()
	self.m_activityTime:updateTime()
	self.m_spinnerComp:updatePoolComp()
	self.m_previewComp:updatePreviewComp()
	self.m_accumulateComp:updateAccumulateComp()
	self:_updateCostBtn()

	if self._isFirstEnter then
		self.m_previewComp:playAnim()

		self._isFirstEnter = false
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_giftBtn
	})
end

function ReleaseActivityMainLayer:_onS2CReleaseDraw(arg_7_1, arg_7_2, arg_7_3)
	self.m_clickIgnoreMask:setVisible(true)
	self.m_spinnerComp:playRollEff()

	self._drawSummaryAwars = arg_7_3.awards

	for iter_7_0, iter_7_1 in ipairs(arg_7_3.prize_ids) do
		local var_7_0 = self.m_spinnerComp:getNeedleCompByIndex(iter_7_0)

		if var_7_0 then
			var_7_0:runFGAction((fgui.FSequence:create({
				fgui.FRotateBy:create(var_0_1.ROTATE_ACC_DURATION, 360),
				fgui.FRotateBy:create(var_0_1.ROTATE_UNIFORM_DURATION, 360),
				fgui.FRotateTo:create(var_0_1.ROTATE_DEC_DURATION, var_0_1.WHEEL_TOTAL_ROTATE * 360 + (g.core.config.activity_release_spinner_prize_info.get(iter_7_1).effect - 0.5) * var_0_1.EACH_REWARD_ANGLE - 25),
				fgui.FCallFunc:create(handler(self, function()
					if iter_7_0 ~= #arg_7_3.prize_ids then
						self.m_spinnerComp:playRewardEff(iter_7_1)
					else
						self:_onLotterStop(iter_7_1)
						self:needlePlayEffect(var_7_0, "get_")
					end
				end))
			})))
		end
	end
end

function ReleaseActivityMainLayer:needlePlayEffect(arg_9_1, arg_9_2)
	arg_9_1:getChild("eff"):addEffectSpine({
		name = "eff_ui_release_pointer",
		remove = true,
		isLoop = false,
		anim = arg_9_2 .. g.core.config.activity_release_spinner_info.get((var_0_0:getSpinnerId())).quality
	})
	self.m_spinnerComp:playArrowEff()
end

function ReleaseActivityMainLayer:_onLotterStop(arg_10_1)
	self.m_spinnerComp:playRewardEff(arg_10_1, self._drawSummaryAwars)

	self._drawSummaryAwars = nil

	if not var_0_0:isGetBigAward() then
		self:_updateMainView()
	end
end

function ReleaseActivityMainLayer:receiveCompEvent(arg_11_1)
	if arg_11_1 == "HIDE_SPINNER_NEEDLE" then
		self.m_spinnerComp:hideSpinnerNeedle()
		self.m_clickIgnoreMask:setVisible(false)

		if var_0_0:isGetBigAward() then
			self.m_previewComp:playAnim()
			self.m_enterTransition:play()
			self.m_spinnerComp:updatePoolComp()
			self.m_accumulateComp:updateAccumulateComp()
			self.m_previewComp:updatePreviewComp()
			self:_updateCostBtn()
		end

		local var_11_0 = var_0_0:getReleaseExtraAwards()

		if var_11_0 and next(var_11_0) then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.release.view.ReleaseShowBigRewardPop").new(var_11_0)))
		end
	end
end

function ReleaseActivityMainLayer:_onS2CReleaseGetReward(arg_12_1, arg_12_2, arg_12_3)
	g.core.module.ModuleManager:awardSummary(arg_12_3.awards)
	self:_updateMainView()
end

function ReleaseActivityMainLayer:_onCrossDayUpdate()
	if not var_0_0:isActivityOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	g.core.network.GameNetProxy:send_C2S_Release_GetInfo({})
end

function ReleaseActivityMainLayer:_onClickTaskBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.release.view.ReleaseActivityTaskPop").new()))
end

function ReleaseActivityMainLayer:_onClickGiftBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.shop.view.shopRelease.ShopReleaseGiftPop").new()))
end

function ReleaseActivityMainLayer:_onClickRecordBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.release.view.ReleaseActivityRecordPop").new()))
end

function ReleaseActivityMainLayer:_onClickPreviewComp()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.release.view.ReleaseActivityPreviewPop").new()))
end

function ReleaseActivityMainLayer:_updateCostBtn()
	self.m_drawOnceBtn:updateBtn(var_0_1.DRAW_ONCE)
	self.m_drawMoreBtn:updateBtn(var_0_1.DRAW_MORE)
end

function ReleaseActivityMainLayer:_onClickIgnoreMask()
	g.core.module.ModuleManager:tip(g.core.lang:get(426022))
end

return ReleaseActivityMainLayer
