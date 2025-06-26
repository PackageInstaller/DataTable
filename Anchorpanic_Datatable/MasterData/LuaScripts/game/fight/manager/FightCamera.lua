module('fight.FightCamera', Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)

    -- 战斗场阵trans
    self.m_gridTrans = nil
    -- 战斗镜头trans
    self.m_scTrans = nil
    -- 镜头总控trans
    self.m_scGeneralCtrlTrans = nil
    -- 镜头镜像trans
    self.m_scCameraRTTRans = nil
    -- 镜头动画trans
    self.m_scAniTrans = nil

    -- 相机初始位置和角度
    self.m_orgSCPoint = nil
    self.m_lOrgSCPoint = math.Vector3(0, 0, -10.5)
    self.m_lOrgSCRotation = math.Vector3(0, 0, 0)

    self.m_DtOrgSCPoint = math.Vector3(0, 3, 0)
    self.m_DtOrgSCRotation = math.Vector3(12, 0, 0)

    self.m_tempDtOrgSCPoint = self.m_DtOrgSCPoint
    self.m_tempDtOrgSCRotation = self.m_DtOrgSCRotation

    self.m_lastSCPoint = nil
    self.m_lastSCRotation = nil

    -- 单体和其他
    self.m_ScPoint_00 = math.Vector3(0, 2, -5)
    self.m_ScRotation_00 = math.Vector3(9, 0, 0)
    -- 全体镜头预设
    self.m_ScPoint_01 = math.Vector3(0, 3, -8)
    self.m_ScRotation_01 = math.Vector3(12, 0, 0)
    -- 直线镜头预设
    self.m_ScPoint_02 = math.Vector3(2, 3, -8)
    self.m_ScRotation_02 = math.Vector3(12, 0, 0)
    -- 整排镜头预设
    self.m_ScPoint_03 = math.Vector3(-2, 2.5, -8)
    self.m_ScRotation_03 = math.Vector3(9, 30, 0)
    -- 十字镜头预设
    self.m_ScPoint_04 = math.Vector3(0, 3, -8)
    self.m_ScRotation_04 = math.Vector3(12, 0, 0)
    -- 九宫镜头预设
    self.m_ScPoint_05 = math.Vector3(0, 3, -8)
    self.m_ScRotation_05 = math.Vector3(12, 0, 0)
    -- 单体后排
    self.m_ScPoint_06 = math.Vector3(0, 3, -8)
    self.m_ScRotation_06 = math.Vector3(12, 0, 0)
    -- boss超远镜头
    self.m_ScPoint_07 = math.Vector3(0.5, 3, -11)
    self.m_ScRotation_07 = math.Vector3(12, 0, 0)
    -- 近战 全体
    self.m_ScPoint_08 = math.Vector3(1.26, 3.4, -9.8)
    self.m_ScRotation_08 = math.Vector3(12, 0, 0)


    -- boss锁定视角战斗
    self.m_ScPoint_boss_fight = math.Vector3(-5.04, 0.99, 7.5)
    self.m_ScRotation_boss_fight = math.Vector3(-14.67, 71.76, -0.6)
    -- boss锁定视角常规
    self.m_ScPoint_boss = math.Vector3(-11.13, 0.9, 6.12)
    self.m_ScRotation_boss = math.Vector3(-17, 46.58, 0.37)
    -- boss锁定视角常规（小屏）
    self.m_ScPoint_boss_small = math.Vector3(-17.86, 0.9, -1)
    self.m_ScRotation_boss_small = math.Vector3(-17, 46.58, 0.37)

    self.m_offsetPosition = nil
    self.m_moveOffsetPosition = nil

    -- 当前action攻击者
    self.m_attackLiveVo = nil
    -- 当前action主受击者
    self.m_targetLiveVo = nil
    -- 当前action受影响战员列表
    self.m_actHeroList = nil

    -- 是否开启锁定视角
    self.m_isLockCamera = false

    -- 战斗相机类型 0默认 1跟随攻击者 2跟随选择
    self.m_fightCameraType = 0
    self.m_lockAttackLiveId = nil

    -- 锁定战员的相机挂点
    self.m_lockHeroCameraRt = nil
    self.m_lockHeroCameraDt = nil
    self.m_lockHeroCameraFt = nil

    self.m_lockHeroCameraDtOrg = gs.Vector3(0, 1.5, -3)

