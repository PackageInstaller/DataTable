
-- AudiMgr是针对C#中的AudioManager的一个封装，让Lua代码中能更容易地调用基础函数，但是，在这个函数中将声音素材的加载和卸载全部进行了封装，在Play的第一次进行加载
-- 也并没有进行卸载的动作。需要考虑声音的整个生命周期管理
-- 在当前的游戏中是存在大量的语音素材的，需要考虑声音资源的加载和卸载逻辑

---@class AudioMgr
local AudioMgr = class("AudioMgr", function (...)
    return AudioManager.Instance
end)

function AudioMgr:ctor(...)
	self.web_audio = {}
end

function AudioMgr:NewResourceVersion()
	if EngineGlobal.useNewResource then
		return true
	end
	return false
end

---播放背景音乐
---@param path string 音频文件路径
---@param loop boolean 是否循环播放
---@param callback function 播放完成回调
function AudioMgr:LuaPlayBgm(path, gameObject, loop, callback)
	if self.currPlayPath ~= path then
		self.currPlayPath = path
		if self.playingKey then
			self:StopBGMWithKey(self.playingKey)
		end
		if self:NewResourceVersion() then
			self.playingKey = self:PlayBGM(path, gameObject, loop and -1 or 1, false, 1, callback)
		else
			self.playingKey = self:PlayBGM(path, loop and -1 or 1, false, 1, callback)
		end
	end
end

---播放带淡入淡出效果的背景音乐
---@param path string 音频文件路径
---@param loop boolean 是否循环播放
---@param callback function 播放完成回调
---@param fadeTime number 淡入淡出时间(秒)
function AudioMgr:LuaPlayBgmFade(path, requestId, loop, callback, fadeTime)
	if self.currPlayPath ~= path then
		self.currPlayPath = path
		if self.playingKey then
			self:StopBGMWithKey(self.playingKey, fadeTime)
			if self.nowDoAfterTimer then
				DLuaTimer:RemoveTimer(self.nowDoAfterTimer)
			end
			self.nowDoAfterTimer = DLuaTimer:DoAfter(fadeTime, function()
				if self:NewResourceVersion() then
					self.playingKey = self:PlayBGM(path, requestId, loop and -1 or 1, false, 1, callback, true, fadeTime)
				else
					self.playingKey = self:PlayBGM(path, loop and -1 or 1, false, 1, callback, true, fadeTime)
				end
				DLuaTimer:RemoveTimer(self.nowDoAfterTimer)
			end)
		else
			if self:NewResourceVersion() then
				self.playingKey = self:PlayBGM(path, requestId, loop and -1 or 1, false, 1, callback, true, fadeTime)
			else
				self.playingKey = self:PlayBGM(path, loop and -1 or 1, false, 1, callback, true, fadeTime)
			end
		end
	end
end

---检查是否正在播放背景音乐
---@return boolean 如果正在播放背景音乐则返回true，否则返回false
function AudioMgr:hasBgmPlaying()
	return self.currPlayPath ~= nil
end


---停止当前播放的背景音乐
---@param fadeTime number 淡出时间(秒)，可选参数
function AudioMgr:StopCurrBgm(fadeTime)
	if self.playingKey then
		self:StopBGMWithKey(self.playingKey, fadeTime)
	end
	if self.nowDoAfterTimer then
		DLuaTimer:RemoveTimer(self.nowDoAfterTimer)
	end
	self.currPlayPath = nil
	self.playingKey = nil
end

---设置2D音效静音
---@param bMute boolean 是否静音
function AudioMgr:set2DSoundMute(bMute)
    self.tmpMute = bMute
end

---播放2D音效
---@param audioPath string 音频文件路径
---@param volume number 音量，可选参数
---@param loopTime number 循环次数，可选参数
---@param callBack function 播放完成回调，可选参数
---@param track number 轨道，可选参数
---@param fadeTime number 淡入淡出时间(秒)，可选参数
function AudioMgr:__playSound(audioPath, gameObject, volume, loopTime, callBack, track, Obj, fadeTime, fadeEase, maxDistanceSE, minDistance)
	if not volume then
		volume = 1
	end
	if not loopTime then
		loopTime = 1
	end
	if not track then
		track = self.soundTrack
		self.soundTrack = self.soundTrack + 1
	end
	local bFadeOutIn = false
	if fadeTime then
		bFadeOutIn = true
	end
	if not fadeTime then
		fadeTime = 0
	end
	if not fadeEase then
		fadeEase = DG.Tweening.Ease.Linear
	end
	if not maxDistanceSE then
		maxDistanceSE = 500
	end
	if not minDistance then
		minDistance = 1
	end
	if type(audioPath) == "string" then
		if self:NewResourceVersion() then
			return self:PlaySound(track, audioPath, gameObject, volume, loopTime, callBack, Obj, bFadeOutIn, fadeTime, fadeEase, maxDistanceSE, minDistance)
		else
			return self:PlaySound(track, audioPath, volume, loopTime, callBack, Obj, bFadeOutIn, fadeTime, fadeEase, maxDistanceSE, minDistance)
		end	
	else
		if self:NewResourceVersion() then
			return self:PlaySoundWithClip(track, audioPath, gameObject, volume, loopTime, callBack, Obj, bFadeOutIn, fadeTime, fadeEase, maxDistanceSE, minDistance)
		else
			return self:PlaySoundWithClip(track, audioPath, volume, loopTime, callBack, Obj, bFadeOutIn, fadeTime, fadeEase, maxDistanceSE, minDistance)
		end
	end
