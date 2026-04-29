function echo(t)
  local s = echo_var(t, 0, "\t", "\n", false)
  
  return s
end

function echo_not_escape(t)
  local s = echo_var(t, 0, "\t", "\n", true)
  return s
end

function echo_one_line(logLevel, t)
  if logLevel < Log.loglevel then
    return
  end
  local s = echo_var(t, 0, " ", " ")
  return s
end

function ohce(str)
  local s = "return " .. str
  local func = load(s)
  local t = func()
  local c = table_to_class(t)
  return c
end

function echo_var(v, depth, tab, newline, notescape)
  if type(v) == "table" then
    return echo_table(v, depth, tab, newline, notescape)
  elseif type(v) == "number" then
    return tostring(v)
  elseif type(v) == "boolean" then
    return tostring(v)
  elseif type(v) == "string" then
    if notescape then
      return "[[" .. v .. "]]"
    else
      return "\"" .. v .. "\""
    end
  else
    return nil
  end
end

local function SortFunc_echo_table(a, b)
  if a.k and b.k and type(a.k) == type(b.k) then
    return a.k < b.k
  elseif a.k and b.k and type(a.k) == "number" then
    return true
  else
    return false
  end
end

function echo_table(t, depth, ctab, newline, notescape)
  local tab = ""
  for i = 1, depth do
    tab = tab .. ctab
  end
  if next(t) == nil then
    return "{}"
  end
  local st = table.create(11, 0)
  st[1] = "{" .. newline
  if t._className == "Vector2" then
    st[#st + 1] = tab
    st[#st + 1] = "_className = \"Vector2\"," .. newline
  elseif t._className == "Vector3" then
    st[#st + 1] = tab
    st[#st + 1] = "_className = \"Vector3\"," .. newline
  end
  local tCount = 0
  for k, v in pairs(t) do
    tCount = tCount + 1
  end
  local arr = table.create(tCount, 0)
  for k, v in pairs(t) do
    arr[#arr + 1] = {k = k, v = v}
  end
  table.sort(arr, SortFunc_echo_table)
  for i, e in ipairs(arr) do
    local k, v = e.k, e.v
    local var = echo_var(v, depth + 1, ctab, newline, notescape)
    if var then
      if type(k) == "number" then
        st[#st + 1] = tab
        st[#st + 1] = "["
        st[#st + 1] = k
        st[#st + 1] = "] = "
        st[#st + 1] = var
        st[#st + 1] = "," .. newline
      else
        st[#st + 1] = tab
        st[#st + 1] = k
        st[#st + 1] = " = "
        st[#st + 1] = var
        st[#st + 1] = "," .. newline
      end
    end
  end
  st[#st + 1] = tab
  st[#st + 1] = "}"
  local s = table.concat(st)
  return s
end

function table_to_class(t)
  if type(t) == "table" and t._className then
    if t._className == "Vector2" then
      return Vector2(t.x, t.y)
    elseif t._className == "Vector3" then
      return Vector3(t.x, t.y, t.z)
    end
    local c = _G[t._className]:New()
    for k, v in pairs(t) do
      c[k] = table_to_class(v)
    end
    return c
  elseif type(t) == "table" then
    local c = {}
    for k, v in pairs(t) do
      c[k] = table_to_class(v)
    end
    return c
  else
    return t
  end
end

function class_to_class(t, touched)
  touched = touched or {}
  if type(t) == "table" then
    if touched[t] then
      return touched[t]
    end
    local c
    if t._className then
      if t._className == "Vector2" then
        c = Vector2(t.x, t.y)
      elseif t._className == "Vector3" then
        c = Vector3(t.x, t.y, t.z)
      else
        c = _G[t._className]:New()
        for k, v in pairs(t) do
          c[k] = class_to_class(v, touched)
        end
      end
    else
      c = {}
      for k, v in pairs(t) do
        c[k] = class_to_class(v, touched)
      end
    end
    touched[t] = c
    return c
  else
    return t
  end
end

function table_equal(a, b, ex)
  for k, u in pairs(a) do
    if not ex or not ex[k] then
      local v = b[k]
      if not v then
        return false
      end
      if type(u) == "table" then
        if not table_equal(u, v) then
          return false
        end
      elseif type(u) == "number" then
        if math.abs(u - v) >= 0.001 then
          return false
        end
      elseif u ~= v then
        return false
      end
    end
  end
  return true
end

ParseTableState = {
  BeginTable = 1,
  EndTable = 2,
  BeginValue = 3,
  EndValue = 4,
  BeginKeyNum = 5,
  ScanKeyNum = 6,
  EndKeyNum = 7,
  BeginKeyID = 8,
  ScanKeyID = 9,
  EndKeyID = 10,
  ScanValueNum = 11,
  ScanValueStr = 12,
  ScanValueBool = 13
}
BooleanDict = {
  t = "r",
  r = "u",
  u = "e",
  e = true,
  f = "a",
  a = "l",
  l = "s",
  s = "e"
}

function is_table_string(s)
  local state = 0
  local depth = 0
  local lastChar = 0
  local s = string.gsub(s, [[
[
	]+]], " ")
  local t = {
    string.byte(s, 1, #s)
  }
  for i, b in ipairs(t) do
    local c = string.char(b)
    ::lbl_26::
    if state == 0 then
      if c ~= " " then
        if c == "{" then
          state = ParseTableState.BeginTable
      else
      end
      else
        return false
      end
    elseif state == ParseTableState.EndValue then
      state = ParseTableState.BeginTable
      goto lbl_26
    elseif state == ParseTableState.BeginTable then
      if c ~= " " then
        if c == "}" then
          state = ParseTableState.EndTable
        elseif c == "[" then
          state = ParseTableState.BeginKeyNum
        elseif string.match(c, "[_%w]") then
          state = ParseTableState.BeginKeyID
        else
          return false
        end
      end
    elseif state == ParseTableState.EndTable then
      if 0 < depth then
        depth = depth - 1
        if c == "," then
          state = ParseTableState.EndValue
        else
          return false
        end
      else
        return false
      end
    elseif state == ParseTableState.BeginKeyNum then
      if string.match(c, "%d") then
        state = ParseTableState.ScanKeyNum
      else
        return false
      end
    elseif state == ParseTableState.ScanKeyNum then
      if not string.match(c, "%d") then
        if c == "]" then
          state = ParseTableState.EndKeyNum
        else
          return false
        end
      end
    elseif state == ParseTableState.BeginKeyID then
      if not string.match(c, "[_%w]") then
        if c == " " then
          state = ParseTableState.EndKeyID
        else
          return false
        end
      end
    elseif state == ParseTableState.EndKeyNum or state == ParseTableState.EndKeyID then
      if c ~= " " then
        if c == "=" then
          state = ParseTableState.BeginValue
        else
          return false
        end
      end
    elseif state == ParseTableState.BeginValue then
      if c ~= " " then
        if c == "-" or string.match(c, "%d") then
          state = ParseTableState.ScanValueNum
        elseif c == "\"" then
          c = 0
          state = ParseTableState.ScanValueStr
        elseif c == "t" or c == "f" then
          state = ParseTableState.ScanValueBool
        elseif c == "{" then
          depth = depth + 1
          state = ParseTableState.BeginTable
        else
          return false
        end
      end
    elseif state == ParseTableState.ScanValueNum then
      if not string.match(c, "[%d%.]") then
        if c == "," then
          state = ParseTableState.EndValue
        else
          return false
        end
      end
    elseif state == ParseTableState.ScanValueStr then
      if lastChar == "\"" then
        if c == "," then
          state = ParseTableState.EndValue
        else
          do return false end
          goto lbl_261
        end
      else
      end
    elseif state == ParseTableState.ScanValueBool and BooleanDict[lastChar] ~= c then
      if BooleanDict[lastChar] == true and c == "," then
        state = ParseTableState.EndValue
      else
        return false
      end
    end
    ::lbl_261::
    lastChar = c
  end
  return state == ParseTableState.EndTable
end
