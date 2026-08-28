------------ import ------------
local CS         = CS
local Vector3    = CS.UnityEngine.Vector3
local Animator   = CS.UnityEngine.Animator
local Time       = CS.UnityEngine.Time
local Quaternion = CS.UnityEngine.Quaternion
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool

------------ import ------------

------------ define ------------

local RoleState = {
    OnGround = 1,               --- 角色仅踩在 ground surface 上;
    OnGroundAndClimbSteep = 2,  --- 角色紧贴着 steep surface;  同时 OnGround
    ClimbSteep = 3,             --- 角色紧贴着 steep surface;  同时 not OnGround
    Oth = 4,                    --- 剩余的所有状态, 比如 跳跃,下落 什么的, 当前版本 一律不处理;
}

local Mathf                      = Mathf
local AnimatorType               = typeof(CS.UnityEngine.Animator)
local RigidbodyType              = typeof(CS.UnityEngine.Rigidbody)
local BehaviourActionType        = typeof(CS.Engine.Lib.BehaviourAction)
local AnimatorMoveBehaviourType        = typeof(CS.Engine.Lib.AnimatorMoveBehaviour)

local ScaleFactorHash            = Animator.StringToHash("ScaleFactor")
local ForwardHash                = Animator.StringToHash("Forward")
local TurnRawHash                = Animator.StringToHash("TurnRaw")
local PlayerInputMagnitude_2Hash = Animator.StringToHash("PlayerInputMagnitude_2")
local PlayerInputFlagHash        = Animator.StringToHash("PlayerInputFlag")
------------ define ------------

---@class HumanControllerOnlyGround
local HumanControllerOnlyGround = Class('HumanControllerOnlyGround')


function HumanControllerOnlyGround:__init()
    self._gravity = -25
    -- Range(1f, 50f)
    self._yRotateMaxSpeed = 15 --- 角色转身速度
    -- 位移起步速度要快, 位移停止速度要慢
    self._startAccelerate = 20
    self._endAccelerate   = 10
    -- 小于此倾角的, 都算 ground surface
    -- Range(0f, 90f)
    self._maxGroundAngle = 45
    self._runSpeed = 1

    ---@type PlayerInput
    self._playerInput = nil

    --------------------------------
    --- component cache
    self._animator = nil
    self._rigidbody = nil
    self._transform = nil

    --------------------------------
    --- 运行时缓存
    self._currentSpeed = 0

    self._forwardAmount = 0
    self._turnAmount = 0 --- [-180f, 180f]

    self._minGroundDotProduct = 0

    self._roleState = RoleState.OnGround

    self._groundContactCount = 0 --- 本帧 接触的 ground surface 的数量
    self._steepContactCount = 0  --- 本帧 接触的 steep surface 的数量

    --- ground surfaces
    self._contactNormal = Vector3.zero 
    self._steepNormal = Vector3.zero

    self._animatorStateInfo = nil --- 本帧(物理帧) 正在播放的 anim clip 信息


    self.isInitComplete = false
end


function HumanControllerOnlyGround:__delete()
    if not isNull(self._behaviourAction) then
        self._behaviourAction.OnCollisionEnterAction = nil
        self._behaviourAction.OnCollisionStayAction = nil
        
    end

    if not isNull(self._animatorMoveBehaviour) then
        self._animatorMoveBehaviour.AnimatorMoveAction = nil
        
    end
end

