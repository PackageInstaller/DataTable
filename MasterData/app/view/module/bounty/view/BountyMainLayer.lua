local var_0_0 = g.core.const.ConstMgr.BountyConst
local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local BountyMainLayer = class("BountyMainLayer", require("app.fairyGUI.bounty.UI_BountyMainLayer"), function()
	return fgui.GComponent:create({
		resName = "BountyMainLayer",
		pkgPath = "ui/bounty/bounty",
		isFullScreen = true,
		pkgName = "bounty"
	}, ...)
end)

function BountyMainLayer:ctor()
	self._monsterList = {}
	self._selectIdx = 0
	self._replaceTimer = nil

	self:_initView()
end

function BountyMainLayer:_initView()
	self:_initBtn()
	self.m_monsterList:setVirtual(self)
	self.m_monsterList:setItemRenderer(handler(self, self._onRenderMonsterList))
	self.m_monsterList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onMonsterListClickItem))
	self.m_topBarComp:setResInfoById(328)
	g.core.model.User.bountyData:saveNewActivityBounty()
	self:addBg("bg/bounty/bg_sjls_zhujiemian.jpg", true)
	self.m_switchTransition:setHook("finish", handler(self, self._onTempCellShowOver))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
end

function BountyMainLayer:_initBtn()
	self.m_normalBtn:addClickListener(handler(self, self._onNormalClick))
	self.m_specialBtn:addClickListener(handler(self, self._onSpecialClick))
	self.m_pointBtn:addClickListener(handler(self, self._onPointClick))
	self.m_rankBtn:addClickListener(handler(self, self._onRankClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskClick))
	self.m_giftBtn:addClickListener(handler(self, self._onGiftClick))
	self.m_shareListLoader:addClickListener(handler(self, self._onShareListClick))
end

function BountyMainLayer:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETINFO, self.updateLayer, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_FINDMONSTER, handler(self, self._onS2CBountyFindMonster), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_CHALLENGEFINISH, self.updateLayer, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_SHAREMONSTER, self._onS2CBountyShareMonster, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayRefresh), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFREEGIFTAWARD, self.updateLayer, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self.updateLayer), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_TASKAWARD, handler(self, self.updateLayer), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_STORY_END, self._onStoryEnd, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.BOUNTY_SUMMON_WEEK_GUIDE_END, self._checkTipsGuide2, self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_pointBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_giftBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_shareRedPointComp
	})
end

function BountyMainLayer:onLoad()
	self:_addCustomListener()
	self:checkChallengeResult()
	self:updateLayer()
	self.m_enterTransition:play()
	self.m_monsterList:transitionShowCells("enter_left", 0.03)
	self.m_pointBtn:setVisible(g.core.common.ServerTime:getDeltaDays(g.core.model.User.bountyData:getActivityTimeInfo().startTime, g.core.common.ServerTime:getTime()) >= 1)
	self:newSchedule(handler(self, self.updateTime), 1)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_GuiwangBoss)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function BountyMainLayer:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_FINISH)
end

function BountyMainLayer:_onStoryEnd()
	self:_checkTipsGuide()
end

function BountyMainLayer:_checkTipsGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	local var_9_0 = g.core.const.ConstMgr.GuideConst
	local var_9_1 = self:getChild("n36")

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.BOUNTY_SUMMON_WEEK_GUIDE) then
		g.core.model.User.guideData:setSaveServerData(var_9_0.SAVE_SERVER_DATA_IDS.BOUNTY_SUMMON_WEEK_GUIDE)
		self:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "BOUNTY_SUMMON_WEEK_GUIDE",
				objects = {
					var_9_1
				}
			})
		end, 0)
	end
end

function BountyMainLayer:_checkTipsGuide2()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	local var_11_0 = g.core.const.ConstMgr.GuideConst
	local var_11_1 = self:getChild("n35")

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.BOUNTY_BTN_WEEK_GUIDE) then
		g.core.model.User.guideData:setSaveServerData(var_11_0.SAVE_SERVER_DATA_IDS.BOUNTY_BTN_WEEK_GUIDE)
		self:newScheduleOnce(function()
			g.core.service.ServiceManager:getServiceByName("TipGuideService"):reset()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "BOUNTY_BTN_WEEK_GUIDE",
				objects = {
					var_11_1
				}
			})
		end, 0)
	end
end

