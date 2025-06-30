--模型基础类
module("model.modelBase", Class.impl())

function ctor(self)
    -- 动作控制
    self.m_ani = nil
    -- 动态骨骼
    self.m_dynamicBone = nil
    -- 是否开启骨骼状态
    self.m_dynamicBoneBeEnable = true

    -- 模型材质管理
    self.m_modelMaterials = nil
    -- 是否开启开启LOD
    self.m_modelLodBeEnable = true

    self.m_prefabName = nil

    self.m_isVisible = true
    self.m_position = math.Vector3()

    -- 所在图层
    self.m_dLayer = nil

    -- 动作的播放速度
    self.m_aniSpeed = 1

    -- 加在模型上的其它效果go (直接通过sn索引)
    self.m_otherEftDict = {}
    -- 加在模型上的其它效果go (通过prefab name索引)
    self.m_otherEfts = {}
    -- 其它效果的加载队列 (在模型未准备好时使用)
    self.m_otherLoadLst = {}

    self.m_rootGo = gs.GameObject()
    self.m_trans = self.m_rootGo.transform
    -- 脸朝角度
    self.m_angle = gs.TransQuick:GetRotationY(self.m_trans);
    self.m_loadSn = 0

    self.m_hideLayer = "HideLayer"

    self.isUnLoadAysn = false

    -- 是否战斗场景使用
    self.isInFightScene = false
end

-- 对象池调用时触发
function onAwake(self)
end

-- 回收：对象池调用时触发
function onRecover(self)
    self:destroy()
end

--删除
function destroy(self)
    self:clearModel()
    self:stopTurnAngle()
    if self.m_rootGo then
        gs.GameObject.Destroy(self.m_rootGo)
        self.m_rootGo = nil
        self.m_trans = nil
    end
end

-- 清空模型 (并不是删除! 删除请用destroy)
function clearModel(self)
    if self.m_loadSn and self.m_loadSn ~= 0 then
        Debug:log_warn("LiveBase", "清空模型取消异步加载")
        gs.ResMgr:CancelLoadAsync(self.m_loadSn)
        self.m_loadSn = 0
    end

    LoopManager:removeFrameByIndex(self.frostIntensitySn)
    LoopManager:removeFrameByIndex(self.metalIntensitySn)

    self:removeAlwayEft()
    self:clearOtherEft()

    if self.m_model then
        gs.GameObject.Destroy(self.m_model)
        self.m_model = nil
        self.m_modelTrans = nil
        self.m_ani = nil
        self.m_dynamicBone = nil
        self.m_dynamicBoneBeEnable = true
        -- 模型材质管理
        self.m_modelMaterials = nil
        -- 是否开启开启LOD
        self.m_modelLodBeEnable = true
    end
end

--设置是否同步加载
function setIsLoad(self, isLoad)
    self.isUnLoadAysn = isLoad
end

-- 开始加载模型模型
-- beAlwayEft : 是否开启常驻特效
function setupPrefab(self, prefabname, beAlwayEft, finishCall, sorceId)
    if self.m_rootGo == nil then
        self.m_rootGo = gs.GameObject()
        self.m_trans = self.m_rootGo.transform
    end

    self.m_prefabName = prefabname
    self.beAlwayEft = beAlwayEft

    self:setModelGoName()
    self:clearModel()

    if self.m_loadSn and self.m_loadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.m_loadSn)
    end

    local function _loadAysnModeCall(go)
        self:loadFinish(go, finishCall, sorceId)
    end
    if self.isUnLoadAysn then
        local go = gs.ResMgr:LoadGO(self.m_prefabName)
        _loadAysnModeCall(go)
    else
        self.m_loadSn = gs.ResMgr:LoadGOAysn(self.m_prefabName, _loadAysnModeCall)
    end

    -- gs.ResMgr:CancelLoadAsync(self.m_alwayEftLoadSn)
    -- self.m_alwayEftLoadSn = 0
end

