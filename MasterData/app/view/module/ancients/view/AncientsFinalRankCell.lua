local AncientsFinalRankCell = class("AncientsFinalRankCell", require("app.fairyGUI.ancients.UI_AncientsFinalRankCell"))

function var_0_0:ctor()
	self.m_List_award:setVirtual(self)
	self.m_List_award:setItemRenderer(handler(self, self._onRenderListAwardCell))
end

function var_0_0:updateCell(arg_2_1)
	self.m_is_finishController:setSelectedIndex(arg_2_1.isFinish and 1 or 0)

	self._awards = arg_2_1.awards

	self.m_Comp_label:updateComp(({
		[0] = 3,
		4,
		5,
		6,
		7
	})[arg_2_1.rankUnit.score])

	if arg_2_1.isFinish then
		self._usersData = g.core.common.GlobalFunc.rankUnit_param(arg_2_1.rankUnit.param, "AncientFinalRankUnit", true)

		local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._usersData.captain)

		if var_2_0 then
			self.m_IconComp:updateAsUser(var_2_0)
			self.m_playerNameTxt:setText(var_2_0.name)
			self.m_fightValueTxt:setText(var_2_0.fight_value)
		end
	end

	self.m_List_award:setNumItems(#self._awards)
end

function var_0_0:_onRenderListAwardCell(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
end

return var_0_0
