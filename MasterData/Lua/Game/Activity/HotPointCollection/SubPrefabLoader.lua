--region import
---@type HotPointCollectionConstants
local HotPointCollectionConstants = import("Game.Activity.HotPointCollection.HotPointCollectionConstants")
---@type Engine.Modules.ResourceModule
local ResourceModule  = CS.Engine.Modules.ResourceModule
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region defines

--endregion

---@class SubPrefabLoader
local SubPrefabLoader = Class('SubPrefabLoader')

function SubPrefabLoader:__init(prefabPath, parent, callback)
    self._prefabPath = prefabPath
    self._parent     = parent
    self._callback   = callback
    self._loadStatus = HotPointCollectionConstants.LoadStatus.Non
end


function SubPrefabLoader:__delete()
    if isNotNull(self._go) then
        KTool.SafeDelete(self._go)
    end
    self._callback = nil
end


function SubPrefabLoader:GetInstance()
    if self._loadStatus == HotPointCollectionConstants.LoadStatus.Processing then
        return false
    end

    if self._loadStatus == HotPointCollectionConstants.LoadStatus.Finished then
        return true
    end

    self._loadStatus = HotPointCollectionConstants.LoadStatus.Processing
    local callback = function (go)
        if self._callback then
            self._callback(go)
        end
        self._go = go
        self._loadStatus = HotPointCollectionConstants.LoadStatus.Finished
    end
    ResourceModule.LoadGameObjectAsync(self._prefabPath, callback, true, self._parent)
    
    return false
end

function SubPrefabLoader:IsFinished()
    return self._loadStatus == HotPointCollectionConstants.LoadStatus.Finished
end

return SubPrefabLoader
