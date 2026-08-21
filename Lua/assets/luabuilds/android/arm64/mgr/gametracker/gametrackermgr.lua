pg = pg or {}
pg.GameTrackerMgr = singletonClass("GameTrackerMgr")
GameTrackerBuilder = import("Mgr.GameTracker.GameTrackerBuilder")

local var_0_0 = 300
local var_0_1 = 20
local var_0_2 = "GameTrackerMgr"
local var_0_3 = "^"

function pg.GameTrackerMgr.Init(arg_1_0, arg_1_1)
	arg_1_0.readBuffer = {}
	arg_1_0.writeBuffer = {}
	arg_1_0.duration = var_0_0
	arg_1_0.passed = 0

	arg_1_0:SetUp()
	arg_1_1()

	return
end

function pg.GameTrackerMgr.Record(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	table.insert(arg_2_0.readBuffer, arg_2_1)
	arg_2_0:Cache()

	if #arg_2_0.readBuffer >= var_0_1 then
		arg_2_0:Synchronization()
	end

	return
end

function pg.GameTrackerMgr.Synchronization(arg_3_0)
	arg_3_0.passed = 0

	arg_3_0:Send()

	return
end

function pg.GameTrackerMgr.Dispose(arg_4_0)
	if arg_4_0.handle then
		UpdateBeat:RemoveListener(arg_4_0.handle)
	end

	arg_4_0.readBuffer = {}
	arg_4_0.writeBuffer = {}
	arg_4_0.passed = 0

	return
end

function pg.GameTrackerMgr.SetUp(arg_5_0)
	arg_5_0.handle = arg_5_0.handle or UpdateBeat:CreateListener(arg_5_0.Update, arg_5_0)

	UpdateBeat:AddListener(arg_5_0.handle)

	return
end

function pg.GameTrackerMgr.Update(arg_6_0)
	arg_6_0.passed = arg_6_0.passed + Time.deltaTime

	if arg_6_0.passed >= arg_6_0.duration then
		arg_6_0.passed = 0

		arg_6_0:Synchronization()
	end

	return
end

function pg.GameTrackerMgr.Send(arg_7_0)
	if #arg_7_0.readBuffer <= 0 then
		return
	end

	local var_7_0 = pg.ConnectionMgr.GetInstance()

	if not var_7_0:isConnected() then
		return
	end

	arg_7_0:FillBuffer()
	arg_7_0:ClearCache()
	pg.m02:sendNotification(GAME.GAME_TRACK, {
		infos = arg_7_0.writeBuffer
	})

	return
end

function pg.GameTrackerMgr.FillBuffer(arg_8_0)
	arg_8_0.writeBuffer = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.readBuffer) do
		table.insert(arg_8_0.writeBuffer, iter_8_1)
	end

	arg_8_0.readBuffer = {}

	return
end

function pg.GameTrackerMgr.Cache(arg_9_0)
	local var_9_0 = arg_9_0.readBuffer or {}

	if #var_9_0 <= 0 then
		return
	end

	local var_9_1 = table.concat(_.map(var_9_0, function(arg_10_0)
		return GameTrackerBuilder.SerializedItem(arg_10_0)
	end), var_0_3)

	if not getProxy(PlayerProxy) then
		return
	end

	local var_9_2 = getProxy(PlayerProxy)

	if not var_9_2:getRawData() then
		return
	end

	local var_9_3 = getProxy(PlayerProxy)

	PlayerPrefs.SetString(var_0_2 .. var_9_3:getRawData().id, var_9_1)
	PlayerPrefs.Save()

	return
end

function pg.GameTrackerMgr.ClearCache(arg_11_0)
	PlayerPrefs.SetString(var_0_2 .. getProxy(PlayerProxy):getRawData().id, "")
	PlayerPrefs.Save()

	return
end

function pg.GameTrackerMgr.FetchCache(arg_12_0)
	local var_12_0 = PlayerPrefs.GetString(var_0_2 .. getProxy(PlayerProxy):getRawData().id, "")

	if not var_12_0 or var_12_0 == "" then
		return
	end

	arg_12_0.readBuffer = {}

	for iter_12_0, iter_12_1 in ipairs((_.map(string.split(var_12_0, var_0_3), function(arg_13_0)
		return GameTrackerBuilder.DeSerializedItem(arg_13_0)
	end))) do
		if iter_12_1 then
			table.insert(arg_12_0.readBuffer, 1, iter_12_1)
		end
	end

	return
end

return
