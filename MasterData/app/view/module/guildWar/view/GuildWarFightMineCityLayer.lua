local var_0_0 = 1
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.GuildWarConst
local var_0_3 = g.core.const.ConstMgr.GuildWarConst.FightStageType
local var_0_5 = g.core.event.enum
local var_0_6 = g.core.event.EventManager
local var_0_7 = {
	EXIT = 2,
	ENTER = 1
}
local var_0_8 = g.core.config.guild_war_parameter_info
local var_0_9 = g.core.module.ModuleManager
local var_0_10 = g.core.model.User.resourceData
local var_0_11 = g.core.model.User.guildWarData
local var_0_12 = g.core.const.ConstMgr.GuideConst
local var_0_13 = g.core.common.ServerTime
local KsMath = require("app.core.utils.KsMath")
local GuildWarFightMineCityLayer = class("GuildWarFightMineCityLayer", require("app.fairyGUI.guildWar.UI_GuildWarFightMineCityLayer"), function()
	return fgui.GComponent:create({
		resName = "GuildWarFightMineCityLayer",
		pkgPath = "ui/guildWar/guildWar",
		isFullScreen = true,
		pkgName = "guildWar"
	}, ...)
end)

function GuildWarFightMineCityLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._guildId = arg_2_1.guildId or 0
	self._cityPos = arg_2_1.cityPos or var_0_2.CityPos.DOWN
	self._timer = nil
	self._exeTimerLastTime = 0

	self.m_topBarComp:setResInfoById(var_0_2.HELP_ID)

	self._maxScore = var_0_8.get(var_0_2.PARAM_MAX_SCORE_ID).parameter

	self.m_quickOpeBtn:addClickListener(handler(self, self._onFastFormat))

	self._guildStruct = var_0_11:getGuildWarGuildStruct(self._guildId)

	self.m_guildNameTxt:setText(self._guildStruct.guildSnapshot.name)
	self.m_cityNameTxt:setText(self._guildStruct.cityName)
	self.m_guildIcon:setURL((g.core.common.Path:getGuildSignOrFrameById(self._guildStruct.guildSnapshot.icon)))

	self._guildWarMinX = display.width - self.m_contentComp:getWidth()
	self._guildWarMaxX = 0

	if self._guildWarMinX < 0 then
		self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
		self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	end

	self.m_topBarComp:setReturnCallBack(handler(self, self._onReturnClick))
	self.m_arrowImg2:setVisible(false)
	self.m_contentComp:setGuildId(self._guildId, self._cityPos)

	if self._guildStruct then
		if self._guildStruct:isMyGuild() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
				tickType = 6,
				enum = var_0_12.ENUM_TICK.GUIDE_WAR_DEVELOP
			})
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
				tickType = 6,
				enum = var_0_12.ENUM_TICK.GUIDE_WAR_FIGHT
			})
		end
	end

	self._waitState = true

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self.m_enterTransition:play(handler(self, self.onEnterAnimTransFinish))
	self.m_chatComp:setCurChannel(var_0_1.ChatConst.GUILD_WAR)
end