end

function AudioMgr:__checkAudioPlayType(curAudio, lastAudio)
	if Config.AudioPlayType[curAudio] and Config.AudioPlayType[lastAudio] then
		return Config.AudioPlayType[curAudio] == Config.AudioPlayType[lastAudio]
	end
	return false
end

---播放2D音效
---@param audioPath string 音频文件路径
---@param volume number? 音量，可选参数
---@param loopTime number? 循环次数，可选参数
---@param callBack function? 播放完成回调，可选参数
---@param track number? 轨道，可选参数
---@param fadeTime number? 淡入淡出时间(秒)，可选参数
---@param fadeEase DG.Tweening.Ease? 淡入淡出曲线，默认为Linear，可选参数
function AudioMgr:play2DSound(audioPath, gameObject, volume, loopTime, callBack, track, fadeTime, fadeEase)
	if AudioMgr.SEMute then
		return
	end

    -- if self.tmpMute then
    --     return
    -- end
	local checkInterval = 0.25
	local checkAudioPath
	if type(audioPath) ~= "string" then
		checkAudioPath = audioPath.name
	else
		checkAudioPath = audioPath
	end

	local curTime = os.clock()
	if Config.AudioPlayType[checkAudioPath] and self.lastAudioPath then
		local checkTime = curTime - self.playAudioTimestamp <= checkInterval
		if checkTime and self:__checkAudioPlayType(checkAudioPath, self.lastAudioPath) then
			return
		end
	end

	self.lastAudioPath = checkAudioPath
	self.playAudioTimestamp = curTime

	return self:__playSound(audioPath, gameObject, volume or 1, loopTime or 1, callBack, track, nil, fadeTime, fadeEase)
end

---播放2D音效
---@param audioPath string 音频文件路径
---@param volume number? 音量，可选参数
---@param loopTime number? 循环次数，可选参数
---@param callBack function? 播放完成回调，可选参数
---@param track number? 轨道，可选参数
---@param fadeTime number? 淡入淡出时间(秒)，可选参数
---@param fadeEase DG.Tweening.Ease? 淡入淡出曲线，默认为Linear，可选参数
---@param obj GameObject? 绑定的游戏对象
---@param maxDistanceSE number? 最大距离
---@param minDistance number? 最小距离
function AudioMgr:play3DSound(audioPath, requestId, volume, loopTime, callBack, track, fadeTime, fadeEase, obj, maxDistanceSE, minDistance)
	if AudioMgr.SEMute then
		return

	end

    if self.tmpMute then
        return
    end
	
	return self:__playSound(audioPath, requestId, volume or 1, loopTime or 1, callBack, track, obj, fadeTime, fadeEase, maxDistanceSE, minDistance)
end

---停止2D音效
---@param name string 音效名称
function AudioMgr:stopSE(name)
	self:StopSE(name)
end

---播放语音
---@param audioPath string 音频文件路径
---@param volume number? 音量，可选参数
---@param loopTime number? 循环次数，可选参数
---@param callBack function? 播放完成回调，可选参数
---@param track number? 轨道，可选参数
function AudioMgr:play2DVoice(audioPath, requestId, volume, loopTime, callBack, track, fadeTime, fadeEase)
	if AudioMgr.VoiceMute then
		return
	end

    if self.tmpMute then
        return
    end

	local checkInterval = 0.25
	local checkAudioPath
	if type(audioPath) ~= "string" then
		checkAudioPath = audioPath.name
	else
		checkAudioPath = audioPath
	end

	local curTime = os.clock()
	if Config.AudioPlayType[checkAudioPath] and self.lastVoicePath then
		local checkTime = curTime - self.playVoiceTimestamp <= checkInterval
		if checkTime and self:__checkAudioPlayType(checkAudioPath, self.lastVoicePath) then
			return
		end
	end

	self.lastVoicePath = checkAudioPath
	self.playVoiceTimestamp = curTime

	return self:__playVoice(audioPath, requestId, volume or 1, loopTime or 1, callBack, track, nil, fadeTime, fadeEase)
