local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.knightsData
local RedCliffExhibitionPlayerComp = class("RedCliffExhibitionPlayerComp", require("app.fairyGUI.redCliff.UI_RedCliffExhibitionPlayerComp"))

function RedCliffExhibitionPlayerComp:updateShowComp(arg_1_1)
	local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1.id)

	if not var_1_0 then
		return
	end

	self.m_userIcon:updateAsUser(var_1_0)
	self.m_userName:setText(var_1_0.name)
	self.m_serverName:setText(var_1_0.server_name)

	local var_1_1 = var_1_0.show_knight_id or 0

	if var_1_1 < 1 then
		var_1_1 = var_1_0.base_id
	end

	self.m_knightMask:setIcon(var_0_0:getMiddleKnightPicById(var_0_1:getKnightResInfo({
		knightId = var_1_1,
		skinId = var_1_0.show_knight_dress
	}).painted_id))

	local var_1_2 = self.m_knightMask:getChild("icon"):getContentSprite()

	if var_1_2 then
		var_1_2:showChangingRect({
			x = -70,
			height = 550,
			width = 140,
			y = -200
		}, 80)
	end
end

return RedCliffExhibitionPlayerComp
