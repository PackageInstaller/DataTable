local var_0_0 = {}

manager.net:Bind(89701, function(arg_1_0)
	VehicleBallData:Init(arg_1_0)
end)

function var_0_0.InitRedPoint()
	VehicleBallData:InitRedPointGroup()
end

function var_0_0:PassVehicleStage()
	manager.net:SendWithLoadingNew(89702, {
		activity_id = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN,
		stage_id = self.stageId,
		kv_list = self.kvList,
		buffs = self.buffs,
		is_pass = self.isPass and 1 or 0
	}, 89703, var_0_0.OnPassVehicleStageBack)
end

function var_0_0:OnPassVehicleStageBack(arg_4_1)
	if isSuccess(self.result) then
		if arg_4_1.is_pass == 1 then
			VehicleBallData:UpdatePassVehicleStage(arg_4_1.stage_id)
			VehicleBallData:SetLastPassedStage(arg_4_1.stage_id)
		end
	else
		ShowTips(self.result)
	end
end

function var_0_0:SetVehicle()
	manager.net:SendWithLoadingNew(89704, {
		activity_id = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN,
		vehicle = self.vehicleId
	}, 89705, var_0_0.OnSetVehicleBack)
end

function var_0_0:OnSetVehicleBack(arg_6_1)
	if isSuccess(self.result) then
		VehicleBallData:SetSelectedVehicleId(arg_6_1.vehicle)
	else
		ShowTips(self.result)
	end
end

function var_0_0:GetIllustrateReward()
	manager.net:SendWithLoadingNew(89706, {
		activity_id = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN,
		buff_id = self.buffID
	}, 89707, var_0_0.OnGetIllustrateRewardBack)
end

function var_0_0:OnGetIllustrateRewardBack(arg_8_1)
	if isSuccess(self.result) then
		VehicleBallData:UpdateBuffRewardState(arg_8_1.buff_id, BilliardGameConst.VehicleBallBuffRewardState.RECEIVED)
		getReward({
			{
				id = MergeBallBuffCfg[arg_8_1.buff_id].reward[1],
				num = MergeBallBuffCfg[arg_8_1.buff_id].reward[2]
			}
		})
	else
		ShowTips(self.result)
	end
end

function var_0_0:UnlockBuff()
	manager.net:SendWithLoadingNew(89708, {
		activity_id = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN,
		buff_id = self.buffID
	}, 89709, var_0_0.OnUnlockBuffBack)
end

function var_0_0:OnUnlockBuffBack(arg_10_1)
	if isSuccess(self.result) then
		VehicleBallData:UpdateUnlockBuffList(arg_10_1.buff_id, true)
		VehicleBallData:UpdateBuffRewardState(arg_10_1.buff_id, BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD)
	else
		ShowTips(self.result)
	end
end

return var_0_0
