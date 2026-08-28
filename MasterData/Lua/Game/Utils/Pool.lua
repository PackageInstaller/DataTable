--region import

--endregion

--region defines

--endregion

---@class Pool
local Pool = Class('Pool')


function Pool:__init(createObj, poolSize)
    self:Create(createObj, poolSize)
end

function Pool:__delete()
    self:Clear()
end

---Create
---@param createObj fun():table
---@param poolSize number
function Pool:Create(createObj, poolSize)
    poolSize = poolSize or 16

    local objects = {}
	for _ = 1, poolSize do
		table.insert(objects, createObj())
	end

    self._createObj = createObj
    self._poolSize  = poolSize
    self._objects   = objects

end

function Pool:Obtain()
    return #self._objects == 0 and self._createObj() or table.remove(self._objects)
end

function Pool:Free(obj)
    local objects = self._objects
    if obj.Reset then
        obj.Reset(obj)
    end
    table.insert(objects, obj)

end

function Pool:Clear()
    for key in pairs(self._objects) do
        self._objects[key] = nil
    end
end

return Pool
