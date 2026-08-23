local GuildWarDrillRankCell = class("GuildWarDrillRankCell", require("app.fairyGUI.guildWar.UI_GuildWarDrillRankCell"))

function GuildWarDrillRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)

	self._rewardList = nil

	self.m_iconList:setVirtual()
	self.m_iconList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function GuildWarDrillRankCell:_onRenderAwardList(arg_2_1, arg_2_2)
	self._rewardList[arg_2_1 + 1].scaleIndex = 4
	self._rewardList[arg_2_1 + 1].hideNum = false

	arg_2_2:updateIcon(self._rewardList[arg_2_1 + 1])
end

function GuildWarDrillRankCell:update(arg_3_1)
	local var_3_0

	if arg_3_1 then
		var_3_0 = arg_3_1.rankData or {}

		if not next(var_3_0) then
			return
		end
	end

	local var_3_1 = var_3_0.rank

	if var_3_0.rank <= 3 then
		self.m_indexRank:setCtrlState("rank", {
			index = var_3_1
		})
	else
		self.m_indexRank:setCtrlState("rank", {
			index = 0
		})
		self.m_indexRank:setTitle(tostring(var_3_1))
	end

	local var_3_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, var_3_0.id)

	if var_3_2 then
		self.m_iconComp:updateInfo({
			style = 6,
			data = var_3_2
		})
		self.m_guildNameText:setText(var_3_2.name or "")
		self.m_iconComp:setVisible(true)
	else
		self.m_guildNameText:setText("")
		self.m_iconComp:setVisible(false)
	end

	self.m_powerText:setText(var_3_0.score)

	if arg_3_1.rewardData then
		self._rewardList = arg_3_1.rewardData.data or {}

		self.m_iconList:setNumItems(#self._rewardList)
		self.m_iconList:setVisible(true)
	else
		self.m_iconList:setVisible(false)
	end
end

return GuildWarDrillRankCell
