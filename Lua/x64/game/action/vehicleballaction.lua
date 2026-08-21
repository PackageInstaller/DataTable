local var_0_0 = {}

manager.net:Bind(89701, function(arg_1_0)
	VehicleBallData:Init(arg_1_0)
end)

function var_0_0.InitRedPoint()
	VehicleBallData:InitRedPointGroup()
end

function var_0_0.PassVehicleStage(arg_3_0)
	local var_3_0 = {
		activity_id = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN,
		stage_id = arg_3_0.stageId,
		kv_list = arg_3_0.kvList,
		buffs = arg_3_0.buffs,
		is_pass = arg_3_0.isPass and 1 or 0
	}

	manager.net:SendWithLoadingNew(89702, var_3_0, 89703, var_0_0.OnPassVehicleStageBack)
end

function var_0_0.OnPassVehicleStageBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		if arg_4_1.is_pass == 1 then
			VehicleBallData:UpdatePassVehicleStage(arg_4_1.stage_id)
			VehicleBallData:SetLastPassedStage(arg_4_1.stage_id)
		end
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.SetVehicle(arg_5_0)
	local var_5_0 = {
		activity_id = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN,
		vehicle = arg_5_0.vehicleId
	}

	manager.net:SendWithLoadingNew(89704, var_5_0, 89705, var_0_0.OnSetVehicleBack)
end

function var_0_0.OnSetVehicleBack(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		VehicleBallData:SetSelectedVehicleId(arg_6_1.vehicle)
	else
		ShowTips(arg_6_0.result)
	end
end

function var_0_0.GetIllustrateReward(arg_7_0)
	local var_7_0 = {
		activity_id = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN,
		buff_id = arg_7_0.buffID
	}

	manager.net:SendWithLoadingNew(89706, var_7_0, 89707, var_0_0.OnGetIllustrateRewardBack)
end

function var_0_0.OnGetIllustrateRewardBack(arg_8_0, arg_8_1)
	if isSuccess(arg_8_0.result) then
		VehicleBallData:UpdateBuffRewardState(arg_8_1.buff_id, BilliardGameConst.VehicleBallBuffRewardState.RECEIVED)

		local var_8_0 = MergeBallBuffCfg[arg_8_1.buff_id].reward

		getReward({
			{
				id = var_8_0[1],
				num = var_8_0[2]
			}
		})
	else
		ShowTips(arg_8_0.result)
	end
end

function var_0_0.UnlockBuff(arg_9_0)
	local var_9_0 = {
		activity_id = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN,
		buff_id = arg_9_0.buffID
	}

	manager.net:SendWithLoadingNew(89708, var_9_0, 89709, var_0_0.OnUnlockBuffBack)
end

function var_0_0.OnUnlockBuffBack(arg_10_0, arg_10_1)
	if isSuccess(arg_10_0.result) then
		VehicleBallData:UpdateUnlockBuffList(arg_10_1.buff_id, true)
		VehicleBallData:UpdateBuffRewardState(arg_10_1.buff_id, BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD)
	else
		ShowTips(arg_10_0.result)
	end
end

return var_0_0
