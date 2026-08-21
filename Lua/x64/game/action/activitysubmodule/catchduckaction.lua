local var_0_0 = {}

manager.net:Bind(65441, function(arg_1_0)
	CatchDuckData:InitData(arg_1_0)
end)
manager.net:Bind(65442, function(arg_2_0)
	CatchDuckData:RefreshData(arg_2_0)
end)

return var_0_0
