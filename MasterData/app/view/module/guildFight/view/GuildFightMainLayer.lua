local RelationType = require("app.core.fairygui.RelationType")
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.model.User.GuildFightData
local GuildFightMainLayer = class("GuildFightMainLayer", require("app.fairyGUI.guildFight.UI_GuildFightMainLayer"), function()
	return fgui.GComponent:create({
		resName = "GuildFightMainLayer",
		pkgPath = "ui/guildFight/guildFight",
		isFullScreen = true,
		pkgName = "guildFight"
	}, ...)
end)

function GuildFightMainLayer:ctor(arg_2_1)
	self._isFirstEnter = true
	self._type = 1
	self._battle = false
	self._schedulerId = nil
	self._curCompCache = {}
	self._curComp = nil

	self.m_topBar:setResInfoById(70)

	self._openDays = g.core.common.ServerTime:getOpenDays()

	self.m_reportBtn:addClickListener(handler(self, self._onClickReportBtn))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_progComp:addClickListener(handler(self, self._onClickProgressReward))
	self.m_progComp:setRedId(10)
	self:_updateBg()
	self:_showBgEff()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.GUILDFIGHT_PLAYERLEVEL)
end

function GuildFightMainLayer:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GUILD_BATTLE_GETINFO, self._onRcvGetInfo, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GUILD_BATTLE_NOTICENEWCHARIOT, self._updateCurComp, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GUILD_BATTLE_NOTICESCORE, self._onRcvUpdateScore, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GUILD_BATTLE_NOTICEUSER, self._updateCurComp, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, self._onRcvNotifyLeave, self)
	var_0_2:addEventListener(var_0_3.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	g.core.network.GameNetProxy:send_C2S_GuildBattle_GetInfo({
		is_match = true
	})
	self.m_enterTransition:play()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	self.m_playTimesComp:updateView()
end

function GuildFightMainLayer:onUnload()
	if self._schedulerId then
		self:cancelSchedule(self._schedulerId)

		self._schedulerId = nil
	end
end

function GuildFightMainLayer:_updateBg()
	self.m_bgIcon = self:addBg("bg/guild/bg_jt_zuihoufangxian_1.jpg", false)

	local var_5_0, var_5_1 = var_0_4:isNormal()

	if var_5_1 == 2 then
		self.m_bgIcon:setURL("bg/guild/bg_jt_zuihoufangxian_2.jpg")
	end
end

function GuildFightMainLayer:_onClickReportBtn()
	var_0_1:pushPopup((require("app.view.module.guildFight.view.GuildFightRecordPop").new()))
end

function GuildFightMainLayer:_onClickRankBtn()
	var_0_1:pushPopup((require("app.view.module.guildFight.view.GuildFightRankPop").new()))
end

function GuildFightMainLayer:_onClickProgressReward()
	var_0_1:pushPopup((require("app.view.module.guildFight.view.GuildFightProgressAwardPop").new()))
end

function GuildFightMainLayer:_onRcvGetInfo()
	local var_9_0, var_9_1 = var_0_4:isNormal()

	self._type = var_9_1

	if self._type == 2 then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 50,
			id = g.core.network.proto.GUILD_BATTLE_SCORE_CROSS
		})
	end

	self:_updateBg()
	self:_refreshPlayMode()
	self:_refreshLeftCount()
	self:_refreshBoxProg()
	self:_updateCurComp()
end

function GuildFightMainLayer:_refreshPlayMode()
	self.m_typeController:setSelectedIndex(self._type - 1)
	g.core.sound.SoundManager:playMusic((self._type == 2 or nil) and g.core.const.ConstMgr.SoundConst.BGM.MUSIC_GUILD_FIGHT_MAIN_2)
end

function GuildFightMainLayer:_refreshLeftCount()
	self.m_playTimesComp:initView({
		playNum = 41,
		getTimesFunc = function()
			return var_0_4:getLeftTimes()
		end
	})
