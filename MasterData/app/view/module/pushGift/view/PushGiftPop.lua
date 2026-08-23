local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local var_0_1 = g.core.model.User.pushGiftData
local var_0_2 = g.core.const.ConstMgr.PushGiftConst
local PushGiftPop = class("PushGiftPop", require("app.fairyGUI.pushGift.UI_PushGiftPop"), function()
	return fgui.GComponent:create({
		resName = "PushGiftPop",
		pkgPath = "ui/pushGift/pushGift",
		pkgName = "pushGift"
	})
end)

function PushGiftPop:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.endcall then
		self._closeCallBack = arg_2_1.endcall
	end

	self._startPosX = 0
	self._giftCount = 0
	self._showIndex = var_0_1:getNewGiftIndex()
	self._selectIdx = 1
	self._showGifts = nil
	self._updateSchedule = nil

	self:showAtCenter()
	self:_initUIRegister()
	self:_enterGiftPopEffect()

	if g.core.utils.Rule.matchChannelAndLv() then
		self.m_knightLoader:setVisible(false)
	end
end

function PushGiftPop:_initUIRegister()
	self.m_getBtn:addClickListener(handler(self, self._onClickBuyGiftBtn))
	self.m_preViewBtn:addClickListener(handler(self, self._onClickPrewBtn))
	self.m_nextViewBtn:addClickListener(handler(self, self._onClickNextBtn))
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onGiftListItemRender))
	self.m_giftList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function PushGiftPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onOpRecharge), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_BUY, handler(self, self._onOpGoldBuyGift), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_AWARD, handler(self, self._onPushGiftAwardRecv), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_INFO, handler(self, self._onSrvPushGiftInfo), self)
	self:_updateMainView()
end

function PushGiftPop:_onSrvPushGiftInfo()
	self:_updateMainView(true)
end

function PushGiftPop:_updateMainView(arg_6_1)
	if tolua.isnull(self) then
		return
	end

	if not self:_checkCurGiftExist() then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	self._showGifts = var_0_1:getGiftDataByIndex(self._showIndex, self._selectIdx)

	if not self._showGifts then
		return
	end

	self._showGroupData = var_0_1:getGiftGroupDataByIdx(self._showIndex)

	if self._showGroupData then
		local var_6_0 = #self._showGroupData

		self.m_giftList:setNumItems(#self._showGroupData)
		self.m_giftList:setSelectedIndex(self._selectIdx - 1)
		self.m_hasGroupController:setSelectedIndex(var_6_0 > 1 and 1 or 0)
	else
		self.m_giftList:setVisible(false)
		self.m_hasGroupController:setSelectedIndex(0)
	end

	var_0_1:clearGiftNew(self._showGifts.push_gift_id)
	self.m_timeBg:setVisible(self._showGifts.type == 0)
	self.m_timeImg:setVisible(self._showGifts.type == 0)
	self.m_timeText:setVisible(self._showGifts.type == 0)
	self:_updateCountDown()

	self._updateSchedule = self._updateSchedule or self:newSchedule(handler(self, self._updateCountDown, 1))

	local var_6_1 = var_0_1:getPushGiftInfo(self._showGifts.push_gift_id)

	if not var_6_1 then
		return
	end

	self.m_typeController:setSelectedIndex((math.max(math.min(var_6_1.pic_knight - 1, 2), 0)))

	self._giftCount = var_0_1:getPushGiftGroupCount()

	self.m_preViewBtn:setVisible(self._giftCount > 1)
	self.m_nextViewBtn:setVisible(self._giftCount > 1)
	self.m_getBtn:updateButton(self._showGifts)
	self.m_discountTxt:setText(g.core.lang:get(307005, {
		num = var_0_1:getGiftDiscountById(self._showGifts.gift_id)
	}))
	KnightVoiceCommon.playVoice({
		voiceName = "Vo_" .. tostring(var_0_2.KNIGHT_VOICE[var_6_1.pic_knight]) .. "_sell"
	})

	if self._showIndex > 1 then
		local var_6_2 = var_0_1:getGiftDataByIndex(self._showIndex - 1, 1)

		self.m_preBoxComp:updateAwards(var_6_2)
		self.m_preBoxComp:setVisible(checkbool(var_6_2))
		self.m_preViewBtn:setVisible(checkbool(var_6_2))
	else
		self.m_preBoxComp:setVisible(false)
		self.m_preViewBtn:setVisible(false)
	end

	self.m_curBoxComp:updateAwards(self._showGifts, true, arg_6_1)

	if self._giftCount > 1 and self._showIndex < self._giftCount then
		local var_6_3 = var_0_1:getGiftDataByIndex(self._showIndex + 1, 1)

		self.m_nextBoxComp:updateAwards(var_6_3)
		self.m_nextBoxComp:setVisible(checkbool(var_6_3))
		self.m_nextViewBtn:setVisible(checkbool(var_6_3))
	else
		self.m_nextBoxComp:setVisible(false)
		self.m_nextViewBtn:setVisible(false)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_nextViewBtn
	})
