local DailyReportPanelComp = class("DailyReportPanelComp", require("app.fairyGUI.dailyReport.UI_DailyReportPanelComp"))
local var_0_1 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER
local var_0_2 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD
local var_0_3 = g.core.model.User.snapShotCacheData
local DailyReportConst = require("app.view.module.dailyReport.const.DailyReportConst")

function DailyReportPanelComp:ctor()
	self._playerId = 0
	self._snapshotId = 0

	local var_1_0 = self:getChild("knightLoader")

	if var_1_0 then
		var_1_0:setIcon(g.core.common.Path:getKnightBookPicRes((g.core.model.User:getAssistantId())))
	end
end

function DailyReportPanelComp:updatePanel(arg_2_1, arg_2_2)
	self._panelData = arg_2_1

	if arg_2_1 and arg_2_1.cfgData then
		self.m_title:setText(arg_2_1.cfgData.info.title)

		if arg_2_1.playerData then
			self:_checkAndShowRank()
		end

		self:_updateContent()
	end
end

function DailyReportPanelComp:updatePanelBySnapShot()
	if self._panelData and self._panelData.cfgData then
		self.m_title:setText(self._panelData.cfgData.info.title)

		if self._panelData.playerData then
			self:_checkAndShowRank()
		end

		self:_updateContent()
	end
end

function DailyReportPanelComp:_checkAndShowRank()
	self._playerId = 0
	self._snapshotId = self._panelData.playerData[1].id or 0

	local var_4_0 = self:getChild("knightIcon")

	if var_4_0 then
		var_4_0:setOverrideClick(true)

		local var_4_1 = self._panelData.playerData[1].user and self._panelData.playerData[1].user or var_0_3:getSnapShot(var_0_1, self._snapshotId)

		if var_4_1 then
			self._playerId = var_4_1.id

			var_4_0:updateAsUser(var_4_1)
		end

		if not self._addClickEvent then
			self._addClickEvent = true

			var_4_0:addClickListener(handler(self, self.onShowPlayerInfo))
		end
	end

	local var_4_2 = self:getChild("furnitureComp")

	if var_4_2 and self._panelData.roomData then
		var_4_2:updateFurniture(self._panelData.roomData)
	end

	local var_4_3 = self:getChild("guildIcon")

	if var_4_3 then
		local var_4_4 = self._panelData.playerData[1].guild and self._panelData.playerData[1].guild or var_0_3:getSnapShot(var_0_2, self._snapshotId)

		if var_4_4 then
			var_4_3:setURL(g.core.common.Path:getGuildSignOrFrameById(var_4_4.icon))
		end
	end

	if checkbool(self:getChild("rankIcon" .. 1)) then
		if self._panelData.playerData[1] and self._panelData.playerData[1].user then
			-- block empty
		elseif self._panelData.playerData[1] then
			local var_4_7 = self._panelData.playerData[1].id or 0

			if var_4_7 > 0 then
				local var_4_8 = var_0_3:getSnapShot(var_0_1, var_4_7)
			end
		end
	end

	for iter_4_0 = 1, 4 do
		local var_4_9 = self:getChild("rankIcon" .. iter_4_0)

		if var_4_9 then
			self._rankType = DailyReportConst.RANK_TYPE.USER

			var_4_9:updateComp(self._panelData.playerData[iter_4_0], iter_4_0, DailyReportConst.RANK_TYPE.USER)
		end
	end

	for iter_4_1 = 1, 4 do
		local var_4_10 = self:getChild("guildRank" .. iter_4_1)

		if var_4_10 then
			self._rankType = DailyReportConst.RANK_TYPE.GUILD

			var_4_10:updateComp(self._panelData.playerData[iter_4_1], iter_4_1, DailyReportConst.RANK_TYPE.GUILD)
		end
	end
end

function DailyReportPanelComp:_updateContent()
	self.m_content:setTitle("")

	local var_5_0 = ""
	local var_5_1 = ""
	local var_5_2 = ""

	if not self._snapshotId or self._snapshotId == 0 or not self._panelData then
		self:_updateContentWithoutNoParam()

		return
	end

	local var_5_4 = self._panelData.playerData[1].score
	local var_5_5 = self._panelData.cfgData.info.content
	local var_5_6 = self._panelData.stringData or {}

	if self._panelData.cfgData.info.rank_wrap_type == 1 then
		local var_5_7 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._snapshotId)

		if not var_5_7 then
			return
		end

		var_5_0 = var_5_7.name
		var_5_1 = var_5_7.guild_name
	else
		local var_5_8 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, self._snapshotId)

		if not var_5_8 then
			return
		end

		var_5_1 = var_5_8.name
		var_5_2 = var_5_8.leader_name
	end

	if string.find(var_5_5, "#user_name#") then
		var_5_6.user_name = var_5_0
	end

	if string.find(var_5_5, "#rank_score#") then
		var_5_6.rank_score = var_5_4
	end

	if string.find(var_5_5, "#guild_name#") then
		var_5_6.guild_name = var_5_1
	end

	if string.find(var_5_5, "#guild_leader_name#") then
		var_5_6.guild_leader_name = var_5_2
	end

	self.m_content:setTitle((g.core.lang:getByString(var_5_5, var_5_6)))
end

function DailyReportPanelComp:_updateContentWithoutNoParam()
	if not self._panelData then
		return
	end

	local var_6_0 = self._panelData.stringData or {}
	local var_6_1 = self._panelData.cfgData.info.content

	for iter_6_0, iter_6_1 in ipairs({
		"#user_name#",
		"#rank_score#",
		"#guild_name#",
		"#guild_leader_name#"
	}) do
		if string.find(var_6_1, "#rank_score#") then
			return
		end
	end

	self.m_content:setTitle((g.core.lang:getByString(var_6_1, var_6_0)))
end

function DailyReportPanelComp:_specialShowRank(arg_7_1, arg_7_2, arg_7_3)
	return
end

function DailyReportPanelComp:onShowPlayerInfo()
	if self._playerId and self._playerId ~= 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			uid = self._playerId
		})
	end
end

function DailyReportPanelComp:showCutPage()
	local var_9_0 = self.m_content:getChild("title")

	if var_9_0 then
		var_9_0:removeFromParent()
		self:addChild(var_9_0)
		var_9_0:setPosition(self.m_content:getPosition())
		var_9_0:setSize(self.m_content:getSize())
	end
end

function DailyReportPanelComp:_onClickGuild()
	if self._guildId then
		fgui.UIPackage:addPackage("ui/guild/guild")
		g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_JOIN_HALL, {
			child = fgui.UIPackage:createObject("guild", "GuildJoinLeftComp"),
			guildType = g.core.const.ConstMgr.GuildCommonConst.guildType.OTHER_GUILD,
			guildId = self._guildId
		})
	end
end

return DailyReportPanelComp
