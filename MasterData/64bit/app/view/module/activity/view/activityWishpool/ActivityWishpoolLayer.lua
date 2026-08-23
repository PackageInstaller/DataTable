local var_0_0 = g.core.model.User.activityWishpoolData
local var_0_1 = g.core.utils.Number.getFormatNum
local ActivityWishpoolLayer = class("ActivityWishpoolLayer", require("app.fairyGUI.activity.UI_ActivityWishpoolLayer"), function()
	return fgui.GComponent:create({
		pkgName = "activity",
		resName = "ActivityWishpoolLayer",
		pkgPath = "ui/activity/activity",
		isFullScreen = true
	}, ...)
end)

function ActivityWishpoolLayer:ctor()
	self.m_bottomBg:setURL("bg/activity/bg_hd_wish_main.jpg")
	self.m_topBgHolder:addEffectSpine({
		anim = "idle",
		name = "wishpool_heye",
		isLoop = true
	})
	self.m_dailyRewardBtn:addClickListener(handler(self, self._onGetDailyReward))
	self.m_fishPoolBtn:addClickListener(handler(self, self._onFishPoolClick))
	self.m_fishingBtn:addClickListener(handler(self, self._onStartFishing))
	self.m_fishingTenBtn:addClickListener(handler(self, self._onStartFishingTen))
	self.m_fishingClickHandler:addClickListener(handler(self, self._onClickFishing))
	self.m_invaildClickComp:addClickListener(handler(self, self._onClickInValidFishing))
	self.m_skipAnimBtn:addClickListener(handler(self, self._onClickSkipAnim))

	self._centerPos = cc.p(self.m_center:getPosition())
	self._fishOutNum = 0
	self._centerSize = self.m_center:getSize()
	self._fishPool = {}
	self._addFish = false

	local var_2_0 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.BAIT
	})

	self.m_yuerIcon:setURL(var_2_0.icon_mini)
	self.m_yuerIcon2:setURL(var_2_0.icon_mini)
	self.m_topBarComp:setResInfoById(263)
	self.m_enterTransition:play()
	var_0_0:saveNewActivity()
	self:addListen(self.m_center)
end

function ActivityWishpoolLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WISHPOOL_FLUSH, self._onWishPoolFlush, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WISHPOOL_DAILYPRESENTS, handler(self, self._onDailyReward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WISHPOOL_FISHING, handler(self, self._onFishingSuccess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)

	self._runScheduler = self._runScheduler or self:newSchedule(handler(self, self._doRun), 0)

	self:updateTime()
	self:_onWishPoolFlush()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_dailyRewardBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_fishingBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_fishingTenBtn,
		customData = {
			num = 10
		}
	})
end

function ActivityWishpoolLayer:_onCrossDayUpdate()
	if not var_0_0:isShowEntrance() then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	else
		g.core.network.GameNetProxy:send_C2S_Wishpool_Flush({})
	end
end

function ActivityWishpoolLayer:updateTime(arg_5_1)
	local var_5_0 = g.core.common.ServerTime:getTime()

	if not self._lastUpdateTime or self._lastUpdateTime ~= var_5_0 then
		self._lastUpdateTime = var_5_0

		local var_5_1 = var_0_0:getEndTime() - var_5_0
		local var_5_2
		local var_5_3
		local var_5_4

		if var_5_1 >= 0 then
			var_5_2 = math.floor(var_5_1 / 86400)
			var_5_3 = math.floor((var_5_1 - var_5_2 * 86400) / 3600)
			var_5_4 = math.floor((var_5_1 - var_5_2 * 86400 - var_5_3 * 3600) / 60)
		else
			var_5_2 = 0
			var_5_3 = 0
			var_5_4 = 0
		end

		self.m_lastTimeTxt:setText(g.core.lang:get(409008, {
			day = var_0_1(2, var_5_2),
			hour = var_0_1(2, var_5_3),
			min = var_0_1(2, var_5_4)
		}))
	end
end

