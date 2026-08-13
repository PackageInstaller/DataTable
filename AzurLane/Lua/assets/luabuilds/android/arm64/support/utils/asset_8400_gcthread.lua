singletonClass = var_0_10000

local var_0_0 = var_0_10000("GCThread")

GCThread = GCThread
var_0.R1024 = 0.00097656

function var_0.Ctor(arg_1_0)
	arg_1_0.step = 1
	arg_1_0.gctick = 0
	arg_1_0.gccost = 0
	arg_1_0.running = false
	UpdateBeat = var_1
	arg_1_0.gcHandle = var_1:CreateListener(arg_1_0.GCStep, arg_1_0)
	UpdateBeat = var_1
	arg_1_0.checkHandle = var_1:CreateListener(arg_1_0.WatchStep, arg_1_0)

	return
end

function var_0.GC(arg_2_0, arg_2_1)
	arg_2_0.needUnityGC = true

	arg_2_0:LuaGC(arg_2_1)

	return
end

function var_0.LuaGC(arg_3_0, arg_3_1)
	if arg_3_1 then
		collectgarbage = var_1_10002

		var_1_10002("collect")
		arg_3_0:GCFinal()
	elseif not arg_3_0.running then
		arg_3_0.running = true

		arg_3_0:CalcStep()

		arg_3_0.gctick = 0
		arg_3_0.gccost = 0
		UpdateBeat = var_2

		var_2:AddListener(arg_3_0.gcHandle)
	end

	return
end

function var_0.GCFinal(arg_4_0)
	arg_4_0.running = false
	UpdateBeat = var_1

	var_1:RemoveListener(arg_4_0.gcHandle)

	if arg_4_0.needUnityGC then
		arg_4_0.needUnityGC = false
		Canvas = var_1

		var_1.ForceUpdateCanvases()

		PoolMgr = var_1

		local var_4_0 = var_1.GetInstance()

		var_1.DestroyAllSprite(var_4_0)

		ResourceMgr = var_1

		local var_4_1 = var_1.Inst

		var_1.ResUnloadAsync(var_4_1)

		LuaHelper = var_1

		var_1.UnityGC()
	end

	IsUnityEditor = var_1

	if var_1 then
		print = var_1

		local var_4_2 = "lua mem: "

		collectgarbage = var_4

		var_1(var_4_2 .. var_4("count") * var_0.R1024 .. "MB")
	end

	return
end

function var_0.GCStep(arg_5_0)
	os = var_1_10001

	local var_5_0 = var_1_10001.clock()

	if not arg_5_0.running then
		-- block empty
	else
		collectgarbage = var_2

		if var_2("step", arg_5_0.step) then
			arg_5_0:GCFinal()
		else
			os = var_2

			local var_5_1 = var_2.clock() * 1000 - var_5_0 * 1000

			arg_5_0.gccost = arg_5_0.gccost <= 0 and var_5_1 or arg_5_0.gccost
			arg_5_0.gccost = (arg_5_0.gccost + var_5_1) * 0.5
			arg_5_0.gctick = arg_5_0.gctick + 1

			if arg_5_0.gctick > 300 and arg_5_0.gctick % 30 == 0 then
				arg_5_0:CalcStep()
			end
		end
	end

	return
end

function var_0.CalcStep(arg_6_0)
	math = var_1_10001

	local var_6_0 = var_1_10001.max(arg_6_0.gctick - 60, 30) / 30 * 500

	math = var_1_10002

	local var_6_1 = var_1_10002.max

	math = var_4
	arg_6_0.step = var_6_0 * var_6_1(1 - var_4.max(arg_6_0.gccost - 3, 0) * 0.1, 0.1)

	return
end

function var_0.StartWatch(arg_7_0, arg_7_1)
	originalPrint = var_1_10002

	var_1_10002("overhead: start watch")

	collectgarbage = var_1_10002

	if arg_7_1 < var_1_10002("count") * var_0.R1024 + 12 then
		arg_7_1 = var_2 + 12
	end

	Timer = var_3
	arg_7_0.watcher = var_3.New(function()
		if not arg_7_0.running then
			collectgarbage = var_0

			local var_8_0 = var_0("count") * var_0.R1024

			if arg_7_1 < var_8_0 then
				originalPrint = var_1

				var_1("overhead: start gc " .. var_8_0 .. "MB")

				arg_7_0.running = true

				local var_8_1 = arg_7_0

				var_1.CalcStep(var_8_1)

				arg_7_0.gctick = 0

				local var_8_2 = arg_7_0

				var_8_2.gccost = 0
				UpdateBeat = var_8_2

				var_8_2:AddListener(arg_7_0.checkHandle)
			end
		end

		return
	end, 5, -1)

	local var_7_0 = arg_7_0.watcher

	var_3.Start(var_7_0)

	return
end

function var_0.StopWatch(arg_9_0)
	originalPrint = var_1_10001

	var_1_10001("overhead: stop watch")

	if arg_9_0.watcher then
		local var_9_0 = arg_9_0.watcher

		var_1.Stop(var_9_0)

		arg_9_0.watcher = nil
	end

	return
end

function var_0.WatchStep(arg_10_0)
	os = var_1_10001

	local var_10_0 = var_1_10001.clock()

	collectgarbage = var_1_10002

	if var_1_10002("step", arg_10_0.step) then
		originalPrint = var_2

		var_2("overhead: gc complete")

		IsUnityEditor = var_2

		if var_2 then
			print = var_2

			local var_10_1 = "lua mem: "

			collectgarbage = var_5

			var_2(var_10_1 .. var_5("count") * var_0.R1024 .. "MB")
		end

		arg_10_0.running = false
		UpdateBeat = var_2

		var_2:RemoveListener(arg_10_0.checkHandle)
	else
		os = var_2

		local var_10_2 = var_2.clock() * 1000 - var_10_0 * 1000

		arg_10_0.gccost = arg_10_0.gccost <= 0 and var_10_2 or arg_10_0.gccost
		arg_10_0.gccost = (arg_10_0.gccost + var_10_2) * 0.5
		arg_10_0.gctick = arg_10_0.gctick + 1

		if arg_10_0.gctick > 300 and arg_10_0.gctick % 30 == 0 then
			arg_10_0:CalcStep()
		end
	end

	return
end

return var_0
