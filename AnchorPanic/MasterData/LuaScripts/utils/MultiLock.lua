module('MultiLock', Class.impl())

function ctor(self)
    self.locks = {}
end

function lock(self, id)
    self.locks[id] = true
end

function lockByTimeout(self, id, timeout, finishCallback)
    self.lock(id)
    if timeout then
        self:autoUnlock(id, timeout)
        finishCallback()
    end
end

function unlock(self, id, finishCallback)
    if self.locks[id] and finishCallback then
        finishCallback()
    end

    self.locks[id] = nil
end

function unlockAll(self)
    self.locks = {}
end

function isLocked(self, id)
    return self.locks[id] ~= nil
end

function isAllUnlocked(self)
    for _ in pairs(self.locks) do
        return false
    end
    return true
end

function autoUnlock(self, id, timeout)
    LoopManager:setTimeout(timeout, nil, function()
        self:unlock(id)
    end)
end

return _M