function ActivityWishpoolLayer:addFish(arg_6_1)
	local var_6_0 = fgui.UIPackage:createObject("activity", "ActivityFishComp")

	var_6_0:setFishStyle(arg_6_1)
	var_6_0:setReverse(math.random(1, 2) > 1)
	self.m_center:addChild(var_6_0)
	var_6_0:setPosition(math.random(100, self._centerSize.width - 100), math.random(0, self._centerSize.height))
	var_6_0:fishIdle()
	table.insert(self._fishPool, var_6_0)

	return var_6_0
end

function ActivityWishpoolLayer:fishAllOut(arg_7_1)
	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(self._fishPool) do
			iter_7_1:fishIn()
		end
	else
		for iter_7_2, iter_7_3 in ipairs(self._fishPool) do
			iter_7_3:fishOut()
		end
	end
end

function ActivityWishpoolLayer:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "FISH_OUT_FINISH" then
		self:fishMoveIn()

		return true
	elseif arg_8_1 == "EVENT_FISH_BE_GET" then
		if not self._removeFishIndex or not self._fishPool[self._removeFishIndex] then
			return
		end

		if self:isCurIndexFishNeedRemove() then
			self._removeFishIndex = nil

			table.remove(self._fishPool, self._removeFishIndex):runFGAction((fgui.FSequence:create(fgui.FFadeOut:create(0.3), fgui.FCallFunc:create(handler(self, self.onShowFishingAward)), fgui.FRemoveSelf:create())))
		else
			local var_8_0 = self._fishPool[self._removeFishIndex]

			self._fishPool[self._removeFishIndex]:runFGAction((fgui.FSequence:create(fgui.FFadeOut:create(0.3), (fgui.FCallFunc:create(handler(self, self.onShowFishingAward))))))
			var_8_0:setMoveStop()
		end

		self._fishRobEff:setAnimation(0, "out", false)
		self._fishRobEff:addSpineEventListener(handler(self, self._onFinishEventFish))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_Bite)
	end

	return false
end

function ActivityWishpoolLayer:getDropFishNum(arg_9_1)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(self._fishPool) do
		if iter_9_1:checkIsMyType(arg_9_1) then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function ActivityWishpoolLayer:isCurIndexFishNeedRemove()
	if not self._removeFishIndex or not self._fishPool[self._removeFishIndex] then
		return false
	end

	if not self._rewardFishContent or not self._rewardFishContent.drop_id then
		return var_0_0:isCurFishNeedRemove()
	end

	if #self._rewardFishContent.drop_id <= 1 then
		return var_0_0:isCurFishNeedRemove()
	else
		local var_10_0 = self._fishPool[self._removeFishIndex]:getDropId()

		return var_0_0:isDropFishNeedRemove(var_10_0, (self:getDropFishNum(var_10_0)))
	end
end

function ActivityWishpoolLayer:updateFishPool()
	if not self._rewardFishContent or not self._rewardFishContent.drop_id or #self._rewardFishContent.drop_id <= 1 then
		return
	end

	for iter_11_0 = 1, #self._rewardFishContent.drop_id do
		if var_0_0:isDropFishNeedRemove(self._rewardFishContent.drop_id[iter_11_0], (self:getDropFishNum(self._rewardFishContent.drop_id[iter_11_0]))) then
			for iter_11_1, iter_11_2 in ipairs(self._fishPool) do
				if iter_11_2:checkIsMyType(self._rewardFishContent.drop_id[iter_11_0]) then
					table.remove(self._fishPool, iter_11_1):runFGAction((fgui.FSequence:create(fgui.FFadeOut:create(0.2), fgui.FRemoveSelf:create())))

					break
				end
			end
		end
	end
end

function ActivityWishpoolLayer:checkCanChangeState()
	if self._lastClickPos then
		g.core.module.ModuleManager:tip(g.core.lang:get(409011))

		return false
	end

	return true
end

function ActivityWishpoolLayer:checkInFishingOutAndIn()
	if self._removeFishIndex then
		table.remove(self._fishPool, self._removeFishIndex):removeSelf()
	end

	self:onShowFishingAward()

	self._lastClickPos = nil
end

