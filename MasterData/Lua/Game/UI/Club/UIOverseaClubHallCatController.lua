-------------------------------------------------------------------------------
-- 社团 - 社团大厅 - 猫咪控制器
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-23 16:54:04
-------------------------------------------------------------------------------

---@class UIOverseaClubHallCatController
---@field Env UIOverseaClubHallCatController
---@field controller Engine.Modules.LuaBehaviour
local UIOverseaClubHallCatController = Class('UIOverseaClubHallCatController')


-------------------------------------------------------------------------------
local GameObject          = CS.UnityEngine.GameObject
local Input          = CS.UnityEngine.Input
local KeyCode          = CS.UnityEngine.KeyCode
local Quaternion          = CS.UnityEngine.Quaternion
local Animator = CS.UnityEngine.Animator
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Time = CS.UnityEngine.Time
local AnimatorClipInfo = CS.UnityEngine.AnimatorClipInfo
local Random = CS.UnityEngine.Random
local Mathf = CS.UnityEngine.Mathf

local SphereCollider = CS.UnityEngine.SphereCollider
local Rigidbody = CS.UnityEngine.Rigidbody
local RigidbodyConstraints = CS.UnityEngine.RigidbodyConstraints
local CapsuleCollider = CS.UnityEngine.CapsuleCollider

local KTool = CS.Engine.Lib.KTool
local URPCameraController = CS.Game.Native.URP.URPCameraController.Instance
local ChatConstants       = import('Game.OverseaChat.ChatConstants')
---@type UIOverseaClubHallCatControllerConstants
local ControllerConstants = import("Game.UI.Club.UIOverseaClubHallCatControllerConstants")
local FSM = import("Game.UI.Club.Controller.FSM.FSM")
local FSMConstants = import("Game.UI.Club.Controller.FSM.OverseaClubStateConstants")

----------------------------------------------------
local BubbleLuaPath  = 'Game.UI.Club.UIOverseaClubHallCatBubbleNode'
local BubbleShowTime = 5 -- 显示时间




-----------------------------------------------------
function UIOverseaClubHallCatController:__init()
    ---@type integer @ 玩家id
    self.playerId_ = 0
    
    ---@type integer @ 所在格子x位置
    self.cellPosX_ = 0

    ---@type integer @ 所在格子z位置
    self.cellPosZ_ = 0

    ---@type UnityEngine.Transform @ 原始气泡节点
    self.bubbleSource_ = nil

    ---@type UnityEngine.Transform @ 气泡父节点
    self.bubbleParent_ = nil
    
    ---@type UIOverseaClubHallCatBubbleNode @ 气泡节点
    self.bubbleNode_ = nil

    self.isInit = false

    ---@type OverseaClubFSM
    self.fsm = nil
end


function UIOverseaClubHallCatController:__delete()
    self.playerId_    = nil
    self.cellPosX_     = nil
    self.cellPosZ_     = nil
    self.bubbleSource_ = nil
    self.bubbleParent_ = nil
    self.bubbleNode_   = nil
    self.fsm = nil
end


function UIOverseaClubHallCatController:Start()
    self.newGroupChatMsgEventCb_ = Events.AddListener(ChatConstants.EventNames.NEW_GROUP_CHAT_MESSAGE, Bind(self, self.OnReceiveGroupChatMsgHandler_))
end



function UIOverseaClubHallCatController:OnDestroy()
    Events.RemoveListener(tostring(ChatConstants.EventNames.NEW_GROUP_CHAT_MESSAGE), self.newGroupChatMsgEventCb_)
    if self.bubbleNode_ then
        CfUtils.SafeDelete(self.bubbleNode_.controller.gameObject)
        self.bubbleNode_ = nil
    end
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIOverseaClubHallCatController:GetPlayerId()
    return checkInt(self.playerId_)
end


---@return integer
function UIOverseaClubHallCatController:GetCellPosX()
    return checkInt(self.cellPosX_)
end


---@return integer
function UIOverseaClubHallCatController:GetCellPosZ()
    return checkInt(self.cellPosZ_)
end


-------------------------------------------------
-- public

