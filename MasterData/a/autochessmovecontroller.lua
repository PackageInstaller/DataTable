---@class AutoChessMoveController
local AutoChessMoveController = class("AutoChessMoveController")

local Bezier = require("bezier")
local random = UnityEngine.Random
local temp_v3 = Vector3.New()
--- 距离格心小于该值时视为已到位（避免末端抖动）
local GRID_ALIGN_EPSILON = 0.05

---@param dst Vector3
---@param p any
---@return boolean
local function tryCopyWorldPos(dst, p)
    if p == nil then
        return false
    end
    local x, y, z = p.x, p.y, p.z
    if x == nil and p.Get ~= nil then
        x, y, z = p:Get()
    end
    if x == nil then
        return false
    end
    dst:Set(x, y or 0, z or 0)
    return true
end

---@param data AutoChessEntity
function AutoChessMoveController:ctor(data)
    self.entity = data
    self.isMoveing = false
    ---@type AutoChessMoveType
    self.moveType = GE.AutoChessMoveType.None
    ---@type fun(entity:AutoChessEntity)?
    self.moveFinishCallback = nil


    ---@type Vector3? Bezier曲线控制点
    self.ctrlPoint = nil

    ---@type Vector3[]? 移动格子路径点
    self.wayPoints = nil
    ---@type int 当前移动格子索引
    self.targetindex = 0

    ---@type integer? 格子移动预留目标（防止多单位抢同一格）
    self.reserveGx = nil
    ---@type integer? 格子移动预留目标
    self.reserveGy = nil

    ---@type integer? 格子移动起点（离开格，移动中不再当作障碍以让队友跟上）
    self.fromGx = nil
    ---@type integer? 格子移动起点
    self.fromGy = nil

    ---@type UnityEngine.Transform? 目标点
    self.targetTrs = nil

    ---@type AutoChessEntity? 目标实体
    self.targetEntity = nil

    self.startPos = Vector3.New()
    self.endPos = Vector3.New()
end


function AutoChessMoveController:Update(dt)
    if not self.isMoveing then
       return 
    end
    self:UpdateMove(dt)
end

---移动到目标点
---@param pos Vector3|Vector3[]|UnityEngine.Transform
---@param moveType AutoChessMoveType
---@param param table?
---@param cb fun(entity:AutoChessEntity)?
function AutoChessMoveController:MoveTo(pos, moveType, param, cb)
    
    self.isMoveing = true
    self.moveType = moveType
    self.moveFinishCallback = cb
    self.startTime = 0


    self:OnMoveStart(moveType, pos, param)
    self:UpdateMove(0)
end