function ActivityWishpoolLayer:onFishFastMove()
	local var_14_0 = false
	local var_14_1 = self:getBestFishInDropList(self._rewardFishContent.drop_id)

	for iter_14_0, iter_14_1 in ipairs(self._fishPool) do
		if iter_14_1:checkIsMyType(var_14_1) and not var_14_0 then
			self._removeFishIndex = iter_14_0
			var_14_0 = true

			if iter_14_1:isStop() then
				iter_14_1:runFGAction((fgui.FFadeIn:create(0.2)))
				iter_14_1:fishReborn()
			end

			iter_14_1:setFishVictim()
		end

		iter_14_1:fishSpeedFast()
	end

	if not var_14_0 then
		local var_14_2 = self:addFish(var_14_1)

		var_14_2:setPosition(self._centerSize.width - 800, self._centerSize.height - 400)
		var_14_2:setFishVictim()
		var_14_2:fishSpeedFast()

		self._removeFishIndex = #self._fishPool
	end
end

function ActivityWishpoolLayer:getBestFishInDropList(arg_15_1)
	local var_15_0 = arg_15_1[1]

	for iter_15_0 = 1, #arg_15_1 do
		local var_15_1 = g.core.config.wishpool_drop_info.get(arg_15_1[iter_15_0])
		local var_15_2

		if 99 > var_15_1.fish_appear then
			var_15_2 = var_15_1.fish_appear
			var_15_0 = arg_15_1[iter_15_0]
		end
	end

	return var_15_0
end

function ActivityWishpoolLayer:onFishAllOut()
	self:fishMoveIn()
end

function ActivityWishpoolLayer:fishMoveIn()
	if not self._rewardFishContent then
		return
	end

	if not self._removeFishIndex or not self._fishPool[self._removeFishIndex] then
		return
	end

	self._fishPool[self._removeFishIndex]:fishMoveToPos(self._lastClickPos)

	for iter_17_0, iter_17_1 in ipairs(self._fishPool) do
		iter_17_1:fishSpeedNormal()
	end
end

function ActivityWishpoolLayer:_doRun(arg_18_1)
	self:updateTime(arg_18_1)

	for iter_18_0, iter_18_1 in ipairs(self._fishPool) do
		iter_18_1:doRun(arg_18_1)
	end
end

function ActivityWishpoolLayer:updateComp(arg_19_1)
	self.m_inFishingController:setSelectedIndex(0)
	self.m_fishingRodHolder:setVisible(false)
	g.core.network.GameNetProxy:send_C2S_Wishpool_Flush({})
	self.m_clickFishTxt:setText(g.core.lang:get(409014))
	self:checkInFishingOutAndIn()
end

function ActivityWishpoolLayer:checkDailyReward()
	local var_20_0 = not var_0_0:isGetDailyReward()

	self.m_dailyRewardBtn:setVisible(var_20_0)
	self.m_animDaily1:setVisible(var_20_0)
	self.m_animDaily2:setVisible(var_20_0)

	if var_20_0 then
		self.m_rewardTransition:play(-1, 0)
	end
end

function ActivityWishpoolLayer:updateView()
	self.m_skipAnimController:setSelectedIndex(var_0_0:isSkipAnim() and 1 or 0)
	self.m_fishPoolBtn:updateFishNum()
	self:checkDailyReward()
	self.m_fishNumTxt:setText(g.core.lang:get(409006, {
		num = var_0_0:getLastFishNum()
	}))

	local var_21_0 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT)

	self.m_yuerNumTxt:setText(var_21_0 .. "/1")

	local var_21_1 = math.min(10, var_0_0:getLastFishNum())

	self.m_yuerNumTxt2:setText(var_21_0 .. "/" .. var_21_1)

	if #self._fishPool == 0 then
		self.m_havFishController:setSelectedIndex(1)
	else
		self.m_havFishController:setSelectedIndex(0)
	end

	if var_21_0 >= var_0_0:getActCfg().bait_num then
		self.m_fishingBtn:setCtrlState("state", {
			index = 0
		})
	else
		self.m_fishingBtn:setCtrlState("state", {
			index = 1
		})
	end

	self.m_fishingTenBtn:setCtrlState("state", {
		index = var_21_1 <= var_21_0 and 0 or 1
	})
	self.m_progressComp:updateProgressComp()
end

function ActivityWishpoolLayer:_onGetDailyReward()
	if not var_0_0:isGetDailyReward() then
		g.core.network.GameNetProxy:send_C2S_Wishpool_DailyPresents({})
	end
end

