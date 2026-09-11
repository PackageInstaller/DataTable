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
	train = function(self)
		local var_1_2 = 1.55
		local var_1_3 = "train_head"
		local var_1_7 = math.random() > 0.5
		local var_1_8 = self.entityID
		local rail = import("..combineRule.rail")
		local var_1_11 = rail:GenerateTrain(1)

		Dorm.DormEntityManager.KeepAsInteractNotEnd(self.entityID, var_1_11[1], true)
		Dorm.DormEntityManager.AttachToEntityCMD(var_1_8, var_1_11[1], "gua_start")
		Dorm.DormEntityManager.PlayAnimeDuringInteract(var_1_8, var_1_3)

		for iter_1_0 = 2, rail:GetTrainCartNum() do
			DormLuaBridge.SetupFurnitureTileEntity(rail:GetTrainEID(iter_1_0))
		end

		local var_1_12 = rail:FindClosestPointOnRail((Dorm.DormEntityManager.QueryPosition(self.entityID)))

		DormCharacterActionManager.taskRunner:NewTask():Then(function(arg_2_0)
			for iter_2_0, iter_2_1 in ipairs(var_1_11) do
				Dorm.DormEntityManager.SetEntitySpeed(iter_2_1, 0)
			end

			manager.audio:PlayEffect("ui_dorm", "ui_dorm_train")
		end)
	end
}