function BountyMainLayer:updateLayer()
	local var_13_0 = g.core.model.User.bountyData:getCurStage()

	if var_13_0 == g.core.const.ConstMgr.BountyConst.ACTIVITY_STATE.RESULT then
		self._replaceTimer = self._replaceTimer or self:newScheduleOnce(handler(self, self.replaceToPeriodLayer), 0.5)

		return
	elseif var_13_0 == g.core.const.ConstMgr.BountyConst.ACTIVITY_STATE.NOT_OPEN then
		self._replaceTimer = self._replaceTimer or self:newScheduleOnce(handler(self, self.replaceToHomeLayer), 0.5)

		return
	end

	self:_updateList()
	self:_updateSelectMonster()
	self:_updateDate()
	self:_updateCost()
	self:_updateShareList()
end

function BountyMainLayer:_updateList()
	self._monsterList = g.core.model.User.bountyData:getMyMonsterList()

	self.m_monsterList:setNumItems(#self._monsterList)
end

function BountyMainLayer:_updateSelectMonster()
	if #self._monsterList > 0 then
		self._selectIdx = math.min(self._selectIdx, #self._monsterList - 1)

		self.m_monsterList:setSelectedIndex(self._selectIdx)
		self:_onMonsterListClickItem()
		self.m_isEmptyController:setSelectedIndex(0)
	else
		self.m_monsterComp:updateCompByStruct(nil)
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function BountyMainLayer:_updateDate()
	local var_16_0 = g.core.model.User.bountyData:getActivityTimeInfo()

	self.m_dateText:setText(g.core.lang:get(422024, {
		startDate = g.core.common.ServerTime:getDateMDHMFormat(var_16_0.startTime),
		endDate = g.core.common.ServerTime:getDateMDHMFormat(var_16_0.endTime)
	}))
end

function BountyMainLayer:_updateCost()
	local var_17_0 = {}

	var_17_0.isCanRecruit = false
	var_17_0.goods = g.core.model.User.bountyData:getSummonCostByType(var_0_0.MONSTER_SUMMON_TYPE.LOW)

	self.m_normalBtn:updateView(var_17_0)

	local var_17_1 = {}

	var_17_1.isCanRecruit = false
	var_17_1.goods = g.core.model.User.bountyData:getSummonCostByType(var_0_0.MONSTER_SUMMON_TYPE.HIGH)

	self.m_specialBtn:updateView(var_17_1)
end

function BountyMainLayer:_updateShareList()
	self.m_shareRwdIcon:setURL((g.core.common.Path:getIconByTypeValue(var_0_0.SHARE_RWD_GOOD.TYPE, var_0_0.SHARE_RWD_GOOD.VALUE, true)))

	local var_18_0 = g.core.model.User.bountyData:getHelpScore() or 0

	self.m_shareNumText:setText(g.core.lang:get(500135, {
		cur = var_18_0,
		max = g.core.model.User.bountyData:getHelpScoreLimit()
	}))
end

function BountyMainLayer:updateTime()
	for iter_19_0, iter_19_1 in ipairs((self.m_monsterList:getChildren())) do
		iter_19_1:updateTimeTxt()
	end

	if self._needSync then
		self:_onCrossDayRefresh()

		self._needSync = false
	end
end

function BountyMainLayer:_onRenderMonsterList(arg_20_1, arg_20_2)
	arg_20_2:updateMonsterCell(self._monsterList[arg_20_1 + 1], arg_20_1)
end

function BountyMainLayer:_onMonsterListClickItem(arg_21_1)
	local var_21_0 = self._selectIdx == self.m_monsterList:getSelectedIndex()

	self._selectIdx = self.m_monsterList:getSelectedIndex()

	if arg_21_1 and not var_21_0 then
		self:_onTempCellShowOver()
		self.m_monsterComp:playSwitchEffect(self._monsterList[self._selectIdx + 1])
		self._monsterList[self._selectIdx + 1]:setIsNew(false)
		self:_onUpdateMonsterCell(self._selectIdx)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_CardFade)
	else
		self.m_monsterComp:updateCompByStruct(self._monsterList[self._selectIdx + 1])
	end
end

function BountyMainLayer:_onUpdateMonsterCell(arg_22_1)
	self.m_monsterList:getChildAt((self.m_monsterList:itemIndexToChildIndex(arg_22_1))):updateMonsterCell(self._monsterList[self._selectIdx + 1], arg_22_1)
end

function BountyMainLayer:_onCrossDayRefresh(arg_23_1, arg_23_2, arg_23_3)
	g.core.network.GameNetProxy:send_C2S_Bounty_GetInfo({})
end

function BountyMainLayer:onClickShareCurMonster()
	self.m_monsterComp:shareCurMonster()
end

function BountyMainLayer:receiveCompEvent(arg_25_1, arg_25_2)
	if arg_25_1 == "bounty_battle_error" then
		self:_onCrossDayRefresh()

		return true
	elseif arg_25_1 == "monster_time_end" then
		self._needSync = true

		return true
	end
end

function BountyMainLayer:_onShareTipClickNotify(arg_26_1)
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_BOUNTY_SHARE, arg_26_1)
end

