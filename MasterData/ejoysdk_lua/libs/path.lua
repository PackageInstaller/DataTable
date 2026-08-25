local E = require("ejoysdk_lua.ejoysdk")
local Path = {}
Path.sep = E.File.sep

function Path.join(base_path, ...)
  local path_parts = {
    ...
  }
  local parts_cnt = #path_parts
  if 0 == parts_cnt then
    return base_path
  end
  base_path = Path.trim_end_separator(base_path)
  local all_parts = {base_path}
  local end_part_has_sep_suffix = false
  local cur_idx = 1
  for i = 1, parts_cnt do
    cur_idx = cur_idx + 1
    local p = path_parts[i]
    if i == parts_cnt then
      local part_len = #p
      local last_ch = p:sub(part_len, part_len)
      end_part_has_sep_suffix = "/" == last_ch or "\\" == last_ch
    end
    p = Path.trim_separators(p)
    all_parts[cur_idx] = p
  end
  local complete_path = table.concat(all_parts, Path.sep)
  if end_part_has_sep_suffix then
    complete_path = complete_path .. Path.sep
  end
  return complete_path
end

function Path.uniform_sep(path)
  path = string.gsub(path, "/", Path.sep)
  return path
end

function Path.trim_end_separator(path)
  if nil == path or "" == path then
    return path
  end
  local pattern = "^(.-)[/\\]*$"
  do return path.gsub, path, pattern end
  return path.gsub, path, pattern, "%1"
end

function Path.trim_separators(path)
  if nil == path or "" == path then
    return path
  end
  local pattern = "^[/\\]*(.-)[/\\]*$"
  do return path.gsub, path, pattern end
  return path.gsub, path, pattern, "%1"
end

function Path.trim_begin_separator(path)
  if nil == path or "" == path then
    return path
  end
  local pattern = "^[/\\]*(.-)$"
  do return path.gsub, path, pattern end
  return path.gsub, path, pattern, "%1"
end

function Path.get_ext_file_dir()
  do return end
  return E.File.get_ext_file_dir, nil
end

local function string_by_deleting_last_component(path)
  local temp = string.reverse(path)
  local _, i = string.find(temp, "[/|\\]")
  if nil ~= i then
    local path_len = string.len(path)
    local offset = path_len - i + 1
    if 1 == offset then
      return "", path
    else
      return string.sub(path, 1, offset), string.sub(path, offset + 1, path_len)
    end
  else
    return "", path
  end
end

function Path.parent_dir(path)
  if not path or "" == path then
    return path
  end
  local end_ch = string.sub(path, string.len(path))
  if "/" == end_ch or "\\" == end_ch then
    path = string.sub(path, 1, string.len(path) - 1)
  end
  local parent_path, last_component = string_by_deleting_last_component(path)
  return parent_path, last_component
end

function Path.ensure_parent_dir(path)
  local dest_parent_dir = Path.parent_dir(path)
  local result, _msg
  result = Path.ensure_dir(dest_parent_dir)
  return result
end

function Path.ensure_dir(path)
  local parent_dir_exists = false
  if E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.FILE_DIR_OPERATION) then
    parent_dir_exists = E.File.exists_fullpath(path)
  end
  local result = parent_dir_exists
  if not parent_dir_exists and E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.MAKE_DIRS) then
    result = E.File.make_dirs(path)
  end
  return result
end

return Path
