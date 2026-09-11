local AutoChessDesireDataTemplate = class("AutoChessDesireDataTemplate")

function AutoChessDesireDataTemplate:Ctor()
	self.TradeID = 0
	self.CardID = 0
	self.PlayerID = 0
	self.NickName = ""
	self.Icon = 0
	self.Level = 0
	self.CardList = {}
	self.State = 0
	self.BlessID = 0
	self.CompleteDesireUser = {}
end

function AutoChessDesireDataTemplate:InitData(arg_2_1)
	self.CardID = arg_2_1.target_id
	self.CardList = arg_2_1.cost_ids
	self.State = arg_2_1.status
	self.BlessID = arg_2_1.bless_id
	self.PlayerID = arg_2_1.user_info.user_id
	self.NickName = arg_2_1.user_info.nick
	self.Icon = arg_2_1.user_info.icon
	self.Level = arg_2_1.user_info.rank_score
	self.TradeID = arg_2_1.trade_id
end

function AutoChessDesireDataTemplate:InitCompleteDesireUser(arg_3_1, arg_3_2)
	local var_3_0 = PlayerData:GetPlayerInfo()

	self.CompleteDesireUser.SelectCardId = arg_3_1
	self.CompleteDesireUser.PlayerID = var_3_0.userID
	self.CompleteDesireUser.NickName = var_3_0.nick
	self.CompleteDesireUser.Icon = var_3_0.portrait
	self.CompleteDesireUser.Level = AutoChessCardData:GetRankScore()
	self.CompleteDesireUser.BlessID = arg_3_2
end

return AutoChessDesireDataTemplate
