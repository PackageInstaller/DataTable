local var_0_0 = class("ChapterDailyContentView", import("..ChapterBaseContentView"))

function var_0_0.RefreshMapItems(arg_1_0)
	local var_1_0 = arg_1_0.chapterToggle_
	local var_1_1 = ChapterClientCfg.get_id_list_by_toggle[var_1_0]

	for iter_1_0 = #arg_1_0.itemList_ + 1, #var_1_1 do
		local var_1_2 = var_1_1[iter_1_0]
		local var_1_3 = arg_1_0:CreateItem(var_1_2)

		if var_1_3 then
			table.insert(arg_1_0.itemList_, {
				virtualItem = ChapterBaseVirtualItemView.New(arg_1_0.mapVirtualItem_, arg_1_0.itemParent_),
				renderItem = var_1_3
			})
		end
	end
end

function var_0_0.CreateItem(arg_2_0, arg_2_1)
	return (ChapterDailyItemView.New(arg_2_0.mapItem_, arg_2_0.itemParent_, arg_2_1, arg_2_0.chapterToggle_))
end

return var_0_0
