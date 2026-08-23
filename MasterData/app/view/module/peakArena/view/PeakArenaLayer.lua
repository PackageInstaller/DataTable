local var_0_0 = g.core.model.User.peakArenaData
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.PeakArenaConst
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.network.GameNetProxy
local var_0_5 = 1
local var_0_6 = g.core.module.ModuleManager
local var_0_7 = g.core.event.EventManager
local var_0_8 = g.core.common.ServerTime
local PeakArenaRankUpPop = require("app.view.module.peakArena.view.PeakArenaRankUpPop")
local PeakArenaLayer = class("PeakArenaLayer", require("app.fairyGUI.peakArena.UI_PeakArenaLayer"), function()
	return fgui.GComponent:create({
		resName = "PeakArenaLayer",
		pkgPath = "ui/peakArena/peakArena",
		isFullScreen = true,
		pkgName = "peakArena"
	}, ...)
end)

function PeakArenaLayer:ctor()
	var_0_0:resetHasAward()
	var_0_0:resetHasCheer()

	self._exeTimerLastTime = 0
	self._timer = nil
	self._groupId = 0

	self:addBg("bg/peakArena/bg_wzjj.jpg")
	self.m_topBarComp:setResInfoById(var_0_2.TOP_BAR_ID)
	self:_addClickListeners()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_1.FUNCTION_TYPE.PEAK_ARENA)
end

function PeakArenaLayer:_addClickListeners()
	for iter_3_0, iter_3_1 in ipairs({
		self.m_integralStageLayerComp,
		self.m_peakStageLayerComp
	}) do
		iter_3_1.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
		iter_3_1.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
		iter_3_1.m_taskBtn:addClickListener(handler(self, self._onClickTaskBtn))
		iter_3_1.m_recordBtn:addClickListener(handler(self, self._onClickRecordBtn))

		if iter_3_1.m_lineUpBtn then
			iter_3_1.m_lineUpBtn:addClickListener(handler(self, self._onClickLineupBg))
		end

		if iter_3_1.m_lineUpTimeBtn then
			iter_3_1.m_lineUpTimeBtn:addClickListener(handler(self, self._onClickLineupTimeBg))
		end

		if iter_3_1.m_lineUpBgLoader then
			iter_3_1.m_lineUpBgLoader:addClickListener(handler(self, self._onClickLineupBg))
		end
	end
end

function PeakArenaLayer:onLoad()
	var_0_7:addEventListener(var_0_3.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	var_0_7:addEventListener(var_0_3.EVENT_NET_S2C_PEAK_ARENA_GETACTIVITYINFO, self._onS2CGetInfo, self)
	var_0_7:addEventListener(var_0_3.EVENT_NET_S2C_PEAK_ARENA_GETUSERINFO, self._onS2CGetUserInfo, self)
	var_0_7:addEventListener(var_0_3.EVENT_NET_S2C_PEAK_ARENA_GETFINALINFO, self._onS2CGetFinalInfo, self)
	var_0_7:addEventListener(var_0_3.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onS2CGetCommonRankList, self)
	var_0_7:addEventListener(var_0_3.EVENT_NET_S2C_PEAK_ARENA_PLAYBETS, self._updateDailyTaskInfo, self)
	var_0_7:addEventListener(var_0_3.EVENT_NET_S2C_PEAK_ARENA_CHEER, handler(self, self._onS2CCheer), self)
	var_0_7:addEventListener(var_0_3.EVENT_NET_S2C_PEAK_ARENA_ALLIANCERANKAWARD, handler(self, self._onS2CAllianceRankAward), self)
	var_0_7:addEventListener(var_0_3.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CUserSnapshot), self)
	var_0_4:send_C2S_PeakArena_GetActivityInfo({})
	var_0_4:send_C2S_PeakArena_GetServerInfos({})
	var_0_4:send_C2S_PeakArena_GetUserInfo({})
	g.core.network.GameNetProxy:send_C2S_Formation_Get({
		tp = var_0_1.LineUpConst.MulTeamType.PEAK_ARENA
	})
	self:_updateDailyTaskInfo()
	g.core.sound.SoundManager:playMusic(var_0_1.SoundConst.BGM.MUSIC_PEAK_ARENA_LAYER)
	self:checkSpeGuideTick()