end

-- 设置锁定视角
function setCameraLock(self, modelId)
    local attackerRo = fight.RoleShowManager:getShowData(modelId)
    if attackerRo:getLockCamera() == 1 then
        self.m_isLockCamera = true

        local scPoint = self.m_ScPoint_boss
        local scRotation = self.m_ScRotation_boss

        local screenW, screenH = ScreenUtil:getScreenSize(nil)
        if screenW / screenH <= 1.5 then
            scPoint = self.m_ScPoint_boss_small
            scRotation = self.m_ScRotation_boss_small
        end

        self.m_tempDtOrgSCPoint = scPoint
        self.m_tempDtOrgSCRotation = scRotation
    else
        self.m_isLockCamera = false

        self.m_tempDtOrgSCPoint = self.m_DtOrgSCPoint
        self.m_tempDtOrgSCRotation = self.m_DtOrgSCRotation
    end
end

--设置相机显示隐藏
function setFightCamera(self, enable)
    if gs.CameraMgr:GetSceneCameraTrans() and gs.CameraMgr:GetSceneCameraTrans().gameObject then
        gs.CameraMgr:GetSceneCameraTrans().gameObject:SetActive(enable)
    end
end

-- 设置战斗中摄像机照射中心的初始位置
function setOrgPos(self, pos)
    self.m_lOrgSCPoint = pos
end

-- 设置战斗中摄像机照射中心的初始角度
function setOrgRotation(self, rotationV3)
    self.m_lOrgSCRotation = rotationV3
end

-- 移除相机及还原
function removeSCamera(self)
    self:resetTranparency()
    self:setFightCameraType(0)

    if self:getCameraTrans() then
        gs.CameraMgr:RemoveSceneCamera()
        self.m_scTrans = nil
    end

    self.m_lastSCPoint = nil
    self.m_lastSCRotation = nil

    self.m_isLockCamera = false

    self.m_tempDtOrgSCPoint = self.m_DtOrgSCPoint
    self.m_tempDtOrgSCRotation = self.m_DtOrgSCRotation
end

-- 获取当前摄像机
function getCameraTrans(self)
    if not self.m_scTrans or gs.GoUtil.IsTransNull(self.m_scTrans) then
        local tmpObj = gs.GameObject.Find("[SCamera]")
        if tmpObj then
            local cameraCom = tmpObj:GetComponent(ty.Camera)
            gs.CameraMgr:SetSceneCamera(cameraCom)
            if cameraCom then
                local layerIdx = gs.LayerMask.NameToLayer("HideLayer");
                gs.CameraMgr:RemoveCullingMask(cameraCom, layerIdx)
            end
        end
        self.m_scTrans = gs.CameraMgr:GetSceneCameraTrans()
    end
    return self.m_scTrans
end

-- 初始化各种节点，以及设置摄像机的父节点
function setCameraGeneralCtrl(self, sceneGrid)
    if sceneGrid then
        self.m_scTrans = gs.CameraMgr:GetSceneCameraTrans()
        self.m_scFilpTrans = sceneGrid:getFilpTrans()
        self.m_scAniTrans = sceneGrid:getAniTrans()
        self.m_gridTrans = sceneGrid:getRootTrans()
        self.m_scCameraDTTRans = sceneGrid:getCameraDTTrans()
        self.m_scCameraRTTRans = sceneGrid:getCameraRTTrans()

    else
        self.m_scFilpTrans = nil
        self.m_scCameraRTTRans = nil
        self.m_scAniTrans = nil
        self.m_gridTrans = nil
    end
    if not gs.GoUtil.IsTransNull(self:getCameraTrans()) then

        -- 镜头放在总控上
        self:getCameraTrans():SetParent(self.m_scCameraDTTRans, false)
        gs.TransQuick:LPos(self:getCameraTrans(), 0, 0, 0)
        gs.TransQuick:SetLRotation(self:getCameraTrans(), 0, 0, 0)

        gs.TransQuick:LPos(self.m_scCameraDTTRans, self.m_tempDtOrgSCPoint)
        gs.TransQuick:SetLRotation(self.m_scCameraDTTRans, self.m_tempDtOrgSCRotation)

        gs.TransQuick:SetLRotation(self.m_scCameraRTTRans, self.m_lOrgSCRotation.x, self.m_lOrgSCRotation.y, self.m_lOrgSCRotation.z)

        local rootPos = fight.SceneGrid:getRootTrans().position

        gs.TransQuick:LPos(self.m_scCameraRTTRans, self.m_lOrgSCPoint.x, self.m_lOrgSCPoint.y, self.m_lOrgSCPoint.z)
        self.m_offsetPosition = self.m_orgSCPoint - rootPos

        self.m_moveOffsetPosition = math.Vector3(self.m_offsetPosition.x, self.m_offsetPosition.y, self.m_offsetPosition.z)
    else
        self.m_scTrans = nil
        if self:getCameraTrans() and not gs.GoUtil.IsTransNull(self:getCameraTrans()) then
            gs.CameraMgr:SetCameraBack(self:getCameraTrans())
        end
    end
