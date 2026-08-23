local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.const.ConstMgr.GuildBossConst
local var_0_2 = g.core.model.User.guildBossData
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.const.ConstMgr.SpineConst
local GuildBossMainLayer = class("GuildBossMainLayer", require("app.fairyGUI.guildBoss.UI_GuildBossMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "guildBoss",
		isFullScreen = true,
		pkgPath = "ui/guildBoss/guildBoss",
		resName = "GuildBossMainLayer"
	})
end)

function GuildBossMainLayer:ctor()
	self._bossInfo = nil
	self._infoList = nil
	self._lastUpdateTime = nil
	self._btnRefreshState = {
		robBtn = true,
		battleBtn = true
	}
	self._battleStateCtr = self.m_battleBtn:getController("state")
	self._robStateCtr = self.m_robBtn:getController("state")

	self:_initComp()
	self:_addListener()
end

function GuildBossMainLayer:onLoad()
	self:_addNetWorkListener()
	self:_sendRankMsg()
	self:_updateLayer()
	self:newSchedule(handler(self, self._updateCountDown), 1)
	g.core.network.GameNetProxy:send_C2S_GuildBoss_GetInfo({})
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_BOSS)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_GUILD_BOSS)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function GuildBossMainLayer:_initComp()
	self:_initData()
	self:_initUI()
end

function GuildBossMainLayer:_updateCountDown()
	local var_5_0

	if not var_0_0:isToday(self._lastUpdateTime) then
		self:_initData()
		self:_updateLayer()

		var_5_0 = self.m_stateController:getSelectedIndex()
	end

	if var_0_2:isProcess() then
		self.m_rankComp:updateCountDown()
		self:_updateBattleBtn()

		if var_5_0 ~= 0 then
			self:_updateLayer()
		end
	elseif var_5_0 == 0 then
		self:_updateLayer()
	end
end

function GuildBossMainLayer:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "GuildBossTabGroupComp_change" then
		self.m_changeKnightTransition:play()
		self:_updateView(arg_6_2.index)
	elseif arg_6_1 == "GuildBossMonsterComp_clickBoss" then
		self:_onClickBattle()
	end
end

function GuildBossMainLayer:_initData()
	self._bossInfo = var_0_2:getTodayBossInfo()
	self._infoList = var_0_2:getInfoList()
	self._lastUpdateTime = var_0_0:getTime()
end

function GuildBossMainLayer:_initUI()
	self:addBg("bg/guild/bg_jt_yuanyingtaofa.jpg")
	self.m_topBar:setResInfoById(69)
end

function GuildBossMainLayer:_addListener()
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattle))
	self.m_robBtn:addClickListener(handler(self, self._onClickRob))
end

function GuildBossMainLayer:_addNetWorkListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvCommonRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._onUpdateRankComp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onUpdateRankComp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_GETINFO, self._onRcvGuildBossInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_CHALLENGEBOSSBEGIN, self._onRcvGuildBossChallengeBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_GETROBUSERLIST, self._onRcvGetRobUserList, self)
end

function GuildBossMainLayer:_updateLayer()
	self._btnRefreshState = {
		robBtn = true,
		battleBtn = true
	}

	local var_11_0 = var_0_0:getWeekDay()

	if var_0_2:isProcess() then
		if var_11_0 == 0 then
			var_11_0 = 7
		end

		var_11_0 = math.min(math.max(1, var_11_0), 7)

		self:_updateView(var_11_0)
		self.m_stateController:setSelectedIndex(0)
		self.m_rankComp:updateCountDown()
		self:_updateBattleBtn()
		self:newSchedule(handler(self, function()
			self:_sendRankMsg()
			g.core.network.GameNetProxy:send_C2S_GuildBoss_GetInfo({})
		end), 60)
	else
		self:_updateView((self.m_weekComp:setWeekDay((math.min(math.max(1, var_11_0 + 1), 7)))))

		if self._bossInfo then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(2)
		end
	end

	self.m_rankComp:updateAwardList()
end

function GuildBossMainLayer:_updateView(arg_13_1)
	self.m_bgPic:setURL("pic/guildBoss/" .. self._infoList[arg_13_1].info.back .. ".png")
	self.m_knightPicComp:updateKnight({
		resId = self._infoList[arg_13_1].info.show_model
	})
	self.m_knightPicComp:setAlphaRect(var_0_5.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 200)
	self.m_rankComp:updateBossName(self._infoList[arg_13_1].info)
	self.m_groundBuffTxt:setText((g.core.utils.String.formatPassiveSkillDesc(self._infoList[arg_13_1].info.player_passive)))
end

