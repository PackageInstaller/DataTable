local var_0_0 = class("AutoChessDesireDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.TradeID = 0
	arg_1_0.CardID = 0
	arg_1_0.PlayerID = 0
	arg_1_0.NickName = ""
	arg_1_0.Icon = 0
	arg_1_0.Level = 0
	arg_1_0.CardList = {}
	arg_1_0.State = 0
	arg_1_0.BlessID = 0
	arg_1_0.CompleteDesireUser = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.CardID = arg_2_1.target_id
	arg_2_0.CardList = arg_2_1.cost_ids
	arg_2_0.State = arg_2_1.status
	arg_2_0.BlessID = arg_2_1.bless_id
	arg_2_0.PlayerID = arg_2_1.user_info.user_id
	arg_2_0.NickName = arg_2_1.user_info.nick
	arg_2_0.Icon = arg_2_1.user_info.icon
	arg_2_0.Level = arg_2_1.user_info.rank_score
	arg_2_0.TradeID = arg_2_1.trade_id
end

function var_0_0.InitCompleteDesireUser(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = PlayerData:GetPlayerInfo()
	local var_3_1 = AutoChessCardData:GetRankScore()

	arg_3_0.CompleteDesireUser.SelectCardId = arg_3_1
	arg_3_0.CompleteDesireUser.PlayerID = var_3_0.userID
	arg_3_0.CompleteDesireUser.NickName = var_3_0.nick
	arg_3_0.CompleteDesireUser.Icon = var_3_0.portrait
	arg_3_0.CompleteDesireUser.Level = var_3_1
	arg_3_0.CompleteDesireUser.BlessID = arg_3_2
end

return var_0_0
