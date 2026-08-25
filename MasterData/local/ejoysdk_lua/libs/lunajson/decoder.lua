local setmetatable, tonumber, tostring = setmetatable, tonumber, _ENV.tostring
local floor, inf = math.floor, math.huge
local mininteger, tointeger = math.mininteger or nil, math.tointeger or nil
local byte, char, find, gsub, match, sub = string.byte, string.char, string.find, string.gsub, string.match, string.sub

local function _decode_error(pos, errmsg)
  error("parse error at " .. pos .. ": " .. errmsg, 2)
end

local f_str_ctrl_pat
if _VERSION == "Lua 5.1" then
  f_str_ctrl_pat = "[^ -ÿ]"
else
  f_str_ctrl_pat = "[\000-\031]"
end
local _ENV

local function newdecoder()
  local json, pos, nullv, arraylen, rec_depth, dispatcher, f
  
  local function decode_error(errmsg)
    do return _decode_error, pos end
    return _decode_error, pos, errmsg
  end
  
  local function f_err()
    decode_error("invalid value")
  end
  
  local function f_nul()
    if "ull" == sub(json, pos, pos + 2) then
      pos = pos + 3
      return nullv
    end
    decode_error("invalid value")
  end
  
  local function f_fls()
    if "alse" == sub(json, pos, pos + 3) then
      pos = pos + 4
      return false
    end
    decode_error("invalid value")
  end
  
  local function f_tru()
    if "rue" == sub(json, pos, pos + 2) then
      pos = pos + 3
      return true
    end
    decode_error("invalid value")
  end
  
  local radixmark = match(tostring(0.5), "[^0-9]")
  local fixedtonumber = tonumber
  if "." ~= radixmark then
    if find(radixmark, "%W") then
      radixmark = "%" .. radixmark
    end
    
    function fixedtonumber(s)
      do return tonumber, gsub(s, ".", radixmark) end
      return tonumber, gsub(s, ".", radixmark)
    end
  end
  
  local function number_error()
    do return decode_error end
    return decode_error, "invalid number"
  end
  
  local function f_zro(mns)
    local num, c = match(json, "^(%.?[0-9]*)([-+.A-Za-z]?)", pos)
    if "" == num then
      if "" == c then
        if mns then
          return -0.0
        end
        return 0
      end
      if "e" == c or "E" == c then
        num, c = match(json, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos)
        if "" == c then
          pos = pos + #num
          if mns then
            return -0.0
          end
          return 0.0
        end
      end
      number_error()
    end
    if 46 ~= byte(num) or 46 == byte(num, -1) then
      number_error()
    end
    if "" ~= c then
      if "e" == c or "E" == c then
        num, c = match(json, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos)
      end
      if "" ~= c then
        number_error()
      end
    end
    pos = pos + #num
    c = fixedtonumber(num)
    if mns then
      c = -c
    end
    return c
  end
  
  local function f_num(mns)
    pos = pos - 1
    local num, c = match(json, "^([0-9]+%.?[0-9]*)([-+.A-Za-z]?)", pos)
    if 46 == byte(num, -1) then
      number_error()
    end
    if "" ~= c then
      if "e" ~= c and "E" ~= c then
        number_error()
      end
      num, c = match(json, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos)
      if not num or "" ~= c then
        number_error()
      end
    end
    pos = pos + #num
    c = fixedtonumber(num)
    if mns then
      c = -c
      if c == mininteger and not find(num, "[^0-9]") then
        c = mininteger
      end
    end
    return c
  end
  
  local function f_mns()
    local c = byte(json, pos)
    if c then
      pos = pos + 1
      if c > 48 then
        if c < 58 then
          do return f_num end
          return f_num, true
        end
      elseif c > 47 then
        do return f_zro end
        return f_zro, true
      end
    end
    decode_error("invalid number")
  end
  
  local f_str_hextbl = {
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    10,
    11,
    12,
    13,
    14,
    15,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    inf,
    10,
    11,
    12,
    13,
    14,
    15,
    __index = function()
      return inf
    end
  }
  setmetatable(f_str_hextbl, f_str_hextbl)
  local f_str_escapetbl = {
    ["\""] = "\"",
    ["\\"] = "\\",
    ["/"] = "/",
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t",
    __index = function()
      decode_error("invalid escape sequence")
    end
  }
  setmetatable(f_str_escapetbl, f_str_escapetbl)
  
  local function surrogate_first_error()
    do return decode_error end
    return decode_error, "1st surrogate pair byte not continued by 2nd"
  end
  
  local f_str_surrogate_prev = 0
  
  local function f_str_subst(ch, ucode)
    if "u" == ch then
      local c1, c2, c3, c4, rest = byte(ucode, 1, 5)
      ucode = f_str_hextbl[c1 - 47] * 4096 + f_str_hextbl[c2 - 47] * 256 + f_str_hextbl[c3 - 47] * 16 + f_str_hextbl[c4 - 47]
      if ucode ~= inf then
        if ucode < 128 then
          if rest then
            do return char, ucode end
            return char, ucode, rest, nil, nil, nil
          end
          do return char end
          return char, ucode, rest, nil, nil, nil
        elseif ucode < 2048 then
          c1 = floor(ucode / 64)
          c2 = ucode - c1 * 64
          c1 = c1 + 192
          c2 = c2 + 128
          if rest then
            do return char, c1, c2 end
            return char, c1, c2, rest, nil, nil
          end
          do return char, c1 end
          return char, c1, c2, rest, nil, nil
        elseif ucode < 55296 or ucode >= 57344 then
          c1 = floor(ucode / 4096)
          ucode = ucode - c1 * 4096
          c2 = floor(ucode / 64)
          c3 = ucode - c2 * 64
          c1 = c1 + 224
          c2 = c2 + 128
          c3 = c3 + 128
          if rest then
            do return char, c1, c2, c3 end
            return char, c1, c2, c3, rest, nil
          end
          do return char, c1, c2 end
          return char, c1, c2, c3, rest, nil
        elseif ucode >= 55296 and ucode < 56320 then
          if 0 == f_str_surrogate_prev then
            f_str_surrogate_prev = ucode
            if not rest then
              return ""
            end
            surrogate_first_error()
          end
          f_str_surrogate_prev = 0
          surrogate_first_error()
        else
          if 0 ~= f_str_surrogate_prev then
            ucode = 65536 + (f_str_surrogate_prev - 55296) * 1024 + (ucode - 56320)
            f_str_surrogate_prev = 0
            c1 = floor(ucode / 262144)
            ucode = ucode - c1 * 262144
            c2 = floor(ucode / 4096)
            ucode = ucode - c2 * 4096
            c3 = floor(ucode / 64)
            c4 = ucode - c3 * 64
            c1 = c1 + 240
            c2 = c2 + 128
            c3 = c3 + 128
            c4 = c4 + 128
            if rest then
              do return char, c1, c2, c3, c4 end
              return char, c1, c2, c3, c4, rest
            end
            do return char, c1, c2, c3 end
            return char, c1, c2, c3, c4, rest
          end
          decode_error("2nd surrogate pair byte appeared without 1st")
        end
      end
      decode_error("invalid unicode codepoint literal")
    end
    if 0 ~= f_str_surrogate_prev then
      f_str_surrogate_prev = 0
      surrogate_first_error()
    end
    return f_str_escapetbl[ch] .. ucode
  end
  
  local f_str_keycache = setmetatable({}, {__mode = "v"})
  
  local function f_str(iskey)
    local newpos = pos
    local tmppos, c1, c2
    repeat
      newpos = find(json, "\"", newpos, true)
      if not newpos then
        decode_error("unterminated string")
      end
      tmppos = newpos - 1
      newpos = newpos + 1
      c1, c2 = byte(json, tmppos - 1, tmppos)
      if 92 == c2 and 92 == c1 then
        repeat
          tmppos = tmppos - 2
          c1, c2 = byte(json, tmppos - 1, tmppos)
        until 92 ~= c2 or 92 ~= c1
        tmppos = newpos - 2
      end
    until 92 ~= c2
    local str = sub(json, pos, tmppos)
    pos = newpos
    if iskey then
      tmppos = f_str_keycache[str]
      if tmppos then
        return tmppos
      end
      tmppos = str
    end
    if find(str, f_str_ctrl_pat) then
      decode_error("unescaped control string")
    end
    if find(str, "\\", 1, true) then
      str = gsub(str, "\\(.)([^\\]?[^\\]?[^\\]?[^\\]?[^\\]?)", f_str_subst)
      if 0 ~= f_str_surrogate_prev then
        f_str_surrogate_prev = 0
        decode_error("1st surrogate pair byte not continued by 2nd")
      end
    end
    if iskey then
      f_str_keycache[tmppos] = str
    end
    return str
  end
  
  local function f_ary()
    rec_depth = rec_depth + 1
    if rec_depth > 1000 then
      decode_error("too deeply nested json (> 1000)")
    end
    local ary = {}
    pos = match(json, "^[ \n\r\t]*()", pos)
    local i = 0
    if 93 == byte(json, pos) then
      pos = pos + 1
    else
      local newpos = pos
      repeat
        i = i + 1
        f = dispatcher[byte(json, newpos)]
        pos = newpos + 1
        ary[i] = f()
        newpos = match(json, "^[ \n\r\t]*,[ \n\r\t]*()", pos)
      until not newpos
      newpos = match(json, "^[ \n\r\t]*%]()", pos)
      if not newpos then
        decode_error("no closing bracket of an array")
      end
      pos = newpos
    end
    if arraylen then
      ary[0] = i
    end
    rec_depth = rec_depth - 1
    return ary
  end
  
  local function f_obj()
    rec_depth = rec_depth + 1
    if rec_depth > 1000 then
      decode_error("too deeply nested json (> 1000)")
    end
    local obj = {}
    pos = match(json, "^[ \n\r\t]*()", pos)
    if 125 == byte(json, pos) then
      pos = pos + 1
    else
      local newpos = pos
      repeat
        if 34 ~= byte(json, newpos) then
          decode_error("not key")
        end
        pos = newpos + 1
        local key = f_str(true)
        f = f_err
        local c1, c2, c3 = byte(json, pos, pos + 3)
        if 58 == c1 then
          if 32 ~= c2 then
            f = dispatcher[c2]
            newpos = pos + 2
          else
            f = dispatcher[c3]
            newpos = pos + 3
          end
        end
        if f == f_err then
          newpos = match(json, "^[ \n\r\t]*:[ \n\r\t]*()", pos)
          if not newpos then
            decode_error("no colon after a key")
          end
          f = dispatcher[byte(json, newpos)]
          newpos = newpos + 1
        end
        pos = newpos
        obj[key] = f()
        newpos = match(json, "^[ \n\r\t]*,[ \n\r\t]*()", pos)
      until not newpos
      newpos = match(json, "^[ \n\r\t]*}()", pos)
      if not newpos then
        decode_error("no closing bracket of an object")
      end
      pos = newpos
    end
    rec_depth = rec_depth - 1
    return obj
  end
  
  dispatcher = {
    [0] = f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_str,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_mns,
    f_err,
    f_err,
    f_zro,
    f_num,
    f_num,
    f_num,
    f_num,
    f_num,
    f_num,
    f_num,
    f_num,
    f_num,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_ary,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_fls,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_nul,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_tru,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_err,
    f_obj,
    f_err,
    f_err,
    f_err,
    f_err,
    __index = function()
      decode_error("unexpected termination")
    end
  }
  setmetatable(dispatcher, dispatcher)
  
  local function decode(json_, pos_, nullv_, arraylen_)
    json, pos, nullv, arraylen = json_, pos_, nullv_, arraylen_
    rec_depth = 0
    pos = match(json, "^[ \n\r\t]*()", pos)
    f = dispatcher[byte(json, pos)]
    pos = pos + 1
    local v = f()
    if pos_ then
      return v, pos
    else
      f, pos = find(json, "^[ \n\r\t]*", pos)
      if pos ~= #json then
        decode_error("json ended")
      end
      return v
    end
  end
  
  return decode
end

return newdecoder
