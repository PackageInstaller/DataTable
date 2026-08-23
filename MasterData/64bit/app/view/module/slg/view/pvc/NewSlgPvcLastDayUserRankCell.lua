local NewSlgPvcLastDayUserRankCell = class("NewSlgPvcLastDayUserRankCell", require("app.fairyGUI.newSlg.UI_NewSlgPvcLastDayUserRankCell"))

function NewSlgPvcLastDayUserRankCell:updateNewSlgPvcRankCell(arg_1_1, arg_1_2)
	self:getChild("bg"):setVisible(arg_1_2 % 2 == 0)

	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1.id)

	self.m_Comp_rank:updateRankIndex({
		rank = arg_1_1.rank
	})
	self.m_Txt_score:setText(arg_1_1.score)
	self.m_Txt_commandValue:setText(arg_1_1.param)

	if var_1_0 then
		self.m_Icon_rank:updateAsUser(var_1_0)
		self.m_Txt_name:setText(var_1_0.name)
		self.m_lvTxt:setText(g.core.lang:get(429006, {
			level = var_1_0.level
		}))
	end
end

return NewSlgPvcLastDayUserRankCell
