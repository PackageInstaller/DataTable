class = var_0_10000

local var_0_0 = "MapBuilderPermanent"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MapBuilder"))

function var_0_1.OnLoaded(arg_1_0)
	setParent = var_1_10001

	var_1_10001(arg_1_0._tf, arg_1_0.float)

	return
end

function var_0_1.OnShow(arg_2_0)
	var_0_1.super.OnShow(arg_2_0)

	setActive = var_1

	var_1(arg_2_0.sceneParent.float, true)

	return
end

function var_0_1.OnHide(arg_3_0)
	local var_3_0 = arg_3_0.sceneParent

	var_1.HideBtns(var_3_0)

	setActive = var_1

	var_1(arg_3_0.sceneParent.float, false)
	var_0_1.super.OnHide(arg_3_0)

	return
end

function var_0_1.UpdateButtons(arg_4_0)
	local var_4_0 = arg_4_0.sceneParent

	var_1.updateDifficultyBtns(var_4_0)

	local var_4_1 = arg_4_0.sceneParent

	var_1.updateActivityBtns(var_4_1)

	local var_4_2 = arg_4_0.sceneParent

	var_1.UpdateSwitchMapButton(var_4_2)

	return
end

function var_0_1.UpdateMapItems(arg_5_0)
	var_0_1.super.UpdateMapItems(arg_5_0)

	local var_5_0 = arg_5_0.contextData.map

	if var_1.getConfig(var_5_0, "cloud_suffix") == "" then
		setActive = var_3

		var_3(arg_5_0.sceneParent.clouds, false)
	else
		setActive = var_3

		var_3(arg_5_0.sceneParent.clouds, true)

		ipairs = var_3

		for iter_5_0, iter_5_1 in var_3(var_1:getConfig("clouds_pos")) do
			local var_5_1 = arg_5_0.sceneParent.cloudRTFs[iter_5_0]
			local var_5_2 = var_8.GetComponent

			typeof = var_1_10012
			Image = var_1_10014

			local var_5_3 = var_5_2(var_5_1, var_1_10012(var_1_10014))

			var_5_3.enabled = false
			GetSpriteFromAtlasAsync = var_10

			var_10("clouds/cloud_" .. iter_5_0 .. "_" .. var_2, "", function(arg_6_0)
				local var_6_0 = arg_5_0

				if var_1.CheckState(var_6_0, var_0_1.STATES.DESTROY) then
					return
				end

				IsNil = var_1

				if not var_1(var_5_3) and var_0 == arg_5_0.contextData.map then
					var_5_3.enabled = true
					var_5_3.sprite = arg_6_0

					local var_6_1 = var_5_3

					var_1.SetNativeSize(var_6_1)

					arg_5_0.sceneParent.cloudRects[iter_5_0] = var_0.rect.width
				end

				return
			end)
		end
	end

	return
end

return var_0_1