function GuildWarFightMineCityLayer:onLoad()
	if self._guildStruct:isMyGuild() then
		var_0_11:enteredMineCityLayer()
	end

	var_0_6:addEventListener(var_0_5.EVENT_NET_S2C_GUILD_GETINFO, self._onS2CGuildGetInfo, self)
	var_0_6:addEventListener(var_0_5.EVENT_NET_S2C_GUILD_WAR_GETINFO, self._onS2CGuildWarGetInfo, self)
	var_0_6:addEventListener(var_0_5.EVENT_NET_S2C_GUILD_WAR_NOTIFY, handler(self, self._onRevNotify), self)
	var_0_6:addEventListener(var_0_5.EVENT_NET_S2C_GUILD_WAR_GETFORMATION, self.updateInfoView, self)
	var_0_6:addEventListener(var_0_5.EVENT_GAME_RESUME_FINISH, self._onS2CGameResumeFinish, self)
	var_0_6:addEventListener(var_0_5.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, self._onS2CGuildNotifyLeave, self)
	self.m_arrowImg:addEffectSpine({
		anim = "play",
		name = "eff_ui_arena_cutarrow",
		isLoop = true
	})
	self.m_arrowImg2:addEffectSpine({
		anim = "play",
		name = "eff_ui_arena_cutarrow",
		isLoop = true
	})
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MINE_MAIN_LAYER)
	self:onUpdateState()

	if self._guildStruct:isMyGuild() then
		self.m_playTimeComp:setVisible(false)
	else
		self.m_playTimeComp:initView({
			type = g.core.common.Goods.RESOURCE.TYPE_GUILD_WAR,
			getTimesFunc = function()
				return var_0_10:getGuildWar()
			end,
			refreshEvent = {
				g.core.event.enum.EVENT_RECOVER_STEP,
				g.core.event.enum.EVENT_FORCE_FRESH,
				g.core.event.enum.EVENT_NET_S2C_RFRESH_RESOURCE
			},
			onGetTimes = function()
				require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.GUILD_WAR)
			end
		})
		self.m_playTimeComp:setVisible(true)
	end

	g.core.network.GameNetProxy:send_C2S_GuildWar_GetFormation({
		guild_id = self._guildId
	})

	if var_0_11:getStageType() == var_0_2.StageType.NONE then
		self:_stopTimer()
		var_0_9:switchModuleIntelligent(g.view.entrance.HOME)
	else
		self:_openTimer()
	end
end

function GuildWarFightMineCityLayer:onEnterAnimTransFinish()
	self._waitState = false

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
end

function GuildWarFightMineCityLayer:_onTouchBegin(arg_7_1)
	arg_7_1:captureTouch()
end

function GuildWarFightMineCityLayer:_onTouchMove(arg_8_1)
	local var_8_0 = KsMath.rangeIn(self.m_contentComp:getX() + arg_8_1:getInput():getTouch():getDelta().x, self._guildWarMinX, self._guildWarMaxX)

	self.m_contentComp:setX(var_8_0)

	if math.abs(var_8_0 - self._guildWarMinX) < 10 then
		self.m_arrowImg:setVisible(false)
	else
		self.m_arrowImg:setVisible(true)
	end

	if math.abs(var_8_0 - self._guildWarMaxX) < 10 then
		self.m_arrowImg2:setVisible(false)
	else
		self.m_arrowImg2:setVisible(true)
	end
end

function GuildWarFightMineCityLayer:onScroll()
	if self._scrollPanel:getPercX() > 0.8 then
		self.m_arrowImg:setVisible(false)
	else
		self.m_arrowImg:setVisible(true)
	end
end

function GuildWarFightMineCityLayer:onUpdateState()
	if not var_0_11:isLeader() or var_0_11:getFightStageType() ~= var_0_3.DEPLOY or var_0_11:getCurWatchGuildId() ~= var_0_11:getMyGuildId() then
		self.m_quickOpeBtn:setVisible(false)
	else
		self.m_quickOpeBtn:setVisible(true)
	end

	self.m_typeController:setSelectedIndex(0)
	self.m_stageComp:updateStage()

	local var_10_0 = var_0_11:getFightStageType()

	if var_10_0 == var_0_3.DEPLOY then
		self.m_stageController:setSelectedIndex(0)
	elseif var_10_0 == var_0_3.FIGHTING then
		self.m_stageController:setSelectedIndex(1)
	else
		self.m_stageController:setSelectedIndex(2)
	end
end

function GuildWarFightMineCityLayer:_onReturnClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
		isSpine = true,
		forceCallFunc = true,
		callback = function()
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	})
end

function GuildWarFightMineCityLayer:_onRevNotify(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = var_0_11:getMyGuildId()

	if arg_13_4.guild_id ~= var_13_0 and arg_13_4.self_guild_id ~= var_13_0 then
		return
	end

	self:updateInfoView()
end

function GuildWarFightMineCityLayer:updateInfoView()
	self:onUpdateState()

	if self._guildStruct:isMyGuild() then
		self.m_typeController:setSelectedIndex(0)
	else
		self.m_typeController:setSelectedIndex(1)
	end

	self.m_progressTxt:setText(math.min(self._guildStruct:getTodayTotalScore(), self._maxScore) .. "(" .. var_0_11:getGuildScorePercentage(self._guildStruct.guildId) .. "%)")
end

function GuildWarFightMineCityLayer:_onFastFormat()
	if var_0_11:isAllLineUp() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308647))

		return
	end

	g.core.network.GameNetProxy:send_C2S_GuildWar_FastFormat({})
