local BaseExpression, Super = System.NewClass("BaseExpression")

function BaseExpression:ctor()
  Super.ctor(self)
end

function BaseExpression:InitGetter()
  local preMt = getmetatable(self)
  local getter = {
    __index = function(_, key)
      local cfg = bg.DT.BattleApi[key]
      if cfg then
        if string.find(cfg.ApiType, "属性") or cfg.ApiType == "目标" then
          local GetAttr = preMt.__index.GetAttr or self.DefaultAttr
          local attrValue = GetAttr(self, key)
          if bc.IsPrintCmd then
            if nil == attrValue then
              print(self.__name .. " 表达式访问属性值为 nil " .. key)
            else
              print(string.format("表达式访问属性:%s, 值:%s", key, attrValue))
            end
          end
          return attrValue or 0
        elseif cfg.ApiType == "公式" then
          local func = preMt.__index[key]
          if func then
            func = System.fn(self, func)
            do return end
            return func, self, func, string.format("表达式访问属性:%s, 值:%s", key, attrValue)
          else
            return 0
          end
        else
          local func = preMt.__index[key]
          if func then
            func = System.fn(self, func)
            return func
          else
            func = System.bind(self.DefaultFunc, self, key)
            return func
          end
        end
      elseif "string" == type(key) and not preMt.__index[key] then
        error(self.__name .. " 方法未定义" .. key)
      end
      return preMt.__index[key]
    end,
    __kind = preMt.__kind,
    __name = preMt.__name,
    __inherits = preMt.__inherits,
    __fullname = preMt.__fullname,
    __super = preMt.__super
  }
  setmetatable(self, getter)
end

function BaseExpression:DefaultAttr(key)
  return 0
end

function BaseExpression:DefaultFunc(funcName)
  print("----调用默认表达式函数: ", funcName, self.__name)
  return 0
end

return BaseExpression
