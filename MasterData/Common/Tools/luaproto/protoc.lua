local function meta(name, t)
  t = t or {}
  
  t.__name = name
  t.__index = t
  return t
end

local function default(t, k, def)
  local v = t[k]
  if not v then
    v = def or {}
    t[k] = v
  end
  return v
end

local Lexer = meta("Lexer")
do
  local escape = {
    a = "\a",
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t",
    v = "\v"
  }
  
  local function tohex(x)
    return string.byte(tonumber(x, 16))
  end
  
  local function todec(x)
    return string.byte(tonumber(x, 10))
  end
  
  local function toesc(x)
    return escape[x] or x
  end
  
  function Lexer.new(name, src)
    local self = {
      name = name,
      src = src,
      pos = 1
    }
    return setmetatable(self, Lexer)
  end
  
  function Lexer:__call(patt, pos)
    return self.src:match(patt, pos or self.pos)
  end
  
  function Lexer:test(patt)
    self:whitespace()
    local pos = self("^" .. patt .. "%s*()")
    if not pos then
      return false
    end
    self.pos = pos
    return true
  end
  
  function Lexer:expected(patt, name)
    if not self:test(patt) then
      return self:error((name or "'" .. patt .. "'") .. " expected")
    end
    return self
  end
  
  function Lexer:pos2loc(pos)
    local linenr = 1
    pos = pos or self.pos
    for start, stop in self.src:gmatch([[
()[^
]*()
?]]) do
      if start <= pos and stop >= pos then
        return linenr, pos - start + 1
      end
      linenr = linenr + 1
    end
  end
  
  function Lexer:error(fmt, ...)
    local ln, co = self:pos2loc()
    return error(("%s:%d:%d: " .. fmt):format(self.name, ln, co, ...))
  end
  
  function Lexer:opterror(opt, msg)
    if not opt then
      return self:error(msg)
    end
    return nil
  end
  
  function Lexer:whitespace()
    local pos, c = self("^%s*()(%/?)")
    self.pos = pos
    if c == "" then
      return self
    end
    return self:comment()
  end
  
  function Lexer:comment()
    local pos = self([[
^%/%/[^
]*
?()]])
    if not pos and self("^%/%*") then
      pos = self("^%/%*.-%*%/()")
      if not pos then
        self:error("unfinished comment")
      end
    end
    if not pos then
      return self
    end
    self.pos = pos
    return self:whitespace()
  end
  
  function Lexer:line_end(opt)
    self:whitespace()
    local pos = self("^[%s;]*%s*()")
    if not pos then
      return self:opterror(opt, "';' expected")
    end
    self.pos = pos
    return pos
  end
  
  function Lexer:eof()
    self:whitespace()
    return self.pos > #self.src
  end
  
  function Lexer:keyword(kw, opt)
    self:whitespace()
    local ident, pos = self("^([%a_][%w_]*)%s*()")
    if not ident or ident ~= kw then
      return self:opterror(opt, "''" .. kw .. "\" expected")
    end
    self.pos = pos
    return kw
  end
  
  function Lexer:ident(name, opt)
    self:whitespace()
    local b, ident, pos = self("^()([%a_][%w_]*)%s*()")
    if not ident then
      return self:opterror(opt, (name or "name") .. " expected")
    end
    self.pos = pos
    return ident, b
  end
  
  function Lexer:full_ident(name, opt)
    self:whitespace()
    local b, ident, pos = self("^()([%a_][%w_.]*)%s*()")
    if not ident or ident:match("%.%.+") then
      return self:opterror(opt, (name or "name") .. " expected")
    end
    self.pos = pos
    return ident, b
  end
  
  function Lexer:integer(opt)
    self:whitespace()
    local ns, oct, hex, s, pos = self("^([+-]?)(0?)([xX]?)([0-9a-fA-F]+)%s*()")
    local n
    if oct == "0" and hex == "" then
      n = tonumber(s, 8)
    elseif oct == "" and hex == "" then
      n = tonumber(s, 10)
    elseif oct == "0" and hex ~= "" then
      n = tonumber(s, 16)
    end
    if not n then
      return self:opterror(opt, "integer expected")
    end
    self.pos = pos
    return ns == "-" and -n or n
  end
  
  function Lexer:number(opt)
    self:whitespace()
    if self:test("nan%f[%A]") then
      return 0.0 / 0.0
    elseif self:test("inf%f[%A]") then
      return 1.0 / 0.0
    end
    local ns, d1, s, d2, s2, pos = self("^([+-]?)(%.?)([0-9]+)(%.?)([0-9]*)()")
    if not ns then
      return self:opterror(opt, "floating-point number expected")
    end
    local es, pos2 = self("(^[eE][+-]?[0-9]+)%s*()", pos)
    if d1 == "." and d2 == "." then
      return self:error("malformed floating-point number")
    end
    self.pos = pos2 or pos
    local n = tonumber(d1 .. s .. d2 .. s2 .. (es or ""))
    return ns == "-" and -n or n
  end
  
  function Lexer:quote(opt)
    self:whitespace()
    local q, start = self("^([\"'])()")
    if not start then
      return self:opterror(opt, "string expected")
    end
    self.pos = start
    local patt = "()(\\?" .. q .. ")%s*()"
    while true do
      local stop, s, pos = self(patt)
      if not stop then
        self.pos = start - 1
        return self:error("unfinished string")
      end
      self.pos = pos
      if s == q then
        return self.src:sub(start, stop - 1):gsub("\\x(%x+)", tohex):gsub("\\(%d+)", todec):gsub("\\(.)", toesc)
      end
    end
  end
  
  function Lexer:constant(opt)
    local c = self:full_ident("constant", "opt") or self:number("opt") or self:quote("opt")
    if not c and not opt then
      return self:error("constant expected")
    end
    return c
  end
  
  function Lexer:option_name()
    local ident
    if self:test("%(") then
      ident = self:full_ident("option name")
      self:expected("%)")
    else
      ident = self:ident("option name")
    end
    while self:test("%.") do
      ident = ident .. "." .. self:ident()
    end
    return ident
  end
  
  function Lexer:type_name()
    if self:test("%.") then
      local id, pos = self:full_ident("type name")
      return "." .. id, pos
    else
      return self:full_ident("type name")
    end
  end
