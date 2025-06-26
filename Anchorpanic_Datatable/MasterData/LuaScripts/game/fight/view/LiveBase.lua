----------------------------------弃用了的-----------
module("fight.LiveBase", Class.impl())

function ctor(self)
    self.m_isMain = true
    -- 动作一次性的开始事件
    self.m_aniStartDisposableCallDict = {}
    -- 动作一次性的结束事件
    self.m_aniEndDisposableCallDict = {}

    -- 动作的回调事件(持续有效)
    self.m_aniStartEndCallDict = {}

    -- 挂点的储存结构体
    self.m_points = {}
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
    -- 当前动作hash
    self.m_curAniHash = gs.Animator.StringToHash(self.m_awakeAnimaName)

    -- 武器
    self.m_weaponList = {}
    -- 加在模型上的其它效果go (直接通过sn索引)
    self.m_otherEftDict = {}
    -- 加在模型上的其它效果go (通过prefab name索引)
    self.m_otherEfts = {}
    -- 其它效果的加载队列 (在模型未准备好时使用)
    self.m_otherLoadLst = {}
    -- 其它道具组件
    self.m_assemblyDict = {}

    self.m_rootGo = gs.GameObject()
    self.m_trans = self.m_rootGo.transform
    -- 脸朝角度
    self.m_angle = gs.TransQuick:GetRotationY(self.m_trans);
    self.m_loadSn = 0

    self.m_hideLayer = "HideLayer"

    self.m_awakeAnimaName = fight.FightDef.ACTION_NAMEs[fight.FightDef.ACT_STAND]

    -- -- 记录播放的动作道具
    self.m_actShowItems = {}

    -- 是否动作中断强制回调endCall
    self.m_isForceEndCall = {}

end

function dtor(self)
    self:destroy()
end

-- function onAwake(self)
--     if self.m_rootGo == nil then
--         self.m_rootGo = gs.GameObject()
--         self.m_trans = self.m_rootGo.transform
--         -- 脸朝角度
--         self.m_angle = gs.TransQuick:GetRotationY(self.m_trans);
--     end
-- end

function onRecover(self)
    self:destroy()
end

