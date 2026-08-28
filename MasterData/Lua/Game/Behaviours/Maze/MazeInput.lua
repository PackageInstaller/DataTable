--- 统一管理 春节迷宫内的 用户输入 (鼠标, 触控)
--- Created by zou hanjie.
--- DateTime: 2022/12/03
---@class MazeInput
local MazeInput = Class('MazeInput')

-- =========================================================== -- 

local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders

---@type Maze2DStates
local Maze2DStates = import('Game.Behaviours.Maze.Maze2DStates')

local Input = CS.UnityEngine.Input
local Time = CS.UnityEngine.Time
local KeyCode = CS.UnityEngine.KeyCode
local Mathf = CS.UnityEngine.Mathf
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local CinemachineVirtualCamera = CS.Cinemachine.CinemachineVirtualCamera
local LensSettings = CS.Cinemachine.LensSettings
local EventSystem = CS.UnityEngine.EventSystems.EventSystem

local TouchPhase = CS.UnityEngine.TouchPhase

local CSRay = CS.UnityEngine.Ray
local CSBounds = CS.UnityEngine.Bounds


--- funtoy:
local KTool = CS.Engine.Lib.KTool
local IDComp = CS.Game.Native.Common.ID

local CinemachineVirtualCamera = CS.Cinemachine.CinemachineVirtualCamera


-- =========================================================== -- 

-- 画布缩放比例: 
local MinScreenZoomVal = 1.0
local MaxScreenZoomVal = 1.6 -- 1.5

local screenZoomSpeed = 10.0 -- 缩放速度
local screenMoveSpeed = 1.0 -- 屏幕滑动速度, 务必在 1.0 周围浮动
local screenMoveThreshold = 0.1 -- 玩家单击按下屏幕直到松开, 在此期间只要滑动屏幕的距离超过此值. 即可判定 "玩家正在滑动屏幕"

local screenZoomInDir = Vector3( 1.0, 1.0, 0.0 ).normalized -- pc模式下人为规定的 screenZoom "放大" 方向, (在此向量半球内都算放大)

-- =========================================================== -- 

---@param mazeMain_ MazeMain
function MazeInput:__init( mazeMain_, mainCamera_, vcam_,  DoHitTrackNodeGOOrBubbleFunc_  )
    --print("   ~~~~~~~ MazeInput:__init() ~~~~~~~")

    Input.multiTouchEnabled = true -- !!! 进入迷宫后需要 开启 多点触控

    self.mazeMain = mazeMain_
    self.cameraPivot = mazeMain_.cameraPivot
    self.mapPivotLeftBottom = mazeMain_.mapPivotLeftBottom
    self.mapPivotRightTop = mazeMain_.mapPivotRightTop

    assert(  self.mapPivotLeftBottom or self.mapPivotRightTop )

    self.vcam = vcam_
    self.initOrthographicSize = self:GetVCamOrthographicSize()
    assert( not isNull(self.initOrthographicSize) )


    self.initOrthographicSize = self:GetVCamOrthographicSize()


    self.DoHitTrackNodeGOOrBubbleFunc = DoHitTrackNodeGOOrBubbleFunc_ -- 函数指针

    self.isMobile = KTool.IsMobile()

    self.screenZoom = 1.0 -- 画布缩放, 允许范围: [MinScreenZoomVal, MaxScreenZoomVal]

    -- 其实此值暂未被用到...
    self.screenCenterPosSS = Vector3(
        SCREEN_WIDTH / 2.0, -- 如: 1920/2.0
        SCREEN_HEIGHT / 2.0, -- 如: 1080/2.0
        0.0
    )

    -- 0表示缩放的第一帧, 之后逐帧递增, -1 表示不在缩放状态
    -- pc端的 双指触碰检测要比 移动端复杂 (shift+鼠标左键), 故采用 frameIdx 来统一管理, 是比较保守的方案;
    self.screenZoomFrameIdx = -1
    self.screenMoveFrameIdx = -1

    -- 背景地图四个边的界限, 边缘碰撞检测用
    self.mapBottom = self.mapPivotLeftBottom.position.z 
    self.mapTop    = self.mapPivotRightTop.position.z 
    self.mapLeft   = self.mapPivotLeftBottom.position.x 
    self.mapRight  = self.mapPivotRightTop.position.x

    -- 背景地图 半高半宽, 用来约束 screenZoom 上界
    self.mapHalfWidth = (self.mapRight - self.mapLeft) * 0.5
    self.mapHalfHeight = (self.mapTop - self.mapBottom) * 0.5 

    self.isInScreenMove = false -- 表示本次触控(从点下到离开) 被判定为 "screenMove"
