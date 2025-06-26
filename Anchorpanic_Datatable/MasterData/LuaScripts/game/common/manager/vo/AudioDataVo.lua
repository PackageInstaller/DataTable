--所有音效基类
module("AudioDataVo", Class.impl())

function ctor(self)
	self:resetData()
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function resetData(self)
	self.m_snId = nil 
	self.m_go = nil
 	self.m_path = nil
 	self.m_source = nil 	
 	self.m_loop = false
 	self.m_finishFrame = nil
 	self.m_finishCall = nil
end

-- 通过已有资源创建新实例
function create(self, path, beLoop, wpos, parentTrans, finishCall)
    local item = self:poolGet()
    item:resetData()

    item.m_snId = SnMgr:getSn()
    item.m_audioGo = gs.GOPoolMgr:Get(path, false)
    if item.m_audioGo == nil or gs.GoUtil.IsGoNull(item.m_audioGo) then
        LuaPoolMgr:poolRecover(item)
        gs.GOPoolMgr:Recover(item.m_audioGo, path)
        
        if item.m_finishCall then item.m_finishCall() end

        Debug:log_warn("AudioManager", "音频文件加载失败，请查看是否存在这个音频文件" .. path)
        return
    end

    item.m_audioGo:SetActive(true)
    item.m_path = path
    item.m_source = item.m_audioGo:GetComponent(ty.AudioSource)
    if  not item.m_source or not item.m_source.clip or item.m_source.clip.length <= 0 then
        LuaPoolMgr:poolRecover(item)
        gs.GOPoolMgr:Recover(item.m_audioGo, path)

        if item.m_finishCall then item.m_finishCall() end

        Debug:log_warn("AudioManager", "音频文件加载失败，请查看这个音频文件是否存在clip，或者clip length是否为0；" .. path)
        return
    end

    item.m_source.loop = beLoop
    item.m_source.pitch = 1
    item.m_loop = beLoop
    item.m_finishCall = finishCall
    item.m_curPlayTime = 0 -- 当前播放的时间


    if parentTrans and not gs.GoUtil.IsTransNull(parentTrans) and not gs.GoUtil.IsTransNull(item.m_audioGo.transform) then
        gs.TransQuick:SetParentOrg01(item.m_audioGo, parentTrans)
        gs.TransQuick:Pos(item.m_audioGo.transform, wpos)
    end
    item:addTimer()
    return item
end

--添加计时器
function addTimer(self)
    self:clearTimer()

    self.m_curPlayTime = 0
    self.m_finishFrame = LoopManager:addFrame(0, -1, nil, function()
        if not self.m_audioGo or gs.GoUtil.IsGoNull(self.m_audioGo) then
            Debug:log_error("AudioManager","请注意，这个音效被删掉了。path = " .. self.m_path .. "请检查逻辑，如果有必要，请在删除前，执行 stopAudioSound")
            self:clearTimer()
            LuaPoolMgr:poolRecover(self)
            return
        end

        self.m_curPlayTime = self.m_curPlayTime + self:getTimeDetaTime()

        if not self.m_source.clip then 
            logError("该音效clip 为空,无法播放" .. self.m_path)

            if self.m_finishCall then 
                self.m_finishCall()
            end
            return
        end
        if not self.m_loop and self.m_curPlayTime > self.m_source.clip.length + 0.5 then
            if self.m_finishCall then 
                self.m_finishCall()
            end
        end
    end)
end

--计时器计时间隔
function getTimeDetaTime(self)
    return 1/gs.Application.targetFrameRate
end

--清理计时器
function clearTimer(self)
	if self.m_finishFrame then 
		LoopManager:removeFrameByIndex(self.m_finishFrame)
		self.m_finishFrame = nil
	end
end

--继续播放音频
function resumeAudioData(self)
    self:addTimer()
    if self.m_source and not gs.GoUtil.IsCompNull(self.m_source) then
        gs.UnityEngineUtil.UnPauseAudio(self.m_source)
    end
end

-- 暂停播放音频
function pauseAudioData(self)
    if self.m_source and not gs.GoUtil.IsCompNull(self.m_source) then
        gs.UnityEngineUtil.PauseAudio(self.m_source)
    end

    self:clearTimer()
end

--主背景音乐过度暂停
function pauseByFade(self, time, callFun)
    if self.m_FadePauseMusicTwenn then
        self.m_FadePauseMusicTwenn:Kill()
        self.m_FadePauseMusicTwenn = nil
    end

    if self.m_FadeMusicTween then
        self.m_FadeMusicTween:Kill()
        self.m_FadeMusicTween = nil
    end

    self.m_FadePauseMusicTwenn = gs.DoTweenUtil.DoTweenFadeFloat(self.m_source.volume, 0, time, function(val)
        self.m_source.volume = val
    end, function()
        self:pauseAudioData()
        if callFun then
            callFun()
        end
    end)
end

--主背景音乐淡入恢复播放
function resumeByFade(self, time, endVolume)
    if self.m_FadePauseMusicTwenn then
        self.m_FadePauseMusicTwenn:Kill()
        self.m_FadePauseMusicTwenn = nil
    end

    if self.m_FadeMusicTween then
        self.m_FadeMusicTween:Kill()
        self.m_FadeMusicTween = nil
    end

    self:resumeAudioData()
    self.m_FadeMusicTween = gs.DoTweenUtil.DoTweenFadeFloat(self.m_source.volume, endVolume, time, function(val)
        if audioData then
            self.m_source.volume = val
        end
    end)
end

-- 回收
function recover(self)
    self:clearTimer()
    gs.GOPoolMgr:Recover(self.m_audioGo, self.m_path)
    self.m_audioGo:SetActive(false)
    self.m_source.pitch = 1
    LuaPoolMgr:poolRecover(self)
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
