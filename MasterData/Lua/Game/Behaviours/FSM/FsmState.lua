---@class FsmState
local FsmState = Class('FsmState')


function FsmState:__init(type)
    self.type = type
end


function FsmState:__delete()
    self._enterCondition = nil
    self._enterCb = nil
    self._leaveCb = nil
end

function FsmState:CheckEnterCondition()
    if self._enterCondition == nil then
        return true
    end
    return self._enterCondition()
end

function FsmState:OnEnter()
    if self._enterCb then
        self._enterCb()
    end
end

function FsmState:OnLeave()
    if self._leaveCb then
        self._leaveCb()
    end
end

function FsmState:SetEnterCondition(cb)
    self._enterCondition = cb
end

function FsmState:SetEnter(cb)
    self._enterCb = cb
end

function FsmState:SetLeave(cb)
    self._leaveCb = cb
end

return FsmState
