local var_0_0 = g.core.model.User.redCliffData
local RedCliffRankCell = class("RedCliffRankCell", require("app.fairyGUI.redCliff.UI_RedCliffRankCell"))

function RedCliffRankCell:ctor()
	return
end

function RedCliffRankCell:updateRankCell(arg_2_1, arg_2_2)
	self.m_hasPlayerController:setSelectedIndex(checkbool(arg_2_1) and 1 or 0)
	self.m_hasBgController:setSelectedIndex(arg_2_2 % 2)

	if not arg_2_1 then
		return
	end

	self.m_rankComp:updateRankIndex({
		rank = arg_2_1.rank
	})
	self:_updatePoolIdAndScore(arg_2_1.score)

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id)

	if var_2_0 then
		self.m_userHeadComp:updateAsUser(var_2_0)
		self.m_userHeadComp:setVisible(true)
		self.m_lvTxt:setText(g.core.lang:get(2052, {
			level = var_2_0.level
		}))
		self.m_nameTxt:setText(var_2_0.name)
		self.m_fightValue:setText(var_2_0.fight_value)
		self.m_server:setText(var_2_0.server_name)
	else
		self.m_userHeadComp:setVisible(false)
		self.m_lvTxt:setText("")
		self.m_nameTxt:setText("")
		self.m_fightValue:setText("")
		self.m_server:setText("")
	end
end

function RedCliffRankCell:_updatePoolIdAndScore(arg_3_1)
	self.m_score:setText((math.uint64_mod(arg_3_1, 100000000)))
	self.m_stage:setText(var_0_0:getPoolInfoByPoolId((math.floor(math.uint64_div(arg_3_1, 100000000)))).pool_name)
end

return RedCliffRankCell
