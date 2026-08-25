local BRACKET_DICT = {
  ["{"] = "}"
}
local QUOTATION_LIST = {
  ["\""] = true,
  ["'"] = true
}
local M = {}

local function Strip(str, substr)
  str = str:trim()
  str = str:trim(substr)
  return str
end

function M.is_list(arg)
  local is_list = false
  for i, c in pairs(arg) do
    if nil ~= BRACKET_DICT[c] then
      return true
    end
    if nil ~= QUOTATION_LIST[c] then
      return true
    end
    if "=" == c then
      return false
    end
  end
  return true
end

function M.get_value_from_string(arg)
  arg = arg:trim()
  local first_char = string.sub(arg, 1, 1)
  local size = string.len(arg)
  local key, value
  if "{" == first_char then
    if 1 == size then
      return {}
    end
    local data = {}
    arg = string.sub(arg, 2)
    if M.is_list(arg:sub(1, #arg - 1)) then
      while nil ~= arg do
        value, arg = M.get_first_arg(arg, ",")
        if "" == arg then
          table.insert(data, value)
          break
        end
        assert(nil ~= arg, "invalid table")
        arg = Strip(arg, ",")
        table.insert(data, value)
      end
    else
      while nil ~= arg do
        key, arg = M.get_first_arg(arg, "=")
        if nil == arg then
          break
        end
        if "" == key then
          table.insert(data, arg)
        else
          value, arg = M.get_first_arg(arg, ",")
          assert(nil ~= arg, "invalid table")
          arg = Strip(arg, ",")
          data[key] = value
        end
      end
    end
    return data
  elseif "'" == first_char or "\"" == first_char then
    if 2 == size then
      return ""
    end
    do return string.sub, arg, 2 end
    return string.sub, arg, 2, size - 1, arg:sub(1, #arg - 1)
  end
end

function M.get_arg(arg, split_str)
  split_str = split_str or ","
  arg = Strip(arg, ",")
  local real_arg
  real_arg, arg = M.get_first_arg(arg, split_str)
  assert(nil ~= arg, "invalid xson data")
  return real_arg
end

function M.get_first_arg(arg, split_str)
  arg = Strip(arg, split_str)
  if 0 == string.len(arg) then
    return nil, nil
  end
  local first_char = string.sub(arg, 1, 1)
  local next_arg
  if nil ~= BRACKET_DICT[first_char] then
    local pos = M.get_pos_by_bracket_pairs(arg, first_char, BRACKET_DICT[first_char])
    assert(0 ~= pos, "bracket not pairs")
    next_arg = M.get_value_from_string(string.sub(arg, 1, pos - 1))
    arg = string.sub(arg, pos + 1)
    return next_arg, arg
  elseif nil ~= QUOTATION_LIST[first_char] then
    for i, c in pairs(arg) do
      if 1 ~= i and c == first_char then
        next_arg = string.sub(arg, 2, i - 1)
        arg = string.sub(arg, i + 3)
        return next_arg, arg
      end
    end
    return nil, nil
  else
    local split_arg_list = arg:split(split_str)
    next_arg = split_arg_list[1]
    if 1 == #split_arg_list then
      arg = ""
    else
      table.remove(split_arg_list, 1)
      arg = table.concat(split_arg_list, split_str)
    end
    next_arg = Strip(next_arg)
    local value = tonumber(next_arg)
    if nil ~= value then
      return value, arg
    end
    if "nil" == next_arg then
      next_arg = nil
    elseif "true" == next_arg then
      next_arg = true
    elseif "false" == next_arg then
      next_arg = false
    end
    return next_arg, arg
  end
end

function M.get_pos_by_bracket_pairs(arg, first_bracket, last_bracket)
  if string.sub(arg, 1, 1) ~= first_bracket then
    return 0
  end
  local bracket_count = 0
  for i, c in pairs(arg) do
    if c == first_bracket then
      bracket_count = bracket_count + 1
    elseif c == last_bracket then
      bracket_count = bracket_count - 1
      if 0 == bracket_count then
        return i
      end
    end
  end
  return 0
end

function M.loads(s, split_str)
  split_str = split_str or ","
  if "," ~= split_str then
    s = s:replace(split_str, ",")
  end
  print("Loads", s)
  do return M.get_arg, s end
  return M.get_arg, s, split_str, ","
end

function M.load_list(s)
  local split_str = " "
  local str = "{" .. s .. "}"
  print(str, "!!!load_list")
  local ret = M.loads(str, split_str)
  print("ret", table.tostring(ret))
  return ret
end

return M
