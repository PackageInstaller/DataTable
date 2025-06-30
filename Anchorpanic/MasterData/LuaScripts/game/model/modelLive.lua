--战员模型基础类
module("model.modelLive", Class.impl(model.modelBase))

function ctor(self)
    super.ctor(self)
    -- 武器
    self.m_weaponList = {}
    -- 其它道具组件
    self.m_assemblylist = {}

    --其他道具组件路径
    self.m_assemblyPathDic = {}

    -- 记录播放的动作道具
    self.m_actShowItems = {}

    -- 动作一次性的开始事件
    self.m_aniStartDisposableCallDict = {}
    -- 动作一次性的结束事件
    self.m_aniEndDisposableCallDict = {}

    -- 动作的回调事件(持续有效)
    self.m_aniStartEndCallDict = {}

    -- 挂点的储存结构体
    self.m_points = {}

    -- 是否动作中断强制回调endCall
    self.m_isForceEndCall = {}
end

--删除
function destroy(self)
    super.destroy(self)

    self:clearStartEndCall()
end

-- 清空模型 (并不是删除! 删除请用destroy)
function clearModel(self)
    super.clearModel(self)

    self:removeWeapon()
    self:clearAssembly()
end

function loadFinish(self, go, finishCall, sorceId)
    if go then
        self.m_points[fight.FightDef.POINT_ROOT] = gs.GoUtil.FindNameInChilds(go.transform, "Root_node")
        self.m_points[fight.FightDef.POINT_TOP] = gs.GoUtil.FindNameInChilds(go.transform, "Top_node")
        self.m_points[fight.FightDef.POINT_SPINE] = gs.GoUtil.FindNameInChilds(go.transform, "Spine_node")
        self.m_points[fight.FightDef.POINT_LWEAPON] = gs.GoUtil.FindNameInChilds(go.transform, "Weapon_L_node")
        self.m_points[fight.FightDef.POINT_RWEAPON] = gs.GoUtil.FindNameInChilds(go.transform, "Weapon_R_node")
        self.m_points[fight.FightDef.POINT_CAMERA] = gs.GoUtil.FindNameInChilds(go.transform, "Camera_node")
        self.m_points[fight.FightDef.POINT_HIT] = gs.GoUtil.FindNameInChilds(go.transform, "Hit_node")
        self.m_points[fight.FightDef.POINT_HEAD] = gs.GoUtil.FindNameInChilds(go.transform, "Bip001 Head")
    end

    super.loadFinish(self, go, nil, sorceId)

    if go then
        if self.m_ani then
            self:setupAniCallSys()
        end

        if finishCall then
            finishCall(true, self)
        end

        if self.m_weaponPath and self.m_weaponType then
            local tmpWeaponPath = self.m_weaponPath
            self.m_weaponPath = nil
            self:addWeapon(tmpWeaponPath, self.m_weaponType, self.beAlwayEft, self.addFinishCall)
        end

        for assemblyKey, liveAssembly in pairs(self.m_assemblyPathDic) do
            if liveAssembly ~= false then
                self:addAssembly(assemblyKey)
            end
        end

        self:setModelScale()
    end
end

-- 设置改变材质
function updateMaterial(self, posList, mats, dissolves)
    if not self.m_modelMaterials or gs.GoUtil.IsCompNull(self.m_modelMaterials) then
        return
    end
    local matList = {}
    for i, matName in ipairs(mats) do
        local mat = gs.ResMgr:Load("arts/character/role/" .. self:getModelId() .. "/mats/" .. matName .. ".mat")
        mat = gs.GameObject.Instantiate(mat)
        table.insert(matList, mat)
    end

    if not table.empty(matList) then
        self.m_modelMaterials:ChangeMaterial(posList, matList)
    end
    local seed = math.random(0, 1000) / 10000
    local num = math.random(-seed, seed)
    if not table.empty(dissolves) then
        self.m_modelMaterials.DissolveValue0 = dissolves[1] + num
        self.m_modelMaterials.DissolveValue1 = dissolves[2] + num
        self.m_modelMaterials.DissolveValue2 = dissolves[3] + num
        self.m_modelMaterials.DissolveValue3 = dissolves[4] + num
        self.m_modelMaterials.DissolveValue4 = dissolves[5] + num
        self.m_modelMaterials.DissolveValue5 = dissolves[6] + num
    end
