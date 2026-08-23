local var_0_0 = g.core.model.User.activityDataManager
local var_0_1 = g.core.model.User.onlineGiftData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.const.ConstMgr
local var_0_5 = g.core.const.ConstMgr.ActivityConst
local ActivityOnlineGiftMainComp = class("ActivityOnlineGiftMainComp", require("app.fairyGUI.activity.UI_ActivityOnlineGiftMainComp"))

function ActivityOnlineGiftMainComp:ctor()
	self._isCoolDownOver = false
	self._activityValue = nil
	self._activityData = nil
	self._giftRemainTime = 0
	self._rewardData = {}
	self._isPlayEnter = true
	self._isCanTouch = true

	self.m_helpBtn:addClickListener(handler(self, self._onClickedHelpBtn))
	self.m_touchImage:addClickListener(handler(self, self._onGetAwardClick))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onItemRenderer))

	self._isSendMsg = false

	self.m_boxIconController:setSelectedIndex(3)
end

function ActivityOnlineGiftMainComp:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_ONLINE_GIFT_GETINFO, handler(self, self._updateContent), self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_ONLINE_GIFT_GETAWARD, handler(self, self._onRecGetAward), self)
	var_0_2:addEventListener(var_0_3.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)

	self._curGift = var_0_1:getCurGift()

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.ONLINE_GIFT_ENTER) then
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.ONLINE_GIFT_ENTER)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = g.core.const.ConstMgr.GuideConst.SPE_STORY_IDS.ONLINE_GIFT_STORY
		})
	end
end

function ActivityOnlineGiftMainComp:updateCD()
	if not self._activityValue then
		return
	end

	local var_3_0 = var_0_0:getConfigTableActivityData(var_0_5.ACTIVITY_TYPE.ONLINE_GIFT, 0)

	if var_3_0 then
		local var_3_1 = math.max(0, var_3_0:getFinishTime() - g.core.common.ServerTime:getTime())

		self.m_activityTimeTxt:setText(g.core.common.ServerTime:secondToDHMString(var_3_1))

		if var_3_1 <= 0 then
			self:dispatchCompEvent("event_activity_expired")
		end
	end
end

function ActivityOnlineGiftMainComp:updateComp(arg_4_1)
	if arg_4_1 and arg_4_1 ~= self._activityValue then
		self._activityValue = arg_4_1
	end

	if self.m_enterTransition and self._isPlayEnter then
		self.m_enterTransition:play()
	end

	if not self._isSendMsg then
		self._isSendMsg = true

		g.core.network.GameNetProxy:send_C2S_OnlineGift_GetInfo({})

		return
	end

	self:_updateContent()
end

function ActivityOnlineGiftMainComp:_updateContent()
	self:_updateRewardList()
	self:_updateCurShowRewardState()

	self._isPlayEnter = true
end

function ActivityOnlineGiftMainComp:_onClickedHelpBtn()
	if var_0_4.HelpConst.HELP_TYPE.ACTIVITY_ONLINE_GIFT and var_0_4.HelpConst.HELP_TYPE.ACTIVITY_ONLINE_GIFT > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
			id = var_0_4.HelpConst.HELP_TYPE.ACTIVITY_ONLINE_GIFT
		}), {
			touchDisappear = true
		})
	end
end

function ActivityOnlineGiftMainComp:_updateRewardList()
	self._rewardData = var_0_1:getAllGift()

	self.m_rewardList:setNumItems(#self._rewardData)

	self._curGift = var_0_1:getCurGift()

	if self._curGift then
		self.m_rewardList:scrollToView(((self._curGift.info.order or 1) - 2 < 0 or nil) and 0)
	end
end

function ActivityOnlineGiftMainComp:_updateCurShowRewardState()
	if not self._activityValue then
		return
	end

	local var_8_0 = var_0_1:isAllReceive()

	if var_8_0 then
		self.m_stateController:setSelectedIndex(2)

		self._giftRemainTime = 0
	elseif self._curGift then
		self.m_stateController:setSelectedIndex(self._curGift.state == 0 and 0 or 1)

		self._giftRemainTime = self._curGift.curRemainTime
	else
		self._giftRemainTime = 0
	end

	if not self._isCoolDownOver then
		if self._giftRemainTime > 0 then
			self.m_leftTimeComp:resetCooldownTs(self._giftRemainTime, handler(self, self._coolDownOver))
		else
			self.m_leftTimeComp:resetCooldownTs(self._giftRemainTime)

			if not var_8_0 and self._curGift then
				self.m_stateController:setSelectedIndex(1)
			end
		end
	elseif not var_8_0 and self._curGift then
		self.m_stateController:setSelectedIndex(1)
	end

	if self._curGift then
		self.m_boxIconController:setSelectedIndex(self._curGift.info.boxState or 0)
	else
		self.m_boxIconController:setSelectedIndex(2)
	end

	self:_playBoxGiftSpine()
	self:_playLeftTimeSpine()
end

function ActivityOnlineGiftMainComp:_onItemRenderer(arg_9_1, arg_9_2)
	if self._rewardData[arg_9_1 + 1] then
		arg_9_2:updateItem(self._rewardData[arg_9_1 + 1], arg_9_1)
	end
end

function ActivityOnlineGiftMainComp:_coolDownOver()
	self._isCoolDownOver = true

	self:_createCoolDownOverSpine()
end

function ActivityOnlineGiftMainComp:_createCoolDownOverSpine()
	self:_playBoxGiftSpine(true)

	self._isPlayEnter = false

	self:updateComp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ACTIVITY_ONLINE_GIFT_REFRESH_POINT)
