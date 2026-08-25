local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("ResSourceAdapter")

function M:check_update_file_list()
  assert(false, "check_update_file_list not implements")
end

function M:check_res_update()
  assert(false, "check_res_update not implements")
end

function M:mark_update_res_invalid()
  assert(false, "mark_update_res_invalid not implements")
end

return M
