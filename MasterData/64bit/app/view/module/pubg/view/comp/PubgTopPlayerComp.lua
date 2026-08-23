local PubgTopPlayerComp = class("PubgTopPlayerComp", require("app.fairyGUI.pubg.UI_PubgTopPlayerComp"))

function PubgTopPlayerComp:ctor()
	return
end

function PubgTopPlayerComp:updatePlayerComp(arg_2_1)
	if not arg_2_1 or self._isUpdate then
		return
	end

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.id)

	if not var_2_0 then
		return
	end

	self.m_userIcon:updateAsUser(var_2_0)
	self.m_userNameText:setText(var_2_0.name)
	self.m_serverNameText:setText(var_2_0.server_name)

	local var_2_1 = var_2_0.show_knight_id or 0

	if var_2_1 < 1 then
		var_2_1 = var_2_0.base_id
	end

	self.m_knightMaskComp:setIcon(g.core.common.Path:getMiddleKnightPicById(g.core.model.User.knightsData:getKnightResInfo({
		knightId = var_2_1,
		skinId = var_2_0.show_knight_dress
	}).painted_id))

	local var_2_2 = self.m_knightMaskComp:getChild("icon"):getContentSprite()

	if var_2_2 then
		var_2_2:showChangingRect({
			x = -70,
			height = 550,
			width = 140,
			y = -200
		}, 80)
	end

	self._isUpdate = true
end

return PubgTopPlayerComp
