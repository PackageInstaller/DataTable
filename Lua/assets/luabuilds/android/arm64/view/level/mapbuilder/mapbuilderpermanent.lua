local var_0_0 = class("MapBuilderPermanent", import(".MapBuilder"))

function var_0_0.OnLoaded(arg_1_0)
	setParent(arg_1_0._tf, arg_1_0.float)

	return
end

function var_0_0.OnShow(arg_2_0)
	var_0_0.super.OnShow(arg_2_0)
	setActive(arg_2_0.sceneParent.float, true)

	return
end

function var_0_0.OnHide(arg_3_0)
	arg_3_0.sceneParent:HideBtns()
	setActive(arg_3_0.sceneParent.float, false)
	var_0_0.super.OnHide(arg_3_0)

	return
end

function var_0_0.UpdateButtons(arg_4_0)
	arg_4_0.sceneParent:updateDifficultyBtns()
	arg_4_0.sceneParent:updateActivityBtns()
	arg_4_0.sceneParent:UpdateSwitchMapButton()

	return
end

function var_0_0.UpdateMapItems(arg_5_0)
	var_0_0.super.UpdateMapItems(arg_5_0)

	local var_5_0 = arg_5_0.contextData.map
	local var_5_1 = arg_5_0.contextData.map:getConfig("cloud_suffix")

	if var_5_1 == "" then
		setActive(arg_5_0.sceneParent.clouds, false)
	else
		setActive(arg_5_0.sceneParent.clouds, true)

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.contextData.map:getConfig("clouds_pos")) do
			local var_5_2 = arg_5_0.sceneParent.cloudRTFs[iter_5_0]:GetComponent(typeof(Image))

			var_5_2.enabled = false

			GetSpriteFromAtlasAsync("clouds/cloud_" .. iter_5_0 .. "_" .. var_5_1, "", function(arg_6_0)
				if arg_5_0:CheckState(var_0_0.STATES.DESTROY) then
					return
				end

				if not IsNil(var_5_2) and var_5_0 == arg_5_0.contextData.map then
					var_5_2.enabled = true
					var_5_2.sprite = arg_6_0

					var_5_2:SetNativeSize()

					arg_5_0.sceneParent.cloudRects[iter_5_0] = var_0.rect.width
				end

				return
			end)
		end
	end

	return
end

return var_0_0
