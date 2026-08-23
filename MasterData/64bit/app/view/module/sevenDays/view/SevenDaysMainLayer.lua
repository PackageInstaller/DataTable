local var_0_0 = g.core.config.unite_token_info
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.SevenDaysConst
local var_0_4 = g.core.const.ConstMgr.SevenDaysConst.INTEGRAL_AWARD_TYPE
local var_0_5 = 1
local var_0_6 = g.core.event.EventManager
local var_0_7 = g.core.common.Path
local var_0_8 = g.core.model.User.sevenDaysData
local var_0_9 = g.core.model.User.knightsData
local var_0_10 = g.core.model.User.resourceData
local var_0_11 = g.core.common.ServerTime
local var_0_12 = g.core.common.Goods
local var_0_13 = g.core.common.GlobalFunc
local SevenDaysMainLayer = class("SevenDaysMainLayer", require("app.fairyGUI.sevenDaysActivity.UI_SevenDaysMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "sevenDaysActivity",
		isFullScreen = true,
		pkgPath = "ui/sevenDaysActivity/sevenDaysActivity",
		resName = "SevenDaysMainLayer"
	}, ...)
end)

function SevenDaysMainLayer:ctor(arg_2_1)
	self._actValue = var_0_8:getActValueByFunId(arg_2_1)
	self._bgLoader = nil
	self._selectedIdxCpp = 0
	self._cdTimer = nil
	self._exeTimerLastTime = 0
	self._dayArr = var_0_8:getDayTabDayArr(self._actValue)
	self._dayTaskStructArr = {}
	self._integralAwardStructArr = {}
	self._specialIntegralAwardStructArr = {}
	self._allAward = {}

	self:_initView()
	self:_updateData()
end

