local RedCliffStageMatchDataCell = class("RedCliffStageMatchDataCell", require("app.fairyGUI.redCliff.UI_RedCliffStageMatchDataCell"))

function RedCliffStageMatchDataCell:ctor()
	self._finalUser = nil
end

function RedCliffStageMatchDataCell:updateDataCell(arg_2_1, arg_2_2)
	self.m_hasBgController:setSelectedIndex(arg_2_2 % 2 == 0 and 1 or 0)

	if not arg_2_1 then
		return
	end

	self._finalUser = arg_2_1

	self.m_isSelfController:setSelectedIndex(arg_2_1.id == g.core.model.User:getId() and 1 or 0)
	self.m_rankComp:updateRankIndex({
		rank = arg_2_2 + 1
	})
	self.m_nameTxt:setText(arg_2_1.name or "")
	self.m_fightValue:setText(arg_2_1.fight_value or 0)
	self.m_headComp:updateAsUser(arg_2_1)
	self.m_server:setText(arg_2_1.server_name)
	self.m_score:setText(arg_2_1.score)
end

function RedCliffStageMatchDataCell:updateGrandCell(arg_3_1, arg_3_2)
	self.m_hasBgController:setSelectedIndex(arg_3_2 % 2 == 0 and 1 or 0)

	if not arg_3_1 then
		return
	end

	self._finalUser = arg_3_1

	self:_updatePoolIdAndScore(arg_3_1.score)

	local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_3_1.id)

	if var_3_0 then
		self.m_isSelfController:setSelectedIndex(var_3_0.id == g.core.model.User:getId() and 1 or 0)
		self.m_rankComp:updateRankIndex({
			rank = arg_3_2 + 1
		})
		self.m_nameTxt:setText(var_3_0.name)
		self.m_fightValue:setText(var_3_0.fight_value)
		self.m_headComp:updateAsUser(var_3_0)
		self.m_headComp:setVisible(true)
		self.m_server:setText(var_3_0.server_name)
	else
		self.m_isSelfController:setSelectedIndex(0)
		self.m_rankComp:updateRankIndex({
			rank = arg_3_2 + 1
		})
		self.m_nameTxt:setText("")
		self.m_fightValue:setText("")
		self.m_headComp:setVisible(false)
		self.m_server:setText("")
	end
end

function RedCliffStageMatchDataCell:_updatePoolIdAndScore(arg_4_1)
	self.m_score:setText((math.uint64_mod(arg_4_1, 100000000)))
end

return RedCliffStageMatchDataCell
