local NewSlgS2CityResultDetailCell = class("NewSlgS2CityResultDetailCell", require("app.fairyGUI.newSlg.UI_NewSlgS2CityResultDetailCell"))
local var_0_1 = g.core.model.User.snapShotCacheData
local var_0_2 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_3 = g.core.common.Path

function NewSlgS2CityResultDetailCell:ctor()
	self._snapshot = nil
end

function NewSlgS2CityResultDetailCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1.rank

	self.m_Comp_rank:updateRankIndex({
		rank = arg_2_1.rank
	})
	self.m_indexTypeController:setSelectedIndex(var_2_0 % 2 ~= 0 and 1 or 2)

	local var_2_1 = arg_2_1.allianceId

	self.m_is_winController:setSelectedIndex(arg_2_1.allianceId == arg_2_1.win_alliance_id and 1 or 0)

	self._snapshot = var_0_1:getSnapShot(var_0_2.SNAP_SHOT_KEY.ALLIANCE, var_2_1)

	if self._snapshot then
		self.m_allianceName:setText(self._snapshot.name)
		self.m_leaderName:setText(g.core.lang:get(428503, {
			userName = self._snapshot.leader_name
		}))
		self.m_allianceIcon:setIcon(var_0_3:getAllianceFlag128(self._snapshot.flag))
	end
end

return NewSlgS2CityResultDetailCell
