-- 非战斗专用
module("fight.LiveView", Class.impl(model.modelLive))

local AUTO_PLAY_INTERVAL = 15
local PER_FRAME_SEC = 1 / 30
-- local BOX_CENTER = gs.Vector3(0,0.9,0)
-- local BOX_SIZE = gs.Vector3(1,1.8,1)

function ctor(self)
    super.ctor(self)
    self.m_modeID = nil
    self.m_uiPrefabPath = nil
    self.m_startAutoPlayTime = 0
end

-- function onAwake(self)
--     super.onAwake(self)
--     self:removeStartEndCall(self.m_aniStartSn)
--     local function _idleStartCall()
--         self:startPlayAuto()
--     end
--     self.m_aniStartSn = self:setupAniStartEndCall(self.m_alwayActHash, _idleStartCall)
-- end

function destroy(self)
    self:destroyTimeSn()
    GameDispatcher:removeEventListener(EventName.UPDATE_LIVEVIEWUPDATEACTION, self.setupClickPlayList, self)
    self:removeStartEndCall(self.m_aniStartSn)
    self.m_aniStartSn = nil
    if self.waterFallPrefab then
        gs.GameObject.Destroy(self.waterFallPrefab)
    end

    super.destroy(self)
end

-- 通过战员ID设置模型(需要显示时装的请使用本接口)
function setHeroId(self, heroId, beAlwayEft, showWeaponSn, finishCall)
    self.heroId = heroId
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    if heroVo then
        self:setModelID(0, heroVo:getUIModel(), beAlwayEft, showWeaponSn, finishCall)
    end
end

-- 设置英雄模版属性
-- tType 角色-0, 怪物-1
-- beAlwayEft : 是否开启常驻特效
-- showWeaponSn : 戴武器序号 (不带武器可填nil, 现在只有一把武器, 要带武器时请填1)
function setTID(self, heroId, heroType, beAlwayEft, showWeaponSn, finishCall)
    self.heroId = heroId
    self.m_raceType = heroType
    if heroType == 0 then
        local hVo = hero.HeroManager:getHeroConfigVo(heroId)
        if hVo then
            self:setModelID(0, hVo:getUIModel(), beAlwayEft, showWeaponSn, finishCall)
            return
        end
    elseif heroType == 1 then
        local mVo = monster.MonsterManager:getMonsterVo01(heroId)
        if mVo then
            -- 战员型
            if mVo.type == 3 then
                self:setModelID(0, mVo.model, beAlwayEft, showWeaponSn, finishCall)
            else
                self:setModelID(1, mVo.model, beAlwayEft, showWeaponSn, finishCall)
            end
            return
        end
        -- elseif heroType == 2 then --NPC 目前按照战员相同处理
        --     local hVo = hero.HeroManager:getHeroConfigVo(heroId)
        --     if hVo then
        --         self:setModelID(0, hVo:getHeroModel(), beAlwayEft, showWeaponSn, finishCall)
        --         return
        --     end
    end
    logError("heroId = [" .. tostring(heroId) .. "] 没有数据")
    self:setModelID(0, 1102, beAlwayEft, showWeaponSn, finishCall)
end

function setModelID(self, raceType, modelID, beAlwayEft, showWeaponSn, finishCall)
    self.m_LoadingFinishCall = finishCall

    self.m_modeID = modelID
    local prefabPath = nil
    if raceType == 0 then
        prefabPath = UrlManager:getRolePath01(modelID)
    elseif raceType == 1 then
        prefabPath = UrlManager:getMonsterPath01(modelID)
    else
        prefabPath = UrlManager:getNPCPath01(modelID)
    end
    if self.m_uiPrefabPath ~= prefabPath then
        self:removeWeapon()
        self:setPrefab(prefabPath, beAlwayEft)
        self.m_uiPrefabPath = prefabPath
        self.m_uiShowWeaponSn = -1
    else
        if finishCall then
            finishCall(true, self)
        end
    end
    self.m_uiShowWeaponSn = showWeaponSn
end

function setPrefab(self, prefabPath, beAlwayEft, finishCall)
    self:setModelLodEnable(false)
    self:setupPrefab(prefabPath, beAlwayEft, finishCall, 3)
end

function loadFinish(self, go, finishCall, sorceId)
    super.loadFinish(self, go, finishCall, sorceId)
    --先隐藏，开始播放默认动画的时候再显示出来
    self:setVisible(false)
    self:_setModeType()
    self:setMaterial()