function destroy(self)
    self:clearModel()
    self:stopTurnAngle()
    self:clearStartEndCall()
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
    if self.m_alwayEftLoadSn and self.m_alwayEftLoadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.m_alwayEftLoadSn)
        self.m_alwayEftLoadSn = 0
    end
    self:removeWeapon()
    self:clearOtherEft()
    self:clearAssembly()
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
-- 启动模型
-- beAlwayEft : 是否开启常驻特效
function setupPrefab(self, prefabname, beAlwayEft, finishCall, sorceId)
    if not self.m_rootGo or gs.GoUtil.IsGoNull(self.m_rootGo) then
        logError("本对象已被销毁了 " .. prefabname)
        return
    end
    self.m_animatorLoadFinish = false
    self.m_prefabName = prefabname
    local function _loadAysnModeCall(go)
        self.m_loadSn = 0
        if go then
            if not self.m_rootGo or gs.GoUtil.IsGoNull(self.m_rootGo) then
                logError("本对象已被销毁了22 " .. prefabname .. " id：" .. (sorceId or 0))
                gs.GameObject.Destroy(go)
                return
            end

            self:setVisible(false)

            self.m_model = go
            self.m_modelTrans = self.m_model.transform

            self.m_modelTrans:SetParent(self.m_trans, false)
            self.m_modelTrans.localPosition = gs.VEC3_ZERO

            self:setTranparency(1)
            -- if string.find(prefabname, "monster") then
            --     self.m_modelTrans.localPosition = gs.VEC3_ZERO
            -- else
            --     gs.TransQuick:PosScale(self.m_modelTrans)
            -- end
            self:setModelScale()

            local str = string.match(prefabname, "model%d*")
            if str then
                self.m_rootGo.name = str .. "Root"
            end
            self.m_defLayer = gs.LayerMask.LayerToName(self.m_model.layer)
            if self.m_isVisible == false then
                gs.GoUtil.ChangeLayer(self.m_rootGo, self.m_hideLayer)
            else
                if self.m_displayLayer and self.m_displayLayer ~= self.m_defLayer then
                    self:setDisplayLayer(self.m_displayLayer)
                end
            end
            self.m_points[fight.FightDef.POINT_ROOT] = gs.GoUtil.FindNameInChilds(self.m_modelTrans, "Root_node")
            self.m_points[fight.FightDef.POINT_TOP] = gs.GoUtil.FindNameInChilds(self.m_modelTrans, "Top_node")
            self.m_points[fight.FightDef.POINT_SPINE] = gs.GoUtil.FindNameInChilds(self.m_modelTrans, "Spine_node")
            self.m_points[fight.FightDef.POINT_LWEAPON] = gs.GoUtil.FindNameInChilds(self.m_modelTrans, "Weapon_L_node")
            self.m_points[fight.FightDef.POINT_RWEAPON] = gs.GoUtil.FindNameInChilds(self.m_modelTrans, "Weapon_R_node")
            self.m_points[fight.FightDef.POINT_CAMERA] = gs.GoUtil.FindNameInChilds(self.m_modelTrans, "Camera_node")
            self.m_points[fight.FightDef.POINT_HIT] = gs.GoUtil.FindNameInChilds(self.m_modelTrans, "Hit_node")

            self.m_dynamicBone = self.m_model:GetComponent(ty.DynamicBoneController)
            if self.m_dynamicBoneBeEnable == false then
                self:setDynamicBoneEnable(self.m_dynamicBoneBeEnable)
            end

            if fight.FightManager.m_gmRoleLod ~= nil then
                self.m_modelLodBeEnable = fight.FightManager.m_gmRoleLod
            end

            self.m_modelMaterials = self.m_model:GetComponent(ty.ModelMaterials)
            if self.m_modelLodBeEnable == false then
                self:setModelLodEnable(self.m_modelLodBeEnable)
            end

            if self.m_weaponPath and self.m_weaponType then
                local tmpWeaponPath = self.m_weaponPath
                self.m_weaponPath = nil
                self:addWeapon(tmpWeaponPath, self.m_weaponType, beAlwayEft)
            end

            for assemblyKey, liveAssembly in pairs(self.m_assemblyDict) do
                if liveAssembly == false then
                    self:addAssembly(assemblyKey)
                end
            end

            if beAlwayEft then
                self:_loadAlwaysEft()
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

            self.m_ani = self.m_model:GetComponent(ty.AnimatCtrl)
            if self.m_ani then
                self.m_ani:LoadClipWithHash(gs.Animator.StringToHash(self.m_awakeAnimaName))
                if self.m_isMain == true then
                    self:_setupAniCallSys()
                end

                self.m_ani:AddFrameCallEvent(self.m_awakeAnimaName, function()
                    if self.m_animatorLoadFinish then return end
                    if not self.m_rootGo then return end

                    self.m_animatorLoadFinish = true
                    self:_afterLoad()

                    self:setVisible(true)
                    if finishCall then
                        finishCall(true, self)
                    end
                end, 0)
            else
                ---兼容武器没有动画的情况
                -- logWarn("this model no animator,prefabName is " .. self.m_prefabName)
                self:setVisible(true)
                if finishCall then
                    finishCall(true, self)
                end
            end
        else
            logError("Role Model " .. self.m_prefabName .. "not exist")

            self:setVisible(true)
            if finishCall then
                finishCall(false, self)
            end
        end
    end
    self:clearModel()
    if self.m_loadSn and self.m_loadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.m_loadSn)
    end
    self.m_loadSn = gs.ResMgr:LoadGOAysn(self.m_prefabName, _loadAysnModeCall)
    gs.ResMgr:CancelLoadAsync(self.m_alwayEftLoadSn)
    self.m_alwayEftLoadSn = 0
end

