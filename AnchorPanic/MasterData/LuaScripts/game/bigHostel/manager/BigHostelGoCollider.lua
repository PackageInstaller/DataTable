-- @FileName:   BigHostelGoCollider.lua
-- @Description:   点击物体类
-- @Author: ZDH
-- @Date:   2025-06-16 11:13:02
-- @Copyright:   (LY) 2025 锚点降临

module("game.bigHostel.manager.BigHostelGoCollider", Class.impl())

function ctor(self)

end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function resetData(self)
    local boxCollider = self.go:GetComponent(ty.BoxCollider)
    if boxCollider == nil or gs.GoUtil.IsCompNull(boxCollider) then
        boxCollider = self.go.gameObject:AddComponent(ty.BoxCollider)
    end

    boxCollider.size = self.size

    if self.center ~= nil then
        boxCollider.center = self.center
    end

    self.boxCollider = boxCollider

    self.frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
end

-- 通过已有资源创建新实例
function create(self, go, size, center, pointDown, pointUp)
    local item = self:poolGet()

    item.go = go
    item.size = size
    item.center = center
    item.pointDown = pointDown
    item.pointUp = pointUp

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

    gs.GameObject.Destroy(self.go:GetComponent(ty.GoMouseEvent))

    self.go = nil
    self.size = nil
    self.center = nil
    self.pointDown = nil
    self.pointUp = nil
    self.down = nil

    LuaPoolMgr:poolRecover(self)
end

function onFrame(self, deltaTime)
    if gs.Application.isMobilePlatform then
        local isHit = false
        if gs.Input.touchCount > 0 then
            for i = 0, gs.Input.touchCount - 1 do
                local touch = gs.Input.GetTouch(i)

                local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), gs.Vector3(touch.position.x, touch.position.y, 0), "RealLight", 500)
                if hitInfo and hitInfo.collider then
                    if gs.UnityEngineUtil.GetRaycastUIResults(touch.position).Count < 2 then
                        local hit_name = hitInfo.collider.gameObject.name
                        if hit_name == self.go.name then
                            self:onPointDown()
                            isHit = true
                            break
                        end
                    end
                end
            end

            self.down = true
        else
            self.down = false
        end

        self:onPointUp(isHit)
    else
        if gs.UnityEngineUtil.GetMouseButton(0) == 1 then
            self.down = true
        else
            self.down = false
        end

        local isHit = false
        local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(gs.CameraMgr:GetToScreenSceneCamera(), "RealLight", 500)
        if hitInfo and hitInfo.collider then
            if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(gs.UnityEngineUtil.GetMousePosX(), gs.UnityEngineUtil.GetMousePosY())).Count < 2 then
                if self.down then
                    local hit_name = hitInfo.collider.gameObject.name
                    if hit_name == self.go.name then
                        self:onPointDown()
                        isHit = true
                    end
                end
            end
        end

        self:onPointUp(isHit)
    end
end

function onPointDown(self)
    if self.isCallDown ~= true then
        if self.pointDown then
            self.pointDown(self.go)
        end

        self.isCallDown = true
    end
end

function onPointUp(self, isHit)
    if (self.down == false or isHit == false) and self.isCallDown == true then
        if self.pointUp then
            self.pointUp(self.go)
        end
        self.isCallDown = false
    end
end

function clearFrame(self)
    if self.frameSn then
        LoopManager:removeFrameByIndex(self.frameSn)
        self.frameSn = nil
    end
end

return _M
