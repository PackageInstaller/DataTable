local AM = require("ejoysdk_lua.age_mark.age_mark")
local Utils = require("ejoysdk_lua.native.utils.Utils")
local M = {}

function M.get_age_mark(opts, cb)
  AM.get_age_mark(opts, function(succ, ...)
    if succ then
      local body = (...)
      body = body or {}
      Utils.notify(cb, 200, "succ", body)
    else
      local code, msg = ...
      code = code or 0
      msg = msg or "fail"
      Utils.notify(cb, code, msg)
    end
  end)
end

function M.open_age_mark_page(cb)
  AM.open_age_mark_page(function(succ, ...)
    if succ then
      local body = (...)
      body = body or {}
      Utils.notify(cb, 200, "succ", body)
    else
      local code, msg = ...
      code = code or 0
      msg = msg or "fail"
      Utils.notify(cb, code, msg)
    end
  end)
end

return M
