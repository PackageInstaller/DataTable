module("game.buildBase.BuildBaseQLive", Class.impl(model.modelLive))


--构造函数
function ctor(self)
    super.ctor(self)
    self.audioDataDic = {}

    --行走速度
    self.m_MoveSpeed = 0
    --AI随机寻路搜寻半径
    self.m_AIRandomRadius = 5

    --AI随机寻路最小范围
    self.m_AIRandomMinRadius = 2
end

-- 设置模型
function setModelID(self, liveId,priority,finishCall)
    self.m_liveId = liveId
    self.m_priority = priority or 1

    local config = hero.HeroCuteManager:getHeroCuteConfigVo(self.m_liveId)
    if config then
        self.m_MoveSpeed = config:getDormitorySpeed()

        local prefabPath = config.mModelPrefab

        if self.m_uiPrefabPath ~= prefabPath then
            self:setPrefab(prefabPath,finishCall)
            self.m_uiPrefabPath = prefabPath
        end
    end
    self:addEventListener()
end

function addEventListener(self)
end

function removeEventListener(self)

end

-- 设置模型
function setPrefab(self, prefabPath,callback)
    self:setupPrefab(prefabPath, beAlwayEft, callback)
end

function loadFinish(self,go,finishCall, sorceId)
    super.loadFinish(self,go,finishCall, sorceId) 
    self:addNavmeshAgent()

    if self.m_ani then
        self:setPreLoadAnisByHashList({DormitoryCost.ACT_SHOW_STAND,DormitoryCost.ACT_SHOW_TAB,DormitoryCost.ACT_SHOW_SHIFT,DormitoryCost.ACT_SHOW_DOWN,DormitoryCost.ACT_SHOW_WALK},callback)

        local function playWalkAudio()
            local mFsSoundPath = DormitoryCost.getRandomFSSount()
            if mFsSoundPath then
                -- 播放脚步声
                self:playAuido(mFsSoundPath)
            end
        end
        self.m_ani:AddFrameCallEvent("Qwalk_Audio", playWalkAudio)
    else
        logError("this model no animator,prefabName is " .. self.m_prefabName)
    end

    self:addAssembly("arts/character/pet/QModelCollider_00/QModelCollider_00.prefab",nil,function (assembly)
        if assembly then
            local mouseEvent = assembly.m_model:AddComponent(ty.GoMouseEvent)
            mouseEvent:SetCallFun(self, nil, self.onPointDownHandler, self.onPointerUpHandler, self.onPointerExitHandler)

            self.mCollider = assembly

            self:playAction(DormitoryCost.ACT_SHOW_STAND)

            self:setPosition(gs.UnityEngineUtil.GetNavMeshRandomPoint(gs.VEC3_ZERO,self.m_AIRandomRadius, self.m_AIRandomMinRadius))
            self:setVisible(true)

            self:startAI()

            -- 面向镜头
            local cameraTrans = gs.CameraMgr:GetSceneCameraTrans()
            self:turnDirByVector(cameraTrans.position, false)
        end
    end)
end

function addAssembly(self, prefabPath, beAlwayEft, finishCall)
    self.m_assemblyPathDic[prefabPath] = false

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
                finishCall(liveAssembly)
            end
        else
            self:removeAssembly(prefabPath)
        end
    end

    liveAssembly:setupPrefab(prefabPath, beAlwayEft, _resultCall, 5)
    liveAssembly:setToParent(self.m_trans)
    liveAssembly:setModelGoName("collider")
end

function playAction(self, aniHash, startCall, endCall)
    super.playAction(self, aniHash, startCall, endCall)

    if self.mCollider then
        self.mCollider:playAction(aniHash)
    end
end

-- 移走
function onPointerExitHandler(self)

end

