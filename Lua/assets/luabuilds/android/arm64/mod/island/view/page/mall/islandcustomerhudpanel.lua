local var_0_0 = class("IslandCustomerHudPanel", import("Mod.Island.Core.View.IslandBaseHudPanel"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandCustomerHud"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.hudImage = arg_2_0._tf:Find("hudImage")
	arg_2_0.unitPosition = pg.island_world_objects[arg_2_0.unitId].param.position
	arg_2_0.images = pg.island_set.island_manage_bubble_resource.key_value_varchar
	arg_2_0.durations = pg.island_set.island_manage_bubble_duration.key_value_varchar
	arg_2_0.cds = pg.island_set.island_manage_bubble_cd.key_value_varchar

	GetImageSpriteFromAtlasAsync(arg_2_0.images[math.random(#arg_2_0.images)], "", arg_2_0.hudImage)

	arg_2_0.timer = Timer.New(function()
		arg_2_0.active = not arg_2_0.active

		if arg_2_0.active then
			GetImageSpriteFromAtlasAsync(arg_2_0.images[math.random(#arg_2_0.images)], "", arg_2_0.hudImage)

			arg_2_0.timer.duration = math.random(arg_2_0.durations[1], arg_2_0.durations[2])
		else
			arg_2_0.timer.duration = math.random(arg_2_0.cds[1], arg_2_0.cds[2])
		end

		return
	end, math.random(arg_2_0.durations[1], arg_2_0.durations[2]), -1)

	arg_2_0.timer:Start()

	return
end

function var_0_0.OnDispose(arg_4_0)
	arg_4_0.timer:Stop()

	arg_4_0.timer = nil

	var_0_0.super.OnDispose(arg_4_0)

	return
end

return var_0_0