end

function PushGiftPop:_onGiftListItemRender(arg_7_1, arg_7_2)
	local var_7_0 = var_0_1:getPushGiftContentInfo(self._showGroupData[arg_7_1 + 1].gift_id)

	if self._showGroupData[arg_7_1 + 1] and var_7_0 then
		if var_7_0.buy_type == var_0_2.GOLD_TYPE then
			arg_7_2:setTitle(g.core.lang:get(406503, {
				price = var_7_0.price
			}))
		elseif var_7_0.buy_type == var_0_2.GOLD_EXCHANGE_TYPE then
			arg_7_2:setTitle(g.core.lang:get(406510, {
				price = var_7_0.price
			}))
		else
			local var_7_1 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.PUSH_GIFT, var_7_0.price)

			if var_7_1 then
				arg_7_2:setTitle(var_7_1.moneyUnit .. var_7_1.realMoney)
			end
		end
	end
end

function PushGiftPop:_onTabListClickItem()
	local var_8_0 = self.m_giftList:getSelectedIndex() + 1

	if var_8_0 == self._selectIdx then
		return
	end

	self._selectIdx = var_8_0

	self:_updateMainView(true)
end

function PushGiftPop:_onClickPrewBtn()
	if self._showIndex <= 1 then
		return
	end

	self._showIndex = self._showIndex - 1
	self._selectIdx = 1

	self:_updateMainView(true)

	if self._showGroupData then
		self.m_giftList:scrollToView(0)
	end

	self.m_preViewBtn:setTouchable(false)
	self.m_preBoxTransition:play(function()
		self.m_preViewBtn:setTouchable(true)
	end)
	g.core.sound.SoundManager:playSound("UI_Menu_ActivitySlide")
end

function PushGiftPop:_onClickNextBtn()
	if self._showIndex >= self._giftCount then
		return
	end

	self._showIndex = self._showIndex + 1
	self._selectIdx = 1

	self:_updateMainView(true)

	if self._showGroupData then
		self.m_giftList:scrollToView(0)
	end

	self.m_nextViewBtn:setTouchable(false)
	self.m_nextBoxTransition:play(function()
		self.m_nextViewBtn:setTouchable(true)
	end)
	g.core.sound.SoundManager:playSound("UI_Menu_ActivitySlide")
end

function PushGiftPop:_onClickBuyGiftBtn()
	if self:_checkCurGiftExist() and self._showGifts and (not self._showGifts.type or self._showGifts.type == 0) then
		local var_13_0 = var_0_1:getPushGiftContentInfo(self._showGifts.gift_id)

		if var_13_0 and (var_13_0.buy_type == var_0_2.GOLD_TYPE or var_13_0.buy_type == var_0_2.GOLD_EXCHANGE_TYPE) then
			local var_13_1 = g.core.model.User:getFreeGold()

			if var_13_0.buy_type == var_0_2.GOLD_EXCHANGE_TYPE then
				var_13_1 = g.core.model.User:getGold()
			end

			if var_13_1 < var_13_0.price then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = 999,
					value = var_13_0.buy_type == var_0_2.GOLD_EXCHANGE_TYPE and 1 or 0,
					needSize = var_13_0.price,
					curSize = var_13_1,
					func = function(arg_14_0)
						g.core.network.GameNetProxy:send_C2S_PushGift_Buy(arg_14_0)
					end,
					funcParams = {
						id = self._showGifts.id
					}
				})

				return
			end

			g.core.network.GameNetProxy:send_C2S_PushGift_Buy({
				id = self._showGifts.id
			})
		else
			g.core.common.GlobalFunc:checkBagBeforeOpRecharge(g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.PUSH_GIFT, var_13_0.price), self._showGifts.id, 0)
		end
	end
