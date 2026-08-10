local var_0_0 = class("RecallSystemRecallNumberInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.copyBrn_, nil, function()
		ShowTips("COPY_SUCCESS")

		UnityEngine.GUIUtility.systemCopyBuffer = arg_3_0.data.user_id
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.data = arg_5_1

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	arg_6_0.recallNameTxt_.text = arg_6_0.data.base_info.nick
	arg_6_0.recallUIDTxt_.text = arg_6_0.data.user_id
	arg_6_0.recallHeadshotImg_.sprite = ItemTools.getItemSprite(arg_6_0.data.base_info.icon)

	arg_6_0.recallHeadshotImg_:SetNativeSize()

	arg_6_0.serverName.text = string.format(GetTips("RECALLED_SERVER_NAME"), arg_6_0.data.server_name)
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
