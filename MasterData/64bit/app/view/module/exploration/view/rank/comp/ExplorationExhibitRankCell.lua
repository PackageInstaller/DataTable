local ExplorationExhibitRankCell = class("ExplorationExhibitRankCell", require("app.fairyGUI.exploration.UI_ExplorationExhibitRankCell"))

function ExplorationExhibitRankCell:ctor()
	return
end

function ExplorationExhibitRankCell:updateCell(arg_2_1, arg_2_2)
	self.m_rankTxt:updateRankIndex({
		rank = arg_2_1
	})
	self.m_timeTxt:setText(self:_getClearTimeString(arg_2_2.score))

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_2.id)

	if not var_2_0 then
		return
	end

	self.m_bgTypeController:setSelectedIndex(g.core.model.User:getId() == var_2_0.id and 1 or 0)
	self.m_nameTxt:setText(var_2_0.name)
	self.m_serverTxt:setText(var_2_0.server_name)
	self.m_userHeadComp:updateAsUser(var_2_0)
end

function ExplorationExhibitRankCell:_getClearTimeString(arg_3_1)
	local var_3_0 = math.floor(arg_3_1 / 86400)
	local var_3_1 = math.floor(arg_3_1 % 86400 / 3600)
	local var_3_2 = math.floor(arg_3_1 % 3600 / 60)

	return var_3_0 > 0 and g.core.lang:get(420671, {
		day = var_3_0,
		hour = var_3_1,
		minute = var_3_2,
		second = arg_3_1 % 60
	}) or g.core.lang:get(420672, {
		hour = var_3_1,
		minute = var_3_2,
		second = arg_3_1 % 60
	})
end

return ExplorationExhibitRankCell