-- function _setupPrefab0(self, prefabname, beAlwayEft, finishCall)
--     if not self.m_rootGo then
--         logError("本对象已被销毁了 " .. prefabname)
--         if finishCall then finishCall(false, self) end
--         return
--     end
--     if self.m_loadSn and self.m_loadSn ~= 0 then
--         gs.ResMgr:CancelLoadAsync(self.m_loadSn)
--     end
--     self.m_loadSn = 0
--     gs.ResMgr:CancelLoadAsync(self.m_alwayEftLoadSn)
--     self.m_alwayEftLoadSn = 0
--     self.m_prefabName = prefabname
--     local go = gs.ResMgr:LoadGO(self.m_prefabName)
--     if go then
--         self:clearModel()
--         self.m_model = go
--         self.m_modelTrans = self.m_model.transform
--         self.m_modelTrans:SetParent(self.m_trans, false)
--         self.m_modelTrans.localPosition = gs.VEC3_ZERO
--         -- if string.find(prefabname, "monster") then
--         --     self.m_modelTrans.localPosition = gs.VEC3_ZERO
--         -- else
--         --     gs.TransQuick:PosScale(self.m_modelTrans)
--         -- end
--         self:setModelScale()

--         local str = string.match(prefabname, "model%d*")
--         if str then
--             self.m_rootGo.name = str .. "Root"
--         end
--         self.m_defLayer = gs.LayerMask.LayerToName(self.m_model.layer)
--         if self.m_displayLayer and self.m_displayLayer ~= self.m_defLayer then
--             self:setDisplayLayer(self.m_displayLayer)
--         end
--         self.m_points[fight.FightDef.POINT_ROOT] = gs.GoUtil.FindNameInChilds(self.m_trans, "Root_node")
--         self.m_points[fight.FightDef.POINT_TOP] = gs.GoUtil.FindNameInChilds(self.m_trans, "Top_node")
--         self.m_points[fight.FightDef.POINT_SPINE] = gs.GoUtil.FindNameInChilds(self.m_trans, "Spine_node")
--         self.m_points[fight.FightDef.POINT_LWEAPON] = gs.GoUtil.FindNameInChilds(self.m_trans, "Weapon_L_node")
--         self.m_points[fight.FightDef.POINT_RWEAPON] = gs.GoUtil.FindNameInChilds(self.m_trans, "Weapon_R_node")
--         self.m_points[fight.FightDef.POINT_CAMERA] = gs.GoUtil.FindNameInChilds(self.m_trans, "Camera_node")
--         self.m_points[fight.FightDef.POINT_HIT] = gs.GoUtil.FindNameInChilds(self.m_trans, "Hit_node")

--         if self.m_weaponPath and self.m_weaponType then
--             local tmpWeaponPath = self.m_weaponPath
--             self.m_weaponPath = nil
--             self:addWeapon(tmpWeaponPath, self.m_weaponType, beAlwayEft)
--         end
--         for assemblyKey, liveAssembly in pairs(self.m_assemblyDict) do
--             if liveAssembly == false then
--                 self:addAssembly(assemblyKey)
--             end
--         end

--         self.m_ani = self.m_model:GetComponent(ty.AnimatCtrl)
--         if self.m_ani then
--             self.m_ani:LoadClipWithHash(self.m_awakeAnimaName)
--             if self.m_isMain == true then
--                 self:_setupAniCallSys()
--             end
--         end

--         self:_afterLoad()

--         if beAlwayEft then
--             self:_loadAlwaysEft()
--         end
--         if finishCall then finishCall(true, self) end
--     else
--         if finishCall then finishCall(false, self) end
--     end
-- end

function setPreLoadAnisByHashList(self, hashList, finishCall)
    if self.m_ani then
        self.m_ani:LoadAsynAniHashArray(hashList, finishCall)
    elseif self.m_model == nil then
        if not self.m_preLoadAnisHashList then
            self.m_preLoadAnisHashList = {}
        end
        table.mergeList(self.m_preLoadAnisHashList, hashList)
        self.m_preLoadAnisHashCall = finishCall
    else
        if finishCall then finishCall() end
    end
end

function setPreLoadAnis(self, stateNames, finishCall)
    if self.m_ani then
        self.m_ani:SetPreLoadAsyn02(stateNames, finishCall)
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
        --gs.TransQuick:Pos(self.m_trans, self.m_position.x, self.m_position.y, self.m_position.z)
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

-- 设置模型缩放
function setModelScale(self, cusScale)
    local defaultScale = 1
    if self:getModelId() and fight.RoleShowManager:getModelScale(self:getModelId()) then
        defaultScale = fight.RoleShowManager:getModelScale(self:getModelId())
    end
    if cusScale then
        defaultScale = defaultScale * cusScale
    end

    gs.TransQuick:Scale0(self.m_modelTrans, defaultScale)
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
    if pointTrans then
        return pointTrans.position
    end
