local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.model.User.pushGiftData
local var_0_2 = g.core.model.User
local var_0_3 = 5
local var_0_4 = 88
local HomePassComp = class("HomePassComp", require("app.fairyGUI.home.UI_HomePassComp"))
local var_0_6 = g.core.model.User.newYearWishData

function HomePassComp:ctor()
	self._pushSchedule = nil

	self:_initBtn()
end

function HomePassComp:_initBtnInfo()
	self._btnList = {
		{
			btn = self.m_passCardBtn,
			redPointComp = self.m_passCardBtn:getChild("redPointComp"),
			showFunc = handler(var_0_2.passCardData, var_0_2.passCardData.getIsShowPassCard),
			updateFunc = handler(self, self._updatePassBtn)
		},
		{
			btn = self.m_primaryDrawBtn,
			redPointComp = self.m_primaryDrawBtn:getChild("redPointComp"),
			showFunc = handler(var_0_2.recruitData, var_0_2.recruitData.checkPrimaryBtnIsShow)
		},
		{
			btn = self.m_newYearWishBtn,
			showFunc = handler(var_0_6, var_0_6.isShowEntrance)
		},
		{
			btn = self.m_onLineAwardBtn,
			showFunc = handler(var_0_2.onlineGiftData, var_0_2.onlineGiftData.isCanShowOnlineAwardBtn)
		},
		{
			btn = self.m_pushGiftBtn,
			redPointComp = self.m_pushGiftBtn:getChild("redPointComp"),
			showFunc = handler(var_0_2.pushGiftData, var_0_2.pushGiftData.isShowPushGift)
		},
		{
			btn = self.m_goldSavingBtn,
			showFunc = handler(var_0_2.goldSavingData, var_0_2.goldSavingData.isShowEntrance)
		},
		{
			btn = self.m_dailyWishBtn,
			redPointComp = self.m_dailyWishBtn:getChild("redPointComp"),
			showFunc = handler(var_0_2.activityWishpoolData, var_0_2.activityWishpoolData.isShowEntrance)
		},
		{
			btn = self.m_lotteryBtn,
			redPointComp = self.m_lotteryBtn:getChild("redPointComp"),
			showFunc = handler(var_0_2.lotteryData, var_0_2.lotteryData.hasLotteryActivity)
		},
		{
			btn = self.m_passCardNewBtn,
			redPointComp = self.m_passCardNewBtn:getChild("redPointComp"),
			showFunc = handler(var_0_2.gmPassCardData, var_0_2.gmPassCardData.isInOpenTime)
		},
		{
			btn = self.m_primaryWedBtn,
			redPointComp = self.m_primaryWedBtn:getChild("redPointComp"),
			showFunc = handler(var_0_2.weddingActivityData, var_0_2.weddingActivityData.isOpen)
		},
		{
			btn = self.m_serverPassBtn,
			redPointComp = self.m_serverPassBtn:getChild("redPointComp"),
			showFunc = handler(var_0_2.serverPassActivityData, var_0_2.serverPassActivityData.isShow)
		}
	}

	self.m_serverPassBtn:getChild("effectComp"):addEffectSpine({
		name = "eff_ui_serverPass_homeicon",
		scale = 1,
		isLoop = true
	})
end

function HomePassComp:_initBtn()
	self:_initBtnInfo()
	self.m_passCardBtn:addClickListener(handler(self, self._onPassCardBtnClick))
	self.m_passCardNewBtn:addClickListener(handler(self, self._onPassCardNewBtnClick))
	self.m_primaryDrawBtn:addClickListener(handler(self, self.onPrimaryBtnClicked))
	self.m_pushGiftBtn:addClickListener(handler(self, self._onPushGiftBtnClick))
	self.m_newYearWishBtn:addClickListener(handler(self, self._onNewYearWishBtnClick))
	self.m_dailyWishBtn:addClickListener(handler(self, self._onOpenWishPoolClick))
	self.m_lotteryBtn:addClickListener(handler(self, self._onLotteryClick))
	self.m_primaryWedBtn:addClickListener(handler(self, self._onPrimaryWedBtnClick))
	self.m_serverPassBtn:addClickListener(handler(self, self._onServerPassBtnClick))
	self.m_onLineAwardBtn:setInMainLayer()
end

function HomePassComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PASS_CARD_INFO, handler(self, self._checkPassBtnShow), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_QUARTER_MINUTE_NOTIFY, handler(self, self.updateEntrance), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FLUSH_RED_POINT, handler(self, self.updateEntrance), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_CHECK_WAR_ORDER, handler(self, self._checkPassGuide), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_AWARD, handler(self, self.checkPushGiftVisible), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_GETGMACTINFO, handler(self, self.checkPushGiftVisible), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECRUIT_INFO, handler(self, self._checkPrimaryVisible), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_YEAR_WISH_GETINFO, handler(self, self._checkAndUpdateNewYear), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_LOTTERY_GETINFO, handler(self, self._checkLotteryVisible), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEDDING_ACTIVITY_GETINFO, handler(self, self._checkPrimaryWedVisible), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SERVER_PASS_INFO, handler(self, self._checkServerPassBtnShow), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SERVER_PASS_AWARD, handler(self, self._checkServerPassBtnShow), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SERVER_PASS_AWARDALL, handler(self, self._checkServerPassBtnShow), self)
	self:updateEntrance()

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.LOTTERY) and not var_0_2.lotteryData:hasReqInfo() then
		g.core.network.GameNetProxy:send_C2S_Lottery_GetInfo({})
	end
end

function HomePassComp:onUnload()
	self._primaryWedTimer = nil
end

function HomePassComp:_checkPassGuide()
	if not self.m_passCardBtn:isVisible() then
		return
	end

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.FIRST_FIGHT_WAR_ENTER) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_PASS_CARD",
			targetBtn = self.m_passCardBtn
		})
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK_DAILY_COST)
end

function HomePassComp:updateEntrance()
	if var_0_6:isShowEntrance() then
		self:_updateNewYearWishBtnTitle()
		self:_updateNewYearWishIcon()
	end

	self:checkPushGiftVisible()
	self:checkBtnVisible()
end

function HomePassComp:checkPushGiftVisible()
	if var_0_1:isShowPushGift() then
		local var_8_0 = self.m_pushGiftBtn:getChild("effectComp")

		var_8_0:removeAllEffect()
		var_8_0:addEffectSpine({
			name = "eff_ui_pushGift_idle",
			scale = 1,
			isLoop = true
		})
		self.m_pushGiftBtn:setVisible(true)
		self:_updatePushCountDown()

		self._pushSchedule = self._pushSchedule or self:newSchedule(handler(self, function()
			self:_updatePushCountDown()
		end), 1)
	else
		self.m_pushGiftBtn:setVisible(false)
	end
end

function HomePassComp:checkBtnVisible()
	local var_10_0 = 0
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(self._btnList) do
		local var_10_2 = false

		if iter_10_1.btn and iter_10_1.showFunc and iter_10_1.showFunc() then
			var_10_0 = var_10_0 + 1
			var_10_2 = true

			iter_10_1.btn:setX(var_0_3 + (var_10_0 - 1) * var_0_4)

			if iter_10_1.updateFunc then
				iter_10_1.updateFunc()
			end

			if iter_10_1.redPointComp then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
					redPointComp = iter_10_1.redPointComp,
					customData = {
						needRefresh = true
					}
				})
			end

			var_10_1 = var_10_1 + 1
		end

		iter_10_1.btn:setVisible(var_10_2)

		if iter_10_1.btn == self.m_primaryDrawBtn and var_10_2 == false then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_HOME_GUIDE_CHECK)
		end
	end

	self:getScrollPane():setTouchEffect(var_10_1 > 4)
end

function HomePassComp:_checkAndUpdateNewYear()
	local var_11_0 = var_0_6:isShowEntrance()

	self.m_newYearWishBtn:setVisible(var_11_0)

	if var_11_0 then
		self:_updateNewYearWishBtnTitle()
		self:_updateNewYearWishIcon()
	end
end

function HomePassComp:_updateNewYearWishBtnTitle()
	self.m_newYearWishBtn:setText((var_0_6:getTitle()))
end

function HomePassComp:_updateNewYearWishIcon()
	local var_13_0 = var_0_6:getIconURL()

	self.m_newYearWishBtn:getChild("iconBg"):setURL(var_13_0.bg)
	self.m_newYearWishBtn:getChild("iconLot"):setURL(var_13_0.lot)
end

function HomePassComp:_onPassCardBtnClick()
	if not var_0_2.passCardData:getIsShowPassCard() then
		g.core.module.ModuleManager:tip(g.core.lang:get(405002))

		return
	end

	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.PASS_CARD, nil, true) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PASS_CARD_MAIN)
	end
end

function HomePassComp:_onPassCardNewBtnClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.PASS_CARD_NEW, nil, true) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_PASS_CARD)
	end
end

function HomePassComp:_onPushGiftBtnClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.PUSH_GIFT, nil, true) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PUSH_GIFT)
	end
end

function HomePassComp:_onNewYearWishBtnClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.NEW_YEAR_WISH) then
		if var_0_6:isDrawEnable() then
			g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_YEAR_WISH)
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_YEAR_WISH_RESULT, (var_0_6:getActInfo()))
		end
	end
