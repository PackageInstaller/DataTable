-------------------------------------------------------------------------------
-- 基础返回数据封装
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-08-08 10:26:39
-------------------------------------------------------------------------------

---@class BaseDojo
local BaseDojo = Class('BaseDojo')


function BaseDojo:__init()
end


function BaseDojo:__delete()
end


---@param jsonData table
---@return BaseDojo
function BaseDojo:Fill(jsonData)
    for key, value in pairs(jsonData or {}) do
        --只更新自己关心的数据
        if isNotNull(value) and table.haskey(self,key) then
            self[key] = value
        end
    end
    return self
end


return BaseDojo