function UIOverseaClubHallCatController:OnInitEnv(initArgs)
    self.playerId_    = checkInt(initArgs.playerId)
    self.cellPosX_     = checkInt(initArgs.cellPosX)
    self.cellPosZ_     = checkInt(initArgs.cellPosZ)
    self.bubbleSource_ = initArgs.bubbleNode
    self.bubbleParent_ = initArgs.parentNode

    

    ----------
    self.animator = KTool.GetComponent(self.controller.gameObject, typeof(Animator))
    assert( self.animator );
    self.animatorLayIndex = self.animator:GetLayerIndex("BaseLayer")
    -- 直接进入 简易npc猫控制器 用的 节点图中:
    self:_IntoNewAnimatorGraph()

    self.isMainCat = GameUtils.IsMySelfPlayerId(self:GetPlayerId())

    --- 给猫绑上碰撞体, 确保它们不会和 场景内的物体碰撞:   -- todo: 未来再使用这一版方案...
    -- local rigidbody = KTool.GetOrAddComponent( self.controller.gameObject, typeof(Rigidbody) )
    -- rigidbody.constraints = RigidbodyConstraints.FreezeRotation
    -- ---
    -- local sphereCollider = KTool.GetOrAddComponent( self.controller.gameObject, typeof(SphereCollider) )
    -- sphereCollider.radius = 0.25
    -- sphereCollider.center = Vector3( 0, 0.251, 0 )
    

    self.transform = self.controller.transform
    ----- 装配初始化假数据:
    self.catMode = ControllerConstants.CatMode.Auto
    self.autoInfo = {
        isInTmpIdle = false,  -- 当前帧是否从一个 有效 state 中返回到 idle clip; (然后等待分配新的随机 state)
        lastLegalState = nil, -- 最近设置的一个有效的 state. (也可能是当前正在执行的 state) 不会是 idle 这种过度 state
        duration = 0,
        startTime = Time.time,
    }

    self.interactIndex = -1 -- !! 仅 server 调用
    self.fsm = FSM.New()
    self.fsm:Init(self, FSMConstants, FSMConstants.Sit)

    if self.isMainCat == true then
        self:SwitchToManual( Vector3.forward, true )
        self:InitCollider()
    end    

    if initArgs.playerConnect then
        self:SetCatPos(initArgs.initPos)
        self:SetCatRot(initArgs.initRot)
        if not self.isMainCat then
            self:SwitchToServerMode()
        end
        self.initPos = self.transform.position 
    else
        --- 进入社区场景时, npc猫随机游走, 且赋予随机初始朝向: 
        --self:_AutoMode_Switch()
        self.initPos = self.transform.position  -- must before fsm:AutoMode_Switch()
        self:_LookAt( self:_GetRandomMoveDir(150) )
        self.fsm:AutoMode_Switch()
    end
    ---
    
    ----------------------------
    self.isInit = true

    self.lastSyncPos = self.transform.position
    self.lastSyncRot = self.transform.forward
end

function UIOverseaClubHallCatController:InitCollider()
    local rigidbody = KTool.GetOrAddComponent(self.controller.gameObject, typeof(Rigidbody))
    rigidbody.angularDrag = 0
    rigidbody.drag = 0
    rigidbody.constraints = 116

    local collider = KTool.GetOrAddComponent(self.controller.gameObject, typeof(CapsuleCollider))
    collider.direction = 3
    collider.radius = 0.2
    collider.height = 0.6
end


function UIOverseaClubHallCatController:OnUpdate()
    if self.isInit ~= true then 
        return
    end 
    -------------------------------------------------
    -- update bubble
    if self.bubbleNode_ and CfUtils.IsActive(self.bubbleNode_.controller) then
        
        -- update position
        self:SyncBubblePosition_()

        -- check lifecycle
        local currentTime = os.time()
        local displayTime = self.bubbleNode_:GetShowTimestamp() + BubbleShowTime
        local disableTime = self.bubbleNode_:GetHideTimestamp()
        if disableTime > 0 then
            -- check hide
            if currentTime >= disableTime then
                CfUtils.SetActive(self.bubbleNode_.controller, false)
            end
        else
            -- check show
            if currentTime >= displayTime then
                self.bubbleNode_:DoHide()
            end
        end
    end

    self.fsm:OnUpdate()
end

-----------------------------------  -------------

function UIOverseaClubHallCatController:MoveStart()
    self.inMove = true
    self:_IntoNewAnimatorGraph()
    self.fsm:ChangeState(FSMConstants.Walk)
