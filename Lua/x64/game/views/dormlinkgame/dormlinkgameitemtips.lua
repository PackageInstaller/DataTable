local var_0_0 = class("DormLinkGameItemTips", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_LinkGame/Alone_LGExplainPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgmaskBtn_, nil, function()
		JumpTools:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.itemID = arg_8_0.params_.itemID

	arg_8_0:RefreshView()
end

function var_0_0.RefreshView(arg_9_0)
	local var_9_0 = ActivityLinkGameGoodsCfg[arg_9_0.itemID]

	if var_9_0 then
		arg_9_0.title_.text = var_9_0.name
		arg_9_0.text_.text = var_9_0.goods_des

		local var_9_1 = DormLinkGameData:GetMainActivityID()

		arg_9_0.icon_.sprite = DormLinkGameTools:GetDormLinkGameItemIcon(var_9_1, arg_9_0.itemID)
	end
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.OnExitInput(arg_11_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