end

-- 播放动作
-- startCall, endCall为一次性事件
function playAction(self, aniHash, startCall, endCall, isForceEndCall)
    if not self.m_ani then return end

    self:setupOneCall(aniHash, startCall, endCall)
    self.m_curAniHash = aniHash --用于外部获取记录

    if isForceEndCall then
        self.m_isForceEndCall[aniHash] = endCall --是否需要动作中断也强制回调endcall
    else
        self.m_isForceEndCall[aniHash] = nil
    end

    local function play()
        if (startCall or endCall) and not self.m_ani:HaveClipWithHash(aniHash) then
            self.m_aniStartDisposableCallDict[aniHash] = nil
            self.m_aniEndDisposableCallDict[aniHash] = nil
            if startCall then startCall(aniHash) end
            if endCall then endCall(aniHash) end
        end

        local exitTimeHash = fight.FightDef.HashExitTimeAnimation[aniHash]
        if exitTimeHash then
            self:LoadClipWithHash(exitTimeHash)
        end
        local layerIndex = fight.FightDef.ANI_BELONG_LAYER[aniHash]
        layerIndex = layerIndex or 0

        local loadCount = 0
        local function selfPlay()
            if not self.m_ani then return end

            if loadCount <= 0 then
                self.m_ani:PlayHash(aniHash, function()
                    for _, weapon in ipairs(self.m_weaponList) do
                        weapon:playAction(aniHash)
                    end
                    for _, liveAssembly in ipairs(self.m_assemblylist) do
                        liveAssembly:playAction(aniHash)
                    end
                end, layerIndex)
            end
        end
        local function loadFinishCall()
            loadCount = loadCount - 1
            selfPlay()
        end

        loadCount = loadCount + #self.m_weaponList
        for _, weapon in ipairs(self.m_weaponList) do
            weapon:LoadClipWithHash(aniHash, loadFinishCall)
        end

        loadCount = loadCount + #self.m_assemblylist
        for _, liveAssembly in ipairs(self.m_assemblylist) do
            liveAssembly:LoadClipWithHash(aniHash, loadFinishCall)
        end

        selfPlay()
    end

    if not self:needAddShowItem(aniHash) then
        play()
    else
        self:playShowItem(aniHash, play)
    end
end

-- 播放动作带过渡
-- startCall, endCall为一次性事件
function playFade(self, aniHash, startCall, endCall, isForceEndCall)
    if not self.m_ani then return end

    self.m_curAniHash = aniHash --用于外部获取记录
    self:setupOneCall(aniHash, startCall, endCall)

    if isForceEndCall then
        self.m_isForceEndCall[aniHash] = endCall --是否需要动作中断也强制回调endcall
    else
        self.m_isForceEndCall[aniHash] = nil
    end

    local function play()
        if (startCall or endCall) and not self.m_ani:HaveClipWithHash(aniHash) then
            self.m_aniStartDisposableCallDict[aniHash] = nil
            self.m_aniEndDisposableCallDict[aniHash] = nil
            if startCall then startCall(aniHash) end
            if endCall then endCall(aniHash) end
        end

        local exitTimeHash = fight.FightDef.HashExitTimeAnimation[aniHash]
        if exitTimeHash then
            self:LoadClipWithHash(exitTimeHash)
        end

        local loadCount = 0
        local function selfPlay()
            if loadCount <= 0 then
                if not self.m_ani then return end
                self.m_ani:PlayFadeHash(aniHash, 0.1, function()
                    for _, weapon in ipairs(self.m_weaponList) do
                        weapon:playFade(aniHash)
                    end
                    for _, liveAssembly in ipairs(self.m_assemblylist) do
                        liveAssembly:playFade(aniHash)
                    end
                end)
            end
        end
        local function loadFinishCall()
            loadCount = loadCount - 1
            selfPlay()
        end

        loadCount = loadCount + #self.m_weaponList
        for _, weapon in ipairs(self.m_weaponList) do
            weapon:LoadClipWithHash(aniHash, loadFinishCall)
        end

        loadCount = loadCount + #self.m_assemblylist
        for _, liveAssembly in ipairs(self.m_assemblylist) do
            liveAssembly:LoadClipWithHash(aniHash, loadFinishCall)
        end

        selfPlay()
    end

    if not self:needAddShowItem(aniHash) then
        play()
    else
        self:playShowItem(aniHash, play)
    end