end

function HomePassComp:_onOpenWishPoolClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.DAILY_WISH) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.WISH_POOL)
	end
end

function HomePassComp:_checkPrimaryVisible()
	self.m_primaryDrawBtn:setVisible((var_0_2.recruitData:checkPrimaryBtnIsShow()))
end

function HomePassComp:onPrimaryBtnClicked()
	g.core.module.ModuleManager:pushModule(g.view.entrance.PRIMARY_RECRUIT)
end

function HomePassComp:_checkLotteryVisible()
	self.m_lotteryBtn:setVisible((var_0_2.lotteryData:hasLotteryActivity()))
end

function HomePassComp:_onLotteryClick()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_YHC_CHOUKA)

	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.LOTTERY) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.LOTTERY)
	end
end

function HomePassComp:_checkPrimaryWedVisible()
	local var_23_0 = var_0_2.weddingActivityData:isOpen()

	self.m_primaryWedBtn:setVisible(var_23_0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_primaryWedBtn:getChild("redPointComp")
	})

	if var_23_0 then
		if self._primaryWedTimer then
			self:cancelSchedule(self._primaryWedTimer)
		end

		local var_23_1 = var_0_2.weddingActivityData:getFrontActData()
		local var_23_2 = var_23_1.openTime + var_23_1.holdTime - g.core.common.ServerTime:getTime()

		if var_23_2 > 0 then
			self._primaryWedTimer = self:newScheduleOnce(handler(self, function(arg_24_0)
				arg_24_0._primaryWedTimer = nil

				arg_24_0:_checkPrimaryWedVisible()
			end), var_23_2)
		end
	end
end

function HomePassComp:_onPrimaryWedBtnClick()
	if var_0_2.weddingActivityData:isOpen() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.WEDDING_ACTIVITY_POP)
		self:newScheduleOnce(handler(self, function(arg_26_0)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = arg_26_0.m_primaryWedBtn:getChild("redPointComp")
			})
		end), 0.5)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(405002))
		self.m_primaryWedBtn:setVisible(false)
	end
end

function HomePassComp:_onServerPassBtnClick()
	if var_0_2.serverPassActivityData:isShow() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.SERVER_PASS_MAIN_LAYER)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(405002))
		self.m_serverPassBtn:setVisible(false)
	end
end

function HomePassComp:_checkPassBtnShow()
	self.m_passCardBtn:setVisible((var_0_2.passCardData:getIsShowPassCard()))
end

function HomePassComp:_checkServerPassBtnShow()
	self.m_serverPassBtn:setVisible((var_0_2.serverPassActivityData:isShow()))
end

function HomePassComp:_updatePassBtn()
	local var_30_0 = var_0_2.passCardData:getCardBaseInfo().rechargr_type

	if var_30_0 >= 3 then
		var_30_0 = 2
	end

	self.m_passCardBtn:setIcon((g.core.common.Path:getPassCardEntranceIconByCharge(var_30_0 or 0)))
end

function HomePassComp:_updatePushCountDown()
	local var_31_0 = var_0_1:getShortTimeGift()

	if var_31_0 then
		local var_31_1 = var_0_1:getPushGiftContentInfo(var_31_0.gift_id)

		if not var_31_1 then
			return
		end

		local var_31_2 = g.core.common.ServerTime:getTime()

		if var_31_0.create_time + var_31_1.gift_time_limit - var_31_2 > 0 then
			self.m_pushGiftBtn:getChild("timeTxt"):setVisible(true)
			self.m_pushGiftBtn:getChild("timeTxt"):setText((g.core.common.ServerTime:_secondToString(var_31_0.create_time + var_31_1.gift_time_limit - var_31_2)))
		else
			self:_cancelPushSchedule()
		end
	else
		self:_cancelPushSchedule()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_pushGiftBtn:getChild("redPointComp")
	})
end

function HomePassComp:_cancelPushSchedule()
	if not var_0_1:getShortTimeGift() and var_0_1:getPushGiftCount() > 0 then
		self.m_pushGiftBtn:getChild("timeTxt"):setText(g.core.lang:get(406507))
		self.m_pushGiftBtn:getChild("timeTxt"):setVisible(true)
	else
		self:checkBtnVisible()
		self.m_pushGiftBtn:setVisible(false)
	end

	if self._pushSchedule then
		self:cancelSchedule(self._pushSchedule)

		self._pushSchedule = nil
	end
end

function HomePassComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

	if self._pushSchedule then
		self:cancelSchedule(self._pushSchedule)

		self._pushSchedule = nil
	end
end

return HomePassComp
