local var_0_0 = class("PolyhedronOverArtifactGroup", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.itemList = {}
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.m_title.text = PolyhedronTools.GetPolyhedronArtifactSubTypeDes(arg_5_1)
	arg_5_0.group = arg_5_2

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.group) do
		if not arg_5_0.itemList[iter_5_0] then
			local var_5_0 = Object.Instantiate(arg_5_0.m_item, arg_5_0.m_content)

			table.insert(arg_5_0.itemList, PolyhedronOverArtifactItem.New(var_5_0))
		end

		arg_5_0.itemList[iter_5_0]:SetActive(true)
		arg_5_0.itemList[iter_5_0]:SetData(iter_5_1)
	end

	local var_5_1 = #arg_5_0.itemList

	for iter_5_2 = #arg_5_0.group + 1, var_5_1 do
		arg_5_0.itemList[iter_5_2]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.m_content)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.transform_)
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList) do
		iter_6_1:RegistCallBack(arg_6_1)
	end
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.itemList) do
		iter_8_1:Dispose()
	end

	arg_8_0.itemList = nil

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	return
end

return var_0_0