--- Init
---@param role UnityEngine.GameObject
---@param playerInput PlayerInput
function HumanControllerOnlyGround:Init(role, playerInput)
    self._transform = role.transform
    self._animator  = role:GetComponent(AnimatorType)
    self._rigidbody = role:GetComponent(RigidbodyType)

    self._playerInput = playerInput

    self._layerIndex = self._animator:GetLayerIndex("Base Layer")

    self._rigidbody.useGravity = false --- 强关;
    self._rigidbody.isKinematic = false

    --- 为了单独修正 位移混合树, 但又不影响其他 anim clip 的速度
    --- 只有 位移混合树 启用 Multipler "ScaleFactor",
    --- 其余 anim clip 都不启用, (或改用别的 变量来控制)
    --- 就能纠正 humanScale 问题     
    self._animator:SetFloat( ScaleFactorHash, 1 / self._animator.humanScale );

    --- 可行走的 ground 坡度;
    self._minGroundDotProduct = Mathf.Cos(self._maxGroundAngle * Mathf.Deg2Rad);

    ---@type Engine.Lib.BehaviourAction
    local behaviourAction = KTool.GetOrAddComponent(role, BehaviourActionType)
    behaviourAction.OnCollisionEnterAction = Bind(self, self.OnCollisionEnter)
    behaviourAction.OnCollisionStayAction  = Bind(self, self.OnCollisionStay)
    self._behaviourAction = behaviourAction

    local animatorMoveBehaviour = KTool.GetOrAddComponent(role, AnimatorMoveBehaviourType)
    animatorMoveBehaviour.AnimatorMoveAction  = Bind(self, self.OnAnimatorMoveAction)
    self._animatorMoveBehaviour = animatorMoveBehaviour

    self.isInitComplete = true
end

function HumanControllerOnlyGround:Update()
    if not self.isInitComplete then
        return
    end

    self._forwardAmount = Vector3.Dot( self._playerInput:GetPlayerInputMoveVec(), self._transform.forward ) --- [0f,1f]
end

function HumanControllerOnlyGround:OnAnimatorMoveAction()
    if not self.isInitComplete then
        return
    end

    local animator = self._animator
    self._animatorStateInfo = animator:GetCurrentAnimatorStateInfo(self._layerIndex)

    self:UpdateState()

    local deltaTime = Time.deltaTime

    ---------------------------------------------------
    local targetSpeed = self._runSpeed * self._forwardAmount
    local k = (self._currentSpeed < targetSpeed and self._startAccelerate or self._endAccelerate) * deltaTime
    self._currentSpeed = Mathf.MoveTowards( self._currentSpeed, targetSpeed, k )

    local animator = self._animator
    --- 必须在此处调用... (在 FixedUpdate 周期中...)
    animator:SetFloat(ForwardHash, self._currentSpeed ); --- root motion
    ---animator:SetFloat( "ForwardRaw", forwardAmount ); --- [0f,1f]
    animator:SetFloat(TurnRawHash,      self._turnAmount );
    ---animator:SetFloat( "Turn",      turnAmount, 0.2f, deltaTime  ); --- 阻尼
    ---animator:SetFloat( "PlayerInputMagnitude", PlayerInput.PlayerInputMagnitude );
    ---animator:SetFloat( "PlayerInputMagnitude_2", PlayerInput.PlayerInputMagnitude_2 );
    ---animator:SetFloat( "PlayerInputMagnitude_2", PlayerInput.GetPlayerInputMagnitude_2( animatorStateInfo.IsTag("RunToStop") ) );
    animator:SetFloat(PlayerInputMagnitude_2Hash, self._playerInput:GetPlayerInputMagnitude2( false ) );
    animator:SetFloat(PlayerInputFlagHash,  self._playerInput:GetPlayerInputFlag() );


    ---------------------------------------------------
    --- 因为开启了 root motion, 一旦上一行代码被调用, "Forward" 被设置, animator 会自动计算出 本帧的 位移速度;
    local velocity = self._rigidbody.velocity 
    local animatorVelocity = animator.velocity
    animatorVelocity = Vector3( animatorVelocity.x, 0, animatorVelocity.z )

    local roleState = self._roleState
    if roleState == RoleState.OnGroundAndClimbSteep or roleState == RoleState.ClimbSteep then
        local upVec = self._playerInput:GetUpVec()
        --- 如果角色朝向 steep surface 方向运动, 就要把这个方向的运动分量剪掉;
        if Vector3.Dot( animatorVelocity.normalized, self._steepNormal ) < 0 then
            local steepNormalXZ = Vector3.ProjectOnPlane( self._steepNormal, upVec ).normalized;
            animatorVelocity = Vector3.ProjectOnPlane( animatorVelocity, steepNormalXZ );--- 仅保留 沿着 steep 滑动的分量;
        end
        velocity.x = animatorVelocity.x;
        velocity.z = animatorVelocity.z;

        --- 加大重力, 确保角色不会沿着 syeep surface 慢慢向上爬;
        --- 目前存在小瑕疵, 先让角色冲向 steep, 然后反身的那一帧, 角色还是会冲到 steep 上面去;
        -- velocity = velocity + upVec * self._gravity * deltaTime * (roleState == RoleState.OnGroundAndClimbSteep and 1 or 3);
        local num = self._gravity * deltaTime * (roleState == RoleState.OnGroundAndClimbSteep and 1 or 3)
        local deltaVel = Vector3(upVec.x * num, upVec.y * num, upVec.z * num)
        velocity = Vector3(velocity.x + deltaVel.x, velocity.y + deltaVel.y, velocity.z + deltaVel.z)

    elseif roleState == RoleState.OnGround then -- 站立在 ground 斜坡上 (静止 or 动态)
        --- 此时施加的不该是 重力, 而是沿着 -contactNormal 方向的力;
        --- 因为我们把 滑动摩擦力 和 静态摩擦力都关到了0, 此时若直接施加向下的重力, 会导致 角色在斜坡上下滑;
        local contactNormal = self._contactNormal
        velocity.x = animatorVelocity.x;
        velocity.z = animatorVelocity.z;

        -- velocity = velocity + contactNormal * (Vector3.Dot(Vector3.down, contactNormal) * deltaTime)
        local num = Vector3.Dot(Vector3.down, contactNormal) * deltaTime
        local deltaVel = Vector3(contactNormal.x * num, contactNormal.y * num, contactNormal.z * num)
        velocity = Vector3(velocity.x + deltaVel.x, velocity.y + deltaVel.y, velocity.z + deltaVel.z)

    else
        --- 剩余情况, 一律简略处理;
        velocity.x = animatorVelocity.x
        velocity.z = animatorVelocity.z
        -- velocity = velocity +  PlayerInput.upDir * gravity * Time.deltaTime;
        local num = self._gravity * deltaTime
        local upVec = self._playerInput:GetUpVec()
        local deltaVel = Vector3(upVec.x * num, upVec.y * num, upVec.z * num)
        velocity = Vector3(velocity.x + deltaVel.x, velocity.y + deltaVel.y, velocity.z + deltaVel.z)

    end

    self._rigidbody.velocity = velocity

    self:HandleTurn()

    self:ClearState()
