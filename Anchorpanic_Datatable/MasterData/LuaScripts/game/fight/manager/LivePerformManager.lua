--[[ 
-----------------------------------------------------
@filename       : LivePerformManager
@Description    : 角色战斗过程非技能演出管理器
@date           : 2022-11-05 19:39:53
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('fight.LivePerformManager', Class.impl(Manager))

--构造函数
function ctor(self)
    self.m_travelDict = {}
end

--析构函数

function dtor(self)

end

-- 初始化boss演出配置
function parseConfigData(self)
    self.mConfigDic = {}
    local baseData = RefMgr:getData("boss_show_data")
    for modelId, data in pairs(baseData) do
        local vo = fight.BossShowCofingVo.new()
        vo:parseData(modelId, data)
        self.mConfigDic[vo.modelId] = vo
    end
end

-- 取boss演出数据
function getBossShowVo(self, modelId)
    if not self.mConfigDic then
        self:parseConfigData()
    end
    return self.mConfigDic[modelId]
end

-- 开场演出
function playStandby(self, liveId)
    local livething = fight.SceneItemManager:getLivething(liveId)
    if not livething:haveClipWithHash(fight.FightDef.ACT_STANDBY) then
        return
    end

    local liveVo = livething:getLiveVo()
    local modelId = liveVo:getModelID()
    local showVo = self:getBossShowVo(modelId)
    livething:getAniLenght(fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_STANDBY], function(lenght)
        if showVo and not table.empty(showVo.standbyEff) then
            for i, v in ipairs(showVo.standbyEff) do
                self:playEffTravel(liveId, 0, v, lenght)
            end
        end
        if showVo and showVo.standbySound and showVo.standbySound ~= "" then
            self:playSoundEff(liveId, showVo.standbySound)
        end
        if showVo and showVo.standbyCv and showVo.standbyCv ~= "" then
            self:playCv(liveId, showVo.standbyCv)
        end
    end)
end

-- 进场演出
function playEnter(self, liveId, type, finishCall)
    local aniList = { fight.FightDef.ACT_ENTER, fight.FightDef.ACT_ENTER_1 }
    local aniHash = aniList[type + 1]

    local livething = fight.SceneItemManager:getLivething(liveId)
    livething:setVisible(true)
    livething:setDisplayLayer("Role")
    if not livething:haveClipWithHash(aniHash) then
        finishCall()
        return
    end

    local heroDic = fight.SceneManager:getSideThingIDs(1)
    for i, id in ipairs(heroDic) do
        local thingVo = fight.SceneManager:getThing(id)
        if thingVo and not thingVo:isDead() then
            thingVo:setVisible(false)
        end
    end

    fight.FightCamera:focusOnLive(liveId)

    local function playComplete()
        local heroDic = fight.SceneManager:getSideThingIDs(1)
        for i, id in ipairs(heroDic) do
            local thingVo = fight.SceneManager:getThing(id)
            if thingVo and not thingVo:isDead() then
                thingVo:setVisible(true)
            end
        end

        local liveVo = livething:getLiveVo()
        local modelId = liveVo:getModelID()
        local showVo = self:getBossShowVo(modelId)
        if showVo and showVo.enterMusic and showVo.enterMusic ~= "" then
            self:playMusic(showVo.enterMusic)
        end

        fight.FightCamera:checkReturnCamera()
        finishCall()
    end

    local liveVo = livething:getLiveVo()
    local modelId = liveVo:getModelID()
    local showVo = self:getBossShowVo(modelId)


    livething:getAniLenght(fight.FightDef.ACTION_NAMEs[aniHash], function(lenght)
        livething:playAction(aniHash, nil, playComplete)

        local effList = { showVo.enterEff, showVo.enter01Eff }
        local effData = effList[type + 1]

        if showVo and not table.empty(effData) then
            for i, v in ipairs(effData) do
                self:playEffTravel(liveId, 0, v, lenght)
            end
        end

        local soundList = { showVo.enterSound, showVo.enter01Sound }
        local soundData = soundList[type + 1]

        if showVo and soundData and soundData ~= "" then
            self:playSoundEff(liveId, soundData)
        end
    end)
end

-- 离场演出
function playLeave(self, liveId, finishCall)
    local livething = fight.SceneItemManager:getLivething(liveId)
    if not livething:haveClipWithHash(fight.FightDef.ACT_LEAVE) then
        finishCall()
        return
    end

    local heroDic = fight.SceneManager:getSideThingIDs(1)
    for i, id in ipairs(heroDic) do
        local thingVo = fight.SceneManager:getThing(id)
        if thingVo and not thingVo:isDead() then
            thingVo:setVisible(false)
        end
    end

    fight.FightCamera:focusOnLive(liveId)

    local function playComplete()
        local heroDic = fight.SceneManager:getSideThingIDs(1)
        for i, id in ipairs(heroDic) do
            local thingVo = fight.SceneManager:getThing(id)
            if thingVo and not thingVo:isDead() then
                thingVo:setVisible(true)
            end
        end

        fight.FightCamera:checkReturnCamera()
        finishCall()
    end

    livething:getAniLenght(fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_LEAVE], function(lenght)
        livething:playAction(fight.FightDef.ACT_LEAVE, nil, playComplete)
        local liveVo = livething:getLiveVo()
        local modelId = liveVo:getModelID()
        local showVo = self:getBossShowVo(modelId)
        if showVo and not table.empty(showVo.leaveEff) then
            for i, v in ipairs(showVo.leaveEff) do
                self:playEffTravel(liveId, showVo.leaveEffPoint[i], v, lenght)
            end
        end

        if showVo and showVo.leaveSound and showVo.leaveSound ~= "" then
            self:playSoundEff(liveId, showVo.leaveSound)
        end

        if showVo and showVo.leveaCv and showVo.leveaCv ~= "" then
            self:playCv(liveId, showVo.leveaCv)
        end
    end)
