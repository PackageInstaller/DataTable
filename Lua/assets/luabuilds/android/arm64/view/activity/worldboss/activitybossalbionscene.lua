local var_0_0 = class("ActivityBossAlbionScene", import(".ActivityBossSceneTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "ActivityBossAlbionUI"
end

function var_0_0.UpdateDropItems(arg_2_0)
	local var_2_0 = arg_2_0.contextData.DisplayItems or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = arg_2_0.barList[iter_2_0]:Find("milestone/item/IconTpl")

		updateDrop(var_2_1, {
			type = arg_2_0.contextData.DisplayItems[5 - iter_2_0][1],
			id = arg_2_0.contextData.DisplayItems[5 - iter_2_0][2],
			count = arg_2_0.contextData.DisplayItems[5 - iter_2_0][3]
		})
		onButton(arg_2_0, var_2_1, function()
			arg_2_0:emit(var_0_0.ON_DROP, var_0)

			return
		end, SFX_PANEL)
	end

	return
end

return var_0_0
