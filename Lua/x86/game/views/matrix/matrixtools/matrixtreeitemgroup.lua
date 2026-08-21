local var_0_0 = class("MatrixTreeItemGroup", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.itemGo_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.GetContainer(arg_2_0)
	return arg_2_0.transform_
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.items_ = {}
	arg_4_0.toggleGroup_ = arg_4_0.gameObject_:GetComponent(typeof(ToggleGroup))
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.tag_ = arg_5_1
	arg_5_0.list_ = arg_5_3

	arg_5_0:UpdateItems()

	if not arg_5_0.items_[arg_5_2]:GetToggle().isOn then
		arg_5_0.items_[arg_5_2]:GetToggle().isOn = true
	else
		arg_5_0:NotifySelect(arg_5_0.tag_, arg_5_2, arg_5_0.list_[arg_5_2])
	end
end

function var_0_0.UpdateItems(arg_6_0)
	for iter_6_0 = 1, #arg_6_0.list_ do
		if not arg_6_0.items_[iter_6_0] then
			local var_6_0 = Object.Instantiate(arg_6_0.itemGo_, arg_6_0.transform_)

			arg_6_0.items_[iter_6_0] = MatrixTreeItem.New(var_6_0)
			arg_6_0.items_[iter_6_0]:GetToggle().group = arg_6_0.toggleGroup_

			arg_6_0.items_[iter_6_0]:GetToggle().onValueChanged:AddListener(function(arg_7_0)
				if arg_7_0 then
					arg_6_0:NotifySelect(arg_6_0.tag_, iter_6_0, arg_6_0.list_[iter_6_0])
				end
			end)
		end

		arg_6_0.items_[iter_6_0]:SetData(arg_6_0.tag_, arg_6_0.list_[iter_6_0])
	end

	while #arg_6_0.items_ > #arg_6_0.list_ do
		local var_6_1 = arg_6_0.items_[#arg_6_0.items_]

		SetActive(var_6_1.gameObject_, false)
		arg_6_0:DisposeItem(var_6_1)
		table.remove(arg_6_0.items_, #arg_6_0.items_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.transform_)
end

function var_0_0.NotifySelect(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0.selectedCallback_ then
		arg_8_0.selectedCallback_(arg_8_1, arg_8_2, arg_8_3)
	end
end

function var_0_0.SetSelectCallback(arg_9_0, arg_9_1)
	arg_9_0.selectedCallback_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()

	if arg_10_0.items_ then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.items_) do
			arg_10_0:DisposeItem(iter_10_1)
		end

		arg_10_0.items_ = nil
	end

	arg_10_0.selectedCallback_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.DisposeItem(arg_11_0, arg_11_1)
	arg_11_1:GetToggle().onValueChanged:RemoveAllListeners()
	arg_11_1:Dispose()
end

return var_0_0