end

function PushGiftPop:_onPushGiftAwardRecv(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if arg_15_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_15_4.awards)

		self._giftCount = var_0_1:getPushGiftGroupCount()

		if self._giftCount > 0 then
			self:_resetShowNewGift()
		else
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	end
end

function PushGiftPop:_resetShowNewGift()
	if var_0_1:getPushGiftGroupCount() == 0 then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	else
		if var_0_1:getGiftGroupDataByIdx(self._showIndex) then
			self._selectIdx = 1
		else
			self._showIndex = 1
			self._selectIdx = 1
		end

		self.m_nextBoxTransition:play()
		self:_updateMainView(true)
	end
end

function PushGiftPop:_onOpRecharge(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if arg_17_4.push_gift then
		g.core.module.ModuleManager:tip(g.core.lang:get(406505))
	end

	g.core.network.GameNetProxy:send_C2S_PushGift_Info({})
	g.core.network.GameNetProxy:send_C2S_PushGift_GetGmActInfo({})
end

function PushGiftPop:_onOpGoldBuyGift(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(406505))
end

function PushGiftPop:_updateCountDown()
	var_0_1:checkValidData()

	if self._showGifts and self._showGifts.gift_id then
		local var_19_0 = var_0_1:getPushGiftContentInfo(self._showGifts.gift_id)

		if var_19_0 then
			self._countDown = self._showGifts.create_time + var_19_0.gift_time_limit - g.core.common.ServerTime:getTime()

			self.m_timeText:setText(g.core.lang:get(406501, {
				str = g.core.common.ServerTime:_secondToString(self._countDown)
			}))

			local var_19_1 = var_0_1:getPushGiftCount()

			if self._countDown <= 0 and var_19_1 <= 1 then
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			elseif self._countDown <= 0 and var_19_1 > 1 then
				self:_resetShowNewGift()
			end
		end
	end
end

function PushGiftPop:homeLayerAutoPopup()
	if self._closeCallBack then
		self._closeCallBack()

		self._closeCallBack = nil
	end
end

function PushGiftPop:_onTouchBegin(arg_21_1)
	arg_21_1:captureTouch()

	self._startPosX = arg_21_1:getInput():getTouch():getLocationInView().x
end

function PushGiftPop:_onTouchEnd(arg_22_1)
	local var_22_0 = arg_22_1:getInput():getPosition().x - self._startPosX

	if var_22_0 > var_0_2.TOUCH_DISTANCE then
		self:_onClickPrewBtn()
	elseif var_22_0 < -var_0_2.TOUCH_DISTANCE then
		self:_onClickNextBtn()
	end
end

function PushGiftPop:_checkCurGiftExist()
	if var_0_1:getPushGiftGroupCount() == 0 then
		return false
	end

	local var_23_0 = var_0_1:getGiftGroupDataByIdx(self._showIndex)

	if not var_23_0 then
		return false
	end

	local var_23_1 = var_23_0[1]

	if not var_23_0[1] then
		return false
	end

	if not var_0_1:getPushGiftInfo(var_23_1.push_gift_id) then
		g.core.platform.BuglyProxy:error("PushGiftPop:_updateMainView:no gift id------------------->" .. var_23_1.push_gift_id)

		return false
	end

	if not var_0_1:getPushGiftContentInfo(var_23_1.gift_id) then
		g.core.platform.BuglyProxy:error("PushGiftPop:_updateMainView:no content id------------------->" .. var_23_1.gift_id)

		return false
	end

	return true
end

function PushGiftPop:_enterGiftPopEffect()
	self.m_enterTransition:play()
	self.m_titleEffect:addEffectSpine({
		isLoop = false,
		name = "eff_ui_pushGift_title"
	})
	self.m_labelEffect:addEffectSpine({
		isLoop = false,
		name = "eff_ui_pushGift_label"
	})
	self.m_bgEffect:addEffectSpine({
		isLoop = false,
		name = "eff_ui_pushGift_bg"
	})
	g.core.sound.SoundManager:playSound("UI_Menu_ActivitySlide")
end

function PushGiftPop:onUnload()
	self:cancelSchedule(self._updateSchedule)

	self._updateSchedule = nil
end

return PushGiftPop