--加载完成(模型加载完成而已)
function loadFinish(self, go, finishCall, sorceId)
    self.m_loadSn = 0
    if go then
        if not self.m_rootGo or gs.GoUtil.IsGoNull(self.m_rootGo) then
            logError("本对象已被销毁了22 " .. self.m_prefabName .. " id：" .. (sorceId or 0))
            gs.GameObject.Destroy(go)
            return
        end

        self.m_model = go
        self.m_modelTrans = self.m_model.transform
        self.m_modelTrans:SetParent(self.m_trans, false)
        self.m_modelTrans.localPosition = gs.VEC3_ZERO

        self.m_defLayer = gs.LayerMask.LayerToName(self.m_model.layer)
        if self.m_isVisible == false then
            gs.GoUtil.ChangeLayer(self.m_rootGo, self.m_hideLayer)
        else
            if self.m_displayLayer and self.m_displayLayer ~= self.m_defLayer then
                self:setDisplayLayer(self.m_displayLayer)
            end
        end

        self.m_dynamicBone = self.m_model:GetComponent(ty.DynamicBoneController)
        if self.m_dynamicBoneBeEnable == false then
            self:setDynamicBoneEnable(self.m_dynamicBoneBeEnable)
        end

        self.m_modelMaterials = self.m_model:GetComponent(ty.ModelMaterials)
        if self.m_modelLodBeEnable == false then
            self:setModelLodEnable(self.m_modelLodBeEnable)
        end

        if not table.empty(self.m_otherLoadLst) then
            for _, otherEftData in ipairs(self.m_otherLoadLst) do
                if otherEftData[3] then
                    self:addOtherEft1(otherEftData[1], otherEftData[2], otherEftData[3], otherEftData[4])
                else
                    self:addOtherEft0(otherEftData[1], otherEftData[2], otherEftData[4])
                end
            end
            self.m_otherLoadLst = {}
        end

        if self.beAlwayEft then
            self:_loadAlwaysEft()
        end

        self.m_ani = self.m_model:GetComponent(ty.AnimatCtrl)
        if self.m_ani then
            self:LoadClipWithHash(fight.FightDef.ACT_STAND)
            self:_afterLoad()
        end
        self:setTranparency(1)

        if finishCall then
            finishCall(true, self)
        end
    else
        logError("Role Model " .. self.m_prefabName .. "not exist")
        if finishCall then
            finishCall(false, self)
        end
    end
end

---加载完成（真正意义上的加载完成）
function _afterLoad(self)
    if self.m_dLayer ~= nil then
        gs.GoUtil.ChangeLayer(self.m_rootGo, self.m_dLayer)
    end
    self.m_rootGo:SetActive(true)

    if self.m_ani then
        -- 检测预加载动作片段资源列表（通过action name）
        if not table.empty(self.m_preLoadAnis) then
            local function _aniFinishCall()
                if self.m_preLoadAnisCall then
                    self.m_preLoadAnisCall()
                    self.m_preLoadAnisCall = nil
                end
                if self.m_curAniHash ~= nil then
                    self:playAction(self.m_curAniHash)
                end
                if self.m_aniSpeed ~= 1 then
                    local tmpSpeed = self.m_aniSpeed
                    self.m_aniSpeed = -1
                    self:setAniSpeed(tmpSpeed)
                end
            end
            self.m_ani:LoadAsynAniNameArray(self.m_preLoadAnis, _aniFinishCall)
            self.m_preLoadAnis = nil
            return
        end

        -- 检测预加载动作片段资源列表（通过hash）
        if not table.empty(self.m_preLoadAnisHashList) then
            local function _aniFinishCall()
                if self.m_preLoadAnisHashCall then
                    self.m_preLoadAnisHashCall()
                    self.m_preLoadAnisHashCall = nil
                end
                if self.m_curAniHash ~= nil then
                    self:playAction(self.m_curAniHash)
                end
                if self.m_aniSpeed ~= 1 then
                    local tmpSpeed = self.m_aniSpeed
                    self.m_aniSpeed = -1
                    self:setAniSpeed(tmpSpeed)
                end
            end
            self.m_ani:LoadAsynAniHashArray(self.m_preLoadAnisHashList, _aniFinishCall)
            self.m_preLoadAnisHashList = nil
            return
        end

        if self.m_curAniHash ~= nil then
            self:playAction(self.m_curAniHash)
        end
        if self.m_aniSpeed ~= 1 then
            local tmpSpeed = self.m_aniSpeed
            self.m_aniSpeed = -1
            self:setAniSpeed(tmpSpeed)
        end
    end
end

--设置模型节点名字
function setModelGoName(self, name)
    if not name then
        name = string.match(self.m_prefabName, "model%d*")
    end

    if name then
        self.m_rootGo.name = name .. "Root"
    end
end

