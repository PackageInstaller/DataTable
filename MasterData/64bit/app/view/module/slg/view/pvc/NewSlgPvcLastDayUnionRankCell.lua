local NewSlgPvcLastDayUnionRankCell = class("NewSlgPvcLastDayUnionRankCell", require("app.fairyGUI.newSlg.UI_NewSlgPvcLastDayUnionRankCell"))

function NewSlgPvcLastDayUnionRankCell:updateNewSlgPvcUnionRankCell(arg_1_1, arg_1_2)
	self:getChild("bg"):setVisible(arg_1_2 % 2 == 0)

	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, arg_1_1.id)

	self.m_Txt_score:setText(arg_1_1.score)

	if var_1_0 then
		self.m_Comp_rank:updateRankIndex({
			rank = arg_1_1.rank
		})
		self.m_Txt_Unionname:setText(var_1_0.name)
		self.m_Txt_name:setText(var_1_0.leader_name)
		self.m_Icon_rank:setIcon(g.core.common.Path:getAllianceFlag128(var_1_0.flag))
	end
end

return NewSlgPvcLastDayUnionRankCell
