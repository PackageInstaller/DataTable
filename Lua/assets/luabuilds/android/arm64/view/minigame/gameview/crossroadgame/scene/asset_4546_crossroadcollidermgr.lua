local CrossRoadColliderMgr = class("CrossRoadColliderMgr")

function CrossRoadColliderMgr:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._runningData = arg_1_1
	self._event = arg_1_2
	self._playerMgr = arg_1_3
	self.carList = nil
	self.roleList = nil

	return
end

function CrossRoadColliderMgr:Step(arg_2_1)
	self.carList = self._runningData:GetTrackCarGoList()
	self.roleList = self._runningData:GetRoleList()

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self.carList) do
		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			if iter_2_3:GetTrack() == CrossRoadGameConst.FRONT_ROAD_NAME then
				table.insert(var_2_0, iter_2_3)
			end
		end
	end

	self.carList = var_2_0
	self.roleList = underscore.select(self.roleList, function(arg_3_0)
		return arg_3_0:GetTrack() == CrossRoadGameConst.SCENE_ROAD_NAME and arg_3_0:GetRunState() ~= CrossRoadGameConst.SHIP_STATE.crash
	end)

	for iter_2_4, iter_2_5 in ipairs(self.carList) do
		for iter_2_6, iter_2_7 in ipairs(self.roleList) do
			if self._runningData:CheckCarCarshRole(iter_2_5, iter_2_7) then
				self._runningData:TryUpdateUnion(iter_2_7)
				iter_2_7:SetRunState(CrossRoadGameConst.SHIP_STATE.crash)
				iter_2_5:SetCarCrashList(iter_2_7)
				self._event(CrossRoadGameConst.HIT_ROLER)
			end
		end

		if not self._playerMgr:GetCrashState() and self._runningData:CheckCarCarshPlayer(iter_2_5) then
			if iter_2_5:GetPosition().x < self._playerMgr:GetPosition().x then
				self._runningData:SetPlayerCrashDir({
					1,
					0
				})
			else
				self._runningData:SetPlayerCrashDir({
					-1,
					0
				})
			end

			local var_2_1, var_2_2, var_2_3, var_2_4 = iter_2_5:GetCarRectPoint()

			self._runningData:SetPlayerCarshSize(var_2_3 - var_2_1)
			self._playerMgr:PlayZhihuiHit()
		end
	end

	return
end

function CrossRoadColliderMgr:Clear()
	return
end

function CrossRoadColliderMgr:Dispose()
	return
end

return CrossRoadColliderMgr
