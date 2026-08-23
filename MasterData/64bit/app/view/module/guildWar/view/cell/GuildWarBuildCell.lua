local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = g.core.model.User.resourceData
local var_0_2 = g.core.const.ConstMgr.GuildWarConst.StageType
local GuildWarBuildCell = class("GuildWarBuildCell", require("app.fairyGUI.guildWar.UI_GuildWarBuildCell"))

function GuildWarBuildCell:ctor()
	self._data = nil

	self.m_challengeBtn:addClickListener(handler(self, self._onChallengeClick))

	self.idleEff = nil
end

function GuildWarBuildCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_ATTACKBUILDING, handler(self, self._onRcvAttackBuilding), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_NOTIFY, handler(self, self._onRevNotify), self)
end

function GuildWarBuildCell:updateBuild(arg_3_1)
	self._data = arg_3_1
	self._cfg = arg_3_1.cfg

	self.m_buildLoader:setURL(g.core.common.Path:getGuildWarBuild(self._cfg.build_type))

	local var_3_0 = math.max(0, self._cfg.build_score - arg_3_1.score)

	self.m_hpTxt:setText(var_3_0 .. "/" .. self._cfg.build_score)
	self.m_progressComp:setProgress(var_3_0, self._cfg.build_score)

	if arg_3_1.hp > 0 and not self.idleEff then
		self.idleEff = self.m_effHolder:addEffectSpine({
			name = "eff_ui_guildwar_buildPop",
			anim = "idle",
			isLoop = true
		})
	end

	if var_3_0 == 0 then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function GuildWarBuildCell:_onRcvAttackBuilding(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_4.build_id ~= self._data.cfg.id then
		return
	end

	self.m_effHolder:addEffectSpine({
		name = "eff_ui_guildwar_buildPop",
		remove = true,
		anim = "play",
		isLoop = false
	})
	g.core.module.ModuleManager:tip(g.core.lang:get(308660, {
		num = self._cfg.attack_score
	}))

	if arg_4_4.awards and #arg_4_4.awards > 0 then
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:awardSummary(arg_4_4.awards)
		end, 0.7)
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.GUILD_WAR_OPEN_CHALLENGE_BUILD_BTN)

	self.idleEff = self.idleEff or self.m_effHolder:addEffectSpine({
		name = "eff_ui_guildwar_buildPop",
		anim = "idle",
		isLoop = true
	})
end

function GuildWarBuildCell:_onRevNotify(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4.guild_id ~= var_0_0:getCurWatchGuildId() then
		return
	end

	if arg_6_4.build_id ~= self._data.cfg.id then
		return
	end

	if arg_6_4.notify_type ~= 1 then
		return
	end

	self._data.hp = arg_6_4.total_lost_hp
	self._data.score = arg_6_4.build_lost_score

	self:updateBuild(self._data)
end

function GuildWarBuildCell:_onChallengeClick()
	if not self._data then
		return
	end

	if var_0_0:getStageType() ~= var_0_2.FIGHT then
		return
	end

	if g.core.common.ServerTime:isToday((g.core.model.User.guildData:getJoinGuildTime())) then
		g.core.module.ModuleManager:tip(g.core.lang:get(308665))

		return
	end

	if var_0_1:getGuildWar() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(308651))

		return
	end

	local var_7_0 = var_0_0:getCurWatchGuildId()

	if not self._data.canBattle then
		return
	end

	local var_7_1

	if self._data.cfg.build_hp - self._data.hp <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(308652))

		do return end

		var_7_1 = {
			guild_id = var_7_0
		}
	end

	var_7_1.build_id = self._data.cfg.id

	g.core.network.GameNetProxy:send_C2S_GuildWar_AttackBuilding(var_7_1)
end

return GuildWarBuildCell
