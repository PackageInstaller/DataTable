pg = pg or {}
pg.GameTrackerMgr = singletonClass("GameTrackerMgr")
GameTrackerBuilder = import("Mgr.GameTracker.GameTrackerBuilder")

local var_0_0 = 300
local var_0_1 = 20
local var_0_2 = "GameTrackerMgr"
local var_0_3 = "^"

function pg.GameTrackerMgr:Init(arg_1_1)
	self.readBuffer = {}
	self.writeBuffer = {}
	self.duration = var_0_0
	self.passed = 0

	self:SetUp()
	arg_1_1()

	return
end

function pg.GameTrackerMgr:Record(arg_2_1)
	if not arg_2_1 then
		return
	end

	table.insert(self.readBuffer, arg_2_1)
	self:Cache()

	if #self.readBuffer >= var_0_1 then
		self:Synchronization()
	end

	return
end

function pg.GameTrackerMgr:Synchronization()
	self.passed = 0

	self:Send()

	return
end

function pg.GameTrackerMgr:Dispose()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	self.readBuffer = {}
	self.writeBuffer = {}
	self.passed = 0

	return
end

function pg.GameTrackerMgr:SetUp()
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function pg.GameTrackerMgr:Update()
	self.passed = self.passed + Time.deltaTime

	if self.passed >= self.duration then
		self.passed = 0

		self:Synchronization()
	end

	return
end

function pg.GameTrackerMgr:Send()
	if #self.readBuffer <= 0 then
		return
	end

	if not pg.ConnectionMgr.GetInstance():isConnected() then
		return
	end

	self:FillBuffer()
	self:ClearCache()
	pg.m02:sendNotification(GAME.GAME_TRACK, {
		infos = self.writeBuffer
	})

	return
end

function pg.GameTrackerMgr:FillBuffer()
	self.writeBuffer = {}

	for iter_8_0, iter_8_1 in ipairs(self.readBuffer) do
		table.insert(self.writeBuffer, iter_8_1)
	end

	self.readBuffer = {}

	return
end

function pg.GameTrackerMgr:Cache()
	local var_9_0 = self.readBuffer or {}

	if #var_9_0 <= 0 then
		return
	end

	local var_9_1 = table.concat(_.map(var_9_0, function(arg_10_0)
		return GameTrackerBuilder.SerializedItem(arg_10_0)
	end), var_0_3)

	if not getProxy(PlayerProxy) then
		return
	end

	if not getProxy(PlayerProxy):getRawData() then
		return
	end

	PlayerPrefs.SetString(var_0_2 .. getProxy(PlayerProxy):getRawData().id, var_9_1)
	PlayerPrefs.Save()

	return
end

function pg.GameTrackerMgr.ClearCache(arg_11_0)
	PlayerPrefs.SetString(var_0_2 .. getProxy(PlayerProxy):getRawData().id, "")
	PlayerPrefs.Save()

	return
end

function pg.GameTrackerMgr:FetchCache()
	local var_12_0 = PlayerPrefs.GetString(var_0_2 .. getProxy(PlayerProxy):getRawData().id, "")

	if not var_12_0 or var_12_0 == "" then
		return
	end

	self.readBuffer = {}

	for iter_12_0, iter_12_1 in ipairs((_.map(string.split(var_12_0, var_0_3), function(arg_13_0)
		return GameTrackerBuilder.DeSerializedItem(arg_13_0)
	end))) do
		if iter_12_1 then
			table.insert(self.readBuffer, 1, iter_12_1)
		end
	end

	return
end

return
