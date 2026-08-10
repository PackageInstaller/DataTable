local var_0_0 = class("MatrixAffixGroup", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.GetContainer(arg_2_0)
	return arg_2_0.transform_
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.items = {}
end

function var_0_0.Refresh(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.id = arg_5_1.id
	arg_5_0.list = arg_5_1.list

	local var_5_0 = getAffixName({
		arg_5_0.id
	})

	arg_5_0.m_name.text = GetI18NText(var_5_0)

	for iter_5_0 = 1, #arg_5_0.list do
		if not arg_5_0.items[iter_5_0] then
			local var_5_1 = Object.Instantiate(arg_5_0.m_item, arg_5_0.m_content)

			arg_5_0.items[iter_5_0] = MatrixSelectAffixItem.New(var_5_1)
		end

		local var_5_2 = arg_5_0.list[iter_5_0]
		local var_5_3 = 0
		local var_5_4 = table.indexof(arg_5_2, var_5_2) and 2 or table.indexof(arg_5_3, var_5_2) and 1 or 0

		arg_5_0.items[iter_5_0]:Refresh(var_5_2, var_5_4)
	end

	while #arg_5_0.items > #arg_5_0.list do
		local var_5_5 = arg_5_0.items[#arg_5_0.items]

		SetActive(var_5_5.gameObject_, false)
		var_5_5:Dispose()
		table.remove(arg_5_0.items, #arg_5_0.items)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.transform_)
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.items) do
		iter_6_1:RegistCallBack(arg_6_1)
	end
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveAllListeners()

	if arg_7_0.items then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.items) do
			iter_7_1:Dispose()
		end

		arg_7_0.items = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