end

function UIOverseaClubHallCatController:MoveEnd()
    self.inMove = false
    if not self.focus then
        self.fsm:ChangeState(FSMConstants.Idle)
    end
end

function UIOverseaClubHallCatController:Move(inputVec)
    self.transform.position = self.transform.position + Time.deltaTime * ControllerConstants.catMoveMaxSpeed * inputVec

    local smoothForward = Vector3.Slerp( self.transform.forward, inputVec, 0.3 ).normalized
    self.transform:LookAt( self.transform.position + smoothForward, Vector3.up  )
    self.transform.forward = inputVec
end




-- function UIOverseaClubHallCatController:_AutoMode_Switch() -- !!! 未被使用
--     -- 让 walk 和其它状态区分开来处理:
--     local random1 = Random.Range(0.0,1.0)
--     if  random1 < 0.5 then         
--         if self.autoInfo.lastLegalState ~= ControllerConstants.CatAutoState.Walk or Random.value < 0.3 then 
--             self:_SwitchTo_Auto_Walk()
--         end
--     else 
--         self:_AutoMode_SwitchWithoutMove()
--     end
--     --self:_AutoMode_SwitchWithoutMove()
-- end



-- 在所有 非移动类 auto state 里随机
-- function UIOverseaClubHallCatController:_AutoMode_SwitchWithoutMove() -- !!! 未被使用
--     local randomVV = Random.Range(0.0, 5.0)
--     if      randomVV < 1 then 
--         if self.autoInfo.lastLegalState ~= ControllerConstants.CatAutoState.Sit then -- sit 动画有个缺陷, 就是它不存在 sit<->idle 的过度动画, 这导致进出它的过程有点生硬;
--             self:_SwitchTo_Auto_Sit()  -- 占: 1
--         end
--     elseif randomVV < 2 then
--         if self.autoInfo.lastLegalState ~= ControllerConstants.CatAutoState.Sleep then
--             self:_SwitchTo_Auto_Sleep() -- 占: 1
--         end
--     elseif randomVV < 3 then
--         if self.autoInfo.lastLegalState ~= ControllerConstants.CatAutoState.Touch_01 then
--             self:_SwitchTo_Auto_Touch_01() -- 占: 1
--         end
--     elseif randomVV < 4 then
--         if self.autoInfo.lastLegalState ~= ControllerConstants.CatAutoState.Touch_02 then
--             self:_SwitchTo_Auto_Touch_02() -- 占: 1
--         end
--     else
--         if self.autoInfo.lastLegalState ~= ControllerConstants.CatAutoState.Touch_03 then
--             self:_SwitchTo_Auto_Touch_03() -- 占: 1
--         end
--     end
-- end



function UIOverseaClubHallCatController:PlayAnimation(index) -- !! server 调用的
    if self.inMove then
        return
    end

    if self.interactIndex == index then
        return
    else
        self:_IntoNewAnimatorGraph()
    end

    self.interactIndex = index

    if index >= 1 and index <= 3 then
        self.fsm:ChangeState(FSMConstants.Interact)
    elseif index == 4 then
        self.fsm:ChangeState(FSMConstants.Sit)
    elseif index == 5 then
        self.fsm:ChangeState(FSMConstants.Sleep)
    end
end



--- 判断是否需要同步到服务端
function UIOverseaClubHallCatController:NeedSyncPositionToServer()
    local flag = false

    if Vector3.Distance(self.lastSyncPos, self.transform.position) > 0.001 then
        flag = true
    end

    if Vector3.Distance(self.lastSyncRot, self.transform.forward) > 0.001 then
        flag = true
    end

    return flag
end

function UIOverseaClubHallCatController:SyncPositionToServer()
    if self:NeedSyncPositionToServer() then

        self.lastSyncPos = self.transform.position
        self.lastSyncRot = self.transform.forward
        local uploadData = {}
        uploadData["pos"] = {self.lastSyncPos.x, self.lastSyncPos.y, self.lastSyncPos.z}
        uploadData["rot"] = {self.lastSyncRot.x, self.lastSyncRot.y, self.lastSyncRot.z}

        if AppService then  -- 处于大厅中，注销登录（比如账号另外登录被挤）会报错 AppService 为空
            AppService:GetInstance():SendTcpData(Constants.Packets.OverseaClubPostPlayerPosition, uploadData)
        end
        ClubUtils.GetClubComp().scenePositionData[tostring(self:GetPlayerId())] = uploadData

        return true
    end

    return false
