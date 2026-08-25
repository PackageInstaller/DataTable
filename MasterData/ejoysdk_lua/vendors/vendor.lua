local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("Vendor")
do
  local method = {
    ACCOUNT = {
      "check_token",
      "merge_info",
      "simple_token",
      "login",
      "logout"
    },
    PAY = {
      "pay",
      "can_pay",
      "product_list"
    },
    SHARE = {
      "share",
      "is_share_support"
    },
    AD = {},
    PUSH = {
      "bind_account",
      "bind_player_id",
      "bind_server_id",
      "set_handlers"
    },
    CUSTOM_SERVICE = {
      "show_custom_service"
    },
    STATS = {
      "commit_event"
    }
  }
  for type_, l in pairs(method) do
    for _, v in ipairs(l) do
      M[v] = function()
        assert(false, type_ .. "/" .. v .. " unimplemented")
      end
    end
  end
  
  function M.get_methods(ability)
    return method[ability]
  end
  
  function M:is_implemented(types)
    self.ability = types
    for _, type_ in ipairs(types) do
      local l = method[type_]
      for _, v in ipairs(l) do
        assert(rawget(self, v), "vendor " .. self.__ClassType__ .. ": " .. type_ .. "/" .. v .. " unimplemented")
      end
    end
    return true
  end
  
  function M:is_support_ability(types)
    for _, type_ in ipairs(types) do
      local l = method[type_]
      for _, v in ipairs(l) do
        local result = rawget(self, v)
        if not result then
          return false
        end
      end
    end
    return true
  end
  
  function M.merge_helper(a, b)
    local new = {}
    for k, v in pairs(a) do
      new[k] = v
    end
    for k, v in pairs(b) do
      new[k] = v
    end
    return new
  end
end
M.ABILITY = {
  ACCOUNT = "ACCOUNT",
  PAY = "PAY",
  SHARE = "SHARE",
  AD = "AD",
  PUSH = "PUSH",
  CUSTOM_SERVICE = "CUSTOM_SERVICE",
  STATS = "STATS",
  CHANNEL_AD = "CHANNEL_AD"
}
return M