end

-- 移除常驻特效
function removeAlwayEft(self)
    if self.m_alwayEfts then
        for _, eftGo in ipairs(self.m_alwayEfts) do
            gs.GameObject.Destroy(eftGo)
        end
        self.m_alwayEfts = nil
    end
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
    for _, v in ipairs(self.m_weaponList) do
        v:setDisplayLayer(displayLayer)
    end
    for _, liveAssembly in pairs(self.m_assemblyDict) do
        if liveAssembly ~= false then
            liveAssembly:setDisplayLayer(displayLayer)
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
    for _, v in ipairs(self.m_weaponList) do
        v:resetDefDisplayLayer()
    end
    for _, liveAssembly in pairs(self.m_assemblyDict) do
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
        else
            gs.GoUtil.ChangeLayer(self.m_rootGo, self.m_hideLayer)
        end
    end
    for _, v in ipairs(self.m_weaponList) do
        v:setVisible(beVisible)
    end
    for _, liveAssembly in pairs(self.m_assemblyDict) do
        if liveAssembly ~= false then
            liveAssembly:setVisible(beVisible)
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
    for _, v in ipairs(self.m_weaponList) do
        v:setTranparency(value)
    end
    for _, liveAssembly in pairs(self.m_assemblyDict) do
        if liveAssembly ~= false then
            liveAssembly:setTranparency(value)
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
function playAction(self, aniHash, startCall, endCall, isForceEndCall)
    if not self.m_ani then return end

    if self.m_isMain == true then
        self:setupOneCall(aniHash, startCall, endCall)
    end

    -- if aniHash ~= gs.Animator.StringToHash(self.m_awakeAnimaName) then 
    if self.m_curAniHash ~= aniHash then
        self.m_curAniHash = aniHash --用于外部获取记录
    end

    if isForceEndCall then
        self.m_isForceEndCall[aniHash] = endCall --是否需要动作中断也强制回调endcall
    else
        self.m_isForceEndCall[aniHash] = nil
    end

    -- end

    if not self.m_animatorLoadFinish then
        return
    end

    local function play()
        local exitTimeHash = fight.FightDef.HashExitTimeAnimation[aniHash]
        if exitTimeHash then
            self.m_ani:LoadClipWithHash(exitTimeHash)
        end

        self.m_ani:PlayHash(aniHash)
        if self.m_isMain and (startCall or endCall) and not self.m_ani:HaveClipWithHash(aniHash) then
            self.m_aniStartDisposableCallDict[aniHash] = nil
            self.m_aniEndDisposableCallDict[aniHash] = nil
            if startCall then startCall(aniHash) end
            if endCall then endCall(aniHash) end
        end
        for _, v in ipairs(self.m_weaponList) do
            v:playAction(aniHash)
        end
        for _, liveAssembly in pairs(self.m_assemblyDict) do
            if liveAssembly ~= false then
                liveAssembly:playAction(aniHash)
            end
        end
    end

    if not self:needAddShowItem(aniHash) then
        play()
    else
        self:playShowItem(aniHash, play)
    end
