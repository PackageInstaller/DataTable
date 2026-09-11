local function var_0_4(arg_2_0)
	return (nullable(DormUtils.GetEntityData(arg_2_0), "rail"))
end

local var_0_5 = 1.55
local var_0_6 = 4
local var_0_7 = "train_head"

return function(arg_3_0)
	local var_3_0 = math.random() > 0.5
	local var_3_1 = arg_3_0.entityID
	local var_3_2 = var_0_4(arg_3_0.targetID)
	local var_3_3 = var_3_2.path
	local var_3_4 = var_3_2:GenerateTrain(var_0_6)

	Dorm.DormEntityManager.KeepAsInteractNotEnd(arg_3_0.entityID, var_3_4[1], true)
	Dorm.DormEntityManager.AttachToEntityCMD(var_3_1, var_3_4[1], "gua_start")
	Dorm.DormEntityManager.PlayAnimeDuringInteract(var_3_1, var_0_7)

	for iter_3_0 = 2, var_3_2:GetTrainCartNum() do
		DormLuaBridge.SetupFurnitureTileEntity(var_3_2:GetTrainEID(iter_3_0))
	end

	local var_3_5 = var_3_2:FindClosestPointOnRail((Dorm.DormEntityManager.QueryPosition(arg_3_0.entityID)))
	local var_3_6 = DormCharacterActionManager.taskRunner:NewTask()

	var_3_6:Then(function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(var_3_4) do
			Dorm.DormEntityManager.SendPatrolCMD(iter_4_1, var_3_3, var_3_0, var_3_5 - (iter_4_0 - 1) * var_0_5 * (var_3_0 and -1 or 1), false)
			Dorm.DormEntityManager.SetEntitySpeed(iter_4_1, 0)
		end

		manager.audio:PlayEffect("ui_dorm", "ui_dorm_train")
	end)

	return var_3_6
end
