local var_0_0 = class("AutoChessHeadItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.gameType_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)

	if arg_3_0.gameType_ == AutoChessConst.GAME_TYPE.PVE then
		if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_5_0 then
			arg_3_0.title_.text = GetTips("AUTO_CHESS_2_VS_TITLE")
		else
			arg_3_0.title_.text = GetTips("AUTO_CHESS_PVE_ENTRANCE")
		end
	else
		arg_3_0.title_.text = GetTips("AUTO_CHESS_PVP_ENTRANCE")
	end
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0.commonPortrait_:RegisteClickCallback(handler(arg_5_0, arg_5_0.OnClickBackCall))
end

function var_0_0.OnClickBackCall(arg_6_0)
	if arg_6_0.gameType_ == AutoChessConst.GAME_TYPE.PVE then
		OperationRecorder.RecordButtonTouch({
			source = 2,
			button_name = "activity_autochess_headshots_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	else
		OperationRecorder.RecordButtonTouch({
			source = 3,
			button_name = "activity_autochess_headshots_touch",
			activity_id = AutoChessData:GetActivityID()
		})
	end

	JumpTools.OpenPageByJump("autoChessHeadTipsPopView", {
		type = 2
	})
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
