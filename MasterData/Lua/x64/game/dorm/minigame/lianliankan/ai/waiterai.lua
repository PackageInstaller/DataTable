local var_0_0 = {}
local var_0_1 = "lianliankan.path.RestaurantWaiter"
local var_0_2
local var_0_3

function var_0_0.SetEntity(arg_1_0)
	var_0_2 = arg_1_0
end

function var_0_0.Work()
	var_0_3 = true

	Dorm.DormEntityManager.ClearInteractEffectOnAttachPoint(var_0_2, "gua_R_hand_bone")
	Dorm.DormEntityManager.PlayEffect(var_0_2, "gua_R_hand_bone", "Effect/Dorm/food03", -1)
	Dorm.DormEntityManager.ChangeEntityAnimeScheme(var_0_2, "carry")
	Dorm.DormEntityManager.StopAllCmd(var_0_2)
	Dorm.DormEntityManager.SendDoActionCMD(var_0_2, "serve", "01", false)
	DormUtils.MoveByPath(var_0_2, Dorm.storage:PickData(var_0_1), true, false)
end

function var_0_0.Back()
	var_0_3 = false

	Dorm.DormEntityManager.ClearInteractEffectOnAttachPoint(var_0_2, "gua_R_hand_bone")
	Dorm.DormEntityManager.RestoreEntityAnimeScheme(var_0_2)
	DormUtils.MoveByPath(var_0_2, Dorm.storage:PickData(var_0_1), true, true)
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