end

function UIOverseaClubHallCatController:ConnectToServer()
    self.lastSyncPos = self.transform.position
    self.lastSyncRot = self.transform.forward
    local uploadData = {}
    uploadData["pos"] = {self.lastSyncPos.x, self.lastSyncPos.y, self.lastSyncPos.z}
    uploadData["rot"] = {self.lastSyncRot.x, self.lastSyncRot.y, self.lastSyncRot.z}
    if AppService then  -- 处于大厅中，注销登录（比如账号另外登录被挤）会报错 AppService 为空
        AppService:GetInstance():SendTcpData(Constants.Packets.OverseaClubEnter, uploadData)
    end
end

----------------------------------- public switch Mode ------------------------------------------

function UIOverseaClubHallCatController:IsAutoMode()
    return self.catMode == ControllerConstants.CatMode.Auto
end

function UIOverseaClubHallCatController:IsServerMode()
    return self.catMode == ControllerConstants.CatMode.Server
end

function UIOverseaClubHallCatController:IsManualMode()
    return self.catMode == ControllerConstants.CatMode.Manual
end

function UIOverseaClubHallCatController:SwitchToAutoMode()

    if self.isMainCat == false then
        printError("SwitchToAutoMode")
    end

    self:_IntoNewAnimatorGraph()
    self.catMode = ControllerConstants.CatMode.Auto
    --self.fsm:ChangeState(FSMConstants.Sleep)
    self.fsm:ChangeState(FSMConstants.Walk)

    
end

function UIOverseaClubHallCatController:SwitchToServerMode() -- 这只猫当前在线, 且受到别的玩家控制
    -- if self.isMainCat == false then
    --     printError("SwitchToServerMode")
    -- end

    self.catMode = ControllerConstants.CatMode.Server
    self.autoInfo.tgtPos = self.transform.position
    self.autoInfo.tgtRot = self.transform.forward
    self:_IntoNewAnimatorGraph()
    self.fsm:ChangeState(FSMConstants.Sit)
end

---@param lookAtDir_ UnityEngine.Vector3
function UIOverseaClubHallCatController:SwitchToManual( lookAtDir_, immediately )
    if self.isMainCat == false then
        printError("SwitchToManual")
    end
    -- self:_SwitchTo_Auto_Sit()
    self.catMode = ControllerConstants.CatMode.Manual
    self:_LookAt( lookAtDir_ )
    self:_IntoNewAnimatorGraph()

    self.fsm:ChangeState(FSMConstants.Sit)

    if immediately then
        self.animator:Play(ControllerConstants.clipName_old_sit_02, self.animatorLayIndex, 1)
    end
    
end

function UIOverseaClubHallCatController:BeginFocusCat( lookAtDir_ )
    self.focus = true
    self.fsm:ChangeState(FSMConstants.Sit)
    self:_LookAt( lookAtDir_ )
end

function UIOverseaClubHallCatController:EndFocusCat()
    self.focus = false
    self.fsm:ChangeState(FSMConstants.Idle)
end

function UIOverseaClubHallCatController:SyncCatPosition(data)
    -- self.autoInfo.tgtPos = data.pos
    -- self.autoInfo.tgtRot = data.rot
    local position = self.autoInfo.tgtPos
    position.x = data.pos[1]
    position.y = data.pos[2]
    position.z = data.pos[3]

    local forward = self.autoInfo.tgtRot
    forward.x = data.rot[1]
    forward.y = data.rot[2]
    forward.z = data.rot[3]

    self.fsm:ChangeState(FSMConstants.Walk)
end


function UIOverseaClubHallCatController:GetCatCurrentPos() 
    return self.transform.position
end

function UIOverseaClubHallCatController:GetCatInitPos() 
    return self.initPos
end

function UIOverseaClubHallCatController:SetCatPos( pos_ )
    if pos_ == nil then
        return
    end

    local pos = self.transform.position
    pos.x = pos_[1]
    pos.y = pos_[2]
    pos.z = pos_[3]
    self.transform.position = pos
