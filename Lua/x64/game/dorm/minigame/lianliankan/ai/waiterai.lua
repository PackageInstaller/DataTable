local var_0_0 = {}
local var_0_1 = "lianliankan.path.RestaurantWaiter"
local var_0_2
local var_0_3

function var_0_0.SetEntity(arg_1_0)
	var_0_2 = arg_1_0
end

function var_0_0.Work()
	local var_2_0 = Dorm.storage:PickData(var_0_1)
	local var_2_1 = var_0_2

	var_0_3 = true

	Dorm.DormEntityManager.ClearInteractEffectOnAttachPoint(var_2_1, "gua_R_hand_bone")
	Dorm.DormEntityManager.PlayEffect(var_2_1, "gua_R_hand_bone", "Effect/Dorm/food03", -1)
	Dorm.DormEntityManager.ChangeEntityAnimeScheme(var_2_1, "carry")
	Dorm.DormEntityManager.StopAllCmd(var_2_1)
	Dorm.DormEntityManager.SendDoActionCMD(var_2_1, "serve", "01", false)
	DormUtils.MoveByPath(var_2_1, var_2_0, true, false)
end

function var_0_0.Back()
	var_0_3 = false

	local var_3_0 = Dorm.storage:PickData(var_0_1)
	local var_3_1 = var_0_2

	Dorm.DormEntityManager.ClearInteractEffectOnAttachPoint(var_3_1, "gua_R_hand_bone")
	Dorm.DormEntityManager.RestoreEntityAnimeScheme(var_3_1)
	DormUtils.MoveByPath(var_3_1, var_3_0, true, true)
end

function var_0_0.OnEntityCompleteAllCmd(arg_4_0)
	if arg_4_0 == var_0_2 and var_0_3 then
		var_0_0.Back()
	end
end

var_0_0.events = {
	[ON_DORM_CHARACTER_WAIT_CMD] = var_0_0.OnEntityCompleteAllCmd,
	[LIANLIANKAN_ITEM_OVERFLOW] = var_0_0.Work
}

return var_0_0
