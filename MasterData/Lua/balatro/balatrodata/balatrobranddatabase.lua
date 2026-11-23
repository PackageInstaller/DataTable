








BalatroBrandDataBase = {}
BalatroBrandDataBase.__index = BalatroBrandDataBase

function BalatroBrandDataBase.New()

    local obj = setmetatable({}, BalatroBrandDataBase)
    obj._ID = nil
    obj._Name = ""
    obj._Des = ""
    obj._ResName = ""
    obj._Effect = nil
    return obj
end

function BalatroBrandDataBase:GetID()
    return self._ID
end

function BalatroBrandDataBase:GetName()
    return self._Name
end

function BalatroBrandDataBase:GetDes()
    return self._Des
end

function BalatroBrandDataBase:GetResName()
    return self._ResName
end



function BalatroBrandDataBase:Execute(cardLst, otherParam)
    if type(self._Effect) == BalatroUtil.LuaDataType.Function then
        self._Effect(self, cardLst, otherParam)
    end
end