end

function GuildFightMainLayer:_refreshBoxProg()
	local var_13_0 = var_0_4:getCurStateTargetScore() or var_0_4:getTargetMaxScoreByType(self._type)

	self.m_progComp:setPercent({
		cur = var_0_4:getGuildScore(),
		max = var_13_0
	})
	self.m_progComp:updateRedPoint()
end

function GuildFightMainLayer:_onCrossDayUpdate()
	if not g.core.model.User.GuildFightData:isInOpenTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.GUILD_CAMPAIGN)

		return
	end

	var_0_1:popAllPopup()
	g.core.model.User.GuildFightData:setMatchState(true)

	self._schedulerId = self:newScheduleOnce(function()
		if g.core.model.User.GuildFightData:getMatchState() then
			g.core.network.GameNetProxy:send_C2S_GuildBattle_GetInfo({
				is_match = true
			})
		end
	end, 6)

	self:_showBgEff()
end

function GuildFightMainLayer:_updateCurComp()
	if not self._curCompCache[self._type] then
		self:_createComp()
	end

	if self._type == 1 and self._curCompCache[2] then
		self._curCompCache[2]:setVisible(false)
	elseif self._type == 2 and self._curCompCache[1] then
		self._curCompCache[1]:setVisible(false)
	end

	self._curComp = self._curCompCache[self._type]

	self._curComp:updateComp()
	self._curComp:setVisible(true)
end

function GuildFightMainLayer:_onRcvUpdateScore()
	self:_refreshBoxProg()
end

function GuildFightMainLayer:_onRcvNotifyLeave(arg_18_1, arg_18_2, arg_18_3)
	if arg_18_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.REMOVE then
		g.core.module.ModuleManager:tip(g.core.lang:get(109547))
	elseif arg_18_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.DISSOLVE then
		g.core.module.ModuleManager:tip(g.core.lang:get(109548))
	elseif arg_18_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.MERGE then
		g.core.module.ModuleManager:tip(g.core.lang:get(430013))
	end

	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function GuildFightMainLayer:_createComp()
	local var_19_0 = {
		RelationType.Center_Center,
		RelationType.Middle_Middle
	}
	local var_19_2 = fgui.UIPackage:createObject("guildFight", self._type == 1 and "GuildFightNormalComp" or "GuildFightChariotComp", self)

	var_19_2:setPivot(0.5, 0.5, true)
	var_19_2:setPosition(display.width / 2, display.height / 2)

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		var_19_2:addRelation(self, iter_19_1, true)
	end

	self:getView():addChildAt(var_19_2, 2)

	self._curCompCache[self._type] = var_19_2
end

function GuildFightMainLayer:receiveCompEvent(arg_20_1, arg_20_2)
	if arg_20_1 == "box_award_receive" then
		-- block empty
	elseif arg_20_1 == "get_box_award" then
		self:_refreshBoxProg()
	end
end

function GuildFightMainLayer:getOenKeyBoxRewards()
	local var_21_0 = var_0_4:getGuildFightCanGetAwardId()

	if #var_21_0 <= 0 then
		return
	end

	local var_21_1 = {}
	local var_21_2 = var_0_4:getGuildIds()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if var_21_2[iter_21_1] then
			table.insert(var_21_1, var_21_2[iter_21_1])
		end
	end

	if #var_21_1 <= 0 then
		return
	end

	g.core.network.GameNetProxy:send_C2S_GuildBattle_Award_OneKey({
		id = var_21_1
	})
end

function GuildFightMainLayer:_showBgEff()
	if self._bgEffNode then
		self._bgEffNode:removeFromParent()

		self._bgEffNode = nil
	end

	self._bgEffNode = self.m_effBg:addEffectSpine({
		name = "eff_ui_guildFight_bg",
		isLoop = true,
		anim = (not var_0_4:isNormal() or nil) and "play2"
	})
end

return GuildFightMainLayer
