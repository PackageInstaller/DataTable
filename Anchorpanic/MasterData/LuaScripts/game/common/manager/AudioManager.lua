module('AudioManager', Class.impl())

function ctor(self)
    local audioRootGO = gs.GameObject.Find("[AUDIO_GO]")
    if not audioRootGO then
        audioRootGO = gs.GameObject("[AUDIO_GO]")
    end
    gs.GoUtil.DontDestroyOnLoad(audioRootGO)
    self.m_audioRoot = audioRootGO.transform
    audioRootGO:SetActive(true)

    self.mMusicData = nil           --主背景音乐音频文件
    self.mPlayingMusic = true       --是否正在播放主背景音乐
    self.mMusicList = nil           --当前播放的主背景音乐列表
    self.mCurMusicType = 0          --当前播放的主背景音乐列表类型
    self.mMusicListIndex = 1        --当前正在播放的主背景音乐列表的下标

    self.mOtherMusciDic = {}        --杂项背景音乐字典

    self.mStoryMusciDic = {}        --剧情背景音乐字典

    self.mAllAudioDataDic = {}      --所有播放的音频（包括背景音乐、CV、音效、战斗音效）
    self.mFightSoundEffectList = {} --所有播放的战斗音效

    self.mTotalVolume = 0           --总音量
    self.mMusicVolume = 0           --背景音乐的音量
    self.mSoundEffcetVolume = 0     --音效的音量
    self.mCvVolume = 0              --当前的CV音量

    self.mCurPlayCVAudioData = nil  --当前正在播放的CV 英雄音频
end

-- 解析音乐音效配置
function parseMusicConfigData(self)
    self.mMusicConfig = {}
    local baseData = RefMgr:getData("music_data")
    for key, data in pairs(baseData) do
        self.mMusicConfig[key] = data
    end
end

-- 获取音乐音效配置数据
function getMusicConfig(self, cusId)
    if not cusId then
        return
    end

    if not self.mMusicConfig then
        self:parseMusicConfigData()
    end

    local data = self.mMusicConfig[cusId]
    if not data then
        Debug:log_error("Audio", "不存在AudioData: " .. cusId)
    end
    return data
end

-- 解析cv配置
function parseCVConfigData(self)
    self.mCVData = {}
    local baseData = RefMgr:getData("cv_data")
    for key, data in pairs(baseData) do
        self.mCVData[key] = data
    end
end

-- 获取cv配置数据
function getCVData(self, cusId)
    if not cusId then
        return
    end
    if not self.mCVData then
        self:parseCVConfigData()
    end
    local data = self.mCVData[cusId]
    if not data then
        Debug:log_error("Audio", "不存在cv Data: " .. cusId)
    end
    return data
end

----------------------------------------------------------------------------背景音乐----------------------------------------------------------------------------------
--播放剧情背景音 前奏+循环
function playStoryBG(self, cusId, volume)
    if volume == nil then
        volume = 1
    end
    -- self:stopStoryMusic()
    local retData = nil
    local data = self:getMusicConfig(cusId)
    if data then
        if data.intro == "" then
            retData = self:playStoryMusic(UrlManager:getMusicPath(data.voice), true, volume)
        else
            retData = self:playStoryMusic(UrlManager:getMusicPath(data.intro), false, volume)
            local time = self.mStoryMusciDic[retData.m_snId].m_source.clip.length
            self.storyLoopSn = LoopManager:setTimeout(time, nil, function()
                self:playStoryMusic(UrlManager:getMusicPath(data.loop), true, volume)
            end)
        end
    end
    return retData
end

-- 单个剧情背景音乐过渡暂停
function pauseStoryBGByFade(self, cusId, time, callFun)
    if table.empty(self.mStoryMusciDic) then
        if callFun then callFun() end
        return
    end

    local data = self:getMusicConfig(cusId)
    if data then
        for k, audioData in pairs(self.mStoryMusciDic) do
            if data.voice == audioData.m_path:match("^.+/(.+)$") then
                self:stopAudioSound(audioData, time, callFun)
            end
        end
    end
end

--剧情背景音乐过渡暂停
function pauseAllStoryBGByFade(self, time, callFun)
    if table.empty(self.mStoryMusciDic) then
        if callFun then callFun() end
        return
    end

    for k, data in pairs(self.mStoryMusciDic) do
        if time == 0 then
            data:pauseAudioData()
            if callFun then callFun() end
        else
            self:stopAudioSound(data, time, callFun)
        end
    end
    self.mStoryMusciDic = {}
