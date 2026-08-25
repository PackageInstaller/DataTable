local file = require("ejoysdk_lua.ejoysdk_file")
local M = {}

function M.download_file(url, opts, cb)
  if not cb or type(cb) ~= "function" then
    return
  end
  file.download_file(url, opts, function(succ, ...)
    if succ then
      local body = (...)
      body = body or {}
      cb({
        code = 200,
        msg = "succ",
        data = body
      })
    else
      local code, msg = ...
      code = code or 0
      msg = msg or "fail"
      cb({code = code, msg = msg})
    end
  end)
end

return M
