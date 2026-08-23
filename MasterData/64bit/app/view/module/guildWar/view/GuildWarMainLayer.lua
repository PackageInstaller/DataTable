local var_0_0 = 1
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.GuildWarConst
local var_0_4 = {
	ENTER = 1,
	EXIT = 2
}
local var_0_5 = g.core.module.ModuleManager
local var_0_6 = g.core.event.EventManager
local var_0_7 = g.core.common.ServerTime
local var_0_8 = g.core.model.User.guildWarData
local GuildWarMainLayer = class("GuildWarMainLayer", require("app.fairyGUI.guildWar.UI_GuildWarMainLayer"), function()
	return fgui.GComponent:create({
		resName = "GuildWarMainLayer",
		pkgName = "guildWar",
		isFullScreen = true,
		pkgPath = "ui/guildWar/guildWar"
	}, ...)
end)

function GuildWarMainLayer:ctor()
	self._needReqSvrNotifyMsg = true
	self._timer = nil
	self._exeTimerLastTime = 0
	self._bgLoader = nil
	self._mainComp = nil

	self.m_topBarComp:setResInfoById(var_0_3.HELP_ID)

	self._preType = var_0_8:getFightStageType()

	if self._preType == var_0_3.StageType.FIGHT then
		self._preType = var_0_8:getFightStageType()
	end

	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_2.FUNCTION_TYPE.GUILD_WAR)
	self:_updateBg(true)
end

function GuildWarMainLayer:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	var_0_6:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_GETINFO, self._onS2CGuildGetInfo, self)
	var_0_6:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_WAR_GETINFO, self._onS2CGuildWarGetInfo, self)
	var_0_6:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, self._onS2CGuildNotifyLeave, self)
	var_0_6:addEventListener(var_0_1.EVENT_GAME_RESUME_FINISH, self._onS2CGameResumeFinish, self)
	var_0_6:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_WAR_NOTIFYPULLDATA, self._onS2CStageChangeNotify, self)
	var_0_6:addEventListener(var_0_1.EVENT_CLOUD_END, self._cloundEndEvent, self)
	var_0_8:setIsWaitDrillBattle(false)
	g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_GuildWar_Achieves_GetInfo({})
end

function GuildWarMainLayer:_cloundEndEvent()
	local var_4_0 = var_0_8:getStageType()

	if var_4_0 == var_0_3.StageType.FIGHT then
		if var_0_8:getFightStageType() ~= var_0_3.FightStageType.WAR_RESULT and var_0_8:isNeedShowLamu(var_0_8:getFightStageType()) then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.guildWar.view.pop.GuildWarStateOpenPop").new({
				state = var_0_8:getFightStageType()
			})))
		end
	elseif var_4_0 == var_0_3.StageType.DRILL and var_0_8:isNeedShowNewSeasonLamu() then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.guildWar.view.pop.GuildWarStateOpenPop").new({
			isNewSeason = true
		})))
	end
end

function GuildWarMainLayer:onUnload()
	self:_stopTimer()

	if not var_0_8:isOpenChat() then
		g.core.model.User.chatData:clearChatByChannel(var_0_2.ChatConst.GUILD_WAR)
	end
end

function GuildWarMainLayer:onRemoved()
	g.core.network.GameNetProxy:send_C2S_GuildWar_OpTab({
		op_type = var_0_4.EXIT
	})
	var_0_8:resetExitData()
end

function GuildWarMainLayer:_onS2CGuildGetInfo()
	local var_7_0, var_7_1 = var_0_8:isOpen()

	if var_7_0 then
		g.core.network.GameNetProxy:send_C2S_GuildWar_GetInfo({})
	else
		self:_stopTimer()
		var_0_5:tip(var_7_1)
		var_0_5:popModule({
			popScene = true
		})
	end
end

function GuildWarMainLayer:_onS2CGuildWarGetInfo()
	local var_8_0, var_8_1 = var_0_8:isOpen()

	if var_8_0 then
		if self._needReqSvrNotifyMsg then
			self._needReqSvrNotifyMsg = false

			g.core.network.GameNetProxy:send_C2S_GuildWar_OpTab({
				op_type = var_0_4.ENTER
			})
		end

		if var_0_8:isOpenChat() then
			g.core.network.GameNetProxy:send_C2S_BulletScreenGetInfo({
				type = g.core.model.User.chatData:toSvrChatType(var_0_2.ChatConst.GUILD_WAR)
			})
		end

		local var_8_2 = var_0_8:getStageType()

		self._preType = var_8_2 == var_0_3.StageType.FIGHT and var_0_8:getFightStageType() or var_8_2

		if self:_updateMainComp(var_8_2) then
			self:_updateBg()
		else
			self._mainComp:updateComp()
		end

		self._mainComp:onCD()
		self:_openTimer()
	else
		self:_stopTimer()
		var_0_5:tip(var_8_1)
		var_0_5:popModule({
			popScene = true
		})
	end