end

function UIOverseaClubHallCatController:SetCatRot( forward_ )
    if forward_ == nil then
        return
    end

    local forward = self.transform.forward
    forward.x = forward_[1]
    forward.y = forward_[2]
    forward.z = forward_[3]
    self.transform.forward = forward
end

function UIOverseaClubHallCatController:SetTransform(transform)
    self.transform:SetPositionAndRotation(transform.position, transform.rotation)
end

--------------------------------- switch in Auto Mode ----------------------------------------------------


-- 注意, 本函数和下面系列函数不一样, 本函数只是为了应付当前简陋的 新动画状态机的 临时之举:
-- 就是让 猫在播完每一个 有效 state 之后, 都主动回一次 idle, 然后再选择新的 随机 state...
function UIOverseaClubHallCatController:_SwitchTo_Auto_TmpIdle()
    self.autoInfo.isInTmpIdle = true
    self.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_idle_club )
end


function UIOverseaClubHallCatController:_SwitchTo_Auto_Walk()
    if self.catMode ~= ControllerConstants.CatMode.Auto then 
        --printError("catMode 异常, 放弃 switch")
        return
    end 
    self.autoInfo.isInTmpIdle = false
    self.autoInfo.lastLegalState = ControllerConstants.CatAutoState.Walk
    self.autoInfo.startTime = Time.time
    self.autoInfo.duration = KTool.Remap( 0.0, 1.0, ControllerConstants.randomDuration_Walk.min, ControllerConstants.randomDuration_Walk.max, Random.value )
    self.autoInfo.tgtPos = self:_GetLegalRandowMoveTargetPos()
    self.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_walk_club )
end 


function UIOverseaClubHallCatController:_SwitchTo_Auto_Sit()
    -- if self.catMode ~= CatMode.Auto then 
    --     printError("catMode 异常, 放弃 switch")
    --     return
    -- end 
    self.autoInfo.isInTmpIdle = false
    self.autoInfo.lastLegalState = ControllerConstants.CatAutoState.Sit
    self.autoInfo.startTime = Time.time
    self.autoInfo.duration = KTool.Remap( 0.0, 1.0, ControllerConstants.randomDuration_Sit.min, ControllerConstants.randomDuration_Sit.max, Random.value )
    self.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_sit_club )
end 


function UIOverseaClubHallCatController:_SwitchTo_Auto_Sleep()
--     if self.catMode ~= CatMode.Auto then 
--         printError("catMode 异常, 放弃 switch")
--         return
--     end 
    self.autoInfo.isInTmpIdle = false
    self.autoInfo.lastLegalState = ControllerConstants.CatAutoState.Sleep
    self.autoInfo.startTime = Time.time
    self.autoInfo.duration = KTool.Remap( 0.0, 1.0, ControllerConstants.randomDuration_Sleep.min, ControllerConstants.randomDuration_Sleep.max, Random.value )
    self.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_sleep_club )
end 


function UIOverseaClubHallCatController:_SwitchTo_Auto_Touch_01()
    -- if self.catMode ~= CatMode.Auto then 
    --     printError("catMode 异常, 放弃 switch")
    --     return
    -- end 
    self.autoInfo.isInTmpIdle = false
    self.autoInfo.lastLegalState = ControllerConstants.CatAutoState.Touch_01
    self.autoInfo.startTime = Time.time
    self.autoInfo.duration = KTool.Remap( 0.0, 1.0, ControllerConstants.randomDuration_Touch_01.min, ControllerConstants.randomDuration_Touch_01.max, Random.value )
    self.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_touch_01_club )
end 

function UIOverseaClubHallCatController:_SwitchTo_Auto_Touch_02()
    -- if self.catMode ~= CatMode.Auto then 
    --     printError("catMode 异常, 放弃 switch")
    --     return
    -- end 
    self.autoInfo.isInTmpIdle = false
    self.autoInfo.lastLegalState = ControllerConstants.CatAutoState.Touch_02
    self.autoInfo.startTime = Time.time
    self.autoInfo.duration = KTool.Remap( 0.0, 1.0, ControllerConstants.randomDuration_Touch_02.min, ControllerConstants.randomDuration_Touch_02.max, Random.value )
    self.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_touch_02_club )
end 

