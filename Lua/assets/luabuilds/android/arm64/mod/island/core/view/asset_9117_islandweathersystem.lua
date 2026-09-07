local IslandWeatherSystem = class("IslandWeatherSystem")
local var_0_1 = 60
local var_0_2 = 240
local var_0_3 = 0

function IslandWeatherSystem:Ctor(arg_1_1)
	warning(tostring(self) .. "weatehr init")

	self.view = arg_1_1
	self.TOD = GameObject.Find("/[MainBlock]/[Climat]/day/[Settings]/TOD_Timeline")
	self._inited = false

	if self.TOD then
		setActive(self.TOD, true)
	end

	if not self.TOD then
		warning("TOD_Timeline不存在 如果是室内场景 忽略这条警告")

		return
	end

	self.director = self.TOD:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
	self.speedComp = GetOrAddComponent(self.TOD, "TimelineSpeed")
	self.settingComp = GetOrAddComponent(self.TOD, "TODSettings")

	self:Init()

	return
end

function IslandWeatherSystem:Init()
	assert(pg.island_set.island_time_rate.key_value_int and pg.island_set.island_time_rate.key_value_int > 0, "Invalid island time rate")

	self.gameDaySec = math.floor(var_0_3 / pg.island_set.island_time_rate.key_value_int)

	self.director:Stop()

	self.director.playOnAwake = false
	self.director.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Loop
	self._inited = true

	if self.settingComp.pauseOnEnterTime then
		self:PauseOnEnterTime()
	else
		self:Play()
	end

	return
end

function IslandWeatherSystem:Play()
	if not self._inited then
		return
	end

	local var_3_0 = self:GetFrame()

	if IsNil(self.director) then
		return
	end

	self.director.time = var_3_0 / var_0_1

	self.director:Play()
	self.speedComp:SetTimelineSpeed(var_0_2 / var_0_1 / self.gameDaySec)

	return
end

function IslandWeatherSystem:PauseOnEnterTime()
	if not self._inited then
		return
	end

	self.director.time = self:GetFrame() / var_0_1

	self.director:Play()
	self.speedComp:SetTimelineSpeed(0)

	return
end

function IslandWeatherSystem:GetFrame()
	if not self._inited then
		return 0
	end

	local var_5_0 = pg.TimeMgr.GetInstance()

	return (math.floor((var_5_0:GetServerTime() - var_5_0._sAnchorTime) % var_0_3 % self.gameDaySec / self.gameDaySec * var_0_2))
end

function IslandWeatherSystem:Dispose()
	return
end

return IslandWeatherSystem
