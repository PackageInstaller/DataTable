return {
	FurniturePosition = {
		defaultPos = {
			501,
			0,
			-2.1
		},
		wallPos = {
			503,
			-1.5,
			-6
		},
		backgroundPos = {
			502.2,
			-0.8,
			-13
		},
		floorPos = {
			501.85,
			-0.5,
			-8.51
		}
	},
	TaskCondition = {
		dance = 2014,
		hero = 2013,
		fur = 2015
	},
	train = function(arg_1_0)
		local var_1_0 = "CharDorm/prop/huochetou"
		local var_1_1 = "CharDorm/prop/huochexiang"
		local var_1_2 = 1.55
		local var_1_3 = 1
		local var_1_4 = "train_head"
		local var_1_5 = 1.5
		local var_1_6 = "train_head_stand"
		local var_1_7 = 1.3
		local var_1_8 = math.random() > 0.5
		local var_1_9 = arg_1_0.entityID
		local var_1_10 = arg_1_0.targetID
		local var_1_11 = import("..combineRule.rail")
		local var_1_12 = Dorm.DormEntityManager.QueryPosition(var_1_9)
		local var_1_13 = var_1_11:GenerateTrain(var_1_3)
		local var_1_14 = var_1_13[1]

		Dorm.DormEntityManager.KeepAsInteractNotEnd(var_1_9, var_1_14, true)
		Dorm.DormEntityManager.AttachToEntityCMD(var_1_9, var_1_14, "gua_start")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_1_9, var_1_4)

		for iter_1_0 = 2, var_1_11:GetTrainCartNum() do
			DormLuaBridge.SetupFurnitureTileEntity(var_1_11:GetTrainEID(iter_1_0))
		end

		local var_1_15 = var_1_11:FindClosestPointOnRail(var_1_12)

		DormCharacterActionManager.taskRunner:NewTask():Then(function(arg_2_0)
			for iter_2_0, iter_2_1 in ipairs(var_1_13) do
				local var_2_0 = var_1_15 - (iter_2_0 - 1) * var_1_2 * (var_1_8 and -1 or 1)

				Dorm.DormEntityManager.SetEntitySpeed(iter_2_1, 0)
			end

			manager.audio:PlayEffect("ui_dorm", "ui_dorm_train")
		end)
	end
}
