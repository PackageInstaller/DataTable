local unpack = unpack or table.unpack

local function split(split_string, pattern, search_pos_begin, plain)
  assert(type(split_string) == "string")
  assert(type(pattern) == "string" and 0 < #pattern)
  search_pos_begin = search_pos_begin or 1
  plain = plain == nil or plain
  local split_result = {}
  if string.IsNullOrEmpty(split_string) then
    return split_result
  end
  while true do
    local find_pos_begin, find_pos_end = string.find(split_string, pattern, search_pos_begin, plain)
    if not find_pos_begin then
      break
    end
    local cur_str
    if search_pos_begin < find_pos_begin then
      cur_str = string.sub(split_string, search_pos_begin, find_pos_begin - 1)
    else
      cur_str = ""
    end
    split_result[#split_result + 1] = cur_str
    search_pos_begin = find_pos_end + 1
  end
  if search_pos_begin <= string.len(split_string) then
    split_result[#split_result + 1] = string.sub(split_string, search_pos_begin)
  else
    split_result[#split_result + 1] = ""
  end
  return split_result
end

local function join(join_table, joiner)
  if #join_table == 0 then
    return ""
  end
  local fmt = "%s"
  for i = 2, #join_table do
    fmt = fmt .. joiner .. "%s"
  end
  return string.format(fmt, unpack(join_table))
end

local function contains(target_string, pattern, plain)
  plain = plain == nil and true or plain
  local find_pos_begin, find_pos_end = string.find(target_string, pattern, 1, plain)
  return find_pos_begin ~= nil
end

local function startswith(target_string, start_pattern, plain)
  plain = plain == nil and true or plain
  local find_pos_begin, find_pos_end = string.find(target_string, start_pattern, 1, plain)
  return find_pos_begin == 1
end

local function endswith(target_string, start_pattern, plain)
  plain = plain == nil and true or plain
  local find_pos_begin, find_pos_end = string.find(target_string, start_pattern, -#start_pattern, plain)
  return find_pos_end == #target_string
end

local function IsNullOrEmpty(target_string)
  if type(target_string) ~= "string" then
    return true
  end
  if target_string == "" or #target_string == 0 then
    return true
  end
  return false
end

local function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

string.split = split
string.join = join
string.contains = contains
string.startswith = startswith
string.endswith = endswith
string.IsNullOrEmpty = IsNullOrEmpty
string.trim = trim
