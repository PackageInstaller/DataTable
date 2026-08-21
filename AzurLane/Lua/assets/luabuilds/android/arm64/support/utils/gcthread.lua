GCThread = singletonClass("GCThread")

local var_0_0 = GCThread

GCThread.R1024 = 0.00097656

function GCThread.Ctor(arg_1_0)
	arg_1_0.step = 1
	arg_1_0.gctick = 0
	arg_1_0.gccost = 0
	arg_1_0.running = false
	arg_1_0.gcHandle = UpdateBeat:CreateListener(arg_1_0.GCStep, arg_1_0)
	arg_1_0.checkHandle = UpdateBeat:CreateListener(arg_1_0.WatchStep, arg_1_0)

	return
end

function GCThread.GC(arg_2_0, arg_2_1)
	arg_2_0.needUnityGC = true

	arg_2_0:LuaGC(arg_2_1)

	return
end

function GCThread.LuaGC(arg_3_0, arg_3_1)
	if arg_3_1 then
		collectgarbage("collect")
		arg_3_0:GCFinal()
	elseif not arg_3_0.running then
		arg_3_0.running = true

		arg_3_0:CalcStep()

		arg_3_0.gctick = 0
		arg_3_0.gccost = 0

		UpdateBeat:AddListener(arg_3_0.gcHandle)
	end

	return
end

function GCThread.GCFinal(arg_4_0)
	arg_4_0.running = false

	UpdateBeat:RemoveListener(arg_4_0.gcHandle)

	if arg_4_0.needUnityGC then
		arg_4_0.needUnityGC = false

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

function GCThread.GCStep(arg_5_0)
	if not arg_5_0.running then
		-- block empty
	elseif collectgarbage("step", arg_5_0.step) then
		arg_5_0:GCFinal()
	else
		local var_5_0 = os.clock() * 1000 - os.clock() * 1000

		arg_5_0.gccost = arg_5_0.gccost <= 0 and var_5_0 or arg_5_0.gccost
		arg_5_0.gccost = (arg_5_0.gccost + var_5_0) * 0.5
		arg_5_0.gctick = arg_5_0.gctick + 1

		if arg_5_0.gctick > 300 and arg_5_0.gctick % 30 == 0 then
			arg_5_0:CalcStep()
		end
	end

	return
end

function GCThread.CalcStep(arg_6_0)
	arg_6_0.step = math.max(arg_6_0.gctick - 60, 30) / 30 * 500 * math.max(1 - math.max(arg_6_0.gccost - 3, 0) * 0.1, 0.1)

	return
end

function GCThread.StartWatch(arg_7_0, arg_7_1)
	originalPrint("overhead: start watch")

	local var_7_0 = collectgarbage("count") * var_0_0.R1024

	if arg_7_1 < var_7_0 + 12 then
		arg_7_1 = var_7_0 + 12
	end

	arg_7_0.watcher = Timer.New(function()
		if not arg_7_0.running then
			local var_8_0 = collectgarbage("count") * var_0_0.R1024

			if var_8_0 > arg_7_1 then
				originalPrint("overhead: start gc " .. var_8_0 .. "MB")

				arg_7_0.running = true

				arg_7_0:CalcStep()

				arg_7_0.gctick = 0
				arg_7_0.gccost = 0

				UpdateBeat:AddListener(arg_7_0.checkHandle)
			end
		end

		return
	end, 5, -1)

	arg_7_0.watcher:Start()

	return
end

function GCThread.StopWatch(arg_9_0)
	originalPrint("overhead: stop watch")

	if arg_9_0.watcher then
		arg_9_0.watcher:Stop()

		arg_9_0.watcher = nil
	end

	return
end

function GCThread.WatchStep(arg_10_0)
	if collectgarbage("step", arg_10_0.step) then
		originalPrint("overhead: gc complete")

		if IsUnityEditor then
			print("lua mem: " .. collectgarbage("count") * var_0_0.R1024 .. "MB")
		end

		arg_10_0.running = false

		UpdateBeat:RemoveListener(arg_10_0.checkHandle)
	else
		local var_10_0 = os.clock() * 1000 - os.clock() * 1000

		arg_10_0.gccost = arg_10_0.gccost <= 0 and var_10_0 or arg_10_0.gccost
		arg_10_0.gccost = (arg_10_0.gccost + var_10_0) * 0.5
		arg_10_0.gctick = arg_10_0.gctick + 1

		if arg_10_0.gctick > 300 and arg_10_0.gctick % 30 == 0 then
			arg_10_0:CalcStep()
		end
	end

	return
end

return GCThread
