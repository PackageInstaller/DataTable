local var_0_0 = {
	ZERO_POINT = 2,
	IMMEDIATELY = 1,
	START_SIX = 3
}
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.model.User.gveDataMgr
local var_0_3 = g.core.model.User.gveDataMgr:getGveData()
local GveInstituteKiller = class("GveInstituteKiller", require("app.fairyGUI.gve.UI_GveInstituteKiller"))

function GveInstituteKiller:ctor()
	var_0_3 = var_0_2:getGveData()

	self.m_goBtn:addClickListener(handler(self, self._onClickGo))
	self.m_detailAllBtn:addClickListener(handler(self, self._onClickDetailAll))
	self.m_detailBtn:addClickListener(handler(self, self._onClickDetail))
	self.m_bossList:setVirtual()
	self.m_bossList:setItemRenderer(handler(self, self._onBossRenderer))
	self.m_bossList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickBoss))
end

function GveInstituteKiller:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_GETALLRANDOMBOSSINFO, self._onRandBossBack, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_SYNCRANDOMBOSSINFO, self._onRandBossRefresh, self)
	self:checkTipsGuide()
end

function GveInstituteKiller:_onClickGo()
	if self._selIndex and self._selIndex >= 0 and self._randBoss[self._selIndex + 1] then
		local var_3_0 = g.core.config.gve_boss_info.get(self._randBoss[self._selIndex + 1].boss_id)

		g.core.module.ModuleManager:popComponent()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_GOTO_TARGET_POS, false, {
			x = var_3_0.x,
			y = var_3_0.y
		})
	end
end

function GveInstituteKiller:playEnterAnim()
	self.m_enterTransition:play()
	self.m_effLine:addEffectSpine({
		name = "eff_ui_gveII_line",
		isLoop = false,
		remove = true
	})
end

function GveInstituteKiller:_onClickDetailAll()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveInstituteAttrPop").new(self._struct)))
end

function GveInstituteKiller:_onClickDetail()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveInstituteInfoPop").new(self._struct:getHelpId())))
end

function GveInstituteKiller:checkTipsGuide()
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
			key = "GVE_KILLER_TASK",
			objects = {
				[2] = self.m_bossList,
				[3] = self.m_guideHelper
			}
		})
	end, 0)
end

function GveInstituteKiller:updateGveCompObj(arg_9_1)
	arg_9_1 = arg_9_1 or self._struct
	self._struct = arg_9_1

	self.m_progress:setProgress(arg_9_1:getProgressValue(), arg_9_1:getUpLvValue())

	local var_9_0 = self._struct:getLevel()

	self.m_lvTxt:setText("Lv." .. var_9_0)

	if var_9_0 == 0 then
		self.m_lockedController:setSelectedIndex(1)
		self.m_nameTxt:setText(self._struct:getResearchName() .. g.core.lang:get(309177))
	else
		self.m_lockedController:setSelectedIndex(0)
		self.m_nameTxt:setText(self._struct:getResearchName())
	end

	if not var_0_3:isFinalBossAlive() then
		self.m_finishController:setSelectedIndex(1)
	else
		self.m_finishController:setSelectedIndex(0)
	end

	g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_FIRST_ENTER_KILL_RESEARCH)
	g.core.network.GameNetProxy:send_C2S_GVE_GetAllRandomBossInfo({})
	self:checkRefreshState()
	self:onCD(0)

	local var_9_1 = var_0_3:getTodayRandBossRandTime()
	local var_9_2 = arg_9_1:getEventValue(8)

	if var_9_2 <= var_9_1 then
		self.m_hasRewardController:setSelectedIndex(1)
	else
		self.m_hasRewardController:setSelectedIndex(0)
	end

	self.m_rewardTimesTxt:setText(math.max(var_9_2 - var_9_1, 0))
	self.m_allRewardTimesTxt:setText("/" .. var_9_2)

	local var_9_3 = self._struct:getEventCfg()

	self.m_descTxt:setText(g.core.lang:get(309189, {
		num1 = var_9_3.research_points_min,
		num2 = var_9_3.research_points_max
	}))
end

function GveInstituteKiller:checkRefreshState()
	if not self._struct then
		return
	end

	local var_10_0 = self._struct:getEventValue(3)

	if var_10_0 == var_0_0.IMMEDIATELY then
		self.m_showReLiveController:setSelectedIndex(0)
	elseif var_10_0 == var_0_0.ZERO_POINT then
		self.m_showReLiveController:setSelectedIndex(1)
	elseif var_10_0 == var_0_0.START_SIX then
		self.m_showReLiveController:setSelectedIndex(1)
	end
end

function GveInstituteKiller:_onRandBossRefresh()
	g.core.network.GameNetProxy:send_C2S_GVE_GetAllRandomBossInfo({})
end

function GveInstituteKiller:_onClickBoss()
	local var_12_0 = self.m_bossList:getSelectedIndex()

	if var_12_0 >= 0 then
		self.m_goBtn:setVisible(true)

		self._selIndex = var_12_0

		local var_12_1 = self.m_bossList:getChildAt(self.m_bossList:itemIndexToChildIndex(var_12_0))

		if var_12_1 and var_12_1.playSelectEff then
			var_12_1:playSelectEff()
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_PSXY_ShortSelection)
	end

	self:checkRefreshState()
end

function GveInstituteKiller:_onRandBossBack(arg_13_1, arg_13_2, arg_13_3)
	self._randBoss = arg_13_3.boss_info

	table.sort(self._randBoss, function(arg_14_0, arg_14_1)
		if arg_14_0.boss_id ~= arg_14_1.boss_id then
			return arg_14_0.boss_id < arg_14_1.boss_id
		end

		return false
	end)
	self.m_bossList:setNumItems(#self._randBoss)
end

function GveInstituteKiller:updateGICompShow()
	self:updateGveCompObj()
end

function GveInstituteKiller:onCD(arg_16_1)
	local var_16_0 = self._struct:getEventValue(3)

	if var_16_0 == var_0_0.ZERO_POINT then
		self.m_timeTxt:setText((var_0_1:getAwardLeftTime(24, 0, 0)))
	elseif var_16_0 == var_0_0.START_SIX then
		local var_16_1, var_16_2, var_16_3 = self:getSixNextRefreshTime()

		self.m_timeTxt:setText((var_0_1:getAwardLeftTime(var_16_1, var_16_2, var_16_3)))
	end
end

function GveInstituteKiller:getSixNextRefreshTime()
	local var_17_0 = os.date("*t", var_0_1:getRealTimeZone())

	if var_17_0.hour < 6 then
		return 6, 0, 0
	elseif var_17_0.min < 30 then
		return var_17_0.hour, 30, 0
	else
		if var_17_0.hour == 23 then
			return 30, 0, 0
		end

		return var_17_0.hour + 1, 0, 0
	end
end

function GveInstituteKiller:_onBossRenderer(arg_18_1, arg_18_2)
	arg_18_2:updateByBossData(self._randBoss[arg_18_1 + 1])
end

return GveInstituteKiller