end

-- 初始化镜头位置
function focusOrg(self)
    if self:getCameraTrans() == nil or gs.GoUtil.IsTransNull(self:getCameraTrans()) then
        return
    end

    fight.SceneGrid:setFilpX(false)
    if self:getCameraTrans() then
        gs.TransQuick:LPos(self.m_scCameraDTTRans, self.m_tempDtOrgSCPoint)
        gs.TransQuick:SetLRotation(self.m_scCameraDTTRans, self.m_tempDtOrgSCRotation)
        gs.TransQuick:LPos(self.m_scCameraRTTRans, self.m_lOrgSCPoint)
        gs.TransQuick:SetLRotation(self.m_scCameraRTTRans, self.m_lOrgSCRotation)
    end
end

-- 播放镜头动画
function playCameraAni(self, beFlip, aniName)
    if SkillEditorDef and SkillEditorDef.IS_DISABLE_FIGHT_CAMERA == true then
        return
    end

    if self.m_isLockCamera == true then
        return
    end

    if self:getCameraTrans() == nil or gs.GoUtil.IsTransNull(self:getCameraTrans()) then
        return
    end

    fight.SceneGrid:playCameraAni(aniName)
    -- self.mBeFlip = beFlip
    -- -- 设置相机节点翻转（技能镜头镜像）
    -- fight.SceneGrid:setFilpX(beFlip)
    self:setBeFlip(beFlip)
end

-- 设置相机节点翻转（技能镜头镜像）
function setBeFlip(self, beFlip)
    if self.m_isLockCamera then
        return
    end
    self.mBeFlip = beFlip
    fight.SceneGrid:setFilpX(beFlip)
end

-- 把摄像机交给角色的挂点（奥义）
function focusOnLive(self, liveId)
    if SkillEditorDef and SkillEditorDef.IS_DISABLE_FIGHT_CAMERA == true then
        return
    end

    if liveId then
        local live = fight.SceneItemManager:getLivething(liveId)
        if live then
            gs.CameraMgr:SetCameraFixed(live:getLiveVo().isAtt)

            local point = live:getPointTrans(fight.FightDef.POINT_CAMERA)
            if point then
                self:getCameraTrans():SetParent(point, false)
                self.isFocusOnLive = true
            end
        end
    end

    gs.TransQuick:LPos(self:getCameraTrans(), 0, 0, 0)
    gs.TransQuick:SetLRotation(self:getCameraTrans(), 0, 180, 0)
end

-- 自由视角锁定战员
function lockOnLive(self, liveId)
    if SkillEditorDef and SkillEditorDef.IS_DISABLE_FIGHT_CAMERA == true then
        return
    end

    if liveId then
        self.m_lockAttackLiveId = liveId
        self:setFightCameraType(2)
    else
        self.m_lockAttackLiveId = nil
        self:setFightCameraType(1)
    end
end

-- 设置战斗镜头视角0常规，1跟随，2锁定
function setFightCameraType(self, type)
    self.m_fightCameraType = type
    self:updateCameraFollow()
end

