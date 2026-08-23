local var_0_0 = g.core.common.Path
local var_0_2 = g.core.model.User.allianceData
local var_0_4 = g.core.model.User.snapShotCacheData
local var_0_5 = g.core.const.ConstMgr.SnapShotCacheConst
local AllianceHallApplyCell = class("AllianceHallApplyCell", require("app.fairyGUI.alliance.UI_AllianceHallApplyCell"))

function AllianceHallApplyCell:ctor()
	self._applyGuild = nil
	self._guildSnapShot = nil
	self._applyTime = 0

	self.m_refuseBtn:addClickListener(handler(self, self._onClickRefuseBtn))
	self.m_approveBtn:addClickListener(handler(self, self._onClickApproveBtn))
end

function AllianceHallApplyCell:updateInviteCell(arg_2_1)
	self._applyGuild = arg_2_1

	local var_2_0 = var_0_4:getSnapShot(var_0_5.SNAP_SHOT_KEY.GUILD, arg_2_1.guild_id)

	if var_2_0 then
		self._guildSnapShot = var_2_0

		self.m_guildPic:setURL(var_0_0:getGuildMidIconById(var_2_0.icon))
		self.m_levelTxt:setText(g.core.lang:get(2052, {
			level = var_2_0.level
		}))
		self.m_applyName:setText(var_2_0.name)
		self.m_serverName:setText((var_0_2:getGuildServerName(var_2_0)))
		self.m_memberNum:setText(var_2_0.member_number or 0)
		self.m_powerTxt:setText(var_2_0.fight_value)
	end
end

function AllianceHallApplyCell:_onClickRefuseBtn()
	if not self._guildSnapShot then
		return
	end

	g.core.network.GameNetProxy:send_C2S_GuildAlliance_ApproveApply({
		agree = false,
		guild_id = self._guildSnapShot.id
	})
end

function AllianceHallApplyCell:_onClickApproveBtn()
	if not self._guildSnapShot then
		return
	end

	if var_0_2:getAllianceGuildMaxNum() <= var_0_2:getGuildNum() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428611))

		return
	end

	if self._guildSnapShot.level < 5 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428612, {
			level = 5
		}))

		return
	end

	g.core.network.GameNetProxy:send_C2S_GuildAlliance_ApproveApply({
		agree = true,
		guild_id = self._guildSnapShot.id
	})
end

return AllianceHallApplyCell
