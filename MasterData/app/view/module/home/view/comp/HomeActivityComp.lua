local var_0_0 = g.core.const.ConstMgr.RecruitConst
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.module.ModuleManager
local HomeConst = require("app.view.module.home.const.HomeConst")
local var_0_6 = g.core.model.User
local HomeActivityComp = class("HomeActivityComp", require("app.fairyGUI.home.UI_HomeActivityComp"))

function HomeActivityComp:ctor()
	self._activityList = {}

	self:_initBtn()
	self:_initListView()
end

function HomeActivityComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_CHECK_DAILY_COST, self._onCheckDailyCostGuide, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_UPRETE_HOME_ACTIVITY_LIST, self._onUpdateFirstRechargeBtn, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETFIRSTRECHARGEAWARD, handler(self, self._checkFirstChargeVisible), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.LAST_PHOENIX_GIFT, handler(self, self._checkPhoenixVisible), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.PHOENIX_REFRESH_NEW_GIFT, handler(self, self._refreshPhoenixRedPoint), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_INFO, handler(self, self.updateData), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MAIN_TASK_GETAWARD, handler(self, self.updateMainQuestShowState), self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_activityBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_firstRechargeBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_dailyRecruitBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_phoenixGiftBtn
	})
	self:checkBtnVisible()
	self:updateData()

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WEEKLY_COMPETITION) and not var_0_6.weeklyCompetitionMgrData:hasReqInfo() then
		g.core.network.GameNetProxy:send_C2S_WeeklyCompetition_Info({})
	end
end

function HomeActivityComp:_refreshPhoenixRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_phoenixGiftBtn
	})
end

function HomeActivityComp:onUnload()
	if var_0_6.sevenDaysData and var_0_6.sevenDaysData:isShow7DaysActivity(var_0_1.FUNCTION_TYPE.SEVEN_DAYS_ACTIVITY) then
		var_0_6.functionUnlockData:saveUnlockedFunc(var_0_1.FUNCTION_TYPE.SEVEN_DAYS_ACTIVITY)
	end

	if var_0_6.sevenDaysData and var_0_6.sevenDaysData:isShow7DaysActivity(var_0_1.FUNCTION_TYPE.SEVEN_DAYS_ACTIVITY_2) then
		var_0_6.functionUnlockData:saveUnlockedFunc(var_0_1.FUNCTION_TYPE.SEVEN_DAYS_ACTIVITY_2)
	end

	if self._schedule then
		self:cancelSchedule(self._schedule)

		self._schedule = nil
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function HomeActivityComp:_initBtn()
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_hotSaleBtn:addClickListener(handler(self, self._onHotSaleBtnClick))
	self.m_activityBtn:addClickListener(handler(self, self._onActivityBtnClick))
	self.m_firstRechargeBtn:addClickListener(handler(self, self._onFirstRechargeBtnClick))
	self.m_dailyRecruitBtn:addClickListener(handler(self, self._onDailyRecruitClick))
	self.m_phoenixGiftBtn:addClickListener(handler(self, self._onPhoenixGiftClick))
end

function HomeActivityComp:_initListView()
	self:addListen(self.m_activityList)
	self.m_activityList:setVirtual()
	self.m_activityList:setScrollLimit(true)
	self.m_activityList:setItemRenderer(handler(self, self._onRenderActivityList))
	self.m_activityList:doFairyBatching(false)
end

function HomeActivityComp:_checkFirstChargeVisible()
	local var_7_0 = var_0_6.firstRechargeData:isShowActivity()

	self.m_firstRechargeBtn:setVisible(var_7_0)
	self:checkSpeWeakGuide(var_7_0)
	self:_checkPhoenixVisible()
end

function HomeActivityComp:_checkPhoenixVisible()
	local var_8_0 = var_0_6.phoenixGiftData:isShowEntrance()
	local var_8_1, var_8_2 = var_0_6.phoenixGiftData:getHomeEntranceIconAndName()

	self.m_phoenixGiftBtn:setIcon(var_8_1)
	self.m_phoenixGiftBtn:setTitle(var_8_2)
	self.m_phoenixGiftBtn:setVisible(var_8_0)

	if var_8_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_phoenixGiftBtn
		})
		self:checkPhoenixSpeWeakGuide()
		self:_refreshPhoenixRedPoint()
	end
end

