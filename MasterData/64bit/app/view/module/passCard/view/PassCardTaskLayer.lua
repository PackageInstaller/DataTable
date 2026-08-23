local var_0_0 = g.core.model.User
local var_0_1 = g.core.common.Path
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local PassCardTaskLayer = class("PassCardTaskLayer", require("app.fairyGUI.passCard.UI_PassCardTaskLayer"), function()
	return fgui.GComponent:create({
		resName = "PassCardTaskLayer",
		pkgName = "passCard",
		isFullScreen = true,
		pkgPath = "ui/passCard/passCard"
	}, ...)
end)

function PassCardTaskLayer:ctor()
	self.m_topBarComp:setHelpId(g.core.const.ConstMgr.HelpConst.HELP_TYPE.PASS_CARD)
	self.m_buyLevelBtn:addClickListener(handler(self, self._onBuyLevelClick))
	self.m_oneKeyGetBtn:addClickListener(handler(self, self._onOneKeyGetAwardClick))
	self.m_taskList:setVirtual(self)
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onListRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTabItem))

	self._isFirstEnter = true
	self._curTabIndex = 1
	self._taskData = {}
	self._levelUpSpineNode = nil
	self._preLevel = 0

	self:_init()
end

function PassCardTaskLayer:_init()
	local var_3_0 = var_0_0.passCardData:getCardBaseInfo()

	self._passCardBaseData = var_3_0

	if var_3_0.baseInfo.title_small_pic ~= "" then
		self.m_titleIcon:setURL(var_0_1:getPassCardTitlePic(var_3_0.baseInfo.title_small_pic))
	end

	self:addBg((var_3_0.baseInfo.bg ~= "" or nil) and "bg/passCard/" .. var_3_0.baseInfo.bg .. ".jpg")
	self:_initTabRed()
end

function PassCardTaskLayer:_initTabRed()
	self._tabBtns = {}

	for iter_4_0 = 1, self.m_tabList:numChildren() do
		local var_4_0 = self.m_tabList:getChildAt(iter_4_0 - 1)

		if var_4_0 then
			var_4_0:getChild("redPointComp"):setId(187 + iter_4_0 - 1)
			table.insert(self._tabBtns, var_4_0)
		end
	end
end

function PassCardTaskLayer:onLoad()
	self._dailyTaskSchedule = self:newSchedule(handler(self, self._updateDailyCD), 1)
	self._weekTaskSchedule = self:newSchedule(handler(self, self._updateWeekCD), 1)

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PASS_CARD_TASKCOMPLETE, handler(self, self._onRecTaskAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PASS_CARD_BUYLEVEL, handler(self, self._onRecBuyPassCardLevel), self)
	self:_updateView()

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end
end

function PassCardTaskLayer:_updateView()
	if not var_0_0.passCardData:getIsShowPassCard() then
		var_0_0.passCardData:setActivityEnd(true)
		g.core.module.ModuleManager:tip(g.core.lang:get(405002))

		return
	end

	self._taskData = var_0_0.passCardData:getTaskInfoData()

	if self._isFirstEnter then
		self._curTabIndex = var_0_0.passCardData:getCanGetAwardTaskType()
		self._isFirstEnter = false
	end

	self.m_tabList:setSelectedIndex(self._curTabIndex - 1)
	self.m_isShowOneKeyController:setSelectedIndex(var_0_0.passCardData:isCanShowOneKeyTaskBtn() and 1 or 0)
	self.m_isFullLevelController:setSelectedIndex(var_0_0.passCardData:isCardFullLevel() and 1 or 0)
	self.m_isShowBuyLevelController:setSelectedIndex(0)

	if var_0_0.passCardData:isCanShowBuyLevelBtn() then
		self.m_isShowBuyLevelController:setSelectedIndex(1)
	end

	self:_updateProgress()
	self:_updateTaskList()
	self:_updateBottomTime()
	self:_updateTabRedPoint()
end

function PassCardTaskLayer:_updateProgress()
	self.m_levelTxt:setText(var_0_0.passCardData:getLevel())

	local var_7_0 = var_0_0.passCardData:getCurMaxExpByLevel(self._passCardBaseData.level)

	self.m_expProgressComp:setPercent({
		tween = true,
		cur = self._passCardBaseData.exp,
		max = var_7_0
	})
	self.m_expTxt:setText(self._passCardBaseData.exp .. "/" .. var_7_0)

	self._preLevel = self._passCardBaseData.level
