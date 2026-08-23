local var_0_0 = g.core.model.User
local RebelRankDamageCell = class("RebelRankDamageCell", require("app.fairyGUI.rebel.UI_RebelRankDamageCell"))

function RebelRankDamageCell:ctor(arg_1_1)
	self.getSharedTrans(self, "enter_up", "CommonLongCellList", self)
end

function RebelRankDamageCell:refreshRankCell(arg_2_1, arg_2_2)
	self.m_haveBgController:setSelectedIndex(arg_2_2 % 2)

	if arg_2_1.rank < 4 then
		self.m_numController:setSelectedIndex(arg_2_1.rank)
	else
		self.m_numController:setSelectedIndex(0)
	end

	self.m_numTxt:setText(arg_2_1.rank)
	self.m_dmgTxt:setText(arg_2_1.score)

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id)

	if var_2_0 then
		self.m_nameTxt:setText(var_2_0.name)
		self.m_levelTxt:setText("Lv." .. var_2_0.level)
		self.m_powerTxt:setText(var_2_0.fight_value)

		if var_2_0.id == var_0_0:getId() then
			var_2_0.avata_id = var_0_0:getAvataId()
		end

		self.m_headComp:updateAsUser(var_2_0)
		self.m_headComp:setVisible(true)
	else
		self.m_nameTxt:setText("")
		self.m_levelTxt:setText("")
		self.m_powerTxt:setText("")
		self.m_headComp:setVisible(false)
	end
end

return RebelRankDamageCell
