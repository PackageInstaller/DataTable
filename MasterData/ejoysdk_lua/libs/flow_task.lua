local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local Handler = {}
local TAG = EM.MODULE.RES .. "flow_task"

function Handler:Inherit(class_type)
  local o = {}
  o.__index = o
  o.__ClassType__ = class_type or "<base class>"
  if self.__tostring then
    o.__tostring = self.__tostring
  end
  do return setmetatable, o end
  return setmetatable, o, self
end

function Handler:new(tag_name, o)
  o = o or {}
  o.tag = tag_name
  setmetatable(o, self)
  self.__index = self
  return o
end

function Handler:_init()
end

function Handler:SetSuccessor(s)
  self.successor = s
end

function Handler:run_next(params)
  local cur_processor_tag = self:get_tag()
  if self.successor then
    local next_processor_tag = self.successor:get_tag()
    E.LOG.debug(TAG, "current finished:" .. tostring(cur_processor_tag) .. ", begin run next:" .. tostring(next_processor_tag))
    self.successor:run(params)
  else
    E.LOG.debug(TAG, "no next processor, current finished:" .. tostring(cur_processor_tag))
  end
end

function Handler:post_next(params)
  E.Timer.once(0, function()
    self:run_next(params)
  end)
end

function Handler:next()
  return self.successor
end

function Handler:has_next()
  return self.successor ~= nil
end

function Handler:run()
  local tag_name = self:get_tag()
  E.LOG.warn(TAG, "task not implements run method: " .. tostring(tag_name))
end

function Handler:post()
  _ejoysdk.log("post begin1:" .. tostring(self:get_tag()))
  E.Timer.once(0, function()
    _ejoysdk.log("post begin2:" .. tostring(self:get_tag()))
    self:run()
    _ejoysdk.log("post begin3:" .. tostring(self:get_tag()))
  end)
end

function Handler:get_tag()
  return self.tag
end

return Handler
