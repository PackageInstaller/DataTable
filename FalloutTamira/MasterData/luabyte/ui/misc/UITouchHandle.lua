local UITouchHandle = {}
local M = UITouchHandle
local allHandles = {}

UITouchHandle.EventType = {}
UITouchHandle.EventType.StartDrag = 1
UITouchHandle.EventType.Draging = 2
UITouchHandle.EventType.EndDrag = 3
UITouchHandle.EventType.Click = 4


-- Ihandle = {}
-- Ihandle.OnBeginDrag(eventData)
-- Ihandle.OnEndDrag(eventData,isHitCollider)
-- Ihandle.OnTouchUp(eventData)
-- Ihandle.OnDrag(eventData,isHitCollider)
-- Ihandle.OnClick(eventData)
-- Ihandle.GetColliderLayer()

--target 为transform
--Ihandle 为对象，其有
function M.SetTouchHandle(target, Ihandle)
    local key = M._GetKey(target)
    if key == nil then
        return
    end
    local CS_UITouchHandle = typeof(CS.GameX.UITouchHandle)
    local csHandle = target.gameObject:GetComponent(CS_UITouchHandle)
    if IsNull(csHandle) then
        csHandle = target.gameObject:AddComponent(CS_UITouchHandle)
    end
    if Ihandle.GetColliderLayer then
        csHandle:SetDragColliderLayer(Ihandle:GetColliderLayer())
    end
    allHandles[key] = csHandle
    if Ihandle.OnBeginDrag then
        csHandle.onBeginDrag = function(eventData)
            Ihandle:OnBeginDrag(eventData)
        end
    end
    if Ihandle.OnTouchUp then
        csHandle.onTouchUp = function(eventData)
            Ihandle:OnTouchUp(eventData)
        end
    end
    if Ihandle.OnEndDrag then
        csHandle.onEndDrag = function(eventData, isHitCollider, id)
            Ihandle:OnEndDrag(eventData, isHitCollider, id)
        end
    end
    if Ihandle.OnDrag then
        csHandle.onDrag = function(eventData, isHitCollider, id)
            Ihandle:OnDrag(eventData, isHitCollider, id)
        end
    end
    if Ihandle.OnClick then
        csHandle.onClick = function(eventData)
            Ihandle:OnClick(eventData)
        end
    end
end

function M.DisposeTouchHandle(target)
    local key = M._GetKey(target)
    if key == nil then
        return
    end
    if allHandles[key] then
        local csHandle = allHandles[key]
        if not IsNull(csHandle) then
            csHandle.onBeginDrag = nil
            csHandle.onEndDrag = nil
            csHandle.onTouchUp = nil
            csHandle.onDrag = nil
            csHandle.onClick = nil
        end
        allHandles[key] = nil
    end

end

function M._GetKey(target)
    if not target or not target.gameObject then
        --if error then error("Register ui press timer need a gameObject as target") end
        return nil
    end
    local key = target.gameObject:GetInstanceID();
    return key
end

function M.Dispose()
    for key, csHandle in pairs(allHandles) do
        if not IsNull(csHandle) then
            csHandle.onBeginDrag = nil
            csHandle.onEndDrag = nil
            csHandle.onTouchUp = nil
            csHandle.onDrag = nil
            csHandle.onClick = nil
        end
    end
    allHandles = {}
end

return UITouchHandle
