local var_0_0 = {}

manager.net:Bind(51001, function(arg_1_0)
	HistoryData:InitData(arg_1_0)
	manager.notify:Invoke(HISTORY_UPDATE)
end)

return var_0_0