end

-- 获取正式模型名(取资源)
function getModelId(self)
    return self.m_modeID
end

-- 获取基础模型名(取公共配置)
function getBaseModelId(self)
    local arr = string.split(self.m_modeID, "_")
    local baseModelId = arr[1] --切掉时装后缀
    return baseModelId
end

-- 设置模式类型
function setModeType(self, modeType, isMonster)
    self.m_roleModeType = modeType
    self.m_isMonster = isMonster
    if self.m_model == nil or self.m_loadSn ~= 0 then return end
    self:_setModeType()
end
-- 初始动作播放
function playStartAction(self)
    if self.m_startActionHash and self.m_startActionHash ~= 0 then
        self:playAction(self.m_startActionHash)
    end
end

-- 设置加载完成回调事件
function setLoadFinishCall(self, call)
    self.m_LoadingFinishCall = call
end
-- 设置出场动作完成完成回调事件
function setStartActionFinishCall(self, call)
    self.m_StartActionFinishCall = call
end

-- 设置替换的材质球
function setMaterial(self)
    local fashionColorVo = fashion.FashionManager:getFashionColorData(self:getModelId())
    if fashionColorVo then
        self:updateMaterial(fashionColorVo.posList, fashionColorVo.materials, fashionColorVo.dissolves)
    end
end

function _setModeType(self)
    if not self.m_roleModeType then return end

    self.m_startActionHash = nil
    local sRo = fight.RoleShowManager:getModeData(self.m_roleModeType)
    if sRo then
        local alwayAniName = sRo:getAlways()
        local actName = sRo:getAction()
        local playAlways = function()
            local function _call()
                self:setVisible(true)

                if self.m_LoadingFinishCall then
                    self.m_LoadingFinishCall()
                    self.m_LoadingFinishCall = nil
                end

                -- 现在版本不需要
                -- if self.m_roleModeType == MainCityConst.ROLE_MODE_OVERVIEW then
                --     self:playWaterEff()
                -- end

            end
            local function _endCall()
                if self.m_StartActionFinishCall then
                    self.m_StartActionFinishCall()
                    self.m_StartActionFinishCall = nil
                end
            end
            if actName and #actName > 0 then
                local actHash = gs.Animator.StringToHash(actName)

                self:playAction(actHash, _call, _endCall)
            else
                self.m_alwayActHash = gs.Animator.StringToHash(alwayAniName)

                if self.m_ani then
                    self.m_ani:AddNeedCallHash(self.m_alwayActHash)
                    self.m_ani:LoadClipWithHash(self.m_alwayActHash)
                end

                local function _idleStartCall()
                    self:startPlayAuto()
                end
                self:removeStartEndCall(self.m_aniStartSn)
                self.m_aniStartSn = self:setupAniStartEndCall(self.m_alwayActHash, _idleStartCall)

                self:playAction(self.m_alwayActHash, _call)
            end
        end

        --================================================================================================================
        AUTO_PLAY_INTERVAL = sRo:getRandomInterval() / 100

        local needWeapon = false
        if not self.m_isMonster then
            needWeapon = sRo:getWeapon() == 1
        end

        if needWeapon then
            local modeShowRo = fight.RoleShowManager:getShowData(self.m_modeID)
            local aniList = {}
            if actName and #actName > 0 then
                table.insert(aniList, actName)
            else
                table.insert(aniList, alwayAniName)
            end
            self:setWeaponLoadFightAni(true, aniList)

            local showWeaponSn = 1
            local wpath = UrlManager:getWeaponPath(string.format("%s_wq_%02d/model%s_wq_%02d.prefab", self.m_modeID, showWeaponSn, self.m_modeID, showWeaponSn))
            self:addWeapon(wpath, modeShowRo:getWeaponNode(), self.beAlwayEft, function()
                playAlways()
            end)
        else
            self:removeWeapon()
            playAlways()
        end

        self.m_autoActLst = {}
        local randomActions = sRo:getRandomActions()
        if randomActions and not table.empty(randomActions) then
            for _, value in ipairs(randomActions) do
                local hash = gs.Animator.StringToHash(value)
                if hero.HeroManager:isUnlockLiveAction(self.m_modeID, hash) then
                    table.insert(self.m_autoActLst, hash)
                end
            end
            self:_setupAutoPlayList()
            self:startPlayAuto()
        end

        self:setupClickPlayList()
        self.m_clickPlayCv = sRo:getIsPlayCv()
    else
        logError(string.format("==========8000表role_showmode没有%s的显示类型配置", self.m_roleModeType))
    end
