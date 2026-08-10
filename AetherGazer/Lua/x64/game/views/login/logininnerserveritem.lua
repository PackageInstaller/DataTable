local var_0_0 = class("LoginInnerServerItem", ReduxView)

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
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_btn, function()
		local var_5_0 = gameContext:GetOpenPageHandler("login")

		if var_5_0 then
			var_5_0.currentServerIndex_ = arg_4_0.id

			var_5_0:UpdateInnerServer()
		end

		arg_4_0:Back()
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.id = arg_6_1.id
	arg_6_0.m_serverName.text = arg_6_1.name
	arg_6_0.m_branchName.text = arg_6_1.branch
	arg_6_0.m_coomitTime.text = arg_6_1.commit_time
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