end
-- 播放动作带过渡
function playFade(self, aniHash, startCall, endCall, isForceEndCall)
    if not self.m_ani then return end

    if self.m_isMain == true then
        self:setupOneCall(aniHash, startCall, endCall)
    end

    -- if aniHash ~= gs.Animator.StringToHash(self.m_awakeAnimaName) then 
    if self.m_curAniHash ~= aniHash then
        self.m_curAniHash = aniHash --用于外部获取记录
    end

    if isForceEndCall then
        self.m_isForceEndCall[aniHash] = endCall --是否需要动作中断也强制回调endcall
    else
        self.m_isForceEndCall[aniHash] = nil
    end

    -- end

    if not self.m_animatorLoadFinish then
        return
    end

    local function play()
        self.m_ani:PlayFadeHash(aniHash)
        if self.m_isMain and (startCall or endCall) and not self.m_ani:HaveClipWithHash(aniHash) then
            self.m_aniStartDisposableCallDict[aniHash] = nil
            self.m_aniEndDisposableCallDict[aniHash] = nil
            if startCall then startCall(aniHash) end
            if endCall then endCall(aniHash) end
        end
        for _, v in ipairs(self.m_weaponList) do
            v:playAction(aniHash)
        end
        for _, liveAssembly in pairs(self.m_assemblyDict) do
            if liveAssembly ~= false then
                liveAssembly:playAction(aniHash)
            end
        end
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
        if self.m_isMain == true then
            self:setupOneCall(aniHash, startCall, endCall)
        end

        -- if aniHash ~= gs.Animator.StringToHash(self.m_awakeAnimaName) then 
        self.m_curAniHash = aniHash --用于外部获取记录

        if isForceEndCall then
            self.m_isForceEndCall[aniHash] = endCall --是否需要动作中断也强制回调endcall
        else
            self.m_isForceEndCall[aniHash] = nil
        end

        -- end

        if not self.m_animatorLoadFinish then
            return
        end

        local function play()
            local exitTimeHash = fight.FightDef.HashExitTimeAnimation[aniHash]
            if exitTimeHash then
                self.m_ani:LoadClipWithHash(exitTimeHash)
            end

            if (resetTriggerHash) then
                self.m_ani:ResetTriggers(resetTriggerHash)
            end
            self.m_ani:PlayTriggerCond(triggerHash)

            if self.m_isMain == true and (startCall or endCall) and not self.m_ani:HaveClipWithTriggerHash(triggerHash) then
                self.m_aniStartDisposableCallDict[aniHash] = nil
                self.m_aniEndDisposableCallDict[aniHash] = nil
                if startCall then startCall(aniHash) end
                if endCall then endCall(aniHash) end
            end
            for _, v in ipairs(self.m_weaponList) do
                v:playActionTrigger(triggerHash, nil, nil, resetTriggerHash)
            end
            for _, liveAssembly in pairs(self.m_assemblyDict) do
                if liveAssembly ~= false then
                    liveAssembly:playActionTrigger(triggerHash, nil, nil, resetTriggerHash)
                end
            end
        end

        if not self:needAddShowItem(aniHash) then
            play()
        else
            self:playShowItem(aniHash, play)
        end
    end
end

function getActionHashByTriggerHash(self, triggerHash)
    return fight.FightDef.TRANS_STATES[triggerHash]
end

-- 设置动作过渡布尔值
function setAnimationBoolVal(self, keyhash, val)
    if self.m_loadSn == 0 and self.m_ani then
        local aniHash = self:getActionHashByTriggerHash(keyhash)
        if aniHash then
            local function play()
                self.m_ani:SetBoolCondtion(triggerHash)

                for _, v in ipairs(self.m_weaponList) do
                    v:setAnimationBoolVal(keyhash, val)
                end
                for _, liveAssembly in pairs(self.m_assemblyDict) do
                    if liveAssembly ~= false then
                        liveAssembly:setAnimationBoolVal(keyhash, val)
                    end
                end
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
            self.m_ani:SetTriggerCondtion(keyhash)

            for _, v in ipairs(self.m_weaponList) do
                v:setAnimationTriggerVal(keyhash)
            end
            for _, liveAssembly in pairs(self.m_assemblyDict) do
                if liveAssembly ~= false then
                    liveAssembly:setAnimationTriggerVal(keyhash)
                end
            end
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

-- 获取动作时长
function getAniLenght(self, aniName)
    if self.m_ani then
        return self.m_ani:GetAniLenght(aniName)
    end
end
-- 设置动作速度
function setAniSpeed(self, aniSpeed)
    if self.m_aniSpeed ~= aniSpeed then
        self.m_aniSpeed = aniSpeed
        if self.m_loadSn == 0 and self.m_ani then
            self.m_ani:SetSpeed(self.m_aniSpeed)
            for _, v in ipairs(self.m_weaponList) do
                v:setAniSpeed(aniSpeed)
            end
            for _, liveAssembly in pairs(self.m_assemblyDict) do
                if liveAssembly ~= false then
                    liveAssembly:setAniSpeed(aniSpeed)
                end
            end
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
end

function getWeapon(self)
    return self.m_weaponList
