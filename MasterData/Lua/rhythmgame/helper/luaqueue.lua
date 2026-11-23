LuaQueue = {}

LuaQueue.__index = LuaQueue

LuaQueue.New = function()
    local obj = {}
    setmetatable(obj, LuaQueue)
    obj:InitQueue()
    return obj
end

function LuaQueue:InitQueue()
    self.list = {}
    self.Count = 0
end

function LuaQueue:Enqueue(item)
    table.insert(self.list, item) 
    self.Count = self.Count + 1
end

function LuaQueue:Dequeue()
    if self.Count == 0 then
        return nil
    end

    local item = self.list[1]
    table.remove(self.list,1)
    self.Count = self.Count - 1

    return item
end

function LuaQueue:Peek()
    if self.Count == 0 then
        return nil
    end

    return self.list[1]
end

function LuaQueue:Clear()
    self.list = {}
    self.Count = 0
end


