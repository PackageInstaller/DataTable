local var_0_0 = g.core.model.User.activityWishpoolData
local var_0_1 = g.core.utils.Number.getFormatNum
local ActivityWishpoolComp = class("ActivityWishpoolComp", require("app.fairyGUI.activity.UI_ActivityWishpoolComp"))

function ActivityWishpoolComp:ctor()
	self.m_bottomBg:setURL("bg/activity/bg_hd_wish_main.jpg")
	self.m_topBgHolder:addEffectSpine({
		anim = "idle",
		name = "wishpool_heye",
		isLoop = true
	})
	self.m_dailyRewardBtn:addClickListener(handler(self, self._onGetDailyReward))
	self.m_fishPoolBtn:addClickListener(handler(self, self._onFishPoolClick))
	self.m_fishingBtn:addClickListener(handler(self, self._onStartFishing))
	self.m_fishingClickHandler:addClickListener(handler(self, self._onClickFishing))
	self.m_invaildClickComp:addClickListener(handler(self, self._onClickInValidFishing))

	self._centerPos = cc.p(self.m_center:getPosition())
	self._fishOutNum = 0
	self._centerSize = self.m_center:getSize()
	self._fishPool = {}
	self._addFish = false

	self.m_yuerIcon:setURL(g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.BAIT
	}).icon_mini)
	self:addListen(self.m_center)
end

function ActivityWishpoolComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WISHPOOL_FLUSH, self._onWishPoolFlush, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WISHPOOL_DAILYPRESENTS, handler(self, self._onDailyReward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WISHPOOL_FISHING, handler(self, self._onFishingSuccess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)

	self._runScheduler = self._runScheduler or self:newSchedule(handler(self, self._doRun), 0)

	self:updateTime()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_dailyRewardBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_fishingBtn
	})
end

function ActivityWishpoolComp:_onCrossDayUpdate()
	g.core.network.GameNetProxy:send_C2S_Wishpool_Flush({})
end

function ActivityWishpoolComp:updateTime(arg_4_1)
	local var_4_0 = g.core.common.ServerTime:getTime()

	if not self._lastUpdateTime or self._lastUpdateTime ~= var_4_0 then
		self._lastUpdateTime = var_4_0

		local var_4_1 = var_0_0:getEndTime() - var_4_0
		local var_4_2
		local var_4_3
		local var_4_4

		if var_4_1 >= 0 then
			var_4_2 = math.floor(var_4_1 / 86400)
			var_4_3 = math.floor((var_4_1 - var_4_2 * 86400) / 3600)
			var_4_4 = math.floor((var_4_1 - var_4_2 * 86400 - var_4_3 * 3600) / 60)
		else
			var_4_2 = 0
			var_4_3 = 0
			var_4_4 = 0
		end

		self.m_lastTimeTxt:setText(g.core.lang:get(409008, {
			day = var_0_1(2, var_4_2),
			hour = var_0_1(2, var_4_3),
			min = var_0_1(2, var_4_4)
		}))
	end
end

function ActivityWishpoolComp:addFish(arg_5_1)
	local var_5_0 = fgui.UIPackage:createObject("activity", "ActivityFishComp")

	var_5_0:setFishStyle(arg_5_1)
	var_5_0:setReverse(math.random(1, 2) > 1)
	self.m_center:addChild(var_5_0)
	var_5_0:setPosition(math.random(100, self._centerSize.width - 100), math.random(0, self._centerSize.height))
	var_5_0:fishIdle()
	table.insert(self._fishPool, var_5_0)
end

function ActivityWishpoolComp:fishAllOut(arg_6_1)
	if arg_6_1 then
		for iter_6_0, iter_6_1 in ipairs(self._fishPool) do
			iter_6_1:fishIn()
		end
	else
		for iter_6_2, iter_6_3 in ipairs(self._fishPool) do
			iter_6_3:fishOut()
		end
	end
end

