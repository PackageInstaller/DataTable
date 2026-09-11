local AutoChessEffectSummonDataTemplate = class("AutoChessEffectSummonDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.buffActionData.AutoChessEffectBaseDataTemplate")))

function AutoChessEffectSummonDataTemplate:Init(arg_1_1)
	AutoChessEffectSummonDataTemplate.super.Init(self, arg_1_1)

	self.playerType = AutoChessConst.PLAYER_TYPE.SELF
	self.chessDataList = {}

	self:InitSummonData(arg_1_1.action_effect_info.call_info)
end

function AutoChessEffectSummonDataTemplate:InitSummonData(arg_2_1)
	if AutoChessData:GetCurGameType() == AutoChessConst.GAME_TYPE.ONLINE then
		if arg_2_1.user_id == PlayerData:GetPlayerInfo().userID then
			self.playerType = AutoChessConst.PLAYER_TYPE.SELF or AutoChessConst.PLAYER_TYPE.OPPONENT
		end
	else
		self.playerType = tonumber(arg_2_1.user_id)
	end

	self.chessDataList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.chess_list) do
		local var_2_0 = AutoChessItemDataTemplate.New()

		var_2_0:Init(iter_2_1)
		table.insert(self.chessDataList, var_2_0)
	end
end

return AutoChessEffectSummonDataTemplate