--获取帧数
function GetTotalFrameCount(self, clipName)
    return self.m_ani:GetTotalFrameCount(clipName)
end

function setPreLoadAnisByHashList(self, hashList, finishCall)
    if self.m_ani then
        self.m_ani:LoadAsynAniHashArray(hashList, finishCall)
        -- elseif self.m_model == nil then
    else
        if not self.m_preLoadAnisHashList then
            self.m_preLoadAnisHashList = {}
        end
        table.mergeList(self.m_preLoadAnisHashList, hashList)
        self.m_preLoadAnisHashCall = finishCall
        -- else
        --     if finishCall then finishCall() end
    end
end

function setPreLoadAnis(self, stateNames, finishCall)
    if self.m_ani then
        self.m_ani:LoadAsynAniNameArray(stateNames, finishCall)
    elseif self.m_model == nil then
        if not self.m_preLoadAnis then
            self.m_preLoadAnis = {}
        end
        table.mergeList(self.m_preLoadAnis, stateNames)
        self.m_preLoadAnisCall = finishCall
    else
        if finishCall then finishCall() end
    end
end

-- 绑定非预设绑定的动作片段
function setOtherAniClipBind(self, clipHash, aniName, finishCall)
    if self.m_ani then
        self.m_ani:LoadClipOtherBind(clipHash, aniName, finishCall)
    end
end

-- 是否有动作片段
function haveClipWithHash(self, clipHash)
    if self.m_ani then
        return self.m_ani:HaveClipWithHash(clipHash)
    end
    return false
end

function setPosition(self, lpos)
    if not lpos then return end
    if self.m_position == lpos then return end
    self.m_position:copy(lpos)
    if self.m_trans and lpos then
        gs.TransQuick:Pos(self.m_trans, self.m_position.x, self.m_position.y, self.m_position.z)
    end
end

function setPositionTween(self, lpos, tweenTime)
    if not lpos then return end
    if self.m_position == lpos then return end
    self.m_position:copy(lpos)

    if self.posTweener then
        self.posTweener:Kill()
        self.posTweener = nil
    end
    if self.m_trans and lpos then
        self.posTweener = TweenFactory:move2pos(self.m_trans, lpos, tweenTime, nil)
    end
end

function setAngle(self, angle, isNow)
    if isNow then
        self:stopTurnAngle()
        self.m_angle = angle
        gs.TransQuick:SetRotation(self.m_trans, 0, angle, 0)
    else
        if angle ~= self.m_angle then
            self:stopTurnAngle()
            self.m_angle = angle
            self.m_angle_tweener = TweenFactory:rotate(self.m_trans, math.Vector3(0, self.m_angle, 0), 0.3)
            fight.TweenManager:addTweener(self.m_angle_tweener)
        end
    end
end

function getAngle(self)
    return self.m_angle
end

function setEulerAngles(self, anglesV3)
    gs.TransQuick:SetRotation(self.m_trans, anglesV3.x, anglesV3.y, anglesV3.z)
end

function stopTurnAngle(self)
    if self.m_angle_tweener ~= nil then
        self.m_angle_tweener:Kill()
        self.m_angle_tweener = nil
    end
end

function getCurPos(self)
    return self.m_position
end

function getTrans(self)
    return self.m_trans
end
function getRootGO(self)
    return self.m_rootGo
end

function getModelGO(self)
    return self.m_model
end

-- 获取正式模型名(取资源)
function getModelId(self)
    return nil
end

-- 获取基础模型名(取公共配置)
function getBaseModelId(self)
    return nil
end

-- 移除常驻特效
function removeAlwayEft(self)
    if self.m_alwayEftLoadSn and self.m_alwayEftLoadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.m_alwayEftLoadSn)
        self.m_alwayEftLoadSn = 0
    end
    if self.m_alwayEfts then
        for _, eftGo in ipairs(self.m_alwayEfts) do
            gs.GameObject.Destroy(eftGo)
        end
    end
    self.m_alwayEfts = {}
end

-- 设置显示图层
function setDisplayLayer(self, displayLayer)
    if self.m_displayLayer == displayLayer then
        return;
    end

    self.m_displayLayer = displayLayer
    if self.m_loadSn == 0 and self.m_rootGo and displayLayer then
        if self.m_isVisible then
            gs.GoUtil.ChangeLayer(self.m_rootGo, displayLayer)
        end
    end
end

