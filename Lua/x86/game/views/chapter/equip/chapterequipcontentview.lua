local var_0_0 = class("ChapterEquipContentView", import("..ChapterBaseContentView"))

function var_0_0.RefreshMapItems(arg_1_0)
	local var_1_0 = arg_1_0.chapterToggle_
	local var_1_1 = ChapterClientCfg.get_id_list_by_toggle[var_1_0]

	for iter_1_0 = #arg_1_0.itemList_ + 1, #var_1_1 do
		local var_1_2

		if var_1_1[iter_1_0] == 203 then
			var_1_2 = ChapterEquipEnchantmentItemView.New(arg_1_0.mapItem_, arg_1_0.itemParent_, var_1_1[iter_1_0], var_1_0)
		elseif var_1_1[iter_1_0] == 204 then
			var_1_2 = ChapterEquipExperienceItemView.New(arg_1_0.mapItem_, arg_1_0.itemParent_, var_1_1[iter_1_0], var_1_0)
		elseif var_1_1[iter_1_0] == 205 then
			var_1_2 = ChapterEquipSeizureItemView.New(arg_1_0.mapItem_, arg_1_0.itemParent_, var_1_1[iter_1_0], var_1_0)
		else
			var_1_2 = ChapterEquipItemView.New(arg_1_0.mapItem_, arg_1_0.itemParent_, var_1_1[iter_1_0], var_1_0)
		end

		if var_1_2 then
			table.insert(arg_1_0.itemList_, {
				virtualItem = ChapterBaseVirtualItemView.New(arg_1_0.mapVirtualItem_, arg_1_0.itemParent_),
				renderItem = var_1_2
			})
		end
	end
end

return var_0_0