end
local Parser = meta("Parser")
Parser.typemap = {}
Parser.loaded = {}
Parser.paths = {"", "."}

function Parser.new()
  local self = {}
  self.typemap = {}
  self.loaded = {}
  self.paths = {"", "."}
  return setmetatable(self, Parser)
end

function Parser:error(msg)
  return self.lex:error(msg)
end

function Parser:addpath(path)
  self.paths[#self.paths + 1] = path
end

function Parser:parsefile(name)
  local info = self.loaded[name]
  if info then
    return info
  end
  local errors = {}
  for _, path in ipairs(self.paths) do
    local fn = path ~= "" and path .. "/" .. name or name
    local fh, err = io.open(fn)
    if fh then
      local content = fh:read("*a")
      info = self:parse(content, name)
      fh:close()
      return info
    end
    errors[#errors + 1] = err or fn .. ": " .. "unknown error"
  end
  if self.import_fallback then
    info = self.import_fallback(name)
  end
  if not info then
    error("module load error: " .. name .. [[

	]] .. table.concat(errors, [[

	]]))
  end
  return info
end

do
  local labels = {
    optional = 1,
    required = 2,
    repeated = 3
  }
  local key_types = {
    int32 = 5,
    int64 = 3,
    uint32 = 13,
    uint64 = 4,
    sint32 = 17,
    sint64 = 18,
    fixed32 = 7,
    fixed64 = 6,
    sfixed32 = 15,
    sfixed64 = 16,
    bool = 8,
    string = 9
  }
  local com_types = {
    group = 10,
    message = 11,
    enum = 14
  }
  local types = {
    double = 1,
    float = 2,
    int32 = 5,
    int64 = 3,
    uint32 = 13,
    uint64 = 4,
    sint32 = 17,
    sint64 = 18,
    fixed32 = 7,
    fixed64 = 6,
    sfixed32 = 15,
    sfixed64 = 16,
    bool = 8,
    string = 9,
    bytes = 12,
    group = 10,
    message = 11,
    enum = 14
  }
  
  local function register_type(self, lex, tname, type)
    if not tname:match("%.") then
      tname = self.prefix .. tname
    end
    if self.typemap[tname] then
      return lex:error("type %s already defined", tname)
    end
    self.typemap[tname] = type
  end
  
  local function type_info(lex, tname)
    local tenum = types[tname]
    if com_types[tname] then
      return lex:error("invalid type name: " .. tname)
    elseif tenum then
      tname = nil
    end
    return tenum, tname
  end
  
  local function map_info(lex)
    local keyt = lex:ident("key type")
    if not key_types[keyt] then
      return lex:error("invalid key type: " .. keyt)
    end
    local valt = lex:expected(","):type_name()
    local name = lex:expected(">"):ident()
    local ident = name:gsub("^%a", string.upper):gsub("_(%a)", string.upper) .. "Entry"
    local kt, ktn = type_info(lex, keyt)
    local vt, vtn = type_info(lex, valt)
    return name, types.message, ident, {
      name = ident,
      field = {
        {
          name = "key",
          number = 1,
          label = labels.optional,
          type = kt,
          type_name = ktn
        },
        {
          name = "value",
          number = 2,
          label = labels.optional,
          type = vt,
          type_name = vtn
        }
      },
      options = {map_entry = true}
    }
  end
  
  local function inline_option(lex, info)
    if lex:test("%[") then
      info = info or {}
      while true do
        local name = lex:option_name()
        local value = lex:expected("="):constant()
        info[name] = value
        if lex:test("%]") then
          return info
        end
        lex:expected(",")
      end
    end
  end
  
  local function field(self, lex, ident)
    local name, type, type_name, map_entry
    if ident == "map" and lex:test("%<") then
      name, type, type_name, map_entry = map_info(lex)
      self.locmap[map_entry.field[1]] = lex.pos
      self.locmap[map_entry.field[2]] = lex.pos
      register_type(self, lex, type_name, types.message)
    else
      type, type_name = type_info(lex, ident)
      name = lex:ident()
    end
    local info = {
      name = name,
      number = lex:expected("="):integer(),
      label = ident == "map" and labels.repeated or labels.optional,
      type = type,
      type_name = type_name
    }
    local options = inline_option(lex)
    if options then
      info.default_value, options.default = tostring(options.default), nil
      info.json_name, options.json_name = options.json_name, nil
      if options.packed and options.packed == "false" then
        options.packed = false
      end
    end
    info.options = options
    if info.number <= 0 then
      lex:error("invalid tag number: " .. info.number)
    end
    return info, map_entry
  end
  
  local function label_field(self, lex, ident)
    local label = labels[ident]
    local info, map_entry
    if not label then
      if self.syntax == "proto2" and ident ~= "map" then
        return lex:error("proto2 disallow missing label")
      end
      return field(self, lex, ident)
    end
    if label == labels.optional and self.syntax == "proto3" then
      return lex:error("proto3 disallow 'optional' label")
    end
    info, map_entry = field(self, lex, lex:type_name())
    info.label = label
    return info, map_entry
  end
  
  local toplevel = {}
  
  function toplevel:package(lex, info)
    local package = lex:full_ident("package name")
    lex:line_end()
    info.package = package
    self.prefix = "." .. package .. "."
    return self
  end
  
  function toplevel:import(lex, info)
    local mode = lex:ident("\"weak\" or \"public\"", "opt") or "public"
    if mode ~= "weak" and mode ~= "public" then
      return lex:error("\"weak or \"public\" expected")
    end
    local name = lex:quote()
    lex:line_end()
    local result = self:parsefile(name)
    if self.on_import then
      self.on_import(result)
    end
    local dep = default(info, "dependency")
    local index = #dep
    dep[index + 1] = name
    if mode == "public" then
      local it = default(info, "public_dependency")
      it[#it + 1] = index
    else
      local it = default(info, "weak_dependency")
      it[#it + 1] = index
    end
  end
  
  do
    local msg_body = {}
    
    function msg_body:message(lex, info)
      local nested_type = default(info, "nested_type")
      nested_type[#nested_type + 1] = toplevel.message(self, lex)
      return self
    end
    
    function msg_body:enum(lex, info)
      local nested_type = default(info, "enum_type")
      nested_type[#nested_type + 1] = toplevel.enum(self, lex)
      return self
    end
    
    function msg_body:extend(lex, info)
      local extension = default(info, "extension")
      local nested_type = default(info, "nested_type")
      local ft, mt = toplevel.extend(self, lex, {})
      for _, v in ipairs(ft) do
        extension[#extension + 1] = v
      end
      for _, v in ipairs(mt) do
        nested_type[#nested_type + 1] = v
      end
      return self
    end
    
    function msg_body:extensions(lex, info)
      local rt = default(info, "extension_range")
      repeat
        local start = lex:integer("field number range")
        local stop = math.floor(5.36870912E8)
        lex:keyword("to")
        if not lex:keyword("max", "opt") then
          stop = lex:integer("field number range end or 'max'")
        end
        rt[#rt + 1] = {
          start = start,
          ["end"] = stop
        }
      until not lex:test(",")
      lex:line_end()
      return self
    end
    
    function msg_body:reserved(lex, info)
      if lex:test("%a") then
        local rt = default(info, "reserved_name")
        repeat
          rt[#rt + 1] = lex:ident("field name")
        until not lex:test(",")
      else
        local rt = default(info, "reserved_range")
        local first = true
        repeat
          local start = lex:integer(first and "field name or number range" or "field number range")
          if lex:keyword("to", "opt") then
            local stop = lex:integer("field number range end")
            rt[#rt + 1] = {
              start = start,
              ["end"] = stop
            }
          else
            rt[#rt + 1] = {
              start = start,
              ["end"] = start
            }
          end
          first = false
        until not lex:test(",")
      end
      lex:line_end()
      return self
    end
    
    function msg_body:oneof(lex, info)
      local fs = default(info, "field")
      local ts = default(info, "nested_type")
      local ot = default(info, "oneof_decl")
      local index = #ot + 1
      local oneof = {
        name = lex:ident()
      }
      lex:expected("{")
      while not lex:test("}") do
        local ident = lex:type_name()
        if ident == "option" then
          toplevel.option(self, lex, oneof)
        else
          local f, t = field(self, lex, ident, "no_label")
          self.locmap[f] = lex.pos
          if t then
            ts[#ts + 1] = t
          end
          f.oneof_index = index - 1
          fs[#fs + 1] = f
        end
        lex:line_end("opt")
      end
      ot[index] = oneof
    end
    
    function toplevel:message(lex, info)
      local name = lex:ident("message name")
      local type = {name = name}
      register_type(self, lex, name, types.message)
      local prefix = self.prefix
      self.prefix = prefix .. name .. "."
      lex:expected("{")
      while not lex:test("}") do
        local ident, pos = lex:type_name()
        local body_parser = msg_body[ident]
        if body_parser then
          body_parser(self, lex, type)
        else
          local fs = default(type, "field")
          local f, t = label_field(self, lex, ident)
          self.locmap[f] = pos
          fs[#fs + 1] = f
          if t then
            local ts = default(type, "nested_type")
            ts[#ts + 1] = t
          end
        end
        lex:line_end("opt")
      end
      lex:line_end("opt")
      if info then
        info = default(info, "message_type")
        info[#info + 1] = type
      end
      self.prefix = prefix
      return type
    end
    
    function toplevel:enum(lex, info)
      local name = lex:ident("enum name")
      local enum = {name = name}
      register_type(self, lex, name, types.enum)
      lex:expected("{")
      while not lex:test("}") do
        local ident = lex:ident("enum constant name")
        if ident == "option" then
          toplevel.option(self, lex, default(enum, "options"))
        else
          local values = default(enum, "value")
          local number = lex:expected("="):integer()
          lex:line_end()
          values[#values + 1] = {
            name = ident,
            number = number,
            options = inline_option(lex)
          }
        end
        lex:line_end("opt")
      end
      lex:line_end("opt")
      if info then
        info = default(info, "enum_type")
        info[#info + 1] = enum
      end
      return enum
    end
    
    function toplevel:option(lex, info)
      local ident = lex:option_name()
      lex:expected("=")
      local value = lex:constant()
      lex:line_end()
      local options = info and default(info, "options") or {}
      options[ident] = value
      return options, self
    end
    
    function toplevel:extend(lex, info)
      local name = lex:type_name()
      local ft = info and default(info, "extension") or {}
      local mt = info and default(info, "message_type") or {}
      lex:expected("{")
      while not lex:test("}") do
        local ident, pos = lex:type_name()
        local f, t = label_field(self, lex, ident)
        self.locmap[f] = pos
        f.extendee = name
        ft[#ft + 1] = f
        mt[#mt + 1] = t
        lex:line_end("opt")
      end
      return ft, mt
    end
    
    local svr_body = {}
    
    function svr_body:rpc(lex, info)
      local name, pos = lex:ident("rpc name")
      local rpc = {name = name}
      self.locmap[rpc] = pos
      local _, tn
      lex:expected("%(")
      rpc.client_stream = lex:keyword("stream", "opt")
      _, tn = type_info(lex, lex:type_name())
      if not tn then
        return lex:error("rpc input type must by message")
      end
      rpc.input_type = tn
      lex:expected("%)"):expected("returns"):expected("%(")
      rpc.server_stream = lex:keyword("stream", "opt")
      _, tn = type_info(lex, lex:type_name())
      if not tn then
        return lex:error("rpc output type must by message")
      end
      rpc.output_type = tn
      lex:expected("%)")
      if lex:test("{") then
        while not lex:test("}") do
          lex:line_end("opt")
          lex:keyword("option")
          toplevel.option(self, lex, default(rpc, "options"))
        end
      end
      lex:line_end("opt")
      local t = default(info, "method")
      t[#t + 1] = rpc
    end
    
    function svr_body.stream(_, lex)
      lex:error("stream not implement yet")
    end
    
    function toplevel:service(lex, info)
      local name = lex:ident("service name")
      local svr = {name = name}
      lex:expected("{")
      while not lex:test("}") do
        local ident = lex:type_name()
        local body_parser = svr_body[ident]
        if body_parser then
          body_parser(self, lex, svr)
        else
          return lex:error("expected 'rpc' or 'option' in service body")
        end
        lex:line_end("opt")
      end
      lex:line_end("opt")
      if info then
        info = default(info, "service")
        info[#info + 1] = svr
      end
      return svr
    end
  end
  
  local function make_context(self, lex)
    local ctx = {
      syntax = "proto2",
      locmap = {},
      prefix = ".",
      lex = lex,
      parser = self
    }
    ctx.loaded = self.loaded
    ctx.typemap = self.typemap
    ctx.paths = self.paths
    
    function ctx.import_fallback(import_name)
      if self.unknown_import == true then
        return true
      elseif type(self.unknown_import) == "string" then
        return import_name:match(self.unknown_import) and true or nil
      elseif self.unknown_import then
        return self:unknown_import(import_name)
      end
    end
    
    function ctx.type_fallback(type_name)
      if self.unknown_type == true then
        return true
      elseif type(self.unknown_type) == "string" then
        return type_name:match(self.unknown_type) and true
      elseif self.unknown_type then
        return self:unknown_type(type_name)
      end
    end
    
    function ctx.on_import(info)
      if self.on_import then
        return self.on_import(info)
      end
    end
    
    return setmetatable(ctx, Parser)
  end
  
  function Parser:parse(src, name)
    local loaded = self.loaded[name]
    if loaded then
      if loaded == true then
        error("loop loaded: " .. name)
      end
      return loaded
    end
    name = name or "<input>"
    self.loaded[name] = true
    local lex = Lexer.new(name, src)
    local info = {
      name = lex.name
    }
    local ctx = make_context(self, lex)
    local syntax = lex:keyword("syntax", "opt")
    if syntax then
      info.syntax = lex:expected("="):quote()
      ctx.syntax = info.syntax
      lex:line_end()
    end
    while not lex:eof() do
      local ident = lex:ident()
      local top_parser = toplevel[ident]
      if top_parser then
        top_parser(ctx, lex, info)
      else
        lex:error("unknown keyword '" .. ident .. "'")
      end
      lex:line_end("opt")
    end
    self.loaded[name] = name ~= "<input>" and info or nil
    return ctx:resolve(lex, info)
  end
  
  local function empty()
  end
  
  local function iter(t, k)
    local v = t[k]
    if v then
      return ipairs(v)
    end
    return empty
  end
  
  local function check_dup(self, lex, type, map, k, v)
    local old = map[v[k]]
    if old then
      local ln, co = lex:pos2loc(self.locmap[old])
      lex:error("%s '%s' exists, previous at %d:%d", type, v[k], ln, co)
    end
    map[v[k]] = v
  end
  
  local function check_type(self, lex, tname)
    if tname:match("^%.") then
      local t = self.typemap[tname]
      if not t then
        return lex:error("unknown type '%s'", tname)
      end
      return t, tname
    end
    local prefix = self.prefix
    for i = #prefix + 1, 1, -1 do
      local op = prefix[i]
      prefix[i] = tname
      local tn = table.concat(prefix, ".", 1, i)
      prefix[i] = op
      local t = self.typemap[tn]
      if t then
        return t, tn
      end
    end
    local tn, t
    if self.type_fallback then
      tn, t = self.type_fallback(tname)
    end
    if tn then
      t = types[t or "message"]
      if tn == true then
        tn = "." .. tname
      end
      return t, tn
    end
    return lex:error("unknown type '%s'", tname)
  end
  
  local function check_field(self, lex, info)
    if info.extendee then
      local t, tn = check_type(self, lex, info.extendee)
      if t ~= types.message then
        lex:error("message type expected in extension")
      end
      info.extendee = tn
    end
    if info.type_name then
      local t, tn = check_type(self, lex, info.type_name)
      info.type = t
      info.type_name = tn
    end
  end
  
  local function check_enum(self, lex, info)
    local names, numbers = {}, {}
    for _, v in iter(info, "value") do
      lex.pos = self.locmap[v]
      check_dup(self, lex, "enum name", names, "name", v)
      if not (info.options and info.options.options) or not info.options.options.allow_alias then
        check_dup(self, lex, "enum number", numbers, "number", v)
      end
    end
  end
  
  local function check_message(self, lex, info)
    self.prefix[#self.prefix + 1] = info.name
    local names, numbers = {}, {}
    for _, v in iter(info, "field") do
      lex.pos = assert(self.locmap[v])
      check_dup(self, lex, "field name", names, "name", v)
      check_dup(self, lex, "field number", numbers, "number", v)
      check_field(self, lex, v)
    end
    for _, v in iter(info, "nested_type") do
      check_message(self, lex, v)
    end
    for _, v in iter(info, "extension") do
      lex.pos = assert(self.locmap[v])
      check_field(self, lex, v)
    end
    self.prefix[#self.prefix] = nil
  end
  
  local function check_service(self, lex, info)
    local names = {}
    for _, v in iter(info, "method") do
      lex.pos = self.locmap[v]
      check_dup(self, lex, "rpc name", names, "name", v)
      local t, tn = check_type(self, lex, v.input_type)
      v.input_type = tn
      if t ~= types.message then
        lex:error("message type expected in parameter")
      end
      t, tn = check_type(self, lex, v.output_type)
      v.output_type = tn
      if t ~= types.message then
        lex:error("message type expected in return")
      end
    end
  end
  
  function Parser:resolve(lex, info)
    self.prefix = {
      "",
      info.package
    }
    for _, v in iter(info, "message_type") do
      check_message(self, lex, v)
    end
    for _, v in iter(info, "enum_type") do
      check_enum(self, lex, v)
    end
    for _, v in iter(info, "service") do
      check_service(self, lex, v)
    end
    for _, v in iter(info, "extension") do
      lex.pos = assert(self.locmap[v])
      check_field(self, lex, v)
    end
    self.prefix = nil
    return info
  end
end
local has_pb, pb = pcall(require, "pb")
if has_pb then
  local descriptor_pb = "\n˘#\n\016descriptor.proto\018\015google.protobuf\"G\n\017FileDescript" .. "orSet\0182\n\004file\024\001 \003(\v2$.google.protobuf.FileDescriptorProto\"" .. "€\003\n\019FileDescriptorProto\018\f\n\004name\024\001 \001(\t\018\015\n\apack" .. "age\024\002 \001(\t\018\018\n\ndependency\024\003 \003(\t\018\025\n\017public_depend" .. "ency\024\n \003(\005\018\023\n\015weak_dependency\024\v \003(\005\0186\n\fmessag" .. "e_type\024\004 \003(\v2 .google.protobuf.DescriptorProto\0187\n\tenum_type" .. "\024\005 \003(\v2$.google.protobuf.EnumDescriptorProto\0188\n\aservice\024" .. "\006 \003(\v2'.google.protobuf.ServiceDescriptorProto\0188\n\textension" .. "\024\a \003(\v2%.google.protobuf.FieldDescriptorProto\018-\n\aoptions\024" .. "\b \001(\v2\028.google.protobuf.FileOptions\0189\n\016source_code_info\024" .. "\t \001(\v2\031.google.protobuf.SourceCodeInfo\018\014\n\006syntax\024\f \001(" .. "\t\"‰\003\n\015DescriptorProto\018\f\n\004name\024\001 \001(\t\0184\n\005field" .. "\024\002 \003(\v2%.google.protobuf.FieldDescriptorProto\0188\n\textension" .. "\024\006 \003(\v2%.google.protobuf.FieldDescriptorProto\0185\n\vnested_ty" .. "pe\024\003 \003(\v2 .google.protobuf.DescriptorProto\0187\n\tenum_type\024" .. "\004 \003(\v2$.google.protobuf.EnumDescriptorProto\018H\n\015extension_rang" .. "e\024\005 \003(\v2/.google.protobuf.DescriptorProto.ExtensionRange\0189\n" .. "\noneof_decl\024\b \003(\v2%.google.protobuf.OneofDescriptorProto\0180" .. "\n\aoptions\024\a \001(\v2\031.google.protobuf.MessageOptions\026,\n\014Ex" .. "tensionRange\018\r\n\005start\024\001 \001(\005\018\v\n\003end\024\002 \001(\005\"©\005" .. "\n\020FieldDescriptorProto\018\f\n\004name\024\001 \001(\t\018\014\n\006number\024" .. "\003 \001(\005\018:\n\005label\024\004 \001(\0142+.google.protobuf.FieldDescriptorPro" .. "to.Label\0188\n\004type\024\005 \001(\0142*.google.protobuf.FieldDescriptorPro" .. "to.Type\018\017\n\ttype_name\024\006 \001(\t\018\016\n\bextendee\024\002 \001(\t\018" .. "\021\n\rdefault_value\024\a \001(\t\018\019\n\voneof_index\024\t \001(\005\018." .. "\n\aoptions\024\b \001(\v2\029.google.protobuf.FieldOptions\"∂\002\n\004T" .. "ype\018\015\n\vTYPE_DOUBLE\016\001\018\014\n\nTYPE_FLOAT\016\002\018\014\n\nTY" .. "PE_INT64\016\003\018\015\n\vTYPE_UINT64\016\004\018\014\n\nTYPE_INT32\016\005\018" .. "\016\n\fTYPE_FIXED64\016\006\018\016\n\fTYPE_FIXED32\016\a\018\r\n\tTYPE_B" .. "OOL\016\b\018\015\n\vTYPE_STRING\016\t\018\014\n\nTYPE_GROUP\016\n\018\016" .. "\n\fTYPE_MESSAGE\016\v\018\014\n\nTYPE_BYTES\016\f\018\015\n\vTYPE_UIN" .. "T32\016\r\018\r\n\tTYPE_ENUM\016\014\018\017\n\rTYPE_SFIXED32\016\015\018\017" .. "\n\rTYPE_SFIXED64\016\016\018\015\n\vTYPE_SINT32\016\017\018\015\n\vTYPE_S" .. "INT64\016\018\"C\n\005Label\018\018\n\014LABEL_OPTIONAL\016\001\018\018\n\014LABEL" .. "_REQUIRED\016\002\018\018\n\014LABEL_REPEATED\016\003\"$\n\020OneofDescriptorPro" .. "to\018\f\n\004name\024\001 \001(\t\"å\001\n\019EnumDescriptorProto\018\f\n\004" .. "name\024\001 \001(\t\0188\n\005value\024\002 \003(\v2).google.protobuf.EnumValueD" .. "escriptorProto\018-\n\aoptions\024\003 \001(\v2\028.google.protobuf.EnumOpti" .. "ons\"l\n\024EnumValueDescriptorProto\018\f\n\004name\024\001 \001(\t\018\014\n" .. "\006number\024\002 \001(\005\0182\n\aoptions\024\003 \001(\v2!.google.protobuf.Enum" .. "ValueOptions\"ê\001\n\022ServiceDescriptorProto\018\f\n\004name\024\001 \001(" .. "\t\0186\n\006method\024\002 \003(\v2&.google.protobuf.MethodDescriptorProto" .. "\0180\n\aoptions\024\003 \001(\v2\031.google.protobuf.ServiceOptions\"¡" .. "\001\n\021MethodDescriptorProto\018\f\n\004name\024\001 \001(\t\018\018\n\ninput" .. "_type\024\002 \001(\t\018\019\n\voutput_type\024\003 \001(\t\018/\n\aoptions\024\004 " .. "\001(\v2\030.google.protobuf.MethodOptions\018\031\n\016client_streaming\024" .. "\005 \001(\b:\005false\018\031\n\016server_streaming\024\006 \001(\b:\005false\"Á\004" .. "\n\vFileOptions\018\020\n\fjava_package\024\001 \001(\t\018\028\n\020java_out" .. "er_classname\024\b \001(\t\018\"\n\019java_multiple_files\024\n \001(\b:\005fals" .. "e\018,\n\029java_generate_equals_and_hash\024\020 \001(\b:\005false\018%\n\022ja" .. "va_string_check_utf8\024\027 \001(\b:\005false\018F\n\foptimize_for\024\t \001(" .. "\0142).google.protobuf.FileOptions.OptimizeMode:\005SPEED\018\018\n\ngo_pa" .. "ckage\024\v \001(\t\018\"\n\019cc_generic_services\024\016 \001(\b:\005false\018$" .. "\n\021java_generic_services\024\017 \001(\b:\005false\018\"\n\019py_generic_ser" .. "vices\024\018 \001(\b:\005false\018\025\n\ndeprecated\024\023 \001(\b:\005false\018" .. "\031\n\016cc_enable_arenas\024\031 \001(\b:\005false\018\025\n\017objc_class_pref" .. "ix\024$ \001(\t\018C\n\020uninterpreted_option\024Á\a \003(\v2$.google.pro" .. "tobuf.UninterpretedOption\":\n\fOptimizeMode\018\t\n\005SPEED\016\001\018\r" .. "\n\tCODE_SIZE\016\002\018\016\n\fLITE_RUNTIME\016\003*\t\bË\a\016ÄÄ" .. "ÄÄ\002\"Ê\001\n\014MessageOptions\018&\n\023message_set_wire_format" .. "\024\001 \001(\b:\005false\018.\n\031no_standard_descriptor_accessor\024\002 \001(\b:" .. "\005false\018\025\n\ndeprecated\024\003 \001(\b:\005false\018\017\n\tmap_entry\024" .. "\a \001(\b\018C\n\020uninterpreted_option\024Á\a \003(\v2$.google.protobu" .. "f.UninterpretedOption*\t\bË\a\016ÄÄÄÄ\002\"†\002\n\fField" .. "Options\018:\n\005ctype\024\001 \001(\0142#.google.protobuf.FieldOptions.CType:" .. "\006STRING\018\014\n\006packed\024\002 \001(\b\018\019\n\004lazy\024\005 \001(\b:\005false" .. "\018\025\n\ndeprecated\024\003 \001(\b:\005false\018\019\n\004weak\024\n \001(\b:\005f" .. "alse\018C\n\020uninterpreted_option\024Á\a \003(\v2$.google.protobuf.Un" .. "interpretedOption\"/\n\005CType\018\n\n\006STRING\016\000\018\b\n\004CORD\016\001" .. "\018\016\n\fSTRING_PIECE\016\002*\t\bË\a\016ÄÄÄÄ\002\"ç\001\n" .. "\vEnumOptions\018\019\n\vallow_alias\024\002 \001(\b\018\025\n\ndeprecated" .. "\024\003 \001(\b:\005false\018C\n\020uninterpreted_option\024Á\a \003(\v2$.goo" .. "gle.protobuf.UninterpretedOption*\t\bË\a\016ÄÄÄÄ\002\"}\n" .. "\016EnumValueOptions\018\025\n\ndeprecated\024\001 \001(\b:\005false\018C\n\020un" .. "interpreted_option\024Á\a \003(\v2$.google.protobuf.UninterpretedOptio" .. "n*\t\bË\a\016ÄÄÄÄ\002\"{\n\014ServiceOptions\018\025\n\ndepr" .. "ecated\024! \001(\b:\005false\018C\n\020uninterpreted_option\024Á\a \003(\v2" .. "$.google.protobuf.UninterpretedOption*\t\bË\a\016ÄÄÄÄ\002\"z" .. "\n\rMethodOptions\018\025\n\ndeprecated\024! \001(\b:\005false\018C\n\020uni" .. "nterpreted_option\024Á\a \003(\v2$.google.protobuf.UninterpretedOption" .. "*\t\bË\a\016ÄÄÄÄ\002\"û\002\n\019UninterpretedOption\018;\n" .. "\004name\024\002 \003(\v2-.google.protobuf.UninterpretedOption.NamePart\018\024" .. "\n\016identifier_value\024\003 \001(\t\018\026\n\018positive_int_value\024\004 \001(" .. "\004\018\026\n\018negative_int_value\024\005 \001(\003\018\020\n\fdouble_value\024\006" .. " \001(\001\018\020\n\fstring_value\024\a \001(\f\018\023\n\015aggregate_value" .. "\024\b \001(\t\0263\n\bNamePart\018\017\n\tname_part\024\001 \002(\t\018\020\n\f" .. "is_extension\024\002 \002(\b\"’\001\n\014SourceCodeInfo\018:\n\blocation\024" .. "\001 \003(\v2(.google.protobuf.SourceCodeInfo.Location\026Ü\001\n\bLocati" .. "on\018\016\n\004path\024\001 \003(\005B\002\016\001\018\016\n\004span\024\002 \003(\005B\002\016\001" .. "\018\024\n\016leading_comments\024\003 \001(\t\018\025\n\017trailing_comments\024" .. "\004 \001(\t\018!\n\025leading_detached_comments\024\006 \003(\tB)\n\019com.google" .. ".protobufB\016DescriptorProtosH\001"
  
  function Parser.reload()
    assert(pb.load(descriptor_pb))
  end
  
  local function do_compile(self, f, ...)
    if self.include_imports then
      local old = self.on_import
      local infos = {}
      
      function self.on_import(info)
        infos[#infos + 1] = info
      end
      
      local r = f(...)
      infos[#infos + 1] = r
      self.on_import = old
      return {file = infos}
    end
    return {
      file = {
        f(...)
      }
    }
  end
  
  function Parser:compile(s, name)
    local set = do_compile(self, self.parse, self, s, name)
    return pb.encode(".google.protobuf.FileDescriptorSet", set)
  end
  
  function Parser:compilefile(fn)
    local set = do_compile(self, self.parsefile, self, fn)
    return pb.encode(".google.protobuf.FileDescriptorSet", set)
  end
  
  function Parser:load(s, name)
    local ret, pos = pb.load(self:compile(s, name))
    if ret then
      return ret, pos
    end
    error("load failed at offset " .. pos)
  end
  
  function Parser:loadfile(fn)
    local ret, pos = pb.load(self:compilefile(fn))
    if ret then
      return ret, pos
    end
    error("load failed at offset " .. pos)
  end
  
  Parser.reload()
end
return Parser
