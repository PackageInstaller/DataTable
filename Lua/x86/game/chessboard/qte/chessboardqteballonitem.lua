local var_0_0 = class("ChessBoardQTEBallonItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.numText_.text = " "
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickCallback then
			arg_4_0.clickCallback(arg_4_0)
		end
	end)
end

function var_0_0.SetBtnClick(arg_6_0, arg_6_1)
	arg_6_0.clickCallback = arg_6_1
end

function var_0_0.ClickEffect(arg_7_0)
	arg_7_0.ani_:Play("ui_bubbIe_blow", 0, 0)
	manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_chess_qte02", "")
end

function var_0_0.SetPos(arg_8_0, arg_8_1)
	arg_8_0.transform_.localPosition = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
