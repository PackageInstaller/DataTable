_G.BaseLuaEffect = _G.BaseLuaEffect or {}

ComponentProperty = new

function BaseLuaEffect:Init(skillEntity, ...)
    self.Entity = skillEntity
    self:Parse(...)
end

function BaseLuaEffect:Parse(...)
    local args = {...}

    for i = 1, #args do
        
    end
end