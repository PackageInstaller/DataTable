local GveBossRankCell = class("GveBossRankCell", require("app.fairyGUI.gve.UI_GveBossRankCell"))

function GveBossRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function GveBossRankCell:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 or {}

	if not next(var_2_0) then
		return
	end

	local var_2_1 = arg_2_2

	if arg_2_2 <= 3 then
		self.m_indexRank:setCtrlState("rank", {
			index = var_2_1
		})
	else
		self.m_indexRank:setCtrlState("rank", {
			index = 0
		})
		self.m_indexRank:setTitle(tostring(var_2_1))
	end

	self.m_damageText:setText(var_2_0.first)

	local var_2_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id)

	if not var_2_2 then
		self.m_snapShotStateController:setSelectedIndex(0)

		return
	end

	self.m_userIcon:updateAsUser(var_2_2)
	self.m_userNameText:setText(var_2_2.name)
	self.m_allianceNameText:setText((string.len(var_2_2.alliance_name) == 0 or nil) and g.core.lang:get(309201))
	self.m_serverNameText:setText(var_2_2.server_name)
	self.m_snapShotStateController:setSelectedIndex(2)
end

return GveBossRankCell
