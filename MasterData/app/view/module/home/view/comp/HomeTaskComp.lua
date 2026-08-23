local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.common.ModuleUnlock
local var_0_2 = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_TASK] = 135,
	[g.core.const.ConstMgr.FUNCTION_TYPE.SPIRIT_HELP] = 447
}
local HomeTaskComp = class("HomeTaskComp", require("app.fairyGUI.home.UI_HomeTaskComp"))

function HomeTaskComp:ctor()
	self:_initBtn()
end

function HomeTaskComp:_initBtn()
	self.m_spiritBtn:addClickListener(handler(self, self._onSpiritBtnClick))
	self.m_spiritBtn:setRedPointId(var_0_2[var_0_0.SPIRIT_HELP])
	self.m_tipsBtn:addClickListener(handler(self, self._onTipsBtnClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.m_taskBtn:getChild("redPointComp"):setId(var_0_2[var_0_0.DAILY_TASK])
	self.m_recruitBtn:addClickListener(handler(self, self._onRecruitBtnClick))
	self.m_tipsBtn:setSound(g.core.const.ConstMgr.SoundConst.Sound.CLICK_WARNING)
	self.m_taskBtn:setSound(g.core.const.ConstMgr.SoundConst.Sound.POPUP_TASK)
	self.m_tickedGuide:setConflictBtn(self.m_welfareBtn)
end

function HomeTaskComp:onLoad()
	self.m_taskBtn:setVisible(false)
	self.m_tipsBtn:setVisible(false)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TIPS_FLUSH, handler(self, self._checkTipBtnRing), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TIPS_NOTIFY, handler(self, self._checkTipBtnRing), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_HOME_REMIND_TIP_SETTING_CHANGED, handler(self, self._checkTipBtnRing), self)

	if var_0_1:isModuleUnlock(var_0_0.DAILY_TASK) then
		self.m_taskBtn:setVisible(true)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_taskBtn:getChild("redPointComp")
		})
	end

	self.m_recruitBtn:setVisible(var_0_1:isModuleUnlock(var_0_0.RECRUIT_GENERIAL))

	if var_0_1:isModuleUnlock(var_0_0.HOME_INFO_REMIND) then
		self.m_tipsBtn:setVisible(true)
	end

	local var_3_0 = g.core.model.User.activityLifeTimeCardData:isSubscription()

	self.m_battleSpeedBtn:setVisible(var_3_0)

	if var_3_0 then
		local var_3_1 = {}

		var_3_1.name = "battleAssistantIcon"

		function var_3_1.click()
			g.core.module.ModuleManager:pushModule(g.view.entrance.BATTLE_SPEED2)
		end

		g.core.layer.LayerManager:getFloatLayer():createAndAddFloatComp(var_3_1, function()
			local var_5_0 = fgui.UIPackage:createObject("base_new", "BaseLoaderBtn")

			var_5_0:setIcon("ui://base_new/icon_xiaozhushou_guofu")

			local var_5_1 = var_5_0:getPosition()

			var_5_1.y = g.core.layer.LayerManager:getFloatLayer():globalToLocal((self.m_recruitBtn:getParent():localToGlobal((self.m_recruitBtn:getPosition())))).y

			var_5_0:setPosition(var_5_1)

			return var_5_0
		end, true)
		g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", true)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_phoenixGiftBtn
		})
		self:_checkBattleSpeedSpeWeakGuide()
	end

	self.m_spiritBtn:setVisible(var_0_1:isModuleUnlock(var_0_0.SPIRIT_HELP))
	self.m_battleSpeedBtn:setVisible(false)

	if not self.m_tickedGuide:isVisible() and not g.core.model.User.guideData:getTopGuide() then
		self.m_welfareBtn:updateBtn()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_recruitBtn
	})
	self:_checkTipBtnRing()
end

function HomeTaskComp:_checkBattleSpeedSpeWeakGuide()
	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.BATTLE_SPEED_ENTERED) then
		local var_6_0 = {
			key = "BATTLE_SPEED_ENTERED"
		}

		var_6_0.targetBtn = g.core.layer.LayerManager:getFloatLayer():getFloatComp("battleAssistantIcon")

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, var_6_0)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK_WAR_ORDER)
end

function HomeTaskComp:onUnload()
	g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", false)
end

function HomeTaskComp:_onTipsBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.HOME_REMIND_POP)
end

function HomeTaskComp:_checkTipBtnRing()
	local var_9_0 = self.m_tipsBtn:getTransition("ring")

	if g.core.model.User.homeInfoRemindData:hasNewTip() then
		var_9_0:play(-1, 0)
	else
		var_9_0:stop()
	end
end

function HomeTaskComp:_onSpiritBtnClick()
	if var_0_1:isModuleUnlock(var_0_0.SPIRIT_HELP) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.SPIRIT_HELP_LAYER, {})
	else
		g.core.module.ModuleManager:tip(var_0_1:getUnlockTxt(var_0_0.SPIRIT_HELP))
	end
end

function HomeTaskComp:_onBattleSpeedBtnClick()
	if var_0_1:isModuleUnlock(var_0_0.BATTLE_SPEED2) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.BATTLE_SPEED2)
	else
		g.core.module.ModuleManager:tip(var_0_1:getUnlockTxt(var_0_0.BATTLE_SPEED2))
	end
end

function HomeTaskComp:_onTaskBtnClick()
	if var_0_1:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_TASK) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.DAILY_TASK)
	end
end

function HomeTaskComp:_onRecruitBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT)
end

return HomeTaskComp