function ActivityWishpoolComp:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "FISH_OUT_FINISH" then
		self:fishMoveIn()

		return true
	elseif arg_7_1 == "EVENT_FISH_BE_GET" then
		self._removeFishIndex = nil

		table.remove(self._fishPool, self._removeFishIndex):runFGAction((fgui.FSequence:create(fgui.FFadeOut:create(0.3), fgui.FCallFunc:create(handler(self, self.onShowFishingAward)), fgui.FRemoveSelf:create())))
		self._fishRobEff:setAnimation(0, "out", false)
		self._fishRobEff:addSpineEventListener(handler(self, self._onFinishEventFish))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_Bite)
	end

	return false
end

function ActivityWishpoolComp:checkCanChangeState()
	if self._lastClickPos then
		g.core.module.ModuleManager:tip(g.core.lang:get(409011))

		return false
	end

	return true
end

function ActivityWishpoolComp:checkInFishingOutAndIn()
	if self._removeFishIndex then
		table.remove(self._fishPool, self._removeFishIndex):removeSelf()
	end

	self:onShowFishingAward()

	self._lastClickPos = nil
end

function ActivityWishpoolComp:onFishFastMove()
	for iter_10_0, iter_10_1 in ipairs(self._fishPool) do
		local var_10_0

		if iter_10_1:checkIsMyType(self._rewardFishContent.drop_id) and not false then
			self._removeFishIndex = iter_10_0
			var_10_0 = true

			iter_10_1:setFishVictim()
		end

		iter_10_1:fishSpeedFast()
	end
end

function ActivityWishpoolComp:onFishAllOut()
	self:fishMoveIn()
end

function ActivityWishpoolComp:fishMoveIn()
	if not self._rewardFishContent then
		return
	end

	self._fishPool[self._removeFishIndex]:fishMoveToPos(self._lastClickPos)

	for iter_12_0, iter_12_1 in ipairs(self._fishPool) do
		iter_12_1:fishSpeedNormal()
	end
end

function ActivityWishpoolComp:_doRun(arg_13_1)
	self:updateTime(arg_13_1)

	for iter_13_0, iter_13_1 in ipairs(self._fishPool) do
		iter_13_1:doRun(arg_13_1)
	end
end

function ActivityWishpoolComp:updateComp(arg_14_1)
	self.m_inFishingController:setSelectedIndex(0)
	self.m_fishingRodHolder:setVisible(false)
	g.core.network.GameNetProxy:send_C2S_Wishpool_Flush({})
	self.m_enterTransition:play()
	self.m_clickFishTxt:setText(g.core.lang:get(409014))
	self:checkInFishingOutAndIn()
end

function ActivityWishpoolComp:checkDailyReward()
	local var_15_0 = not var_0_0:isGetDailyReward()

	self.m_dailyRewardBtn:setVisible(var_15_0)
	self.m_animDaily1:setVisible(var_15_0)
	self.m_animDaily2:setVisible(var_15_0)

	if var_15_0 then
		self.m_rewardTransition:play(-1, 0)
	end
end

function ActivityWishpoolComp:updateView()
	self:checkDailyReward()
	self.m_fishNumTxt:setText(g.core.lang:get(409006, {
		num = var_0_0:getLastFishNum()
	}))

	local var_16_0 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT)

	self.m_yuerNumTxt:setText(var_16_0 .. "/" .. var_0_0:getActCfg().bait_num)

	if #self._fishPool == 0 then
		self.m_havFishController:setSelectedIndex(1)
	else
		self.m_havFishController:setSelectedIndex(0)
	end

	if var_16_0 >= var_0_0:getActCfg().bait_num then
		self.m_fishingBtn:setCtrlState("state", {
			index = 0
		})
	else
		self.m_fishingBtn:setCtrlState("state", {
			index = 1
		})
	end

	self.m_progressComp:updateProgressComp()
end

function ActivityWishpoolComp:_onGetDailyReward()
	if not var_0_0:isGetDailyReward() then
		g.core.network.GameNetProxy:send_C2S_Wishpool_DailyPresents({})
	end
end

function ActivityWishpoolComp:_onFishPoolClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.activity.view.activityWishpool.ActivityFishPoolPop").new(), {
		touchDisappear = true
	})
end

