module('fight.FightLoader', Class.impl())

function ctor(self)
    self.m_alwaysEftDic = nil
    self:_parseAlwaysEftData()

    self.m_fightCacheLst = {}
end

-- 初始化配置表
function _parseAlwaysEftData(self)
    self.m_alwaysEftDic = {}
    local baseData = RefMgr:getData('always_effect_data')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(fight.AlwaysEffectDataRo)
        ro:parseData(key, data)
        self.m_alwaysEftDic[key] = ro
    end
end

function alwayEftRos(self)
    if self.m_alwaysEftDic == nil then
        self:_parseAlwaysEftData()
    end
    return self.m_alwaysEftDic
end

function getAlwayEftRo(self, modelpath)
    local arr = string.split(modelpath, "/")
    local alwayKey = arr[#arr]
    -- local key = string.getFileName(modelpath)
    local dic = self:alwayEftRos()
    -- if dic[key] == nil then
    --     -- Debug:log_error("FightLoader", "常驻特效 不存在modelpath: " .. tostring(key))
    --     return
    -- end
    return dic[alwayKey]
end


-- 进场加载镜头
function loadEnterSceneAll(self, finishCall)
    --print("loadEnterSceneAll======")
    fight.FightCamera:focusOrg()

    for liveID, thing in pairs(fight.SceneItemManager:getAllLiveThing()) do
        local liveVo = fight.SceneManager:getThing(liveID)
        if liveVo and not liveVo:isDead() and liveVo:getRaceVo().monType == monster.MonsterType.SUPER_BOSS then
            fight.SceneItemManager:playBossGoinShow(finishCall)
            return
        end
    end

    local animPath = UrlManager:getFightCameraAniPath("goin.anim")
    fight.SceneGrid:playCameraAni(animPath)
    local function _toPlayGoin()
        fight.SceneItemManager:playGoin(finishCall)
    end
    RateLooper:setTimeout(0.3, self, _toPlayGoin)
end

function loadEnterSceneSide(self, side, finishCall)
    local animPath = UrlManager:getFightCameraAniPath("goin.anim")
    local function _loadCameraFinishCall()
        fight.FightCamera:focusOrg()
        fight.FightCamera:playCameraAni(false, animPath)
        local function _toPlayGoin()
            fight.SceneItemManager:playSideGoin(side, finishCall)
        end
        RateLooper:setTimeout(0.3, self, _toPlayGoin)
    end
    gs.ResMgr:PreLoadAsyn(animPath, _loadCameraFinishCall)
end

function loadEnterSceneList(self, liveIDs, finishCall)
    -- local animPath = UrlManager:getFightCameraAniPath("goin.anim")
    -- local function _loadCameraFinishCall()
    fight.FightCamera:focusOrg()
    -- fight.FightCamera:playCameraAni(false, animPath)
    -- local function _toPlayGoin()
    fight.SceneItemManager:playGoinList(liveIDs, finishCall)
    -- end
    -- RateLooper:setTimeout(0.3, self, _toPlayGoin)
    -- end
    -- gs.ResMgr:PreLoadAsyn(animPath, _loadCameraFinishCall)
end

-- 根据表格数据 加载角色模型
function loadHeroLive(self, side, heroData, beVisible, finishCall)
    --print("loadHeroLive ===========", side, heroData.id)
    local liveVo = fight.LivethingVo.new(heroData.id, side)
    liveVo:setTID(heroData.tid, heroData.type, heroData.body_fashion_id, heroData.body_fashion_color_id)
    local gridID = heroData.pos.x * 100 + heroData.pos.y
    liveVo:setGridID00(gridID)

    liveVo:setAtt(AttConst.LV, heroData.lv)
    liveVo:setAtt(AttConst.HP, heroData.hp)
    liveVo:setAtt(AttConst.HP_MAX, heroData.max_hp)
    liveVo:setAtt(AttConst.MP, heroData.rage / 10)
    liveVo:setAtt(AttConst.MP_MAX, fight.FightManager:getMaxRage())
    liveVo:setAtt(AttConst.SKILL_SOUL, heroData.skill_soul)
    liveVo:setAtt(AttConst.STUN, heroData.hit_stun)
    liveVo:setAtt(AttConst.STUN_MAX, heroData.max_hit_stun)
    fight.SceneManager:addThing(liveVo)
    self:loadLiveModel(liveVo, beVisible, finishCall)

    -- if (liveVo:isAttacker()==1) then
    --     print("loadHeroLive", heroData.rage/10)
    -- end
end

-- 根据表格数据对象 加载角色模型
function loadLiveModel(self, liveVo, beVisible, finishCall)
    local function _animatLoadFinish()
        self:loadHeroBuffEffRes(liveVo, finishCall)
        -- finishCall()
    end

    local function _liveLoadFinishCall(beSuccess, live)
        if beSuccess then
            local vo = live:getLiveVo()
            -- 位置
            local gridID = vo:getGridID()
            local pos = fight.SceneGrid:getPos(vo:isAttacker(), gridID)
            vo:updatePosition(pos)
            -- live:setToParent(fight.SceneGrid:getRootTrans())
            -- live:setDisplayLayer("Role")
            live:setDisplayLayer("HideLayer")
            live:setVisible(beVisible, true)
            live:setPreLoadAnis({ "stand", "ready", "exit", "goin", "atk01", "die", "hit01", "hit02", "hit03", "hit04", "hit05", "hit06", "getup", "skill01", "skill02", "skill03", "skillmix", "skillmax", "win", "standby", "leave", "enter", "enter01", "change", "change01", "change02", "dizzy", "berserk" }, _animatLoadFinish)

        else
            finishCall()
        end
    end

    fight.SceneItemManager:addLivething(liveVo, _liveLoadFinishCall)
end

-- 加载额外英雄的模型列表
function loadExtraHeroModelList(self, tidList, finishCall)
    if tidList == nil or #tidList == 0 then
        if finishCall then finishCall() end
        return;
    end

    local copyTidList = {}
    for i, v in ipairs(tidList) do
        copyTidList[i] = tidList[i];
    end

    tidList = copyTidList;
    local _modelLoadFinish = nil
    local function _modelResultCall(res)
        _modelLoadFinish()
    end
    _modelLoadFinish = function()
        local tid = tidList[1]
        if tid then
            table.remove(tidList, 1)
            self:loadExtraHeroModel(tid, _modelResultCall);
        else
            if finishCall then finishCall() end
        end
    end
    _modelLoadFinish()
end

-- 加载额外英雄的模型（额外英雄其实是monster配置, 但是带上的是character的model id）
function loadExtraHeroModel(self, tid, finishCall)
    local liveVo = fight.LivethingVo.new(0, 1)
    liveVo:setTID(tid, 1)

    local function _animatLoadFinish()
        self:_loadLiveEffRes(liveVo, finishCall)
    end

    local preloadList = {}
    local modelID = liveVo:getModelID();
    local mVo = monster.MonsterManager:getMonsterVo01(tid)
    if mVo and mVo.type == 3 then
        -- 战员型
        local animStates = { "stand", "ready", "exit", "goin", "atk01", "die", "hit01", "hit02", "hit03", "hit04", "hit05", "hit06", "getup", "skill01", "skill02", "skill03", "skillmix", "skillmax", "win", "standby", "leave", "enter", "enter01", "change", "change01", "change02", "dizzy", "berserk" }
        for i, s in ipairs(animStates) do
            local animUrl = string.format("arts/character/animat/role_fight/%s/%s.anim", modelID, s)
            preloadList[#preloadList + 1] = animUrl
        end
    else
        local animStates = { "stand", "ready", "exit", "goin", "atk01", "die", "hit01", "hit02", "hit03", "hit04", "hit05", "hit06", "getup", "skill01", "skill02", "skill03", "skillmix", "skillmax", "win", "standby", "leave", "enter", "enter01", "change", "change01", "change02", "dizzy", "berserk" }
        for i, s in ipairs(animStates) do
            local animUrl = string.format("arts/character/animat/monster/%s/%s.anim", modelID, s)
            preloadList[#preloadList + 1] = animUrl
        end
    end

    local _resourceLoadFinish = nil
    local function _resourceResultCall(res)
        _resourceLoadFinish()
    end
    _resourceLoadFinish = function()
        local path = preloadList[1]
        if path then
            table.remove(preloadList, 1)
            gs.ResMgr:PreLoadAsyn(path, _resourceResultCall)
        else
            _animatLoadFinish()
        end
    end

    -- _resourceLoadFinish()
    -- local function _liveLoadFinishCall(beSuccess, live)
    --     local vo = live:getLiveVo()
    --     vo:updatePosition(gs.Vector3(1000, 1000, 1000))
    --     live:setDisplayLayer("HideLayer")
    --     live:setVisible(false, true)
    --     _resourceLoadFinish()
    -- end

    -- fight.SceneItemManager:addLivething(liveVo, _liveLoadFinishCall)
    gs.ResMgr:LoadAysn(liveVo:getPrefabName(), _resourceLoadFinish)


end


-- 预加载战斗需要的资源
function loadSceneCommonResource(self, finishCallback)
    local preloadList = {}

    -- fight ui preload
    -- local uiSprites = fightUI.FightUI.getFightUIPreloadSprites();
    -- for i, surl in ipairs(uiSprites) do
    --     gs.ResMgr:PreLoadSprite(surl)
    -- end

    local uiPathes = fightUI.FightUI.getFightUIPreloadPrefabs();
    for i, url in ipairs(uiPathes) do
        preloadList[#preloadList + 1] = url
    end

    -- scene music 
    if fight.SceneManager and fight.SceneManager.m_sceneMusicID and fight.SceneManager.m_sceneMusicID > 0 then
        local data = AudioManager:getMusicConfig(fight.SceneManager.m_sceneMusicID)
        if data then
            local url = UrlManager:getMusicPath(data.voice);
            preloadList[#preloadList + 1] = url
        end
    end

    -- fly animations 
    local flyAnimationUrls = fightUI.FightFlyUtil:getAllFlyAnimations();
    for i, url in ipairs(flyAnimationUrls) do
        preloadList[#preloadList + 1] = url
    end

    local function _syncFinish()
        -- cache fly animation items 
        fightUI.FightFlyUtil:preloadItem(3)
    end

    local _resourceLoadFinish = nil
    local function _resourceResultCall(res)
        _resourceLoadFinish()
    end
    _resourceLoadFinish = function()
        local path = preloadList[1]
        if path then
            table.remove(preloadList, 1)
            gs.ResMgr:PreLoadAsyn(path, _resourceResultCall)
        else
            _syncFinish()
            if finishCallback then finishCallback() end
        end
    end
    _resourceLoadFinish()
end

function _loadLiveEffRes(self, liveVo, finishCall)
    -- 镜头动画
    local modelID = liveVo:getModelID()
    local cameraTmpUrlLst = { "_atk01.anim", "_skill01.anim", "_skill02.anim" }
    for _, url in ipairs(cameraTmpUrlLst) do
        local cameraAniUrl = UrlManager:getFightCameraAniPath(modelID .. url)
        local clip = gs.ResMgr:Load(cameraAniUrl)
        if clip then
            fight.SceneGrid.m_cameraAni:AddClip(clip, cameraAniUrl)
        end
    end

    if fight.FightManager.m_gmOpenEft == true then
        if finishCall then finishCall() return end
        return
    end
    local raceType = liveVo:getRaceType()
    local raceVo = liveVo:getRaceVo()
    local preLoadDict = {}
    local preLoadSpriteDict = {}
    local preloadEffect = {}


    if raceType == 0 then
        preLoadSpriteDict[UrlManager:getHeroHeadUrlByModel(modelID)] = true
        preLoadSpriteDict[UrlManager:getHeroHeadShadow(modelID)] = true
        preLoadSpriteDict[UrlManager:getFormationHeadUrl(modelID)] = true
    else
        preLoadSpriteDict[UrlManager:getIconPath(raceVo.head)] = true
        preLoadSpriteDict[UrlManager:getIconPath(raceVo.shadowHead)] = true
        preLoadSpriteDict[UrlManager:getFormationHeadUrl(raceVo:getShowModelld())] = true
    end

    local livePerformEffList = fight.LivePerformManager:getPerLoadEffList(modelID)
    for i, effPath in ipairs(livePerformEffList) do
        preLoadDict[effPath] = true
        preloadEffect[effPath] = true
    end

    local livePerformSoundList = fight.LivePerformManager:getPreLoadSoundList(modelID)
    for i, soundPath in ipairs(livePerformSoundList) do
        preLoadDict[soundPath] = true
    end

    -- 战员可能用到的所有有特效的buff
    -- if raceVo.involveBuff and #raceVo.involveBuff > 0 then
    --     for i, buffId in ipairs(raceVo.involveBuff) do
    --         local buffRo = Buff.BuffRoMgr:getBuffRo(buffId)
    --         local eftArr = buffRo:getHangStand()
    --         if not table.empty(eftArr) then
    --             for i, eftName in ipairs(eftArr) do
    --                 preLoadDict[UrlManager:get3DBuffPath(eftName)] = true
    --                 preloadEffect[UrlManager:get3DBuffPath(eftName)] = true
    --             end
    --         end
    --         eftArr = buffRo:getHangBody()
    --         if not table.empty(eftArr) then
    --             for i, eftName in ipairs(eftArr) do
    --                 preLoadDict[UrlManager:get3DBuffPath(eftName)] = true
    --                 preloadEffect[UrlManager:get3DBuffPath(eftName)] = true
    --             end
    --         end
    --         eftArr = buffRo:getHangHead()
    --         if not table.empty(eftArr) then
    --             for i, eftName in ipairs(eftArr) do
    --                 preLoadDict[UrlManager:get3DBuffPath(eftName)] = true
    --                 preloadEffect[UrlManager:get3DBuffPath(eftName)] = true
    --             end
    --         end
    --         eftArr = buffRo:getHangWeapon()
    --         if not table.empty(eftArr) then
    --             for i, eftName in ipairs(eftArr) do
    --                 preLoadDict[UrlManager:get3DBuffPath(eftName)] = true
    --                 preloadEffect[UrlManager:get3DBuffPath(eftName)] = true
    --             end
    --         end
    --     end
    -- end


    -- local quality = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.effect)
    -- if not quality then
    --     quality = 3
    -- end

    -- preLoadDict[UrlManager:getFightCameraAniPath(modelID.."_atk01.anim")] = true
    if not table.empty(liveVo.m_skillList) then
        for _, v in ipairs(liveVo.m_skillList) do
            local skillRo = fight.SkillManager:getSkillRo(v)
            if skillRo then
                local cvID = skillRo:getVoice()
                if cvID and cvID > 0 then
                    local data = AudioManager:getCVData(cvID)
                    preLoadDict[UrlManager:getCVSoundPath(data.voice)] = true
                end
                local icon = skillRo:getIcon()
                if icon then
                    preLoadSpriteDict[UrlManager:getIconPath("skill/" .. icon)] = true
                end
                local editRo = fight.SkillManager:getSkillEditDataRo01(modelID, skillRo:getAnimation())
                if editRo then
                    -- 技能特效
                    local eft = editRo:getEft()
                    if eft then
                        for _, e in ipairs(eft) do
                            -- if not e.playLv or e.playLv == quality then
                            preLoadDict[UrlManager:getEfxRolePath(e.eftName)] = true
                            preloadEffect[UrlManager:getEfxRolePath(e.eftName)] = true
                            -- end
                        end
                    end
                    -- 音效
                    local audios = editRo:getAudio()
                    if audios then
                        for _, ae in ipairs(audios) do
                            if ae.sound and #ae.sound > 0 then
                                preLoadDict[UrlManager:getFightSoundPath(ae.sound)] = true
                            end
                        end
                    end
                end
            end
        end
    end

    local spriteLst = table.keys(preLoadSpriteDict)
    for i, surl in ipairs(spriteLst) do
        gs.ResMgr:PreLoadSprite(surl)
    end

    -- TimeUtil:startTime()
    local _prefabLoadFinish = nil
    local preLoadLst = table.keys(preLoadDict)
    local function _prefabResultCall(go, prefabPath)
        if go ~= nil and not gs.GoUtil.IsGoNull(go) then
            local isEffect = preloadEffect[prefabPath]
            if isEffect then
                --去掉延时，避免在这个过程中清理场景，无法回收
                LoopManager:addTimer(0.1, 1, self, function()
                    if not gs.GoUtil.IsGoNull(go) then
                        go:SetActive(false)
                    end
                end)
                gs.GOPoolMgr:Recover(go, prefabPath)
            else
                go:SetActive(false)
                gs.GOPoolMgr:Recover(go, prefabPath)
            end
        end
        _prefabLoadFinish()
    end
    _prefabLoadFinish = function()
        local path = preLoadLst[1]
        if path then
            table.remove(preLoadLst, 1)
            gs.GOPoolMgr:GetAsyc(path, _prefabResultCall, path)
        else
            if finishCall then finishCall() end
        end
    end
    _prefabLoadFinish()
    -- gs.ResMgr:PreLoadListAsyn(preLoadLst, _animatLoadFinish)
end

-- 预加载战员buff特效资源
function loadHeroBuffEffRes(self, liveVo, finishCall)
    local raceType = liveVo:getRaceType()
    local raceVo = liveVo:getRaceVo()
    local preLoadDict = {}

    -- 战员可能用到的所有有特效的buff
    if raceVo.involveBuff and #raceVo.involveBuff > 0 then
        for i, buffId in ipairs(raceVo.involveBuff) do
            local buffRo = Buff.BuffRoMgr:getBuffRo(buffId)
            local eftArr = buffRo:getHangStand()
            if not table.empty(eftArr) then
                for i, eftName in ipairs(eftArr) do
                    preLoadDict[UrlManager:get3DBuffPath(eftName)] = true
                end
            end
            eftArr = buffRo:getHangBody()
            if not table.empty(eftArr) then
                for i, eftName in ipairs(eftArr) do
                    preLoadDict[UrlManager:get3DBuffPath(eftName)] = true
                end
            end
            eftArr = buffRo:getHangHead()
            if not table.empty(eftArr) then
                for i, eftName in ipairs(eftArr) do
                    preLoadDict[UrlManager:get3DBuffPath(eftName)] = true
                end
            end
            eftArr = buffRo:getHangWeapon()
            if not table.empty(eftArr) then
                for i, eftName in ipairs(eftArr) do
                    preLoadDict[UrlManager:get3DBuffPath(eftName)] = true
                end
            end
        end
    end

    local _prefabLoadFinish = nil
    local preLoadLst = table.keys(preLoadDict)
    local function _prefabResultCall(go, prefabPath)
        if go ~= nil and not gs.GoUtil.IsGoNull(go) then
            LoopManager:addTimer(0.1, 1, self, function()
                if not gs.GoUtil.IsGoNull(go) then
                    go:SetActive(false)
                end
            end)
            gs.GOPoolMgr:Recover(go, prefabPath)

        end
        _prefabLoadFinish()
    end
    _prefabLoadFinish = function()
        local path = preLoadLst[1]
        if path then
            table.remove(preLoadLst, 1)
            gs.GOPoolMgr:GetAsyc(path, _prefabResultCall, path)
        else
            if finishCall then finishCall() end
        end
    end
    _prefabLoadFinish()
end

function inFightingLoad(self)

end

function _loadLazyCall(go, path)
    if go then
        go:SetActive(false)
        -- print("_loadLazyCall============== ", path)
        gs.GOPoolMgr:Recover(go, path)
    end
end

function _updateLoad(self)
    if not table.empty(self.m_fightCacheLst) then
        local path = self.m_fightCacheLst[1]
        if path then
            table.remove(self.m_fightCacheLst, 1)
            gs.GOPoolMgr:GetAsyc(path, self._loadLazyCall, path)
            return
        end
    end
    LoopManager:removeTimerByIndex(self.m_updateLoadSn)
    self.m_updateLoadSn = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]