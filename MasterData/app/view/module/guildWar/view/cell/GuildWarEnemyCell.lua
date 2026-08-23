local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = g.core.model.User.resourceData
local var_0_2 = g.core.const.ConstMgr.GuildWarConst.StageType
local GuildWarEnemyCell = class("GuildWarEnemyCell", require("app.fairyGUI.guildWar.UI_GuildWarEnemyCell"))

function GuildWarEnemyCell:ctor()
	self._data = nil

	self.m_challengeBtn:addClickListener(handler(self, self._onChallengeClick))
end

function GuildWarEnemyCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_NOTIFY, handler(self, self._onRevNotify), self)
end

function GuildWarEnemyCell:updateEnemy(arg_3_1)
	self._data = arg_3_1

	local var_3_0 = arg_3_1.cfg.people_hp
	local var_3_1 = arg_3_1.playerData:getUser()
	local var_3_2 = math.max(0, arg_3_1.cfg.people_hp - arg_3_1.playerData:getCostHp())

	if var_3_1 then
		self.m_fightValueTxt:setText(var_3_1.fight_value)
		self.m_knightLoader:setIcon((g.core.common.Path:getKnightBookPicRes((var_3_1.show_knight_dress ~= 0 or nil) and (var_3_1.show_knight_dress or var_3_1.show_knight_id))))
		self.m_hpTxt:setText(var_3_2 .. "/" .. var_3_0)
		self.m_hpProgress:setMax(var_3_0)
		self.m_hpProgress:setValue(var_3_2)
		self.m_nameTxt:setText(var_3_1.name)
	end

	if var_3_2 > 0 then
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
	end
end

function GuildWarEnemyCell:_onChallengeClick()
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
		g.core.module.ModuleManager:tip(g.core.lang:get(308659))

		return
	end

	local var_4_0 = var_0_0:getCurWatchGuildId()
	local var_4_1

	if self._data.cfg.people_hp - self._data.playerData:getCostHp() <= 0 then
		do return end

		var_4_1 = {
			guild_id = var_4_0
		}
	end

	var_4_1.build_id = self._data.cfg.id
	var_4_1.position = self._data.playerData:getPosition()

	g.core.network.GameNetProxy:send_C2S_GuildWar_AttackDefenderBegin(var_4_1)
end

function GuildWarEnemyCell:_onRevNotify(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_4.guild_id ~= var_0_0:getCurWatchGuildId() then
		return
	end

	if arg_5_4.build_id ~= self._data.cfg.id then
		return
	end

	if arg_5_4.notify_type ~= 2 then
		return
	end

	if arg_5_4.position ~= self._data.playerData.position then
		return
	end

	self._data.playerData.hp = arg_5_4.total_lost_hp

	self:updateEnemy(self._data)
end

return GuildWarEnemyCell
