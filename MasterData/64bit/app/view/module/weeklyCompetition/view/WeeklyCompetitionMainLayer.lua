local var_0_0 = g.core.model.User.weeklyCompetitionMgrData
local WeeklyCompetitionConst = require("app.view.module.weeklyCompetition.const.WeeklyCompetitionConst")
local WeeklyCompetitionMainLayer = class("WeeklyCompetitionMainLayer", require("app.fairyGUI.weeklyCompetition.UI_WeeklyCompetitionMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "weeklyCompetition",
		isFullScreen = true,
		pkgPath = "ui/weeklyCompetition/weeklyCompetition",
		resName = "WeeklyCompetitionMainLayer"
	}, ...)
end)

function WeeklyCompetitionMainLayer:ctor(arg_2_1)
	self._weeklyCompetitionData = var_0_0:getActDataByBaseId(arg_2_1.goods.activity_value)
	self._baseInfo = self._weeklyCompetitionData:getCurBaseInfo()
	self._rankInfo = nil
	self._openBoxId = -1

	self:_initView()
	self:addBg("bg/activity/bg_zhouhd_main.jpg", false, nil, 1)
	self._weeklyCompetitionData:saveNewActivity()
	self.m_rankComp:initRankData(self._weeklyCompetitionData)
	self.m_proComp:initViewComp(self._weeklyCompetitionData)
	self.m_tipScoreComp:initViewComp(self._weeklyCompetitionData)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.WEEKLY_COMPETITION)
end

function WeeklyCompetitionMainLayer:_initView()
	local var_3_0

	for iter_3_0 = 1, g.core.config.activity_enter_info.getLength() do
		var_3_0 = g.core.config.activity_enter_info.indexOf(iter_3_0)

		if var_3_0.activity_type == g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.WEEKLY_COMPETITION and var_3_0.activity_value == self._baseInfo.activityInfo.sub_id then
			break
		end
	end

	self.m_topBarComp:setTitle(var_3_0.remark)
	self.m_topBarComp:setResInfoById((self._baseInfo.cfg or nil) and (self._baseInfo.cfg.interface_main or 320))
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClicked))
	self.m_giftBtn:addClickListener(handler(self, self._onGiftBtnClicked))
	self.m_tipRewardIcon:addClickListener(handler(self, self._onTipRewardIconClick))
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRender))
	self.m_taskList:doFairyBatching(false)
end

function WeeklyCompetitionMainLayer:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "boxClicked" then
		if arg_4_2.info.state == WeeklyCompetitionConst.REWARD_STATE.MATCH then
			self:_clearAllEffect()
			self:_updateLayer()
			g.core.network.GameNetProxy:send_C2S_WeeklyCompetition_ScoreAward({
				reward_id = arg_4_2.info.cfg.id,
				activity_id = self._weeklyCompetitionData:getActiveId()
			})
		elseif self._openBoxId ~= arg_4_2.info.cfg.id then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.weeklyCompetition.view.pop.WeeklyCompetitionProgressPop").new({
				rewardInfo = arg_4_2.info,
				weeklyData = self._weeklyCompetitionData
			})))
		end

		return true
	elseif arg_4_1 == "Change_ServerType" then
		return true
	elseif arg_4_1 == "openBoxAwards" then
		self:_onShowAwards(arg_4_2.awards, handler(self, self._checkPlayNextSectionEffect))

		return true
	elseif arg_4_1 == "boxReNewEnd" then
		self:_updateLayer()

		return true
	elseif arg_4_1 == "tipCompHide" then
		self.m_isShowTipController:setSelectedIndex(0)
		self.m_proComp:playProUpEffect(arg_4_2.startScore, arg_4_2.targetScore)

		return true
	elseif arg_4_1 == "onProUpEffectEnd" then
		self:_updateLayer()

		return true
	elseif arg_4_1 == "onRewardPreviewShow" then
		self:_onRewardPreviewShow()

		return true
	end

	return false
end

