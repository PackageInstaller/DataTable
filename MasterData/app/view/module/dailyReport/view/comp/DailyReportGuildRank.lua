local DailyReportGuildRank = class("DailyReportGuildRank", require("app.fairyGUI.dailyReport.UI_DailyReportGuildRank"))

function DailyReportGuildRank:updateComp(arg_1_1, arg_1_2)
	self._guildId = nil

	if arg_1_1 and arg_1_1.id then
		local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, arg_1_1.id)

		if var_1_0 then
			self._guildId = var_1_0.id

			if self:getController("empty") then
				self:getController("empty"):setSelectedIndex(1)
			end

			if self:getChild("rankTxt") then
				self:getChild("rankTxt"):setText(arg_1_2)
			end

			if self:getChild("nameTxt") then
				self:getChild("nameTxt"):setText(var_1_0.name)
			end

			if self:getChild("fightValueTxt") then
				self:getChild("fightValueTxt"):setText(var_1_0.fight_value)
			end

			if self:getChild("guildIcon") then
				self:getChild("guildIcon"):setURL(g.core.common.Path:getGuildSignOrFrameById(var_1_0.icon))
			end

			if self:getChild("svrNameTxt") then
				self:getChild("svrNameTxt"):setText(var_1_0.server_name)
			end

			if self:getController("rank") then
				self:getController("rank"):setSelectedIndex(arg_1_2 - 1)
			end
		elseif self:getController("empty") then
			self:getController("empty"):setSelectedIndex(0)
		end
	elseif self:getController("empty") then
		self:getController("empty"):setSelectedIndex(0)
	end
end

function DailyReportGuildRank:_onGuildClick()
	if self._guildId then
		fgui.UIPackage:addPackage("ui/guild/guild")
		g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_JOIN_HALL, {
			child = fgui.UIPackage:createObject("guild", "GuildJoinLeftComp"),
			guildType = g.core.const.ConstMgr.GuildCommonConst.guildType.OTHER_GUILD,
			guildId = self._guildId
		})
	end
end

return DailyReportGuildRank
