ys = ys or {}

local var_0_0 = ys
local var_0_1 = pg

ys.MVC = ys.MVC or {}
ys.MVC.Facade = singletonClass("MVC.Facade")
ys.MVC.Facade.__name = "MVC.Facade"

function ys.MVC.Facade.Ctor(arg_1_0)
	arg_1_0:Initialize()

	return
end

function ys.MVC.Facade.AddDataProxy(arg_2_0, arg_2_1)
	assert(arg_2_1.__name ~= nil and type(arg_2_1.__name) == "string", arg_2_0.__name .. ".AddDataProxy: dataProxy.__name expected a string value")
	assert(arg_2_0._proxyList[arg_2_1.__name] == nil, arg_2_0.__name .. ".AddDataProxy: same dataProxy exist")

	arg_2_1._state = arg_2_0

	arg_2_1:ActiveProxy()

	arg_2_0._proxyList[arg_2_1.__name] = arg_2_1

	return arg_2_1
end

function ys.MVC.Facade.AddMediator(arg_3_0, arg_3_1)
	if arg_3_1.__name == nil or type(arg_3_1.__name) ~= "string" then
		assert(false, arg_3_0.__name .. ".AddMediator: mediator.__name expected a string value")
	end

	assert(arg_3_0._mediatorList[arg_3_1.__name] == nil, arg_3_0.__name .. ".AddMediator: same mediator exist")

	arg_3_0._mediatorList[arg_3_1.__name] = arg_3_1
	arg_3_1._state = arg_3_0

	arg_3_1:Initialize()

	return arg_3_1
end

function ys.MVC.Facade.AddCommand(arg_4_0, arg_4_1)
	if arg_4_1.__name == nil or type(arg_4_1.__name) ~= "string" then
		assert(false, arg_4_0.__name .. ".AddCommand: command.__name expected a string value")
	end

	assert(arg_4_0._commandList[arg_4_1.__name] == nil, arg_4_0.__name .. ".AddCommand: same command exist")

	arg_4_0._commandList[arg_4_1.__name] = arg_4_1
	arg_4_1._state = arg_4_0

	arg_4_1:Initialize()

	return arg_4_1
end

function ys.MVC.Facade.GetProxyByName(arg_5_0, arg_5_1)
	assert(type(arg_5_1) == "string", arg_5_0.__name .. ".GetProxyByName: expect a string value")

	return arg_5_0._proxyList[arg_5_1]
end

function ys.MVC.Facade.GetMediatorByName(arg_6_0, arg_6_1)
	assert(type(arg_6_1) == "string", arg_6_0.__name .. ".GetMediatorByName: expect a string value")

	return arg_6_0._mediatorList[arg_6_1]
end

function ys.MVC.Facade.GetCommandByName(arg_7_0, arg_7_1)
	assert(type(arg_7_1) == "string", arg_7_0.__name .. ".GetCommandByName: expect a string value")

	return arg_7_0._commandList[arg_7_1]
end

function ys.MVC.Facade.RemoveMediator(arg_8_0, arg_8_1)
	if type(arg_8_1) == "string" then
		arg_8_1 = arg_8_0._mediatorList[arg_8_1]
	end

	assert(arg_8_1 ~= nil, arg_8_0.__name .. ".RemoveMediator: try to remove a nil mediator")
	arg_8_1:Dispose()

	arg_8_0._mediatorList[arg_8_1.__name] = nil

	return
end

function ys.MVC.Facade.RemoveCommand(arg_9_0, arg_9_1)
	if type(arg_9_1) == "string" then
		arg_9_1 = arg_9_0._commandList[arg_9_1]
	end

	assert(arg_9_1 ~= nil, arg_9_0.__name .. ".RemoveCommand: try to remove a nil command")
	arg_9_1:Dispose()

	arg_9_0._commandList[arg_9_1.__name] = nil

	return
end

function ys.MVC.Facade.RemoveProxy(arg_10_0, arg_10_1)
	if type(arg_10_1) == "string" then
		arg_10_1 = arg_10_0._proxyList[arg_10_1]
	end

	assert(arg_10_1 ~= nil, arg_10_0.__name .. ".RemoveProxy: try to remove a nil proxy")
	arg_10_1:DeactiveProxy()

	arg_10_0._proxyList[arg_10_1.__name] = nil

	return
end

function ys.MVC.Facade.Initialize(arg_11_0)
	arg_11_0._proxyList = {}
	arg_11_0._commandList = {}
	arg_11_0._mediatorList = {}

	return
end

function ys.MVC.Facade.Active(arg_12_0)
	if not arg_12_0._isPause then
		return
	end

	arg_12_0._isPause = false

	var_0_1.TimeMgr.GetInstance():ResumeBattleTimer()

	return
end

function ys.MVC.Facade.Deactive(arg_13_0)
	if arg_13_0._isPause then
		return
	end

	arg_13_0._isPause = true

	var_0_1.TimeMgr.GetInstance():PauseBattleTimer()

	return
end

function ys.MVC.Facade.ActiveEscape(arg_14_0)
	arg_14_0._escapeAITimer = var_0_1.TimeMgr.GetInstance():AddTimer("escapeTimer", 0, var_0_0.Battle.BattleConfig.viewInterval, function()
		arg_14_0:escapeUpdate()

		return
	end)

	return
end

function ys.MVC.Facade.DeactiveEscape(arg_16_0)
	var_0_1.TimeMgr.GetInstance():RemoveTimer(arg_16_0._escapeAITimer)

	return
end

function ys.MVC.Facade.RemoveAllTimer(arg_17_0)
	var_0_1.TimeMgr.GetInstance():RemoveAllBattleTimer()

	arg_17_0._calcTimer = nil
	arg_17_0._AITimer = nil

	return
end

function ys.MVC.Facade.ResetTimer(arg_18_0)
	local var_18_0 = var_0_1.TimeMgr.GetInstance()

	var_18_0:ResetCombatTime()
	var_18_0:RemoveBattleTimer(arg_18_0._calcTimer)
	var_18_0:RemoveBattleTimer(arg_18_0._AITimer)

	arg_18_0._calcTimer = var_18_0:AddBattleTimer("calcTimer", -1, var_0_0.Battle.BattleConfig.calcInterval, function()
		arg_18_0:calcUpdate()

		return
	end)

	return
end

function ys.MVC.Facade.ActiveAutoComponentTimer(arg_20_0)
	arg_20_0._AITimer = var_0_1.TimeMgr.GetInstance():AddBattleTimer("aiTimer", -1, var_0_0.Battle.BattleConfig.AIInterval, function()
		arg_20_0:aiUpdate()

		return
	end)

	return
end

function ys.MVC.Facade.calcUpdate(arg_22_0)
	local var_22_0 = var_0_1.TimeMgr.GetInstance():GetCombatTime()

	for iter_22_0, iter_22_1 in pairs(arg_22_0._proxyList) do
		iter_22_1:Update(var_22_0)
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_0._commandList) do
		iter_22_3:Update(var_22_0)
	end

	return
end

function ys.MVC.Facade.aiUpdate(arg_23_0)
	arg_23_0:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name):UpdateAutoComponent(var_0_1.TimeMgr.GetInstance():GetCombatTime())

	return
end

function ys.MVC.Facade.escapeUpdate(arg_24_0)
	local var_24_0 = var_0_1.TimeMgr.GetInstance():GetCombatTime()

	arg_24_0:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name):UpdateEscapeOnly(var_24_0)
	arg_24_0:GetMediatorByName(var_0_0.Battle.BattleSceneMediator.__name):UpdateEscapeOnly(var_24_0)

	return
end

return