end

function HumanControllerOnlyGround:UpdateState()
    if self._groundContactCount > 0 then
        self._roleState = RoleState.OnGround
        self._contactNormal:Normalize()
    else
        self._roleState = RoleState.Oth;
        self._contactNormal = self._playerInput:GetUpVec() 
    end

    self._steepNormal:Normalize() --- 零向量 归一化后 依然是 零向量;

    --- 角色紧贴 steep surface
    if self._steepContactCount > 0 then
        self._roleState = (self._roleState == RoleState.OnGround) and RoleState.OnGroundAndClimbSteep or RoleState.ClimbSteep
    end

    
end

function HumanControllerOnlyGround:HandleTurn()
    local transform = self._transform
    local roleTgtForward = self._playerInput:GetCurrentTgtMoveDirAndSetItValid()

    roleTgtForward = Vector3.ProjectOnPlane( roleTgtForward, transform.up ).normalized; -- 躺平到 角色 xz平面上; 此句可写可不写

    if Vector3.Dot( transform.forward, roleTgtForward ) > 0.999 then
        --- xz 平面的旋转夹角太小时, 就放弃播转动动画了;
        self._turnAmount = 0

    else
        local ang = Vector3.Angle( transform.forward, roleTgtForward );
        local Clockwise = Vector3.Dot( transform.up, Vector3.Cross( transform.forward, roleTgtForward )) < 0 and -1 or 1;
        self._turnAmount = Clockwise * ang;

    end

    local animatorStateInfo = self._animatorStateInfo
    --- !!!!!!
    --- 180 大回转 的 角色方向控制, 需要混合 root motion 和 代码逻辑
    if animatorStateInfo:IsTag("Turn180") then
        self:HandleTurn180RoleRotation( roleTgtForward )
        return
    end

    --- 不管在 idle 还是 move 状态, 都只允许在 [-145,145] 区间内执行 手动转身;
    local isNeedTurn = animatorStateInfo:IsTag("Idle") or (self._turnAmount > -145 and self._turnAmount < 145)
    if isNeedTurn then
        local forward = Vector3.RotateTowards( transform.forward, roleTgtForward, self._yRotateMaxSpeed * Time.deltaTime, 0 ).normalized; --- 在玩家平面上的 xz面旋转插值;
        local up = self._playerInput:GetUpVec()
        self._rigidbody:MoveRotation( Quaternion.LookRotation( forward, up ) )
        
    end
