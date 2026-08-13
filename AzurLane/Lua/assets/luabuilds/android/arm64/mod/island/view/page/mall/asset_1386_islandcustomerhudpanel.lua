class = var_0_10000

local var_0_0 = "IslandCustomerHudPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.Core.View.IslandBaseHudPanel"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandCustomerHud"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.hudImage = var_1.Find(var_2_0, "hudImage")
	pg = var_1
	arg_2_0.unitPosition = var_1.island_world_objects[arg_2_0.unitId].param.position
	pg = var_1
	arg_2_0.images = var_1.island_set.island_manage_bubble_resource.key_value_varchar
	pg = var_1
	arg_2_0.durations = var_1.island_set.island_manage_bubble_duration.key_value_varchar
	pg = var_1
	arg_2_0.cds = var_1.island_set.island_manage_bubble_cd.key_value_varchar
	GetImageSpriteFromAtlasAsync = var_1

	local var_2_1 = arg_2_0.images

	math = var_4

	var_1(var_2_1[var_4.random(#arg_2_0.images)], "", arg_2_0.hudImage)

	Timer = var_1

	local var_2_2 = var_1.New

	local function var_2_3()
		arg_2_0.active = not arg_2_0.active

		if arg_2_0.active then
			GetImageSpriteFromAtlasAsync = var_0

			local var_3_0 = arg_2_0.images

			math = var_2_10003

			var_0(var_3_0[var_2_10003.random(#arg_2_0.images)], "", arg_2_0.hudImage)

			local var_3_1 = arg_2_0.timer

			math = var_1
			var_3_1.duration = var_1.random(arg_2_0.durations[1], arg_2_0.durations[2])
		else
			local var_3_2 = arg_2_0.timer

			math = var_1
			var_3_2.duration = var_1.random(arg_2_0.cds[1], arg_2_0.cds[2])
		end

		return
	end

	math = var_4
	arg_2_0.timer = var_2_2(var_2_3, var_4.random(arg_2_0.durations[1], arg_2_0.durations[2]), -1)

	local var_2_4 = arg_2_0.timer

	var_1.Start(var_2_4)

	return
end

function var_0_1.OnDispose(arg_4_0)
	local var_4_0 = arg_4_0.timer

	var_1.Stop(var_4_0)

	arg_4_0.timer = nil

	var_0_1.super.OnDispose(arg_4_0)

	return
end

return var_0_1
