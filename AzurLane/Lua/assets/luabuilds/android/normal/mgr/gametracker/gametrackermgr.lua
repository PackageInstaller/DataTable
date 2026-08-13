pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.GameTrackerMgr = var_0_10001("GameTrackerMgr")
pg = var_0

local var_0_1 = var_0.GameTrackerMgr

import = var_1

local var_0_2 = var_1("Mgr.GameTracker.GameTrackerBuilder")
local var_0_3 = GameTrackerBuilder
local var_0_4 = 300
local var_0_5 = 20
local var_0_6 = "GameTrackerMgr"
local var_0_7 = "^"

function var_0_1.Init(arg_1_0, arg_1_1)
	arg_1_0.readBuffer = {}
	arg_1_0.writeBuffer = {}
	arg_1_0.duration = var_0_4
	arg_1_0.passed = 0

	arg_1_0:SetUp()
	arg_1_1()

	return
end

function var_0_1.Record(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	table = var_1_10002

	var_1_10002.insert(arg_2_0.readBuffer, arg_2_1)
	arg_2_0:Cache()

	if #arg_2_0.readBuffer >= var_0_5 then
		arg_2_0:Synchronization()
	end

	return
end

function var_0_1.Synchronization(arg_3_0)
	arg_3_0.passed = 0

	arg_3_0:Send()

	return
end

function var_0_1.Dispose(arg_4_0)
	if arg_4_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_4_0.handle)
	end

	arg_4_0.readBuffer = {}
	arg_4_0.writeBuffer = {}
	arg_4_0.passed = 0

	return
end

function var_0_1.SetUp(arg_5_0)
	if not arg_5_0.handle then
		UpdateBeat = var_1
		arg_5_0.handle = var_1:CreateListener(arg_5_0.Update, arg_5_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_5_0.handle)

	return
end

function var_0_1.Update(arg_6_0)
	local var_6_0 = arg_6_0.passed

	Time = var_1_10002
	arg_6_0.passed = var_6_0 + var_1_10002.deltaTime

	if arg_6_0.passed >= arg_6_0.duration then
		arg_6_0.passed = 0

		arg_6_0:Synchronization()
	end

	return
end

function var_0_1.Send(arg_7_0)
	if #arg_7_0.readBuffer <= 0 then
		return
	end

	pg = var_1

	local var_7_0 = var_1.ConnectionMgr.GetInstance()

	if not var_1.isConnected(var_7_0) then
		return
	end

	arg_7_0:FillBuffer()
	arg_7_0:ClearCache()

	pg = var_1

	local var_7_1 = var_1.m02
	local var_7_2 = var_1.sendNotification

	GAME = var_1_10003

	var_7_2(var_7_1, var_1_10003.GAME_TRACK, {
		infos = arg_7_0.writeBuffer
	})

	return
end

function var_0_1.FillBuffer(arg_8_0)
	arg_8_0.writeBuffer = {}
	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0.readBuffer) do
		table = var_1_10006

		var_1_10006.insert(arg_8_0.writeBuffer, iter_8_1)
	end

	arg_8_0.readBuffer = {}

	return
end

function var_0_1.Cache(arg_9_0)
	local var_9_0

	if not arg_9_0.readBuffer then
		var_9_0 = {}
	end

	if #var_9_0 <= 0 then
		return
	end

	_ = var_2

	local var_9_1 = var_2.map(var_9_0, function(arg_10_0)
		GameTrackerBuilder = var_2_10001

		return var_2_10001.SerializedItem(arg_10_0)
	end)

	table = var_3

	local var_9_2 = var_3.concat(var_9_1, var_0_7)

	getProxy = var_4
	PlayerProxy = var_5

	if not var_4(var_5) then
		return
	end

	getProxy = var_4
	PlayerProxy = var_5

	local var_9_3 = var_4(var_5)

	if not var_4.getRawData(var_9_3) then
		return
	end

	getProxy = var_4
	PlayerProxy = var_9_3

	local var_9_4 = var_4(var_9_3)
	local var_9_5 = var_4.getRawData(var_9_4).id

	PlayerPrefs = var_9_4

	var_9_4.SetString(var_0_6 .. var_9_5, var_9_2)

	PlayerPrefs = var_5

	var_5.Save()

	return
end

function var_0_1.ClearCache(arg_11_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)
	local var_11_1 = var_1.getRawData(var_11_0).id

	PlayerPrefs = var_11_0

	var_11_0.SetString(var_0_6 .. var_11_1, "")

	PlayerPrefs = var_2

	var_2.Save()

	return
end

function var_0_1.FetchCache(arg_12_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)
	local var_12_1 = var_1.getRawData(var_12_0).id

	PlayerPrefs = var_12_0

	if not var_12_0.GetString(var_0_6 .. var_12_1, "") or var_2 == "" then
		return
	end

	arg_12_0.readBuffer = {}
	string = var_3

	local var_12_2 = var_3.split(var_2, var_0_7)

	_ = var_4

	local var_12_3 = var_4.map(var_12_2, function(arg_13_0)
		GameTrackerBuilder = var_2_10001

		return var_2_10001.DeSerializedItem(arg_13_0)
	end)

	ipairs = var_5

	for iter_12_0, iter_12_1 in var_5(var_12_3) do
		if iter_12_1 then
			table = var_1_10010

			var_1_10010.insert(arg_12_0.readBuffer, 1, iter_12_1)
		end
	end

	return
end

return