function SevenDaysMainLayer:onLoad()
	var_0_6:addEventListener(var_0_1.EVENT_NET_S2C_NEW_SEVENDAYS_INFO, self._onS2CNewSevenDaysInfo, self)
	var_0_6:addEventListener(var_0_1.EVENT_NET_S2C_NEW_SEVENDAYS_AWARD, self._onS2CNewSevenDaysAward, self)
	var_0_6:addEventListener(var_0_1.EVENT_NET_S2C_NEW_SEVENDAYS_SCOREAWARD, self._onS2cNewSevenDaysScoreAward, self)
	var_0_6:addEventListener(var_0_1.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	self:_updateView()

	if self._actValue == var_0_3.ACT_VALUE.PHASE_2 then
		self._cdTimer = g.core.common.Scheduler:newSchedule(handler(self, self._onCD), var_0_5)
	end

	g.core.network.GameNetProxy:send_C2S_NewSevendays_Info({
		type = self._actValue
	})
	self:_playEnterAni()
end

function SevenDaysMainLayer:onUnload()
	self:_cancelCDTimer()
	var_0_8:saveAllUnlockedDays()
end

function SevenDaysMainLayer:_onS2CNewSevenDaysInfo(arg_5_1)
	self:_refreshCurIntegral()
	self.m_taskList:setNumItems(#self._dayTaskStructArr)
	self.m_integralAwardList:setNumItems(#self._integralAwardStructArr)
	self:_scrollIntegralAwardListView()
	self.m_specialIntegralAwardList:setNumItems(#self._specialIntegralAwardStructArr)
end

function SevenDaysMainLayer:_onS2CNewSevenDaysAward(arg_6_1, arg_6_2)
	local var_6_0 = g.core.config.sevendays_task_info.get(arg_6_2.id)

	for iter_6_0, iter_6_1 in ipairs(arg_6_2.award) do
		table.insert(self._allAward, iter_6_1)
	end

	if #var_0_8:getDayTabAllCanGetAwardId(var_6_0.type, var_6_0.reset) <= 0 then
		self._allAward = {}

		g.core.module.ModuleManager:awardSummary((g.core.common.GlobalFunc.mergeAwards(self._allAward)))
	end

	self:_refreshCurIntegral()
	self.m_dayList:setNumItems(var_0_3.DAY_TAB_NUM)
	self.m_taskList:setNumItems(#self._dayTaskStructArr)
	self.m_integralAwardList:setNumItems(#self._integralAwardStructArr)
	self:_scrollIntegralAwardListView()
	self.m_specialIntegralAwardList:setNumItems(#self._specialIntegralAwardStructArr)
end

function SevenDaysMainLayer:_onS2cNewSevenDaysScoreAward(arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_2.award) do
		table.insert(self._allAward, iter_7_1)
	end

	if #var_0_8:getIntegralAllCanGetAwardId(g.core.config.sevendays_points_reward_info.get(arg_7_2.id).type) <= 0 then
		g.core.module.ModuleManager:awardSummary(self._allAward)

		self._allAward = {}
	end

	self.m_integralAwardList:setNumItems(#self._integralAwardStructArr)
	self:_scrollIntegralAwardListView()
	self.m_specialIntegralAwardList:setNumItems(#self._specialIntegralAwardStructArr)
end

function SevenDaysMainLayer:_initView()
	self.m_checkBtn:addClickListener(handler(self, self._onClickCheckBtn))
	self.m_dayList:setVirtual()
	self.m_dayList:setItemRenderer(handler(self, self._onDayListRefresh))
	self.m_dayList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickDayTab))
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskListRefresh))
	self.m_specialIntegralAwardList:setIniter()
	self.m_specialIntegralAwardList:doFairyBatching(true)
	self.m_specialIntegralAwardList:setItemRenderer(handler(self, self._onSpecialIntegralAwardListRefresh))
	self.m_integralAwardList:setVirtual()
	self.m_integralAwardList:setItemRenderer(handler(self, self._onIntegralAwardListRefresh))
end

function SevenDaysMainLayer:_updateData()
	local var_9_0 = var_0_11:getCreateRoleDays()

	if #self._dayArr > 1 then
		var_9_0 = math.max(var_9_0, self._dayArr[1])
		var_9_0 = math.min(var_9_0, self._dayArr[#self._dayArr])
		self._selectedIdxCpp = table.indexof(self._dayArr, var_9_0) - 1
	else
		var_9_0 = 1
		self._selectedIdxCpp = 0
	end

	var_0_8:saveUnlockedDay(var_9_0)

	self._dayTaskStructArr = var_0_8:getTaskStructArr(self._actValue, var_9_0)
	self._integralAwardStructArr = var_0_8:getIntegralAwardStructArr(self._actValue, var_0_4.NORMAL)
	self._specialIntegralAwardStructArr = var_0_8:getIntegralAwardStructArr(self._actValue, var_0_4.SPECIAL)
end

function SevenDaysMainLayer:_updateView()
	self.m_actValueController:setSelectedIndex(self._actValue - 1)
	self.m_topBarComp:setTitle(var_0_8:getActivityData(self._actValue):getActivityName())
	self.m_topBarComp:setResInfoById(var_0_3.TOP_BAR_ID[self._actValue])

	local var_10_0
	local var_10_1

	if self._actValue == var_0_3.ACT_VALUE.PHASE_2 then
		local var_10_2 = var_0_0.get(var_0_3.SHOW_UNITE_TOKEN_ID)

		self.m_uniteTokenPicComp:updatePic({
			url = var_0_7:getUniteTokenCardImg(var_10_2.res_id)
		})
		self.m_uniteTokenPicComp:setAlphaRect(var_0_2.SpineConst.MASK_TYPE.HORIZON, cc.rect(-200, 0, 400, 0), 150)
		self.m_knightNameTxt:setText(var_10_2.name)

		var_10_0 = "bg/activity/bg_7activity2.jpg"
		var_10_1 = var_0_7:getIconByTypeValue(var_0_12.TYPE_RESOURCE, var_0_12.RESOURCE.TYPE_COURAGE_2)
	else
		local var_10_3 = g.core.config.parameter_info.get(var_0_3.SHOW_KNIGHT_ID).parameter

		self.m_knightPicComp:updateKnight({
			baseId = var_10_3
		})
		self.m_knightPicComp:setAlphaRect(var_0_2.SpineConst.MASK_TYPE.HORIZON, cc.rect(-300, 0, 400, 0), 150)

		local var_10_4 = var_0_9:getKnightResInfo({
			knightId = var_10_3
		})

		self.m_knightNameTxt:setText(var_10_4.name)
		self.m_knightQuality:setURL(var_0_7:getQualityArtTxtURL(var_10_4.quality))
		self.m_knightBgQuality:setURL("ui://base_new/pic_7activity_pinzhi_" .. var_10_4.quality + 1)

		var_10_0 = "bg/activity/bg_7activity.jpg"
		var_10_1 = var_0_7:getIconByTypeValue(var_0_12.TYPE_RESOURCE, var_0_12.RESOURCE.TYPE_COURAGE)
	end

	if self._bgLoader then
		self._bgLoader:setURL(var_10_0)
	else
		self._bgLoader = self:addBg(var_10_0)
	end

	self.m_integralIconLoader:setURL(var_10_1)
	self:_updateCDTxt()
	self:_updateListView()
end

function SevenDaysMainLayer:_updateListView()
	self.m_dayList:setNumItems(var_0_3.DAY_TAB_NUM)
	self.m_dayList:setSelectedIndex(self._selectedIdxCpp)
	self.m_taskList:setNumItems(#self._dayTaskStructArr)
	self.m_specialIntegralAwardList:setNumItems(#self._specialIntegralAwardStructArr)
	self.m_specialIntegralAwardList:resizeToFit(#self._specialIntegralAwardStructArr)
	self.m_integralAwardList:setNumItems(#self._integralAwardStructArr)
	self:_scrollIntegralAwardListView()
end

function SevenDaysMainLayer:_onCD()
	local var_12_0 = var_0_11:getTime()

	if var_12_0 - self._exeTimerLastTime < var_0_5 then
		return
	end

	self._exeTimerLastTime = var_12_0

	if var_0_8:isShowWithActValue(self._actValue) then
		self:_updateCDTxt()
	else
		self:_cancelCDTimer()
		g.core.module.ModuleManager:popModule()
		g.core.module.ModuleManager:tip(g.core.lang:get(403005))
	end
end

function SevenDaysMainLayer:_onCrossDay()
	if var_0_8:isShowWithActValue(self._actValue) then
		self:_updateData()
		self:_updateListView()
	end
end

function SevenDaysMainLayer:_onDayListRefresh(arg_14_1, arg_14_2)
	arg_14_2:updateCell(self._actValue, self._dayArr[arg_14_1 + 1])
end

function SevenDaysMainLayer:_onTaskListRefresh(arg_15_1, arg_15_2)
	arg_15_2:updateCell(self._dayTaskStructArr[arg_15_1 + 1])
end

function SevenDaysMainLayer:_onIntegralAwardListRefresh(arg_16_1, arg_16_2)
	arg_16_2:updateCell(self._integralAwardStructArr[arg_16_1 + 1], arg_16_1 + 1 == #self._integralAwardStructArr)
end

function SevenDaysMainLayer:_onSpecialIntegralAwardListRefresh(arg_17_1, arg_17_2)
	arg_17_2:updateCell(self._specialIntegralAwardStructArr[arg_17_1 + 1], arg_17_1 + 1 == 1)
end

function SevenDaysMainLayer:_onClickCheckBtn()
	local var_18_0

	if self._actValue == var_0_3.ACT_VALUE.PHASE_2 then
		var_18_0 = {
			type = var_0_12.TYPE_UNITETOKEN,
			value = var_0_3.SHOW_UNITE_TOKEN_ID
		}
	else
		local var_18_1 = {
			type = var_0_12.TYPE_KNIGHT
		}

		var_18_1.value = g.core.config.parameter_info.get(var_0_3.SHOW_KNIGHT_ID).parameter
		var_18_0 = var_18_1
	end

	var_0_13.pushInfoPop(var_18_0)
end

function SevenDaysMainLayer:_onClickDayTab()
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.SEVEN_DAYS_ACTIVITY_SWITCH_DAY)

	local var_19_0 = self.m_dayList:getSelectedIndex()

	if self._selectedIdxCpp == var_19_0 then
		return
	end

	local var_19_1 = self._dayArr[var_19_0 + 1]

	if var_0_8:getDayTabState(self._actValue, self._dayArr[var_19_0 + 1]) == var_0_3.DAY_TAB_STATE.LOCKED then
		self.m_dayList:setSelectedIndex(self._selectedIdxCpp)
		g.core.module.ModuleManager:tip(g.core.lang:get(403003))
	else
		self._selectedIdxCpp = var_19_0

		var_0_8:saveUnlockedDay(var_19_1)
		self.m_dayList:getChildAt((self.m_dayList:itemIndexToChildIndex(var_19_0))):updateCell(self._actValue, var_19_1)

		self._dayTaskStructArr = var_0_8:getTaskStructArr(self._actValue, var_19_1)

		self.m_taskList:setNumItems(#self._dayTaskStructArr)
		self.m_taskList:scrollToView(0, false, false)
		self:_playTaskCellsEnterAni()
	end
end

function SevenDaysMainLayer:_updateCDTxt()
	local var_20_0 = var_0_8:getActivityData(self._actValue)

	if not var_20_0 then
		return
	end

	local var_20_1, var_20_2, var_20_3 = var_0_11:getLeftTimeParts((var_20_0:getFinishTime()))

	self.m_cdTxt:setText(var_20_1 > 0 and g.core.lang:get(403004, {
		day = var_20_1,
		hour = var_20_2
	}) or g.core.lang:get(403007, {
		hour = var_20_2,
		min = var_20_3
	}))
end

function SevenDaysMainLayer:_cancelCDTimer()
	if self._cdTimer then
		g.core.common.Scheduler:cancelSchedule(self._cdTimer)

		self._cdTimer = nil
	end
end

function SevenDaysMainLayer:_refreshCurIntegral()
	self.m_curIntegralTxt:setText((var_0_10:getResourceById((self._actValue == var_0_3.ACT_VALUE.PHASE_2 or nil) and var_0_12.RESOURCE.TYPE_COURAGE_2)))
end

function SevenDaysMainLayer:_playEnterAni()
	local var_23_0 = "play"

	if self._actValue == var_0_3.ACT_VALUE.PHASE_2 then
		var_23_0 = "play2"
	end

	self.m_enterTransition:setHook("play", function()
		self.m_effTitle:addEffectSpine({
			isLoop = false,
			name = "eff_ui_sevenDaysActivity_title",
			remove = true,
			anim = var_23_0
		})
	end)
	self.m_enterTransition:setHook("list", function()
		self:_playTaskCellsEnterAni()
	end)
	self.m_enterTransition:play()
	self.m_effBg:addEffectSpine({
		isLoop = false,
		name = "eff_ui_sevenDaysActivity_bgA",
		remove = true,
		anim = var_23_0
	})
	g.core.sound.SoundManager:playSound(var_0_2.SoundConst.Sound.SEVEN_DAYS_ACTIVITY_OPEN)
end

function SevenDaysMainLayer:_playTaskCellsEnterAni()
	self.m_taskList:transitionShowCells("enter_right", 0.03)
end

function SevenDaysMainLayer:_getDayWithIndex(arg_27_1)
	return (self._actValue == var_0_3.ACT_VALUE.PHASE_2 or nil) and arg_27_1 + var_0_3.DAY_TAB_NUM
end

function SevenDaysMainLayer:_getDayIndexWithDay(arg_28_1)
	arg_28_1 = arg_28_1 % var_0_3.DAY_TAB_NUM

	if arg_28_1 == 0 then
		arg_28_1 = var_0_3.DAY_TAB_NUM
	end

	return arg_28_1
end

function SevenDaysMainLayer:_scrollIntegralAwardListView()
	local var_29_0 = 0

	for iter_29_0, iter_29_1 in ipairs(self._integralAwardStructArr) do
		if iter_29_1:getReceiveState() ~= var_0_3.RECEIVE_STATE.RECEIVED then
			var_29_0 = iter_29_0 - 1

			break
		end
	end

	self.m_integralAwardList:scrollToView(var_29_0, true)
end

return SevenDaysMainLayer