function ActivityWishpoolComp:_onStartFishing()
	if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT) >= var_0_0:getActCfg().bait_num and #self._fishPool > 0 then
		self.m_inFishingController:setSelectedIndex(1)
		self.m_clickFishTxt:setText(g.core.lang:get(409015))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RodClick)
	elseif #self._fishPool > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(409010))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(409009))
	end
end

function ActivityWishpoolComp:_onClickFishing(arg_20_1)
	if self._lastClickPos then
		g.core.module.ModuleManager:tip(g.core.lang:get(409011))

		return
	end

	local var_20_0 = arg_20_1:getInput():getPosition()

	self._lastClickPos = var_20_0

	if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT) >= var_0_0:getActCfg().bait_num and #self._fishPool > 0 then
		g.core.network.GameNetProxy:send_C2S_Wishpool_Fishing({})
		self.m_fishingRodHolder:setVisible(true)

		if not self._fishRobEff then
			self._fishRobEff = self.m_fishingRodHolder:addEffectSpine({
				anim = "in",
				name = "wishpool_yuju",
				isLoop = false
			})
		else
			self._fishRobEff:setAnimation(0, "in", false)
		end

		self.m_clickFishTxt:setText(g.core.lang:get(409016))
		self.m_fishingRodHolder:setPosition(var_20_0)
		self._fishRobEff:addSpineEventListener(handler(self, self._onStartEventFish))
	elseif #self._fishPool > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(409010))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(409009))
	end
end

function ActivityWishpoolComp:_onClickInValidFishing()
	g.core.module.ModuleManager:tip(g.core.lang:get(409012))
end

function ActivityWishpoolComp:_onStartEventFish(arg_22_1)
	if arg_22_1.type == "complete" then
		self._fishRobEff:setAnimation(0, "idle", true)
		self._fishRobEff:addSpineEventListener()
	end
end

function ActivityWishpoolComp:_onFinishEventFish(arg_23_1)
	if arg_23_1.type == "complete" then
		self._fishRobEff:addSpineEventListener()
	end
end

function ActivityWishpoolComp:_onWishPoolFlush(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if not self._addFish then
		self._addFish = true

		for iter_24_0, iter_24_1 in pairs((var_0_0:getCurrentAllFish())) do
			if iter_24_1 > 0 then
				for iter_24_2 = 1, iter_24_1 do
					self:addFish(iter_24_0)
				end
			end
		end
	end

	self:updateView()
end

function ActivityWishpoolComp:_onDailyReward(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	self:checkDailyReward()
	g.core.module.ModuleManager:awardSummary(arg_25_4.awards)
	self:updateView()
end

function ActivityWishpoolComp:_onFishingSuccess(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	self._rewardFishContent = arg_26_4

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_Fishing)
	self:onFishFastMove()
end

function ActivityWishpoolComp:onShowFishingAward()
	if not self._rewardFishContent then
		return
	end

	g.core.module.ModuleManager:awardSummary(self._rewardFishContent.awards)
	self.m_fishNumTxt:setText(g.core.lang:get(409006, {
		num = var_0_0:getLastFishNum()
	}))
	self.m_yuerNumTxt:setText(g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT) .. "/" .. var_0_0:getActCfg().bait_num)

	self._rewardFishContent = nil

	self:resetFishingPage()
end

function ActivityWishpoolComp:resetFishingPage()
	self.m_fishingRodHolder:setVisible(false)
	self.m_inFishingController:setSelectedIndex(0)

	if #self._fishPool == 0 then
		self.m_havFishController:setSelectedIndex(1)
	else
		self.m_havFishController:setSelectedIndex(0)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_fishingBtn
	})

	if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT) >= var_0_0:getActCfg().bait_num then
		self.m_fishingBtn:setCtrlState("state", {
			index = 0
		})
	else
		self.m_fishingBtn:setCtrlState("state", {
			index = 1
		})
	end

	self.m_clickFishTxt:setText(g.core.lang:get(409014))

	self._lastClickPos = nil
end

function ActivityWishpoolComp:onUnload()
	local var_29_0 = self._rewardFishContent

	if self._rewardFishContent then
		self._rewardFishContent = nil

		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.module.ModuleManager:awardSummary(var_29_0.awards)
		end, 0)
	end
end

return ActivityWishpoolComp