-- 摄像机由角色挂点中退回到默认位置
function checkReturnCamera(self, cusTime)
    if self.isFocusOnLive then
        self.isFocusOnLive = false
        self.currLockLiveId = nil
    end
    if self.m_fightCameraType ~= 0 and self.m_attackLiveVo then
        self:updateCameraFollow()
        return
    end
    if self:getCameraTrans() then

        self.m_attackLiveVo = nil
        self.m_targetLiveVo = nil
        self.m_actHeroList = nil
        self.m_lastSCPoint = nil
        self.m_lastSCRotation = nil

        RateLooper:removeFrame(self, self.onFrame)
        self.isInFind = false

        if not self.m_scCameraDTTRans then
            gs.CameraMgr:SetCameraBack(self:getCameraTrans())
        end

        gs.TransQuick:LPos(self.m_scAniTrans, 0, 0, 0)
        gs.TransQuick:SetLRotation(self.m_scAniTrans, 0, 0, 0)
        gs.TransQuick:LPos(self:getCameraTrans(), 0, 0, 0)
        gs.TransQuick:SetLRotation(self:getCameraTrans(), 0, 0, 0)

        self:removeRoundTween()
        self:removeMoveScFileTween()
        self:removeReturnTween()

        if self:getCameraTrans().parent == self.m_scCameraDTTRans then
            local delayTime = cusTime or 1
            self.m_returnTweenList = {}

            table.insert(self.m_returnTweenList, fight.TweenManager:addTweener(TweenFactory:move2Lpos(self.m_scCameraRTTRans, self.m_lOrgSCPoint, delayTime, gs.DT.Ease.OutCubic)))
            table.insert(self.m_returnTweenList, fight.TweenManager:addTweener(TweenFactory:lRotate(self.m_scCameraRTTRans, self.m_lOrgSCRotation, delayTime)))
            table.insert(self.m_returnTweenList, fight.TweenManager:addTweener(TweenFactory:move2Lpos(self.m_scCameraDTTRans, self.m_tempDtOrgSCPoint, delayTime, gs.DT.Ease.OutCubic)))
            table.insert(self.m_returnTweenList, fight.TweenManager:addTweener(TweenFactory:lRotate(self.m_scCameraDTTRans, self.m_tempDtOrgSCRotation, delayTime)))
        else
            gs.CameraMgr:SetCameraFixed(0)
            self:getCameraTrans():SetParent(self.m_scCameraDTTRans, false)
            gs.TransQuick:LPos(self.m_scCameraRTTRans, self.m_lOrgSCPoint)
            gs.TransQuick:SetLRotation(self.m_scCameraRTTRans, self.m_lOrgSCRotation)
            gs.TransQuick:LPos(self.m_scCameraDTTRans, self.m_tempDtOrgSCPoint)
            gs.TransQuick:SetLRotation(self.m_scCameraDTTRans, self.m_tempDtOrgSCRotation)
        end
    end
end

function removeReturnTween(self)
    if self.m_returnTweenList then
        for _, tween in ipairs(self.m_returnTweenList) do
            tween:Kill()
        end
    end
    self.m_returnTweenList = {}
end

-- 当出手者不能出手，聚焦出手者的位置
function focusAttacker(self, cusAttackerVo, finishCall)
    if self.m_isLockCamera then
        return
    end
    self:removeReturnTween()
    local pos = cusAttackerVo.position
    pos = math.Vector3(pos.x, pos.y - 0.4, pos.z - 4.5)

    self:deepRound(pos, 1, finishCall)
end

-- 设置攻击者和目标
function setLiveVo(self, cusAttackerVo, cusTargetVo)
    self.m_attackLiveVo = cusAttackerVo
    self.m_targetLiveVo = cusTargetVo
end

-- 把攻击者和受击者显示到镜头内
function showHeroInCamera(self, cusAttackerVo, cusTargetVo)
    self.m_attackLiveVo = cusAttackerVo
    self.m_targetLiveVo = cusTargetVo
    if self.m_attackLiveVo == self.m_targetLiveVo or self.m_isLockCamera == true then
        return
    end

    local heroDis = gs.TransQuick:PosDist(cusAttackerVo.position, cusTargetVo.position)
    local cameraCom = gs.CameraMgr:GetSceneCamera()
    if cameraCom then
        local halfFOV = (cameraCom.fieldOfView * 0.5) * gs.Mathf.Deg2Rad
        local height = heroDis * 0.5 / cameraCom.aspect
        local cameraDis = height / gs.Mathf.Tan(halfFOV)
        cameraDis = math.max(math.abs(self.m_ScPoint_00.z), cameraDis)

        local centerPos = (cusAttackerVo.position + cusTargetVo.position) * 0.5
        local cameraPos = self.m_scCameraRTTRans.localPosition
        local curZ = math.min(cusAttackerVo.position.z, cusTargetVo.position.z)
        local newPos = math.Vector3(centerPos.x, cameraPos.y, curZ - cameraDis)
        self:deepRound(newPos, 0.5)
    end
    self.isInFind = true
    RateLooper:addFrame(1, 0, self, self.onFrame)
