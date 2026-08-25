local Class = require("ejoysdk_lua.ejoysdk_class")
local Interface = Class:Inherit("Interface")

function Interface:_init(name, methods)
  self.name = name
  self.methods = methods
end

function Interface:check(obj)
  local missing = {}
  for _, method in ipairs(self.methods) do
    if not obj[method] then
      table.insert(missing, method)
    end
  end
  if #missing > 0 then
    error(string.format("Interface %s missing methods: %s", self.name, table.concat(missing, ", ")))
  end
end

return Interface
