local var_0_0 = class("IslandWeatherSystem")
local var_0_1 = 60
local var_0_2 = 240
local var_0_3 = 0

function var_0_0.Ctor(arg_1_0, arg_1_1)
	warning(tostring(arg_1_0) .. "weatehr init")

	arg_1_0.view = arg_1_1
	arg_1_0.TOD = GameObject.Find("/[MainBlock]/[Climat]/day/[Settings]/TOD_Timeline")
	arg_1_0._inited = false

	if arg_1_0.TOD then
		setActive(arg_1_0.TOD, true)
	end

	if not arg_1_0.TOD then
		warning("TOD_Timeline不存在 如果是室内场景 忽略这条警告")

		return
	end

	arg_1_0.director = arg_1_0.TOD:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
	arg_1_0.speedComp = GetOrAddComponent(arg_1_0.TOD, "TimelineSpeed")
	arg_1_0.settingComp = GetOrAddComponent(arg_1_0.TOD, "TODSettings")

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	assert(pg.island_set.island_time_rate.key_value_int and pg.island_set.island_time_rate.key_value_int > 0, "Invalid island time rate")

	arg_2_0.gameDaySec = math.floor(var_0_3 / pg.island_set.island_time_rate.key_value_int)

	arg_2_0.director:Stop()

	arg_2_0.director.playOnAwake = false
	arg_2_0.director.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Loop
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

	local var_3_0 = arg_3_0:GetFrame()

	if IsNil(arg_3_0.director) then
		return
	end

	arg_3_0.director.time = var_3_0 / var_0_1

	arg_3_0.director:Play()
	arg_3_0.speedComp:SetTimelineSpeed(var_0_2 / var_0_1 / arg_3_0.gameDaySec)

	return
end

function var_0_0.PauseOnEnterTime(arg_4_0)
	if not arg_4_0._inited then
		return
	end

	arg_4_0.director.time = arg_4_0:GetFrame() / var_0_1

	arg_4_0.director:Play()
	arg_4_0.speedComp:SetTimelineSpeed(0)

	return
end

function var_0_0.GetFrame(arg_5_0)
	if not arg_5_0._inited then
		return 0
	end

	local var_5_0 = pg.TimeMgr.GetInstance()

	return (math.floor((var_5_0:GetServerTime() - var_5_0._sAnchorTime) % var_0_3 % arg_5_0.gameDaySec / arg_5_0.gameDaySec * var_0_2))
end

function var_0_0.Dispose(arg_6_0)
	return
end

return var_0_0
