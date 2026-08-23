local BGMService = class("BGMService")
local var_0_1 = 1

function BGMService:ctor()
	self._musicVolume = 1
	self._musicType = 0
	self._defalut = g.core.const.ConstMgr.SoundConst.BGM.MAIN
	self._curMusicName = ""
	self._musicDelay = 0

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_ENTER_ROOT, self.onModuleEnter, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BGM_CHANGE, self.onBgmMusicChange, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MUSIC_SETTING_CHANGED, self._onMusicSettingChanged, self)
end

function BGMService:onModuleEnter(arg_2_1, arg_2_2)
	local var_2_0 = self._curMusicName

	if not self._curMusicName or var_2_0 == "" then
		var_2_0 = self._defalut
	end

	while true do
		if arg_2_2.BGM then
			var_2_0 = arg_2_2.BGM

			break
		elseif arg_2_2.BGM_OFF then
			return
		elseif arg_2_2.previous then
			arg_2_2 = arg_2_2.previous
		else
			break
		end
	end

	local var_2_1 = self._musicVolume

	self._musicVolume = var_2_0 == g.core.const.ConstMgr.SoundConst.BGM.FIGHT_PVE_1 and 0.7 or 0.8

	if self._musicType == 1 then
		var_2_0 = g.core.const.ConstMgr.SoundConst.BGM.FIGHT_PVE_2
	elseif self._musicType == 2 then
		var_2_0 = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_PVP
	elseif self._musicType == 3 then
		var_2_0 = g.core.const.ConstMgr.SoundConst.BGM.BOSS
	elseif self._musicType == 4 then
		var_2_0 = g.core.const.ConstMgr.SoundConst.BGM.FIGHT_PVE_1
	elseif self._musicType == 5 then
		var_2_0 = g.core.const.ConstMgr.SoundConst.BGM.BOSS
	end

	self._musicType = 0

	if self._curMusicName ~= var_2_0 then
		self._musicDelay = arg_2_2.BGM_DELAY or 0

		if self._schedule then
			g.core.common.Scheduler:cancelSchedule(self._schedule)
		end

		if not self._preVolume then
			self._preVolume = var_2_1
			self._curVolume = var_2_1
		end

		self._schedule = g.core.common.Scheduler:newSchedule(handler(self, self._onMusicChange), 0.1)
		self._curMusicName = var_2_0
	end
end

function BGMService:_onMusicChange(arg_3_1, arg_3_2)
	arg_3_2 = math.min(arg_3_2, var_0_1)

	local var_3_0 = math.max(0, self._curVolume - arg_3_2 / var_0_1 * self._preVolume)

	if var_3_0 == 0 then
		if self._delaySchedule then
			g.core.common.Scheduler:cancelSchedule(self._delaySchedule)

			self._delaySchedule = nil
		end

		if self._musicDelay == 0 then
			g.core.sound.SoundManager:setMusicVolume(self._musicVolume)
			g.core.sound.SoundManager:playMusic(self._curMusicName)
		else
			self._delaySchedule = g.core.common.Scheduler:newScheduleOnce(function()
				g.core.sound.SoundManager:setMusicVolume(self._musicVolume)
				g.core.sound.SoundManager:playMusic(self._curMusicName)
			end, self._musicDelay)
		end

		g.core.common.Scheduler:cancelSchedule(self._schedule)

		self._preVolume = nil
		self._curVolume = nil
		self._schedule = nil
	else
		self._curVolume = var_3_0

		g.core.sound.SoundManager:setMusicVolume(var_3_0)
	end
end

function BGMService:onBgmMusicChange(arg_5_1, arg_5_2)
	self._musicType = arg_5_2.type or 0
end

function BGMService:_onMusicSettingChanged(arg_6_1, arg_6_2)
	if arg_6_2 then
		local var_6_0 = self._curMusicName

		if not self._curMusicName or var_6_0 == "" then
			var_6_0 = self._defalut
		end

		g.core.sound.SoundManager:playMusic(var_6_0)
	end
end

return BGMService