end

function ActivityOnlineGiftMainComp:_onGetAwardClick()
	self._curGift = var_0_1:getCurGift()

	if self._curGift and self._isCanTouch then
		if self._curGift.state == 1 then
			local var_12_0 = self._curGift.info.order or 1

			g.core.network.GameNetProxy:send_C2S_OnlineGift_GetAward({
				order = var_12_0
			})
		elseif self._curGift.state == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(402251))
		end
	end
end

function ActivityOnlineGiftMainComp:_onCrossDayUpdate()
	g.core.network.GameNetProxy:send_C2S_OnlineGift_GetInfo({})

	self._isCoolDownOver = false
end

function ActivityOnlineGiftMainComp:_onRecGetAward(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self._isCanTouch = false

	if self._effCasePick then
		self._effCasePick:removeFromParent()

		self._effCasePick = nil
	end

	self._curAwardContent = arg_14_4
	self._effCasePick = require("app.view.common.SpineBase").new({
		resId = "",
		isLoop = false,
		anim = "play",
		path = g.core.common.Path:getEffSpine("eff_ui_activity_casePick"),
		listener = handler(self, self._onGetAwardSpineBack)
	})

	self.m_effCasePick:addNode(self._effCasePick)
	self:_playLeftTimeSpine(true)
end

function ActivityOnlineGiftMainComp:_playBoxGiftSpine(arg_15_1)
	if self._effCaseLine then
		self._effCaseLine:removeFromParent()

		self._effCaseLine = nil
	end

	if self._effCaseCrack then
		self._effCaseCrack:removeFromParent()

		self._effCaseCrack = nil
	end

	if self._curGift then
		if self._curGift.state == 1 or arg_15_1 then
			local var_15_0 = self._curGift.info.boxState or 0
			local var_15_1 = "play"
			local var_15_2

			if var_15_0 == 0 then
				var_15_1 = "play3"
			elseif var_15_0 == 1 then
				var_15_1 = "play2"
				var_15_2 = require("app.view.common.SpineBase").new
			end

			self._effCaseLine = require("app.view.common.SpineBase").new({
				resId = "",
				isLoop = true,
				path = g.core.common.Path:getEffSpine("eff_ui_activity_caseLine"),
				anim = var_15_1
			})

			self.m_effCaseLine:addNode(self._effCaseLine)
		elseif self._curGift.state == 0 then
			self._effCaseCrack = require("app.view.common.SpineBase").new({
				resId = "",
				anim = "play",
				isLoop = true,
				path = g.core.common.Path:getEffSpine("eff_ui_activity_caseCrack")
			})

			self.m_effCaseCrack:addNode(self._effCaseCrack)
		end
	end
end

function ActivityOnlineGiftMainComp:_playLeftTimeSpine(arg_16_1)
	if self._effRing then
		self._effRing:removeFromParent()

		self._effRing = nil
	end

	if self._curGift then
		local var_16_0 = {
			resId = "",
			anim = "play",
			isLoop = true,
			path = g.core.common.Path:getEffSpine("eff_ui_activity_ring")
		}

		if self._curGift.state == 1 then
			if arg_16_1 then
				var_16_0.isLoop = false
				var_16_0.anim = "play3"
			else
				var_16_0.isLoop = false
				var_16_0.anim = "play2"
			end
		elseif self._curGift.state == 0 then
			var_16_0.isLoop = true
			var_16_0.anim = "play"
		end

		self._effRing = require("app.view.common.SpineBase").new(var_16_0)

		self.m_effRing:addNode(self._effRing)
	end
end

function ActivityOnlineGiftMainComp:_onGetAwardSpineBack(arg_17_1, arg_17_2)
	if arg_17_1.type == "complete" and self and self._curAwardContent then
		self._isCoolDownOver = false
		self._isPlayEnter = false

		self:updateComp()

		self._isCanTouch = true

		local var_17_0

		if self._curAwardContent then
			var_17_0 = self._curAwardContent.awards or {}
		end

		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			iter_17_1.changeControllers = true
			iter_17_1.nameRow = 2
		end

		require("app.view.module.show.ShowFactory"):awardSummary(var_17_0)

		self._curAwardContent = nil
	end
end

return ActivityOnlineGiftMainComp
