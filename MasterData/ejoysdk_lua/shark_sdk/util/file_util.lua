local ejoysdk = require("ejoysdk_lua.ejoysdk")
local M = {}

function M.file_exists(file_path)
  local ok = ejoysdk.File.exists(file_path, false)
  return ok
end

function M.read_file(file_path)
  local data = ejoysdk.File.readfile(file_path, false)
  return data
end

function M.get_file_md5(file_path)
  local md5, code, err = ejoysdk.File.md5(file_path)
  if nil ~= code and 0 ~= code then
    return "", err
  end
  return md5, nil
end

return M
