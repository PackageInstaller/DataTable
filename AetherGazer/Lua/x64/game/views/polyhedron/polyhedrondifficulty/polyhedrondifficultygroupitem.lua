local var_0_0 = class("polyhedronDifficultyGroupItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.id = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.itemList = {}

	local var_3_0 = PolyhedronDifficultyCfg[arg_3_0.id]

	for iter_3_0, iter_3_1 in ipairs(var_3_0.params) do
		local var_3_1 = Object.Instantiate(arg_3_0.m_item, arg_3_0.m_content)

		SetActive(var_3_1, true)
		table.insert(arg_3_0.itemList, PolyhedronDifficultyItem.New(var_3_1, iter_3_1))
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.m_content)

	arg_3_0.transform_.sizeDelta = Vector2.New(arg_3_0.transform_.rect.width, arg_3_0.m_content.rect.height + 50)
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.m_lvLab.text = arg_3_0.id
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.id)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 < PolyhedronDifficultyCfg[arg_6_0.id].unlock_difficulty then
		arg_6_0.stateController:SetSelectedIndex(1)
	elseif arg_6_2 >= arg_6_0.id then
		arg_6_0.stateController:SetSelectedIndex(2)
	else
		arg_6_0.stateController:SetSelectedIndex(0)
	end
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.clickFunc = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.itemList) do
		iter_8_1:Dispose()
	end

	arg_8_0.itemList = {}

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