function resetDefDisplayLayer(self)
    if self.m_displayLayer == self.m_defLayer then
        return;
    end

    self.m_displayLayer = self.m_defLayer
    if self.m_loadSn == 0 and self.m_rootGo and self.m_defLayer then
        if self.m_isVisible then
            gs.GoUtil.ChangeLayer(self.m_rootGo, self.m_defLayer)
        end
    end
end

-- 设置是否显示
function setVisible(self, beVisible)
    if self.m_isVisible == beVisible then
        return
    end

    self.m_isVisible = beVisible
    if self.m_rootGo then
        if beVisible == true then
            if self.m_rootGo.activeSelf == false then
                self.m_rootGo:SetActive(beVisible)
            end
            if self.m_displayLayer then
                gs.GoUtil.ChangeLayer(self.m_rootGo, self.m_displayLayer)
            else
                gs.GoUtil.ChangeLayer(self.m_rootGo, self.m_defLayer)
            end

            if self.beAlwayEft then
                self:_loadAlwaysEft()
            end
        else
            gs.GoUtil.ChangeLayer(self.m_rootGo, self.m_hideLayer)
            self:removeAlwayEft()
        end
    end
end

-- 设置透明度
function setTranparency(self, value)
    if self.m_tranparency == value then
        return
    end

    self.m_tranparency = value
    if self.m_model then
        local mat = self.m_model:GetComponent(ty.ModelMaterials)
        if mat then
            mat:SetTranparency(value)
        end
    end
end

-- 冰冻效果
function setIsFrostEnable(self, isEnable)
    if self.m_isFrostEnable == isEnable then
        return
    end

    LoopManager:removeFrameByIndex(self.frostIntensitySn)

    self.m_isFrostEnable = isEnable
    if self.m_model then
        local mat = self.m_model:GetComponent(ty.ModelMaterials)
        if mat then
            mat:SetIsFrostEnable(isEnable)

            if isEnable then
                local intensity = 0
                self.frostIntensitySn = LoopManager:addFrame(1, 10, self, function()
                    mat:SetFrostIntensity(intensity)
                    intensity = intensity + 0.1
                end)
            end
        end
    end
end

-- 金属封印
function setIsMetalEnable(self, isEnable)
    if self.m_isMetalEnable == isEnable then
        return
    end

    LoopManager:removeFrameByIndex(self.metalIntensitySn)

    self.m_isMetalEnable = isEnable
    if self.m_model then
        local mat = self.m_model:GetComponent(ty.ModelMaterials)
        if mat then
            mat:SetIsMetalEnable(isEnable)

            if isEnable then
                local intensity = 0
                self.metalIntensitySn = LoopManager:addFrame(1, 10, self, function()
                    mat:SetMetalIntensity(intensity)
                    intensity = intensity + 0.1
                end)
            end
        end
    end
end

-- 弱点击破发光效果
function setIsWeekEnable(self, isEnable)
    if self.m_isWeekEnable == isEnable then
        return
    end
    self.m_isWeekEnable = isEnable
    if self.m_model then
        local mat = self.m_model:GetComponent(ty.ModelMaterials)
        if mat then
            mat:SetFrameOutLine(isEnable)
        end
    end
end

-- 设置景深渲染顺序
function setDofPrepare(self)
    if self.m_model then
        local mat = self.m_model:GetComponent(ty.ModelMaterials)
        if mat then
            mat:DofPrepare()
        end
    end
end

-- 添加到父节点
function setToParent(self, parent, worldPositionStays)
    self.m_parentTrans = parent
    if self.m_trans then
        if worldPositionStays == nil then
            worldPositionStays = false
        end
        self.m_trans:SetParent(parent, worldPositionStays)
        self.m_parentTrans = nil

    end
end

function isPlayHash(self, aniHash)
    if self.m_ani then
        return self.m_ani:IsPlayingShortNameHash(aniHash)
    end
    return false
end

-- 播放动作
-- startCall, endCall为一次性事件
function playAction(self, aniHash)
    if not self.m_ani then return end

    local exitTimeHash = fight.FightDef.HashExitTimeAnimation[aniHash]
    if exitTimeHash then
        self:LoadClipWithHash(exitTimeHash)
    end

    local layerIndex = fight.FightDef.ANI_BELONG_LAYER[aniHash]
    layerIndex = layerIndex or 0
    self.m_ani:PlayHash(aniHash, nil, layerIndex)
