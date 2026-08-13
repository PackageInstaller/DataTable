class = var_0_10000

local var_0_0 = var_0_10000("IslandWeatherSystem")
local var_0_1 = 60
local var_0_2 = 240
local var_0_3 = 0

function var_0_0.Ctor(arg_1_0, arg_1_1)
	warning = var_1_10002
	tostring = var_1_10003

	var_1_10002(var_1_10003(arg_1_0) .. "weatehr init")

	arg_1_0.view = arg_1_1
	GameObject = var_1_10002
	arg_1_0.TOD = var_1_10002.Find("/[MainBlock]/[Climat]/day/[Settings]/TOD_Timeline")
	arg_1_0._inited = false

	if arg_1_0.TOD then
		setActive = var_2

		var_2(arg_1_0.TOD, true)
	end

	if not arg_1_0.TOD then
		warning = var_2

		var_2("TOD_Timeline不存在 如果是室内场景 忽略这条警告")

		return
	end

	local var_1_0 = arg_1_0.TOD
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	UnityEngine = var_1_10005
	arg_1_0.director = var_1_1(var_1_0, var_4(var_1_10005.Playables.PlayableDirector))
	GetOrAddComponent = var_2
	arg_1_0.speedComp = var_2(arg_1_0.TOD, "TimelineSpeed")
	GetOrAddComponent = var_2
	arg_1_0.settingComp = var_2(arg_1_0.TOD, "TODSettings")

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.island_set.island_time_rate.key_value_int

	assert = var_1_10002

	var_1_10002(var_2_0 and var_2_0 > 0, "Invalid island time rate")

	math = var_1_10002
	arg_2_0.gameDaySec = var_1_10002.floor(var_0_3 / var_2_0)

	local var_2_1 = arg_2_0.director

	var_2.Stop(var_2_1)

	arg_2_0.director.playOnAwake = false

	local var_2_2 = arg_2_0.director

	UnityEngine = var_3
	var_2_2.extrapolationMode = var_3.Playables.DirectorWrapMode.Loop
	arg_2_0._inited = true

	if arg_2_0.settingComp.pauseOnEnterTime then
		arg_2_0:PauseOnEnterTime()
	else
		arg_2_0:Play()
	end

	return
end

function var_0_0.Play(arg_3_0)
	if not arg_3_0._inited then
		return
	end

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.GetFrame(var_3_0)

	IsNil = var_3_0

	if var_3_0(arg_3_0.director) then
		return
	end

	arg_3_0.director.time = var_3_1 / var_0_1

	local var_3_2 = arg_3_0.director

	var_2.Play(var_3_2)

	local var_3_3 = arg_3_0.speedComp

	var_2.SetTimelineSpeed(var_3_3, var_0_2 / var_0_1 / arg_3_0.gameDaySec)

	return
end

function var_0_0.PauseOnEnterTime(arg_4_0)
	if not arg_4_0._inited then
		return
	end

	local var_4_0 = arg_4_0:GetFrame()

	arg_4_0.director.time = var_4_0 / var_0_1

	local var_4_1 = arg_4_0.director

	var_2.Play(var_4_1)

	local var_4_2 = arg_4_0.speedComp

	var_2.SetTimelineSpeed(var_4_2, 0)

	return
end

function var_0_0.GetFrame(arg_5_0)
	if not arg_5_0._inited then
		return 0
	end

	pg = var_1

	local var_5_0 = var_1.TimeMgr.GetInstance()
	local var_5_1 = (var_1.GetServerTime(var_5_0) - var_1._sAnchorTime) % var_0_3 % arg_5_0.gameDaySec

	math = var_1_10004

	return (var_1_10004.floor(var_5_1 / arg_5_0.gameDaySec * var_0_2))
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