end

function setupClickPlayList(self)
    local sRo = fight.RoleShowManager:getModeData(self.m_roleModeType)
    if sRo then
        self.m_clickPlayActLst = {}
        self.m_clickActLst = {}
        local playActions = sRo:getPlayActions()
        if playActions and not table.empty(playActions) then
            for _, actionName in ipairs(playActions) do
                local hash = gs.Animator.StringToHash(actionName)
                local baseData = hero.HeroInteractManager:getConfigData01(self:getBaseModelId(), self:getModelId(), actionName)
                if baseData then
                    if hero.HeroManager:isUnlockLiveAction(self:getBaseModelId(), hash) then
                        if self.m_ani then
                            self.m_ani:AddNeedCallHash(hash)
                        end
                        table.insert(self.m_clickActLst, hash)
                    end
                end
            end
        end
    end
end

function _setupAutoPlayList(self)
    self.m_autoActPlayLst = {}
    local tmpLst = table.copy(self.m_autoActLst)

    -- while( not table.empty(tmpLst) ) do
    --     local idx = math.random(1, #tmpLst)
    --     table.insert(self.m_autoActPlayLst, tmpLst[idx])
    --     table.remove(tmpLst, idx)
    -- end

    -- 临时
    self.m_autoActPlayLst = tmpLst

end

-- 点击动作播放
function playClickAction(self, actionFinishCall, startPlayCvCall, finishPlayCvCall)
    if self.m_isPlayIngClick then return end

    if table.empty(self.m_clickPlayActLst) then
        local tmpLst = table.copy(self.m_clickActLst)
        while (not table.empty(tmpLst)) do
            local idx = math.random(1, #tmpLst)
            table.insert(self.m_clickPlayActLst, tmpLst[idx])
            table.remove(tmpLst, idx)
        end
    end

    while true and not table.empty(self.m_clickPlayActLst) do
        local hash = self.m_clickPlayActLst[1]
        table.remove(self.m_clickPlayActLst, 1)
        local actionName = fight.FightDef.ACTION_NAMEs[hash]
        local baseData = hero.HeroInteractManager:getConfigData01(self:getBaseModelId(), self:getModelId(), actionName)
        if baseData then
            if self.m_ani and self.m_ani:HaveClipWithHash(hash) then
                local function _resultCall()
                    self.m_isPlayIngClick = false

                    if actionFinishCall then actionFinishCall(true) end

                    local data = AudioManager:getCVData(baseData.cv_id)
                    if data and data.voice == "" then
                        if finishPlayCvCall then finishPlayCvCall(true) end
                    end
                end

                local function _startCall()
                    local function _playCV()
                        if not self.canPlayCv then return end

                        local audioData
                        if AudioManager:preloadCvByCvId(baseData.cv_id, true) then
                            audioData = AudioManager:playHeroCVOnReplace(baseData.cv_id, finishPlayCvCall)
                        else
                            self.mTimeSn = LoopManager:setTimeout(10, nil, finishPlayCvCall) 
                        end
                        if startPlayCvCall then
                            startPlayCvCall(audioData)
                        end
                    end
                    LoopManager:setTimeout(math.max(hero.HeroInteractManager:getCvDataLayBack(baseData), 0.1), self, _playCV)
                end

                self:destroyTimeSn()
                self:playAction(hash, _startCall, _resultCall)
            end
            self.m_isPlayIngClick = true

            if self.m_clickPlayCv then
                self.canPlayCv = true
                return true, baseData
            end
        end
    end

    return false
end

--中断播放CV
function stopPlayCv(self)
    self.canPlayCv = false
end

--加载动画片段
function loadClip(self, aniHash)
    local exitTimeHash = fight.FightDef.HashExitTimeAnimation[aniHash]
    if exitTimeHash then
        self.m_ani:LoadClipWithHash(exitTimeHash)
    end
end

function playAction(self, aniHash, startCall, endCall)
    if GameManager.IS_DEBUG and StorageUtil:getString0('login_show_model_anim') == "1" then
        aniHash = fight.FightDef.ACT_SHOW_STAND
        if self.m_ani then
            self.m_ani:AddNeedCallHash(aniHash)
            self.m_ani:LoadClipWithHash(aniHash)
        end
    end

    LoopManager:clearTimeout(self.m_playAutoTimeSn)
    self.m_playAutoTimeSn = nil
    if self.m_model then
        local SmileController = self.m_model:GetComponent(ty.SmileController)
        if SmileController then
            SmileController:SetRandmonShowVal(1) --表情恢复
        end
    end
    super.playAction(self, aniHash, startCall, endCall)
end

function playFade(self, aniHash, startCall, endCall)
    if GameManager.IS_DEBUG and StorageUtil:getString0('login_show_model_anim') == "1" then
        aniHash = fight.FightDef.ACT_SHOW_STAND
        if self.m_ani then
            self.m_ani:AddNeedCallHash(aniHash)
            self.m_ani:LoadClipWithHash(aniHash)
        end
    end

    LoopManager:clearTimeout(self.m_playAutoTimeSn)
    self.m_playAutoTimeSn = nil

    if self.m_model then
        local SmileController = self.m_model:GetComponent(ty.SmileController)
        if SmileController then
            SmileController:SetRandmonShowVal(1) --表情恢复
        end
    end
    super.playFade(self, aniHash, startCall, endCall)
end

function clearModel(self)
    self.m_uiPrefabPath = nil
    self.m_uiShowWeaponSn = nil
    LoopManager:clearTimeout(self.m_playAutoTimeSn)
    self.m_playAutoTimeSn = nil
    super.clearModel(self)
end

-- 开始自动随机播放
function startPlayAuto(self)
    if GameManager.IS_DEBUG and StorageUtil:getString0('login_show_model_anim') == "1" then
        return
    end

    local curTime = os.time()
    if (curTime - self.m_startAutoPlayTime) > AUTO_PLAY_INTERVAL then
        LoopManager:clearTimeout(self.m_playAutoTimeSn)
        self.m_playAutoTimeSn = LoopManager:setTimeout(AUTO_PLAY_INTERVAL, self, self._playAutoIdle)
        self.m_startAutoPlayTime = curTime
    end
end

-- 播放攻击动作及其技能特效
function playAttActEft(self, aniHash, targetLive, endCall)
    local aniName = fight.FightDef.ACTION_NAMEs[aniHash]
    if aniName then
        if self.m_trans == nil or gs.GoUtil.IsTransNull(self.m_trans) then
            return
        end
        local stime = os.time()
        local function _startCall()
            local skillEditDataRo = fight.SkillManager:getSkillEditDataRo01(self.m_modeID, aniName)
            if skillEditDataRo then
                self:getAniLenght(aniName, function(length)
                    self:_playEftList(skillEditDataRo:getEft(), targetLive, length)
                    self:_playTargetList(skillEditDataRo:getTarget(), targetLive)
                end)
            end
        end
        self:playFade(aniHash, _startCall, endCall)
    end
end
function _afterLoad(self)
    super._afterLoad(self)

    GameDispatcher:addEventListener(EventName.UPDATE_LIVEVIEWUPDATEACTION, self.setupClickPlayList, self)
end

function _playAutoIdle(self)
    self.m_startAutoPlayTime = 0
    self.m_playAutoTimeSn = nil
    if self.m_trans == nil or gs.GoUtil.IsTransNull(self.m_trans) then
        return
    end
    if table.empty(self.m_autoActLst) then return end
    if self:isPlayHash(self.m_alwayActHash) then
        if table.empty(self.m_autoActPlayLst) then
            self:_setupAutoPlayList()
        end
        if not table.empty(self.m_autoActPlayLst) then
            self:playFade(self.m_autoActPlayLst[1])
            table.remove(self.m_autoActPlayLst, 1)
        end
    end
end

function _playEftList(self, efts, targetLive, aniLenght)
    if fight.FightManager.m_gmOpenEft == true then return end
    if table.empty(efts) then return end
    local function _eftCall(xx, eftData)
        if self.m_trans == nil or gs.GoUtil.IsTransNull(self.m_trans) then
            return
        end
        local travel = nil
        if eftData.eftType == 0 then --点放
            travel = STravelFactory:travel02(0, 3)
        elseif eftData.eftType == 1 then --电链
            travel = STravelFactory:travel02(0, 7)
        elseif eftData.eftType == 2 then --导弹集
            travel = STravelFactory:travel02(0, 8)
        end
        if travel then
            travel:setTempLive(self, targetLive)
            local eftName = UrlManager:getEfxRolePath(eftData.eftName)
            travel:setPerfData(eftName, nil, eftData.endTime, eftData)
            travel:setSimplePoint(eftData.eftPointB)
            travel:start()
        end
    end

    local quality = systemSetting.SystemSettingManager:getSystemSettingValue(systemSetting.SystemSettingDefine.effect)
    quality = math.max(quality - 1, 1)

    for _, v in ipairs(efts) do
        if v.eftName then
            if not v.playLv or v.playLv == quality then
                if not v.endTime or v.endTime == 0 then
                    v.endTime = aniLenght - v.time * PER_FRAME_SEC
                end
                LoopManager:setTimeout(v.time * PER_FRAME_SEC, nil, _eftCall, v)
            end
        end
    end
end

function _playTargetList(self, targetDatas, targetLive)
    if table.empty(targetDatas) or not targetLive then
        return
    end
    local function _hitCall(xx, hitData)
        if targetLive == nil or targetLive.m_trans == nil or gs.GoUtil.IsTransNull(self.m_trans) then
            return
        end
        self:_hitTarget(targetLive, hitData)
    end
    for _, v in ipairs(targetDatas) do
        LoopManager:setTimeout(v.time * PER_FRAME_SEC, nil, _hitCall, v)
    end
end

-- 编辑器模型下打中目标的处理
function _hitTarget(self, targetLive, hitData)
    -- 受击动作
    targetLive:playAction(hitData.hitActHash)

    -- 受击特效
    if hitData.hitEft and #hitData.hitEft > 0 then
        local travel = STravelFactory:travel02(0, 3)
        travel:setPerfData(UrlManager:getEfxRolePath(hitData.hitEft), nil, 1)
        travel:setSimplePoint(1)
        travel:setTempLive(targetLive)
        travel:start()
    end
end

local testAnis = { fight.FightDef.ACT_ATTACK_1, fight.FightDef.ACT_SKILL_1, fight.FightDef.ACT_SKILL_2 }--, fight.FightDef.ACT_SKILL_MIX, fight.FightDef.ACT_SKILL_MAX}
function playForTest(self)
    local localTestAnis = table.copy(testAnis)
    local _attFinishout = nil
    local function _attFinish()
        if gs.GoUtil.IsGoNull(self.m_model) then
            return
        end
        if table.empty(localTestAnis) then
            localTestAnis = table.copy(testAnis)
        end
        local hash = localTestAnis[1]
        table.remove(localTestAnis, 1)
        self:playAttActEft(hash, self, _attFinishout)
    end
    _attFinishout = function()
        LoopManager:setTimeout(math.random(1, 2), self, _attFinish)
    end
    -- _attFinishout()
    LoopManager:setTimeout(math.random(2, 4), self, _attFinishout)
end

function playWaterEff(self)
    self.waterFallPrefab = AssetLoader.GetGO(UrlManager:getPrefabPath("tools/WaterFallPrefab.prefab"), self)

    self.waterFallPrefab.transform:SetParent(self.m_trans)
    gs.TransQuick:LPos(self.waterFallPrefab.transform, 0, 0, 0)

    local waterCtl = self.waterFallPrefab:GetComponent(ty.DissolveBaseCtr)

    --local renders = self.m_model:GetComponentsInChildren(ty.Renderer)

    waterCtl:SetAllRenders(self.m_model)
    waterCtl:Play(nil)

    -- local len = ctrs.Length - 1

    -- for i = 0, len do
    --     ctrs[i]:Play(nil)
    -- end
end

-- 设置模型缩放
function setModelScale(self, cusScale)
    local defaultScale = 1
    if self:getModelId() and fight.RoleShowManager:getModelShowScale(self:getModelId()) then
        defaultScale = fight.RoleShowManager:getModelShowScale(self:getModelId())
        defaultScale = defaultScale > 0 and defaultScale or 1
    end
    if cusScale then
        defaultScale = defaultScale * cusScale
    end

    if self.m_modelTrans then
        gs.TransQuick:Scale0(self.m_modelTrans, defaultScale)
    end

end

function destroyTimeSn(self)
    if self.mTimeSn then
        LoopManager:clearTimeout(self.mTimeSn)
        self.mTimeSn = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]