end

--播放剧情背景音
function playStoryMusic(self, path, loop, volume)
    if loop == nil then
        loop = true
    end
    if volume == nil then
        volume = 1
    end

    local musci_Data = self:playAudioSound(path, loop)
    musci_Data.m_source.volume = self.mMusicVolume * self.mTotalVolume * volume
    self.mStoryMusciDic[musci_Data.m_snId] = musci_Data
    return musci_Data
end

--停止所有剧情类的音效
function stopStoryMusic(self)
    if (self.storyLoopSn) then
        LoopManager:clearTimeout(self.storyLoopSn)
        self.storyLoopSn = nil
    end

    for k, v in pairs(self.mStoryMusciDic) do
        self:stopAudioSound(v)
    end
    self.mStoryMusciDic = {}
end

--播放其他主背景音乐 (自行管理)
function playOtherMusic(self, path, loop)
    if loop == nil then
        loop = true
    end

    local musci_Data = self:playAudioSound(path, loop)
    musci_Data.m_source.volume = self.mMusicVolume * self.mTotalVolume
    self.mOtherMusciDic[musci_Data.m_snId] = musci_Data

    return musci_Data
end

-- 播放主背景音乐 通过ID
function playMusicById(self, cusId, loop)
    if storyTalk.StoryTalkManager:getNotAllowdPlay() then
        print("强制取消了播放" .. cusId)
        return
    end

    local data = self:getMusicConfig(cusId)
    if data then
        if data.intro == "" then
            self:playMusic(UrlManager:getMusicPath(data.voice), loop)
        else
            if self:isPlayingMusic(UrlManager:getMusicPath(data.loop)) or self:isPlayingMusic(UrlManager:getMusicPath(data.intro)) then
                return false
            end
            self:playMusic(UrlManager:getMusicPath(data.intro), false)

            self:clearMusicTimeOutSn()
            local time = self.mMusicData and self.mMusicData.m_source.clip.length or 1
            self.mMusicTimeOutSn = LoopManager:setTimeout(time, nil, function()
                self:playMusic(UrlManager:getMusicPath(data.loop), true)
            end)
        end
    end

    -- local data = self:getMusicConfig(cusId)
    -- if data then
    --     self:playMusic(UrlManager:getMusicPath(data.voice), loop)
    -- end
end

--移除主背景音乐的延迟计时器
function clearMusicTimeOutSn(self)
    if self.mMusicTimeOutSn then
        LoopManager:clearTimeout(self.mMusicTimeOutSn)
        self.mMusicTimeOutSn = nil
    end
end

-- 播放主背景音乐对象(唯一)
function playMusic(self, path, loop, finishCall)
    if storyTalk.StoryTalkManager:getNotAllowdPlay() then
        print("强制取消了播放" .. path)
        return
    end

    if self:isPlayingMusic(path) then
        return false
    end

    if loop == nil then
        loop = true
    end
    self:stopMusic()
    self.mMusicData = self:playAudioSound(path, loop, finishCall)
    if self.mMusicData then
        self.mMusicData.m_source.volume = self.mMusicVolume * self.mTotalVolume
    end
end

--移除主背景音乐
function stopMusic(self)
    self:clearMusicTimeOutSn()
    self:stopAudioSound(self.mMusicData)
end

--播放随机主背景音乐列表（通过Id）
function playMusicListByIds(self, ids, _type)
    if storyTalk.StoryTalkManager:getNotAllowdPlay() then
        print("强制取消了播放 ids")
        return
    end

    local lst = {}
    for index, value in ipairs(ids) do
        local data = self:getMusicConfig(value)
        if data then
            table.insert(lst, UrlManager:getMusicPath(data.voice))
        end
    end
    return self:playMusicList(lst, _type)
end