function GuildBossMainLayer:_updateBattleBtn()
	if self._btnRefreshState.battleBtn then
		if 0 <= 0 then
			self.m_battleTxt:setText(g.core.lang:get(306502, {
				num = var_0_2:getLeftChallengeNum()
			}))
			self.m_battleBtn:setTouchable(true)
			self._battleStateCtr:setSelectedIndex(0)

			self._btnRefreshState.battleBtn = false
		else
			self.m_battleTxt:setText((var_0_0:secondToMSString((var_0_2:getChallengeCountdown()))))
		end
	end

	if self._btnRefreshState.robBtn then
		if 0 <= 0 then
			self.m_robTxt:setText(g.core.lang:get(306502, {
				num = var_0_2:getLeftRobNum()
			}))
			self.m_robBtn:setTouchable(true)
			self._robStateCtr:setSelectedIndex(0)

			self._btnRefreshState.robBtn = false
		else
			self.m_robTxt:setText((var_0_0:secondToMSString((var_0_2:getRobCountdown()))))
		end
	end
end

function GuildBossMainLayer:_sendRankMsg()
	if not self._bossInfo then
		-- block empty
	elseif self._bossInfo.type == var_0_1.TYPE_LOCAL_SERVER then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 50,
			id = g.core.network.proto.GUILD_BOSS_USER_LOCAL
		})
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 30,
			id = g.core.network.proto.GUILD_BOSS_GUILD_LOCAL
		})
	elseif self._bossInfo.type == var_0_1.TYPE_CROSS_SERVER then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 50,
			id = g.core.network.proto.GUILD_BOSS_USER_CROSS
		})
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 30,
			id = g.core.network.proto.GUILD_BOSS_GUILD_CROSS
		})
	end
end

function GuildBossMainLayer:_onClickBattle()
	if var_0_2:getLeftChallengeNum() <= 0 then
		var_0_4:tip(g.core.lang:get(306503))

		return
	end

	if var_0_2:getChallengeCountdown() > 0 then
		var_0_4:tip(g.core.lang:get(306504))

		return
	end

	self._btnRefreshState.battleBtn = true

	self.m_battleBtn:setTouchable(false)
	self._battleStateCtr:setSelectedIndex(1)
	g.core.network.GameNetProxy:send_C2S_GuildBoss_ChallengeBossBegin({
		id = self._bossInfo.id
	})
end

function GuildBossMainLayer:_onClickRob()
	if var_0_2:getLeftRobNum() <= 0 then
		var_0_4:tip(g.core.lang:get(306505))

		return
	end

	if var_0_2:getRobCountdown() > 0 then
		var_0_4:tip(g.core.lang:get(306506))

		return
	end

	self._btnRefreshState.robBtn = true

	self.m_robBtn:setTouchable(false)
	self._robStateCtr:setSelectedIndex(1)
	g.core.network.GameNetProxy:send_C2S_GuildBoss_GetRobUserList({
		id = self._bossInfo.id
	})
end

function GuildBossMainLayer:_setPlayerPassiveText()
	self.m_buffTxt:setText((g.core.utils.String.formatPassiveSkillDesc(self._bossInfo.player_passive)))
end

function GuildBossMainLayer:_onUpdateRankComp()
	self.m_rankComp:onUpdateRank()
end

function GuildBossMainLayer:_onRcvCommonRankList(arg_20_1, arg_20_2, arg_20_3)
	if not arg_20_3.rank_units and self.m_stateController:getSelectedIndex() ~= 0 then
		self.m_rankComp:updateAwardList()
		self.m_stateController:setSelectedIndex(2)
	else
		arg_20_3.self_rank = arg_20_3.self_rank or 0

		self.m_rankComp:updateRankData(arg_20_3, self._bossInfo)
	end
end

function GuildBossMainLayer:_onRcvGetRobUserList(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_3.list or {}

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		if arg_22_0.rank ~= 0 and arg_22_1.rank ~= 0 then
			return arg_22_0.rank < arg_22_1.rank
		end

		if arg_22_0.rank == 0 and arg_22_1.rank == 0 then
			return arg_22_0.score > arg_22_1.score
		else
			return arg_22_0.rank ~= 0
		end
	end)

	if #var_21_0 == 0 then
		var_0_4:tip(g.core.lang:get(306507))
	else
		self:addPopup(require("app.view.module.guildBoss.view.GuildBossRobPop"):new(self._bossInfo))
	end
end

function GuildBossMainLayer:_onRcvGuildBossInfo()
	self._btnRefreshState = {
		robBtn = true,
		battleBtn = true
	}

	self:_updateBattleBtn()
end

function GuildBossMainLayer:_onRcvGuildBossChallengeBegin(arg_24_1, arg_24_2, arg_24_3)
	g.core.battle.BattleProxy:enterBattle({
		soundType = 4,
		type = BattleConst.TYPE_GUILD_BOSS,
		battle_id = arg_24_3.battle_id,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		bgId = g.core.config.guild_boss_info.get(arg_24_3.id).battle_stage
	})
end

return GuildBossMainLayer