end

-- 通过触发器来播放动作
-- startCall, endCall为一次性事件
function playActionTrigger(self, triggerHash, startCall, endCall, resetTriggerHash, isForceEndCall)
    if not self.m_ani then return end

    local aniHash = self:getActionHashByTriggerHash(triggerHash)
    if aniHash ~= nil then
        self:setupOneCall(aniHash, startCall, endCall)
        self.m_curAniHash = aniHash --用于外部获取记录

        if isForceEndCall then
            self.m_isForceEndCall[aniHash] = endCall --是否需要动作中断也强制回调endcall
        else
            self.m_isForceEndCall[aniHash] = nil
        end

        local function play()
            if (startCall or endCall) and not self.m_ani:HaveClipWithHash(aniHash) then
                self.m_aniStartDisposableCallDict[aniHash] = nil
                self.m_aniEndDisposableCallDict[aniHash] = nil
                if startCall then startCall(aniHash) end
                if endCall then endCall(aniHash) end
            end

            local exitTimeHash = fight.FightDef.HashExitTimeAnimation[aniHash]
            if exitTimeHash then
                self:LoadClipWithHash(exitTimeHash)
            end

            if (resetTriggerHash) then
                self.m_ani:ResetTriggers(resetTriggerHash)
            end

            local loadCount = 0
            local function selfPlay()
                if loadCount <= 0 then
                    self.m_ani:PlayTriggerCond(triggerHash, function()
                        for _, weapon in ipairs(self.m_weaponList) do
                            weapon:playActionTrigger(triggerHash)
                        end
                        for _, liveAssembly in ipairs(self.m_assemblylist) do
                            liveAssembly:playActionTrigger(triggerHash)
                        end
                    end)
                end
            end
            local function loadFinishCall()
                loadCount = loadCount - 1
                selfPlay()
            end

            loadCount = loadCount + #self.m_weaponList
            for _, weapon in ipairs(self.m_weaponList) do
                weapon:LoadClipWithHash(aniHash, loadFinishCall)
            end

            loadCount = loadCount + #self.m_assemblylist
            for _, liveAssembly in ipairs(self.m_assemblylist) do
                liveAssembly:LoadClipWithHash(aniHash, loadFinishCall)
            end

            selfPlay()
        end

        if not self:needAddShowItem(aniHash) then
            play()
        else
            self:playShowItem(aniHash, play)
        end
    end
end

-- 设置动作过渡布尔值
function setAnimationBoolVal(self, keyhash, val)
    if self.m_loadSn == 0 and self.m_ani then
        local aniHash = self:getActionHashByTriggerHash(keyhash)
        if aniHash then
            local function play()
                for _, v in ipairs(self.m_weaponList) do
                    v:setAnimationBoolVal(keyhash, val)
                end
                for _, liveAssembly in pairs(self.m_assemblylist) do
                    liveAssembly:setAnimationBoolVal(keyhash, val)
                end

                super.setAnimationTriggerVal(self, keyhash)
            end
            if not self:needAddShowItem(aniHash) then
                play()
            else
                self:playShowItem(aniHash, play)
            end
        end
    end
end

-- 设置动作过渡触发值
function setAnimationTriggerVal(self, keyhash)
    if self.m_loadSn == 0 and self.m_ani then
        local function play()
            for _, v in ipairs(self.m_weaponList) do
                v:setAnimationTriggerVal(keyhash)
            end
            for _, liveAssembly in pairs(self.m_assemblylist) do
                liveAssembly:setAnimationTriggerVal(keyhash)
            end

            super.setAnimationTriggerVal(self, keyhash)
        end

        local aniHash = self:getActionHashByTriggerHash(keyhash)
        if aniHash then
            if not self:needAddShowItem(aniHash) then
                play()
            else
                self:playShowItem(aniHash, play)
            end
        end
    end
end

-- 删除武器
function removeWeapon(self)
    for _, v in ipairs(self.m_weaponList) do
        LoopManager:clearTimeout(v.s_loadPlaySn)
        v:destroy()
    end
    self.m_weaponList = {}
    self.m_points[fight.FightDef.POINT_RFIRE] = nil
    self.m_points[fight.FightDef.POINT_LFIRE] = nil
    self.m_weaponPath = nil
    self.m_weaponType = nil
    self.addFinishCall = nil
