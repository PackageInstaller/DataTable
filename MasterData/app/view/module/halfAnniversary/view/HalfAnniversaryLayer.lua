local var_0_0 = g.core.model.User.halfAnniversaryData
local HalfAnniversaryLayer = class("HalfAnniversaryLayer", require("app.fairyGUI.halfAnniversary.UI_HalfAnniversaryLayer"), function()
	return fgui.GComponent:create({
		resName = "HalfAnniversaryLayer",
		pkgPath = "ui/halfAnniversary/halfAnniversary",
		isFullScreen = true,
		pkgName = "halfAnniversary"
	}, ...)
end)

function HalfAnniversaryLayer:ctor()
	self._activityCfg = var_0_0:getHalfYearActivityCfg()

	self:_initRegisterUI()
	self.m_enterTransition:play(handler(self, self._enterMapCheckGetAwards))
end

function HalfAnniversaryLayer:_initRegisterUI()
	self.m_topBarComp:setHelpId(self._activityCfg.help_id)
	self.m_topBarComp:setTitle(self._activityCfg.name)
	self.m_taskBtn:addClickListener(handler(self, self._onClickTaskBtn))
	self.m_scoreBtn:addClickListener(handler(self, self._onClickBuyScoreBtn))

	self.m_timeComp = fgui.UIPackage:createObject("halfAnniversary", "HalfAnniversaryTimeComp_" .. self._activityCfg.id)

	self.m_timePlaceHolder:addChild(self.m_timeComp)
end

function HalfAnniversaryLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayRefresh, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_GETINFO, handler(self, self._updateMainView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_BUYSCORE, handler(self, self._onS2CWelfarefundBuyScore), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._updateScoreCount), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_GETSCOREAWARD, handler(self, self._onS2CWelfarefundGetScoreAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
	g.core.network.GameNetProxy:send_C2S_Welfarefund_GetInfo({})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.HALF_ANNIVERSARY)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_SCENE_LIFE)
end

function HalfAnniversaryLayer:_updateMainView()
	self:_updateActivityTime()
	self:_updateScoreCount()
end

function HalfAnniversaryLayer:_updateActivityTime()
	self.m_timeComp:updateActivityTime()
end

function HalfAnniversaryLayer:_updateScoreCount()
	self.m_scoreComp:updateScore()
	self.m_scoreBtn:setVisible(var_0_0:getActivityOpenDays() >= self._activityCfg.day)
	self.m_mapComp:updatePointView()
end

function HalfAnniversaryLayer:_onS2CWelfarefundBuyScore()
	self:_updateScoreCount()
end

function HalfAnniversaryLayer:_onS2CWelfarefundGetScoreAward(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_9_4.awards, true, nil, nil, handler(self, function()
			self.m_mapComp:checkCanGetAwards()
		end))
		self:_updateScoreCount()
	end
end

function HalfAnniversaryLayer:_onClickTaskBtn()
	if var_0_0:isActivityOpen() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.HALF_ANNIVERSARY_TASK)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
	end
end

function HalfAnniversaryLayer:_onClickBuyScoreBtn()
	if var_0_0:isActivityOpen() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.HALF_ANNIVERSARY_SHOP)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
	end
end

function HalfAnniversaryLayer:receiveCompEvent(arg_13_1, arg_13_2)
	if arg_13_1 == "EVENT_STORY_END" then
		self.m_mapComp:updateByStoryEnd(arg_13_2)
	end
end

function HalfAnniversaryLayer:_onCrossDayRefresh()
	if not var_0_0:isActivityOpen() then
		g.core.module.ModuleManager:popModule()

		return
	end

	g.core.network.GameNetProxy:send_C2S_Welfarefund_GetInfo({})
end

function HalfAnniversaryLayer:_onModuleExit(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_3 == g.view.entrance.HALF_ANNIVERSARY_TASK or arg_15_3 == g.view.entrance.HALF_ANNIVERSARY_SHOP then
		self.m_mapComp:checkCanGetAwards()
	end
end

function HalfAnniversaryLayer:_enterMapCheckGetAwards()
	self.m_mapComp:checkCanGetAwards()
end

return HalfAnniversaryLayer
