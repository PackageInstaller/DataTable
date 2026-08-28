------------ import ------------
local Matrix4x4  = CS.UnityEngine.Matrix4x4
local Quaternion = CS.UnityEngine.Quaternion
------------ import ------------

------------ define ------------
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local KTool = CS.Engine.Lib.KTool
local Transform = CS.UnityEngine.Transform

------------ define ------------

---@class MinMapControl
local MinMapControl = Class('MinMapControl')


function MinMapControl:__init()
    self._uiMinMap      = nil  --- ui小地图
    self._uiRole        = nil  --- ui箭头
    ---@field targetRole                	UnityEngine.Transform    
    self._targetRole    = nil  --- 目标角色
    ---@field targetForward                	UnityEngine.Transform
    self._targetForward = nil  --- 视野目标朝向

    --- 存在的目的是为了测得 "world-space" 和 "小地图 ui-space" 的坐标系 转换矩阵 
    --- 用户需要手动填写这两组点:
    self._posPair1 = {
        wsPos = Vector3( -4, 0.0, 8.5 ),
        uiPos = Vector2( 42.1, 25.8 )
    }
    self._posPair2 = {
        wsPos = Vector3( -13.2, 0.0, 24.97 ),
        uiPos = Vector2( 104.6, -121.4 )
    }

    self._matrix = Matrix4x4.identity

    self.isError = true
end


function MinMapControl:__delete()

end

--- Init
---@param uiMinMap    UnityEngine.RectTransform
---@param uiRole      UnityEngine.RectTransform
---@param role        UnityEngine.Transform
---@param forward     UnityEngine.Transform
---@param uiView     UnityEngine.Transform
function MinMapControl:Init(uiMinMap, uiRole, role, forward, uiView )
    self._uiMinMap      = uiMinMap
    self._uiRole        = uiRole
    self._targetRole    = role
    self._targetForward = forward
    self._uiView = uiView
    
    self:CalcMatrix()
    
    self.isError = false
end

function MinMapControl:CalcMatrix()
    local posPair1 = self._posPair1
    local posPair2 = self._posPair2

    local a = Vector2(
        posPair2.wsPos.x - posPair1.wsPos.x,
        posPair2.wsPos.z - posPair1.wsPos.z
    )
    local b = Vector2(
        posPair2.uiPos.x - posPair1.uiPos.x,
        posPair2.uiPos.y - posPair1.uiPos.y
    )
    --- 用户必须配置 两个采样点, 且两点不能相同 
    if ( a.magnitude < 0.01 or b.magnitude < 0.01 ) then
        printError("必须设置两个有效的采样点")
        self.isError = true
    end

    local angle = Vector2.SignedAngle( a.normalized ,b.normalized )
    local scale = b.magnitude / a.magnitude

    --- 一种拙略的计算 两坐标系之间的 偏移值的方法:
    --- 先实现一个 无偏移矩阵, 将采样点 wspos 转换为 uipos, 然后求差值, 此值即为偏移值...
    local tmpMatrix = Matrix4x4.TRS(
        Vector3.zero,
        Quaternion.Euler( 0.0, -angle, 0.0 ),
        Vector3( scale, scale, scale )
    )
    local offset = Vector3( posPair1.uiPos.x, 0.0, posPair1.uiPos.y) - tmpMatrix:MultiplyPoint3x4(posPair1.wsPos)

    --- 默认在 3d空间的 xz 上变换
    self._matrix:SetTRS(
        offset,
        Quaternion.Euler( 0.0, -angle, 0.0 ),
        Vector3( scale, scale, scale )
    )
end

function MinMapControl:Update()
    if self.isError then
        return
    end

    local tgtRole    = self._targetRole
    local tgtForward = self._targetForward
    local uiMinMap   = self._uiMinMap
    local uiRole     = self._uiRole
    local matrix     = self._matrix
    local uiView     = self._uiView

    local rolePos = tgtRole.transform.position
    rolePos.y = 0.0

    local cameraForwardPos = rolePos + Vector3.ProjectOnPlane( tgtForward.forward, Vector3.up ) * 10.0
    cameraForwardPos.y = 0.0

    local roleForwardPos = rolePos + Vector3.ProjectOnPlane( tgtRole.forward, Vector3.up ) * 10.0
    roleForwardPos.y = 0.0

    local roleUIPos    = matrix:MultiplyPoint3x4(rolePos)
    local cameraforwardUIPos = matrix:MultiplyPoint3x4(cameraForwardPos)
    local roleforwardUIPos = matrix:MultiplyPoint3x4(roleForwardPos)

    --- 小地图位移:
    uiMinMap.localPosition = Vector3( roleUIPos.x, roleUIPos.z, 0.0 )

    --- 视野旋转:
    local ang = Vector3.SignedAngle( Vector3.forward, roleUIPos - cameraforwardUIPos, Vector3.up )
    uiView.localRotation = Quaternion.Euler(0.0, 0.0, -ang)

    --- 箭头旋转:
    ang = Vector3.SignedAngle( Vector3.forward, roleUIPos - roleforwardUIPos, Vector3.up )
    uiRole.rotation = Quaternion.Euler(0.0, 0.0, -ang)

    
end



return MinMapControl
