local var_0_0 = {}

manager.net:Bind(26009, function(arg_1_0)
	BattleStageData:InitChallengeData(arg_1_0.challenge_battle_list)
end)
manager.net:Bind(26017, function(arg_2_0)
	BattleStageData:InitChapterStarReward(arg_2_0.gain_list)
end)

return var_0_0
