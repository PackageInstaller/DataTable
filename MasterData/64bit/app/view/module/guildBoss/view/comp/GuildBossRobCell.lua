local var_0_0 = g.core.model.User.guildBossData
local var_0_1 = g.core.const.ConstMgr.GuildBossConst
local GuildBossRobCell = class("GuildBossRobCell", require("app.fairyGUI.guildBoss.UI_GuildBossRobCell"))

function GuildBossRobCell:ctor()
	self.m_robBtn:addClickListener(handler(self, self._onClickRob))
end

function GuildBossRobCell:updateRobCell(arg_2_1)
	local var_2_0 = arg_2_1.bossInfo
	local var_2_1 = arg_2_1.data.rank

	self.m_haveBgController:setSelectedIndex(arg_2_1.data.rank % 2)

	if var_2_1 > 0 and var_2_1 <= 3 then
		self.m_numController:setSelectedIndex(var_2_1)
	elseif var_2_1 == 0 then
		self.m_numController:setSelectedIndex(0)
		self.m_numTxt:setText(g.core.lang:get(306508))
	else
		self.m_numController:setSelectedIndex(0)
		self.m_numTxt:setText(var_2_1)
	end

	self.m_scoreTxt:setText((var_0_0:getGainScoreByRank(var_2_1, arg_2_1.data.score)))

	local var_2_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.data.id)

	self._user = var_2_2

	if var_2_2 then
		self.m_headComp:updateAsUser(var_2_2)
		self.m_headComp:setVisible(true)
		self.m_nameTxt:setText(var_2_2.name)

		local var_2_3 = var_2_2.guild_name

		if var_2_0 and var_2_0.type == var_0_1.TYPE_CROSS_SERVER and string.len(var_2_2.server_name) > 0 then
			local var_2_4, var_2_5 = g.core.lang:getFormatServerName(var_2_2.server_name)

			var_2_3 = var_2_3 .. var_2_5
		end

		self.m_guildName:setText(var_2_3)
		self.m_powerTxt:setText(var_2_2.fight_value)
	else
		self.m_headComp:setVisible(false)
		self.m_nameTxt:setText("")
		self.m_guildName:setText("")
		self.m_powerTxt:setText("")
	end
end

function GuildBossRobCell:_onClickRob()
	if not self._user then
		return
	end

	if var_0_0:getLeftRobNum() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(306505))

		return
	end

	if var_0_0:getRobCountdown() > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(306506))

		return
	end

	self:dispatchCompEvent("GuildBossRobCell_clickRob", {
		user = self._user
	})
end

return GuildBossRobCell