end

function onFrame(self)
    if self.mFlipPos and gs.CameraMgr:IsInView(self.m_attackLiveVo:getCurPos()) and
    gs.CameraMgr:IsInView(self.m_targetLiveVo:getCurPos()) then
        RateLooper:removeFrame(self, self.onFrame)
        -- RateLooper:setTimeout(0.2, self, function()
        self:moveScFilp(self.mBeFlip, self.mFlipPos, self.mSkillCamera, self.mOffsetZ, self.mTargetZ, self.mFlipTime)
        -- end)
    end
end

-- 镜头普通移动
function deepRound(self, pos, time, call)
    self.m_deepRoundTween = fight.TweenManager:addTweener(TweenFactory:move2Lpos(self.m_scCameraRTTRans, pos, time, gs.DT.Ease.OutCubic, call))
end

function removeRoundTween(self)
    if self.m_deepRoundTween then
        self.m_deepRoundTween:Kill()
        self.m_deepRoundTween = nil
    end
end

-- 镜头动作节点移动 beFlip 治疗偏移相反
function moveScFilpTrans(self, beFlip, flipPos, skillCamera, offsetZ, targetZ, flipTime)
    self.mBeFlip = beFlip
    self.mFlipPos = flipPos
    self.mSkillCamera = skillCamera
    self.mOffsetZ = offsetZ
    self.mTargetZ = targetZ
    self.mFlipTime = flipTime

    if not self.isInFind then
        self:moveScFilp(beFlip, flipPos, skillCamera, offsetZ, targetZ, flipTime)
    end
end