end
-- 装载武器
function addWeapon(self, weaponPath, weaponType, beAlwayEft, finishCall)
    if self.m_weaponPath == weaponPath and self.m_weaponType == weaponType then return end
    self.m_weaponPath = weaponPath
    self.m_weaponType = weaponType
    if self.m_model == nil or self.m_loadSn ~= 0 then return end

    self:removeWeapon()
    -- 放右手
    if weaponType == 1 and self.m_points[fight.FightDef.POINT_RWEAPON] then
        self:_addWeapon(weaponPath, self.m_points[fight.FightDef.POINT_RWEAPON], beAlwayEft, finishCall)
        -- 放脚底
    elseif weaponType == 2 and self.m_points[fight.FightDef.POINT_ROOT] then
        self:_addWeapon(weaponPath, self.m_points[fight.FightDef.POINT_ROOT], beAlwayEft, finishCall)
        -- 放左手
    elseif weaponType == 3 then
        if self.m_points[fight.FightDef.POINT_RWEAPON] then
            self:_addWeapon(weaponPath, self.m_points[fight.FightDef.POINT_RWEAPON], beAlwayEft, finishCall)
        end
        if self.m_points[fight.FightDef.POINT_LWEAPON] then
            self:_addWeapon(weaponPath, self.m_points[fight.FightDef.POINT_LWEAPON], beAlwayEft, finishCall)
        end
    else
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
        self.m_LoadAni_Tab = { "stand", "exit", "goin", "atk01", "die", "hit01", "hit02", "hit03", "hit04", "hit05", "hit06", "getup", "skill01", "skill02", "skillmix", "skillmax", "win" }
    end
end

function _addWeapon(self, weaponPath, parent, beAlwayEft, finishCall)
    local liveWeapon = fight.LiveBase.new()
    liveWeapon.m_isMain = false
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
            -- if self.m_ani and liveWeapon.m_ani then
            --     local function _loadPlay()
            --         liveWeapon.s_loadPlaySn = nil
            --         liveWeapon.m_ani:LoadAnimatCtrlSameClip(self.m_ani)
            --         liveWeapon:setDisplayLayer(self.m_displayLayer)
            --         liveWeapon:setVisible(self.m_isVisible)
            --     end
            --     liveWeapon.s_loadPlaySn = LoopManager:setTimeout(0.1, self, _loadPlay)
            -- else
            --     liveWeapon:setDisplayLayer(self.m_displayLayer)
            liveWeapon:setVisible(self.m_isVisible)
            -- end
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
    -- liveWeapon:setVisible(false)
    liveWeapon:setupPrefab(weaponPath, beAlwayEft, _resultCall, 4)
end

function addAssembly(self, prefabPath, beAlwayEft, finishCall)
    self.m_assemblyDict[prefabPath] = false
    if self.m_model == nil or self.m_loadSn ~= 0 then return end

    local liveAssembly = fight.LiveBase.new()
    liveAssembly.m_isMain = false
    self.m_assemblyDict[prefabPath] = liveAssembly

    local function _resultCall(beSucss)
        if beSucss then
            local charAppend = liveAssembly.m_model:GetComponent(ty.CharAppendEffect)

            -- if self.m_ani and liveAssembly.m_ani then
            --     local function _loadPlay()
            --         liveAssembly.s_loadPlaySn = nil
            --         liveAssembly.m_ani:LoadAnimatCtrlSameClip(self.m_ani)
            --         liveAssembly:setDisplayLayer(self.m_displayLayer)
            --         liveAssembly:setVisible(self.m_isVisible)
            --         if charAppend then
            --             charAppend.CharSet = self.m_model
            --         end
            --         if finishCall then
            --             finishCall()
            --         end
            --     end
            --     liveAssembly.s_loadPlaySn = LoopManager:setTimeout(0.1, self, _loadPlay)
            -- else
            -- liveAssembly:setDisplayLayer(self.m_displayLayer)
            -- liveAssembly:setVisible(self.m_isVisible)
            if charAppend then
                charAppend.CharSet = self.m_model
            end
            if finishCall then
                finishCall()
            end
            -- end
        else
            self.m_assemblyDict[prefabPath] = nil
            liveAssembly:destroy()
        end
    end

    liveAssembly:setToParent(self.m_points[fight.FightDef.POINT_ROOT])
    -- liveAssembly:setVisible(false)
    liveAssembly:setupPrefab(prefabPath, beAlwayEft, _resultCall, 5)
