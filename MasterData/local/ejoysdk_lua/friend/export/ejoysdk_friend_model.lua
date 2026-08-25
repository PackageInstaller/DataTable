local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local ImplClass = require("ejoysdk_lua.friend.ejoysdk_friend_model_impl")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local FRIEND = require("ejoysdk_lua.friend.ejoysdk_friend")
local FAVOR = require("ejoysdk_lua.friend.ejoysdk_favor")
local M = Class:Inherit("friend_model")

function M:_init(handler, init_param)
  self.impl = ImplClass:New(handler, init_param)
end

function M:destroy()
  if self.impl then
    self.impl:destroy()
  end
end

do
  local function wrap_func(target)
    for k, v in pairs(target) do
      if type(v) == "function" and not E.Utils.start_with(k, "_") and not M[k] and "init" ~= k then
        M[k] = function(self, ...)
          do return v, ... end
          
          return v, ...
        end
      end
    end
  end
  
  wrap_func(FRIEND)
  wrap_func(FAVOR)
end
E_UTILS.do_export_wrapping(M, "chat")
return M