end

function GuildWarFightMineCityLayer:_onS2CGameResumeFinish()
	g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
end

function GuildWarFightMineCityLayer:_onS2CGuildNotifyLeave(arg_17_1, arg_17_2, arg_17_3)
	if arg_17_3.type == var_0_1.GuildCommonConst.LeaveType.REMOVE then
		var_0_9:tip(g.core.lang:get(109813))
	elseif arg_17_3.type == var_0_1.GuildCommonConst.LeaveType.DISSOLVE then
		var_0_9:tip(g.core.lang:get(109814))
	elseif arg_17_3.type == var_0_1.GuildCommonConst.LeaveType.MERGE then
		var_0_9:tip(g.core.lang:get(430013))
	end

	self:_stopTimer()
	var_0_9:switchModuleIntelligent(g.view.entrance.HOME)
end

function GuildWarFightMineCityLayer:_onS2CGuildGetInfo()
	local var_18_0, var_18_1 = var_0_11:isOpen()

	if var_18_0 then
		g.core.network.GameNetProxy:send_C2S_GuildWar_GetInfo({})
	else
		self:_stopTimer()
		var_0_9:tip(var_18_1)
		var_0_9:popModule({
			popScene = true
		})
	end
end

function GuildWarFightMineCityLayer:_onS2CGuildWarGetInfo()
	local var_19_0, var_19_1 = var_0_11:isOpen()

	if var_19_0 then
		if var_0_11:isOpenChat() then
			g.core.network.GameNetProxy:send_C2S_BulletScreenGetInfo({
				type = g.core.model.User.chatData:toSvrChatType(var_0_1.ChatConst.GUILD_WAR)
			})
		end

		if var_0_11:getStageType() == var_0_2.StageType.FIGHT then
			if var_0_11:getFightStageType() == var_0_3.WAR_RESULT then
				self:_stopTimer()
				var_0_9:tip(g.core.lang:get(308617))
				var_0_9:popModule({
					popScene = true
				})
			else
				g.core.network.GameNetProxy:send_C2S_GuildWar_GetFormation({
					guild_id = self._guildId
				})
				g.core.network.GameNetProxy:send_C2S_GuildWar_OpTab({
					op_type = var_0_7.ENTER
				})
			end
		else
			self:_stopTimer()
			var_0_9:tip(g.core.lang:get(308654))
			var_0_9:popModule({
				popScene = true
			})
		end
	else
		self:_stopTimer()
		var_0_9:tip(var_19_1)
		var_0_9:switchModuleIntelligent(g.view.entrance.HOME)
	end
end

function GuildWarFightMineCityLayer:_onCD()
	local var_20_0 = var_0_13:getTime()

	if var_20_0 - self._exeTimerLastTime < var_0_0 then
		return
	end

	self._exeTimerLastTime = var_20_0

	local var_20_1 = var_0_11:getStageType()

	if var_20_1 == var_0_2.StageType.NONE then
		self:_stopTimer()
		var_0_9:tip(g.core.lang:get(308618))
		var_0_9:switchModuleIntelligent(g.view.entrance.HOME)
	elseif var_20_1 == var_0_2.StageType.FIGHT then
		if var_0_11:getFightStageType() == var_0_3.WAR_RESULT then
			self:_stopTimer()
			var_0_9:tip(g.core.lang:get(308617))
			var_0_9:popModule({
				popScene = true
			})
		else
			self.m_stageComp:onCD()
		end
	else
		self.m_stageComp:onCD()
	end
end

function GuildWarFightMineCityLayer:_openTimer()
	if self._timer then
		return
	end

	self._timer = self:newSchedule(handler(self, self._onCD), var_0_0)
end

function GuildWarFightMineCityLayer:_stopTimer()
	if self._timer then
		self:cancelSchedule(self._timer)

		self._timer = nil
	end
end

function GuildWarFightMineCityLayer:onUnload()
	self:_stopTimer()

	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end

	if not var_0_11:isOpenChat() then
		g.core.model.User.chatData:clearChatByChannel(var_0_1.ChatConst.GUILD_WAR)
	end
end

return GuildWarFightMineCityLayer
