class = var_0_10000

local var_0_0 = "IslandStoryRecordPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mgr.Story.NewStoryRecordPanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.view = arg_1_1

	var_0_1.super.Ctor(arg_1_0)

	return
end

function var_0_1.GetUIName(arg_2_0)
	return "IslandStoryRecordUI"
end

function var_0_1.GetParent(arg_3_0)
	return arg_3_0.view._tf
end

function var_0_1.UpdateIcon(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1.icon

	GetImageSpriteFromAtlasAsync = var_1_10004

	var_1_10004("island/IslandShipIcon/" .. var_4_0, "", arg_4_2:Find("Image"))

	return
end

function var_0_1.BlurPanel(arg_5_0)
	return
end

function var_0_1.UnOverlayPanel(arg_6_0)
	return
end

return var_0_1