function HomeActivityComp:checkBtnVisible()
	local var_9_0 = var_0_3:isModuleUnlock(var_0_2.PLAY_SHOP)

	self.m_shopBtn:setVisible(var_9_0)

	if var_9_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_shopBtn
		})
	end

	self.m_activityBtn:setVisible((var_0_3:isModuleUnlock(var_0_2.ACTIVITY)))
	self:_checkFirstChargeVisible()

	local var_9_1 = var_0_3:isModuleUnlock(var_0_2.HOT_SELLING)

	self.m_hotSaleBtn:setVisible(var_9_1)

	if var_9_1 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_hotSaleBtn
		})
	end

	self.m_dailyRecruitBtn:setVisible(var_0_6.recruitData:hasDailyRecruitRed())
	self:_checkPhoenixVisible()
end

function HomeActivityComp:_setPhoenixGiftInvisible()
	self.m_phoenixGiftBtn:setVisible(false)
end

function HomeActivityComp:updateData()
	var_0_6.homeData:updateActivityList()

	self._activityList = var_0_6.homeData:getActivityList()

	self.m_activityList:setNumItems(#self._activityList)
end

function HomeActivityComp:_onRenderActivityList(arg_12_1, arg_12_2)
	arg_12_2:updateCell(self._activityList[arg_12_1 + 1])
end

function HomeActivityComp:checkSpeWeakGuide(arg_13_1)
	if arg_13_1 and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.FIRST_RECHARGE_ENTER) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_FIRST_RECHARGE",
			targetBtn = self.m_firstRechargeBtn
		})
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK_WAR_ORDER)
end

function HomeActivityComp:checkPhoenixSpeWeakGuide(arg_14_1)
	if not arg_14_1 then
		-- block empty
	end

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.PHOENIX_GIFT_ENTERED) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "PHOENIX_GIFT_ENTERED",
			targetBtn = self.m_phoenixGiftBtn
		})
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK_WAR_ORDER)
end

function HomeActivityComp:_onCheckDailyCostGuide()
	if var_0_3:isModuleUnlock(var_0_2.ACTIVITY) then
		local var_15_0 = false

		for iter_15_0, iter_15_1 in ipairs((g.core.model.User.activityMainLayerData:getSortedActivityDataList())) do
			if iter_15_1:getFunctionId() == var_0_2.DAILY_BOX then
				var_15_0 = true

				break
			end
		end

		if var_15_0 and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.FIRST_DAILY_COST_ENTER) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "GUIDE_DAILY_COST_STEP_1",
				targetBtn = self.m_activityBtn
			})
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK_ONLINE_GIFT)
end

function HomeActivityComp:_onUpdateFirstRechargeBtn()
	self.m_firstRechargeBtn:setVisible((var_0_6.firstRechargeData:isShowActivity()))
end

function HomeActivityComp:_onShopBtnClick()
	if var_0_3:checkModuleUnlockStatus(var_0_2.PLAY_SHOP, nil, true) then
		var_0_4:pushModule(g.view.entrance.SHOP)
	end
end

function HomeActivityComp:_onHotSaleBtnClick()
	var_0_4:pushModule(g.view.entrance.RECHARGE, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.HOT_TAB_TYPE
	})
end

function HomeActivityComp:_onActivityBtnClick()
	if var_0_3:checkModuleUnlockStatus(var_0_2.ACTIVITY, nil, true) then
		var_0_4:pushModule(g.view.entrance.ACTIVITY)
	end
end

function HomeActivityComp:_onFirstRechargeBtnClick()
	if var_0_3:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_FIRST_RECHARGE) then
		var_0_4:pushModule(g.view.entrance.NEW_FIRST_RECHARGE)
	end
end

function HomeActivityComp:_onDailyRecruitClick()
	if var_0_3:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_RECRUIT) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT, {
			route1 = 6,
			route2 = var_0_0.RECRUIT_TYPE.DAILY_RECRUIT
		})
	end
end

function HomeActivityComp:_onPhoenixGiftClick()
	if var_0_3:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PHOENIX_GIFT) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PHOENIX_GIFT)
	end
end

function HomeActivityComp:updateActivityBtnRed()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_activityBtn
	})
end

function HomeActivityComp:updateMainQuestShowState()
	self.m_isShowMainQuestController:setSelectedIndex(g.core.model.User.homeData:isShowMainQuest() and 1 or 0)
end

return HomeActivityComp
