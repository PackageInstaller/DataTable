local M = {}
M.__index = M
local file_name_pattern = "^.+[/\\](.+)$"

function M.get_file_name(file_full_path)
  if type(file_full_path) ~= "string" then
    return
  end
  do return file_full_path.match, file_full_path end
  return file_full_path.match, file_full_path, file_name_pattern
end

return M