end

function removeAssembly(self, prefabPath)
    local liveAssembly = self.m_assemblyDict[prefabPath]
    if liveAssembly and liveAssembly ~= false then
        LoopManager:clearTimeout(liveAssembly.s_loadPlaySn)
        liveAssembly:destroy()
    end
    self.m_assemblyDict[prefabPath] = nil
end

function clearAssembly(self)
    for _, liveAssembly in pairs(self.m_assemblyDict) do
        if liveAssembly ~= false then
            LoopManager:clearTimeout(liveAssembly.s_loadPlaySn)
            liveAssembly:destroy()
        end
    end
    self.m_assemblyDict = {}
end

function _afterLoad(self)
    if self.m_dLayer ~= nil then
        gs.GoUtil.ChangeLayer(self.m_rootGo, self.m_dLayer)
    end
    self.m_rootGo:SetActive(true)

    if self.m_ani then
        -- self.m_ani:LoadClipWithHash(fight.FightDef.ACT_GETUP)
        -- if not table.empty(self.m_weaponList) then
        --     for _, v in ipairs(self.m_weaponList) do
        --         if v.m_ani then
        --             v.m_ani:LoadAnimatCtrlSameClip(self.m_ani)
        --         end
        --     end
        -- end
        -- for _, liveAssembly in pairs(self.m_assemblyDict) do
        --     if liveAssembly ~= false then
        --         if liveAssembly.m_ani then
        --             liveAssembly.m_ani:LoadAnimatCtrlSameClip(self.m_ani)
        --         end
        --     end
        -- end

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
                -- self.m_model:SetActive(true)
            end
            self.m_ani:SetPreLoadAsyn02(self.m_preLoadAnis, _aniFinishCall)
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
                -- self.m_model:SetActive(true)
            end
            self.m_ani:SetPreLoadAsyn02(self.m_preLoadAnisHashList, _aniFinishCall)
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

function _loadAlwaysEft(self)
    self:removeAlwayEft()
    local ro = fight.FightLoader:getAlwayEftRo(self.m_prefabName)
    if ro then
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
            self:removeAssembly(UrlManager:getShowItemPath(itemPath))
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
            for i = #tmpLst, 1 do
                local itemPath = tmpLst[i]
                if tmpDict[itemPath] then
                    tmpDict[itemPath] = nil
                    --小道具可能有特效
                    self.m_assemblyDict[UrlManager:getShowItemPath(itemPath)].m_rootGo:SetActive(false)
                    self.m_assemblyDict[UrlManager:getShowItemPath(itemPath)].m_rootGo:SetActive(true)
                    table.remove(tmpLst, i)
                end
            end
            --移除上次遗留的跟这次不重复的道具
            if not table.empty(tmpDict) then
                for itemPath, _ in pairs(tmpDict) do
                    self:removeAssembly(UrlManager:getShowItemPath(itemPath))
                    self.m_actShowItems[itemPath] = nil
                end
            end

            if not table.empty(tmpLst) then
                for _, itemPath in ipairs(tmpLst) do
                    self:addAssembly(UrlManager:getShowItemPath(itemPath), nil, callFun)
                    self.m_actShowItems[itemPath] = true
                end
            else
                if callFun then
                    callFun()
                end
            end
        end
    end
end

-- 注册动作回调事件
function _setupAniCallSys(self)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_GOIN)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_READY)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_EXIT)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_ATTACK_1)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_SKILL_1)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_SKILL_2)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_SKILL_MIX)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_SKILL_MAX)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_DIE)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_WIN)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_WALK)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_GETUP)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_SHOW_STAND_TIME_1)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_SHOW_IDLE_TIME_1)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_LEAVE)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_ENTER)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_STANDBY)
    self.m_ani:AddNeedCallHash(fight.FightDef.ACT_CHANGE)

    local function _startCall(aniHash)
        -- print("_setupAniCallSys ", self.m_prefabName, aniHash)
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
    dict[sn] = { startCall = startCall, endCall = endCall }

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



return _M

--[[ 替换语言包自动生成，请勿修改！
]]