function BountyMainLayer:_playSummonEffect()
	self.m_tempCell:updateMonsterCell(self._monsterList[1], 0)
	self.m_monsterComp:playSummonEffect()
	self:_setCellOpacity(0, 1)
	self.m_monsterList:scrollToView(math.min(1, #self._monsterList - 1), false, true)
	self.m_monsterList:getScrollPane():setPosY(0, true)
	self.m_switchTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Menu_Slide_01)
end

function BountyMainLayer:_onTempCellShowOver()
	self:_setCellOpacity(255)
	self.m_tempCell:setOpacity(0)
end

function BountyMainLayer:_setCellOpacity(arg_29_1, arg_29_2)
	for iter_29_0, iter_29_1 in ipairs((self.m_monsterList:getChildren())) do
		if not arg_29_2 or self.m_monsterList:childIndexToItemIndex(iter_29_0) == arg_29_2 then
			if arg_29_1 == 0 then
				iter_29_1:setVisible(false)
				iter_29_1:newScheduleOnce(handler(iter_29_1, function(arg_30_0)
					arg_30_0:setOpacity(arg_29_1)
					arg_30_0:setVisible(true)
				end), 0.2)
			else
				iter_29_1:cancelAllSchedule()
				iter_29_1:setOpacity(arg_29_1)
				iter_29_1:setVisible(true)
			end
		end
	end
end

function BountyMainLayer:replaceToPeriodLayer()
	self:cancelAllSchedule()

	self._replaceTimer = nil

	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:replaceModule(g.view.entrance.BOUNTY_PERIOD)
end

function BountyMainLayer:replaceToHomeLayer()
	self:cancelAllSchedule()

	self._replaceTimer = nil

	g.core.module.ModuleManager:popAllPopup()
	g.core.module.ModuleManager:replaceModule(g.view.entrance.HOME)
end

function BountyMainLayer:_onS2CBountyShareMonster(arg_33_1, arg_33_2, arg_33_3)
	self:_updateSelectMonster()
	self:_updateList()
end

function BountyMainLayer:_onS2CBountyFindMonster(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	self:updateLayer()
	self.m_monsterList:scrollToView(0, false, true)
	self.m_monsterList:setSelectedIndex(0)
	self:_onMonsterListClickItem()
	self:_playSummonEffect()
end

function BountyMainLayer:checkChallengeResult()
	if not g.core.model.User.bountyData:getLastChallengeResult() and not g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_BOUNTY_SHARE) then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(422037),
			confirmText = g.core.lang:get(422039),
			cancelText = g.core.lang:get(422038),
			onConfirm = handler(self, self.onClickShareCurMonster),
			onCancel = function()
				return
			end,
			tip = {
				txt = g.core.lang:get(408110)
			},
			onCheck = handler(self, self._onShareTipClickNotify)
		})))
	end

	g.core.model.User.bountyData:resetLastChallengeResult()
end

function BountyMainLayer:_onNormalClick()
	g.core.network.GameNetProxy:send_C2S_Bounty_FindMonster({
		find_type = var_0_0.MONSTER_SUMMON_TYPE.LOW
	})
end

function BountyMainLayer:_onSpecialClick()
	g.core.network.GameNetProxy:send_C2S_Bounty_FindMonster({
		find_type = var_0_0.MONSTER_SUMMON_TYPE.HIGH
	})
end

function BountyMainLayer:_onPointClick()
	if not g.core.model.User:isJoinGuild() then
		g.core.module.ModuleManager:tip(g.core.lang:get(411025))

		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.bounty.view.BountyDailyPointPop").new()))
end

function BountyMainLayer:_onRankClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.bounty.view.pop.BountyRankPop").new()))
end

function BountyMainLayer:_onShopClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.BOUNTY
	})
end

function BountyMainLayer:_onTaskClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.bounty.view.pop.BountyTaskRewardPop").new()))
end

function BountyMainLayer:_onGiftClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.bounty.view.pop.BountyGiftPop").new({
		title = g.core.lang:get(422560),
		activityValue = g.core.model.User.bountyData:getActivityId(),
		shopValue = g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.BOUNTY_GIFT,
		openCheckFunc = handler(self, function(arg_44_0)
			return g.core.model.User.bountyData:isInActiveTime()
		end)
	})))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Wuzhuang_GetMenuSlide)
end

function BountyMainLayer:_onShareListClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.BOUNTY_SHARE)
end

return BountyMainLayer