end



function MazeInput:__delete()
    --print("   ~~~~~~~ MazeInput:__delete() ~~~~~~~")
    Input.multiTouchEnabled = false -- !!! 离开迷宫时需要 关闭 多点触控
    self.mazeMain = nil
    self.isMobile = nil
end


-- =============================================================== Self -> ================================================================== -- 



-- 主函数
---@return void
function MazeInput:MainUpdate()
    --print("MainUpdate")

    self:UpdateIsPointerOverGameObject()

    ----------------- 双指缩放屏幕: screenZoom ------------------
    do
        local isMultiTouch, touchPos1, touchPos2 = self:IsMultiTouch()
        if isMultiTouch then 
            --printError("检测到 多点触控")
            if  self.screenZoomFrameIdx < 0 then 
                self.screenZoomFrameIdx = 0
            end
            self:DoScreenZoom( touchPos1, touchPos2 )
            self.screenZoomFrameIdx = self.screenZoomFrameIdx + 1
            return -- !!! 立刻退出
        else 
            if self.screenZoomFrameIdx > 0 then
                -- 善后 screenZoom:
                self.screenZoomFrameIdx = -1
                self.screenMoveFrameIdx = -1 -- 多点触控 一定会打断 单点移动
                self.screenZoomLastDistance = nil
                self.screenZoomLastPos = nil
            end
        end
    end

    ----------------- 单指滑动屏幕: screenMove ------------------
    do 
        local isSingleTouch,touchPos = self:IsSingleTouch() 
        if isSingleTouch then
            --printError("检测到 单点触控")
            if  self.screenMoveFrameIdx < 0 then 
                self.screenMoveFrameIdx = 0
                self.isInScreenMove = false
            end
            local isMoveingScreen = self:DoScreenMove( touchPos )
            self.screenMoveFrameIdx = self.screenMoveFrameIdx + 1

            if isMoveingScreen then 
                self.isInScreenMove = true
            end
        else
            if self.screenMoveFrameIdx >= 0 then 
                -- 善后 screenMove:
                self.screenMoveFrameIdx = -1
                self.screenMoveInitPos = nil
                self.screenMoveLastPos = nil
            end
        end
    end

    ------------------- 单指点击 trackNodeGo 或 bubble ----------------
    do
        -- 假设玩家本想拖动屏幕, 但手指直接点在了 bubble 上, 此时会导致误触, 使用 IsSingleTouchUp() 来规避此问题
        local isSingleTouchUp,touchPos = self:IsSingleTouchUp()
        if      (self.isInScreenMove == false) -- 如果本次 触控周期被判断为 "screenMove" 了, 那么就不再触发 点击事件
            and isSingleTouchUp 
            and (self.mazeMain.isInPuzzle == false) -- 部分迷宫(迷宫2)的解谜环节会彻底屏蔽 "trackNodeGo 和 bubble 的点击" 
        then  

            cs_coroutine.start(function()
                -- 在此处延缓两帧, 以规避 谜题解谜按钮 和 地面节点/bubble 同时按下时的冲突
                -- (此时应该优先允许 谜题解谜按钮 执行)
                -- 这是不是最好的办法...
                coroutine.yield(Yielders.EndOfFrame)
                coroutine.yield(Yielders.EndOfFrame)

                --if      Maze2DStates.isInAutoControl <= 0                                       -- 没有按下其它界面按钮了
                if      Maze2DStates.IsInAutoControlLegal() == true                              -- 没有按下其它界面按钮了
                    and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle   -- 没有按下谜题解谜按钮了
                then 
                    --print( "koko -o- isInAutoControl = " .. Maze2DStates.isInAutoControl )

                    assert( not isNull(touchPos)  )
                    self.DoHitTrackNodeGOOrBubbleFunc( self.mazeMain, touchPos, self.isPointerOverGameObject ) -- 函数指针
                end 
            end)
        end
    end
end


function MazeInput:GetVCamOrthographicSize()
    return self.vcam.m_Lens.OrthographicSize 
end

function MazeInput:SetVCamOrthographicSize( newSize_ )
    local lens = self.vcam.m_Lens
    lens.OrthographicSize = newSize_
    self.vcam.m_Lens = lens
end



