local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.guildData
local var_0_2 = g.core.model.User.snapShotCacheData
local var_0_3 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD
local GuildMergeGuildApplyCell = class("GuildMergeGuildApplyCell", require("app.fairyGUI.guild.UI_GuildMergeGuildApplyCell"))

function GuildMergeGuildApplyCell:ctor()
	self._guildId = 0

	self.m_lookBtn:addClickListener(handler(self, self._onClickLook))
end

function GuildMergeGuildApplyCell:_onClickLook()
	if self._guildId > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.guild.view.merge.GuildMergeLookApplyPop").new({
			targetGid = self._guildId
		}), {
			touchDisappear = true
		})
	end
end

function GuildMergeGuildApplyCell:updateApplyGuild(arg_3_1)
	self:_updateLockTime(arg_3_1)

	local var_3_0 = var_0_2:getSnapShot(var_0_3, arg_3_1.guild_id)

	if var_3_0 then
		if self._guildId == arg_3_1.guild_id then
			return
		end

		self._guildId = arg_3_1.guild_id

		self.m_icon:setURL(g.core.common.Path:getGuildMidIconById(var_3_0.icon))
		self.m_guildLevel:setText(g.core.lang:get(100535, {
			lv = var_3_0.level
		}))
		self.m_guildName:setText(var_3_0.name)
	else
		self._guildId = 0

		self.m_icon:setURL("")
		self.m_guildLevel:setText("")
		self.m_guildName:setText("")
	end
end

function GuildMergeGuildApplyCell:_updateLockTime(arg_4_1)
	if arg_4_1.is_confirm then
		self.m_lockTime:setText(var_0_0:getLeftHMSFormat(arg_4_1.merge_time + var_0_1:getMergeLockTime()))
	else
		self.m_lockTime:setText("")
	end
end

return GuildMergeGuildApplyCell
