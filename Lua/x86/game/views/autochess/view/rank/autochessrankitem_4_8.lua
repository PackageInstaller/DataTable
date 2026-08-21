local var_0_0 = require("game/views/autoChess/view/rank/AutoChessRankItem")
local var_0_1 = class("AutoChessRankItem_4_8", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_1.InitUI(arg_2_0)
	var_0_1.super.InitUI(arg_2_0)

	arg_2_0.typeController = arg_2_0.conExCollection_:GetController("type")
end

function var_0_1.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.viewBtn_, nil, function()
		AutoChessMatchAction.OpenTeamnfoPopAfterFetch(arg_3_0:GetRankActivityID(), arg_3_0.data)
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_rank_team_touch",
			activity_id = AutoChessData:GetActivityID(),
			source = arg_3_0.data.user_id
		})
	end)
end

function var_0_1.Dispose(arg_5_0)
	var_0_1.super.Dispose(arg_5_0)
end

function var_0_1.GetRankActivityID(arg_6_0)
	if arg_6_0.isLevelRank_ then
		return ActivityConst.ACTIVITY_AUTO_CHESS_LEVEL_RANK
	else
		return ActivityConst.ACTIVITY_AUTO_CHESS_SCORE_RANK
	end
end

function var_0_1.SetData(arg_7_0, arg_7_1, arg_7_2)
	var_0_1.super.SetData(arg_7_0, arg_7_1)

	arg_7_0.isLevelRank = arg_7_2

	arg_7_0.typeController:SetSelectedIndex(arg_7_2 and 0 or 1)

	if arg_7_0.isLevelRank then
		local var_7_0 = AutoChessTools.GetRankLevelCfg(arg_7_1.score)

		arg_7_0.rankLevelText_.text = var_7_0.name
		arg_7_0.rankLevelIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Xihe/RankIcon/" .. var_7_0.icon)
	end
end

return var_0_1
