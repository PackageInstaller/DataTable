local var_0_0 = class("OsirisRecallItem", ReduxView)

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

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "Item")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_button, nil, function()
		manager.story:StartStoryById(arg_4_0.id, function()
			return
		end)
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.id = arg_7_1

	if PlayerData:GetPlayerInfo().storylist[arg_7_1] or false then
		arg_7_0.m_button.interactable = true

		arg_7_0.stateController:SetSelectedIndex(0)
	else
		arg_7_0.m_button.interactable = false

		arg_7_0.stateController:SetSelectedIndex(1)
	end

	local var_7_0 = StoryCfg[arg_7_1]

	arg_7_0.m_name.text = var_7_0 and GetI18NText(var_7_0.name) or ""
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