end


---停止语音
---@param name string 音效名称
---@param fadeTime number? 淡出时间，可选参数
function AudioMgr:stopVoice(name, fadeTime)
	self:StopVoice(name, fadeTime or 0)
end


---播放语音的内部实现方法
---@param audioPath string|UnityEngine.AudioClip 音频文件路径或AudioClip对象
---@param volume number 音量大小，默认为1
---@param loopTime number 循环次数，默认为1
---@param callBack function 播放完成回调
---@param track number 音轨编号，默认使用自增的soundTrack
---@param Obj GameObject 绑定的游戏对象
---@param bFadeOutIn boolean 是否使用淡入淡出效果
---@param fadeTime number 淡入淡出时间，默认为0
---@param fadeEase DG.Tweening.Ease 淡入淡出曲线，默认为Linear
---@return number 返回音轨编号
function AudioMgr:__playVoice(audioPath, requestId, volume, loopTime, callBack, track, Obj, fadeTime, fadeEase)
	if not volume then
		volume = 1
	end
	if not loopTime then
		loopTime = 1
	end
	if not track then
		track = self.voiceTrack
		self.voiceTrack = self.voiceTrack + 1
	end
	local bFadeOutIn = false
	if fadeTime then
		bFadeOutIn = true
	end
	if not fadeTime then
		fadeTime = 0
	end
	if not fadeEase then
		fadeEase = DG.Tweening.Ease.Linear
	end
	if type(audioPath) == "string" then
		if self:NewResourceVersion() then
			return self:PlayVoice(track, audioPath, requestId, volume, loopTime, callBack, Obj, bFadeOutIn, fadeTime, fadeEase)
		else
			return self:PlayVoice(track, audioPath, volume, loopTime, callBack, Obj, bFadeOutIn, fadeTime, fadeEase)
		end
	else
		if self:NewResourceVersion() then
			return self:PlayVoiceWithClip(track, audioPath, requestId, volume, loopTime, callBack, Obj, bFadeOutIn, fadeTime, fadeEase)
		else
			return self:PlayVoiceWithClip(track, audioPath, volume, loopTime, callBack, Obj, bFadeOutIn, fadeTime, fadeEase)
		end	
	end
end

function AudioMgr:setBGMVolume(value)
	self.BGMVolume = value
end

function AudioMgr:setSEVolume(value)
	self.SEVolume = value
end

function AudioMgr:setCVVolume(value)
	self.VoiceVolume = value
end

function AudioMgr:setMasterVolume(value)
	self.MasterVolume = value
end

---暂停BGM
---@param time number|nil 暂停时间，可选参数
---@param func function|nil 暂停回调，可选参数
function AudioMgr:pauseBGM(time, func)
	if not time then
		time = 0
	end
	if self.playingKey then
		self:PauseBGMFade(self.playingKey, time, func)
	end
end

---恢复BGM
---@param time number|nil 恢复时间，可选参数
---@param func function|nil 恢复回调，可选参数
function AudioMgr:resumBGM(time, func)
	if not time then
		time = 0
	end
	if self.playingKey then
		self:ResumBGMFade(self.playingKey, time, func)
	end
end

--SE静音
function AudioMgr:SetSEMute(bool)
	self.SEMute = bool
end

--BGM静音
function AudioMgr:SetBGMMute(bool)
	self.BGMMute = bool
end

--Voice静音
function AudioMgr:SetVoiceMute(bool)
	self.VoiceMute = bool
end

--主音量静音
function AudioMgr:SetMasterMute(value)
	self.MasterMute = value
end

---获取音频时长
---@param path string 音频文件路径
---@return number 音频时长
function AudioMgr:getAudioLength(path)
	return self:GetAudioLength(path)
end

---获取当前播放音频的实时分贝值
---@param name string 音频名称
---@return number 分贝值
function AudioMgr:getNowVoiceDB(name)
	return self:GetNowVoiceDB(name)
end

---预加载音频资源，加载完成后可直接调用播放接口无需等待异步加载
---@param path string 音频文件路径
---@param gameObject UnityEngine.GameObject 绑定的游戏对象，用于资源生命周期管理
---@param onComplete function? 加载完成回调，可选参数
function AudioMgr:preloadAudio(path, gameObject, onComplete)
	if not self:NewResourceVersion() then
		return
	end
	if not path or path == "" then
		if onComplete then
			onComplete()
		end
		return
	end
	self:PreloadAudio(path, gameObject, onComplete)
end

return AudioMgr