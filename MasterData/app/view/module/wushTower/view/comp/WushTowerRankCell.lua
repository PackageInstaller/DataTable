local var_0_0 = g.core.model.User
local var_0_1 = g.core.model.User.wushTowerData
local WushTowerRankCell = class("WushTowerRankCell", require("app.fairyGUI.wushTower.UI_WushTowerRankCell"))

function WushTowerRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function WushTowerRankCell:updateCell(arg_2_1, arg_2_2)
	if arg_2_2.rank <= 3 then
		self.m_indexRank:setCtrlState("rank", {
			index = arg_2_2.rank
		})
	else
		self.m_indexRank:setTitle(tostring(arg_2_2.rank))
		self.m_indexRank:setCtrlState("rank", {
			index = 0
		})
	end

	local var_2_0 = var_0_1:getZoneCfgByRankId(arg_2_2.score)

	self.m_scoreTxt:setText(g.core.lang:get(408416, {
		zoneId = var_2_0.zone_id,
		floor = var_2_0.floor
	}))
	self.m_showBgController:setSelectedIndex(arg_2_1 and 1 or 0)

	local var_2_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_2.id)

	if var_2_1 then
		if var_2_1.id == var_0_0:getId() then
			self.m_IconComp:updateAsSelf()
		else
			self.m_IconComp:updateAsUser(var_2_1)
		end

		self.m_IconComp:setVisible(true)
		self.m_nameTxt:setText(var_2_1.name or "")
		self.m_levelTxt:setText(g.core.lang:get(120) .. var_2_1.level or "")

		local var_2_2 = var_2_1.guild_name or ""

		if string.len(var_2_2) == 0 then
			var_2_2 = g.core.lang:get(302055)
		end

		self.m_guildNameTxt:setText(var_2_2)
	else
		self.m_IconComp:setVisible(false)
		self.m_nameTxt:setText("")
		self.m_levelTxt:setText("")
		self.m_guildNameTxt:setText("")
	end
end

return WushTowerRankCell
