local var_0_0 = g.core.model.User
local TowerRankCell = class("TowerRankCell", require("app.fairyGUI.tower.UI_TowerRankCell"))

function TowerRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function TowerRankCell:update(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.data or {}

		if not next(var_2_0) then
			return
		end
	end

	local var_2_1 = var_2_0.rank

	if var_2_0.rank <= 3 then
		self.m_indexRank:setCtrlState("rank", {
			index = var_2_1
		})
	else
		self.m_indexRank:setCtrlState("rank", {
			index = 0
		})
		self.m_indexRank:setTitle(tostring(var_2_1))
	end

	self.m_passStage:setText(var_2_0.score)

	local var_2_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_2_0.id)

	self.m_IconComp:updateAsUser(var_2_2)

	if var_2_2 then
		local var_2_3, var_2_4 = g.core.lang:getFormatServerName(var_2_2.server_name)

		self.m_userName:setText(var_2_2.name or "")
		self.m_serverName:setText(var_2_4)
		self.m_power:setText(var_2_2.fight_value)
		self.m_isSelfController:setSelectedIndex(var_0_0:isSelfById(var_2_2.id) and 1 or 0)
	else
		self.m_userName:setText("")
		self.m_serverName:setText("")
		self.m_power:setText("")
		self.m_isSelfController:setSelectedIndex(0)
	end
end

return TowerRankCell