end

function PeakArenaLayer:onUnload()
	self:_cancelScheduler()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function PeakArenaLayer:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "ClickGroupNameItem" then
		if var_0_0:getStageType() == var_0_2.StageType.PEAK then
			self._groupId = arg_6_2

			self.m_peakStageLayerComp:updateComp(arg_6_2)
		end
	elseif arg_6_1 == "CompEventCloseFormationLayer" and var_0_0:getStageType() == var_0_2.StageType.PEAK then
		self.m_peakStageLayerComp:onReturnFormPop()
	end
end

function PeakArenaLayer:_onClickRankBtn()
	var_0_6:pushPopup(require("app.view.module.peakArena.view.PeakArenaRankLayer").new(), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function PeakArenaLayer:_onClickShopBtn()
	var_0_6:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_1.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_1.ShopConst.SHOP_TYPE.PEAK_ARENA
	})
end

function PeakArenaLayer:_onClickTaskBtn()
	var_0_6:pushPopup(require("app.view.module.peakArena.view.PeakArenaDailyTaskPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function PeakArenaLayer:_onClickRecordBtn()
	var_0_6:pushPopup(require("app.view.module.peakArena.view.PeakArenaMatchRecordLayer").new(), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function PeakArenaLayer:_onClickLineupBg()
	var_0_6:pushModule(g.view.entrance.FORMATION)
end

function PeakArenaLayer:_onClickLineupTimeBg()
	if self.m_peakStageLayerComp:getCanLineUpStatus() then
		var_0_6:pushModule(g.view.entrance.PEAK_FORMATION)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(307055))
	end
end

function PeakArenaLayer:checkSpeGuideTick()
	if self.m_peakStageLayerComp:getCanLineUpStatus() and g.core.config.parameter_info.get(20055).parameter < var_0_0:getBetEndTime() - var_0_8:getTime() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GUIDE_PEAK_FORMATION",
			targetBtn = self.m_peakStageLayerComp.m_lineUpTimeBtn
		})
	end
end

function PeakArenaLayer:_onCrossDay()
	var_0_4:send_C2S_GetModuleTaskInfo({
		module_id = var_0_1.TaskConst.MODULE_ID.PEAK_ARENA
	})
end

function PeakArenaLayer:_onS2CGetInfo()
	local var_15_0 = var_0_0:getStageType()

	self.m_stageController:setSelectedIndex(var_15_0)

	if var_15_0 == var_0_2.StageType.INTEGRAL then
		self.m_integralStageLayerComp:playEnterAni()
	elseif var_15_0 == var_0_2.StageType.PEAK then
		self:_reqPeakArenaFinalInfo()
		self.m_peakStageLayerComp:playEnterAni()
	elseif var_15_0 == var_0_2.StageType.TOP_SHOW then
		self:_reqPeakArenaFinalInfo()
		self.m_topShowStageLayerComp:playEnterAni()
	end

	if var_15_0 == var_0_2.StageType.NONE then
		self:_cancelScheduler()
		var_0_6:switchModuleIntelligent(g.view.entrance.HOME)
	else
		self:_startScheduler()
	end
end

function PeakArenaLayer:_onS2CGetUserInfo()
	self.m_integralStageLayerComp:onRcvUserInfo()
	self:_checkDanGradingChange()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function PeakArenaLayer:_onS2CGetFinalInfo()
	local var_17_0 = var_0_0:getStageType()

	if var_17_0 == var_0_2.StageType.PEAK then
		local var_17_1 = var_0_2.FINAL_GROUP_ID

		if var_0_0:getPeakStageGroupType() == var_0_2.GroupType.GROUP then
			var_17_1 = var_0_0:getDefaultShowGroupId()
		end

		self._groupId = var_17_1

		self.m_peakStageLayerComp:updateComp(var_17_1)
	elseif var_17_0 == var_0_2.StageType.TOP_SHOW then
		self.m_topShowStageLayerComp:updateComp()
	end
