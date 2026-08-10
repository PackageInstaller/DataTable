local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.buffActionData.AutoChessEffectBaseDataTemplate")
local var_0_1 = class("AutoChessEffectSummonDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)

	arg_1_0.playerType = AutoChessConst.PLAYER_TYPE.SELF
	arg_1_0.chessDataList = {}

	arg_1_0:InitSummonData(arg_1_1.action_effect_info.call_info)
end

function var_0_1.InitSummonData(arg_2_0, arg_2_1)
	if AutoChessData:GetCurGameType() == AutoChessConst.GAME_TYPE.ONLINE then
		local var_2_0 = PlayerData:GetPlayerInfo().userID

		arg_2_0.playerType = arg_2_1.user_id == var_2_0 and AutoChessConst.PLAYER_TYPE.SELF or AutoChessConst.PLAYER_TYPE.OPPONENT
	else
		arg_2_0.playerType = tonumber(arg_2_1.user_id)
	end

	arg_2_0.chessDataList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.chess_list) do
		local var_2_1 = AutoChessItemDataTemplate.New()

		var_2_1:Init(iter_2_1)
		table.insert(arg_2_0.chessDataList, var_2_1)
	end
end

return var_0_1