end

function getWeapon(self)
    return self.m_weaponList
end
-- 装载武器
function addWeapon(self, weaponPath, weaponType, beAlwayEft, finishCall)
    if self.m_weaponPath == weaponPath and self.m_weaponType == weaponType then return end

    self.m_weaponPath = weaponPath
    self.m_weaponType = weaponType
    self.addFinishCall = finishCall

    if self.m_model == nil or self.m_loadSn ~= 0 then return end

    self:removeWeapon()

    -- 放右手
    if weaponType == 1 then
        if not self.m_points[fight.FightDef.POINT_RWEAPON] then
            logError("站员模型挂点丢失 Weapon_R_node prefabName=" .. self.m_prefabName)
        end
        self:_addWeapon(weaponPath, self.m_points[fight.FightDef.POINT_RWEAPON], beAlwayEft, finishCall)
        -- 放脚底
    elseif weaponType == 2 then
        if not self.m_points[fight.FightDef.POINT_ROOT] then
            logError("站员模型挂点丢失 Root_node prefabName=" .. self.m_prefabName)
        end
        self:_addWeapon(weaponPath, self.m_points[fight.FightDef.POINT_ROOT], beAlwayEft, finishCall)
        -- 放左手
    elseif weaponType == 3 then
        if self.m_points[fight.FightDef.POINT_RWEAPON] then
            logError("站员模型挂点丢失 Weapon_R_node prefabName=" .. self.m_prefabName)
        else
            self:_addWeapon(weaponPath, self.m_points[fight.FightDef.POINT_RWEAPON], beAlwayEft, finishCall)
        end

        if self.m_points[fight.FightDef.POINT_LWEAPON] then
            logError("站员模型挂点丢失 Weapon_L_node prefabName=" .. self.m_prefabName)
        else
            self:_addWeapon(weaponPath, self.m_points[fight.FightDef.POINT_LWEAPON], beAlwayEft, finishCall)
        end
    else
        if self.m_points[fight.FightDef.POINT_RWEAPON] then
            logError("站员模型挂点丢失 Weapon_R_node prefabName=" .. self.m_prefabName)
        end

        if self.m_points[fight.FightDef.POINT_LWEAPON] then
            logError("站员模型挂点丢失 Weapon_L_node prefabName=" .. self.m_prefabName)
        end
        if not self.m_points[fight.FightDef.POINT_ROOT] then
            logError("站员模型挂点丢失 Root_node prefabName=" .. self.m_prefabName)
        end

        if self.m_points[fight.FightDef.POINT_RWEAPON] then
            self:_addWeapon(weaponPath, self.m_points[fight.FightDef.POINT_RWEAPON], beAlwayEft, finishCall)
        elseif self.m_points[fight.FightDef.POINT_LWEAPON] then
            self:_addWeapon(weaponPath, self.m_points[fight.FightDef.POINT_LWEAPON], beAlwayEft, finishCall)
        elseif self.m_points[fight.FightDef.POINT_ROOT] then
            self:_addWeapon(weaponPath, self.m_points[fight.FightDef.POINT_ROOT], beAlwayEft, finishCall)
        end
    end
end

function setWeaponLoadFightAni(self, beLoad, loadAni_Tab)
    self.m_beWeaponLoadFightAni = beLoad
    self.m_LoadAni_Tab = loadAni_Tab
    if self.m_LoadAni_Tab == nil then
        self.m_LoadAni_Tab = {"stand", "exit", "goin", "atk01", "die", "hit01", "hit02", "hit03", "hit04", "hit05", "hit06", "getup", "skill01", "skill02", "skillmix", "skillmax", "win"}
    end
end