-- 移动镜头
function moveScFilp(self, beFlip, flipPos, skillCamera, offsetZ, targetZ, flipTime)
    if self.m_isLockCamera then
        if beFlip then
            self:checkReturnCamera()
            return
        end
        if not beFlip and self.m_attackLiveVo and self.m_attackLiveVo.isAtt == 1 then
            self.m_moveScFilpTweens = {}
            table.insert(self.m_moveScFilpTweens, fight.TweenManager:addTweener(TweenFactory:move2Lpos(self.m_scCameraDTTRans, self.m_ScPoint_boss_fight, 1, gs.DT.Ease.OutCubic)))
            table.insert(self.m_moveScFilpTweens, fight.TweenManager:addTweener(TweenFactory:lRotate(self.m_scCameraDTTRans, self.m_ScRotation_boss_fight, 1)))
        end
        return
    end

    if self.m_fightCameraType ~= 0 then
        self:updateCameraFollow()
        return
    end
    GameDispatcher:dispatchEvent(EventName.FIGHT_CAMERA_MOVE)

    self.m_lockHeroCameraRt = nil
    self.m_lockHeroCameraDt = nil
    self.m_lockHeroCameraFt = nil

    RateLooper:removeFrame(self, self.onFrame)
    self.isInFind = false
    self.mBeFlip = nil
    self.mFlipPos = nil
    self.mSkillCamera = nil
    self.mOffsetZ = nil
    self.mTargetZ = nil
    self.mFlipTime = nil

    self.mFlipPos = nil
    self.attactInView = false

    local offsetPos = gs.VEC3_ZERO
    local rotation = nil
    if skillCamera == 2 then
        -- 全体
        offsetPos = self:checkNeedToFar(self.m_ScPoint_01, 1)
        rotation = self.m_ScRotation_01

    elseif skillCamera == 3 then
        -- 直线
        offsetPos = self.m_ScPoint_02
        rotation = self.m_ScRotation_02
    elseif skillCamera == 4 then
        -- 整排
        offsetPos = math.Vector3(self.m_ScPoint_03.x, self.m_ScPoint_03.y, self.m_ScPoint_03.z - offsetZ)
        rotation = self.m_ScRotation_03

    elseif skillCamera == 5 then
        -- 十字
        offsetPos = math.Vector3(self.m_ScPoint_04.x, self.m_ScPoint_04.y, self.m_ScPoint_04.z - offsetZ)
        rotation = self.m_ScRotation_04

    elseif skillCamera == 6 then
        -- 九宫格
        offsetPos = math.Vector3(self.m_ScPoint_05.x, self.m_ScPoint_05.y, self.m_ScPoint_05.z - offsetZ)
        rotation = self.m_ScRotation_05

    elseif skillCamera == 7 then
        -- 后排
        offsetPos = self:checkNeedToFar(self.m_ScPoint_06, 1) -- math.Vector3(self.m_ScPoint_06.x, self.m_ScPoint_06.y, self.m_ScPoint_06.z - offsetZ)
        rotation = self.m_ScRotation_06

    elseif skillCamera == 8 then
        -- 多目标辅助技能（暂时用全体的镜头）
        offsetPos = self:checkNeedToFar(self.m_ScPoint_01, 1)
        rotation = self.m_ScRotation_01
    elseif skillCamera == 9 then
        -- boss超远镜头
        offsetPos = self:checkNeedToFar(self.m_ScPoint_07, 2)
        rotation = self.m_ScRotation_07
    elseif skillCamera == 10 then
        -- 近战 全体
        offsetPos = self:checkNeedToFar(self.m_ScPoint_08, 1)
        rotation = self.m_ScRotation_08
    else

        offsetPos = self.m_ScPoint_00
        rotation = self.m_ScRotation_00

        if math.abs(targetZ - offsetZ) > 2 then
            -- 两个人站对角线，拉远一点
            offsetPos = math.Vector3(offsetPos.x, offsetPos.y, offsetPos.z - 2)
        end

        if self.m_attackLiveVo and self.m_attackLiveVo == self.m_targetLiveVo then
            -- 目标为自己，推近点
            offsetPos = math.Vector3(offsetPos.x, offsetPos.y, offsetPos.z + 1)
        end
    end

    -- 受击者是boss类怪物需要增加攻击者的攻击距离
    local function getCameraValue(attacterData, targeterData, nomalData)
        local v3 = nil
        if table.empty(attacterData) and table.empty(targeterData) then
            return nomalData
        end
        if table.empty(attacterData) then
            return math.Vector3(targeterData[1], targeterData[2], targeterData[3])
        end
        if table.empty(targeterData) then
            return math.Vector3(attacterData[1], attacterData[2], attacterData[3])
        end

        if math.abs(attacterData[3]) > math.abs(targeterData[3]) then
            return math.Vector3(attacterData[1], attacterData[2], attacterData[3])
        else
            return math.Vector3(targeterData[1], targeterData[2], targeterData[3])
        end
    end
    if self.m_attackLiveVo and self.m_targetLiveVo then
        local attackerRo = fight.RoleShowManager:getShowData(self.m_attackLiveVo:getModelID())
        local targeterRo = fight.RoleShowManager:getShowData(self.m_targetLiveVo:getModelID())
        offsetPos = getCameraValue(attackerRo:getTargetCameraPonit(), targeterRo:getTargetCameraPonit(), offsetPos)
        rotation = getCameraValue(attackerRo:getTargetCameraRotation(), targeterRo:getTargetCameraRotation(), rotation)
    end


    -- 镜头移动到目标位置的速度
    local filpSpeed = 10
    local filpDis = math.v3Distance(flipPos, self.m_scCameraRTTRans.localPosition)
    local filpTime = flipTime or 1 -- filpDis / filpSpeed

    -- 相机云台旋转的速度
    local dtSpeed = 10
    local dtDis = math.v3Distance(offsetPos, self.m_scCameraDTTRans.localPosition)
    local dtTime = flipTime or 1 -- dtDis / dtSpeed

    self:removeRoundTween()
    self:removeReturnTween()
    self:removeMoveScFileTween()
    self.m_moveScFilpTweens = {}

    if not self.m_lastSCPoint or
    (self.m_lastSCPoint.x ~= flipPos.x or self.m_lastSCPoint.y ~= flipPos.y or self.m_lastSCPoint.z ~= flipPos.z) then

        local tempPos = math.Vector3(self.m_scCameraRTTRans.localPosition.x, self.m_scCameraRTTRans.localPosition.y, flipPos.z)
        local cPos = (tempPos + self.m_scCameraRTTRans.localPosition) * 0.5
        if math.abs(tempPos.x - self.m_scCameraRTTRans.localPosition.x) > 2 then
            cPos.x = cPos.x + 2 * ((beFlip and 1 or -1))
        end

        table.insert(self.m_moveScFilpTweens,
        fight.TweenManager:addTweener(TweenFactory:moveLocalBezier(self.m_scCameraRTTRans,
        self.m_scCameraRTTRans.localPosition, cPos, flipPos, filpTime, gs.DT.Ease.OutCubic, function()
            self:setTranparency()
        end)))
        table.insert(self.m_moveScFilpTweens, fight.TweenManager:addTweener(
        TweenFactory:lRotate(self.m_scCameraRTTRans, self.m_lOrgSCRotation, filpTime, nil)))

        self.m_lastSCPoint = flipPos
        self.m_lastSCRotation = self.m_lOrgSCRotation
    end

    offsetPos = math.Vector3(offsetPos.x * (beFlip and -1 or 1), offsetPos.y, offsetPos.z)
    table.insert(self.m_moveScFilpTweens, fight.TweenManager:addTweener(TweenFactory:move2Lpos(self.m_scCameraDTTRans, offsetPos, dtTime, gs.DT.Ease.OutCubic)))
    table.insert(self.m_moveScFilpTweens, fight.TweenManager:addTweener(TweenFactory:lRotate(self.m_scCameraDTTRans, rotation, dtTime)))
