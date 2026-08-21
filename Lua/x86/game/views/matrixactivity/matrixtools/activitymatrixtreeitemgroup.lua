local var_0_0 = class("ActivityMatrixTreeItemGroup", MatrixTreeItemGroup)

function var_0_0.SetData(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.tag_ = arg_1_1
	arg_1_0.list_ = arg_1_3
	arg_1_0.matrix_activity_id = arg_1_4

	arg_1_0:UpdateItems()

	if not arg_1_0.items_[arg_1_2]:GetToggle().isOn then
		arg_1_0.items_[arg_1_2]:GetToggle().isOn = true
	else
		arg_1_0:NotifySelect(arg_1_0.tag_, arg_1_2, arg_1_0.list_[arg_1_2])
	end
end

function var_0_0.UpdateItems(arg_2_0)
	for iter_2_0 = 1, #arg_2_0.list_ do
		if not arg_2_0.items_[iter_2_0] then
			local var_2_0 = Object.Instantiate(arg_2_0.itemGo_, arg_2_0.transform_)

			arg_2_0.items_[iter_2_0] = ActivityMatrixTreeItem.New(var_2_0)
			arg_2_0.items_[iter_2_0]:GetToggle().group = arg_2_0.toggleGroup_

			arg_2_0.items_[iter_2_0]:GetToggle().onValueChanged:AddListener(function(arg_3_0)
				if arg_3_0 then
					arg_2_0:NotifySelect(arg_2_0.tag_, iter_2_0, arg_2_0.list_[iter_2_0])
				end
			end)
		end

		arg_2_0.items_[iter_2_0]:SetData(arg_2_0.tag_, arg_2_0.list_[iter_2_0], arg_2_0.matrix_activity_id)
	end

	while #arg_2_0.items_ > #arg_2_0.list_ do
		local var_2_1 = arg_2_0.items_[#arg_2_0.items_]

		SetActive(var_2_1.gameObject_, false)
		arg_2_0:DisposeItem(var_2_1)
		table.remove(arg_2_0.items_, #arg_2_0.items_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_2_0.transform_)
end

return var_0_0