-- 鼠标按下
function onPointDownHandler(self)
    self:stopAI()

    if not self.m_ani:IsPlayingShortNameHash(DormitoryCost.ACT_SHOW_TAB) then
        self:playAction(DormitoryCost.ACT_SHOW_TAB)
        self:playAuido("ui_dor_click_voice.prefab")

        self:playAuido("ui_dor_click.prefab")

        -- 面向镜头
        local cameraTrans = gs.CameraMgr:GetSceneCameraTrans()
        self:turnDirByVector(cameraTrans.position, false)
    end
end

-- 鼠标按下释放
function onPointerUpHandler(self)
   self:startAI()
end

-- 转向某个位置
function turnDirByVector(self, cusPosition)
    if self.m_position:equals(cusPosition) then
        return
    end

    local dir = (self.m_position - cusPosition)
    local angle = math.get_angle_ignoreY(math.Vector3.BACK, dir)
    self:setAngle(angle)
end

-- 设置角度
function setAngle(self, angle)
    self:stopTurnAngle()
    self.m_angle = angle
    gs.TransQuick:SetRotation(self.m_trans, 0, angle, 0)
end

function setPosition(self, lpos)
    if not lpos then return end
    if self.m_position == lpos then return end
    self.m_position:copy(lpos)
    if self.m_trans and lpos then
        gs.TransQuick:Pos(self.m_trans, self.m_position.x, self.m_position.y, self.m_position.z)
    end
end

-- 停止转向
function stopTurnAngle(self)
    if self.m_angle_tweener ~= nil then
        self.m_angle_tweener:Kill()
        self.m_angle_tweener = nil
    end
end

-- 清除模型
function clearModel(self)
    self:removeEventListener()
    self:clearAudio()
    self:stopAI()
    self:clearTimer()
    self.mCollider = nil
    
    super.clearModel(self)
end

--播放音效
function playAuido(self, audioName)
    local audioData = nil
    local finishCall = function()
        if audioData then
            self.audioDataDic[audioData.m_snId] = nil
        end
    end
    audioData = AudioManager:playSoundEffect(UrlManager:getDormSoundPath(audioName), false, nil, self.m_trans, finishCall)
    if audioData then
        self.audioDataDic[audioData.m_snId] = audioData
    end
end

--清理音效
function clearAudio(self)
    for k, v in pairs(self.audioDataDic) do
        AudioManager:stopAudioSound(v)
    end
    self.audioDataDic = {}
end

--设置模型节点名字
function setModelGoName(self)
    self.m_rootGo.name = "buildBaseCutLive_root"
end

function getSetUpCallAniHash(self)
    return 
    {
        DormitoryCost.ACT_SHOW_IDLE
    }
end


------------------------------------------------------------------------------------AI相关-------------------------------------------------------------------------------------------
--是否需要AI
function setNeedAI(self,value)
    self.m_needAI = value
    self:addNavmeshAgent()
end

---添加寻路组件
function addNavmeshAgent(self)
    if not self.m_needAI then return end

    if self.m_rootGo then
        self.m_NavMeshAgent = gs.GoUtil.AddComponent(self.m_rootGo, ty.NavMeshAgent)
        self.m_NavMeshAgent.enabled = false

        -- 允许NavMesh旋转角色
        self.m_NavMeshAgent.updateRotation = false
        -- 允许NavMesh移动角色
        self.m_NavMeshAgent.updatePosition = true
        -- 允许NavMesh开启
        self.m_NavMeshAgent.enabled = true
        
        -- 根据配置来设定速度
        self.m_NavMeshAgent.speed = self.m_MoveSpeed
        -- 转弯角速度
        self.m_NavMeshAgent.angularSpeed = 120
        -- 加速度
        self.m_NavMeshAgent.acceleration = 8
        -- 距离目标位置的停止距离
        self.m_NavMeshAgent.stoppingDistance = 0
        -- 自动刹车，不开启可能会在目标点附近来回晃动
        self.m_NavMeshAgent.autoBraking = true
        
        -- agent半径
        self.m_NavMeshAgent.radius = 0.3
        -- agent高度
        self.m_NavMeshAgent.height = 1
        -- 规避的质量水平，设定越高，权衡规避障碍的精度越高
        self.m_NavMeshAgent.obstacleAvoidanceType = gs.ObstacleAvoidanceType.GoodQualityObstacleAvoidance
        -- 优先权
        self.m_NavMeshAgent.avoidancePriority = self.m_priority

        -- 自动跳跃链接
        self.m_NavMeshAgent.autoTraverseOffMeshLink = true
        -- 如果当前路径无效，尝试获得一个新的路径
        self.m_NavMeshAgent.autoRepath = true
    end
