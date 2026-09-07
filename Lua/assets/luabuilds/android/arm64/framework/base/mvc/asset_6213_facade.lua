ys = ys or {}

local var_0_0 = ys
local var_0_1 = pg

ys.MVC = ys.MVC or {}
ys.MVC.Facade = singletonClass("MVC.Facade")
ys.MVC.Facade.__name = "MVC.Facade"

function ys.MVC.Facade:Ctor()
	self:Initialize()

	return
end

function ys.MVC.Facade:AddDataProxy(arg_2_1)
	assert(arg_2_1.__name ~= nil and type(arg_2_1.__name) == "string", self.__name .. ".AddDataProxy: dataProxy.__name expected a string value")
	assert(self._proxyList[arg_2_1.__name] == nil, self.__name .. ".AddDataProxy: same dataProxy exist")

	arg_2_1._state = self

	arg_2_1:ActiveProxy()

	self._proxyList[arg_2_1.__name] = arg_2_1

	return arg_2_1
end

function ys.MVC.Facade:AddMediator(arg_3_1)
	if arg_3_1.__name == nil or type(arg_3_1.__name) ~= "string" then
		assert(false, self.__name .. ".AddMediator: mediator.__name expected a string value")
	end

	assert(self._mediatorList[arg_3_1.__name] == nil, self.__name .. ".AddMediator: same mediator exist")

	self._mediatorList[arg_3_1.__name] = arg_3_1
	arg_3_1._state = self

	arg_3_1:Initialize()

	return arg_3_1
end

function ys.MVC.Facade:AddCommand(arg_4_1)
	if arg_4_1.__name == nil or type(arg_4_1.__name) ~= "string" then
		assert(false, self.__name .. ".AddCommand: command.__name expected a string value")
	end

	assert(self._commandList[arg_4_1.__name] == nil, self.__name .. ".AddCommand: same command exist")

	self._commandList[arg_4_1.__name] = arg_4_1
	arg_4_1._state = self

	arg_4_1:Initialize()

	return arg_4_1
end

function ys.MVC.Facade:GetProxyByName(arg_5_1)
	assert(type(arg_5_1) == "string", self.__name .. ".GetProxyByName: expect a string value")

	return self._proxyList[arg_5_1]
end

function ys.MVC.Facade:GetMediatorByName(arg_6_1)
	assert(type(arg_6_1) == "string", self.__name .. ".GetMediatorByName: expect a string value")

	return self._mediatorList[arg_6_1]
end

function ys.MVC.Facade:GetCommandByName(arg_7_1)
	assert(type(arg_7_1) == "string", self.__name .. ".GetCommandByName: expect a string value")

	return self._commandList[arg_7_1]
end

function ys.MVC.Facade:RemoveMediator(arg_8_1)
	if type(arg_8_1) == "string" then
		arg_8_1 = self._mediatorList[arg_8_1]
	end

	assert(arg_8_1 ~= nil, self.__name .. ".RemoveMediator: try to remove a nil mediator")
	arg_8_1:Dispose()

	self._mediatorList[arg_8_1.__name] = nil

	return
end

function ys.MVC.Facade:RemoveCommand(arg_9_1)
	if type(arg_9_1) == "string" then
		arg_9_1 = self._commandList[arg_9_1]
	end

	assert(arg_9_1 ~= nil, self.__name .. ".RemoveCommand: try to remove a nil command")
	arg_9_1:Dispose()

	self._commandList[arg_9_1.__name] = nil

	return
end

function ys.MVC.Facade:RemoveProxy(arg_10_1)
	if type(arg_10_1) == "string" then
		arg_10_1 = self._proxyList[arg_10_1]
	end

	assert(arg_10_1 ~= nil, self.__name .. ".RemoveProxy: try to remove a nil proxy")
	arg_10_1:DeactiveProxy()

	self._proxyList[arg_10_1.__name] = nil

	return
end

function ys.MVC.Facade.Initialize(arg_11_0)
	arg_11_0._proxyList = {}
	arg_11_0._commandList = {}
	arg_11_0._mediatorList = {}

	return
end

function ys.MVC.Facade:Active()
	if not self._isPause then
		return
	end

	self._isPause = false

	var_0_1.TimeMgr.GetInstance():ResumeBattleTimer()

	return
end

function ys.MVC.Facade:Deactive()
	if self._isPause then
		return
	end

	self._isPause = true

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

function ys.MVC.Facade:DeactiveEscape()
	var_0_1.TimeMgr.GetInstance():RemoveTimer(self._escapeAITimer)

	return
end

function ys.MVC.Facade.RemoveAllTimer(arg_17_0)
	var_0_1.TimeMgr.GetInstance():RemoveAllBattleTimer()

	arg_17_0._calcTimer = nil
	arg_17_0._AITimer = nil

	return
end

function ys.MVC.Facade:ResetTimer()
	local var_18_0 = var_0_1.TimeMgr.GetInstance()

	var_18_0:ResetCombatTime()
	var_18_0:RemoveBattleTimer(self._calcTimer)
	var_18_0:RemoveBattleTimer(self._AITimer)

	self._calcTimer = var_18_0:AddBattleTimer("calcTimer", -1, var_0_0.Battle.BattleConfig.calcInterval, function()
		self:calcUpdate()

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

function ys.MVC.Facade:calcUpdate()
	local var_22_0 = var_0_1.TimeMgr.GetInstance():GetCombatTime()

	for iter_22_0, iter_22_1 in pairs(self._proxyList) do
		iter_22_1:Update(var_22_0)
	end

	for iter_22_2, iter_22_3 in pairs(self._commandList) do
		iter_22_3:Update(var_22_0)
	end

	return
end

function ys.MVC.Facade:aiUpdate()
	self:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name):UpdateAutoComponent(var_0_1.TimeMgr.GetInstance():GetCombatTime())

	return
end

function ys.MVC.Facade:escapeUpdate()
	local var_24_0 = var_0_1.TimeMgr.GetInstance():GetCombatTime()

	self:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name):UpdateEscapeOnly(var_24_0)
	self:GetMediatorByName(var_0_0.Battle.BattleSceneMediator.__name):UpdateEscapeOnly(var_24_0)

	return
end

return
