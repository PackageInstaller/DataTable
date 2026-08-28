------------ import ------------
local Matrix4x4  = CS.UnityEngine.Matrix4x4
local Quaternion = CS.UnityEngine.Quaternion
local Input      = CS.UnityEngine.Input
local KeyCode    = CS.UnityEngine.KeyCode
local Vector3   = CS.UnityEngine.Vector3
local Vector2   = CS.UnityEngine.Vector2
local KCookie   = CS.Engine.Lib.KCookie -- 全局缓存容器
------------ import ------------

------------ define ------------
local Mathf      = Mathf
------------ define ------------

---@class PlayerInput
local PlayerInput = Class('PlayerInput')


-- ========================== 配置参数 ==============================

-- 目前 角色运动时配置的相机是一个 free look vcamere, 它的 Binding Mode 为 "World Space" ( "Simple Follow With World Up" 也一样 ),
-- 同时它的 Aim - Screen x 值为 0.4, 导致角色站在画面的左侧;
-- 这个配置会导致 角色的forward 和 相机的 foward 并不在一个轴线上, 最终导致角色向前运动时向右偏航, 这是 "角色->相机", "相机->角色" 循环影响的结果;
-- ------- 
-- 目前的临时解法是: 每一次都手动校正 forwardDir, 让它向左偏一个角度,
-- 本变量就是向左偏转的角度值:
local forwardCalibrationYAngle = -4.0 -- -5.7

-- ========================================================


function PlayerInput:__init()
    self._tgtCamera             = nil
    self._etcJoystick             = nil

    self.isUseKeyboard         = GameUtils.IsPCPlatform()      --- 切换输入: 屏幕滑杆 / 键盘

    self.ctrlKeyFlag          = false     -- 按下任意 control, 在 true/false 之间切换

    self._originInput           = Vector3.zero --- 最原始的外设输入
    self.playerInputMoveVec    = Vector3.zero --- 本帧运动方向, 玩家不操作时为 0向量; ws; 模长 <= 1;
    self.tgtMoveDir            = Vector3.forward --- 存储玩家最后一次输入的 运动方向; ws

    self.upDir                 = Vector3.up
    self.forwardDir            = Vector3.forward
    self.rightDir              = Vector3.right
 
    self.isPlayerInput         = false ---非0即1

    self._isEasyTouchTouched    = false --- 确保只在 触控滑杆输入时, 才接收

    self._isStop                = false  --- 是否暂停用户输入
    self._isInitComplete        = false
end


function PlayerInput:__delete()
    local etcJoystick = self._etcJoystick
    etcJoystick.onMoveStart:RemoveAllListeners()
    etcJoystick.onMove:RemoveAllListeners()
    etcJoystick.onMoveEnd:RemoveAllListeners()

end

--- Init
---@param tgtCamera UnityEngine.Camera
---@param etcJoystick ETCJoystick
function PlayerInput:Init(tgtCamera, etcJoystick)
    self._tgtCamera = tgtCamera
    self._etcJoystick = etcJoystick

    etcJoystick.onMoveStart:AddListener(Bind(self, self.EasyTouchOnMoveStart))
    etcJoystick.onMove:AddListener(Bind(self, self.EasyTouchOnMove))
    etcJoystick.onMoveEnd:AddListener(Bind(self, self.EasyTouchOnMoveEnd))

    --- 若有缓存, 则读取 tgtMoveDir 的缓存:
    local cachedTgtMoveDir = KCookie.Get("tgtMoveDir") -- Object
    if not isNull(cachedTgtMoveDir) then 
        self.tgtMoveDir = cachedTgtMoveDir
    end
    ---:
    self._isInitComplete = true
    ---:
    -- 修正偏航用的 旋转四元数:
    self._forwardCalibrationRotation = Quaternion.Euler( 0.0, forwardCalibrationYAngle, 0.0 ); -- Quaternion
end

function PlayerInput:Update()
    if not self._isInitComplete then
        return
    end
    if self._isStop then
        self.playerInputMoveVec   = Vector3.zero;
        return
    end
    local tgtCamera = self._tgtCamera

    -- 每按下一次 ctl 键, 就会切换 跑步 和 走路 模式:
    if Input.GetKeyDown(KeyCode.LeftControl) or Input.GetKeyDown(KeyCode.RightControl) then 
        self.ctrlKeyFlag = not self.ctrlKeyFlag
        GameUtils.Toast(self.ctrlKeyFlag and localize("已切换至走路状态") or localize("已切换至跑步状态"))
    end

    if self.isUseKeyboard and not self._isEasyTouchTouched then
        self._originInput.x = Input.GetAxis("Horizontal")
        self._originInput.z = Input.GetAxis("Vertical")    
    else 
        -- 触控模式下将直接接收 easyTouch 的输入
    end
    
    --- --- 躺平在 ground surface 上的 camera 坐标系 ---
    --- 但是这三个 向量是 ws 表达;
    self.upDir = Vector3.up; --- 暂定;
    self.forwardDir = Vector3.ProjectOnPlane( tgtCamera.transform.forward, self.upDir ).normalized
    -- 修正偏航, 见本文件 forwardCalibrationYAngle 处注解
    self.forwardDir = self._forwardCalibrationRotation * self.forwardDir
    self.rightDir = Vector3.Cross(self.upDir, self.forwardDir).normalized

    ----------------
    self.playerInputMoveVec = (self._originInput.x * self.rightDir + self._originInput.z * self.forwardDir); --- 本帧运动方向, 玩家不操作时为 0向量; ws
    self.playerInputMoveVec = Vector3.ClampMagnitude(self.playerInputMoveVec, 1)


    -- 使用键盘时, 运动向量要更接近 单位向量 或 0向量
    if self.isUseKeyboard then
        self.playerInputMoveVec = Vector3.Lerp( self.playerInputMoveVec, self.playerInputMoveVec.normalized, 0.5 )
    end

    self:CalcIsPlayerInput()

    --- 只有在有效输入时, 才记录 目标运动方向
    if self.isPlayerInput then
        self.tgtMoveDir           = self.playerInputMoveVec.normalized
        self._playerInputMagnitude = 1
    else
        self.playerInputMoveVec   = Vector3.zero;
    end
end



function PlayerInput:CalcIsPlayerInput()
    local isWSAD = Input.GetKey(KeyCode.W) or Input.GetKey(KeyCode.S) or Input.GetKey(KeyCode.A) or Input.GetKey(KeyCode.D)
    self.isPlayerInput = self.isUseKeyboard and isWSAD or (self.playerInputMoveVec.magnitude > 0.01)
end


--- Easy Touch 5 callback
--- 当玩家松开后, 应立即停止对 originInput 的修改;
function PlayerInput:EasyTouchOnMoveStart()
    self._isEasyTouchTouched = true
end

function PlayerInput:EasyTouchOnMove(vec)
    if self._isEasyTouchTouched then
        self._originInput = Vector3( vec.x, 0, vec.y )
    end
end

function PlayerInput:EasyTouchOnMoveEnd()
    self._isEasyTouchTouched = false
    self._originInput        = Vector3.zero
end


function PlayerInput:StopInput()
    self._isStop = true
    self.isPlayerInput = false
end

function PlayerInput:ResumeInput()
    self._isStop = false
    self.isPlayerInput = true
end

return PlayerInput
