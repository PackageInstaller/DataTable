local AncientsPointsRankingComp = class("AncientsPointsRankingComp", require("app.fairyGUI.ancients.UI_AncientsPointsRankingComp"))

function var_0_0:ctor()
	self.m_List_team_ranking:setVirtual(self)
	self.m_List_team_ranking:setItemRenderer(handler(self, self._onRenderListTeamRankingCell))

	self._isFinish = false
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)
end

function var_0_0:updateView(arg_3_1)
	self._promoteTeams = arg_3_1 or {}
	self._cacheMap = {}
	self._allPlayerIds = {}

	self.m_is_emptyController:setSelectedIndex(#self._promoteTeams > 0 and 0 or 1)

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self._promoteTeams) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1.promote_users) do
			table.insert(var_3_0, iter_3_3.user_id)
		end

		if iter_3_1.other_user_ids then
			for iter_3_4, iter_3_5 in ipairs(iter_3_1.other_user_ids) do
				table.insert(var_3_0, iter_3_5)
			end
		end
	end

	self._allPlayerIds = var_3_0
	self._currentIndex = 1

	self:_sendUserSnapshotRequest()
end

function var_0_0:_sendUserSnapshotRequest()
	dump(self._currentIndex, "currentIndex")

	if #self._allPlayerIds < self._currentIndex then
		self._isFinish = true

		self.m_List_team_ranking:setNumItems(#self._promoteTeams)

		return
	end

	local var_4_0 = math.min(self._currentIndex + 30 - 1, #self._allPlayerIds)
	local var_4_1 = {}

	for iter_4_0 = self._currentIndex, var_4_0 do
		table.insert(var_4_1, self._allPlayerIds[iter_4_0])
	end

	self._currentIndex = var_4_0 + 1

	g.core.network.GameNetProxy:send_C2S_GetUserSnapShot({
		user_ids = var_4_1
	})
end

function var_0_0:_onGetCommonSimpleUserSnapshot(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	for iter_5_0, iter_5_1 in ipairs(arg_5_4.snapshots or {}) do
		if iter_5_1.id then
			self._cacheMap[iter_5_1.id] = iter_5_1
		end
	end

	self:_sendUserSnapshotRequest()
end

function var_0_0:_onRenderListTeamRankingCell(arg_6_1, arg_6_2)
	arg_6_2:updateCell({
		data = self._promoteTeams[arg_6_1 + 1],
		dataIndex = arg_6_1 + 1
	}, self._cacheMap)
end

return var_0_0