end

function GuildWarMainLayer:_onS2CGuildNotifyLeave(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.type == var_0_2.GuildCommonConst.LeaveType.REMOVE then
		var_0_5:tip(g.core.lang:get(109813))
	elseif arg_9_3.type == var_0_2.GuildCommonConst.LeaveType.DISSOLVE then
		var_0_5:tip(g.core.lang:get(109814))
	elseif arg_9_3.type == var_0_2.GuildCommonConst.LeaveType.MERGE then
		var_0_5:tip(g.core.lang:get(430013))
	end

	self:_stopTimer()
	var_0_5:popModule({
		popScene = true
	})
end

function GuildWarMainLayer:checkAndTickGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_GUIDE_RE_CHECK)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function GuildWarMainLayer:_onS2CGameResumeFinish()
	self._needReqSvrNotifyMsg = true

	g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
end

function GuildWarMainLayer:_onS2CStageChangeNotify()
	var_0_8:resetExitData()
	g.core.network.GameNetProxy:send_C2S_GuildWar_GetInfo({})
end

function GuildWarMainLayer:_onCD()
	local var_13_0 = var_0_7:getTime()

	if var_13_0 - self._exeTimerLastTime < var_0_0 then
		return
	end

	self._exeTimerLastTime = var_13_0

	local var_13_1 = var_0_8:getStageType()

	if var_13_1 == var_0_3.StageType.NONE then
		self:_stopTimer()
		var_0_5:popModule({
			popScene = true
		})
	else
		if self:_updateMainComp(var_13_1) then
			self:_updateBg()
			var_0_8:resetExitData()
		end

		self._mainComp:onCD()

		local var_13_2 = var_13_1

		if var_13_1 == var_0_3.StageType.FIGHT then
			var_13_2 = var_0_8:getFightStageType()
		end

		if self._preType ~= var_13_2 then
			self._preType = var_13_2

			g.core.network.GameNetProxy:send_C2S_GuildWar_GetInfo({})
		end
	end
end

function GuildWarMainLayer:_getMainCompName(arg_14_1)
	return arg_14_1 == var_0_3.StageType.FIGHT and var_0_3.MainCompName[var_0_8:getFightStageType()] or var_0_3.MainCompName[arg_14_1] or ""
end

function GuildWarMainLayer:_updateMainComp(arg_15_1)
	local var_15_0 = self:_getMainCompName(arg_15_1)

	assert(#var_15_0 > 0, "Error! GuildWarMainLayer MainCompName is empty!")

	if (self._mainComp and self._mainComp:getName()) == var_15_0 then
		return false
	end

	self.m_mainCompDad:removeChildren()

	local var_15_1 = fgui.UIPackage:createObject("guildWar", var_15_0, self)

	var_15_1:setSize(display.width, display.height)
	var_15_1:updateComp()
	var_15_1:playEnterAni()
	self.m_mainCompDad:addChildBase(var_15_1)

	self._mainComp = var_15_1

	return true
end

function GuildWarMainLayer:_openTimer()
	if self._timer then
		return
	end

	self._timer = self:newSchedule(handler(self, self._onCD), var_0_0)
end

function GuildWarMainLayer:_stopTimer()
	if self._timer then
		self:cancelSchedule(self._timer)

		self._timer = nil
	end
end

function GuildWarMainLayer:_updateBg(arg_18_1)
	if self._bgLoader then
		self._bgLoader:setURL((var_0_8:getStageType() == var_0_3.StageType.FIGHT or nil) and "bg/guildWar/bg_jtzf_kaizhan.jpg")
	else
		self._bgLoader = self.m_bgNode:addBg("bg/guildWar/bg_jtzf_kaizhan.jpg")
	end

	if not arg_18_1 then
		self.m_enterTransition:play()
	end
end

function GuildWarMainLayer:onClickBackBtn()
	if var_0_8:getIsWaitDrillBattle() then
		return
	end

	g.core.module.ModuleManager:popModule()
end

return GuildWarMainLayer