end

-- 变身演出
function playChange(self, liveId, type, finishCall)
    local aniList = { fight.FightDef.ACT_CHANGE, fight.FightDef.ACT_CHANGE_1, fight.FightDef.ACT_CHANGE_2 }
    local aniHash = aniList[type + 1]
    local livething = fight.SceneItemManager:getLivething(liveId)
    if not livething:haveClipWithHash(aniHash) then
        finishCall()
        return
    end

    fight.FightCamera:focusOnLive(liveId)

    local function playComplete()
        fight.FightCamera:checkReturnCamera()
        finishCall()
    end

    local livething = fight.SceneItemManager:getLivething(liveId)
    livething:getAniLenght(fight.FightDef.ACTION_NAMEs[aniHash], function(lenght)
        livething:playAction(aniHash, nil, playComplete)
        local liveVo = livething:getLiveVo()
        local modelId = liveVo:getModelID()
        local showVo = self:getBossShowVo(modelId)

        local effList = { showVo.changeEff, showVo.change01Eff, showVo.change02Eff }
        local effData = effList[type + 1]

        if showVo and effData and not table.empty(effData) then
            for i, v in ipairs(effData) do
                self:playEffTravel(liveId, 0, v, lenght)
            end
        end

        local soundList = { showVo.changeSound, showVo.change01Sound, showVo.change02Sound }
        local soundData = soundList[type + 1]

        if showVo and soundData and soundData ~= "" then
            self:playSoundEff(liveId, soundData)
        end
    end)
end

-- 播放演出特效
function playEffTravel(self, liveId, point, effName, lenght)
    lenght = (lenght and lenght > 0) and lenght or 6
    local travel = STravelFactory:travel02(nil, 3, liveId, 0)
    local eftName = UrlManager:getEfxBossPath(effName)
    travel:setPerfData(eftName, nil, lenght)
    travel:setSimplePoint(point)
    travel:start()
    table.insert(self.m_travelDict, travel.mc_sn)
end

-- 播放CV
function playCv(self, liveId, soundName)
    AudioManager:playCvByCVPath(UrlManager:getCVSoundPath(soundName))
end

-- 播放bgm
function playMusic(self, musicId)
    AudioManager:playMusicById(musicId)
end

-- 播放音效
function playSoundEff(self, liveId, soundName)
    local livething = fight.SceneItemManager:getLivething(liveId)
    local liveVo = livething:getLiveVo()
    AudioManager:playFightSoundEffect(UrlManager:getFightSoundPath(soundName), false, liveVo:getCurPos())
end

function stopStandby(self, liveId)
    -- 移除特效
    for _, key in pairs(self.m_travelDict) do
        STravelHandle:endTravel(key)
    end
    self.m_travelDict = {}
    AudioManager:stopAllFightSoundEffect()
    PostHandler:resetChromatic()

    local livething = fight.SceneItemManager:getLivething(liveId)
    -- 恢复事件帧隐藏的场景
    if livething then
        livething:resetEnvironment()
    end
end


----------------------------------------------------------------------

-- 特效列表做预加载
function getPerLoadEffList(self, modelId)
    local showVo = self:getBossShowVo(modelId)
    local list = {}
    if showVo and not table.empty(showVo.changeEff) then
        for i, v in ipairs(showVo.changeEff) do
            table.insert(list, self:getEffPath(v))
        end
    end
    if showVo and not table.empty(showVo.change02Eff) then
        for i, v in ipairs(showVo.change02Eff) do
            table.insert(list, self:getEffPath(v))
        end
    end
    if showVo and not table.empty(showVo.leaveEff) then
        for i, v in ipairs(showVo.leaveEff) do
            table.insert(list, self:getEffPath(v))
        end
    end
    if showVo and not table.empty(showVo.enterEff) then
        for i, v in ipairs(showVo.enterEff) do
            table.insert(list, self:getEffPath(v))
        end
    end
    if showVo and not table.empty(showVo.enter01Eff) then
        for i, v in ipairs(showVo.enter01Eff) do
            table.insert(list, self:getEffPath(v))
        end
    end
    if showVo and not table.empty(showVo.standbyEff) then
        for i, v in ipairs(showVo.standbyEff) do
            table.insert(list, self:getEffPath(v))
        end
    end
    return list
end

-- 取特效路径
function getEffPath(self, effName)
    if effName and effName ~= "" then
        return UrlManager:getEfxBossPath(effName)
    end
    return nil
end

-- 音效列表做预加载
function getPreLoadSoundList(self, modelId)
    local showVo = self:getBossShowVo(modelId)
    local list = {}
    if showVo and showVo.standbySound and showVo.standbySound ~= "" then
        table.insert(list, showVo.standbySound)
    end
    if showVo and showVo.leaveSound and showVo.leaveSound ~= "" then
        table.insert(list, showVo.leaveSound)
    end
    if showVo and showVo.enterSound and showVo.enterSound ~= "" then
        table.insert(list, showVo.enterSound)
    end
    if showVo and showVo.enter01Sound and showVo.enter01Sound ~= "" then
        table.insert(list, showVo.enter01Sound)
    end
    if showVo and showVo.changeSound and showVo.changeSound ~= "" then
        table.insert(list, showVo.changeSound)
    end
    if showVo and showVo.change02Sound and showVo.change02Sound ~= "" then
        table.insert(list, showVo.change02Sound)
    end
    return list
end

return _M