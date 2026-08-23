local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.GuildWarConst
local var_0_3 = {
	FIGHTING = 1,
	DEPLOY = 0
}
local var_0_4 = g.core.common.Goods
local var_0_5 = g.core.model.User
local var_0_6 = g.core.model.User.resourceData
local var_0_7 = g.core.model.User.guildWarData
local var_0_8 = g.core.common.ServerTime
local var_0_9 = g.core.module.ModuleManager
local GuildWarFightingStageMainComp = class("GuildWarFightingStageMainComp", require("app.fairyGUI.guildWar.UI_GuildWarFightStageMainComp"))

function GuildWarFightingStageMainComp:ctor()
	self._effectLeftNode = nil
	self._effectRightNode = nil

	self:_initPlayTimesComp()
	self.m_chatComp:setCurChannel(var_0_1.ChatConst.GUILD_WAR)
	self.m_deployBtn:addClickListener(handler(self, self._onClickDeployBtn))
	self.m_taskBtn:addClickListener(handler(self, self._onClickTaskBtn))
	self.m_warAwardBtn:addClickListener(handler(self, self._onClickWarAwardBtn))
	self.m_seasonAwardBtn:addClickListener(handler(self, self._onClickSeasonAwardBtn))
	self.m_myGuildCityBtn:addClickListener(handler(self, self._onClickCity))
	self.m_cityBtn_1:addClickListener(handler(self, self._onClickCity))
	self.m_cityBtn_2:addClickListener(handler(self, self._onClickCity))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShop))
	self.m_fightStageTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onFightStageTypeControllerChanged))
end

function GuildWarFightingStageMainComp:_onClickShop()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GUILE_WAR_SHOP)
end

function GuildWarFightingStageMainComp:updateComp()
	if var_0_7:getFightStageType() == var_0_2.FightStageType.FIGHTING then
		self.m_fightProgressComp:updateComp()
		self.m_fightStageTypeController:setSelectedIndex(var_0_3.FIGHTING)
		self.m_bgComp:addBgEffect()
	else
		self.m_warLeftRankComp:updateView()
		self.m_fightStageTypeController:setSelectedIndex(var_0_3.DEPLOY)
	end

	self.m_myGuildCityComp:updateComp(var_0_2.CityPos.DOWN, (var_0_7:getMyGuildStruct()))

	local var_3_0 = var_0_7:getEnemyGuildStructArr()

	table.sort(var_3_0, var_0_7:getGuildStructSortFunc_2())
	self.m_cityComp_1:updateComp(var_0_2.CityPos.LEFT, var_3_0[1], g.core.lang:get(308640))
	self.m_cityComp_2:updateComp(var_0_2.CityPos.RIGHT, var_3_0[2], g.core.lang:get(308641))
	self.m_titleComp:setStateText(g.core.lang:get(308633, {
		num = var_0_7:getWarNumNow(),
		max = var_0_7:getMaxWarNum()
	}))
	self:addEnemyEffect(var_3_0)
end

function GuildWarFightingStageMainComp:playEnterAni()
	self.m_enterTransition:play()
end

function GuildWarFightingStageMainComp:_onFightStageTypeControllerChanged()
	if var_0_7:getFightStageType() == var_0_2.FightStageType.FIGHTING then
		self.m_bgComp:addBgEffect()
		self:addEnemyEffect()
	end

	self:checkAndTickGuide()
end

function GuildWarFightingStageMainComp:onLoad()
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onS2CRankList, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._onS2CRankList, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_NET_S2C_GUILD_WAR_NOTIFY, self._onS2CNotify, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_NET_S2C_GUILD_WAR_NOTIFYSTRATEGY, self._onS2CNotifyStrategy, self)
	g.core.event.EventManager:addEventListener(var_0_0.EVENT_NET_S2C_GUILD_WAR_SETSTRATEGY, self._onS2CNotifyStrategy, self)
	g.core.event.EventManager:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
	g.core.event.EventManager:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_deployBtn
	})
	self.m_playTimesComp:updateView()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MINE_MAIN_LAYER)
end

function GuildWarFightingStageMainComp:checkAndTickGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_GUIDE_RE_CHECK)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function GuildWarFightingStageMainComp:onCD()
	if var_0_7:getFightStageType() == var_0_2.FightStageType.DEPLOY then
		local var_8_0, var_8_1 = var_0_7:getStartEndTime(var_0_2.StageType.FIGHT, var_0_2.FightStageType.DEPLOY)
		local var_8_2, var_8_3, var_8_4, var_8_5 = var_0_8:getLeftTimeParts(var_8_1)

		self.m_fightingCDTxt:setText((string.format("%02d:%02d:%02d", var_8_3, var_8_4, var_8_5)))
		self.m_fightStageTypeController:setSelectedIndex(var_0_3.DEPLOY)
	else
		self.m_fightStageTypeController:setSelectedIndex(var_0_3.FIGHTING)
	end

	local var_8_6, var_8_7 = var_0_7:getStartEndTime(var_0_2.StageType.FIGHT)

	self.m_titleComp:setTimeText((g.core.lang:get(308634, {
		time = var_0_8:getLeftDHMSFormat(var_8_7)
	})))
	self.m_scheduleComp:onCD()