function WeeklyCompetitionMainLayer:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._reqInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_INFO, handler(self, self._updateLayer), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_SCOREAWARD, handler(self, self._onDrawReward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, handler(self, self._onReceiveRankInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_GETRANKLIST, handler(self, self._onReceiveRankInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateRank), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEEKLY_COMPETITION_ENTER, handler(self, self._checkScoreTip), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.WEEKLY_COMPETITION_GIFT_POP_CLOSE, handler(self, self._reqEnterInfo), self)
end

function WeeklyCompetitionMainLayer:onLoad()
	self:_addCustomListener()
	self:_reqInfo()
	self:_reqEnterInfo()
	self:_updateLayer()
end

function WeeklyCompetitionMainLayer:_reqEnterInfo()
	local var_7_0 = self._weeklyCompetitionData:getActiveId()

	g.core.network.GameNetProxy:send_C2S_WeeklyCompetition_Enter({
		activity_id = var_7_0
	})
	g.core.network.GameNetProxy:send_C2S_WeeklyCompetition_GetRankList({
		page = 1,
		activity_id = var_7_0
	})
end

function WeeklyCompetitionMainLayer:onUnload()
	self:_onStopTimeSchedule()
end

function WeeklyCompetitionMainLayer:_updateLayer()
	self.m_nameText:setText(self._baseInfo.cfg.title)
	self.m_proComp:updateProgressComp(self._baseInfo.rewardInfoList[self._baseInfo.section], nil, self._weeklyCompetitionData)
	self:_updateRank()
	self.m_tipRewardIcon:setURL((g.core.common.Path:getIconByTypeValue(self._baseInfo.rewardInfoList[#self._baseInfo.rewardInfoList][#self._baseInfo.rewardInfoList[#self._baseInfo.rewardInfoList]].awards[1].type, self._baseInfo.rewardInfoList[#self._baseInfo.rewardInfoList][#self._baseInfo.rewardInfoList[#self._baseInfo.rewardInfoList]].awards[1].value)))
	self.m_tipRewardNumText:setText(self._baseInfo.rewardInfoList[#self._baseInfo.rewardInfoList][#self._baseInfo.rewardInfoList[#self._baseInfo.rewardInfoList]].awards[1].size)
	self.m_tipText:setText(g.core.lang:get(420102, {
		node = self._baseInfo.rewardInfoList[#self._baseInfo.rewardInfoList][#self._baseInfo.rewardInfoList[#self._baseInfo.rewardInfoList]].cfg.node_name
	}))

	local var_9_0 = self.m_tipText:getPosition()

	var_9_0.x = self.m_tipRewardIcon:getPosition().x - self.m_tipRewardIcon:getSize().width * self.m_tipRewardIcon:getScale().x + 5

	self.m_tipText:setPosition(var_9_0)
	self.m_taskList:setNumItems(#self._baseInfo.taskInfoList)

	local var_9_1

	if self._baseInfo.activityInfo.local_end_time - g.core.common.ServerTime:getTime() > 0 then
		self:_onStartTimeSchedule()
		self:_updateTime()
	else
		self:newScheduleOnce(handler(self, function(arg_10_0)
			g.core.module.ModuleManager:popAllPopup()
			g.core.module.ModuleManager:onlyPopSelfByDisplay(arg_10_0)
		end), 0.5)

		var_9_1 = self.m_awardTipBg:getSize()
	end

	var_9_1.width = self.m_tipRewardNumText:getPosition().x - self.m_tipText:getPosition().x + self.m_tipText:getSize().width + 20

	self.m_awardTipBg:setSize(var_9_1)
end

function WeeklyCompetitionMainLayer:_onTaskItemRender(arg_11_1, arg_11_2)
	arg_11_2:updateItem(self._baseInfo.taskInfoList[arg_11_1 + 1], (arg_11_1 + 1) % 2, self._weeklyCompetitionData:getScoreIconUrl())
end

function WeeklyCompetitionMainLayer:_onReceiveRankInfo(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = {}

	var_12_0.rankList = arg_12_4.rank_units or {}
	var_12_0.myRank = arg_12_4.self_rank or 0
	self._rankInfo = var_12_0

	self:_updateRank()
end

function WeeklyCompetitionMainLayer:_updateRank()
	if self._rankInfo then
		self.m_rankComp:updateRankComp(self._rankInfo)
	end
end

function WeeklyCompetitionMainLayer:_onStartTimeSchedule()
	self._timeSchedule = self._timeSchedule or self:newSchedule(handler(self, self._updateTime), 1)
end

function WeeklyCompetitionMainLayer:_onStopTimeSchedule()
	if self._timeSchedule then
		self:cancelSchedule(self._timeSchedule)
	end

	self._timeSchedule = nil
end

function WeeklyCompetitionMainLayer:_updateTime()
	local var_16_0 = self._baseInfo.activityInfo.local_end_time - g.core.common.ServerTime:getTime()

	if var_16_0 > 0 then
		self.m_timeText:setText((g.core.common.ServerTime:getCountDownBySecond(var_16_0)))
	else
		self.m_timeText:setText("")
		self:_onStopTimeSchedule()
		self:_reqInfo()
	end
end

function WeeklyCompetitionMainLayer:_reqInfo()
	g.core.network.GameNetProxy:send_C2S_WeeklyCompetition_Info({})
end

function WeeklyCompetitionMainLayer:_onTipRewardIconClick()
	g.core.common.GlobalFunc.pushInfoPop(self._baseInfo.rewardInfoList[#self._baseInfo.rewardInfoList][#self._baseInfo.rewardInfoList[#self._baseInfo.rewardInfoList]].awards[1])
end

function WeeklyCompetitionMainLayer:_onDrawReward(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	self._openBoxId = arg_19_4.reward_id

	if g.core.config.weekly_competition_reward_info.get(arg_19_4.reward_id).if_big == 1 then
		self.m_proComp:playOpenBox(arg_19_4.reward_id, arg_19_4)
	else
		self:_onShowAwards(arg_19_4.awards, handler(self, self._checkPlayNextSectionEffect))
	end
end

function WeeklyCompetitionMainLayer:_onShowAwards(arg_20_1, arg_20_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		award = {
			awards = arg_20_1,
			func = arg_20_2
		}
	})
end

function WeeklyCompetitionMainLayer:_onGiftBtnClicked()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.weeklyCompetition.view.pop.WeeklyCompetitionGiftPop").new({
		title = g.core.lang:get(420103),
		activityValue = self._baseInfo.activityInfo.sub_id,
		shopValue = g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.WEEKLY_COMPETITION,
		openCheckFunc = handler(self, function(arg_22_0)
			return arg_22_0._baseInfo.activityInfo.local_end_time > g.core.common.ServerTime:getTime()
		end)
	})))
end

function WeeklyCompetitionMainLayer:_onRankBtnClicked()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.weeklyCompetition.view.pop.WeeklyCompetitionRankPop").new({
		baseId = self._baseInfo.activityInfo.sub_id,
		rankInfo = self._rankInfo,
		weeklyData = self._weeklyCompetitionData
	})))
end

function WeeklyCompetitionMainLayer:_onRewardPreviewShow()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(self._baseInfo.rewardInfoList) do
		var_24_0[#var_24_0 + 1] = iter_24_1[#iter_24_1]
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.weeklyCompetition.view.pop.WeeklyCompetitionRewardPop").new({
		awardList = var_24_0,
		weeklyData = self._weeklyCompetitionData
	})))
end

function WeeklyCompetitionMainLayer:_checkScoreTip()
	local var_25_0 = self._weeklyCompetitionData:getLastScore()
	local var_25_1 = self._weeklyCompetitionData:getResourceNum() - var_25_0

	if var_25_1 ~= 0 then
		self:_playScoreEffect(var_25_0 + 1, var_25_1, true, var_25_0)
	end
end

function WeeklyCompetitionMainLayer:_playScoreEffect(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	self.m_proComp:updateProgressComp(self._baseInfo.rewardInfoList[self._baseInfo.section], arg_26_4, self._weeklyCompetitionData)

	if arg_26_3 then
		self.m_tipScoreComp:playShow(arg_26_1, arg_26_2)
		self.m_isShowTipController:setSelectedIndex(1)
	else
		self.m_isShowTipController:setSelectedIndex(0)
		self.m_proComp:playProUpEffect(arg_26_1, arg_26_1 + arg_26_2)
	end
end

function WeeklyCompetitionMainLayer:_checkPlayNextSectionEffect()
	self._openBoxId = -1

	local var_27_0 = true

	for iter_27_0, iter_27_1 in ipairs(self._baseInfo.rewardInfoList[self._baseInfo.section]) do
		if iter_27_1.state == WeeklyCompetitionConst.REWARD_STATE.REWARDED then
			var_27_0 = false

			break
		end
	end

	if var_27_0 then
		self:_playScoreEffect(self._baseInfo.rewardInfoList[self._baseInfo.section - 1][#self._baseInfo.rewardInfoList[self._baseInfo.section - 1]].scoreInfo.score, self._weeklyCompetitionData:getResourceNum() - self._baseInfo.rewardInfoList[self._baseInfo.section - 1][#self._baseInfo.rewardInfoList[self._baseInfo.section - 1]].scoreInfo.score, false, self._baseInfo.rewardInfoList[self._baseInfo.section - 1][#self._baseInfo.rewardInfoList[self._baseInfo.section - 1]].scoreInfo.score)
	else
		self:_updateLayer()
	end
end

function WeeklyCompetitionMainLayer:_clearAllEffect()
	self.m_proComp:clearAllEffect()
end

return WeeklyCompetitionMainLayer