function ActivityWishpoolLayer:_onFishPoolClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.activity.view.activityWishpool.ActivityFishPoolPop").new(), {
		touchDisappear = true
	})
end

function ActivityWishpoolLayer:_onStartFishing()
	if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT) >= var_0_0:getActCfg().bait_num and #self._fishPool > 0 then
		self._isFishingTen = false

		if var_0_0:isSkipAnim() then
			g.core.network.GameNetProxy:send_C2S_Wishpool_Fishing({
				num = 1
			})

			return
		end

		self.m_inFishingController:setSelectedIndex(1)
		self.m_clickFishTxt:setText(g.core.lang:get(409015))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RodClick)
	elseif #self._fishPool > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(409021))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(409009))
	end
end

function ActivityWishpoolLayer:_onStartFishingTen()
	local var_25_0 = math.min(10, var_0_0:getLastFishNum())

	if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT) < var_25_0 then
		if var_25_0 > 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(409021))
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(409009))
		end

		return
	end

	if var_25_0 <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(409009))

		return
	end

	self._isFishingTen = true

	if var_0_0:isSkipAnim() then
		g.core.network.GameNetProxy:send_C2S_Wishpool_Fishing({
			num = var_25_0
		})

		return
	end

	self.m_inFishingController:setSelectedIndex(1)
	self.m_clickFishTxt:setText(g.core.lang:get(409015))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RodClick)
end

function ActivityWishpoolLayer:_onClickFishing(arg_26_1)
	if self._lastClickPos then
		g.core.module.ModuleManager:tip(g.core.lang:get(409011))

		return
	end

	local var_26_0 = arg_26_1:getInput():getPosition()

	self._lastClickPos = var_26_0

	local var_26_1 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT)

	if var_26_1 >= var_0_0:getActCfg().bait_num and #self._fishPool > 0 or (self._isFishingTen or nil) and var_26_1 >= math.min(10, var_0_0:getLastFishNum()) then
		if self._isFishingTen then
			g.core.network.GameNetProxy:send_C2S_Wishpool_Fishing({
				num = math.min(10, var_0_0:getLastFishNum())
			})
		else
			g.core.network.GameNetProxy:send_C2S_Wishpool_Fishing({
				num = 1
			})
		end

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
		self.m_fishingRodHolder:setPosition(var_26_0)
		self._fishRobEff:addSpineEventListener(handler(self, self._onStartEventFish))
	elseif #self._fishPool > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(409021))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(409009))
	end
end

function ActivityWishpoolLayer:_onClickInValidFishing()
	g.core.module.ModuleManager:tip(g.core.lang:get(409012))
end

function ActivityWishpoolLayer:_onClickSkipAnim()
	var_0_0:setSkipAnimState()
end

function ActivityWishpoolLayer:_onStartEventFish(arg_29_1)
	if arg_29_1.type == "complete" then
		self._fishRobEff:setAnimation(0, "idle", true)
		self._fishRobEff:addSpineEventListener()
	end
end

function ActivityWishpoolLayer:_onFinishEventFish(arg_30_1)
	if arg_30_1.type == "complete" then
		self._fishRobEff:addSpineEventListener()
	end
end