end
-- 播放动作带过渡
function playFade(self, aniHash)
    if not self.m_ani then return end

    local exitTimeHash = fight.FightDef.HashExitTimeAnimation[aniHash]
    if exitTimeHash then
        self:LoadClipWithHash(exitTimeHash)
    end
    self.m_ani:PlayFadeHash(aniHash)
end

-- 通过触发器来播放动作
-- startCall, endCall为一次性事件
function playActionTrigger(self, triggerHash, resetTriggerHash)
    if not self.m_ani then return end

    local aniHash = self:getActionHashByTriggerHash(triggerHash)
    if aniHash ~= nil then
        local exitTimeHash = fight.FightDef.HashExitTimeAnimation[aniHash]
        if exitTimeHash then
            self:LoadClipWithHash(exitTimeHash)
        end

        if (resetTriggerHash) then
            self.m_ani:ResetTriggers(resetTriggerHash)
        end
        self.m_ani:PlayTriggerCond(triggerHash)
    end
end
--加载动作
function LoadClipWithHash(self, aniHash, finishCall)
    if not self.m_ani then
        if finishCall ~= nil then
            finishCall()
        end
        return
    end

    self.m_ani:LoadClipWithHash(aniHash, finishCall)
end

function getActionHashByTriggerHash(self, triggerHash)
    return fight.FightDef.TRANS_STATES[triggerHash]
end

-- 设置动作过渡布尔值
function setAnimationBoolVal(self, keyhash, val)
    if self.m_loadSn == 0 and self.m_ani then
        local aniHash = self:getActionHashByTriggerHash(keyhash)
        if aniHash then
            local exitTimeHash = fight.FightDef.HashExitTimeAnimation[aniHash]
            if exitTimeHash then
                self:LoadClipWithHash(exitTimeHash)
            end

            self.m_ani:SetBoolCondtion(keyhash)
        end
    end
end

-- 设置动作过渡触发值
function setAnimationTriggerVal(self, keyhash)
    if self.m_loadSn == 0 and self.m_ani then
        local aniHash = self:getActionHashByTriggerHash(keyhash)
        if aniHash then
            local exitTimeHash = fight.FightDef.HashExitTimeAnimation[aniHash]
            if exitTimeHash then
                self:LoadClipWithHash(exitTimeHash)
            end

            self.m_ani:SetBoolCondtion(keyhash)
        end
    end
end

-- 获取动作时长
function getAniLenght(self, aniName, callback)
    if self.m_ani then
        self.m_ani:GetAniLenght(aniName, callback)
    end
end
-- 设置动作速度
function setAniSpeed(self, aniSpeed)
    if self.m_aniSpeed ~= aniSpeed then
        self.m_aniSpeed = aniSpeed
        if self.m_loadSn == 0 and self.m_ani then
            self.m_ani:SetSpeed(self.m_aniSpeed)
        end
    end
end

-- 设置动态骨骼开关
function setDynamicBoneEnable(self, beEnable)
    self.m_dynamicBoneBeEnable = beEnable
    if self.m_dynamicBone then
        self.m_dynamicBone:SetDynamicBoneEnable(beEnable)
    end
end

-- 设置模型LOD开关
function setModelLodEnable(self, beEnable)
    self.m_modelLodBeEnable = beEnable
    if self.m_modelMaterials then
        self.m_modelMaterials:SetModelLodEnable(beEnable)
    end
end

-- 恢复事件帧隐藏的场景元素
function resetEnvironment(self)
    if self.m_ani then
        return self.m_ani:SetEnvironmentState(1)
    end
end

function _loadAlwaysEft(self)
    self:removeAlwayEft()
    local ro = fight.FightLoader:getAlwayEftRo(self.m_prefabName)
    if ro and (ro:getJustUI() == 0 or (ro:getJustUI() == 1 and self.isInFightScene == false)) then
        self.m_alwayEfts = {}

        local group = ro:getEftGroup()
        local eftLst = {}
        for _, v in ipairs(group) do
            table.insert(eftLst, v)

        end
        local function _loadAysnAlwaysEftCall(eftGo)
            self.m_alwayEftLoadSn = nil
            if eftGo then
                eftGo.transform:SetParent(self.m_trans, false)
                local charAppend = eftGo:GetComponent(ty.CharAppendEffect)
                if charAppend then
                    charAppend.CharSet = self.m_model
                end
                table.insert(self.m_alwayEfts, eftGo)
            end
            local eftPath = eftLst[1]
            if eftPath then
                table.remove(eftLst, 1)
                self.m_alwayEftLoadSn = gs.ResMgr:LoadGOAysn(UrlManager:getAlwayEfxRolePath(eftPath), _loadAysnAlwaysEftCall)
            end
        end
        _loadAysnAlwaysEftCall()
    end