end

function PassCardTaskLayer:_updateTaskList()
	self.m_taskList:setNumItems(#(self._taskData[self._curTabIndex] or {}))
	self.m_taskList:transitionShowCells("enter_right", 0.03, 1)
end

function PassCardTaskLayer:_onBuyLevelClick()
	if not var_0_0.passCardData:getIsShowPassCard() then
		g.core.module.ModuleManager:tip(g.core.lang:get(405002))

		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.passCard.view.PassCardBuyLevelPop").new(), {
		touchDisappear = false
	})
end

function PassCardTaskLayer:_onOneKeyGetAwardClick()
	if not var_0_0.passCardData:getIsShowPassCard() then
		g.core.module.ModuleManager:tip(g.core.lang:get(405002))

		return
	end

	local var_10_0 = var_0_0.passCardData:getAllCanGetTaskAwardId()

	if #var_10_0 >= 2 then
		g.core.network.GameNetProxy:send_C2S_PassCard_TaskComplete({
			task_ids = var_10_0
		})
	end
end

function PassCardTaskLayer:_onListRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateTaskItem(self._taskData[self._curTabIndex][arg_11_1 + 1])
end

function PassCardTaskLayer:_onClickTabItem(arg_12_1)
	self._curTabIndex = arg_12_1:getDataValue() + 1

	self:_updateTaskList()
	self:_updateBottomTime()
end

function PassCardTaskLayer:_updateBottomTime()
	self.m_taskTypeController:setSelectedIndex(self._curTabIndex - 1)

	if self._curTabIndex - 1 == 0 then
		self:_updateDailyCD()
	elseif self._curTabIndex - 1 == 1 then
		self:_updateWeekCD()
	end
end

function PassCardTaskLayer:_updateDailyCD()
	local var_14_0 = g.core.common.ServerTime:getTimestampByHMS(24, 0, 0)
	local var_14_1 = g.core.common.ServerTime:getLeftHMSFormat(var_14_0)

	self.m_dailyLeftTimeTxt:setText((MultilingualMgr:getUseLang() ~= "cn" or nil) and g.core.common.ServerTime:getLeftHMSFormatOverseas(var_14_0))
end

function PassCardTaskLayer:_updateWeekCD()
	self.m_weekLeftTimeTxt:setText((g.core.common.ServerTime:getCurWeekCountDown()))
end

function PassCardTaskLayer:_onCrossDayUpdate()
	var_0_0.passCardData:resetTaskDataWhenCrossDay()
	g.core.network.GameNetProxy:send_C2S_PassCard_Info({})
end

function PassCardTaskLayer:_onRecTaskAward(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if arg_17_4 and arg_17_4.awards then
		require("app.view.module.show.ShowFactory"):awardSummary(arg_17_4.awards, false, nil, nil, handler(self, function()
			if (arg_17_4.level or 0) ~= self._preLevel then
				self:_addLevelUpSpine()
			end

			self:_updateView()
		end))
	end
end

function PassCardTaskLayer:_updateTabRedPoint()
	for iter_19_0, iter_19_1 in ipairs(self._tabBtns) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = iter_19_1
		})
	end
end

function PassCardTaskLayer:_onRecBuyPassCardLevel(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(405005))
	g.core.module.ModuleManager:popComponent()
	self:_addLevelUpSpine()
	self:_updateView()
end

function PassCardTaskLayer:onUnload()
	if self._dailyTaskSchedule then
		self._dailyTaskSchedule = nil

		self:cancelSchedule(self._dailyTaskSchedule)
	end

	if self._weekTaskSchedule then
		self._weekTaskSchedule = nil

		self:cancelSchedule(self._weekTaskSchedule)
	end
end

function PassCardTaskLayer:_addLevelUpSpine()
	if self._levelUpSpineNode then
		self._levelUpSpineNode:removeFromParent()

		self._levelUpSpineNode = nil
	end

	self._levelUpSpineNode = self.m_levelUpSpineComp:addEffectSpine({
		anim = "play",
		name = "eff_ui_passCard_levelUp",
		isLoop = false
	})
end

return PassCardTaskLayer