end

--设置寻路优先级
function setNavPriority(self,priority)
    if self.m_NavMeshAgent == nil or gs.GoUtil.IsCompNull(self.m_NavMeshAgent) then 
        return
    end

    priority = priority or self.m_priority
    self.m_NavMeshAgent.avoidancePriority = priority
end

--开始AI
function startAI(self)
    if not self.m_needAI then 
        return 
    end

    if self.m_NavMeshAgent == nil or gs.GoUtil.IsCompNull(self.m_NavMeshAgent) then 
        logError("未设置AI,请先设置AI")
        return
    end
    if not self.mRoleTimerId then
        self.mRoleTimerId = LoopManager:addTimer(5, 0, self, self.onAIStep)
    end

    -- self:onAIStep()
end
--停止AI
function stopAI(self)
    LoopManager:removeTimerByIndex(self.mRoleTimerId)
    self.mRoleTimerId = nil

    self:stopMove()
end

function onAIStep(self)
    if self.m_Moveing then return end

    local random1 = math.random(0, 1)
    if random1 > 0.5 then
        self:startMove()
    else
        local list = DormitoryCost.ACT_SHOW_LIST
        local random2 = math.random(1, #list)
        local action = list[random2]
        self:playAction(action)
    end
end

--AI寻路
function startMove(self)
    self:stopMove()
    local point = gs.UnityEngineUtil.GetNavMeshRandomPoint(self.m_position,self.m_AIRandomRadius, self.m_AIRandomMinRadius)
    self:movePoint(point)
end
--停止寻路移动
function stopMove(self)
    if not self.isMoveing then return end

    self:setNavPriority(0)
    self.m_NavMeshAgent:ResetPath()

    self.isMoveing = false
    self:playAction(DormitoryCost.ACT_SHOW_STAND)

    self:clearTimer()
end

----更新移动
function updateMove(self)
    if self.isMoveing and gs.Vector3.Distance(self.m_trans.position, self.m_CurFindPoint) <= 0.1 then
        self:stopMove()
        if self.m_MoveFinishCall then 
            self.m_MoveFinishCall()
        end
    else
        self.m_NavMeshAgent:SetDestination(self.m_CurFindPoint)
        self:turnDirByVector(self.m_NavMeshAgent.nextPosition)

        if not self.m_ani:IsPlayingShortNameHash(DormitoryCost.ACT_SHOW_WALK) then
            self:playAction(DormitoryCost.ACT_SHOW_WALK)
        end
        self.isMoveing = true 

        self:setPosition(self.m_trans.position)
    end
end

--寻路到某个点
function movePoint(self,pos,finishCall)
    self.m_CurFindPoint = pos
    self.m_MoveFinishCall = finishCall

    self:setNavPriority()

    self.isCanMove = true

    self:clearTimer()
    if self.m_MoveFrameSn == nil then
        self.m_MoveFrameSn = LoopManager:addFrame(1, 0, self, self.updateMove)
    end
end

--清理计时器
function clearTimer(self)
    if self.m_MoveFrameSn ~= nil then
        self.m_MoveFrameSn = LoopManager:removeFrameByIndex(self.m_MoveFrameSn)
    end
end

return _M
