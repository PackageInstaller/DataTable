local var_0_0 = {}

manager.net:Bind(65029, function(arg_1_0)
	AdvanceTestData:OnReceviedAdvanceTestData(arg_1_0)
end)
manager.net:Bind(65031, function(arg_2_0)
	AdvanceTestData:OnReceviedBattleResult(arg_2_0)
end)

return var_0_0
