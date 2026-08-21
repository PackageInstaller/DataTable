local var_0_0 = class("CrossRoadColliderMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._runningData = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._playerMgr = arg_1_3
	arg_1_0.carList = nil
	arg_1_0.roleList = nil

	return
end

function var_0_0.Step(arg_2_0, arg_2_1)
	arg_2_0.carList = arg_2_0._runningData:GetTrackCarGoList()
	arg_2_0.roleList = arg_2_0._runningData:GetRoleList()

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.carList) do
		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			if iter_2_3:GetTrack() == CrossRoadGameConst.FRONT_ROAD_NAME then
				table.insert({}, iter_2_3)
			end
		end
	end

	arg_2_0.carList = {}
	arg_2_0.roleList = underscore.select(arg_2_0.roleList, function(arg_3_0)
		return arg_3_0:GetTrack() == CrossRoadGameConst.SCENE_ROAD_NAME and arg_3_0:GetRunState() ~= CrossRoadGameConst.SHIP_STATE.crash
	end)

	for iter_2_4, iter_2_5 in ipairs(arg_2_0.carList) do
		for iter_2_6, iter_2_7 in ipairs(arg_2_0.roleList) do
			if arg_2_0._runningData:CheckCarCarshRole(iter_2_5, iter_2_7) then
				arg_2_0._runningData:TryUpdateUnion(iter_2_7)
				iter_2_7:SetRunState(CrossRoadGameConst.SHIP_STATE.crash)
				iter_2_5:SetCarCrashList(iter_2_7)
				arg_2_0._event(CrossRoadGameConst.HIT_ROLER)
			end
		end

		if not arg_2_0._playerMgr:GetCrashState() and arg_2_0._runningData:CheckCarCarshPlayer(iter_2_5) then
			if iter_2_5:GetPosition().x < arg_2_0._playerMgr:GetPosition().x then
				arg_2_0._runningData:SetPlayerCrashDir({
					1,
					0
				})
			else
				arg_2_0._runningData:SetPlayerCrashDir({
					-1,
					0
				})
			end

			local var_2_0, var_2_1, var_2_2, var_2_3 = iter_2_5:GetCarRectPoint()

			arg_2_0._runningData:SetPlayerCarshSize(var_2_2 - var_2_0)
			arg_2_0._playerMgr:PlayZhihuiHit()
		end
	end

	return
end

function var_0_0.Clear(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	return
end

return var_0_0