end

-- 是否需要拉远一点（后排，boss镜头，小屏幕要拉远点，不然看不到）
function checkNeedToFar(self, offsetPos, dis)
    local pos = offsetPos
    local rate = gs.Screen.height / gs.Screen.width
    if rate > 0.7 then
        pos = math.Vector3(offsetPos.x, offsetPos.y, offsetPos.z - dis)
    end
    return pos
end

-- 更新相机跟随
function updateCameraFollow(self)
    if self.isFocusOnLive then
        return
    end
    if self.m_fightCameraType == 1 and self.m_attackLiveVo and self.currLockLiveId ~= self.m_attackLiveVo.id then
        self.currLockLiveId = self.m_attackLiveVo.id
        local live = fight.SceneItemManager:getLivething(self.m_attackLiveVo.id)
        if live then
            self.m_lockHeroCameraRt = live:getPointTrans(fight.FightDef.POINT_CAMERA_RT)
            self.m_lockHeroCameraDt = live:getPointTrans(fight.FightDef.POINT_CAMERA_DT)
            self.m_lockHeroCameraFt = live:getPointTrans(fight.FightDef.POINT_CAMERA_FT)
            -- gs.TransQuick:LPos(self.m_lockHeroCameraDt, self.m_lockHeroCameraDtOrg)
            -- gs.TransQuick:SetLRotation(self.m_lockHeroCameraDt, self.m_lOrgSCRotation)
            gs.TransQuick:LPos(self.m_lockHeroCameraFt, gs.VEC3_ZERO)
            gs.TransQuick:SetLRotation(self.m_lockHeroCameraFt, gs.VEC3_ZERO)
            gs.TransQuick:SetParentOrg(self:getCameraTrans(), self.m_lockHeroCameraFt)
        end
    end
    if self.m_fightCameraType == 2 and self.m_lockAttackLiveId and self.currLockLiveId ~= self.m_lockAttackLiveId then
        self.currLockLiveId = self.m_lockAttackLiveId
        local live = fight.SceneItemManager:getLivething(self.m_lockAttackLiveId)
        if live then
            self.m_lockHeroCameraRt = live:getPointTrans(fight.FightDef.POINT_CAMERA_RT)
            self.m_lockHeroCameraDt = live:getPointTrans(fight.FightDef.POINT_CAMERA_DT)
            self.m_lockHeroCameraFt = live:getPointTrans(fight.FightDef.POINT_CAMERA_FT)
            -- gs.TransQuick:LPos(self.m_lockHeroCameraDt, self.m_lockHeroCameraDtOrg)
            -- gs.TransQuick:SetLRotation(self.m_lockHeroCameraDt, self.m_lOrgSCRotation)
            gs.TransQuick:LPos(self.m_lockHeroCameraFt, gs.VEC3_ZERO)
            gs.TransQuick:SetLRotation(self.m_lockHeroCameraFt, gs.VEC3_ZERO)
            gs.TransQuick:SetParentOrg(self:getCameraTrans(), self.m_lockHeroCameraFt)
        end
    end
    if self.m_fightCameraType == 0 then
        self:checkReturnCamera()
    end

