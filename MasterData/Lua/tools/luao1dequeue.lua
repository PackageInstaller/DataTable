LuaO1DeQueue = {}
LuaO1DeQueue.__index = LuaO1DeQueue


function LuaO1DeQueue.New()
    local self = {}
    setmetatable(self, LuaO1DeQueue)
    self:InitQueue();
    return self
end

function LuaO1DeQueue:InitQueue()
    self.first=0;
    self.last=-1;
    self.list={};
    self.size=0;
end

function LuaO1DeQueue:Size()
    return self.size;
end

function LuaO1DeQueue:PushFirst(value)
    self.first=self.first-1;
    self.list[self.first]=value;
    self.size=self.size+1;
end

function LuaO1DeQueue:PushLast(value)
    self.last=self.last+1;
    self.list[self.last]=value;
    self.size=self.size+1;
end

function LuaO1DeQueue:PopFirst()
    if self.first>self.last then
        return nil;
    end
    local value=self.list[self.first];
    self.list[self.first]=nil;
    self.first=self.first+1;
    self.size=self.size-1;
    return value;
end

function LuaO1DeQueue:PopLast()
    if self.first>self.last then
        return nil;
    end
    local value=self.list[self.last];
    self.list[self.last]=nil;
    self.last=self.last-1;
    self.size=self.size-1;
    return value;
end