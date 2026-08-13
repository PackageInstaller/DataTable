ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
pg = var_0_10001

local var_0_1

if not var_0.MVC then
	var_0_1 = {}
end

var_0.MVC = var_0_1

local var_0_2 = var_0.MVC

singletonClass = var_0_10003
var_0_2.Facade = var_0_10003("MVC.Facade")
var_0.MVC.Facade.__name = "MVC.Facade"

function var_0.MVC.Facade.Ctor(arg_1_0)
	arg_1_0:Initialize()

	return
end

function var_0.MVC.Facade.AddDataProxy(arg_2_0, arg_2_1)
	assert = var_1_10002

	if arg_2_1.__name ~= nil then
		type = var_3

		local var_2_0

		if var_3(arg_2_1.__name) ~= "string" then
			var_2_0 = false
		else
			var_2_0 = true
		end

		var_1_10002(var_2_0, arg_2_0.__name .. ".AddDataProxy: dataProxy.__name expected a string value")

		assert = var_1_10002

		var_1_10002(arg_2_0._proxyList[arg_2_1.__name] == nil, arg_2_0.__name .. ".AddDataProxy: same dataProxy exist")

		arg_2_1._state = arg_2_0

		arg_2_1:ActiveProxy()

		arg_2_0._proxyList[arg_2_1.__name] = arg_2_1

		return arg_2_1
	end
end

function var_0.MVC.Facade.AddMediator(arg_3_0, arg_3_1)
	if arg_3_1.__name ~= nil then
		type = var_2

		if var_2(arg_3_1.__name) ~= "string" then
			assert = var_2

			var_2(false, arg_3_0.__name .. ".AddMediator: mediator.__name expected a string value")
		end

		assert = var_2

		var_2(arg_3_0._mediatorList[arg_3_1.__name] == nil, arg_3_0.__name .. ".AddMediator: same mediator exist")

		arg_3_0._mediatorList[arg_3_1.__name] = arg_3_1
		arg_3_1._state = arg_3_0

		arg_3_1:Initialize()

		return arg_3_1
	end
end

function var_0.MVC.Facade.AddCommand(arg_4_0, arg_4_1)
	if arg_4_1.__name ~= nil then
		type = var_2

		if var_2(arg_4_1.__name) ~= "string" then
			assert = var_2

			var_2(false, arg_4_0.__name .. ".AddCommand: command.__name expected a string value")
		end

		assert = var_2

		var_2(arg_4_0._commandList[arg_4_1.__name] == nil, arg_4_0.__name .. ".AddCommand: same command exist")

		arg_4_0._commandList[arg_4_1.__name] = arg_4_1
		arg_4_1._state = arg_4_0

		arg_4_1:Initialize()

		return arg_4_1
	end
end

function var_0.MVC.Facade.GetProxyByName(arg_5_0, arg_5_1)
	assert = var_1_10002
	type = var_1_10003

	var_1_10002(var_1_10003(arg_5_1) == "string", arg_5_0.__name .. ".GetProxyByName: expect a string value")

	return arg_5_0._proxyList[arg_5_1]
end

function var_0.MVC.Facade.GetMediatorByName(arg_6_0, arg_6_1)
	assert = var_1_10002
	type = var_1_10003

	var_1_10002(var_1_10003(arg_6_1) == "string", arg_6_0.__name .. ".GetMediatorByName: expect a string value")

	return arg_6_0._mediatorList[arg_6_1]
end

function var_0.MVC.Facade.GetCommandByName(arg_7_0, arg_7_1)
	assert = var_1_10002
	type = var_1_10003

	var_1_10002(var_1_10003(arg_7_1) == "string", arg_7_0.__name .. ".GetCommandByName: expect a string value")

	return arg_7_0._commandList[arg_7_1]
end

function var_0.MVC.Facade.RemoveMediator(arg_8_0, arg_8_1)
	type = var_1_10002

	if var_1_10002(arg_8_1) == "string" then
		arg_8_1 = arg_8_0._mediatorList[arg_8_1]
	end

	assert = var_2

	var_2(arg_8_1 ~= nil, arg_8_0.__name .. ".RemoveMediator: try to remove a nil mediator")
	arg_8_1:Dispose()

	arg_8_0._mediatorList[arg_8_1.__name] = nil

	return
end

function var_0.MVC.Facade.RemoveCommand(arg_9_0, arg_9_1)
	type = var_1_10002

	if var_1_10002(arg_9_1) == "string" then
		arg_9_1 = arg_9_0._commandList[arg_9_1]
	end

	assert = var_2

	var_2(arg_9_1 ~= nil, arg_9_0.__name .. ".RemoveCommand: try to remove a nil command")
	arg_9_1:Dispose()

	arg_9_0._commandList[arg_9_1.__name] = nil

	return
end

