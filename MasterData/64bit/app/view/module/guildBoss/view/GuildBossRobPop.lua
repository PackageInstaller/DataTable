local var_0_0 = g.core.model.User.guildBossData
local BattleConst = require("app.view.battle.const.BattleConst")
local GuildBossRobPop = class("GuildBossRobPop", require("app.fairyGUI.guildBoss.UI_GuildBossRobPop"), function()
	return fgui.GComponent:create({
		resName = "GuildBossRobPop",
		pkgName = "guildBoss",
		pkgPath = "ui/guildBoss/guildBoss"
	})
end)

function GuildBossRobPop:ctor(arg_2_1, arg_2_2)
	self._list = arg_2_1
	self._bossInfo = arg_2_2

	self:showAtCenter(true)
	self.m_robList:setVirtual(self)
	self.m_robList:setItemRenderer(handler(self, self._onRenderRob))
end

function GuildBossRobPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_BOSS_ROBUSERBEGIN, self._onRcvRobUserBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateList), self)
	self:_updateList()
end

function GuildBossRobPop:_onRenderRob(arg_4_1, arg_4_2)
	if self._list[arg_4_1 + 1] then
		arg_4_2:updateRobCell({
			data = self._list[arg_4_1 + 1],
			bossInfo = self._bossInfo
		})
	end
end

function GuildBossRobPop:_updateList()
	local var_5_0 = var_0_0:getUserInfo().score
	local var_5_1 = #self._list - 1

	for iter_5_0 = 1, #self._list do
		if var_5_0 > self._list[iter_5_0].score then
			var_5_1 = iter_5_0 - 1

			break
		end
	end

	self.m_robList:setNumItems(#self._list)
	self.m_robList:animateShowCells()
	self.m_robList:scrollToView(var_5_1)
end

function GuildBossRobPop:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "GuildBossRobCell_clickRob" then
		if arg_6_2.user then
			g.core.network.GameNetProxy:send_C2S_GuildBoss_RobUserBegin({
				id = self._bossInfo.id,
				user_id = arg_6_2.user.id
			})
		end
	end
end

function GuildBossRobPop:_onRcvRobUserBegin(arg_7_1, arg_7_2, arg_7_3)
	g.core.battle.BattleProxy:enterBattle({
		soundType = 2,
		type = BattleConst.TYPE_GUILD_BOSS_ROB,
		battle_id = arg_7_3.battle_id,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		bgId = g.core.config.guild_boss_info.get(arg_7_3.id).battle_stage
	})
end

return GuildBossRobPop