-- 在每次 1号手指触碰的起始帧, 更新 self.isPointerOverGameObject
---@return void
function MazeInput:UpdateIsPointerOverGameObject()
    if self.isMobile then
        --- Mobiles: ---
        if      (Input.touchCount > 0) 
            and (not isNull(Input.touches[0])) 
            and (Input.touches[0].phase == TouchPhase.Began)
        then
            self.isPointerOverGameObject = EventSystem.current:IsPointerOverGameObject(Input.touches[0].fingerId)
        end
    else
        --- PC: ---
        if Input.GetMouseButtonDown(0) then
            self.isPointerOverGameObject = EventSystem.current:IsPointerOverGameObject()
        end
    end
end


-- 是否识别到 多点触控
---@return boolean, Vector3 | nil, Vector3 | nil
function MazeInput:IsMultiTouch()
    if self.isMobile then
        --- Mobiles: ---
        -- 严格版, 仅允许 2 个手指的触控
        if Input.touchCount == 2 then
            local t1 = Input.touches[0] 
            local t2 = Input.touches[1]
            -- 这里充分检查之后, 后面的 计算环节就不再检查了...
            if  (not isNull(t1)) and (not isNull(t2)) 
                and (t1.phase == TouchPhase.Began or t1.phase == TouchPhase.Stationary or t1.phase == TouchPhase.Moved ) 
                and (t2.phase == TouchPhase.Began or t2.phase == TouchPhase.Stationary or t2.phase == TouchPhase.Moved )
            then
                return true, t1.position, t2.position
            end
        end
        return false, nil, nil
    else
        --- PC: ---
        -- 按下任意 shift 键, 同时按下鼠标左键, 来模拟 双指触控
        if 
            Input.GetMouseButton(0) -- 同时包含 (1)按下的第一帧, (2)持续按下后的每一帧 
            and (Input.GetKey(KeyCode.LeftShift) or Input.GetKey(KeyCode.RightShift)) 
        then 
            return true, Input.mousePosition, Vector3.zero -- 第二个值是无效的
        end
        return false, nil, nil
    end
end



---@return boolean, Vector3 | nil
function MazeInput:IsSingleTouch()
    if self.isMobile then
        --- Mobiles: ---
        if (Input.touchCount == 1) and (not isNull(Input.touches[0])) then
            local phase = Input.touches[0].phase
            if phase == TouchPhase.Began or phase == TouchPhase.Stationary or phase == TouchPhase.Moved then 
                --local tp = Input.touches[0].position
                return true, Input.touches[0].position -- !!! 注意, 这是 Vector2
            end
        end
        return false, nil
    else 
        --- PC: ---
        if Input.GetMouseButton(0) then -- 第一帧 和 按下的后续帧统统包含
            return true, Input.mousePosition
        end
        return false, nil
    end
end


-- 仅检测 Up 帧
---@return boolean, Vector3 | nil
function MazeInput:IsSingleTouchUp()
    if self.isMobile then
        --- Mobiles: ---
        if (Input.touchCount == 1) and (not isNull(Input.touches[0])) then
            local phase = Input.touches[0].phase
            if phase == TouchPhase.Ended then 
                return true, Input.touches[0].position -- !!! 注意, 这是 Vector2
            end
        end
        return false, nil
    else 
        --- PC: ---
        if Input.GetMouseButtonUp(0) then -- 第一帧 和 按下的后续帧统统包含
            return true, Input.mousePosition
        end
        return false, nil
    end
end



