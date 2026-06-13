local M = BaseClass("RedPointMgr", Singleton)

local CS_RedPoint = CS.GameX.RedPoint

function M:__init()
    self._allChecker = {}
    self._isLoaded = false
end

function M:AddChecker(type, className)
    local checkerClass = require(className)
    local checker = checkerClass.New(type)
    self._isLoaded = true
    return checker
end

function M:Notify(type, isActive)
    if not self._isLoaded then
        return
    end
    CS_RedPoint.Notify(type, isActive)
end

function M:ForceCheck(type)
    CS_RedPoint.ForceCheck(type)
end

function M:Cleanup()
end

function M:Dispose()
end

return M