function _addWeapon(self, weaponPath, parent, beAlwayEft, finishCall)
    local liveWeapon = model.modelWeapon.new()
    table.insert(self.m_weaponList, liveWeapon)
    local function _resultCall(beSucss)
        if beSucss then
            -- 武器动画
            if self.m_beWeaponLoadFightAni then
                liveWeapon:setPreLoadAnis(self.m_LoadAni_Tab, finishCall)
            else
                if finishCall then
                    finishCall(beSucss)
                end
            end

            self.m_points[fight.FightDef.POINT_RFIRE] = gs.GoUtil.FindNameInChilds(liveWeapon:getTrans(), "Firepoint_R_node")
            self.m_points[fight.FightDef.POINT_LFIRE] = gs.GoUtil.FindNameInChilds(liveWeapon:getTrans(), "Firepoint_L_node")
            liveWeapon:setVisible(self.m_isVisible)
        else
            for i, v in ipairs(self.m_weaponList) do
                if liveWeapon == v then
                    table.remove(self.m_weaponList, i)
                    break
                end
            end
            liveWeapon:destroy()
        end
    end

    liveWeapon:setToParent(parent)
    liveWeapon:setupPrefab(weaponPath, beAlwayEft, _resultCall, 4)
end

function addAssembly(self, prefabPath, beAlwayEft, finishCall)
    self.m_assemblyPathDic[prefabPath] = false
    self.m_actShowItems[prefabPath] = true

    if self.m_model == nil or self.m_loadSn ~= 0 then return end

    local liveAssembly = model.modelItem.new()
    table.insert(self.m_assemblylist, liveAssembly)

    local function _resultCall(beSucss)
        if beSucss then
            local charAppend = liveAssembly.m_model:GetComponent(ty.CharAppendEffect)
            if charAppend then
                charAppend.CharSet = self.m_model
            end
            if finishCall then
                finishCall()
            end
        else
            self:removeAssembly(prefabPath)
        end
    end

    liveAssembly:setToParent(self.m_points[fight.FightDef.POINT_ROOT])
    liveAssembly:setVisible(self.m_isVisible)
    liveAssembly:setupPrefab(prefabPath, beAlwayEft, _resultCall, 5)
end

function removeAssembly(self, prefabPath)
    for i, v in ipairs(self.m_assemblylist) do
        if v.m_prefabName == prefabPath then
            table.remove(self.m_assemblylist, i)
            v:destroy()
            break
        end
    end

    self.m_assemblyPathDic[prefabPath] = nil
    self.m_actShowItems[prefabPath] = nil
end

function clearAssembly(self)
    for _, liveAssembly in pairs(self.m_assemblylist) do
        if liveAssembly ~= false then
            LoopManager:clearTimeout(liveAssembly.s_loadPlaySn)
            liveAssembly:destroy()
        end
    end
    self.m_assemblylist = {}
    self.m_assemblyPathDic = {}
end

--是否需要播放小道具
function needAddShowItem(self, aniHash)
    local modelId = self:getModelId()
    if modelId == nil then
        self:clearShowItemList()
        return false
    end

    local actionItemList = hero.HeroActionManager:getConfigAcitonItems(modelId, aniHash)
    if actionItemList == nil then
        self:clearShowItemList()
        return false
    end

    return true
end

--清理小道具
function clearShowItemList(self)
    if not table.empty(self.m_actShowItems) then
        for itemPath, _ in pairs(self.m_actShowItems) do
            self:removeAssembly(itemPath)
        end
    end
    self.m_actShowItems = {}
end

-- 播放表演的道具及特效
function playShowItem(self, aniHash, callFun)
    local modelId = self:getModelId()
    if modelId ~= nil then
        local actionItemList = hero.HeroActionManager:getConfigAcitonItems(modelId, aniHash)
        if actionItemList then
            local tmpDict = table.copy(self.m_actShowItems)
            local tmpLst = table.copy(actionItemList)
            --首先判断是否有重复的道具，有则不移除
            for i = #tmpLst, 1, -1 do
                local itemPath = UrlManager:getShowItemPath(tmpLst[i])
                if tmpDict[itemPath] then
                    --小道具可能有特效
                    local m_assembly = nil
                    for k, v in pairs(self.m_assemblylist) do
                        if v.m_prefabName == itemPath then
                            m_assembly = v
                            break
                        end
                    end

                    if m_assembly then
                        tmpDict[itemPath] = nil
                        table.remove(tmpLst, i)
                        local model = m_assembly.m_model
                        if model and not gs.GoUtil.IsGoNull(model) then
                            model:SetActive(false)
                            model:SetActive(true)
                        end
                    end
                end
            end

            --移除上次遗留的跟这次不重复的道具
            if not table.empty(tmpDict) then
                for itemPath, _ in pairs(tmpDict) do
                    self:removeAssembly(itemPath)
                end
            end

            if not table.empty(tmpLst) then
                for _, itemPath in pairs(tmpLst) do
                    self:addAssembly(UrlManager:getShowItemPath(itemPath), nil, callFun)
                end
            else
                if callFun then
                    callFun()
                end
            end
        end
    end
