local var_0_0 = class("PolyhedronSetArtifactGroup", ReduxView)

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

function var_0_0.RegistCallBack(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.itemList) do
		iter_5_1:RegistCallBack(arg_5_1)
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.m_title.text = PolyhedronTools.GetPolyhedronArtifactSubTypeDes(arg_6_1)
	arg_6_0.group = arg_6_2

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.group) do
		if not arg_6_0.itemList[iter_6_0] then
			arg_6_0.itemList[iter_6_0] = PolyhedronSetArtifactItem.New(arg_6_0.m_item, arg_6_0.m_content)
		end

		arg_6_0.itemList[iter_6_0]:SetActive(true)
		arg_6_0.itemList[iter_6_0]:SetData(iter_6_1)
	end

	local var_6_0 = #arg_6_0.itemList

	for iter_6_2 = #arg_6_0.group + 1, var_6_0 do
		arg_6_0.itemList[iter_6_2]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.m_content)
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

function var_0_0.RefreshContentHeight(arg_9_0)
	local var_9_0 = arg_9_0.m_content:GetComponent("VerticalLayoutGroup").spacing
	local var_9_1 = 0
	local var_9_2 = arg_9_0.m_content.childCount
	local var_9_3

	for iter_9_0 = 1, var_9_2 do
		var_9_1 = var_9_1 + arg_9_0.m_content:GetChild(iter_9_0 - 1):GetSizeDeltaY(nil) + var_9_0
	end

	local var_9_4 = var_9_1 - var_9_0

	arg_9_0.m_content:SetSizeDeltaY(var_9_4)
end

function var_0_0.RefreshHeight(arg_10_0)
	local var_10_0 = arg_10_0.transform_:GetComponent("VerticalLayoutGroup").spacing
	local var_10_1 = 0
	local var_10_2 = arg_10_0.transform_.childCount
	local var_10_3

	for iter_10_0 = 1, var_10_2 do
		var_10_1 = var_10_1 + arg_10_0.transform_:GetChild(iter_10_0 - 1):GetSizeDeltaY(nil) + var_10_0
	end

	local var_10_4 = var_10_1 - var_10_0

	arg_10_0.transform_:SetSizeDeltaY(var_10_4)
end

return var_0_0
