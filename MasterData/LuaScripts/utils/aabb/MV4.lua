module("MV4", Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    if self.goPoolName then
        self:recover()
    else
        self:destroy()
    end
    LuaPoolMgr:poolRecover(self)
end

function create(self,x,y,z,w)
    self.x = x
    self.y = y
    self.z = z
    self.w = w
end


return _M