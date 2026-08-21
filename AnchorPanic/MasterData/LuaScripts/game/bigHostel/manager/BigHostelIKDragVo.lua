-- @FileName:   BigHostelIKDragVo.lua
-- @Description:   IK拖拽通用类
-- @Author: ZDH
-- @Date:   2025-06-16 11:13:02
-- @Copyright:   (LY) 2025 锚点降临

module("game.bigHostel.manager.BigHostelIKDragVo", Class.impl())

function ctor(self)

end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function resetData(self)
    self.m_dragPos = gs.Vector3(0, 0, 0)

    self.boxCollider = self.clickGo:GetComponent(ty.BoxCollider)
    if self.boxCollider == nil or gs.GoUtil.IsCompNull(self.boxCollider) then
        self.boxCollider = self.clickGo:AddComponent(ty.BoxCollider)
        self.boxCollider.size = gs.Vector3(self.boxSize.x, self.boxSize.y, self.boxSize.z)
    end

    local function onPointDown()
        if bigHostel.BigHostelManager:getHostelHero().main_type == BigHostelConst.SceneUI_Type.TRIAL then
            gs.Message.Show(_TT(50091))
            return
        end

        if not bigHostel.BigHostelManager:getIsCanInteract() then
            return
        end

        if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(gs.UnityEngineUtil.GetMousePosX(), gs.UnityEngineUtil.GetMousePosY())).Count > 1 then
            return
        end

        if bigHostel.BigHostelManager:getDisableFreeCameraReset() == true then
            gs.Message.Show(_TT(84522))
            return
        end

        self.m_mouseDown = true

        self.speed = self.drag_speed
        self.raycast_panel:SetActive(true)

        if self.point_down then
            self.point_down()
        end

        self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
    end

    local function onPointUp()
        if bigHostel.BigHostelManager:getDisableFreeCameraReset() == true then
            return
        end

        if self.point_up then
            self.point_up(self.m_dragPos)
        end

        self:resetMouseState()
    end

    local mouseEvent = self.clickGo:GetComponent(ty.GoMouseEvent)
    if mouseEvent == nil or gs.GoUtil.IsCompNull(mouseEvent) then
        mouseEvent = self.clickGo:AddComponent(ty.GoMouseEvent)
    end
    mouseEvent:SetCallFun(self, nil, onPointDown, onPointUp, nil)

    -- self.raycast_panel.transform.position = self.clickGo.transform:TransformPoint(gs.VEC3_ZERO)
end

function setData(self, FBBIK, clickGo, box_size, raycast_panel, Offet_Bones, point_down, dragCall, point_up, limit, drag_speed, reset_speed)
    self.FBBIK = FBBIK
    self.clickGo = clickGo
    self.boxSize = box_size
    self.raycast_panel = raycast_panel
    self.Offet_Bones = Offet_Bones
    self.point_down = point_down
    self.dragCall = dragCall
    self.point_up = point_up

    self.drag_speed = drag_speed or 1
    self.reset_speed = reset_speed or 1

    self.limit = limit

    self:resetData()
end

-- 通过已有资源创建新实例
function create(self, FBBIK, clickGo, box_size, raycast_panel, Offet_Bones, point_down, dragCall, point_up, limit, drag_speed, reset_speed)
    local item = self:poolGet()

    item.FBBIK = FBBIK
    item.clickGo = clickGo
    item.boxSize = box_size
    item.raycast_panel = raycast_panel
    item.Offet_Bones = Offet_Bones
    item.point_down = point_down
    item.dragCall = dragCall
    item.point_up = point_up

    item.drag_speed = drag_speed or 1
    item.reset_speed = reset_speed or 1

    item.limit = limit

    item:resetData()

    return item
end

-- 回收
function recover(self)
    self:clearFrame()

    if self.boxCollider ~= nil and not gs.GoUtil.IsCompNull(self.boxCollider) then
        gs.GameObject.Destroy(self.boxCollider)
    end
    self.boxCollider = nil

    gs.GameObject.Destroy(self.clickGo:GetComponent(ty.GoMouseEvent))

    self.FBBIK = nil
    self.clickGo = nil
    self.raycast_panel = nil
    self.Offet_Bones = nil
    self.dragCall = nil

    self.speed = nil
    self.limit = nil

    self.m_mouseDown = nil
    self.m_startDragPos = nil
    self.m_dragPos = nil

    LuaPoolMgr:poolRecover(self)
end

function onFrame(self, deltaTime)
    if self.m_mouseDown then
        local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "Event", 500)
        if hitInfo and hitInfo.collider then
            if hitInfo.collider.gameObject.name == self.raycast_panel.name then
                if self.m_startDragPos == nil then
                    self.m_startDragPos = hitInfo.point
                end

                if self.limit ~= nil then
                    local offset = hitInfo.point - self.m_startDragPos
                    local limit_x = offset.x
                    if self.limit.min_x ~= nil and self.limit.max_x ~= nil then
                        limit_x = gs.Mathf.Clamp(offset.x, -self.limit.min_x, self.limit.max_x)
                    end

                    local limit_y = offset.y
                    if self.limit.min_y ~= nil and self.limit.max_y ~= nil then
                        limit_y = gs.Mathf.Clamp(offset.y, -self.limit.min_y, self.limit.max_y)
                    end

                    local limit_z = offset.z
                    if self.limit.min_z ~= nil and self.limit.max_z ~= nil then
                        limit_z = gs.Mathf.Clamp(offset.z, -self.limit.min_z, self.limit.max_z)
                    end

                    self.drag_offset = gs.Vector3(limit_x, limit_y, limit_z)
                else
                    self.drag_offset = hitInfo.point - self.m_startDragPos
                end
            end
        end
    end

    self.m_dragPos = gs.Vector3.Lerp(self.m_dragPos, self.drag_offset, deltaTime * self.speed)

    -- self.m_dragPos = gs.TransQuick:Vector3_SmoothDamp(self.m_dragPos, self.drag_offset, self.speed)
    -- self.m_dragPos = self.drag_offset

    if self.m_dragPos ~= gs.VEC3_ZERO then
        if self.Offet_Bones ~= nil then
            for _, effctor_type in pairs(self.Offet_Bones) do
                local effctor = self.FBBIK.solver:GetEffector(effctor_type)
                effctor.positionOffset = effctor.positionOffset + self.m_dragPos
            end
        end

        if self.dragCall then
            self.dragCall(self.m_dragPos, self.drag_offset)
        end
    else
        if self.dragCall then
            self.dragCall(gs.VEC3_ZERO, self.drag_offset)
        end
    end
end

function resetMouseState(self)
    if self.FBBIK == nil then
        return
    end

    self.m_mouseDown = false
    self.m_startDragPos = nil

    self.drag_offset = gs.Vector3(0, 0, 0)

    self.speed = self.reset_speed

    self.raycast_panel:SetActive(false)
end

function clearFrame(self)
    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end
end

return _M