end

--- HandleTurn180RoleRotation
---@param roleTgtForward UnityEngine.Vector3
function HumanControllerOnlyGround:HandleTurn180RoleRotation(roleTgtForward)
    --- 首先让 root motion 播完它需要的 本帧 旋转;
    --- 设置 m_transform.rotation 后, m_transform.forward 会立马发生变化;
    -- m_transform.rotation *= animator.deltaRotation
    local transform = self._transform
    local animator  = self._animator
    transform.rotation = Quaternion.Dot(transform.rotation, animator.deltaRotation)

    --- 在大回转动画的后半段, 人为干预旋转角度, 让它朝向 玩家最新输入的 运动朝向;
    local k = Mathf.Clamp01( self._animatorStateInfo.normalizedTime ); --- 最后若干帧可能都为 1f;
    if k > 0.5 then
        k = k*k*k; --- 三阶曲线
        k = Mathf.Lerp( 0, k, 0.18 ); --- k值要尽可能小, 
        transform.forward = Vector3.Lerp( transform.forward, roleTgtForward, k );
        
    end
    
end

function HumanControllerOnlyGround:ClearState()
    self._contactNormal      = Vector3.zero
    self._steepNormal        = Vector3.zero
    self._groundContactCount = 0
    self._steepContactCount  = 0
end

--- OnCollisionEnter
---@param collision UnityEngine.Collision
function HumanControllerOnlyGround:OnCollisionEnter(_, collision)
    self:EvaluateCollision(collision)
end
--- OnCollisionStay
---@param collision UnityEngine.Collision
function HumanControllerOnlyGround:OnCollisionStay(_, collision)
    self:EvaluateCollision(collision)
end

function HumanControllerOnlyGround:EvaluateCollision(collision)
    local minGroundDotProduct = self._minGroundDotProduct
    for i = 0, collision.contactCount - 1, 1 do
        local normal = collision:GetContact(i).normal; --- surface normal
        local upDot = Vector3.Dot(self._playerInput:GetUpVec(), normal);
        if upDot >= minGroundDotProduct then --- 确定此平面为 ground
            local contactNormal = self._contactNormal
            self._contactNormal = Vector3(contactNormal.x + normal.x, contactNormal.y + normal.y, contactNormal.z + normal.z)
            self._groundContactCount = self._groundContactCount + 1
        else
            --- 坡度太陡了, 不属于 ground
            --- 但是只要这个 surface 不是朝向下方的, 那么都算是 steep surface;
            --- 暂不关心由多个 steep surface 构成的 虚拟 ground surface; (比如两个 steep surface 构成的 狭沟)
            if upDot > -0.01 then
                -- self._steepNormal = self._steepNormal + normal
                local steepNormal = self._steepNormal
                self._steepNormal = Vector3(steepNormal.x + normal.x, steepNormal.y + normal.y, steepNormal.z + normal.z)
                self._steepContactCount = self._steepContactCount + 1
            end
        end
    end

end

return HumanControllerOnlyGround
