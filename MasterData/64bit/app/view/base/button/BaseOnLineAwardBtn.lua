local var_0_1 = g.core.model.User
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.const.ConstMgr.ActivityConst
local BaseOnLineAwardBtn = class("BaseOnLineAwardBtn", require("app.fairyGUI.base_new.UI_BaseOnLineAwardBtn"))

function BaseOnLineAwardBtn:ctor(arg_1_1)
	self._timeSchedule = nil
	self._isShow = false
	self._spineNode = nil
	self._inMainLayer = false

	self:addClickListener(handler(self, self._onGoToOnLineAwardModule))
end

function BaseOnLineAwardBtn:onLoad()
	if g.core.guide.GuideProxy:isGuideRunning() then
		self:setVisible(false)

		return
	end

	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_ONLINE_GIFT_GETINFO, handler(self, self._updateBtn), self)
	var_0_2:addEventListener(var_0_3.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	var_0_2:addEventListener(var_0_3.EVENT_GUIDE_CHECK_ONLINE_GIFT, self._onCheckOnlineGiftGuide, self)

	self._isShow = false

	if var_0_1.onlineGiftData:isCanShowOnlineAwardBtn() and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ONLINE_GIFT) then
		self._timeSchedule = self:newSchedule(handler(self, self._updateCD), 1)
		self._isShow = true

		g.core.network.GameNetProxy:send_C2S_OnlineGift_GetInfo({})
	end

	self:setVisible(self._isShow)

	if self._isShow and not self._inMainLayer and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.ONLINE_GIFT_ENTER) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_ONLINE_GIFT",
			targetBtn = self
		})
	end
end

function BaseOnLineAwardBtn:_onCheckOnlineGiftGuide()
	if self._isShow and self._inMainLayer and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.ONLINE_GIFT_ENTER) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_ONLINE_GIFT",
			targetBtn = self
		})
	end
end

function BaseOnLineAwardBtn:_onGoToOnLineAwardModule()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ACTIVITY, {
		activityValue = 0,
		activityType = var_0_4.ACTIVITY_TYPE.ONLINE_GIFT
	})
end

function BaseOnLineAwardBtn:_updateBtn()
	self:_updateState()
	self:_setShowText()
end

function BaseOnLineAwardBtn:setInMainLayer()
	self._inMainLayer = true
end

function BaseOnLineAwardBtn:_updateState()
	self._curGift = var_0_1.onlineGiftData:getCurGift()

	if self._curGift then
		self.m_stateController:setSelectedIndex(self._curGift.state == 0 and 0 or 1)
		self.m_boxIconController:setSelectedIndex(self._curGift.info.boxState or 0)
	else
		self._isShow = false

		self.m_boxIconController:setSelectedIndex(3)
	end

	self:_showSpine()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function BaseOnLineAwardBtn:_setShowText()
	self._giftRemainTime = self._curGift and self._curGift.endTime - g.core.common.ServerTime:getTime() or 0

	self.m_timeTxt:setText((g.core.common.ServerTime:secondToMSString((math.max(0, self._giftRemainTime)))))

	if self._giftRemainTime <= 0 then
		if self._timeSchedule then
			self:cancelSchedule(self._timeSchedule)

			self._timeSchedule = nil
		end

		self:_updateState()
		self:dispatchCompEvent("OnlineAwardCanGet")
	end
end

function BaseOnLineAwardBtn:_updateCD()
	if self._curGift and self._isShow then
		self:_setShowText()
	end
end

function BaseOnLineAwardBtn:_onCrossDayUpdate()
	if var_0_1.onlineGiftData:isOnlineActivityOpen() then
		g.core.network.GameNetProxy:send_C2S_OnlineGift_GetInfo({})
	end
end

function BaseOnLineAwardBtn:onUnload()
	if self._timeSchedule then
		self:cancelSchedule(self._timeSchedule)

		self._timeSchedule = nil
	end
end

function BaseOnLineAwardBtn:hide()
	self:setVisible(false)

	if self._timeSchedule then
		self:cancelSchedule(self._timeSchedule)

		self._timeSchedule = nil
	end

	if self._spineNode then
		self._spineNode:removeFromParent()

		self._spineNode = nil
	end
end

function BaseOnLineAwardBtn:show()
	self:onLoad()
end

function BaseOnLineAwardBtn:_showSpine()
	if self._spineNode and (not self._curGift or self._curGift.state ~= 1 or self._effectType ~= self.m_boxIconController:getSelectedIndex()) then
		self._spineNode:removeFromParent()

		self._spineNode = nil
	end

	if self._curGift and self._curGift.state == 1 and not self._spineNode then
		local var_14_0
		local var_14_1 = self.m_boxIconController:getSelectedIndex()

		self._effectType = var_14_1

		if var_14_1 ~= 4 then
			var_14_0 = "play_" .. tostring(var_14_1 + 1)
		end

		if not var_14_0 then
			return
		end

		self._spineNode = self.m_effectComp:addEffectSpine({
			isLoop = true,
			x = 0,
			y = 0,
			name = "eff_ui_home_onlinebox",
			anim = var_14_0
		})
	end
end

function BaseOnLineAwardBtn:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return BaseOnLineAwardBtn