function var_0.MVC.Facade.RemoveProxy(arg_10_0, arg_10_1)
	type = var_1_10002

	if var_1_10002(arg_10_1) == "string" then
		arg_10_1 = arg_10_0._proxyList[arg_10_1]
	end

	assert = var_2

	var_2(arg_10_1 ~= nil, arg_10_0.__name .. ".RemoveProxy: try to remove a nil proxy")
	arg_10_1:DeactiveProxy()

	arg_10_0._proxyList[arg_10_1.__name] = nil

	return
end

function var_0.MVC.Facade.Initialize(arg_11_0)
	arg_11_0._proxyList = {}
	arg_11_0._commandList = {}
	arg_11_0._mediatorList = {}

	return
end

function var_0.MVC.Facade.Active(arg_12_0)
	if not arg_12_0._isPause then
		return
	end

	arg_12_0._isPause = false

	local var_12_0 = var_0_10001.TimeMgr.GetInstance()

	var_1.ResumeBattleTimer(var_12_0)

	return
end

function var_0.MVC.Facade.Deactive(arg_13_0)
	if arg_13_0._isPause then
		return
	end

	arg_13_0._isPause = true

	local var_13_0 = var_0_10001.TimeMgr.GetInstance()

	var_1.PauseBattleTimer(var_13_0)

	return
end

function var_0.MVC.Facade.ActiveEscape(arg_14_0)
	local var_14_0 = var_0_10001.TimeMgr.GetInstance()

	arg_14_0._escapeAITimer = var_1.AddTimer(var_14_0, "escapeTimer", 0, var_0.Battle.BattleConfig.viewInterval, function()
		local var_15_0 = arg_14_0

		var_0.escapeUpdate(var_15_0)

		return
	end)

	return
end

function var_0.MVC.Facade.DeactiveEscape(arg_16_0)
	local var_16_0 = var_0_10001.TimeMgr.GetInstance()

	var_1.RemoveTimer(var_16_0, arg_16_0._escapeAITimer)

	return
end

function var_0.MVC.Facade.RemoveAllTimer(arg_17_0)
	local var_17_0 = var_0_10001.TimeMgr.GetInstance()

	var_1.RemoveAllBattleTimer(var_17_0)

	arg_17_0._calcTimer = nil
	arg_17_0._AITimer = nil

	return
end

function var_0.MVC.Facade.ResetTimer(arg_18_0)
	local var_18_0 = var_0_10001.TimeMgr.GetInstance()

	var_1.ResetCombatTime(var_18_0)
	var_1:RemoveBattleTimer(arg_18_0._calcTimer)
	var_1:RemoveBattleTimer(arg_18_0._AITimer)

	arg_18_0._calcTimer = var_1:AddBattleTimer("calcTimer", -1, var_0.Battle.BattleConfig.calcInterval, function()
		local var_19_0 = arg_18_0

		var_0.calcUpdate(var_19_0)

		return
	end)

	return
end

function var_0.MVC.Facade.ActiveAutoComponentTimer(arg_20_0)
	local var_20_0 = var_0_10001.TimeMgr.GetInstance()

	arg_20_0._AITimer = var_1.AddBattleTimer(var_20_0, "aiTimer", -1, var_0.Battle.BattleConfig.AIInterval, function()
		local var_21_0 = arg_20_0

		var_0.aiUpdate(var_21_0)

		return
	end)

	return
end

function var_0.MVC.Facade.calcUpdate(arg_22_0)
	local var_22_0 = var_0_10001.TimeMgr.GetInstance()
	local var_22_1 = var_1.GetCombatTime(var_22_0)

	pairs = var_22_0

	for iter_22_0, iter_22_1 in var_22_0(arg_22_0._proxyList) do
		iter_22_1:Update(var_22_1)
	end

	pairs = var_2

	for iter_22_2, iter_22_3 in var_2(arg_22_0._commandList) do
		iter_22_3:Update(var_22_1)
	end

	return
end

function var_0.MVC.Facade.aiUpdate(arg_23_0)
	local var_23_0 = arg_23_0:GetProxyByName(var_0.Battle.BattleDataProxy.__name)
	local var_23_1 = var_1.UpdateAutoComponent
	local var_23_2 = var_0_10001.TimeMgr.GetInstance()

	var_23_1(var_23_0, var_4.GetCombatTime(var_23_2))

	return
end

function var_0.MVC.Facade.escapeUpdate(arg_24_0)
	local var_24_0 = arg_24_0:GetProxyByName(var_0.Battle.BattleDataProxy.__name)
	local var_24_1 = var_0_10001.TimeMgr.GetInstance()
	local var_24_2 = var_2.GetCombatTime(var_24_1)

	var_24_0:UpdateEscapeOnly(var_24_2)

	local var_24_3 = arg_24_0:GetMediatorByName(var_0.Battle.BattleSceneMediator.__name)

	var_3.UpdateEscapeOnly(var_24_3, var_24_2)

	return
end

return