end

--获取需要注册的动作hash
function getSetUpCallAniHash(self)
    return
    {
        fight.FightDef.ACT_GOIN,
        fight.FightDef.ACT_READY,
        fight.FightDef.ACT_EXIT,
        fight.FightDef.ACT_ATTACK_1,
        fight.FightDef.ACT_SKILL_1,
        fight.FightDef.ACT_SKILL_2,
        fight.FightDef.ACT_SKILL_3,
        fight.FightDef.ACT_SKILL_MIX,
        fight.FightDef.ACT_SKILL_MAX,
        fight.FightDef.ACT_DIE,
        fight.FightDef.ACT_WIN,
        fight.FightDef.ACT_WALK,
        fight.FightDef.ACT_GETUP,
        fight.FightDef.ACT_SHOW_STAND_TIME_1,
        fight.FightDef.ACT_SHOW_IDLE_TIME_1,
        fight.FightDef.ACT_LEAVE,
        fight.FightDef.ACT_ENTER,
        fight.FightDef.ACT_ENTER_1,
        fight.FightDef.ACT_STANDBY,
        fight.FightDef.ACT_CHANGE,
        fight.FightDef.ACT_CHANGE_1,
        fight.FightDef.ACT_CHANGE_2,

        FieldExplorationConst.ACT_BOXUP,
        FieldExplorationConst.ACT_BOXDOWN,
    }
end

-- 注册动作回调事件
function setupAniCallSys(self)
    local hashList = self:getSetUpCallAniHash()
    for k, aniHash in pairs(hashList) do
        self.m_ani:AddNeedCallHash(aniHash)
    end

    local function _startCall(aniHash)
        local eventCalls = self.m_aniStartDisposableCallDict[aniHash]
        if eventCalls then
            self.m_aniStartDisposableCallDict[aniHash] = nil
            for _, v in ipairs(eventCalls) do
                v(aniHash)
            end
        end
        eventCalls = self.m_aniStartEndCallDict[aniHash]
        if eventCalls then
            for _, dataVal in pairs(eventCalls) do
                if dataVal.startCall then
                    dataVal.startCall(aniHash)
                end
            end
        end
    end
    local function _endCall(aniHash)
        local eventCalls = self.m_aniEndDisposableCallDict[aniHash]
        if eventCalls then
            local endCall = self.m_isForceEndCall[aniHash]
            if endCall then
                self.m_isForceEndCall[self.m_curAniHash] = nil
            end
            self.m_aniEndDisposableCallDict[aniHash] = nil
            for _, v in ipairs(eventCalls) do
                v(aniHash)
            end
        end
        eventCalls = self.m_aniStartEndCallDict[aniHash]
        if eventCalls then
            for _, dataVal in pairs(eventCalls) do
                if dataVal.endCall then
                    dataVal.endCall(aniHash)
                end
            end
        end

    end
    self.m_ani:SetStateEvent(_startCall, _endCall)
end

function setupOneCall(self, aniHash, startCall, endCall)
    if self.m_isForceEndCall and self.m_isForceEndCall[self.m_curAniHash] then
        -- 上一次需要endCall但没完成又需要强制回调的处理
        local calls = self.m_aniEndDisposableCallDict[self.m_curAniHash]
        self.m_aniEndDisposableCallDict[self.m_curAniHash] = nil

        local endCall = self.m_isForceEndCall[self.m_curAniHash]
        if endCall then
            self.m_isForceEndCall[self.m_curAniHash] = nil
            endCall()
        end
    end

    if startCall then
        local calls = self.m_aniStartDisposableCallDict[aniHash]
        if not calls then
            calls = {}
            self.m_aniStartDisposableCallDict[aniHash] = calls
        end
        for _, v in ipairs(calls) do
            if v == startCall then
                return
            end
        end
        table.insert(calls, startCall)
    end
    if endCall then
        local calls = self.m_aniEndDisposableCallDict[aniHash]
        if not calls then
            calls = {}
            self.m_aniEndDisposableCallDict[aniHash] = calls
        end
        for _, v in ipairs(calls) do
            if v == endCall then
                return
            end
        end
        table.insert(calls, endCall)
    end