function UIOverseaClubHallCatController:_SwitchTo_Auto_Touch_03()
    -- if self.catMode ~= CatMode.Auto then 
    --     printError("catMode 异常, 放弃 switch")
    --     return
    -- end 
    self.autoInfo.isInTmpIdle = false
    self.autoInfo.lastLegalState = ControllerConstants.CatAutoState.Touch_03
    self.autoInfo.startTime = Time.time
    self.autoInfo.duration = KTool.Remap( 0.0, 1.0, ControllerConstants.randomDuration_Touch_03.min, ControllerConstants.randomDuration_Touch_03.max, Random.value )
    self.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_touch_03_clb )
end 


------------------------------------------------------------------------------------------

function UIOverseaClubHallCatController:_IntoNewAnimatorGraph()
    -- 直接进入 简易npc猫控制器 用的 节点图中:
    self.animator:Play( ControllerConstants.clipName_idle, self.animatorLayIndex )
end



function UIOverseaClubHallCatController:_OnMove(animatorStateInfo_)

    -- if animatorStateInfo_.shortNameHash ~= clipName_walk then 
    --     --printError("不在 walk clip")
    --     --return
    -- else 
    --     --print("可 walk ------")
    -- end 

    local oldPos = self.transform.position
    local tgtPos = self.autoInfo.tgtPos
    local distance = (tgtPos-oldPos).magnitude
    if distance > 0.001  then
        if not self.inMove then
            self:MoveStart()
        end
        
        --- need move
        local tgtForward = (tgtPos - oldPos).normalized

        local dotVal = Vector3.Dot( tgtForward, self.transform.forward )
        local magnitude = Mathf.Clamp01( KTool.Remap( -1, 0.6, 0, 1, dotVal )) -- 当角色正在转身时, 位移幅度变小一点;

        local smoothForward = Vector3.Slerp( self.transform.forward, tgtForward, 0.3 ).normalized
        self.transform:LookAt( oldPos + smoothForward, Vector3.up  )
        ---
        self.transform.position = Vector3.MoveTowards( oldPos, tgtPos, Time.deltaTime * ControllerConstants.catMoveMaxSpeed * 0.6 * magnitude )
    else
        self.inMove = false
        if self.autoInfo.tgtRot then
            self.transform.forward = self.autoInfo.tgtRot
        end
        --- need idle
        self.fsm:ChangeState(FSMConstants.Idle)
    end 
end



-------------------------------------------------
-- private

function UIOverseaClubHallCatController:AppendMessage_(data)
    if isNull(self.bubbleSource_) then return end
    if isNull(self.bubbleParent_) then return end
    
    if not self.bubbleNode_ then
        ---@type UnityEngine.GameObject
        local bubbleNode = GameObject.Instantiate(self.bubbleSource_, self.bubbleParent_)
        bubbleNode.name  = 'BubbleNode_' .. self:GetPlayerId()
        self.bubbleNode_ = CfUtils.GetLuaScr(bubbleNode.gameObject, BubbleLuaPath)
        bubbleNode.transform.localScale = Vector3(0.02, 0.02, 0.02)
    end
    
    if self.bubbleNode_ then
        self.bubbleNode_:DoShow(data)
        CfUtils.SetActive(self.bubbleNode_.controller, true)
    end
end


function UIOverseaClubHallCatController:SyncBubblePosition_()
    if isNull(self.bubbleSource_) then return end

    local bubbleTf = self.bubbleNode_.controller.transform
    local modelTf  = self.controller.transform
    local modelPos = modelTf.position
    modelPos.y = modelPos.y + 0.4

    local isChange = Vector3.Distance(bubbleTf.position, modelPos) > 0.001
    if isChange then
        bubbleTf.position = modelPos
        bubbleTf.localRotation = Quaternion.LookRotation(modelTf.forward)
    end

    -- 让 ui元素始终朝向 mainCamera
    local mainCamera = URPCameraController.mainCamera
    local lookAtPos  = bubbleTf.position + mainCamera.transform.rotation * Vector3.back
    local worldUpDir = mainCamera.transform.rotation * Vector3.up
    bubbleTf:LookAt( lookAtPos, worldUpDir )
    bubbleTf:Rotate( 0.0, 180.0, 0.0 )
end


-------------------------------------------------
-- handler

