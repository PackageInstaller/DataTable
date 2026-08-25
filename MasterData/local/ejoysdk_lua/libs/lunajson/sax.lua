local setmetatable, tonumber, tostring = setmetatable, tonumber, _ENV.tostring
local floor, inf = math.floor, math.huge
local mininteger, tointeger = math.mininteger or nil, math.tointeger or nil
local byte, char, find, gsub, match, sub = string.byte, string.char, string.find, string.gsub, string.match, string.sub

local function _parse_error(pos, errmsg)
  error("parse error at " .. pos .. ": " .. errmsg, 2)
end

local f_str_ctrl_pat
if _VERSION == "Lua 5.1" then
  f_str_ctrl_pat = "[^ -ÿ]"
else
  f_str_ctrl_pat = "[\000-\031]"
end
local type, unpack = type, table.unpack or _ENV.unpack
local open = io.open
local _ENV

local function nop()
end

local function newparser(src, saxtbl)
  local json, jsonnxt, rec_depth
  local jsonlen, pos, acc = 0, 1, 0
  local dispatcher, f
  if "string" == type(src) then
    json = src
    jsonlen = #json
    
    function jsonnxt()
      json = ""
      jsonlen = 0
      jsonnxt = nop
    end
  else
    function jsonnxt()
      acc = acc + jsonlen
      
      pos = 1
      repeat
        json = src()
        if not json then
          json = ""
          jsonlen = 0
          jsonnxt = nop
          return
        end
        jsonlen = #json
      until jsonlen > 0
    end
    
    jsonnxt()
  end
  local sax_startobject = saxtbl.startobject or nop
  local sax_key = saxtbl.key or nop
  local sax_endobject = saxtbl.endobject or nop
  local sax_startarray = saxtbl.startarray or nop
  local sax_endarray = saxtbl.endarray or nop
  local sax_string = saxtbl.string or nop
  local sax_number = saxtbl.number or nop
  local sax_boolean = saxtbl.boolean or nop
  local sax_null = saxtbl.null or nop
  
  local function tryc()
    local c = byte(json, pos)
    if not c then
      jsonnxt()
      c = byte(json, pos)
    end
    return c
  end
  
  local function parse_error(errmsg)
    do return _parse_error, acc + pos end
    return _parse_error, acc + pos, errmsg
  end
  
  local function tellc()
    return tryc() or parse_error("unexpected termination")
  end
  
  local function spaces()
    while true do
      pos = match(json, "^[ \n\r\t]*()", pos)
      if pos <= jsonlen then
        return
      end
      if 0 == jsonlen then
        parse_error("unexpected termination")
      end
      jsonnxt()
    end
  end
  
  local function f_err()
    parse_error("invalid value")
  end
  
  local function generic_constant(target, targetlen, ret, sax_f)
    for i = 1, targetlen do
      local c = tellc()
      if byte(target, i) ~= c then
        parse_error("invalid char")
      end
      pos = pos + 1
    end
    do return sax_f end
    return sax_f, ret, 1, nil, tellc(), pos + 1, "invalid char", i
  end
  
  local function f_nul()
    if "ull" == sub(json, pos, pos + 2) then
      pos = pos + 3
      do return sax_null end
      return sax_null, nil, pos, pos + 2, nil
    end
    do return generic_constant, "ull", 3, nil end
    return generic_constant, "ull", 3, nil, sax_null
  end
  
  local function f_fls()
    if "alse" == sub(json, pos, pos + 3) then
      pos = pos + 4
      do return sax_boolean end
      return sax_boolean, false, pos, pos + 3, nil
    end
    do return generic_constant, "alse", 4, false end
    return generic_constant, "alse", 4, false, sax_boolean
  end
  
  local function f_tru()
    if "rue" == sub(json, pos, pos + 2) then
      pos = pos + 3
      do return sax_boolean end
      return sax_boolean, true, pos, pos + 2, nil
    end
    do return generic_constant, "rue", 3, true end
    return generic_constant, "rue", 3, true, sax_boolean
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
    do return parse_error end
    return parse_error, "invalid number"
  end
  
  local function generic_number(mns)
    local buf = {}
    local i = 1
    local is_int = true
    local c = byte(json, pos)
    pos = pos + 1
    
    local function nxt()
      buf[i] = c
      i = i + 1
      c = tryc()
      pos = pos + 1
    end
    
    if 48 == c then
      nxt()
      if c and c >= 48 and c < 58 then
        number_error()
      end
    else
      repeat
        nxt()
      until not (c and c >= 48) or not (c < 58)
    end
    if 46 == c then
      is_int = false
      nxt()
      if not (c and c >= 48) or not (c < 58) then
        number_error()
      end
      repeat
        nxt()
      until not (c and c >= 48) or not (c < 58)
    end
    if 69 == c or 101 == c then
      is_int = false
      nxt()
      if 43 == c or 45 == c then
        nxt()
      end
      if not (c and c >= 48) or not (c < 58) then
        number_error()
      end
      repeat
        nxt()
      until not (c and c >= 48) or not (c < 58)
    end
    if c and (c >= 65 and c <= 91 or c >= 97 and c <= 123 or 43 == c or 45 == c or 46 == c) then
      number_error()
    end
    pos = pos - 1
    local num = char(unpack(buf))
    num = fixedtonumber(num)
    if mns then
      num = -num
      if num == mininteger and is_int then
        num = mininteger
      end
    end
    do return sax_number end
    return sax_number, num
  end
  
  local function f_zro(mns)
    local num, c = match(json, "^(%.?[0-9]*)([-+.A-Za-z]?)", pos)
    if "" == num then
      if pos > jsonlen then
        pos = pos - 1
        do return generic_number end
        return generic_number, mns, nil, nil
      end
      if "" == c then
        if mns then
          do return sax_number end
          return sax_number, -0.0, nil, nil
        end
        do return sax_number end
        return sax_number, 0, nil, nil
      end
      if "e" == c or "E" == c then
        num, c = match(json, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos)
        if "" == c then
          pos = pos + #num
          if pos > jsonlen then
            pos = pos - #num - 1
            do return generic_number end
            return generic_number, mns, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos
          end
          if mns then
            do return sax_number end
            return sax_number, -0.0, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos
          end
          do return sax_number end
          return sax_number, 0.0, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos
        end
      end
      pos = pos - 1
      do return generic_number end
      return generic_number, mns, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos
    end
    if 46 ~= byte(num) or 46 == byte(num, -1) then
      pos = pos - 1
      do return generic_number end
      return generic_number, mns, -1, pos
    end
    if "" ~= c then
      if "e" == c or "E" == c then
        num, c = match(json, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos)
      end
      if "" ~= c then
        pos = pos - 1
        do return generic_number end
        return generic_number, mns, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos
      end
    end
    pos = pos + #num
    if pos > jsonlen then
      pos = pos - #num - 1
      do return generic_number end
      return generic_number, mns, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos
    end
    c = fixedtonumber(num)
    if mns then
      c = -c
    end
    do return sax_number end
    return sax_number, c, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos
  end
  
  local function f_num(mns)
    pos = pos - 1
    local num, c = match(json, "^([0-9]+%.?[0-9]*)([-+.A-Za-z]?)", pos)
    if 46 == byte(num, -1) then
      do return generic_number end
      return generic_number, mns, -1, nil
    end
    if "" ~= c then
      if "e" ~= c and "E" ~= c then
        do return generic_number end
        return generic_number, mns, -1, nil
      end
      num, c = match(json, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos)
      if not num or "" ~= c then
        do return generic_number end
        return generic_number, mns, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos
      end
    end
    pos = pos + #num
    if pos > jsonlen then
      pos = pos - #num
      do return generic_number end
      return generic_number, mns, "^([^eE]*[eE][-+]?[0-9]+)([-+.A-Za-z]?)", pos
    end
    c = fixedtonumber(num)
    if mns then
      c = -c
      if c == mininteger and not find(num, "[^0-9]") then
        c = mininteger
      end
    end
    do return sax_number end
    return sax_number, c, "[^0-9]", pos
  end
  
  local function f_mns()
    local c = byte(json, pos) or tellc()
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
    parse_error("invalid number")
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
      parse_error("invalid escape sequence")
    end
  }
  setmetatable(f_str_escapetbl, f_str_escapetbl)
  
  local function surrogate_first_error()
    do return parse_error end
    return parse_error, "1st surrogate pair byte not continued by 2nd"
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
          parse_error("2nd surrogate pair byte appeared without 1st")
        end
      end
      parse_error("invalid unicode codepoint literal")
    end
    if 0 ~= f_str_surrogate_prev then
      f_str_surrogate_prev = 0
      surrogate_first_error()
    end
    return f_str_escapetbl[ch] .. ucode
  end
  
  local function f_str(iskey)
    local pos2 = pos
    local newpos
    local str = ""
    local bs
    while true do
      newpos = find(json, "[\\\"]", pos2)
      if not newpos then
        str = str .. sub(json, pos, jsonlen)
        if pos2 == jsonlen + 2 then
          pos2 = 2
        else
          pos2 = 1
        end
        jsonnxt()
        if 0 == jsonlen then
          parse_error("unterminated string")
        end
      else
        if 34 == byte(json, newpos) then
          break
        end
        pos2 = newpos + 2
        bs = true
      end
    end
    str = str .. sub(json, pos, newpos - 1)
    pos = newpos + 1
    if find(str, f_str_ctrl_pat) then
      parse_error("unescaped control string")
    end
    if bs then
      str = gsub(str, "\\(.)([^\\]?[^\\]?[^\\]?[^\\]?[^\\]?)", f_str_subst)
      if 0 ~= f_str_surrogate_prev then
        f_str_surrogate_prev = 0
        parse_error("1st surrogate pair byte not continued by 2nd")
      end
    end
    if iskey then
      do return sax_key end
      return sax_key, str, "\\(.)([^\\]?[^\\]?[^\\]?[^\\]?[^\\]?)", f_str_subst, newpos - 1
    end
    do return sax_string end
    return sax_string, str, "\\(.)([^\\]?[^\\]?[^\\]?[^\\]?[^\\]?)", f_str_subst, newpos - 1
  end
  
  local function f_ary()
    rec_depth = rec_depth + 1
    if rec_depth > 1000 then
      parse_error("too deeply nested json (> 1000)")
    end
    sax_startarray()
    spaces()
    if 93 ~= byte(json, pos) then
      local newpos
      while true do
        f = dispatcher[byte(json, pos)]
        pos = pos + 1
        f()
        newpos = match(json, "^[ \n\r\t]*,[ \n\r\t]*()", pos)
        if newpos then
          pos = newpos
        else
          newpos = match(json, "^[ \n\r\t]*%]()", pos)
          if newpos then
            pos = newpos
            break
          end
          spaces()
          local c = byte(json, pos)
          pos = pos + 1
          if 44 == c then
            spaces()
          else
            if 93 == c then
              break
            end
            parse_error("no closing bracket of an array")
          end
        end
        if pos > jsonlen then
          spaces()
        end
      end
    end
    rec_depth = rec_depth - 1
    do return end
    return sax_endarray, spaces, jsonlen, "no closing bracket of an array", pos
  end
  
  local function f_obj()
    rec_depth = rec_depth + 1
    if rec_depth > 1000 then
      parse_error("too deeply nested json (> 1000)")
    end
    sax_startobject()
    spaces()
    if 125 ~= byte(json, pos) then
      local newpos
      while true do
        if 34 ~= byte(json, pos) then
          parse_error("not key")
        end
        pos = pos + 1
        f_str(true)
        newpos = match(json, "^[ \n\r\t]*:[ \n\r\t]*()", pos)
        if newpos then
          pos = newpos
        else
          spaces()
          if 58 ~= byte(json, pos) then
            parse_error("no colon after a key")
          end
          pos = pos + 1
          spaces()
        end
        if pos > jsonlen then
          spaces()
        end
        f = dispatcher[byte(json, pos)]
        pos = pos + 1
        f()
        newpos = match(json, "^[ \n\r\t]*,[ \n\r\t]*()", pos)
        if newpos then
          pos = newpos
        else
          newpos = match(json, "^[ \n\r\t]*}()", pos)
          if newpos then
            pos = newpos
            break
          end
          spaces()
          local c = byte(json, pos)
          pos = pos + 1
          if 44 == c then
            spaces()
          else
            if 125 == c then
              break
            end
            parse_error("no closing bracket of an object")
          end
        end
        if pos > jsonlen then
          spaces()
        end
      end
    end
    rec_depth = rec_depth - 1
    do return end
    return sax_endobject, spaces, jsonlen, "no closing bracket of an object", pos
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
    f_err
  }
  
  local function run()
    rec_depth = 0
    spaces()
    f = dispatcher[byte(json, pos)]
    pos = pos + 1
    f()
  end
  
  local function read(n)
    if n < 0 then
      error("the argument must be non-negative")
    end
    local pos2 = pos - 1 + n
    local str = sub(json, pos, pos2)
    while pos2 > jsonlen and 0 ~= jsonlen do
      jsonnxt()
      pos2 = pos2 - (jsonlen - (pos - 1))
      str = str .. sub(json, pos, pos2)
    end
    if 0 ~= jsonlen then
      pos = pos2 + 1
    end
    return str
  end
  
  local function tellpos()
    return acc + pos
  end
  
  return {
    run = run,
    tryc = tryc,
    read = read,
    tellpos = tellpos
  }
end

local function newfileparser(fn, saxtbl)
  local fp = open(fn)
  
  local function gen()
    local s
    if fp then
      s = fp:read(8192)
      if not s then
        fp:close()
        fp = nil
      end
    end
    return s
  end
  
  do return newparser, gen end
  return newparser, gen, saxtbl
end

return {newparser = newparser, newfileparser = newfileparser}
