local var_0_0 = g.core.model.User
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.peakArenaData
local PARankCell = class("PARankCell", require("app.fairyGUI.peakArena.UI_PARankCell"))

function PARankCell:ctor()
	self._awardData = {}

	self.m_starComp:initStar({
		index = 10,
		style = 1,
		gap = -6,
		num = 0
	})
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function PARankCell:updateCell(arg_2_1, arg_2_2)
	self.m_showBgController:setSelectedIndex(arg_2_1 and 1 or 0)

	local var_2_0 = var_0_2:getPALevelInfo(arg_2_2.score)

	self.m_rankIcon:setURL(var_0_1:getPeakArenaDanGradingPic(var_2_0.pic))
	self.m_starComp:setStarNum(var_2_0.star)

	if arg_2_2.rank <= 3 then
		self.m_indexRank:setCtrlState("rank", {
			index = arg_2_2.rank
		})
	else
		self.m_indexRank:setCtrlState("rank", {
			index = 0
		})
		self.m_indexRank:setTitle(tostring(arg_2_2.rank))
	end

	local var_2_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_2.id)

	if var_2_1 then
		self.m_serverName:setText((g.core.platform.ServerListProxy:getServerById(tonumber(var_2_1.sid)) or {}).name or "")

		if var_2_1.id == var_0_0:getId() then
			self.m_IconComp:updateAsSelf()
		else
			self.m_IconComp:updateAsUser(var_2_1)
		end

		self.m_userName:setText(var_2_1.name or "")
		self.m_score:setText(arg_2_2.score)

		local var_2_3 = ""

		if var_0_2:isShowAlliance() then
			var_2_3 = var_2_1.alliance_name or ""

			if string.len(var_2_3) == 0 then
				var_2_3 = g.core.lang:get(109642)
			end
		else
			var_2_3 = var_2_1.guild_name or ""

			if string.len(var_2_3) == 0 then
				var_2_3 = g.core.lang:get(302055)
			end
		end

		self.m_guildName:setText(var_2_3)
		self.m_fightValueTxt:setText(var_2_1.fight_value or 0)
	end
end

return PARankCell