function UIOverseaClubHallCatController:OnReceiveGroupChatMsgHandler_(data)
    local socialLine    = AppService:GetInstance():GetSocialLine()
    local serverChannel = checkNumber(data.chatChannel)
    local chatChannel   = socialLine:ServerChannelToChannel(serverChannel)

    -- 工会聊天信息
    if checkNumber(chatChannel) == ChatConstants.Channels.Union then
        if checkInt(data.playerId) == self.playerId_ then
            self:AppendMessage_(data)
        end
    end
end



-----------------------------------------------

function UIOverseaClubHallCatController:_GetLegalRandowMoveTargetPos()
    local newPos = self:_GetRandomMoveTargetPos( 90 )
    local oldPos = self.transform.position
    --while (newPos-oldPos).magnitude < 0.2 do 
    if (newPos-oldPos).magnitude < 0.2 then 
        newPos = self:_GetRandomMoveTargetPos( 150 ) -- 增大旋转半角,  让猫能从边缘处走出来
        print("find new pos = " .. newPos:ToString() )
    end 
    return newPos
end


---@param maxRotateRadius_ number @ 旋转半角, degree
function UIOverseaClubHallCatController:_GetRandomMoveTargetPos( maxRotateRadius_ )
    if type(maxRotateRadius_) ~= "number" then 
        maxRotateRadius_ = 90
    end 

    local dir = self:_GetRandomMoveDir( maxRotateRadius_ ) -- 让猫尽量选择前半球方向, 不要整天走 180度大回转
    local radius = self.isMainCat and ControllerConstants.CatActiveRegion.mainCatRadius 
                        or ControllerConstants.CatActiveRegion.npcCatRadius

    if isNull(self.initPos) then 
        printError("异常, 依然存在地方导致 initPos 为空")
        self.initPos = Vector3.zero
    end 

    local pos = self.initPos + dir * (KTool.Remap( 0.0, 1.0, 0.1, 1, Random.value ) * radius)

    -- clamp to legal region:
    pos.x = Mathf.Clamp(pos.x,  ControllerConstants.CatActiveRegion.xRange.x, ControllerConstants.CatActiveRegion.xRange.y )
    pos.z = Mathf.Clamp(pos.z,  ControllerConstants.CatActiveRegion.zRange.x, ControllerConstants.CatActiveRegion.zRange.y )
    return pos
end 



function UIOverseaClubHallCatController:_LookAt( dir_ ) 
    self.transform:LookAt( self.transform.position + dir_, Vector3.up )
end 


function UIOverseaClubHallCatController:_GetRandomMoveDir( range_ ) 
    local oldAngle = UIOverseaClubHallCatController.Dir2Angle( self.transform.forward, Vector3.forward, Vector3.up )
    range_ = Mathf.Abs(range_)
    local newAngle = UIOverseaClubHallCatController.SafeDegree( oldAngle + Random.Range( -range_, range_ ))
    return UIOverseaClubHallCatController.Angle2Dir( newAngle, Vector3.forward, Vector3.up )
end


---@param degree_ number
---@return number
function UIOverseaClubHallCatController.SafeDegree( degree_ )
    while degree_ < 0.0 do
        degree_ = degree_ + 360.0
    end    
    while  degree_ >= 360.0 do
        degree_ = degree_ - 360
    end
    return degree_
end


---@param dir_ UnityEngine.Vector3
---@param angleInitDir_ UnityEngine.Vector3
---@param axis_ UnityEngine.Vector3
---@return number
function UIOverseaClubHallCatController.Dir2Angle( dir_, angleInitDir_, axis_ )
    dir_ = Vector3.ProjectOnPlane( dir_, axis_ )
    local angle = Vector3.SignedAngle( angleInitDir_, dir_, axis_ )
    return UIOverseaClubHallCatController.SafeDegree(angle)
end



---@param degree_ UnityEngine.Vector3
---@param angleInitDir_ UnityEngine.Vector3
---@param dir_ UnityEngine.Vector3
---@return UnityEngine.Vector3
function UIOverseaClubHallCatController.Angle2Dir( degree_, angleInitDir_, axis_ )
    local ret = Quaternion.AngleAxis( degree_, axis_ ) * angleInitDir_
    return ret.normalized
end






return UIOverseaClubHallCatController