function ActivityWishpoolLayer:_onWishPoolFlush(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	if not self._addFish then
		self._addFish = true

		for iter_31_0, iter_31_1 in pairs((var_0_0:getCurrentAllShowFish())) do
			if iter_31_1 > 0 then
				for iter_31_2 = 1, iter_31_1 do
					self:addFish(iter_31_0)
				end
			end
		end
	end

	self:updateView()
end

function ActivityWishpoolLayer:_onDailyReward(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	self:checkDailyReward()
	g.core.module.ModuleManager:awardSummary(arg_32_4.awards)
	self:updateView()
end

function ActivityWishpoolLayer:_onFishingSuccess(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	self._isFishingTen = false

	self.m_fishPoolBtn:setDescFishId(arg_33_4.drop_id)

	self._rewardFishContent = arg_33_4

	if var_0_0:isSkipAnim() then
		self:onShowFishingAward()

		return
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_Fishing)
	self:onFishFastMove()
end

function ActivityWishpoolLayer:onShowFishingAward()
	if not self._rewardFishContent then
		return
	end

	if #self._rewardFishContent.drop_id == 1 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.activityWishpool.ActivityWishpoolRewardPop").new({
			drop_id = self._rewardFishContent.drop_id,
			awards = self._rewardFishContent.awards,
			exitFunc = handler(self, self.resetFishingPage)
		})))
	else
		g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.activityWishpool.ActivityWishpoolTenRewardPop").new({
			drop_id = self._rewardFishContent.drop_id,
			awards = self._rewardFishContent.awards,
			exitFunc = handler(self, self.resetFishingPage)
		})))
	end

	self.m_fishNumTxt:setText(g.core.lang:get(409006, {
		num = var_0_0:getLastFishNum()
	}))

	local var_34_0 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT)

	self.m_yuerNumTxt:setText(var_34_0 .. "/1")
	self.m_yuerNumTxt2:setText(var_34_0 .. "/" .. math.min(10, var_0_0:getLastFishNum()))

	if self._removeFishIndex and self._fishPool[self._removeFishIndex] then
		local var_34_1 = self._fishPool[self._removeFishIndex]

		self._fishPool[self._removeFishIndex]:runFGAction((fgui.FFadeIn:create(0.5)))
		var_34_1:setReverse(math.random(1, 2) > 1)
		var_34_1:setPosition(math.random(100, self._centerSize.width - 100), math.random(0, self._centerSize.height))
		var_34_1:fishReborn()

		self._removeFishIndex = nil
	end

	self:updateFishPool()

	self._rewardFishContent = nil
end

function ActivityWishpoolLayer:resetFishingPage()
	self.m_fishPoolBtn:updateFishNum()
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
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_fishingTenBtn,
		customData = {
			num = 10
		}
	})

	local var_35_0 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT)
	local var_35_1, var_35_2

	if var_35_0 >= var_0_0:getActCfg().bait_num then
		self.m_fishingBtn:setCtrlState("state", {
			index = 0
		})
	else
		self.m_fishingBtn:setCtrlState("state", {
			index = 1
		})

		var_35_1 = "state"
		var_35_2 = {}
	end

	var_35_2.index = math.min(10, var_0_0:getLastFishNum()) <= var_35_0 and 0 or 1

	self.m_fishingTenBtn:setCtrlState(var_35_1, var_35_2)
	self.m_clickFishTxt:setText(g.core.lang:get(409014))

	self._lastClickPos = nil
end

function ActivityWishpoolLayer:onUnload()
	if self:isCurIndexFishNeedRemove() then
		table.remove(self._fishPool, self._removeFishIndex):removeSelf()

		self._removeFishIndex = nil
	else
		self.m_fishNumTxt:setText(g.core.lang:get(409006, {
			num = var_0_0:getLastFishNum()
		}))

		local var_36_0 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT)

		self.m_yuerNumTxt:setText(var_36_0 .. "/1")
		self.m_yuerNumTxt2:setText(var_36_0 .. "/" .. math.min(10, var_0_0:getLastFishNum()))

		if self._removeFishIndex and self._fishPool[self._removeFishIndex] then
			local var_36_1 = self._fishPool[self._removeFishIndex]

			self._fishPool[self._removeFishIndex]:runFGAction((fgui.FFadeIn:create(0.5)))
			var_36_1:setReverse(math.random(1, 2) > 1)
			var_36_1:setPosition(math.random(100, self._centerSize.width - 100), math.random(0, self._centerSize.height))
			var_36_1:fishReborn()

			self._removeFishIndex = nil
		end
	end

	self:resetFishingPage()
	self:updateFishPool()

	local var_36_2 = self._rewardFishContent

	if self._rewardFishContent then
		self._rewardFishContent = nil

		g.core.common.Scheduler:newScheduleOnce(function()
			if #var_36_2.drop_id == 1 then
				g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.activityWishpool.ActivityWishpoolRewardPop").new(var_36_2)))
			else
				g.core.module.ModuleManager:pushPopup((require("app.view.module.activity.view.activityWishpool.ActivityWishpoolTenRewardPop").new(var_36_2)))
			end
		end, 0)
	end

	self:cancelAllSchedule()

	self._runScheduler = nil
end

return ActivityWishpoolLayer
