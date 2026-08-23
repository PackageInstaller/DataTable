local ExplorationDamageRankCell = class("ExplorationDamageRankCell", require("app.fairyGUI.exploration.UI_ExplorationDamageRankCell"))

function ExplorationDamageRankCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self._updateAlliance), self)
end

function ExplorationDamageRankCell:updateCell(arg_2_1, arg_2_2)
	self.m_hasBgController:setSelectedIndex(arg_2_1 % 2)

	self._data = arg_2_2

	if not arg_2_2 then
		self.m_hasPlayerController:setSelectedIndex(0)

		return
	end

	local var_2_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_2.id)

	self.m_damageTxt:setText(arg_2_2.score)

	if var_2_0 then
		self.m_hasPlayerController:setSelectedIndex(1)
		self.m_rankTxt:updateRankIndex({
			rank = arg_2_1
		})
		self.m_userHeadComp:updateAsUser(var_2_0)
		self.m_lvText:setText(g.core.lang:get(2052, {
			level = var_2_0.level
		}))
		self.m_nameTxt:setText(var_2_0.name)
		self.m_serverTxt:setText(var_2_0.server_name)
		self.m_allianceTxt:setText(var_2_0.alliance_name)
		self:_updateAlliance()
	else
		self.m_hasPlayerController:setSelectedIndex(0)
	end
end

function ExplorationDamageRankCell:_updateAlliance()
	if not self._data then
		self.m_allianceStateController:setSelectedIndex(0)

		return
	end

	local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._data.id)

	if not var_3_0 or var_3_0.alliance_name == "" then
		self.m_allianceStateController:setSelectedIndex(0)

		return
	end

	local var_3_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, var_3_0.alliance_id)

	if not var_3_1 then
		self.m_allianceStateController:setSelectedIndex(0)

		return
	end

	self.m_allianceIcon:setIcon(g.core.common.Path:getAllianceFlag128(var_3_1.flag))
	self.m_allianceStateController:setSelectedIndex(1)
	self.m_allianceTxt:setText(var_3_0.alliance_name)
end

return ExplorationDamageRankCell