-- 实现 "画布缩放" 这个功能
---@return void
function MazeInput:DoScreenZoom( pos1, pos2 )
    
    if self.isMobile then
        --- Mobiles: ---
        -- 简单地比较 前后两帧 两指的间距值, 来计算缩放值
        assert( (not isNull(pos1)) and (not isNull(pos2)) )
        if self.screenZoomFrameIdx == 0 then 
            -- 第一帧: (必要的初始化工作)
            self.screenZoomLastDistance = (pos1 - pos2).magnitude
            return
        else 
            -- 后续帧:
            assert( not isNull(self.screenZoomLastDistance) )
            local nowDistance = (pos1 - pos2).magnitude
            local scale = nowDistance / self.screenZoomLastDistance
            self.screenZoomLastDistance = nowDistance
            self.screenZoom = self.screenZoom * scale -- 变大或变小
        end
    else
        --- PC: ---
        -- 由于 pc端不存在两个手指, 故人为将 rightTop 方向设定为 "放大" 方向
        assert( not isNull(pos1) ) -- 不使用 pos2
        if self.screenZoomFrameIdx == 0 then 
            self.screenZoomLastPos =  pos1
            return
        else 
            local mov = pos1 - self.screenZoomLastPos --非归一化
            self.screenZoomLastPos =  pos1

            local isZoomIn = (Vector3.Dot(mov,screenZoomInDir) >= 0.0) and 1.0 or -1.0
            local magnitude = mov.magnitude / SCREEN_HEIGHT * screenZoomSpeed -- 归一化, 设置缩放速度
            self.screenZoom = self.screenZoom + (isZoomIn * magnitude) -- 变大或变小  
        end
    end
    self.screenZoom = Mathf.Clamp( self.screenZoom, MinScreenZoomVal, MaxScreenZoomVal ) -- 约束范围:

    -- ---------------------------------------------
    local newOrthoSize = self.initOrthographicSize * self.screenZoom
    -- 屏幕的长宽, 不能大于 地图长宽的 90%: 
    local screenHalfHeight = newOrthoSize -- 屏幕半高 
    local screenHalfWidth = newOrthoSize * SCREEN_WIDTH / SCREEN_HEIGHT -- 屏幕半宽

    if screenHalfWidth > (self.mapHalfWidth * 0.9) then 
        newOrthoSize = (self.mapHalfWidth * 0.9) * SCREEN_HEIGHT / SCREEN_WIDTH
    end
    if screenHalfHeight > (self.mapHalfHeight * 0.9) then 
        newOrthoSize = self.mapHalfHeight * 0.9
    end

    -- ---------------------------------------------
    -- 检测是否撞边:
    -- 现在 屏幕大小一定小于 map大小 (的90%), 所以只要将 露出边界的 offset 往回缩就可以了,
    local isHitMapEnd,newScreenBounds = self:IsHitMapEnd( newOrthoSize, self.vcam.transform.position )
    if isHitMapEnd == true then
        local w,h = self:ClacScreenOverstep(newScreenBounds) -- 越界的值
        print("screen 越界了; w,h= " .. tostring(w) .. "," .. tostring(h))
        -- 修改 cameraPivot, 然后 camera 再去跟随这个 pivot
        local newpos = self.cameraPivot.position - Vector3(w, 0.0, h)
        self.cameraPivot.position = newpos
    end

    -- 真的缩放屏幕:
    self:SetVCamOrthographicSize( Mathf.Lerp( self:GetVCamOrthographicSize(), newOrthoSize, 0.2 ) )-- 柔和跟进

    --print("orthographicSize" .. tostring( self:GetVCamOrthographicSize() ))
end




-- 实现 "画布移动" 这个功能
-- ret: 如果本帧移动距离超过一定值, 返回 true, 表示这是移动帧 (从而屏蔽后续 bubble 的点击)
---@param touchPos Vector3
---@return boolean
function MazeInput:DoScreenMove( pos )
    assert( not isNull(pos) )
    if self.screenMoveFrameIdx == 0 then
        --printError("移动第一帧 " .. tostring(pos:ToString()) )
        self.screenMoveInitPos = self.cameraPivot.position
        self.screenMoveLastPos = pos

    elseif self.screenMoveFrameIdx > 0 then
        --printError("移动 后续帧 " .. tostring(pos:ToString()) )
        assert( (not isNull(self.screenMoveLastPos)) and (not isNull(self.screenMoveInitPos)) )

        local offset = pos - self.screenMoveLastPos -- Vector3
        self.screenMoveLastPos = pos

        -- !!! 比例换算, 确保不管在任何 screenZoom 下, 拖动屏幕时 手指和地面都是 完美对应的
        -- 当然, 由于 camera 和 cameraPivot 之间还存在一道 lerp, 所有实际上不会真的 100% 对应, 而是被平滑了
        offset = offset / SCREEN_HEIGHT * (self:GetVCamOrthographicSize() * 2.0)
        
        local mov = Vector3( offset.x, 0.0, offset.y ) * screenMoveSpeed -- Vector3
        local newPos = self.cameraPivot.position - mov 

        -- ---------------------------------------------
        -- -- 检测是否撞边:
        newPos = self:CalcSafetyPos( newPos )
        self.cameraPivot.position = newPos

        local historyMoveDistance = (newPos - self.screenMoveInitPos).magnitude
        return (historyMoveDistance > screenMoveThreshold)
    else
        assert(false)
    end
    return false
end