end

function GuildWarFightingStageMainComp:addEnemyEffect(arg_9_1)
	if var_0_7:getFightStageType() ~= var_0_2.FightStageType.FIGHTING then
		self.m_effectLeftNode:setVisible(false)
		self.m_effectRightNode:setVisible(false)

		return
	end

	if not arg_9_1 then
		arg_9_1 = var_0_7:getEnemyGuildStructArr()

		table.sort(arg_9_1, var_0_7:getGuildStructSortFunc_2())
	end

	if arg_9_1[1] then
		self.m_effectLeftNode:setVisible(true)

		if self._effectLeftNode == nil then
			self._effectLeftNode = self.m_effectLeftNode:addEffectSpine({
				isLoop = true,
				name = "eff_ui_guildwar_mapline",
				anim = "play_1"
			})
		end

		if arg_9_1[1].strategyType == var_0_2.StrategyType.ATTACK then
			self._effectLeftNode:setAnimation(0, "play_1", true)
			self.m_effectLeftNode:setOpacity(255)
		else
			self._effectLeftNode:setAnimation(0, "play_1m", true)
			self.m_effectLeftNode:setOpacity(178)
		end
	end

	if arg_9_1[2] then
		self.m_effectRightNode:setVisible(true)

		if self._effectRightNode == nil then
			self._effectRightNode = self.m_effectRightNode:addEffectSpine({
				isLoop = true,
				name = "eff_ui_guildwar_mapline",
				anim = "play_2"
			})
		end

		if arg_9_1[2].strategyType == var_0_2.StrategyType.ATTACK then
			self._effectRightNode:setAnimation(0, "play_2", true)
			self.m_effectRightNode:setOpacity(255)
		else
			self._effectRightNode:setAnimation(0, "play_2m", true)
			self.m_effectRightNode:setOpacity(178)
		end
	end
end

function GuildWarFightingStageMainComp:_onS2CRankList()
	if var_0_7:getFightStageType() ~= var_0_2.FightStageType.FIGHTING then
		self.m_warLeftRankComp:updateView()
	end
end

function GuildWarFightingStageMainComp:_onS2CNotify()
	self:updateComp()
end

function GuildWarFightingStageMainComp:_onS2CNotifyStrategy()
	self.m_myGuildCityComp:updateStrategyType()
	self.m_cityComp_1:updateStrategyType()
	self.m_cityComp_2:updateStrategyType()
	self:addEnemyEffect()
end

function GuildWarFightingStageMainComp:_onClickTaskBtn()
	var_0_9:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarTaskPop").new(), {
		touchDisappear = false
	})
end

function GuildWarFightingStageMainComp:_onClickDeployBtn()
	if var_0_5.guildData:hasGuild() then
		var_0_9:pushModule(g.view.entrance.GUILD_WAR_SELF_CITY, {
			guildId = var_0_5.guildData:getGuildId()
		})
	end
end

function GuildWarFightingStageMainComp:_onClickWarAwardBtn()
	var_0_9:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarFightRankPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GuildWarFightingStageMainComp:_onClickSeasonAwardBtn()
	var_0_9:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarSeasonRankPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GuildWarFightingStageMainComp:_onClickCity(arg_17_1)
	local var_17_0 = arg_17_1:getSender():getName()

	if var_17_0 == self.m_myGuildCityBtn:getName() then
		self.m_myGuildCityComp:onClickCity()
	elseif var_17_0 == self.m_cityBtn_1:getName() then
		self.m_cityComp_1:onClickCity()
	elseif var_17_0 == self.m_cityBtn_2:getName() then
		self.m_cityComp_2:onClickCity()
	end
end

function GuildWarFightingStageMainComp:_initPlayTimesComp()
	self.m_playTimesComp:initView({
		type = var_0_4.RESOURCE.TYPE_GUILD_WAR,
		getTimesFunc = function()
			return var_0_6:getGuildWar()
		end,
		refreshEvent = {
			var_0_0.EVENT_RECOVER_STEP,
			var_0_0.EVENT_FORCE_FRESH,
			var_0_0.EVENT_NET_S2C_RFRESH_RESOURCE
		},
		onGetTimes = function()
			require("app.view.base.infoPop.BasePlayNumPop").createBuy(var_0_1.ShopConst.SHOP_ITEM_ID.GUILD_WAR)
		end
	})
end

return GuildWarFightingStageMainComp
