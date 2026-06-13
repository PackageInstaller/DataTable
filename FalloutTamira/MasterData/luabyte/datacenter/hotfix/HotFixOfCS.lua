local function hotfix_ex(cs, field, func)
    assert(type(field) == 'string' and type(func) == 'function', 'invalid argument: #2 string needed, #3 function needed!')
    local function func_after(...)
        xlua.hotfix(cs, field, nil)
        local ret = { func(...) }
        xlua.hotfix(cs, field, func_after)
        return table.unpack(ret)
    end
    xlua.hotfix(cs, field, func_after)
end

local function hotfix(cs, field, fuc)
    xlua.hotfix(cs, field, fuc)
end

-- 关闭角色档案红点 24.12.14
-- local function HotFixStoryRedPoint()
--     xlua.private_accessible(CS.GameX.GameData.HeroDataMgrNew)
--     --用于热更之后第一次读取英雄数据错误
--     hotfix_ex(CS.GameX.GameData.HeroDataMgrNew, "IsStoryRedPoint", function(self, id)
--         return false
--     end)
-- end

-- local function UnHotFixStoryRedPoint()
--     hotfix(CS.GameX.GameData.HeroDataMgrNew, "IsStoryRedPoint", nil)
-- end

local function Register()
    if not CS.GameX.GameGlobal.EnableHotFixMode then
        return
    end
    -- HotFixStoryRedPoint()
end

local function Unregister()
    if not CS.GameX.GameGlobal.EnableHotFixMode then
        return
    end
    -- UnHotFixStoryRedPoint()
end

-- 热修复调用原方法
-- local class = CS.XLuaExample.HotfixExample
-- local engine = CS.UnityEngine
-- xlua.private_accessible(class)

-- local util = require 'util'
-- util.hotfix_ex(class,"Update",function(self)
-- 	-- 调用原本的方法
--     self.Update(self)
--     if self._timer>1 then
--         engine.Debug.Log("这是Lua代码")
--     end
-- end)

return { Register = Register, Unregister = Unregister }