end

function setupAniStartEndCall(self, aniHash, startCall, endCall)
    local dict = self.m_aniStartEndCallDict[aniHash]
    if not dict then
        dict = {}
        self.m_aniStartEndCallDict[aniHash] = dict
    else
        for _, value in pairs(dict) do
            if startCall == value.startCall or endCall == value.endCall then
                logError("动作回调 有重复设置")
                return
            end
        end
    end
    local sn = SnMgr:getSn()
    dict[sn] = {startCall = startCall, endCall = endCall}

    return sn
end

function removeStartEndCall(self, sn)
    for _, dict in pairs(self.m_aniStartEndCallDict) do
        if dict[sn] then
            dict[sn] = nil
            SnMgr:disposeSn(sn)
            return
        end
    end
end

function clearStartEndCall(self)
    for _, dict in pairs(self.m_aniStartEndCallDict) do
        for sn, _ in pairs(dict) do
            SnMgr:disposeSn(sn)
        end
    end
    self.m_aniStartEndCallDict = {}
end

-- 设置显示图层
function setDisplayLayer(self, displayLayer)
    super.setDisplayLayer(self, displayLayer)

    if self.m_displayLayer == displayLayer then
        return;
    end

    for _, v in ipairs(self.m_weaponList) do
        v:setDisplayLayer(displayLayer)
    end

    for _, liveAssembly in pairs(self.m_assemblylist) do
        if liveAssembly ~= false then
            liveAssembly:setDisplayLayer(displayLayer)
        end
    end
end

function resetDefDisplayLayer(self)
    super.resetDefDisplayLayer(self)

    if self.m_displayLayer == self.m_defLayer then
        return;
    end

    for _, v in ipairs(self.m_weaponList) do
        v:resetDefDisplayLayer()
    end

    for _, liveAssembly in pairs(self.m_assemblylist) do
        if liveAssembly ~= false then
            liveAssembly:resetDefDisplayLayer()
        end
    end
end

-- 设置是否显示
function setVisible(self, beVisible)
    if self.m_isVisible == beVisible then
        return
    end

    super.setVisible(self, beVisible)

    for _, v in ipairs(self.m_weaponList) do
        v:setVisible(beVisible)
    end
    for _, liveAssembly in pairs(self.m_assemblylist) do
        if liveAssembly ~= false then
            liveAssembly:setVisible(beVisible)
        end
    end
end

-- 设置透明度
function setTranparency(self, value)
    super.setTranparency(self, value)

    if self.m_tranparency == value then
        return
    end

    for _, v in ipairs(self.m_weaponList) do
        v:setTranparency(value)
    end
    for _, liveAssembly in pairs(self.m_assemblylist) do
        if liveAssembly ~= false then
            liveAssembly:setTranparency(value)
        end
    end
end

-- 设置模型缩放
function setModelScale(self, cusScale)
    local defaultScale = 1
    if self:getModelId() and fight.RoleShowManager:getModelScale(self:getModelId()) then
        defaultScale = fight.RoleShowManager:getModelScale(self:getModelId())
        defaultScale = defaultScale > 0 and defaultScale or 1
    end
    if cusScale then
        defaultScale = defaultScale * cusScale
    end

    gs.TransQuick:Scale0(self.m_modelTrans, defaultScale)
end

function setAniSpeed(self, aniSpeed)
    super.setAniSpeed(self, aniSpeed)

    for _, v in ipairs(self.m_weaponList) do
        v:setAniSpeed(aniSpeed)
    end
    for _, liveAssembly in pairs(self.m_assemblylist) do
        if liveAssembly ~= false then
            liveAssembly:setAniSpeed(aniSpeed)
        end
    end
end

-- 获取挂点
function getPointTrans(self, pointType)
    local pointTrans = self.m_points[pointType]
    if not pointTrans and pointType ~= fight.FightDef.POINT_HIT then
        Debug:log_warn("LiveBase", "point type[%d] not exist", pointType)
    end
    return pointTrans
end

-- 获取挂点当前位置
function getPointPos(self, pointType)
    local pointTrans = self:getPointTrans(pointType)
    if pointTrans and not gs.GoUtil.IsTransNull(pointTrans) then
        return pointTrans.position
    end
    return nil
end

return _M
