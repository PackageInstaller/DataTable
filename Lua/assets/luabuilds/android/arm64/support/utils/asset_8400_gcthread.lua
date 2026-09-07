GCThread = singletonClass("GCThread")

local var_0_0 = GCThread

GCThread.R1024 = 0.00097656

function GCThread:Ctor()
	self.step = 1
	self.gctick = 0
	self.gccost = 0
	self.running = false
	self.gcHandle = UpdateBeat:CreateListener(self.GCStep, self)
	self.checkHandle = UpdateBeat:CreateListener(self.WatchStep, self)

	return
end

function GCThread:GC(arg_2_1)
	self.needUnityGC = true

	self:LuaGC(arg_2_1)

	return
end

function GCThread:LuaGC(arg_3_1)
	if arg_3_1 then
		collectgarbage("collect")
		self:GCFinal()
	elseif not self.running then
		self.running = true

		self:CalcStep()

		self.gctick = 0
		self.gccost = 0

		UpdateBeat:AddListener(self.gcHandle)
	end

	return
end

function GCThread:GCFinal()
	self.running = false

	UpdateBeat:RemoveListener(self.gcHandle)

	if self.needUnityGC then
		self.needUnityGC = false

		Canvas.ForceUpdateCanvases()
		PoolMgr.GetInstance():DestroyAllSprite()
		ResourceMgr.Inst:ResUnloadAsync()
		LuaHelper.UnityGC()
	end

	if IsUnityEditor then
		print("lua mem: " .. collectgarbage("count") * var_0_0.R1024 .. "MB")
	end

	return
end

function GCThread:GCStep()
	if not self.running then
		-- block empty
	elseif collectgarbage("step", self.step) then
		self:GCFinal()
	else
		local var_5_0 = os.clock() * 1000 - os.clock() * 1000

		self.gccost = self.gccost <= 0 and var_5_0 or self.gccost
		self.gccost = (self.gccost + var_5_0) * 0.5
		self.gctick = self.gctick + 1

		if self.gctick > 300 and self.gctick % 30 == 0 then
			self:CalcStep()
		end
	end

	return
end

function GCThread:CalcStep()
	self.step = math.max(self.gctick - 60, 30) / 30 * 500 * math.max(1 - math.max(self.gccost - 3, 0) * 0.1, 0.1)

	return
end

function GCThread:StartWatch(arg_7_1)
	originalPrint("overhead: start watch")

	local var_7_0 = collectgarbage("count") * var_0_0.R1024

	if arg_7_1 < var_7_0 + 12 then
		arg_7_1 = var_7_0 + 12
	end

	self.watcher = Timer.New(function()
		if not self.running then
			local var_8_0 = collectgarbage("count") * var_0_0.R1024

			if var_8_0 > arg_7_1 then
				originalPrint("overhead: start gc " .. var_8_0 .. "MB")

				self.running = true

				self:CalcStep()

				self.gctick = 0
				self.gccost = 0

				UpdateBeat:AddListener(self.checkHandle)
			end
		end

		return
	end, 5, -1)

	self.watcher:Start()

	return
end

function GCThread:StopWatch()
	originalPrint("overhead: stop watch")

	if self.watcher then
		self.watcher:Stop()

		self.watcher = nil
	end

	return
end

function GCThread:WatchStep()
	if collectgarbage("step", self.step) then
		originalPrint("overhead: gc complete")

		if IsUnityEditor then
			print("lua mem: " .. collectgarbage("count") * var_0_0.R1024 .. "MB")
		end

		self.running = false

		UpdateBeat:RemoveListener(self.checkHandle)
	else
		local var_10_0 = os.clock() * 1000 - os.clock() * 1000

		self.gccost = self.gccost <= 0 and var_10_0 or self.gccost
		self.gccost = (self.gccost + var_10_0) * 0.5
		self.gctick = self.gctick + 1

		if self.gctick > 300 and self.gctick % 30 == 0 then
			self:CalcStep()
		end
	end

	return
end

return GCThread