---@param orthoSize number
---@param cameraPos Vector3
---@return boolean, table
function MazeInput:IsHitMapEnd( orthoSize, cameraPos )

    -- 一处简单的修改:
    -- 目前几乎不担心 vcam 的相机边框超出 地面边界了, 因为相机底色被设置为了黑色 
    -- 而且旧的 相机缩放+边框适配 算法存在点问题, 它会导致相机往地图中央跑, 这个效果很怪 
    -- 目前的简单修改是: 
    --    使用下行代码, 无视掉 相机缩放后的边框 与 地图边框 的关系;
    orthoSize = self.initOrthographicSize

    local screenHalfHeight = orthoSize -- 屏幕半高 
    local screenHalfWidth = orthoSize * SCREEN_WIDTH / SCREEN_HEIGHT -- 屏幕半宽
    ---:
    local bottom_  = cameraPos.z - screenHalfHeight
    local top_     = cameraPos.z + screenHalfHeight
    local left_    = cameraPos.x - screenHalfWidth
    local right_   = cameraPos.x + screenHalfWidth
    ---:
    local isHit = ((bottom_ < self.mapBottom) or (top_ > self.mapTop) or (left_ < self.mapLeft) or (right_ > self.mapRight))
    local newScreenBounds = { 
        bottom = bottom_,
        top    = top_,
        left   = left_,
        right  = right_ 
    }
    return isHit, newScreenBounds
end


-- 如果 screen 超出 map 边界, 计算出超出的 offset 值(向量)
---@param newScreenBounds table @ IsHitMapEnd() 的返回值
---@return number, number @ 超出的 offset, 只考虑两个轴
function MazeInput:ClacScreenOverstep( newScreenBounds )
    local e = newScreenBounds
    local w = 0.0
    local h = 0.0
    local isFind = false
    ---:
    if e.bottom < self.mapBottom then 
        isFind = true
        h = e.bottom - self.mapBottom
    elseif e.top > self.mapTop then
        isFind = true
        h = e.top - self.mapTop
    end
    ---:
    if e.left < self.mapLeft then 
        isFind = true
        w = e.left - self.mapLeft
    elseif e.right > self.mapRight then
        isFind = true
        w = e.right - self.mapRight
    end
    assert( isFind == true ) -- 要是一条边也不越界, 那一定是之前的计算出问题了...
    return w,h
end




-- 同时实现:
-- (1) vcam 缩放值恢复 init 值 
-- (2) vcam 看向 role
---@return System.Collections.IEnumerator
function MazeInput:BackToInitScreenZoomAndLookAtRole()

    local t = 0.0 
    local tSpeed = 1.8
    local speedMultiplier = 1.2

    local srcOrtho = self:GetVCamOrthographicSize()
    local dstOrtho = self.initOrthographicSize

    local srcPos = self.mazeMain.cameraPivot.position
    local dstPos = self:CalcSafetyPos( self.mazeMain.uiRole.roleTF.position )

    local len = (dstPos-srcPos).magnitude
    local k = 1.0 / (len+1) -- [1.0->0.0]
    local newSpeed = MapDecryptionMgr.Remap( 1.0, 0.0, tSpeed, tSpeed * len * speedMultiplier, k )

    while t < len do 
        local smooth_t = Mathf.SmoothStep( 0, 1, t/len )
        self:SetVCamOrthographicSize( Mathf.Lerp( srcOrtho, dstOrtho, smooth_t ) )
        self.mazeMain.cameraPivot.position = Vector3.Lerp( srcPos, dstPos, smooth_t )
        ---
        t = t + Time.deltaTime * newSpeed
        --print( "tpr -- ======" )
        coroutine.yield(Yielders.EndOfFrame)
    end 

    self.screenZoom = 1.0 -- !!! Must
end




-- 如果 tgtPos 会导致 screen 超出 map 编辑, 就重新计算一个安全的 pos, 返回它
---@param tgtPos Vector3
---@return Vector3 -- new tgtPos
function MazeInput:CalcSafetyPos( tgtPos )

    -- 检测是否撞边:
    -- 现在 屏幕大小一定小于 map大小 (的90%), 所有只要将 露出边界的 offset 往回缩就可以了,
    local isHitMapEnd,newScreenBounds = self:IsHitMapEnd( self:GetVCamOrthographicSize(), tgtPos )
    if isHitMapEnd == true then
        --print("screen 越界了")
        local w,h = self:ClacScreenOverstep(newScreenBounds) -- 越界的值
        --print("screen 越界了; w,h= " .. tostring(w) .. "," .. tostring(h))
        tgtPos = tgtPos - Vector3(w, 0.0, h)
    end
    --self.cameraPivot.position = tgtPos 
    return  tgtPos
end



return MazeInput