--播放随机主背景音乐列表
function playMusicList(self, paths, _type, idx)
    if table.empty(paths) then return false end

    self.mMusicList = paths
    self.mCurMusicType = _type
    if self.mCurMusicType == 1 then
        if not idx or idx > #paths then
            idx = 1
        end
    else
        if (idx ~= nil and #paths > 1) then
            local keys = table.keys(paths)
            table.sort(keys)
            table.remove(keys, idx)
            if #keys > 1 then
                local tmpIdx = math.random(1, #keys)
                idx = keys[tmpIdx]
            else
                idx = keys[1]
            end
        else
            idx = math.random(1, #paths)
        end
    end
    self.mMusicListIndex = idx

    local finishCall = function()
        self:playMusicList(self.mMusicList, self.mCurMusicType, self.mMusicListIndex)
    end

    local path = paths[self.mMusicListIndex]
    if not self:playMusic(path, finishCall) then
        table.remove(paths, self.mMusicListIndex)
        return self:playMusicList(self.mMusicList, self.mCurMusicType, self.mMusicListIndex)
    end
end

--判断是否在播放主背景音乐对象
function isPlayingMusic(self, path)
    if self.mMusicData then
        if self.mMusicData.m_path == path then
            return true
        end
    end
end

--获取当前的主背景音乐播放数据
function getMusicData(self)
    return self.mMusicData
end

--主背景音乐过渡暂停
function pauseMusicByFade(self, time, callFun)
    if not self.mMusicData then return end

    if time == 0 then
        self.mMusicData:pauseAudioData()
    else
        self.mMusicData:pauseByFade(time, callFun)
    end
end

--主背景音乐淡入恢复播放
function resumeMusicByFade(self, time)
    if not self.mMusicData then return end

    local curVolume = self.mMusicVolume * self.mTotalVolume
    self.mMusicData:resumeAudioData()
    if time > 0 then
        self.mMusicData:resumeByFade(time, curVolume)
    else
        self.mMusicData.m_source.volume = curVolume
    end
end

-- 设置主背景音乐音量
function setMusicVolume(self, volume)
    self.mMusicVolume = volume

    if self.mMusicData then
        self.mMusicData.m_source.volume = self.mMusicVolume * self.mTotalVolume
    end

    for snId, musicData in pairs(self.mOtherMusciDic) do
        musicData.m_source.volume = self.mMusicVolume * self.mTotalVolume
    end

    for snId, musicData in pairs(self.mStoryMusciDic) do
        musicData.m_source.volume = self.mMusicVolume * self.mTotalVolume
    end
end

-- 获取当前主背景音乐音量
function getMusicVolume(self)
    return self.mMusicVolume
end

-------------------------------------------------------------------音效-----------------------------------------------
-- -- 播放音效对象 通过Id
-- function playSoundEffectById(self, cusId)
--     local data = self:getMusicConfig(cusId)
--     if data then
--         self:playSoundEffect(UrlManager:getEffectSoundPath(data.voice))
--     end
-- end

--播放音效对象  beLoop 是否循环播放，finishCall: 结束回调, 非循环时有效 wpos：生成的位置
function playSoundEffect(self, path, beLoop, wpos, parentTrans, finishCall)
    local volume = self.mSoundEffcetVolume * self.mTotalVolume
    if (volume <= 0) then
        if finishCall then finishCall(path) end
        return
    end
    local audioData = self:playAudioSound(path, beLoop, finishCall, wpos, parentTrans)
    if audioData then
        audioData.m_source.volume = volume
    end
    return audioData
end

-- 设置音效音量
function setSoundEffectVolume(self, value)
    if value then
        self.mSoundEffcetVolume = value
    end
end

-- 获取当前音效音量
function getSoundEffectVolume(self)
    return self.mSoundEffcetVolume
end

-------------------------------------------------------------战斗音效--------------------------

--播放一个战斗音效 注意：parentTrans 不为空的时候得在 parentTrans Destroy 执行一次 stopAudioSound
function playFightSoundEffect(self, path, beLoop, wpos, parentTrans, finishCall)
    local volume = self.mSoundEffcetVolume * self.mTotalVolume
    if (volume <= 0) then
        if finishCall then finishCall(path) end
        return
    end

    if not path or path == "" then
        logWarn("play audio path is nil ")
        return
    end

    if not parentTrans then
        parentTrans = self.m_audioRoot
    end

    if not wpos then
        wpos = gs.VEC3_ZERO
    end

    local audioData = nil
    local function deleteCall()
        self:stopAudioSound(audioData)
        if finishCall then finishCall(path) end
    end

    audioData = AudioFightEffectDataVo:create(path, beLoop, wpos, parentTrans, deleteCall)
    if audioData then
        audioData.m_source.volume = volume

        audioData:setPitch(fight.FightManager:getTimeScale())

        self.mFightSoundEffectList[audioData.m_snId] = audioData
        self.mAllAudioDataDic[audioData.m_snId] = audioData
    end
    return audioData
end

-- 对所有战斗音效对象进行timeScale处理
function setFightAudioSpeed(self, timeScale)
    if self.mFightSoundEffectList then
        for sn, audioData in pairs(self.mFightSoundEffectList) do
            if not gs.GoUtil.IsGoNull(audioData.m_audioGo) and audioData.m_source then
                audioData:setPitch(timeScale)
            end
        end
    end
end

--停止所有战斗音效对象
function stopAllFightSoundEffect(self)
    if self.mFightSoundEffectList then
        for snId, audioData in pairs(self.mFightSoundEffectList) do
            audioData:recover()
        end
        self.mFightSoundEffectList = {}
    end
end

-------------------------------------------------------------战员CV-----------------------------

--播放一个CV 通过字段名(排队)
function playHeroCVByFieldName(self, heroTid, fieldName, finishCall, isReplace)
    if not fieldName then
        return
    end
    local vo = hero.HeroManager:getHeroConfigVo(heroTid)
    if vo then
        local orgData = vo:getOrgData()
        if orgData and orgData[fieldName] then
            if isReplace then
                return self:playHeroCVOnReplace(orgData[fieldName], finishCall)
            else
                return self:playHeroCV(orgData[fieldName], finishCall)
            end
        end
    else
        local monVo = monster.MonsterManager:getMonsterVo01(heroTid)
        if monVo then
            local orgData = monVo:getOrgData()
            if orgData and orgData[fieldName] then
                return self:playHeroCV(orgData[fieldName], finishCall)
            end
        end
    end
end

--播放一个CV(排队)
function playHeroCV(self, cusId, finishCall)
    -- 有人正在cv播放中
    if self.mCurPlayCVAudioData then
        if finishCall then
            finishCall()
        end
        return
    end

    local function _finish()
        if finishCall then
            finishCall()
        end
    end

    self.mCurPlayCVAudioData = self:playCvByCVID(cusId, _finish)
    return self.mCurPlayCVAudioData, cusId
end

--播放一个CV(顶掉上一个)
function playHeroCVOnReplace(self, cusId, finishCall)
    -- 有人正在cv播放中
    if self.mCurPlayCVAudioData then
        self:stopAudioSound(self.mCurPlayCVAudioData)
    end

    self.mCurPlayCVAudioData = self:playCvByCVID(cusId, finishCall)
    return self.mCurPlayCVAudioData
end

--播放一个Cv通过CVId
function playCvByCVID(self, cvId, finishCall)
    local data = self:getCVData(cvId)
    if data and data.voice ~= "" then
        return self:playCvByCVPath(UrlManager:getCVSoundPath(data.voice), finishCall)
    end
end

--播放一个Cv通过CVId
function playCvByCVPath(self, path, finishCall)
    local volume = self:getCvVolume() * self:getTotalVolume()
    -- if (volume <= 0) then
    --     if finishCall then finishCall(path) end
    --     return
    -- end
    local audioData = self:playAudioSound(path, false, finishCall)
    if audioData then
        audioData.m_source.volume = volume
    end

    return audioData
end

-- 设置CV音量
function setCvVolume(self, value)
    if value then
        self.mCvVolume = value
    end
end

-- 获取当前CV音量
function getCvVolume(self)
    return self.mCvVolume
end

-------------------------------------------------------通用方法------------------------------------------
--------------------------------------------------战斗音效没有走通用--------------------------------------
--获取总音量
function getTotalVolume(self)
    return self.mTotalVolume
end

--设置总音量
function setTotalVolume(self, val)
    if val then
        self.mTotalVolume = val
    end

    if self.mMusicData then
        self.mMusicData.m_source.volume = self.mMusicVolume * self.mTotalVolume
    end

    for snId, musicData in pairs(self.mOtherMusciDic) do
        musicData.m_source.volume = self.mMusicVolume * self.mTotalVolume
    end
end

--因为切换cv音效功能需要根据不同配置去用不同目录的音效
--但是我们有两套播放cv的逻辑 一套在lua 一套在c#
--lua这边是根据配置去那名字拼接路径的 c#那边是直接传递路径的不好改
--为了兼容故而在这播放音效最底层去处理
local function fixCvPath(path)
    -- 判断路径是否以指定前缀开头
    local cvPrefixPath = UrlManager:getCVSoundPrefixPath()
    if string.startsWith(path, cvPrefixPath) then
        local data = systemSetting.SystemSettingManager:getCurCvTypeSettingCfg()
        local folderName = data[1]
        if folderName ~= "cv" then
            --替换前缀中出现的cv为多国cv总目录
            local newCvPrefixPath = string.gsub(cvPrefixPath, "cv", "cv_multiple")
            --拼接目标国家cv目录
            newCvPrefixPath = newCvPrefixPath .. folderName .. "/"
            --替换路径前缀
            path = string.replacePrefix(path, cvPrefixPath, newCvPrefixPath)
        end
    end
    return path
end

--播放一个音频文件
function playAudioSound(self, path, beLoop, finishCall, wpos, parentTrans)
    path = fixCvPath(path)
    local audioData = nil
    local function _delayCall()
        self:stopAudioSound(audioData)
        if finishCall then finishCall(path) end
    end
    audioData = self:loadAudioSound(path, beLoop, wpos, parentTrans, _delayCall)
    if audioData then
        self.mAllAudioDataDic[audioData.m_snId] = audioData
        return audioData
    end
    if finishCall then
        finishCall(path)
    end
end

--加载音效文件 路径 path, 音量 volume, 是否循环 beLoop, 生成位置 wpos, 父借点 parentTrans, 播放完成回调（循环不会回调） deleteCall
function loadAudioSound(self, path, beLoop, wpos, parentTrans, deleteCall)
    if not path or path == "" then
        logWarn("play audio path is nil ")
        return
    end

    if not parentTrans then
        parentTrans = self.m_audioRoot
    end

    if not wpos then
        wpos = gs.VEC3_ZERO
    end

    return AudioDataVo:create(path, beLoop, wpos, parentTrans, deleteCall)
end

function preloadCvByCvId(self, cvId, noTips)
    local cvData = self:getCVData(cvId)
    if not cvData then
        return false
    end
    local path = UrlManager:getCVSoundPath(cvData.voice)
    path = fixCvPath(path)
    local audioGo = gs.GOPoolMgr:Get(path, false)
    if not audioGo then
        if not noTips then
            gs.Message.Show(_TT(1431))
        end
        return false
    end

    gs.GOPoolMgr:Recover(audioGo, path)
    return true
end

function deleteAudioSound(self, audioData)
    if not audioData then return end

    if self.mAllAudioDataDic[audioData.m_snId] ~= nil then
        self.mAllAudioDataDic[audioData.m_snId] = nil
    end
    if self.mFightSoundEffectList[audioData.m_snId] ~= nil then
        self.mFightSoundEffectList[audioData.m_snId] = nil
    end
    if self.mOtherMusciDic[audioData.m_snId] ~= nil then
        self.mOtherMusciDic[audioData.m_snId] = nil
    end

    if self.mStoryMusciDic[audioData.m_snId] ~= nil then
        self.mStoryMusciDic[audioData.m_snId] = nil
    end

    if self.mMusicData and self.mMusicData.m_snId == audioData.m_snId then
        self.mMusicData = nil
    end

    if self.mCurPlayCVAudioData and self.mCurPlayCVAudioData.m_snId == audioData.m_snId then
        self.mCurPlayCVAudioData = nil
    end
end

--停止指定Sn的音效
function stopAudioBySnId(self, snId)
    if self.mAllAudioDataDic[snId] == nil then
        return
    end

    local audioData = self.mAllAudioDataDic[snId]
    self:stopAudioSound(audioData)
end

--停止指定路径的音效
function stopAudioByUrl(self, url)
    for _, audioData in pairs(self.mAllAudioDataDic) do
        if audioData.m_path == url then
            self:stopAudioSound(audioData)
            break
        end
    end
end

--停止指定的音频文件
function stopAudioSound(self, audioData, fadeTime, callFun)
    if not audioData then
        return
    end

    if self.mAllAudioDataDic[audioData.m_snId] == nil then
        logError("self.mAllAudioDataDic[audioData.m_snId] == nil")
        return
    end
    if (fadeTime and fadeTime > 0) then
        audioData:pauseByFade(fadeTime, callFun)
    else
        audioData:recover()
        if callFun then callFun() end
    end

    self:deleteAudioSound(audioData)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