end

function PeakArenaLayer:_onS2CGetCommonRankList()
	if var_0_0:getStageType() == var_0_2.StageType.INTEGRAL then
		self.m_integralStageLayerComp:onRcvUserInfo()
	end
end

function PeakArenaLayer:_updateDailyTaskInfo()
	var_0_4:send_C2S_GetModuleTaskInfo({
		module_id = var_0_1.TaskConst.MODULE_ID.PEAK_ARENA
	})
end

function PeakArenaLayer:_onS2CCheer(arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	var_0_6:awardSummary(arg_20_4.awards or {})
	self.m_peakStageLayerComp:updateHeadAfterCheer(arg_20_4)
end

function PeakArenaLayer:_onS2CAllianceRankAward(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	var_0_6:awardSummary(arg_21_4.awards or {})
	self.m_topShowStageLayerComp:updateRankAwardView(arg_21_4.target_id)
end

function PeakArenaLayer:_onS2CUserSnapshot()
	self:_onS2CGetCommonRankList()

	local var_22_0 = self.m_stageController:getSelectedIndex()

	if var_22_0 == var_0_2.StageType.PEAK then
		self.m_peakStageLayerComp:updateComp(self._groupId)
	elseif var_22_0 == var_0_2.StageType.TOP_SHOW then
		self.m_topShowStageLayerComp:updateComp()
	end
end

function PeakArenaLayer:_onCD()
	local var_23_0 = var_0_8:getTime()

	if var_23_0 - self._exeTimerLastTime < var_0_5 then
		return
	end

	self._exeTimerLastTime = var_23_0

	local var_23_1 = var_0_0:getStageType()
	local var_23_2 = self.m_stageController:getSelectedIndex()

	if var_23_2 ~= var_23_1 then
		self.m_stageController:setSelectedIndex(var_23_1)
	end

	if var_23_1 == var_0_2.StageType.INTEGRAL then
		self.m_integralStageLayerComp:onCD()
	elseif var_23_1 == var_0_2.StageType.PEAK then
		self.m_peakStageLayerComp:onCD()

		if var_23_2 == var_0_2.StageType.INTEGRAL then
			self.m_peakStageLayerComp:playEnterAni()
		end
	elseif var_23_1 == var_0_2.StageType.TOP_SHOW then
		if var_23_2 == var_0_2.StageType.PEAK then
			self.m_topShowStageLayerComp:playEnterAni()
		end
	else
		self:_cancelScheduler()
		var_0_6:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function PeakArenaLayer:_checkDanGradingChange()
	local var_24_0 = var_0_0:getDanGradingChangeType()

	if var_0_0:isFirstEntrySeason() then
		var_0_0:setEnteredSeason(true)
	end

	if var_24_0 == var_0_2.DanGradingChangeType.NONE then
		return
	end

	local var_24_1 = var_0_0:getMyselfInfo()

	var_0_0:resetOldScore()
	var_0_6:pushPopup((PeakArenaRankUpPop.new({
		changeType = var_24_0,
		score = var_24_1.score,
		oldScore = var_24_1.old_score
	})))
end

function PeakArenaLayer:_startScheduler()
	if not self._timer then
		self:_onCD()

		self._timer = g.core.common.Scheduler:newSchedule(handler(self, self._onCD), var_0_5)
	end
end

function PeakArenaLayer:_cancelScheduler()
	if self._timer then
		g.core.common.Scheduler:cancelSchedule(self._timer)

		self._timer = nil
	end
end

function PeakArenaLayer:_reqPeakArenaFinalInfo()
	var_0_4:send_C2S_PeakArena_GetFinalInfo({})
end

return PeakArenaLayer
