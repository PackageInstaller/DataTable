local var_0_0 = g.core.const.ConstMgr.GuildWarConst
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.model.User.guildWarData
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = 0
local var_0_6 = 3
local GuildWarDrillStageMainComp = class("GuildWarDrillStageMainComp", require("app.fairyGUI.guildWar.UI_GuildWarDrillStageMainComp"))

function GuildWarDrillStageMainComp:ctor(arg_1_1)
	self._stage = arg_1_1
	self._btnEffect = nil
	self.finallBattleTime = var_0_5
	self.isNeedUpdate = false

	self:initView()
end

function GuildWarDrillStageMainComp:initView()
	self.m_drillRankBtn:addClickListener(handler(self, self._onClickDrillRankBtn))
	self.m_seasonRankBtn:addClickListener(handler(self, self._onClickSeasonRankBtn))
	self.m_challengeBtn:addClickListener(handler(self, self._onClickChallengeBtn))
	self.m_formationBtn:addClickListener(handler(self, self._gotoFormation))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShop))
	self.m_playTimesComp:initView({
		playNum = g.core.const.ConstMgr.ShopConst.PLAY_TYPE.GUILD_WAR,
		getTimesFunc = function()
			return var_0_2:getLastDrillCount()
		end
	})
	self.m_titleComp:setStateText(g.core.lang:get(308619))
end

function GuildWarDrillStageMainComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_PRACTICE, self._onRcvBattleBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_PRACTICENOTIFY, self._onRcvDrillNotify, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_GUILD_FIGHT_MAIN_1)
end

function GuildWarDrillStageMainComp:_onClickShop()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GUILE_WAR_SHOP)
end

function GuildWarDrillStageMainComp:_onRcvBattleBegin(arg_6_1, arg_6_2, arg_6_3)
	g.core.battle.BattleProxy:enterBattle({
		canSkip = true,
		battle_id = arg_6_3.battle_id,
		type = BattleConst.TYPE_GUILDWAR,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		bgId = var_0_0.BATTLE_BG_ID
	})
	var_0_2:setIsWaitDrillBattle(false)

	self.finallBattleTime = var_0_1:getTime()
end

function GuildWarDrillStageMainComp:_onRcvDrillNotify()
	self.isNeedUpdate = true
	self.finallBattleTime = var_0_5
end

function GuildWarDrillStageMainComp:updateComp()
	self.m_playTimesComp:updateView()
	self:updateView()
end

function GuildWarDrillStageMainComp:_onCrossDay()
	g.core.network.GameNetProxy:send_C2S_GuildWar_GetInfo({})
end

function GuildWarDrillStageMainComp:updateView()
	self.m_rankComp:updateView()
	self.m_playTimesComp:updateView()
	self.m_myScoreText:setText((var_0_2:getDrillUserScore()))

	if var_0_2:getLastDrillCount() > 0 then
		self.m_hasChallengeCountController:setSelectedIndex(1)

		if self._btnEffect == nil then
			self._btnEffect = self.m_challengeEffect:addEffectSpine({
				anim = "idle",
				name = "eff_ui_guildwar_btnAciton",
				isLoop = true
			})
		else
			self._btnEffect:setAnimation(0, "idle", true)
		end
	else
		self.m_hasChallengeCountController:setSelectedIndex(0)
	end
end

function GuildWarDrillStageMainComp:onCD()
	local var_11_0, var_11_1 = var_0_2:getStartEndTime(var_0_0.StageType.DRILL)

	self.m_titleComp:setTimeText(g.core.lang:get(308604, {
		time = var_0_1:getLeftDHMSFormat(var_11_1)
	}))

	if self.isNeedUpdate then
		self.isNeedUpdate = false

		self:updateView()
	end

	if self.finallBattleTime ~= var_0_5 and var_0_1:getTime() - self.finallBattleTime > var_0_6 then
		self.finallBattleTime = var_0_5

		var_0_2:resetExitData()
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 100,
			id = g.core.network.proto.GUILD_WAR_PRACTICE_SCORE_CROSS
		})
	end
end

function GuildWarDrillStageMainComp:playEnterAni()
	self.m_enterTransition:play()
end

function GuildWarDrillStageMainComp:_onClickChallengeBtn()
	if var_0_2:getLastDrillCount() > 0 then
		var_0_2:setIsWaitDrillBattle(true)
		g.core.network.GameNetProxy:send_C2S_GuildWar_Practice({})
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.GUILD_WAR_DRILL_CHALLENGE_BTN)
	end

	if self._btnEffect then
		self._btnEffect:setAnimation(0, "click", false)
	end
end

function GuildWarDrillStageMainComp:_onClickDrillRankBtn()
	var_0_4:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarDrillRankPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GuildWarDrillStageMainComp:_onClickSeasonRankBtn()
	var_0_4:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarSeasonRewardPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GuildWarDrillStageMainComp:_gotoFormation()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

return GuildWarDrillStageMainComp
