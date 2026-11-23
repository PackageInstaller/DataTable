







BalatroObjectPool = {}
BalatroObjectPool.__index = BalatroObjectPool

function BalatroObjectPool:New()
    local instance = setmetatable({}, BalatroObjectPool)
    instance.pool = {}
    return instance
end

function BalatroObjectPool:CreateObject(prefab, parent)
    local obj = self.pool[prefab.name]
    if obj and #obj > 0 then
        local instance = table.remove(obj)
        SetActive(instance, true)
        return instance
    else
        local newObject = LuaMgr.InstantiateGO(prefab, parent, false)
        newObject.name = prefab.name
        return newObject
    end
end

function BalatroObjectPool:RecycleObject(object)
    if not object then
        return
    end

    SetActive(object, false)
    local objectName = object.name
    if not self.pool[objectName] then
        self.pool[objectName] = {}
    end
    table.insert(self.pool[objectName], object)
end

function BalatroObjectPool:ReleaseObject(object)
    local objectName = object.name
    local objects = self.pool[objectName]
    if not objects then
        return
    end
    for _, object in pairs(objects) do
        if object then
            LuaMgr.Destroy(object)
        end
    end
    for key, object in pairs(objects) do
        objects[key] = nil
    end
    self.pool[objectName] = nil
end

function BalatroObjectPool:ReleaseAll()
    for objectName, objects in pairs(self.pool) do
        for _, object in ipairs(objects) do
            if object then
                LuaMgr.Destroy(object)
            end
        end
        for key, object in pairs(objects) do
            objects[key] = nil
        end
        self.pool[objectName] = nil
    end
end

BalatroObjectPool.GetObject = function(prefab, parent)
    if not BalatroObjectPool.ObjectPool then
        BalatroObjectPool.ObjectPool = BalatroObjectPool:New()
    end
    return BalatroObjectPool.ObjectPool:CreateObject(prefab, parent)
end

BalatroObjectPool.RecycleObject = function(object)
    if not BalatroObjectPool.ObjectPool then
        return
    end
    BalatroObjectPool.ObjectPool:RecycleObject(object)
end