function AutoChessMoveController:OnMoveStart(moveType, pos, param)
    self.moveStartTime = Time.time
    local entit  = self.entity:GetPosition()
    self.startPos:Set(entit.x, entit.y, entit.z)

    local mgr = AutoChessManager.instance()
    if moveType == GE.AutoChessMoveType.Point then
        self:SetGridMoveDir(pos)
        self.endPos:Set(pos.x, pos.y, pos.z)
        self.reserveGx, self.reserveGy = mgr:WorldPosToGridPos(pos.x, pos.z)
    elseif moveType == GE.AutoChessMoveType.Bezier then
        self.endPos:Set(pos.x, pos.y, pos.z)
        local c1 = 0.5
        local c2 = 1
        local c3 = 0
        if param then
            local ctrlCfg = param
            if ctrlCfg[1] ~= nil then
                if type(ctrlCfg[1]) == "number" then
                    c1 = ctrlCfg[1]
                elseif type(ctrlCfg[1]) == "table" then
                    c1 = UnityEngine.Random.Range(ctrlCfg[1][1], ctrlCfg[1][2]) 
                    
                end
            end

            if ctrlCfg[2] ~= nil then
                if type(ctrlCfg[2]) == "number" then
                    c2 = ctrlCfg[2]
                elseif type(ctrlCfg[2]) == "table" then
                    c2 = UnityEngine.Random.Range(ctrlCfg[2][1], ctrlCfg[2][2]) 
                    
                end
            end

            if ctrlCfg[3] ~= nil then
                if type(ctrlCfg[3]) == "number" then
                    c3 = ctrlCfg[3]
                elseif type(ctrlCfg[3]) == "table" then
                    c3 = UnityEngine.Random.Range(ctrlCfg[3][1], ctrlCfg[3][2]) 
                    
                end
            end
        end

        local moveDir = self.endPos - self.startPos
        local dis = Vector3.Distance(pos, self.startPos)
        moveDir:SetNormalize()
        local p = self.startPos + moveDir * c1 * dis
        local right = Vector3.Cross(Vector3.up, moveDir)
        local up =  Vector3.Cross(moveDir, right).normalized
        local ctrlPoint = p + up * c2 +  right * c3
        self.ctrlPoint = ctrlPoint
        self.bezierDis = 0
    elseif moveType == GE.AutoChessMoveType.Grid then
        self.wayPoints = pos
        self.endPos:Set(0, 0, 0)
        self.targetindex = 1
        self.reserveGx = nil
        self.reserveGy = nil
        self.fromGx, self.fromGy = self.entity:GetLogicalGridPos()
        if param ~= nil and param.destGx ~= nil and param.destGy ~= nil then
            self.reserveGx = param.destGx
            self.reserveGy = param.destGy
        elseif pos ~= nil and #pos > 0 then
            local last = pos[#pos]
            self.reserveGx, self.reserveGy = mgr:WorldPosToGridPos(last.x, last.z)
        end
        if self.reserveGx ~= nil and self.reserveGy ~= nil
            and mgr:IsGridBlockedForLanding(self.entity, self.reserveGx, self.reserveGy) then
            self.isMoveing = false
            self.moveType = GE.AutoChessMoveType.None
            self.wayPoints = nil
            self.targetindex = 0
            self.reserveGx = nil
            self.reserveGy = nil
            self.fromGx = nil
            self.fromGy = nil
            self.moveFinishCallback = nil
            return
        end
    elseif moveType == GE.AutoChessMoveType.target then
        self.targetEntity = param
        self.targetTrs = pos
    elseif moveType == GE.AutoChessMoveType.Line then
        self.endPos:Set(pos.x, pos.y, pos.z)
    end
end

function AutoChessMoveController:UpdateMove(dt)
    if self.entity.destroyed then
        self:OnMoveEnd()
        return
    end
    if not self.entity:CanMove() then
        self:OnMoveEnd()
        return
    end
    if self.moveType == GE.AutoChessMoveType.Point then
        self:MovePoint(dt)
    elseif self.moveType == GE.AutoChessMoveType.Bezier then
        self:MoveBezier(dt)
    elseif self.moveType == GE.AutoChessMoveType.Grid then
        self:MoveGrid(dt)
    elseif self.moveType == GE.AutoChessMoveType.target then
        self:MoveTarget(dt)
    elseif self.moveType == GE.AutoChessMoveType.Line then
        self:MoveLine(dt)
    end
end

---朝某一方向移动
function AutoChessMoveController:MoveLine(dt)
    local deltaTime = dt
    local speed = self.entity:GetMoveSpeed()

    local moveDir = self.endPos

    local addPos = moveDir * speed * deltaTime

    local entityPos = self.entity:GetPosition()
    temp_v3:Set(entityPos.x + addPos.x, entityPos.y + addPos.y, entityPos.z + addPos.z)
    local pos = temp_v3
    self.entity:SetMovePosition(pos)

end

function AutoChessMoveController:MoveBezier(dt)
    local deltaTime = dt
    local speed = self.entity:GetMoveSpeed()

    local dis = Vector3.Distance(self.endPos, self.startPos)
    local d = self.bezierDis
    d = d + speed * deltaTime
    d = math.min(d, dis)
    self.bezierDis = d

    local p = math.min(1, d / dis)
    local pos = Bezier:GetBezierPoint(p, self.startPos, self.ctrlPoint, self.endPos)
    self:SetGridMoveDir(pos)
    self.entity:SetMovePosition(pos)
    if d >= dis then
        self:OnMoveEnd()
    end
end

function AutoChessMoveController:MoveGrid(dt)
    local deltaTime = dt

    local disToMove = self.entity:GetMoveSpeed() * deltaTime
    local curPos = self.entity:GetPosition()
    while disToMove > 0 and self.targetindex <= #self.wayPoints do
        local targetPos = self.wayPoints[self.targetindex]
        self:SetGridMoveDir(targetPos)
        local dis = Vector3.Distance(curPos, targetPos)
        if dis < 0.00001 then
            curPos = targetPos
            self.targetindex = self.targetindex + 1
            goto continue 
        end
        if disToMove >= dis then
            curPos = targetPos
            disToMove = disToMove - dis
            self.targetindex = self.targetindex + 1
            if self.targetindex > #self.wayPoints then
               self.isMoveing = false
               break
            end
        else
            curPos = Vector3.MoveTowards(curPos, targetPos, disToMove)
            break
        end
        ::continue::
    end
    self.entity:SetMovePosition(curPos)
    if not self.isMoveing then
        self:OnMoveEnd()
    end
end

---追击目标点
function AutoChessMoveController:MoveTarget(dt)

    local disToMove = self.entity:GetMoveSpeed() * dt
    local endPos = self:ResolveTargetMovePos()
    if endPos == nil then
        self:OnMoveEnd()
        return
    end

    local curPos = self.entity:GetPosition()
    if curPos == nil then
        self:OnMoveEnd()
        return
    end
    local dis = Vector3.Distance(curPos, endPos)
    if disToMove >= dis then
        self.entity:SetMovePosition(endPos)
        self:OnMoveEnd()
        return
    end
    local pos = Vector3.MoveTowards(curPos, endPos, disToMove)
    self.entity:SetMovePosition(pos)
end

---解析追击目标世界坐标（绑点失效时回退到实体位置）
---@return Vector3?
function AutoChessMoveController:ResolveTargetMovePos()
    if self.targetEntity ~= nil then
        if self.targetEntity.destroyed or self.targetEntity:IsDead() then
            return nil
        end
        if self.targetTrs ~= nil and not IsNull(self.targetTrs) then
            if tryCopyWorldPos(self.endPos, self.targetTrs.position) then
                return self.endPos
            end
        end
        local p = self.targetEntity:GetPosition()
        if p ~= nil then
            self.endPos:Set(p.x, p.y, p.z)
            return self.endPos
        end
        return nil
    end
    if self.targetTrs ~= nil and not IsNull(self.targetTrs) then
        if tryCopyWorldPos(self.endPos, self.targetTrs.position) then
            return self.endPos
        end
    end
    return nil
end

---移动到目标点
function AutoChessMoveController:MovePoint(dt)
    local deltaTime = dt
    local speed = self.entity:GetMoveSpeed()

    temp_v3:Set(self.endPos.x - self.startPos.x, self.endPos.y - self.startPos.y, self.endPos.z- self.startPos.z)
    temp_v3:SetNormalize()
    local moveDir = temp_v3
    local addPos = moveDir * speed * deltaTime
    local entityPos = self.entity:GetPosition()

    local pos = entityPos + addPos
    local d = self.endPos - pos

    local dot = Vector3.Dot(moveDir, d)
    if dot <= 0 then
        pos = self.endPos
        self.entity:SetMovePosition(pos)
        self:OnMoveEnd()
    else
        self.entity:SetMovePosition(pos)
    end
end


function AutoChessMoveController:SetGridMoveDir(targetPos)
    local sPos = self.entity:GetPosition()
    local ePos = targetPos
    local dir = ePos - sPos
    dir:SetNormalize()
    self.entity:SetRotationXY(dir.x, dir.z)
end

---@param targetPos Vector3
---@param cb fun(entity:AutoChessEntity)?
function AutoChessMoveController:MoveToWorldPosSmooth(targetPos, cb)
    local pos = self.entity:GetPosition()
    local dis = Vector3.Distance(pos, targetPos)
    if dis <= GRID_ALIGN_EPSILON then
        self.entity:SetMovePosition(targetPos)
        if cb then
            cb(self.entity)
        end
        return
    end
    if self.isMoveing then
        self:StopMove(false)
    end
    self:MoveTo(targetPos, GE.AutoChessMoveType.Point, nil, cb)
end

---行军途中停下时，先走完当前这一段路点（当前格心），而不是瞬移
---@param cb fun(entity:AutoChessEntity)?
function AutoChessMoveController:FinishCurrentGridStep(cb)
    if self.moveType == GE.AutoChessMoveType.Grid and self.wayPoints ~= nil and self.targetindex <= #self.wayPoints then
        local targetPos = self.wayPoints[self.targetindex]
        self:StopMove(false)
        self:MoveToWorldPosSmooth(targetPos, cb)
        return
    end
    self:AlignToNearestGridCenter(cb)
end

---平滑走到最近格子中心
---@param cb fun(entity:AutoChessEntity)?
function AutoChessMoveController:AlignToNearestGridCenter(cb)
    local acMgr = AutoChessManager.instance()
    local gx, gy = self.entity:GetLogicalGridPos()
    local wx, wz = acMgr:GridPosToWorldPos(gx, gy)
    local pos = self.entity:GetPosition()
    local targetPos = Vector3.New(wx, pos.y, wz)
    self:MoveToWorldPosSmooth(targetPos, cb)
end

function AutoChessMoveController:IsAligningToGrid()
    return self.isMoveing and self.moveType == GE.AutoChessMoveType.Point
end


function AutoChessMoveController:OnMoveEnd()
    local wasGrid = self.moveType == GE.AutoChessMoveType.Grid
    local intentGx, intentGy = self.reserveGx, self.reserveGy
    local fromGx, fromGy = self.fromGx, self.fromGy
    local mgr = AutoChessManager.instance()
    if wasGrid and intentGx ~= nil and intentGy ~= nil then
        local landingBlocked = mgr:IsGridBlockedForLanding(self.entity, intentGx, intentGy)
        if not landingBlocked then
            local pos = self.entity:GetPosition()
            local wx, wz = mgr:GridPosToWorldPos(intentGx, intentGy)
            local target = Vector3.New(wx, pos.y, wz)
            local dis = Vector3.Distance(pos, target)
            -- 仅在做完一格行程、接近意图格时微调到格心，避免中途被吸回
            if dis > GRID_ALIGN_EPSILON and dis <= mgr.gridSize * 1.2 then
                self.entity:SetMovePosition(target)
            end
        end
    end
    self:StopMove(true)
    if wasGrid then
        mgr:ResolveEntityGridOverlap(self.entity)
        mgr:RelocateEntityNearIntentGrid(self.entity, intentGx, intentGy, fromGx, fromGy)
    end
end

---@param invokeCallback boolean? 是否触发移动结束回调
function AutoChessMoveController:StopMove(invokeCallback)
    if not self.isMoveing and self.moveType == GE.AutoChessMoveType.None then
        return
    end
    local cb = self.moveFinishCallback
    self.isMoveing = false
    self.moveType = GE.AutoChessMoveType.None
    self.wayPoints = nil
    self.targetindex = 0
    self.ctrlPoint = nil
    self.targetTrs = nil
    self.targetEntity = nil
    self.moveFinishCallback = nil
    self.reserveGx = nil
    self.reserveGy = nil
    self.fromGx = nil
    self.fromGy = nil
    if invokeCallback and cb then
        cb(self.entity)
    end
end

return AutoChessMoveController