end
-- 添加其它物件 (直接添加，内部不作记录, 特效对象由自己管理)
function addOtherEft0(self, prefabPath, aniStatusName, finishCall)
    if self.m_model == nil or self.m_loadSn ~= 0 then
        table.insert(self.m_otherLoadLst, { prefabPath, aniStatusName, nil, finishCall })
        return
    end
    local eftGo = gs.GOPoolMgr:Get(prefabPath)
    if eftGo == nil then return end

    local charAppend = eftGo:GetComponent(ty.CharAppendEffect)
    -- 自动挂点
    if not gs.GoUtil.IsCompNull(charAppend) then
        charAppend.CharSet = self.m_rootGo
    else
        eftGo.transform:SetParent(self.m_trans, false)
    end
    -- 特效动作
    if aniStatusName then
        local animat = eftGo:GetComponent(ty.Animator)
        if animat then
            animat:Play(aniStatusName);
            animat:Update(0);
        end
    end
    eftGo:SetActive(true)
    if finishCall then
        finishCall(eftGo)
    end
    return eftGo
end

-- 添加其它物件 (会作内部记录)
function addOtherEft1(self, prefabPath, aniStatusName, timeLen, finishCall)
    if self.m_model == nil or self.m_loadSn ~= 0 then
        if not timeLen or timeLen <= 0 then
            timeLen = 0
        end
        table.insert(self.m_otherLoadLst, { prefabPath, aniStatusName, timeLen, finishCall })
        return
    end
    local eftGo = self:addOtherEft0(prefabPath, aniStatusName)
    if eftGo then
        local dict = self.m_otherEfts[prefabPath]
        if not dict then
            dict = {}
            self.m_otherEfts[prefabPath] = dict
        end
        local sn = SnMgr:getSn()
        dict[sn] = eftGo
        self.m_otherEftDict[sn] = { eftGo, prefabPath }
        if timeLen and timeLen > 0 then
            local function _timeout()
                self:removeOtherEft0(sn)
            end
            LoopManager:setTimeout(timeLen, self, _timeout)
            SnMgr:disposeSn(sn)
        end
        if finishCall then
            finishCall(sn)
        end
        return sn
    end
end
-- 通过sn移除其它物件
function removeOtherEft0(self, sn)
    local data = self.m_otherEftDict[sn]
    if data then
        SnMgr:disposeSn(sn)
        self.m_otherEftDict[sn] = nil
        data[1]:SetActive(false)
        gs.GOPoolMgr:Recover(data[1], data[2])
        -- gs.GameObject.Destroy(data[1])
        local dict = self.m_otherEfts[data[2]]
        if dict then
            dict[sn] = nil
        end
    end
end
-- 通过prefabPath移除对应的其它物件集合
function removeOtherEft1(self, prefabPath)
    if not table.empty(self.m_otherLoadLst) then
        for i = #self.m_otherLoadLst, 1, -1 do
            local data = self.m_otherLoadLst[i]
            if data[1] == prefabPath then
                table.remove(self.m_otherLoadLst, i)
            end
        end
    end
    local dict = self.m_otherEfts[prefabPath]
    if dict then
        for sn, eftGo in pairs(dict) do
            eftGo:SetActive(false)
            gs.GOPoolMgr:Recover(eftGo, prefabPath)
            -- gs.GameObject.Destroy(eftGo)
            SnMgr:disposeSn(sn)
            self.m_otherEftDict[sn] = nil
        end
        self.m_otherEfts[prefabPath] = nil
    end
end
-- 清空其它物件
function clearOtherEft(self)
    for sn, data in pairs(self.m_otherEftDict) do
        data[1]:SetActive(false)
        gs.GOPoolMgr:Recover(data[1], data[2])
        -- gs.GameObject.Destroy(data[1])
        SnMgr:disposeSn(sn)
    end
    self.m_otherEftDict = {}
    self.m_otherEfts = {}
    self.m_otherLoadLst = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]