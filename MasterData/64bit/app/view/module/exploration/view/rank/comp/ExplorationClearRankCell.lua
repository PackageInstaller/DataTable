local ExplorationClearRankCell = class("ExplorationClearRankCell", require("app.fairyGUI.exploration.UI_ExplorationClearRankCell"))

function ExplorationClearRankCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self._updateAlliance), self)
end

function ExplorationClearRankCell:updateCell(arg_2_1, arg_2_2)
	self.m_hasBgController:setSelectedIndex(arg_2_1 % 2)

	self._data = arg_2_2

	if not arg_2_2 then
		self.m_hasPlayerController:setSelectedIndex(0)

		return
	end

	self.m_clearTime:setText(self:_getClearTimeString(arg_2_2.score))

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_2.id)

	if var_2_0 then
		self.m_hasPlayerController:setSelectedIndex(1)
		self.m_rankTxt:updateRankIndex({
			rank = arg_2_1
		})
		self.m_userHeadComp:updateAsUser(var_2_0)
		self.m_lvTxt:setText(g.core.lang:get(2052, {
			level = var_2_0.level
		}))
		self.m_nameTxt:setText(var_2_0.name)
		self.m_serverTxt:setText(var_2_0.server_name)
		self:_updateAlliance()
	end
end

function ExplorationClearRankCell:_getClearTimeString(arg_3_1)
	local var_3_0 = math.floor(arg_3_1 / 86400)
	local var_3_1 = math.floor(arg_3_1 % 86400 / 3600)
	local var_3_2 = math.floor(arg_3_1 % 3600 / 60)

	return var_3_0 > 0 and g.core.lang:get(420671, {
		day = var_3_0,
		hour = var_3_1,
		minute = var_3_2
	}) or g.core.lang:get(420672, {
		hour = var_3_1,
		minute = var_3_2
	})
end

function ExplorationClearRankCell:_updateAlliance()
	if not self._data then
		self.m_allianceStateController:setSelectedIndex(0)

		return
	end

	local var_4_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._data.id)

	if not var_4_0 or var_4_0.alliance_name == "" then
		self.m_allianceStateController:setSelectedIndex(0)

		return
	end

	local var_4_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, var_4_0.alliance_id)

	if not var_4_1 then
		self.m_allianceStateController:setSelectedIndex(0)

		return
	end

	self.m_allianceIcon:setIcon(g.core.common.Path:getAllianceFlag128(var_4_1.flag))
	self.m_allianceStateController:setSelectedIndex(1)
	self.m_allianceTxt:setText(var_4_0.alliance_name)
end

return ExplorationClearRankCell