end


-- 战场受击方中心点
function getGridCenter(self)
    local cameraPos
    if self.m_targetLiveVo:isAttacker() == 1 then
        cameraPos, _ = fight.SceneGrid:getACenter()
    else
        cameraPos, _ = fight.SceneGrid:getDCenter()
    end
    return cameraPos
end

-- 移除技能镜头缓动
function removeMoveScFileTween(self)
    if not table.empty(self.m_moveScFilpTweens) then
        for _, tween in ipairs(self.m_moveScFilpTweens) do
            tween:Kill()
        end
        self.m_moveScFilpTweens = nil
    end
end

-- 回到原点
function moveRestore(self, time)
    fight.SceneGrid:cameraAniNode2Org(time)
end

-- 设置战斗单位透明化
function setTranparency(self)
    if self.m_isLockCamera then
        return
    end
    local thingDic = fight.SceneManager:getAllThing()
    local skillAI = fight.FightAction:getCurSkillAI()

    if skillAI then
        local attackVo = skillAI:getAttackVo()
        local attackerPos = attackVo:getCurPos()
        local actHeroList = fight.FightManager:actionHeroList(skillAI:getActionData())
        if actHeroList and not table.empty(actHeroList) then
            local beFind = false
            for id, thing in pairs(thingDic) do
                beFind = false
                for _, hero in ipairs(actHeroList) do
                    if id == hero.hero_id then
                        thing:setTranparency(1)
                        beFind = true
                        break
                    end
                end
                local targetPos = thing:getCurPos()
                if beFind == false and targetPos then
                    local isInView = gs.CameraMgr:IsInView(targetPos)
                    local tempPos = math.Vector3(targetPos.x, self:getCameraTrans().position.y, targetPos.z)
                    local cameraDis1 = gs.TransQuick:PosDist(self:getCameraTrans(), targetPos)
                    local cameraDis = gs.TransQuick:PosDist(self:getCameraTrans(), tempPos)
                    if (isInView or cameraDis < 3) and targetPos.z < attackerPos.z and self.m_fightCameraType == 0 then
                        thing:setTranparency(0.35)
                    end
                    -- if cameraDis < 2.5 and targetPos.z < attackerPos.z then
                    --     thing:setTranparency(0)
                    -- end
                end
            end
        end
    end
end

function getFightCameraType(self)
    return self.m_fightCameraType
end

function getLockHeroCameraRt(self)
    return self.m_lockHeroCameraRt
end

function getLockHeroCameraDt(self)
    return self.m_lockHeroCameraDt
end

function getLockHeroCameraFt(self)
    return self.m_lockHeroCameraFt
end

-- 恢复战斗单位的透明化
function resetTranparency(self)
    local thingDic = fight.SceneManager:getAllThing()
    for _, thing in pairs(thingDic) do
        thing:setTranparency(1)
    end
end

-- 设置战斗相机景深片
function setCameraDof(self)
    self.fakeDof = gs.ResMgr:LoadGO("arts/prefabs/fightObj/FakeDof.prefab")
    gs.TransQuick:SetParentOrg(self.fakeDof.transform, self:getCameraTrans())
end

-- 设置4k录制画质
function setVideoQuality(self, camera)
    local defScamera = camera
    if not defScamera then
        defScamera = gs.CameraMgr:GetDefSceneCamera()
    end

    if (self.m_graphicBlitCamera == nil) then
        local go = gs.GameObject.Find("[RESOLUTION_CAMERA]")
        if not go or gs.GoUtil.IsGoNull(go) then
            go = gs.GameObject("[RESOLUTION_CAMERA]")
            self.m_graphicBlitCamera = go:AddComponent(ty.Camera)
            self.m_graphicBlit = go:AddComponent(ty.GraphicBlit)
        end
    end
    self.m_graphicBlitCamera.transform:SetParent(defScamera.transform)
    self.m_graphicBlitCamera.transform.localPosition = gs.Vector3.zero
    self.m_graphicBlitCamera.transform.localEulerAngles = gs.Vector3.zero

    self.m_graphicBlit:setRenderCamera(defScamera)

    local height = 4096
    local width = height / gs.Screen.height * gs.Screen.width
    self.m_graphicBlit:setResolution(width, height)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]