module('BaseRo', Class.impl(nil))

function ctor(self)
    setmetatable(self, {
        __index = function(table, key)
            -- 首先在子类表中查找
            local value = rawget(table.class, key)
            if value ~= nil then
                return value
            end

            -- 检查是否是getter方法，且属性存在
            local name = convertName(key)
            local getterValue = rawget(table, name)
            if getterValue ~= nil then
                return function() return getterValue end -- 返回getter函数
            else
                return rawget(BaseRo, key)
            end
        end
    })

    -- 子类如果声明了parseData，会在其背后默认添加上父类的parseData
    if self.parseData and self.parseData ~= BaseRo.parseData then
        local originalParseData = self.parseData
        self.parseData = function(self, refID, refData)
            -- 首先调用子类自定义的parseData
            originalParseData(self, refID, refData)
            -- 然后调用BaseRo的parseData
            BaseRo.parseData(self, refID, refData)
        end
    end
end

-- 函数名转换为成员变量名，例子： getTalkGroup转换为m_talkGroup
function convertName(originalName)
    if originalName:sub(1, 3) == "get" then
        -- 提取 'get' 之后的部分，并将首字母转换为小写
        local propertyName = originalName:sub(4)
        propertyName = propertyName:sub(1, 1):lower() .. propertyName:sub(2)
        return "m_" .. propertyName
    else
        return originalName
    end
end

-- BaseRo类的parseData方法
function parseData(self, refID, refData)
    for k, v in pairs(refData) do
        self["m_" .. k] = v -- 动态赋值
    end
end

return _M
