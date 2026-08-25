local __DISTILLER
if nil == __DISTILLER then
  __DISTILLER = nil
  __DISTILLER = {
    FACTORIES = {},
    __nativeRequire = require,
    require = function(id)
      assert(type(id) == "string", "require invalid id:" .. tostring(id))
      if package.loaded[id] then
        return package.loaded[id]
      end
      if __DISTILLER.FACTORIES[id] then
        local func = __DISTILLER.FACTORIES[id]
        package.loaded[id] = func(__DISTILLER.require) or true
        return package.loaded[id]
      end
      do return __DISTILLER.__nativeRequire end
      return __DISTILLER.__nativeRequire, id, func(__DISTILLER.require) or true, __DISTILLER.require, id
    end,
    define = function(self, id, factory)
      assert(type(id) == "string", "invalid id:" .. tostring(id))
      assert(type(factory) == "function", "invalid factory:" .. tostring(factory))
      if package.loaded[id] == nil and nil == self.FACTORIES[id] then
        self.FACTORIES[id] = factory
      else
        print("[__DISTILLER::define] module " .. tostring(id) .. " is already defined")
      end
    end,
    exec = function(self, id)
      local func = self.FACTORIES[id]
      assert(func, "missing factory method for id " .. tostring(id))
      func(__DISTILLER.require)
    end
  }
end
__DISTILLER:define("LuaBoomer.LocalModule.FileViewManager.M6FileViewImpl", function(require)
  local M = {}
  
  local function getFileList(file_list, dir, filters)
    for i, filter in ipairs(filters) do
      local files = global.GetFileListFromDirectory(dir, filter, true)
      for j, file in ipairs(files) do
        table.insert(file_list, file)
      end
    end
  end
  
  function M.getFileList()
    local save_dir = global.ProjectSavedDir()
    local logs_dir = save_dir .. "Logs"
    local crashes_dir = save_dir .. "Crashes"
    local download_dir = global.ProjectPersistentDownloadDir()
    local file_list = {}
    getFileList(file_list, logs_dir, {"log", "txt"})
    getFileList(file_list, crashes_dir, {
      "log",
      "runtime-xml",
      "dmp"
    })
    getFileList(file_list, download_dir, {
      "pak",
      "lua",
      "json"
    })
    return file_list
  end
  
  function M.getFile(filePath)
    local file_handler = io.open(filePath, "rb")
    do return file_handler.read, file_handler end
    return file_handler.read, file_handler, "*a"
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.NetworkModule.SocketBase", function(require)
  local socket, fd
  local M = {}
  
  function M.createSocket()
    local sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0)
    if sock then
      sock:setblocking(false)
      return {
        connect = function(ip, port)
          local code = sock:connect(ip, port)
          return code
        end,
        is_connect_ready = function()
          if not sock then
            return false
          end
          do return sock.check_async_connect end
          return sock.check_async_connect, sock
        end,
        send = function(data)
          local n, err = sock:send(data)
          if err then
            print("socket send failed, err code is : " .. err)
            return false
          end
          return true
        end,
        recv = function(len)
          local data, err = sock:recv(len)
          if err then
            return nil
          end
          return data
        end,
        close = function()
          sock:close()
          sock = nil
        end
      }
    end
    return nil
  end
  
  function M.isReady()
    return nil ~= fd
  end
  
  function M.initSocket()
    if not socket then
      socket = require("socket.c")
    end
    fd = socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0)
    if fd then
      fd:setblocking(false)
    end
    return fd
  end
  
  function M.is_connect_ready()
    if nil ~= fd then
      do return fd.check_async_connect end
      return fd.check_async_connect, fd
    end
    return nil
  end
  
  function M.connect(ip, port)
    local code = fd:connect(ip, port)
    return code
  end
  
  function M.getLocalPort()
    if fd then
      local host, port = fd:getsockname()
      return port
    end
  end
  
  function M.close()
    if fd then
      fd:close()
      fd = nil
    end
  end
  
  function M.recv(len)
    if not fd then
      return nil
    end
    local data, err = fd:recv(len)
    if err then
      return nil
    end
    return data
  end
  
  function M.send(data)
    if not fd then
      return false
    end
    local n, err = fd:send(data)
    if err then
      print("socket send failed, err code is : " .. err)
      return false
    end
    return true
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.NetworkModule.SocketLevent", function(require)
  local socket, sel, fd
  local is_conn = false
  local M = {}
  
  function M.isReady()
    return nil ~= fd
  end
  
  function M.is_connect_ready()
    if nil ~= fd then
      return is_conn
    end
    return nil
  end
  
  function M.initSocket()
    if not socket then
      socket = require("levent.socket")
      sel = require("levent.select")
    end
    fd = socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0)
    if fd then
      fd:setblocking(false)
    end
    return fd
  end
  
  function M.isConnect()
    return nil ~= fd
  end
  
  function M.socket()
    fd, errcode = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print("init levent socket", errcode)
    if fd then
      fd:setblocking(false)
    end
    return fd
  end
  
  function M.connect(ip, port)
    local code = fd:connect(ip, port)
    if nil ~= code then
      is_conn = true
    end
    return code
  end
  
  function M.getLocalPort()
    if fd then
      local host, port = fd:getsockname()
      return port
    end
  end
  
  function M.close()
    if fd then
      fd:close()
      fd = nil
      is_conn = false
    end
  end
  
  function M.recv(len)
    if not fd then
      return nil
    end
    local data = fd:recv(len)
    return data
  end
  
  function M.send(data)
    if not fd then
      return nil
    end
    do return fd.send, fd end
    return fd.send, fd, data
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.NetworkModule.SocketM1", function(require)
  local socket, Lib, fd
  local M = {}
  
  function M.isReady()
    return nil ~= fd
  end
  
  function M.is_connect_ready()
    if nil ~= fd then
      do return fd.check_async_connect end
      return fd.check_async_connect, fd
    end
    return nil
  end
  
  function M.initSocket()
    if not socket then
      socket = require("socket.c")
      Lib = require("lib.c")
    end
    fd = socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0)
    if fd then
      fd:setblocking(false)
    end
    return fd
  end
  
  function M.isConnect()
    return nil ~= fd
  end
  
  function M.socket()
    fd = socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0)
    if fd then
      fd:setblocking(false)
    end
    return fd
  end
  
  function M.connect(ip, port)
    local code = fd:connect(ip, port)
    return code
  end
  
  function M.getLocalPort()
    if fd then
      local host, port = fd:getsockname()
      return port
    end
  end
  
  function M.close()
    if fd then
      fd:close()
      fd = nil
    end
  end
  
  function M.recv(len)
    if not fd then
      return nil
    end
    local recv_buf = Lib.alloc(len)
    local buf_len, err = fd:recv(recv_buf, len)
    if not buf_len then
      return nil
    end
    if 0 == buf_len then
      return nil
    end
    local data = Lib.ltostring(recv_buf, buf_len)
    Lib.free(recv_buf)
    return data
  end
  
  function M.send(data)
    if not fd then
      return nil
    end
    do return fd.send, fd end
    return fd.send, fd, data
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.Util.Logger", function(require)
  local M = {}
  local log_levels = {
    debug = 1,
    info = 2,
    warn = 3,
    error = 4
  }
  local target_log_level = 99
  
  function M.setLogLevel(level)
    target_log_level = level
  end
  
  function M.loggerBase(logger_level, ...)
    local index = log_levels[logger_level]
    if index >= target_log_level then
      local header = "[" .. logger_level .. "] LuaBoomerLogger: "
      print(header, ...)
    end
  end
  
  function M.debug(...)
    M.loggerBase("debug", ...)
  end
  
  function M.info(...)
    M.loggerBase("info", ...)
  end
  
  function M.warn(...)
    M.loggerBase("warn", ...)
  end
  
  function M.error(...)
    M.loggerBase("error", ...)
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.NetworkModule.SocketXlua", function(require)
  local logger = require("LuaBoomer.Util.Logger")
  local socket, sock
  local M = {}
  local connect_code
  
  function M.isReady()
    return nil ~= socket
  end
  
  function M.initSocket()
    if not socket then
      socket = require("socket")
    end
    return socket
  end
  
  function M.is_connect_ready()
    return nil ~= sock and 1 == connect_code
  end
  
  function M.connect(ip, port)
    if 0 == connect_code then
      logger.info("Luaboomer SocketXLua waiting connection, connect_code: ", connect_code)
      return 1
    end
    sock = socket.tcp()
    sock:settimeout(0)
    local status, error = sock:connect(ip, port)
    logger.info("Luaboomer SocketXLua nonblocking connect...: ", status, error)
    connect_code = 0
    if nil == sock then
      connect_code = nil
      return 0
    else
      sock:settimeout(0)
      return 1
    end
  end
  
  local SELECT_MAX_TRIES = 10
  local selectCount = 0
  
  function M.selectSocket()
    local n, m, error = socket.select({sock}, {sock}, 0)
    local select_code = #n + #m
    if select_code > 0 then
      logger.info("Luaboomer SocketXLua connect successfully")
      connect_code = 1
    end
    if nil ~= error then
      selectCount = selectCount + 1
      if selectCount > SELECT_MAX_TRIES then
        logger.info("Luaboomer SocketXLua connect failed")
        connect_code = 2
        selectCount = 0
      end
    end
  end
  
  function M.getLocalPort()
    local peerLocalInfo = 111
    if nil ~= sock then
      peerLocalInfo = sock:getsockname()
    end
    return peerLocalInfo
  end
  
  function M.close()
    if not sock then
      return nil
    end
    sock:close()
    sock = nil
    connect_code = nil
  end
  
  function M.recv(len)
    if not sock then
      return nil
    end
    local data = sock:receive(len)
    return data
  end
  
  function M.send(data)
    if not sock then
      return nil
    end
    do return sock.send, sock end
    return sock.send, sock, data
  end
  
  function M.update(delta_time)
    if nil ~= sock and 1 ~= connect_code then
      M.selectSocket()
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.NetworkModule.SocketS3", function(require)
  local socket, fd
  local M = {}
  
  function M.isReady()
    return nil ~= fd
  end
  
  function M.initSocket()
    if not socket then
      socket = require("ejoy2dx.socket.c")
    end
    fd = socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0)
    if fd then
      fd:setblocking(false)
    end
    return fd
  end
  
  function M.is_connect_ready()
    if nil ~= fd then
      do return fd.check_async_connect end
      return fd.check_async_connect, fd
    end
    return nil
  end
  
  function M.connect(ip, port)
    local code = fd:connect(ip, port)
    return code
  end
  
  function M.getLocalPort()
    if fd then
      local host, port = fd:getsockname()
      return port
    end
  end
  
  function M.close()
    if fd then
      fd:close()
      fd = nil
    end
  end
  
  function M.recv(len)
    if not fd then
      return nil
    end
    local data = fd:recv(len)
    return data
  end
  
  function M.send(data)
    if not fd then
      return nil
    end
    do return fd.send, fd end
    return fd.send, fd, data
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.NetworkModule.SocketUnityCs", function(require)
  local cs_net
  local connect_ready = false
  local M = {}
  local is_init = false
  
  function M.setImpl(impl)
    cs_net = impl
  end
  
  function M.getImpl()
    return cs_net
  end
  
  function M.isReady()
    return is_init and cs_net
  end
  
  function M.is_connect_ready()
    do return end
    return cs_net.IsConnectReady, nil
  end
  
  function M.initSocket()
    is_init = true
    cs_net.Init()
    return is_init
  end
  
  function M.connect(ip, port)
    local code = cs_net.Connect(ip, port)
    connect_ready = 1 == code
    return code
  end
  
  function M.getLocalPort()
    do return end
    return cs_net.GetLocalPort, nil
  end
  
  function M.close()
    is_init = false
    cs_net.Close()
  end
  
  function M.recv(len)
    do return cs_net.Recv end
    return cs_net.Recv, len
  end
  
  function M.send(data)
    do return cs_net.Send end
    return cs_net.Send, data
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.NetworkModule.SocketK1", function(require)
  local super = require("LuaBoomer.NetworkModule.SocketUnityCs")
  super.setImpl(XS.LuaBoomerNet)
  local cs_net = super.getImpl()
  local orginConnect = super.connect
  
  function super.recv(len)
    local data = cs_net.Recv(len)
    if data then
      do return Slua.ToString end
      return Slua.ToString, data
    end
    return nil
  end
  
  function super.send(data)
    do return cs_net.Send, Slua.ToBytes(data) end
    return cs_net.Send, Slua.ToBytes(data)
  end
  
  function super.connect(ip, port)
    do return orginConnect, ip, tonumber(port) end
    return orginConnect, ip, tonumber(port)
  end
  
  return super
end)
__DISTILLER:define("LuaBoomer.NetworkModule.SocketRL1", function(require)
  local socket, fd
  local M = {}
  
  function M.isReady()
    return nil ~= fd
  end
  
  function M.initSocket()
    if not socket then
      socket = require("socket.c")
    end
    fd = socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0)
    if fd then
      fd:setblocking(false)
    end
    return fd
  end
  
  function M.is_connect_ready()
    if nil ~= fd then
      return true
    end
    return nil
  end
  
  function M.connect(ip, port)
    local code = fd:connect(ip, port)
    return code
  end
  
  function M.getLocalPort()
    if fd then
      local host, port = fd:getsockname()
      return port
    end
  end
  
  function M.close()
    if fd then
      fd:close()
      fd = nil
    end
  end
  
  function M.recv(len)
    if not fd then
      return nil
    end
    local data, err = fd:recv(len)
    if err then
      return nil
    end
    return data
  end
  
  function M.send(data)
    if not fd then
      return false
    end
    local n, err = fd:send(data)
    if err then
      print("socket send failed, err code is : " .. err)
      return false
    end
    return true
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.Util.StringUtil", function(require)
  local StringUtil = {}
  
  function StringUtil.startWiths(str, match)
    return string.sub(str, 1, string.len(match)) == match
  end
  
  function StringUtil.endWiths(str, subStr)
    if nil == str or nil == subStr then
      return nil
    end
    local str_tmp = string.reverse(str)
    local subStr_tmp = string.reverse(subStr)
    if 1 ~= string.find(str_tmp, subStr_tmp) then
      return false
    else
      return true
    end
  end
  
  function StringUtil.split(input, delimiter)
    if "" == delimiter then
      return false
    end
    local pos, arr = 0, {}
    for st, sp in function()
      do return string.find, input, delimiter, pos end
      return string.find, input, delimiter, pos, true
    end, nil, nil, nil do
      table.insert(arr, string.sub(input, pos, st - 1))
      pos = sp + 1
    end
    table.insert(arr, string.sub(input, pos))
    return arr
  end
  
  function StringUtil.trim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
  end
  
  return StringUtil
end)
__DISTILLER:define("LuaBoomer.Util.Json", function(require)
  local VERSION = 2.016091619E7
  local AUTHOR_NOTE = "-[ JSON.lua package by Jeffrey Friedl (http://regex.info/blog/lua/json) version 20160916.19 ]-"
  local OBJDEF = {VERSION = VERSION, AUTHOR_NOTE = AUTHOR_NOTE}
  local default_pretty_indent = "  "
  local default_pretty_options = {
    pretty = true,
    align_keys = false,
    indent = default_pretty_indent
  }
  local isArray = {
    __tostring = function()
      return "JSON array"
    end
  }
  isArray.__index = isArray
  local isObject = {
    __tostring = function()
      return "JSON object"
    end
  }
  isObject.__index = isObject
  
  function OBJDEF:newArray(tbl)
    do return setmetatable, tbl or {} end
    return setmetatable, tbl or {}, isArray
  end
  
  function OBJDEF:newObject(tbl)
    do return setmetatable, tbl or {} end
    return setmetatable, tbl or {}, isObject
  end
  
  local function getnum(op)
    return type(op) == "number" and op or op.N
  end
  
  local isNumber = {
    __tostring = function(T)
      return T.S
    end,
    __unm = function(op)
      do return getnum end
      return getnum, op
    end,
    __concat = function(op1, op2)
      return tostring(op1) .. tostring(op2)
    end,
    __add = function(op1, op2)
      return getnum(op1) + getnum(op2)
    end,
    __sub = function(op1, op2)
      return getnum(op1) - getnum(op2)
    end,
    __mul = function(op1, op2)
      return getnum(op1) * getnum(op2)
    end,
    __div = function(op1, op2)
      return getnum(op1) / getnum(op2)
    end,
    __mod = function(op1, op2)
      return getnum(op1) % getnum(op2)
    end,
    __pow = function(op1, op2)
      return getnum(op1) ^ getnum(op2)
    end,
    __lt = function(op1, op2)
      return getnum(op1) < getnum(op2)
    end,
    __eq = function(op1, op2)
      return getnum(op1) == getnum(op2)
    end,
    __le = function(op1, op2)
      return getnum(op1) <= getnum(op2)
    end
  }
  isNumber.__index = isNumber
  
  function OBJDEF:asNumber(item)
    if getmetatable(item) == isNumber then
      return item
    elseif type(item) == "table" and type(item.S) == "string" and type(item.N) == "number" then
      do return setmetatable, item end
      return setmetatable, item, isNumber, nil
    else
      local holder = {
        S = tostring(item),
        N = tonumber(item)
      }
      do return setmetatable, holder end
      return setmetatable, holder, isNumber
    end
  end
  
  function OBJDEF:forceString(item)
    if type(item) == "table" and type(item.S) == "string" then
      return item.S
    else
      do return tostring end
      return tostring, item
    end
  end
  
  function OBJDEF:forceNumber(item)
    if type(item) == "table" and type(item.N) == "number" then
      return item.N
    else
      do return tonumber end
      return tonumber, item
    end
  end
  
  local function unicode_codepoint_as_utf8(codepoint)
    if codepoint <= 127 then
      do return string.char end
      return string.char, codepoint, nil, nil, nil, nil, nil, nil, nil, nil
    elseif codepoint <= 2047 then
      local highpart = math.floor(codepoint / 64)
      local lowpart = codepoint - 64 * highpart
      do return string.char, 192 + highpart end
      return string.char, 192 + highpart, 128 + lowpart, nil, nil, nil, nil, nil
    elseif codepoint <= 65535 then
      local highpart = math.floor(codepoint / 4096)
      local remainder = codepoint - 4096 * highpart
      local midpart = math.floor(remainder / 64)
      local lowpart = remainder - 64 * midpart
      highpart = 224 + highpart
      midpart = 128 + midpart
      lowpart = 128 + lowpart
      if 224 == highpart and midpart < 160 or 237 == highpart and midpart > 159 or 240 == highpart and midpart < 144 or 244 == highpart and midpart > 143 then
        return "?"
      else
        do return string.char, highpart, midpart end
        return string.char, highpart, midpart, lowpart, nil, nil
      end
    else
      local highpart = math.floor(codepoint / 262144)
      local remainder = codepoint - 262144 * highpart
      local midA = math.floor(remainder / 4096)
      remainder = remainder - 4096 * midA
      local midB = math.floor(remainder / 64)
      local lowpart = remainder - 64 * midB
      do return string.char, 240 + highpart, 128 + midA, 128 + midB end
      return string.char, 240 + highpart, 128 + midA, 128 + midB, 128 + lowpart
    end
  end
  
  function OBJDEF:onDecodeError(message, text, location, etc)
    if text then
      if location then
        message = string.format("%s at char %d of: %s", message, location, text)
      else
        message = string.format("%s: %s", message, text)
      end
    end
    if nil ~= etc then
      message = message .. " (" .. OBJDEF:encode(etc) .. ")"
    end
    if self.assert then
      self.assert(false, message)
    else
      assert(false, message)
    end
  end
  
  OBJDEF.onDecodeOfNilError = OBJDEF.onDecodeError
  OBJDEF.onDecodeOfHTMLError = OBJDEF.onDecodeError
  
  function OBJDEF:onEncodeError(message, etc)
    if nil ~= etc then
      message = message .. " (" .. OBJDEF:encode(etc) .. ")"
    end
    if self.assert then
      self.assert(false, message)
    else
      assert(false, message)
    end
  end
  
  local function grok_number(self, text, start, options)
    local integer_part = text:match("^-?[1-9]%d*", start) or text:match("^-?0", start)
    if not integer_part then
      self:onDecodeError("expected number", text, start, options.etc)
    end
    local i = start + integer_part:len()
    local decimal_part = text:match("^%.%d+", i) or ""
    i = i + decimal_part:len()
    local exponent_part = text:match("^[eE][-+]?%d+", i) or ""
    i = i + exponent_part:len()
    local full_number_text = integer_part .. decimal_part .. exponent_part
    if options.decodeNumbersAsObjects then
      return OBJDEF:asNumber(full_number_text), i
    end
    if options.decodeIntegerStringificationLength and (integer_part:len() >= options.decodeIntegerStringificationLength or exponent_part:len() > 0) or options.decodeDecimalStringificationLength and (decimal_part:len() >= options.decodeDecimalStringificationLength or exponent_part:len() > 0) then
      return full_number_text, i
    end
    local as_number = tonumber(full_number_text)
    if not as_number then
      self:onDecodeError("bad number", text, start, options.etc)
    end
    return as_number, i
  end
  
  local function grok_string(self, text, start, options)
    if text:sub(start, start) ~= "\"" then
      self:onDecodeError("expected string's opening quote", text, start, options.etc)
    end
    local i = start + 1
    local text_len = text:len()
    local VALUE = ""
    while i <= text_len do
      local c = text:sub(i, i)
      if "\"" == c then
        return VALUE, i + 1
      end
      if "\\" ~= c then
        VALUE = VALUE .. c
        i = i + 1
      elseif text:match("^\\b", i) then
        VALUE = VALUE .. "\b"
        i = i + 2
      elseif text:match("^\\f", i) then
        VALUE = VALUE .. "\f"
        i = i + 2
      elseif text:match("^\\n", i) then
        VALUE = VALUE .. "\n"
        i = i + 2
      elseif text:match("^\\r", i) then
        VALUE = VALUE .. "\r"
        i = i + 2
      elseif text:match("^\\t", i) then
        VALUE = VALUE .. "\t"
        i = i + 2
      else
        local hex = text:match("^\\u([0123456789aAbBcCdDeEfF][0123456789aAbBcCdDeEfF][0123456789aAbBcCdDeEfF][0123456789aAbBcCdDeEfF])", i)
        if hex then
          i = i + 6
          local codepoint = tonumber(hex, 16)
          if codepoint >= 55296 and codepoint <= 56319 then
            local lo_surrogate = text:match("^\\u([dD][cdefCDEF][0123456789aAbBcCdDeEfF][0123456789aAbBcCdDeEfF])", i)
            if lo_surrogate then
              i = i + 6
              codepoint = 9216 + (codepoint - 55296) * 1024 + tonumber(lo_surrogate, 16)
            else
            end
          end
          VALUE = VALUE .. unicode_codepoint_as_utf8(codepoint)
        else
          VALUE = VALUE .. text:match("^\\(.)", i)
          i = i + 2
        end
      end
    end
    self:onDecodeError("unclosed string", text, start, options.etc)
  end
  
  local function skip_whitespace(text, start)
    local _, match_end = text:find("^[ \n\r\t]+", start)
    if match_end then
      return match_end + 1
    else
      return start
    end
  end
  
  local grok_one
  
  local function grok_object(self, text, start, options)
    if text:sub(start, start) ~= "{" then
      self:onDecodeError("expected '{'", text, start, options.etc)
    end
    local i = skip_whitespace(text, start + 1)
    local VALUE = self.strictTypes and self:newObject({}) or {}
    if text:sub(i, i) == "}" then
      return VALUE, i + 1
    end
    local text_len = text:len()
    while i <= text_len do
      local key, new_i = grok_string(self, text, i, options)
      i = skip_whitespace(text, new_i)
      if text:sub(i, i) ~= ":" then
        self:onDecodeError("expected colon", text, i, options.etc)
      end
      i = skip_whitespace(text, i + 1)
      local new_val, new_i = grok_one(self, text, i, options)
      VALUE[key] = new_val
      i = skip_whitespace(text, new_i)
      local c = text:sub(i, i)
      if "}" == c then
        return VALUE, i + 1
      end
      if text:sub(i, i) ~= "," then
        self:onDecodeError("expected comma or '}'", text, i, options.etc)
      end
      i = skip_whitespace(text, i + 1)
    end
    self:onDecodeError("unclosed '{'", text, start, options.etc)
  end
  
  local function grok_array(self, text, start, options)
    if text:sub(start, start) ~= "[" then
      self:onDecodeError("expected '['", text, start, options.etc)
    end
    local i = skip_whitespace(text, start + 1)
    local VALUE = self.strictTypes and self:newArray({}) or {}
    if text:sub(i, i) == "]" then
      return VALUE, i + 1
    end
    local VALUE_INDEX = 1
    local text_len = text:len()
    while i <= text_len do
      local val, new_i = grok_one(self, text, i, options)
      VALUE[VALUE_INDEX] = val
      VALUE_INDEX = VALUE_INDEX + 1
      i = skip_whitespace(text, new_i)
      local c = text:sub(i, i)
      if "]" == c then
        return VALUE, i + 1
      end
      if text:sub(i, i) ~= "," then
        self:onDecodeError("expected comma or '['", text, i, options.etc)
      end
      i = skip_whitespace(text, i + 1)
    end
    self:onDecodeError("unclosed '['", text, start, options.etc)
  end
  
  function grok_one(self, text, start, options)
    start = skip_whitespace(text, start)
    if start > text:len() then
      self:onDecodeError("unexpected end of string", text, nil, options.etc)
    end
    if text:find("^\"", start) then
      do return grok_string, self, text, start end
      return grok_string, self, text, start, options.etc, options.etc
    elseif text:find("^[-0123456789 ]", start) then
      do return grok_number, self, text, start end
      return grok_number, self, text, start, options, options.etc
    elseif text:find("^%{", start) then
      do return grok_object, self, text, start end
      return grok_object, self, text, start, options, options.etc
    elseif text:find("^%[", start) then
      do return grok_array, self, text, start end
      return grok_array, self, text, start, options, options.etc
    elseif text:find("^true", start) then
      return true, start + 4
    elseif text:find("^false", start) then
      return false, start + 5
    elseif text:find("^null", start) then
      return nil, start + 4
    else
      self:onDecodeError("can't parse JSON", text, start, options.etc)
    end
  end
  
  function OBJDEF:SafeDecode(text, etc, options)
    local stat, result, err = pcall(self.decode, self, text, etc, options)
    if stat and result then
      return result
    elseif stat then
      return result, err
    else
      return nil, result
    end
  end
  
  function OBJDEF:decode(text, etc, options)
    if type(options) ~= "table" then
      options = {}
    end
    if nil ~= etc then
      options.etc = etc
    end
    if type(self) ~= "table" or self.__index ~= OBJDEF then
      OBJDEF:onDecodeError("JSON:decode must be called in method format", nil, nil, options.etc)
    end
    if nil == text then
      self:onDecodeOfNilError(string.format("nil passed to JSON:decode()"), nil, nil, options.etc)
    elseif type(text) ~= "string" then
      self:onDecodeError(string.format("expected string argument to JSON:decode(), got %s", type(text)), nil, nil, options.etc)
    end
    if text:match("^%s*$") then
      return nil
    end
    if text:match("^%s*<") then
      self:onDecodeOfHTMLError(string.format("html passed to JSON:decode()"), text, nil, options.etc)
    end
    if 0 == text:sub(1, 1):byte() or text:len() >= 2 and 0 == text:sub(2, 2):byte() then
      self:onDecodeError("JSON package groks only UTF-8, sorry", text, nil, options.etc)
    end
    if nil == options.decodeNumbersAsObjects then
      options.decodeNumbersAsObjects = self.decodeNumbersAsObjects
    end
    if nil == options.decodeIntegerStringificationLength then
      options.decodeIntegerStringificationLength = self.decodeIntegerStringificationLength
    end
    if nil == options.decodeDecimalStringificationLength then
      options.decodeDecimalStringificationLength = self.decodeDecimalStringificationLength
    end
    local success, value = pcall(grok_one, self, text, 1, options)
    if success then
      return value
    else
      if self.assert then
        self.assert(false, value)
      else
        assert(false, value)
      end
      return nil, value
    end
  end
  
  local function backslash_replacement_function(c)
    if "\n" == c then
      return "\\n"
    elseif "\r" == c then
      return "\\r"
    elseif "\t" == c then
      return "\\t"
    elseif "\b" == c then
      return "\\b"
    elseif "\f" == c then
      return "\\f"
    elseif "\"" == c then
      return "\\\""
    elseif "\\" == c then
      return "\\\\"
    else
      do return string.format, "\\u%04x", c:byte() end
      return string.format, "\\u%04x", c:byte()
    end
  end
  
  local chars_to_be_escaped_in_JSON_string = "[" .. "\"" .. "%\\" .. "%z" .. "\001" .. "-" .. "\031" .. "]"
  local LINE_SEPARATOR_as_utf8 = unicode_codepoint_as_utf8(8232)
  local PARAGRAPH_SEPARATOR_as_utf8 = unicode_codepoint_as_utf8(8233)
  
  local function json_string_literal(value, options)
    local newval = value:gsub(chars_to_be_escaped_in_JSON_string, backslash_replacement_function)
    if options.stringsAreUtf8 then
      newval = newval:gsub(LINE_SEPARATOR_as_utf8, "\\u2028"):gsub(PARAGRAPH_SEPARATOR_as_utf8, "\\u2029")
    end
    return "\"" .. newval .. "\""
  end
  
  local function object_or_array(self, T, etc)
    local string_keys = {}
    local number_keys = {}
    local number_keys_must_be_strings = false
    local maximum_number_key
    for key in pairs(T) do
      if type(key) == "string" then
        table.insert(string_keys, key)
      elseif type(key) == "number" then
        table.insert(number_keys, key)
        if key <= 0 or key >= math.huge then
          number_keys_must_be_strings = true
        elseif not maximum_number_key or key > maximum_number_key then
          maximum_number_key = key
        end
      else
        self:onEncodeError("can't encode table with a key of type " .. type(key), etc)
      end
    end
    if 0 == #string_keys and not number_keys_must_be_strings then
      if #number_keys > 0 then
        return nil, maximum_number_key
      elseif tostring(T) == "JSON array" then
        return nil
      elseif tostring(T) == "JSON object" then
        return {}
      else
        return nil
      end
    end
    table.sort(string_keys)
    local map
    if #number_keys > 0 then
      if self.noKeyConversion then
        self:onEncodeError("a table with both numeric and string keys could be an object or array; aborting", etc)
      end
      map = {}
      for key, val in pairs(T) do
        map[key] = val
      end
      table.sort(number_keys)
      for _, number_key in ipairs(number_keys) do
        local string_key = tostring(number_key)
        if nil == map[string_key] then
          table.insert(string_keys, string_key)
          map[string_key] = T[number_key]
        else
          self:onEncodeError("conflict converting table with mixed-type keys into a JSON object: key " .. number_key .. " exists both as a string and a number.", etc)
        end
      end
    end
    return string_keys, nil, map
  end
  
  local encode_value
  
  function encode_value(self, value, parents, etc, options, indent, for_key)
    if nil == value or not for_key and options and options.null and value == options.null then
      return "null"
    elseif type(value) == "string" then
      do return json_string_literal, value end
      return json_string_literal, value, options, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
    elseif type(value) == "number" then
      if value ~= value then
        return "null"
      elseif value >= math.huge then
        return "1e+9999"
      elseif value <= -math.huge then
        return "-1e+9999"
      else
        do return tostring end
        return tostring, value, options, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
      end
    elseif type(value) == "boolean" then
      do return tostring end
      return tostring, value, options, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
    elseif type(value) ~= "table" then
      self:onEncodeError("can't convert " .. type(value) .. " to JSON", etc)
    elseif getmetatable(value) == isNumber then
      do return tostring end
      return tostring, value, "can't convert " .. type(value) .. " to JSON", etc, " to JSON", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
    else
      local T = value
      if type(options) ~= "table" then
        options = {}
      end
      if type(indent) ~= "string" then
        indent = ""
      end
      if parents[T] then
        self:onEncodeError("table " .. tostring(T) .. " is a child of itself", etc)
      else
        parents[T] = true
      end
      local result_value
      local object_keys, maximum_number_key, map = object_or_array(self, T, etc)
      if maximum_number_key then
        local ITEMS = {}
        for i = 1, maximum_number_key do
          table.insert(ITEMS, encode_value(self, T[i], parents, etc, options, indent))
        end
        if options.pretty then
          result_value = "[ " .. table.concat(ITEMS, ", ") .. " ]"
        else
          result_value = "[" .. table.concat(ITEMS, ",") .. "]"
        end
      elseif object_keys then
        local TT = map or T
        if options.pretty then
          local KEYS = {}
          local max_key_length = 0
          for _, key in ipairs(object_keys) do
            local encoded = encode_value(self, tostring(key), parents, etc, options, indent, true)
            if options.align_keys then
              max_key_length = math.max(max_key_length, #encoded)
            end
            table.insert(KEYS, encoded)
          end
          local key_indent = indent .. tostring(options.indent or "")
          local subtable_indent = key_indent .. string.rep(" ", max_key_length) .. (options.align_keys and "  " or "")
          local FORMAT = "%s%" .. string.format("%d", max_key_length) .. "s: %s"
          local COMBINED_PARTS = {}
          for i, key in ipairs(object_keys) do
            local encoded_val = encode_value(self, TT[key], parents, etc, options, subtable_indent)
            table.insert(COMBINED_PARTS, string.format(FORMAT, key_indent, KEYS[i], encoded_val))
          end
          result_value = "{\n" .. table.concat(COMBINED_PARTS, ",\n") .. "\n" .. indent .. "}"
        else
          local PARTS = {}
          for _, key in ipairs(object_keys) do
            local encoded_val = encode_value(self, TT[key], parents, etc, options, indent)
            local encoded_key = encode_value(self, tostring(key), parents, etc, options, indent, true)
            table.insert(PARTS, string.format("%s:%s", encoded_key, encoded_val))
          end
          result_value = "{" .. table.concat(PARTS, ",") .. "}"
        end
      else
        result_value = "[]"
      end
      parents[T] = false
      return result_value
    end
  end
  
  function OBJDEF:SafeEncode(value, etc, options)
    local stat, result, err = pcall(self.encode, self, value, etc, options)
    if stat and result then
      return result
    elseif stat then
      return result, err
    else
      return nil, result
    end
  end
  
  function OBJDEF:encode(value, etc, options)
    if type(self) ~= "table" or self.__index ~= OBJDEF then
      OBJDEF:onEncodeError("JSON:encode must be called in method format", etc)
    end
    if type(options) ~= "table" then
      options = {}
    end
    do return encode_value, self, value, {}, etc end
    return encode_value, self, value, {}, etc, options
  end
  
  function OBJDEF:encode_pretty(value, etc, options)
    if type(self) ~= "table" or self.__index ~= OBJDEF then
      OBJDEF:onEncodeError("JSON:encode_pretty must be called in method format", etc)
    end
    if type(options) ~= "table" then
      options = default_pretty_options
    end
    do return encode_value, self, value, {}, etc end
    return encode_value, self, value, {}, etc, options
  end
  
  function OBJDEF.__tostring()
    return "JSON encode/decode package"
  end
  
  OBJDEF.__index = OBJDEF
  
  function OBJDEF:new(args)
    local new = {}
    if args then
      for key, val in pairs(args) do
        new[key] = val
      end
    end
    do return setmetatable, new end
    return setmetatable, new, OBJDEF, pairs(args)
  end
  
  do return OBJDEF.new end
  return OBJDEF.new, OBJDEF
end)
__DISTILLER:define("LuaBoomer.Util.JsonUtil", function(require)
  local JSON = require("LuaBoomer.Util.Json")
  local StringUtil = require("LuaBoomer.Util.StringUtil")
  
  local function is_integer(n)
    if math.type(n) == "integer" then
      return true
    end
    return false
  end
  
  local function valueFormat(v)
    if type(v) ~= "string" and type(v) ~= "number" and type(v) ~= "boolean" and type(v) ~= "table" then
      do return tostring end
      return tostring, v
    end
    return v
  end
  
  local function handle_decode_sparse_array(t_array)
    local t_array_new = {}
    for k, v in pairs(t_array.__value) do
      if "__type" ~= k then
        t_array_new[tonumber(k)] = v
      end
    end
    return t_array_new
  end
  
  local function isSparseArrayTable(t)
    for k, v in pairs(t) do
      if "__type" == k and "sparse_array" == v then
        return true
      end
    end
    return false
  end
  
  local function isArrayTable(t)
    if type(t) ~= "table" then
      return false
    end
    for i, v in pairs(t) do
      if type(i) ~= "number" then
        return false
      end
    end
    return true
  end
  
  local function mydecode(t_table)
    local new_table = {}
    for k, v in pairs(t_table) do
      local currentKey
      if type(k) == "string" and StringUtil.startWiths(k, "[") and StringUtil.endWiths(k, "]") then
        local num_k = tonumber(string.sub(k, 2, -2))
        new_table[num_k] = v
        currentKey = num_k
      else
        new_table[k] = v
        currentKey = k
      end
      if type(v) == "table" then
        new_table[currentKey] = mydecode(v)
      end
    end
    return new_table
  end
  
  local function handle_sparse_array(t_array)
    local array = {}
    local t_array_new = {
      __type = "sparse_array",
      __value = array
    }
    for i, v in pairs(t_array) do
      array[i] = v
    end
    return t_array_new
  end
  
  local function cloneTable(t_table)
    local copy = {}
    for k, v in pairs(t_table) do
      if type(v) == "table" then
        copy[k] = cloneTable(v)
      else
        copy[k] = v
      end
    end
    return copy
  end
  
  local function tableConcat(t1, t2)
    for i = 1, #t2 do
      t1[#t1 + 1] = t2[i]
    end
    return t1
  end
  
  local function myencode(t_table)
    local new_table = {}
    for k, v in pairs(t_table) do
      local new_v = v
      if type(v) == "table" then
        new_v = myencode(v)
      else
        new_v = valueFormat(v)
      end
      if type(k) == "number" and is_integer(k) then
        new_table["[" .. k .. "]"] = new_v
      else
        new_table[k] = new_v
      end
    end
    return new_table
  end
  
  local json = {
    encode = function(t, f)
      local flag = false
      if nil ~= f then
        flag = f
      end
      if flag then
        t = myencode(cloneTable(t))
      else
      end
      local result = JSON:SafeEncode(t)
      return result
    end,
    decode = function(text)
      local origin = JSON:SafeDecode(text)
      local ok, result = xpcall(mydecode, debug.traceback, origin)
      if not ok then
        return origin
      end
      return result
    end,
    clone = function(t)
      do return cloneTable end
      return cloneTable, t
    end,
    concat = function(t1, t2)
      do return tableConcat, t1 end
      return tableConcat, t1, t2
    end,
    tableDecode = function(t)
      do return mydecode end
      return mydecode, t
    end
  }
  return json
end)
__DISTILLER:define("LuaBoomer.NetworkModule.LbNet", function(require)
  local QueueList = {}
  
  function QueueList.new()
    return {first = 0, last = -1}
  end
  
  function QueueList.pushFront(list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
  end
  
  function QueueList.pushBack(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
  end
  
  function QueueList.popFront(list)
    local first = list.first
    if first > list.last then
      return nil
    end
    local value = list[first]
    list[first] = nil
    list.first = first + 1
    return value
  end
  
  function QueueList.popBack(list)
    local last = list.last
    if last < list.first then
      return nil
    end
    local value = list[last]
    list[last] = nil
    list.last = last - 1
    return value
  end
  
  local socket_impl
  local StringUtil = require("LuaBoomer.Util.StringUtil")
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  local local_mgr = require("LuaBoomer.LocalModule.LocalModuleMgr")
  local logger = require("LuaBoomer.Util.Logger")
  local M = {}
  local send_buffer = QueueList.new()
  local server_site, device_info
  local heartbeat_start_time = 0
  local heartbeat_interval = 2
  local retry_count = 0
  local max_retry_count = 3
  
  local function _reconnect()
    if not socket_impl.isReady() then
      socket_impl.initSocket()
    end
    if socket_impl.isReady() then
      local server_info = StringUtil.split(server_site, ":")
      local code = socket_impl.connect(server_info[1], server_info[2])
      logger.info("try to connect to", server_info[1], server_info[2])
      logger.info("return code is :", code)
      logger.info("local port:", socket_impl.getLocalPort())
    end
  end
  
  local InitUpdateModuleName = "InitUpdateModule"
  
  local function handleInitModuleMsg(data)
    if StringUtil.startWiths(data, InitUpdateModuleName) then
      local len_1 = #InitUpdateModuleName
      local len_2 = len_1 + #"`0`"
      local is_end = string.sub(data, len_1 + 2, len_2 - 1)
      local bundle = string.sub(data, len_2 + 1)
      if "0" == is_end then
        local_mgr.getInitUpdateModule().onReceiveBundle(bundle, false)
      else
        local_mgr.getInitUpdateModule().onReceiveBundle(bundle, true)
      end
      return true
    end
  end
  
  local RemoteModuleMgrName = "RemoteModuleMgr"
  
  local function handleRemoteModuleMgrMsg(data)
    if StringUtil.startWiths(data, RemoteModuleMgrName) then
      local len_1 = #RemoteModuleMgrName
      local len_2 = len_1 + #"`0`"
      local flag = string.sub(data, len_1 + 2, len_2 - 1)
      local block = string.sub(data, len_2 + 1)
      local_mgr.getRemoteModuleMgr().onReceiveBlock(block, flag)
      return true
    end
  end
  
  local ByteLocalModuleMsgHeader = "`Byte`"
  
  local function handleByteLocalModuleMsg(data)
    if StringUtil.startWiths(data, ByteLocalModuleMsgHeader) then
      local msg = string.sub(data, #ByteLocalModuleMsgHeader + 1)
      local split_flag = "`||`"
      local msgArray = StringUtil.split(msg, split_flag)
      if not msgArray or 0 == #msgArray then
        return false
      end
      local local_module_handler = msgArray[1] or "nil"
      if local_mgr.checkModule(local_module_handler) ~= nil then
        table.remove(msgArray, 1)
        local msg = {}
        while #msgArray > 0 do
          local key = table.remove(msgArray, 1)
          local value = table.remove(msgArray, 1)
          if nil ~= key and nil ~= value then
            msg[key] = value
          end
        end
        local_mgr.onReceive({
          header = {module_handler = local_module_handler},
          data = msg
        })
        return true
      end
    end
  end
  
  local function _get_socket_recv_data(socket_instance, length)
    local data = ""
    local res_len = length
    while res_len > 0 do
      local sub_data = socket_instance.recv(length)
      if nil ~= sub_data then
        data = data .. sub_data
      end
      res_len = length - string.len(data)
    end
    return data
  end
  
  local function _doReceive()
    if not socket_impl.isReady() then
      return false
    end
    local length_str = socket_impl.recv(2)
    if length_str and 2 == #length_str then
      local length = string.unpack(">I2", length_str)
      local data = _get_socket_recv_data(socket_impl, length)
      if data then
        if handleInitModuleMsg(data) then
          return true
        end
        if handleRemoteModuleMgrMsg(data) then
          return true
        end
        if handleByteLocalModuleMsg(data) then
          return true
        end
        local json = JsonUtil.decode(data)
        if nil ~= json and type(json) == "table" and nil ~= json.header then
          local module_handler = json.header.module_handler
          if "InitUpdateModule" == module_handler then
            local_mgr.getInitUpdateModule().onReceive(json)
          elseif nil ~= local_mgr.getRemoteModuleMgr() and local_mgr.getRemoteModuleMgr().checkModule(module_handler) then
            local_mgr.getRemoteModuleMgr().onReceive(json)
          elseif nil ~= local_mgr.checkModule(module_handler) then
            local_mgr.onReceive(json)
          end
        else
          logger.info("recv unexpected message: data [" .. string.sub(data, 1, 100) .. "..." .. "]")
          assert(false, "recv unexpected message: data [" .. string.sub(data, 1, 100) .. "..." .. "]")
        end
        return true
      end
    end
    return false
  end
  
  local function flushReceive()
    local count = 0
    local tryNext = true
    while count < 100 and tryNext do
      count = count + 1
      tryNext = _doReceive()
    end
  end
  
  local function _doSend()
    if not socket_impl.isReady() then
      return
    end
    for i = 1, #send_buffer do
      local msg = send_buffer[i]
      local fmt = string.format(">I2c%d", #msg)
      local data = string.pack(fmt, #msg, msg)
      socket_impl.send(data)
    end
    send_buffer = {}
  end
  
  local max_send_once = 5
  
  local function _doSendV2()
    if not socket_impl.isReady() then
      return
    end
    for i = 1, max_send_once do
      local msg = QueueList.popBack(send_buffer)
      if nil == msg then
        break
      end
      local fmt = string.format(">I2c%d", #msg)
      local data = string.pack(fmt, #msg, msg)
      if not socket_impl.send(data) then
        QueueList.pushBack(send_buffer, msg)
        break
      end
    end
  end
  
  local do_recv_interval = 5
  local do_recv_count = 0
  
  local function flushReceiveV2()
    do_recv_count = do_recv_count + 1
    if do_recv_count >= do_recv_interval then
      do_recv_count = 0
      _doReceive()
    end
  end
  
  function M.updateEveryFrame(delta_time)
    if socket_impl.isReady() and socket_impl.is_connect_ready() then
      flushReceiveV2()
      _doSendV2()
    end
  end
  
  function M.simpleHeartbeat()
    if socket_impl.isReady() and socket_impl.is_connect_ready() then
      local msg = JsonUtil.encode({
        header = {
          module_handler = "HeartbeatModule"
        },
        data = device_info
      })
      local fmt = string.format(">I2c%d", #msg)
      local packData = string.pack(fmt, #msg, msg)
      local send_result = socket_impl.send(packData)
      if not send_result then
        retry_count = retry_count + 1
      else
        retry_count = 0
        return
      end
      if retry_count >= max_retry_count then
        socket_impl.close()
      end
    else
      _reconnect()
    end
  end
  
  function M.heartbeat(delta_time)
    if 0 == heartbeat_start_time or heartbeat_start_time > heartbeat_interval then
      heartbeat_start_time = 0.01
      if socket_impl.isReady() and socket_impl.is_connect_ready() then
        local msg = JsonUtil.encode({
          header = {
            module_handler = "HeartbeatModule"
          },
          data = device_info
        })
        local fmt = string.format(">I2c%d", #msg)
        local packData = string.pack(fmt, #msg, msg)
        local send_result = socket_impl.send(packData)
        if not send_result then
          retry_count = retry_count + 1
        else
          retry_count = 0
          return
        end
        if retry_count >= max_retry_count then
          socket_impl.close()
        end
      else
        _reconnect()
      end
    end
    heartbeat_start_time = heartbeat_start_time + delta_time
  end
  
  function M.update(delta_time)
    if nil ~= socket_impl and socket_impl.update then
      socket_impl.update(delta_time)
    end
  end
  
  function M.requestMsg(module_handler, data)
    local msg = JsonUtil.encode({
      header = {module_handler = module_handler},
      data = data
    })
    QueueList.pushFront(send_buffer, msg)
  end
  
  function M.requestBinaryMsg(module_handler, binaryData, msgData)
    local msg = JsonUtil.encode({
      header = {module_handler = module_handler},
      data = msgData
    })
    local binaryDataLen = #binaryData
    local msgDataLen = #msg
    local totalLen = binaryDataLen + msgDataLen
    local specialToken = "|"
    local fmt = string.format(">I2I2I2c%dc%d", binaryDataLen, msgDataLen)
    local packData = string.pack(fmt, string.byte(specialToken), totalLen, binaryDataLen, binaryData, msg)
    QueueList.pushFront(send_buffer, packData)
  end
  
  local is_init = false
  
  function M.init(lb_server, socket_impl_func)
    logger.info("~~~~~~~net init~~~~~~~")
    logger.info("lb_server: ", lb_server)
    server_site = lb_server
    if nil ~= socket_impl_func then
      socket_impl = require(socket_impl_func)
    else
      socket_impl = require("LuaBoomer.NetworkModule.SocketBase")
    end
    _reconnect()
    is_init = true
  end
  
  function M.get_is_init()
    return is_init
  end
  
  function M.manuallyReconnect()
    _reconnect()
  end
  
  function M.getLocalPort()
    do return end
    return socket_impl.getLocalPort, nil
  end
  
  function M.manuallyDisconnect()
    if socket_impl.isReady() then
      socket_impl.close()
    end
  end
  
  function M.setDeviceInfo(device)
    local new_device_info = device_info
    if nil == new_device_info then
      new_device_info = {}
    end
    for k, v in pairs(device) do
      new_device_info[k] = v
    end
    device_info = new_device_info
  end
  
  function M.getDeviceInfo()
    return device_info
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.RemoteModuleMgr", function(require)
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local json = require("LuaBoomer.Util.JsonUtil")
  local M = {}
  local module_handler = "RemoteModuleMgr"
  local logger = require("LuaBoomer.Util.Logger")
  local remote_modules = {}
  local result_buffer = {}
  local recv_fin = false
  local recv_blocks = ""
  local recv_params
  
  local function loadScript(script, params)
    local data = {}
    if params then
      data = json.decode(params)
    end
    data = data or {}
    local env = setmetatable(data, {
      __index = _G
    })
    do return load, script, "luaboomerRemoteModule", "bt" end
    return load, script, "luaboomerRemoteModule", "bt", env
  end
  
  function M.onReceiveBlock(block, flag)
    if not recv_fin then
      if "0" == flag then
        recv_blocks = recv_blocks .. block
      end
      if "1" == flag then
        recv_params = json.decode(block)
        local msg = {
          header = {
            module_handler = "RemoteModuleMgr"
          },
          data = {
            lua_code = recv_blocks,
            module_name = recv_params.module_name,
            reply_to = recv_params.reply_to,
            param_json = block
          }
        }
        M.onReceive(msg)
        recv_fin = false
        recv_blocks = ""
        recv_params = nil
      end
    end
  end
  
  function M.onReceive(msg)
    local incoming_module_handler = msg.header.module_handler
    local module_name = msg.data.module_name
    local reply_to = msg.data.reply_to
    if incoming_module_handler == module_handler then
      local return_data = {reply_to = reply_to}
      local module_code = msg.data.lua_code
      local module_params = msg.data.param_json
      local remote_code, error = loadScript(module_code, module_params)
      local result = error
      if not error then
        local code_success = false
        code_success, result = pcall(remote_code)
        if code_success then
          return_data.status = "success"
          remote_modules[module_name] = remote_code
        else
          return_data.status = "failed"
        end
      else
        return_data.status = "failed"
      end
      return_data.result = result
      if nil ~= reply_to then
        table.insert(result_buffer, return_data)
      end
    else
      for k, v in pairs(remote_modules) do
        local module = remote_modules[module_name]
        if nil ~= module and "table" == type(module) and nil ~= module.onReceive then
          module.onReceive(msg)
        end
      end
    end
  end
  
  function M.update(delta_time)
    for module_name, remote_module in pairs(remote_modules) do
      if type(remote_module) == "table" and remote_module.update ~= nil then
        remote_module.update(delta_time)
      end
    end
    if #result_buffer >= 1 then
      network_core.requestMsg(module_handler, result_buffer)
      result_buffer = {}
    end
  end
  
  function M.checkModule(module_name)
    return remote_modules[module_name]
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.Util.uuid", function(require)
  local M = {}
  local math = require("math")
  local os = require("os")
  local string = require("string")
  local bitsize = 32
  local lua_version = tonumber(_VERSION:match("%d%.*%d*"))
  local MATRIX_AND = {
    {0, 0},
    {0, 1}
  }
  local MATRIX_OR = {
    {0, 1},
    {1, 1}
  }
  local HEXES = "0123456789abcdef"
  local math_floor = math.floor
  local math_random = math.random
  local math_abs = math.abs
  local string_sub = string.sub
  local to_number = tonumber
  local assert = _ENV.assert
  local type = _ENV.type
  
  local function BITWISE(x, y, matrix)
    local z = 0
    local pow = 1
    while x > 0 or y > 0 do
      z = z + matrix[x % 2 + 1][y % 2 + 1] * pow
      pow = pow * 2
      x = math_floor(x / 2)
      y = math_floor(y / 2)
    end
    return z
  end
  
  local function INT2HEX(x)
    local s, base = "", 16
    local d
    while x > 0 do
      d = x % base + 1
      x = math_floor(x / base)
      s = string_sub(HEXES, d, d) .. s
    end
    while #s < 2 do
      s = "0" .. s
    end
    return s
  end
  
  function M.new(hwaddr)
    local bytes = {
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255),
      math_random(0, 255)
    }
    if hwaddr then
      assert("string" == type(hwaddr), "Expected hex string, got " .. type(hwaddr))
      local i, str = #hwaddr, hwaddr
      hwaddr = ""
      while i > 0 and #hwaddr < 12 do
        local c = str:sub(i, i):lower()
        if HEXES:find(c, 1, true) then
          hwaddr = c .. hwaddr
        end
        i = i - 1
      end
      assert(12 == #hwaddr, "Provided string did not contain at least 12 hex characters, retrieved '" .. hwaddr .. "' from '" .. str .. "'")
      bytes[11] = to_number(hwaddr:sub(1, 2), 16)
      bytes[12] = to_number(hwaddr:sub(3, 4), 16)
      bytes[13] = to_number(hwaddr:sub(5, 6), 16)
      bytes[14] = to_number(hwaddr:sub(7, 8), 16)
      bytes[15] = to_number(hwaddr:sub(9, 10), 16)
      bytes[16] = to_number(hwaddr:sub(11, 12), 16)
    end
    bytes[7] = BITWISE(bytes[7], 15, MATRIX_AND)
    bytes[7] = BITWISE(bytes[7], 64, MATRIX_OR)
    bytes[9] = BITWISE(bytes[7], 63, MATRIX_AND)
    bytes[9] = BITWISE(bytes[7], 128, MATRIX_OR)
    return INT2HEX(bytes[1]) .. INT2HEX(bytes[2]) .. INT2HEX(bytes[3]) .. INT2HEX(bytes[4]) .. "-" .. INT2HEX(bytes[5]) .. INT2HEX(bytes[6]) .. "-" .. INT2HEX(bytes[7]) .. INT2HEX(bytes[8]) .. "-" .. INT2HEX(bytes[9]) .. INT2HEX(bytes[10]) .. "-" .. INT2HEX(bytes[11]) .. INT2HEX(bytes[12]) .. INT2HEX(bytes[13]) .. INT2HEX(bytes[14]) .. INT2HEX(bytes[15]) .. INT2HEX(bytes[16])
  end
  
  function M.randomseed(seed)
    seed = math_floor(math_abs(seed))
    if seed >= 2 ^ bitsize then
      seed = seed - math_floor(seed / 2 ^ bitsize) * 2 ^ bitsize
    end
    if lua_version < 5.2 then
      math.randomseed(seed - 2 ^ (bitsize - 1))
    else
      math.randomseed(seed)
    end
    return seed
  end
  
  function M.seed()
    if package.loaded.socket and package.loaded.socket.gettime then
      do return M.randomseed end
      return M.randomseed, package.loaded.socket.gettime() * 10000
    else
      do return M.randomseed, os.time() end
      return M.randomseed, os.time()
    end
  end
  
  do return setmetatable, M end
  return setmetatable, M, {
    __call = function(self, hwaddr)
      do return self.new end
      return self.new, hwaddr
    end
  }, function(self, hwaddr)
    do return self.new end
    return self.new, hwaddr
  end
end)
__DISTILLER:define("LuaBoomer.LocalModule.ServerCmdModule", function(require)
  local M = {}
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local module_handler = "ServerCmdModule"
  local logger = require("LuaBoomer.Util.Logger")
  local uuid = require("LuaBoomer.Util.uuid")
  local _send_buffer = {}
  
  local function genId()
    uuid.seed()
    do return end
    return uuid, nil
  end
  
  function M.httpRequest(method, data, api)
    local legal_method = {post = "POST", get = "GET"}
    local id
    if method and legal_method[string.lower(method)] then
      id = genId()
      table.insert(_send_buffer, {
        msgId = id,
        method = legal_method[string.lower(method)],
        data = data,
        api = api
      })
    else
      logger.error("http method error: ", method)
      return
    end
    return id
  end
  
  function M.init()
  end
  
  function M.update(delta_time)
    if #_send_buffer >= 1 then
      network_core.requestMsg(module_handler, _send_buffer)
      _send_buffer = {}
    end
  end
  
  function M.onReceive(msg)
    print(msg)
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.TimeMgr", function(require)
  local M = {}
  local time = 0
  local timers = {}
  
  function M.init(...)
    time = 0
  end
  
  local function _runTimer(timer)
    timer.running = true
    while timer.next_time <= time and not timer.__deleted do
      timer.loop_count = timer.loop_count + 1
      xpcall(function()
        do return timer.obj[timer.func_name] end
        return timer.obj[timer.func_name], timer
      end, debug.traceback)
      if timer.__deleted then
        M:remove(timer)
      elseif timer.loop_time and timer.loop_time > 0 and (timer.loop_total_count == nil or timer.loop_count < timer.loop_total_count) then
        timer.last_time = time
        timer.next_time = timer.next_time + timer.loop_time
      else
        M:remove(timer)
      end
    end
    timer.running = false
  end
  
  function M.addTask(obj, func_name)
    local timer = {}
    timer.obj = obj
    timer.func_name = func_name
    timer.ready = false
    
    function timer.stop()
      timer.__deleted = true
    end
    
    function timer.isLast()
      return timer.loop_count == timer.loop_total_count
    end
    
    function timer.setDelay(delay)
      timer.delay = delay
      return timer
    end
    
    function timer.setInterval(interval)
      timer.loop_time = interval
      return timer
    end
    
    function timer.setLoop(loop_total_count)
      timer.loop_total_count = loop_total_count
      return timer
    end
    
    function timer.setParam(param)
      timer.param = param
      return timer
    end
    
    function timer.build()
      timer.last_time = time
      timer.next_time = time + timer.delay
      timer.loop_count = 0
      timer.running = false
      timer.ready = true
      return timer
    end
    
    table.insert(timers, timer)
    return timer
  end
  
  function M:remove(timer)
    if not timer or timer.__deleted then
      return
    end
    timer.__deleted = true
  end
  
  function M:clear()
    for i = #timers, 1, -1 do
      table.remove(timers, i)
    end
  end
  
  function M.update(delta_time)
    time = time + delta_time
    if 0 == #timers then
      return
    end
    
    local function Order(a, b)
      if a.next_time < b.next_time then
        return true
      else
        return false
      end
    end
    
    if #timers > 1 then
      table.sort(timers, Order)
    end
    for i, timer in ipairs(timers) do
      if not timer.__deleted and timer.ready and timer.next_time < time then
        _runTimer(timer)
      end
    end
    for i = #timers, 1, -1 do
      if timers[i].__deleted then
        table.remove(timers, i)
      end
    end
  end
  
  local single = {}
  
  function single.getInstance()
    M:clear()
    return M
  end
  
  function single.update(delta_time)
    M.update(delta_time)
  end
  
  return single
end)
__DISTILLER:define("LuaBoomer.Util.TimeUtil", function(require)
  local M = {}
  local time_cache_table = {}
  local time_cache_time_out = 30
  
  function M.time()
    local cur_time = os.time()
    if nil == time_cache_table[cur_time] then
      time_cache_table[cur_time] = 1
    else
      time_cache_table[cur_time] = time_cache_table[cur_time] + 1
      if time_cache_table[cur_time] >= 1000 then
        time_cache_table[cur_time] = 999
      end
    end
    for key, value in pairs(time_cache_table) do
      if cur_time - key > time_cache_time_out then
        time_cache_table[key] = nil
      end
    end
    return cur_time * 1000 + time_cache_table[cur_time]
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.Util.Queue", function(require)
  local mt = {}
  
  local function create()
    local o = {first = 0, last = -1}
    setmetatable(o, {__index = mt})
    return o
  end
  
  function mt:clear()
    local item = self:popBack()
    while item do
      item = self:popBack()
    end
  end
  
  function mt:pushFront(value)
    local first = self.first - 1
    self.first = first
    self[first] = value
  end
  
  function mt:pushBack(value)
    local last = self.last + 1
    self.last = last
    self[last] = value
  end
  
  function mt:popFront()
    local first = self.first
    if first > self.last then
      return nil
    end
    local value = self[first]
    self[first] = nil
    self.first = first + 1
    return value
  end
  
  function mt:popBack()
    local last = self.last
    if last < self.first then
      return nil
    end
    local value = self[last]
    self[last] = nil
    self.last = last - 1
    return value
  end
  
  return {create = create}
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProfileTaskModule", function(require)
  local M = {}
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local module_handler = "ProfileTaskModule"
  local timeUtil = require("LuaBoomer.Util.TimeUtil")
  local mark_task_id
  
  function M.init(...)
  end
  
  local Queue = require("LuaBoomer.Util.Queue")
  local mark_queue = Queue.create()
  
  function M.startTask(taskId)
    mark_task_id = taskId
    M.clearMark()
  end
  
  function M.markScreenshot(img, format, shotType)
    if not mark_task_id then
      return
    end
    if nil == shotType then
      shotType = 0
    end
    mark_queue:pushFront({
      task = mark_task_id,
      type = "screenshot",
      value = img,
      time = timeUtil.time(),
      format = format,
      shot = shotType
    })
  end
  
  function M.markLog(logTxt)
    if not mark_task_id then
      return
    end
    mark_queue:pushFront({
      task = mark_task_id,
      type = "log",
      value = logTxt,
      time = timeUtil.time()
    })
  end
  
  local max_block_size = 16384
  local max_send = 5
  
  function M.uploadTaskMark()
    if not mark_task_id then
      return
    end
    local send_count = 0
    local item = mark_queue:popBack()
    while item do
      send_count = send_count + 1
      local content = item.value
      if item.type == "log" then
        network_core.requestMsg(module_handler, {
          msg = "upload_task_mark",
          item = item
        })
      elseif item.type == "screenshot" then
        local block_total_count = math.ceil(#content / max_block_size)
        item.value = nil
        for index = 1, block_total_count do
          local block = string.sub(content, (index - 1) * max_block_size + 1, index * max_block_size)
          local data = {
            msg = "upload_task_mark",
            item = item,
            is_end = index == block_total_count,
            index = index
          }
          network_core.requestBinaryMsg(module_handler, block, data)
        end
      end
      if send_count >= max_send then
        break
      end
      item = mark_queue:popBack()
    end
    return
  end
  
  function M.clearMark()
    mark_queue:clear()
  end
  
  function M.update(delta_time)
    M.uploadTaskMark()
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.LbThreadMgr", function(require)
  local M = {}
  local currentThread, lastTime
  local stopErr = "LbThreadMgr_Stop_Task"
  
  function M.init(...)
  end
  
  function M.startTask(func, errHandler)
    local function warpErrHandler(error)
      if string.find(error, stopErr) then
        return
      end
      if errHandler then
        errHandler(error)
      else
        print(debug.traceback())
      end
    end
    
    local function warpFunc()
      local success, result = xpcall(func, warpErrHandler)
      if not success then
        print("LbThreadMgr Task Execute failed ")
      end
    end
    
    if currentThread then
      debug.sethook(currentThread, function()
        error(stopErr)
      end, "l")
      coroutine.resume(currentThread)
      currentThread = nil
      lastTime = nil
    end
    currentThread = coroutine.create(warpFunc)
  end
  
  function M.sleep(second)
    if not currentThread then
      return
    end
    if not lastTime then
      lastTime = os.time()
    end
    local curTime = os.time()
    while second > curTime - lastTime do
      coroutine.yield()
      curTime = os.time()
    end
    lastTime = curTime
    coroutine.resume(currentThread)
  end
  
  function M.update(delta_time)
    if currentThread then
      coroutine.resume(currentThread)
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.InitUpdateModule", function(require)
  local M = {}
  local module_handler = "InitUpdateModule"
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local CMD = {}
  local project, onUpdateCallBack
  local is_send_init_request = false
  local is_bundle_update_done = false
  local lua_boomer_bundle
  
  function M.init(conf)
    project = conf.project
    onUpdateCallBack = conf.onUpdateCallBack
  end
  
  function CMD.get_bundle(params)
    if not is_bundle_update_done then
      lua_boomer_bundle = lua_boomer_bundle .. params.bundle
      if params.is_end then
        onUpdateCallBack(lua_boomer_bundle)
        is_bundle_update_done = true
      end
    end
  end
  
  function M.onReceiveBundle(bundle, is_end)
    if not is_bundle_update_done then
      lua_boomer_bundle = lua_boomer_bundle .. bundle
      if is_end then
        onUpdateCallBack(lua_boomer_bundle)
        is_bundle_update_done = true
      end
    end
  end
  
  function M.onReceive(msg)
    local data = msg.data
    local command = data.command
    local command_data = data.command_data
    if command then
      local f = CMD[command]
      f(command_data)
    end
  end
  
  function M.updateEveryFrame(delta_time)
    if not is_send_init_request then
      lua_boomer_bundle = ""
      local request = {
        msg = "get_lua_boomer_bundle",
        project = project,
        version = "v2"
      }
      network_core.requestMsg(module_handler, request)
      is_send_init_request = true
    end
  end
  
  function M.update(delta_time)
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.LocalModuleMgr", function(require)
  local local_modules = {}
  local module_conf = {}
  local init_update_module
  local base_modules = {}
  local remote_module_mgr, server_cmd_module, timer_mgr, profile_task_module, lb_thread_mgr
  local M = {}
  local local_module_names = {
    LogViewModule = "LuaBoomer.LocalModule.LogViewModule",
    ProfileModule = "LuaBoomer.LocalModule.ProfileModule",
    DataForwardModule = "LuaBoomer.LocalModule.DataForwardModule",
    NetProfileModule = "LuaBoomer.LocalModule.NetProfileModule",
    GMModule = "LuaBoomer.LocalModule.GMModule",
    ProtoTestModule = "LuaBoomer.LocalModule.ProtoTest.ProtoTestModule",
    FileViewModule = "LuaBoomer.LocalModule.FileViewManager.FileViewModule",
    LiveCodingModule = "LuaBoomer.LocalModule.LiveCoding.LiveCodingModule",
    EventModule = "LuaBoomer.LocalModule.EventModule",
    ZtestModule = "LuaBoomer.LocalModule.ZtestModule",
    ClientHeartbeatCheckModule = "LuaBoomer.LocalModule.ClientHeartbeatCheckModule",
    FpsModule = "LuaBoomer.LocalModule.FpsModule",
    LuaFlameModule = "LuaBoomer.LocalModule.LuaFlameGraph.LuaFlameModule"
  }
  
  function M.getModule(module_handler)
    local module = local_modules[module_handler]
    if not module then
      return base_modules[module_handler], true
    end
    return module, module_conf[module_handler].switch
  end
  
  function M.onReceive(msg)
    local module_handler = msg.header.module_handler
    local module, switch = M.getModule(module_handler)
    if switch and nil ~= module and type(module) == "table" and nil ~= module.onReceive then
      module.onReceive(msg)
    end
  end
  
  function M.updateEveryFrame(delta_time)
    for module_name, module in pairs(local_modules) do
      if module_conf[module_name].switch and nil ~= module and type(module) == "table" and nil ~= module.updateEveryFrame then
        module.updateEveryFrame(delta_time)
      end
    end
    for module_name, module in pairs(base_modules) do
      if nil ~= module and type(module) == "table" and nil ~= module.updateEveryFrame then
        module.updateEveryFrame(delta_time)
      end
    end
  end
  
  function M.update(delta_time)
    for module_name, module in pairs(local_modules) do
      if module_conf[module_name].switch and nil ~= module and type(module) == "table" and nil ~= module.update then
        module.update(delta_time)
      end
    end
    for module_name, module in pairs(base_modules) do
      if nil ~= module and type(module) == "table" and nil ~= module.update then
        module.update(delta_time)
      end
    end
  end
  
  function M.initModules(confs)
    remote_module_mgr = require("LuaBoomer.LocalModule.RemoteModuleMgr")
    base_modules.RemoteModuleMgr = remote_module_mgr
    server_cmd_module = require("LuaBoomer.LocalModule.ServerCmdModule")
    base_modules.ServerCmdModule = server_cmd_module
    timer_mgr = require("LuaBoomer.LocalModule.TimeMgr")
    base_modules.TimeMgr = timer_mgr
    profile_task_module = require("LuaBoomer.LocalModule.ProfileTaskModule")
    base_modules.ProfileTaskModule = profile_task_module
    lb_thread_mgr = require("LuaBoomer.LocalModule.LbThreadMgr")
    base_modules.LbThreadMgr = lb_thread_mgr
    for module, conf in pairs(confs) do
      local modulePath = local_module_names[module]
      if modulePath then
        local_modules[module] = require(modulePath)
        local_modules[module].init(conf)
      end
    end
    for k, v in pairs(local_module_names) do
      if not confs[k] then
        confs[k] = {switch = false}
      end
    end
    module_conf = confs
  end
  
  function M.isModuleOn(module_name)
    if not module_conf[module_name] then
      return false
    end
    return module_conf[module_name].switch
  end
  
  function M.moduleSwitch(module_name, state, argv_table)
    if not module_conf[module_name] then
      print("not found this module: ", module_name)
      return
    end
    print("changing module state: ", module_name)
    local current_state = module_conf[module_name].switch
    if nil == state then
      current_state = not current_state
    else
      current_state = state
    end
    module_conf[module_name].switch = current_state
    if nil ~= argv_table and local_modules[module_name].atSwitch then
      local_modules[module_name].atSwitch(state, argv_table)
    end
  end
  
  function M.forwardData(data)
    if not local_modules.DataForwardModule then
      return
    end
    local_modules.DataForwardModule.addData(data)
  end
  
  function M.checkModule(module_name)
    local module = local_modules[module_name]
    if not module then
      return base_modules[module_name]
    end
    return module
  end
  
  function M.getRemoteModuleMgr()
    return remote_module_mgr
  end
  
  function M.getServerCmdModule()
    return server_cmd_module
  end
  
  function M.getProfileTaskModule()
    return profile_task_module
  end
  
  function M.getInitUpdateModule()
    if nil == init_update_module then
      init_update_module = require("LuaBoomer.LocalModule.InitUpdateModule")
    end
    return init_update_module
  end
  
  function M.getEventModule()
    local module, switch = M.getModule("EventModule")
    return module
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.LogViewModule", function(require)
  local M = {}
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local module_handler = "LogViewModule"
  local log_buffer = {}
  local send_buffer = {}
  local log_file, log_reader, init_conf
  local is_init_done = false
  local tick_time = 0
  local tick_time_interval = 0.1
  local is_on = false
  local _do_init_recover
  local simple_log_lock = false
  
  local function getTargetUpvalue(fun, upvalueName)
    local isEnd = false
    local result
    local i = 1
    while not isEnd do
      local name, val = debug.getupvalue(fun, i)
      if nil == name then
        isEnd = true
      end
      if name == upvalueName then
        isEnd = true
        result = val
      else
        i = i + 1
      end
    end
    return result, i
  end
  
  local function dumpTable(self, depth, as_key)
    depth = depth or 1
    local self_type = type(self)
    if "table" == self_type and depth > 0 then
      local pieces = {}
      local first = true
      for k, v in pairs(self) do
        local key_str = dumpTable(k, depth - 1, true)
        local value_str = dumpTable(v, depth - 1)
        if first then
          table.insert(pieces, key_str .. "=" .. value_str)
          first = false
        else
          table.insert(pieces, ", " .. key_str .. "=" .. value_str)
        end
      end
      if as_key then
        return "[{" .. table.concat(pieces) .. "}]"
      else
        return "{" .. table.concat(pieces) .. "}"
      end
    elseif "string" == self_type then
      if as_key then
        return self
      else
        return "\"" .. self .. "\""
      end
    elseif "userdata" == self_type then
      if as_key then
        return "[" .. "[#userdata#]" .. "]"
      else
        return "[#userdata#]"
      end
    elseif as_key then
      return "[" .. tostring(self) .. "]"
    else
      do return tostring end
      return tostring, self, "]", table.concat(pieces), "}", pairs(self)
    end
  end
  
  local function getKeyArray(self, maxKeys)
    local keyArray = {}
    local hasMoreKey = false
    for k, v in pairs(self) do
      if maxKeys <= #keyArray then
        hasMoreKey = true
        break
      end
      local keyType = type(k)
      local keyStr = k
      if "userdata" == keyType or "function" == keyType or "table" == keyType or "thread" == keyType then
        keyStr = "[#" .. keyType .. "#]"
      elseif "string" == keyType then
        keyStr = "'" .. k .. "'"
      else
        keyStr = tostring(k)
      end
      if 1 ~= string.find(keyStr, "__") then
        table.insert(keyArray, {k, keyStr})
      end
    end
    return keyArray, hasMoreKey
  end
  
  local function sonic_dumpTable(node, depth, maxKeys)
    depth = depth or 3
    maxKeys = maxKeys or 10
    local stack, output = {}, {}
    local nodeKeyArray, nodeHasMoreKey = getKeyArray(node, maxKeys)
    table.insert(stack, {
      origin = node,
      keyArray = nodeKeyArray,
      curIndex = 1,
      curDepth = 1,
      hasMoreKey = nodeHasMoreKey
    })
    while #stack > 0 do
      local curNode = table.remove(stack)
      local keyArray = curNode.keyArray
      local curTable = curNode.origin
      local curStartIndex = curNode.curIndex
      local hasEnterLoop = false
      for i = curStartIndex, #keyArray do
        hasEnterLoop = true
        if 1 == i then
          table.insert(output, "{")
        else
          table.insert(output, ", ")
        end
        local curkey = keyArray[i][1]
        local curKeyStr = keyArray[i][2]
        curNode.curIndex = i + 1
        table.insert(output, "[" .. curKeyStr .. "]")
        table.insert(output, " = ")
        local curValue = curTable[curkey]
        local valueType = type(curValue)
        if "userdata" == valueType or "function" == valueType or "thread" == valueType then
          table.insert(output, "'[#" .. valueType .. "#]'")
        elseif "string" == valueType then
          table.insert(output, "'" .. curValue .. "'")
        elseif "table" == valueType and depth >= curNode.curDepth then
          table.insert(stack, curNode)
          local curkeyArray, curHasMoreKey = getKeyArray(curValue, maxKeys)
          table.insert(stack, {
            origin = curValue,
            keyArray = curkeyArray,
            curIndex = 1,
            curDepth = curNode.curDepth + 1,
            hasMoreKey = curHasMoreKey
          })
          break
        elseif "table" == valueType then
          table.insert(output, "'[#" .. valueType .. "#]'")
        else
          table.insert(output, "'" .. tostring(curValue) .. "'")
        end
        if i == #keyArray then
          table.insert(output, curNode.hasMoreKey and " ...}" or "}")
        end
      end
      if not hasEnterLoop then
        if 0 == #keyArray then
          table.insert(output, "{")
        end
        table.insert(output, curNode.hasMoreKey and " ...}" or "}")
      end
    end
    do return table.concat end
    return table.concat, output, curNode.origin, curNode.curIndex, true, table.insert, output, curNode.hasMoreKey and " ...}" or "}", nil, keyArray[i][1], keyArray[i][2], curTable[curkey], type(curValue), table.insert, output, curNode.hasMoreKey and " ...}" or "}", tostring(curValue), "'", curNode.curDepth + 1
  end
  
  local function send_specific_print(...)
    local arg = {
      ...
    }
    local msg = ""
    for i, v in ipairs(arg) do
      local argType = type(v)
      if "table" == argType then
        msg = msg .. sonic_dumpTable(v)
      elseif "userdata" == argType then
        msg = msg .. "[#userdata#]"
      else
        msg = msg .. tostring(v)
      end
      if i ~= #arg then
        msg = msg .. " "
      end
    end
    if #msg > 0 then
      table.insert(log_buffer, msg)
    end
  end
  
  local function send_simple_print(...)
    local args = {
      ...
    }
    local printTable = {}
    for k, v in pairs(args) do
      table.insert(printTable, tostring(v))
    end
    local msg = table.concat(printTable, " ")
    if #msg > 0 then
      table.insert(log_buffer, msg)
    end
  end
  
  local function send_print(...)
    if simple_log_lock then
      send_simple_print(...)
      return
    end
    send_specific_print(...)
  end
  
  local function _print(...)
    global.originPrint(...)
    send_print(...)
  end
  
  local function filter(ty, ...)
    local args = table.pack(...)
    local filter = {}
    table.insert(filter, "LogLevel-" .. ty .. ": ")
    for i, v in ipairs(args) do
      if type(v) == "string" then
        table.insert(filter, v)
      end
    end
    return filter
  end
  
  local function overwrite(project)
    local function recoverOverwrite()
    end
    
    if nil == project then
      global.originPrint = print
      print = _print
      
      function recoverOverwrite()
        print = global.originPrint
      end
    elseif "m5" == project then
      local Log = require("Framework.Log.Log")
      local old_info_page = Log.InfoPage
      local old_info = Log.Info
      local old_error = Log.Error
      local old_error_page = Log.ErrorPage
      local old_warning = Log.Warning
      local old_warning_page = Log.WarningPage
      
      function Log.InfoPage(...)
        old_info_page(...)
        send_print(table.unpack(filter("info", ...)))
      end
      
      function Log.Info(...)
        old_info(...)
        send_print(table.unpack(filter("info", ...)))
      end
      
      function Log.Error(...)
        old_error(...)
        send_print(table.unpack(filter("error", ...)))
      end
      
      function Log.ErrorPage(...)
        old_error_page(...)
        send_print(table.unpack(filter("error", ...)))
      end
      
      function Log.WarningPage(...)
        old_warning_page(...)
        send_print(table.unpack(filter("warning", ...)))
      end
      
      function Log.Warning(...)
        old_warning(...)
        send_print(table.unpack(filter("warning", ...)))
      end
      
      function recoverOverwrite()
        Log.InfoPage = old_info_page
        Log.Info = old_info
        Log.Error = old_error
        Log.ErrorPage = old_error_page
        Log.Warning = old_warning
        Log.WarningPage = old_warning_page
      end
    elseif "q6" == project then
      local old_print = print
      
      function print(...)
        old_print(...)
        send_print(...)
      end
      
      local print_r = require("Utils.print_r")
      local old_Rprint, up = getTargetUpvalue(print_r, "print")
      if nil ~= old_Rprint and old_Rprint ~= print then
        local function new_Rprint(...)
          old_Rprint(...)
          
          send_print(...)
        end
        
        debug.setupvalue(print_r, up, new_Rprint)
      end
      
      function recoverOverwrite()
        if nil ~= old_Rprint and old_Rprint ~= print then
          debug.setupvalue(print_r, up, old_Rprint)
        end
        print = old_print
      end
    elseif "m1" == project or "m2" == project or "m1p" == project then
      local old_print = print
      
      function print(...)
        old_print(...)
        send_print(...)
      end
      
      local old_outputConsole = outputConsole
      
      function outputConsole(...)
        if old_outputConsole then
          old_outputConsole(...)
        end
        send_print(...)
      end
      
      local old_log = row_log
      
      function row_log(...)
        old_log(...)
        send_print(...)
      end
      
      local global = require("global")
      local origin_err_handler = global.err_handler
      
      local function new_err_handler(...)
        local prev_simple_log_lock = simple_log_lock
        simple_log_lock = false
        local return_table = {
          origin_err_handler(...)
        }
        simple_log_lock = prev_simple_log_lock
        do return table.unpack end
        return table.unpack, return_table
      end
      
      global.err_handler = new_err_handler
      
      function recoverOverwrite()
        print = old_print
        outputConsole = old_outputConsole
        row_log = old_log
        global.err_handler = origin_err_handler
      end
      
      M.setSimpleLogOn()
    else
      local old_print = print
      
      function print(...)
        old_print(...)
        send_print(...)
      end
      
      function recoverOverwrite()
        print = old_print
      end
    end
    return recoverOverwrite
  end
  
  local function readLogFile(filename)
    log_file = io.open(filename, "r")
    if log_file then
      local file_size = log_file:seek("end")
      local last_chunk_size = 20480
      if file_size > last_chunk_size then
        log_file:seek("set", file_size - last_chunk_size)
      end
      log_reader = log_file:lines()
    end
  end
  
  local function _shouldSendLog(delta_time)
    tick_time = tick_time + delta_time
    if tick_time > tick_time_interval then
      tick_time = 0
      return true
    end
    return false
  end
  
  local function reloadSendBuffer()
    local max_buffer_size = 32768
    local half_buffer_size = max_buffer_size / 2
    local line
    if 0 == #log_buffer then
      return
    end
    while half_buffer_size > 0 and #log_buffer > 0 do
      line = table.remove(log_buffer, 1)
      table.insert(send_buffer, line)
      half_buffer_size = half_buffer_size - #line
      max_buffer_size = max_buffer_size - #line
    end
    if max_buffer_size < 0 then
      local prefix = line:sub(1, max_buffer_size)
      local postfix = line:sub(max_buffer_size)
      send_buffer[#send_buffer] = prefix
      table.insert(log_buffer, 1, postfix)
    end
  end
  
  local function _do_init(conf)
    local function init_cb()
    end
    
    if not conf or conf.approach == "overwrite" then
      init_cb = overwrite(conf.project)
      is_init_done = true
      return init_cb
    end
    if conf.approach == "file" and conf.filename then
      readLogFile(conf.filename)
      is_init_done = true
      
      function init_cb()
        if log_reader then
          log_reader:close()
        end
      end
      
      return init_cb
    end
    print("LuaBoomer LogViewModule init error: ", conf)
  end
  
  function M.init(conf)
    if not init_conf then
      init_conf = conf
    end
    if not conf.switch then
      return
    end
  end
  
  function M.update(delta_time)
    if not is_init_done and is_on then
      _do_init_recover = _do_init(init_conf)
    end
    if is_init_done and not is_on and nil ~= _do_init_recover then
      _do_init_recover()
      _do_init_recover = nil
      is_init_done = false
    end
  end
  
  function M.updateEveryFrame(delta_time)
    if not _shouldSendLog(delta_time) then
      return
    end
    while is_on and log_reader and #log_buffer < 100 do
      local content = log_reader()
      if not content or 0 == #content then
        break
      end
      table.insert(log_buffer, content)
    end
    reloadSendBuffer()
    if #send_buffer >= 1 then
      network_core.requestMsg(module_handler, send_buffer)
      send_buffer = {}
    end
  end
  
  function M.executeCommand(data)
    local command = data.command
    local fun = M[command]
    if fun then
      local ok, err = pcall(fun, data)
      if not ok then
        print("executeCommand error: " .. err)
      end
    else
      print("executeCommand command not exists: " .. command)
    end
  end
  
  function M.onReceive(msg)
    local data = msg.data
    local type = data.type
    if "command" == type then
      M.executeCommand(data)
    end
  end
  
  function M.turnOn()
    is_on = true
  end
  
  function M.turnOff()
    is_on = false
  end
  
  function M.setSimpleLogOn()
    simple_log_lock = true
  end
  
  function M.setSimpleLogOff()
    simple_log_lock = false
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.HookModule", function(require)
  local logger = require("LuaBoomer.Util.Logger")
  local M = {}
  
  local function dispatchFunc(info, hooks)
    local target = hooks[info.name]
    if not target then
      return nil
    end
    local fileName = info.source
    if fileName == target.fileName then
      return target.func, target.argumentIndex
    end
    return nil
  end
  
  function M:new(obj)
    obj = obj or {
      hooks = {},
      hookCount = 0
    }
    self.__index = self
    do return setmetatable, obj end
    return setmetatable, obj, self
  end
  
  function M:Instance()
    if self.instance == nil then
      self.instance = self:new()
    end
    return self.instance
  end
  
  function M:AddHook(targetFileName, targetFuncName, hookFunc, targetArgumentIndex)
    print("adding hook:", targetFuncName)
    self.instance.hooks[targetFuncName] = {
      fileName = targetFileName,
      func = hookFunc,
      argumentIndex = targetArgumentIndex
    }
    self:_refreshCount()
  end
  
  function M:_refreshCount()
    local count = 0
    for _, __ in pairs(self.instance.hooks) do
      count = count + 1
    end
    self.instance.hookCount = count
  end
  
  function M:SetHooks()
    local function hookFuncEnter()
      local info = debug.getinfo(2, "Sun")
      
      local func, argumentIndex = dispatchFunc(info, self.instance.hooks)
      if func then
        local _, value = debug.getlocal(2, argumentIndex or 1)
        if not value then
          print("got nil value: ", info.name)
          return
        end
        func(value)
      end
    end
    
    if 0 == self.instance.hookCount then
      logger.info("found no hooks")
      return
    end
    debug.sethook(hookFuncEnter, "c")
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoCollectorModule", function(require)
  local M = {}
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local hook_core = require("LuaBoomer.LocalModule.HookModule")
  local module_handler = "ProtoCollectorModule"
  local hookModule = hook_core:Instance()
  local proto_buffer = {}
  local one_proto = {}
  
  function M.getReceiveProto(protoPath, protoBinPath)
    local sproto = require(protoPath)
    local proto_bin = global.LoadBinaryFileToString(protoBinPath)
    local sobj = sproto.new(proto_bin)
    local obj = sobj:host("base.pack")
    local mt = debug.getmetatable(obj)
    local ori_dispatch = mt.__index.dispatch
    
    function mt.__index.dispatch(...)
      local type, v1, v2, v3, v4 = ori_dispatch(...)
      if "RESPONSE" == type then
        local msg = {
          sessionId = v1,
          data = v2,
          type = "receive"
        }
        table.insert(proto_buffer, msg)
      end
      return type, v1, v2, v3, v4
    end
  end
  
  function M.getSendProto()
    local function func(value)
      if value.session then
        one_proto.session = value.session
        
        one_proto.type = "send"
        one_proto.protoType = value.type
      else
        one_proto.data = value
        table.insert(proto_buffer, one_proto)
        one_proto = {}
      end
    end
    
    hookModule:AddHook("=[C]", "encode", func, 2)
  end
  
  function M.init(conf)
    local _conf = conf or {}
    if _conf.protoPath and _conf.protoBinPath then
      M.getReceiveProto(_conf.protoPath, _conf.protoBinPath)
      M.getSendProto()
    end
  end
  
  function M.onReceive(msg)
  end
  
  function M.update(delta_time)
    if #proto_buffer > 1 then
      network_core.requestMsg(module_handler, proto_buffer)
      proto_buffer = {}
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProfileModule", function(require)
  local M = {}
  local CMD = {}
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local module_handler = "ProfileModule"
  local timeUtil = require("LuaBoomer.Util.TimeUtil")
  local mark_task_id
  
  function M.startTask(taskId)
    mark_task_id = taskId
  end
  
  local extra_data
  local is_profile = false
  local data_list = {}
  local _getProfile, _duration, _ori_duration, _profileConf, _onChangeConfig
  
  function M.setProfile(flag)
    is_profile = flag
  end
  
  function M.init(conf)
    local _conf = conf or {}
    _getProfile = _conf.engineProfileFunc
    _duration = _conf.duration
    _ori_duration = _conf.duration
    _profileConf = _conf.profileConf
    _onChangeConfig = _conf.onChangeConfig
  end
  
  function M.atSwitch(state, data)
    if nil ~= _onChangeConfig then
      local oldConfig = JsonUtil.decode(JsonUtil.encode(_profileConf))
      _profileConf.state = state
      _onChangeConfig(oldConfig, _profileConf)
    else
      _profileConf.state = state
    end
    extra_data = data
  end
  
  function M.setExtraData(data)
    extra_data = data
  end
  
  function CMD.setConfig(config_string)
    local oldConfig = JsonUtil.decode(JsonUtil.encode(_profileConf))
    local newConfig = JsonUtil.decode(config_string)
    for key, value in pairs(newConfig) do
      _profileConf[key] = newConfig[key]
    end
    if nil ~= _onChangeConfig then
      _onChangeConfig(oldConfig, _profileConf)
    end
    if 1 == _profileConf.profile then
      is_profile = true
    else
      is_profile = false
    end
  end
  
  function M.onReceive(msg)
    local data = msg.data
    local command = data.command
    local command_data = data.command_data
    if command then
      local f = CMD[command]
      f(command_data)
    end
  end
  
  function M.updateEveryFrame(delta_time)
    if not _getProfile then
      return
    end
    if not is_profile then
      return
    end
    local data = _getProfile(_profileConf, extra_data)
    data.extra_data = extra_data
    table.insert(data_list, data)
  end
  
  local function average(data_list)
    local result = 0
    for i, v in ipairs(data_list) do
      result = result + v
    end
    return result * 1.0 / #data_list
  end
  
  local function mergeData(perfData, statPerfMap)
    for k, v in pairs(perfData) do
      if type(v) == "table" then
        local innerMap = {}
        if not statPerfMap[k] then
          statPerfMap[k] = innerMap
        end
        for metric, value in pairs(v) do
          if not innerMap[metric] then
            innerMap[metric] = {}
          end
          table.insert(innerMap[metric], value)
        end
      else
        if not statPerfMap[k] then
          statPerfMap[k] = {
            type = "simple",
            list = {}
          }
        end
        table.insert(statPerfMap[k].list, v)
      end
    end
  end
  
  local function calAverage(statPerfMap)
    for k, v in pairs(statPerfMap) do
      if type(v) == "table" and not v.type then
        for metric, value in pairs(v) do
          v[metric] = average(value)
        end
      else
        statPerfMap[k] = average(statPerfMap[k].list)
      end
    end
  end
  
  local function mergeSend(data_list, extra_data, mark_task_id)
    local r_data = {}
    local dataArray = {}
    local dataObject = {}
    local statPerfMap = {}
    for i, v in ipairs(data_list) do
      local oneData = data_list[i]
      if 1 == i then
        dataObject = oneData.data[1]
      end
      local perfData = oneData.data[1].performanceData
      mergeData(perfData, statPerfMap)
    end
    calAverage(statPerfMap)
    dataObject.performanceData = statPerfMap
    table.insert(dataArray, dataObject)
    r_data.data = dataArray
    r_data.extra_data = extra_data
    r_data.task_id = mark_task_id
    network_core.requestMsg(module_handler, r_data)
    return r_data
  end
  
  local step_limit = 120
  
  function M.update(delta_time)
    if not _getProfile then
      return
    end
    if is_profile then
      local tmp_list = {}
      local step_count = 0
      for i = 1, #data_list do
        local data = data_list[i]
        table.insert(tmp_list, data)
        if step_count > step_limit then
          mergeSend(tmp_list, extra_data, mark_task_id)
          step_count = 0
          tmp_list = {}
        else
          step_count = step_count + 1
        end
      end
      if #tmp_list > 0 then
        mergeSend(tmp_list, extra_data, mark_task_id)
      end
      data_list = {}
    else
      _duration = _duration - delta_time
      if _duration <= 0 then
        local data = _getProfile(_profileConf, extra_data)
        data.extra_data = extra_data
        if mark_task_id then
          data.task_id = mark_task_id
        end
        network_core.requestMsg(module_handler, data)
        _duration = _ori_duration
      end
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.DataForwardModule", function(require)
  local M = {}
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local module_handler = "DataForwardModule"
  local data_buf = {}
  
  function M.init()
  end
  
  function M.addData(data)
    table.insert(data_buf, data)
  end
  
  function M.update(delta_time)
    if #data_buf >= 1 then
      network_core.requestMsg(module_handler, {forward = data_buf})
      data_buf = {}
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.NetProfileModule", function(require)
  local M = {}
  local profile
  local CMD = {}
  local profile_core
  local logger = require("LuaBoomer.Util.Logger")
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local module_handler = "NetProfileModule"
  local func_get_fps, init_params, log_path, bool_profile_optick
  local to_upload_files = {}
  local profile_types = {
    "luaprofile_flame_graph_data.txt"
  }
  local max_block_size = 32768
  local old_frame = 0
  local new_frame = 0
  local old_time = 0
  local new_time = 0
  local show_time = 2
  local StringUtil = require("LuaBoomer.Util.StringUtil")
  local logger = require("LuaBoomer.Util.Logger")
  
  local function _statFps(delta_time)
    new_frame = new_frame + 1
    new_time = new_time + delta_time
    local pass_time = new_time - old_time
    if pass_time > show_time then
      local frame = new_frame - old_frame
      local time = new_time - old_time
      local fps = frame / time
      old_frame = new_frame
      old_time = new_time
      if profile_core.setFps ~= nil then
        profile_core.setFps(fps)
      end
    end
  end
  
  function M.updateEveryFrame(delta_time)
    if nil == profile then
      return
    end
    if "true" == bool_profile_optick and nil ~= profile_core.optickNextFrame then
      profile_core.optickNextFrame()
    end
    if nil == func_get_fps then
      _statFps(delta_time)
    end
  end
  
  local function _fixLogPath()
    if nil == log_path then
      return false
    end
    if "" == log_path then
      log_path = "./"
    end
    if not StringUtil.endWiths(log_path, "/") or not StringUtil.endWiths(log_path, "\\") then
      if string.find(log_path, "/") then
        log_path = log_path .. "/"
      end
      if string.find(log_path, "\\") then
        log_path = log_path .. "\\"
      end
    end
  end
  
  local function _upload()
    if "true" == bool_profile_optick then
      return false
    end
    if nil == log_path then
      return false
    end
    for key, value in ipairs(profile_types) do
      if nil == to_upload_files[key] then
        local file_info = {}
        local upload_file = log_path .. value
        file_info.filename = upload_file
        local file_handler = io.open(upload_file, "r")
        if nil ~= file_handler then
          file_info.file_handler = file_handler
          file_info.is_end = false
          file_info.start_time = os.time()
          to_upload_files[key] = file_info
        end
      end
    end
  end
  
  local function _reportStatus(status)
    local data = {
      msg = "ProfileStatus",
      status = status,
      init_params = init_params
    }
    network_core.requestMsg(module_handler, data)
  end
  
  local function _stopUpload()
    if "true" == bool_profile_optick then
      return false
    end
    if nil == log_path then
      return false
    end
    for key, value in ipairs(profile_types) do
      if nil ~= to_upload_files[key] then
        to_upload_files[key].is_end = true
      end
    end
  end
  
  function CMD.start_profile(sid)
    local status = profile.status()
    if 1 ~= status then
      profile.init(init_params)
      profile.start()
      status = profile.status()
      logger.info("[NetProfileModule] start_profile ok, current status is ", status)
      _upload()
    end
    _reportStatus(status)
  end
  
  function CMD.stop_optick(sid)
    init_params = string.gsub(init_params, "bool_profile_optick=true", "bool_profile_optick=false")
    bool_profile_optick = "false"
    CMD.stop_profile(sid)
    local status = profile.status()
    _reportStatus(status)
  end
  
  function CMD.start_optick(sid)
    init_params = string.gsub(init_params, "bool_profile_optick=false", "bool_profile_optick=true")
    bool_profile_optick = "true"
    CMD.stop_profile(sid)
    CMD.start_profile(sid)
    local status = profile.status()
    _reportStatus(status)
  end
  
  function CMD.stop_profile(sid)
    local status = profile.status()
    if 1 == status then
      profile.stop(20)
      profile.destory()
      status = profile.status()
      logger.info("[NetProfileModule] stop_profile ok, current status is ", status)
      _stopUpload()
    end
    _reportStatus(status)
  end
  
  function CMD.status_profile(sid)
    if nil == profile then
      return
    end
    local status = profile.status()
    _reportStatus(status)
  end
  
  local function loadLuaProfileCLib()
    do return require end
    return require, "LuaProfile"
  end
  
  function M.init(conf)
    if conf.params == nil or nil == conf.profile_lua_path then
      return
    end
    func_get_fps = conf.func_get_fps
    local code_success = false
    local result
    code_success, result = pcall(loadLuaProfileCLib)
    if code_success then
      profile_core = result
    end
    if nil == profile_core then
      logger.warn("LuaProfile c library not found")
      return
    end
    init_params = conf.params
    profile = require(conf.profile_lua_path)
    local sps = StringUtil.split(init_params, "&")
    for k, v in ipairs(sps) do
      local sub_sps = StringUtil.split(v, "=")
      if 2 == #sub_sps and "log_path" == sub_sps[1] then
        log_path = sub_sps[2]
      end
      if 2 == #sub_sps and "bool_profile_optick" == sub_sps[1] then
        bool_profile_optick = sub_sps[2]
      end
    end
    _fixLogPath()
    if nil ~= bool_profile_optick and "true" == bool_profile_optick then
      CMD.start_profile()
    end
  end
  
  function M.onReceive(msg)
    local data = msg.data
    local command = data.command
    local session_id = data.session_id
    if command and session_id then
      local f = CMD[command]
      f(session_id)
    end
  end
  
  local function _doUpload()
    if "true" == bool_profile_optick then
      return false
    end
    if nil == log_path then
      return false
    end
    for key, value in ipairs(to_upload_files) do
      local file_info = value
      local file_handler = file_info.file_handler
      local content = file_handler:read("*a")
      if content then
        local block_total_count = math.ceil(#content / max_block_size)
        for index = 1, block_total_count do
          local block = string.sub(content, (index - 1) * max_block_size + 1, index * max_block_size)
          local data = {
            msg = "ProfileFileUpload",
            filename = file_info.filename,
            start_time = file_info.start_time,
            is_end = file_info.is_end,
            append_data = block
          }
          network_core.requestMsg(module_handler, data)
        end
      end
      if value.is_end then
        to_upload_files[key] = nil
      end
    end
    return true
  end
  
  local report_status_count_time = 0
  local report_status_interval_time = 3
  
  function M.update(delta_time)
    if nil == profile then
      return
    end
    if func_get_fps then
      local success, fps = pcall(func_get_fps)
      if success and nil ~= profile_core and nil ~= profile_core.setFps then
        profile_core.setFps(fps)
      end
    end
    _doUpload()
    report_status_count_time = report_status_count_time + delta_time
    if report_status_count_time > report_status_interval_time then
      CMD.status_profile()
      report_status_count_time = 0
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.GMModule", function(require)
  local M = {}
  local gm_impl
  local logger = require("LuaBoomer.Util.Logger")
  
  function M.onReceive(msg)
    logger.info("recv gm: " .. msg.data.cmd)
    if gm_impl then
      gm_impl(msg)
    else
      logger.warn("gm协议实现函数未赋值, 无法执行gm指令:" .. msg.data.cmd)
    end
  end
  
  function M.init(conf)
    gm_impl = conf.gm_impl
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.EventModule", function(require)
  local M = {}
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local module_handler = "EventModule"
  local project = ""
  
  function M.init(conf)
    project = conf.project
  end
  
  function M.onLoginSuccess()
    network_core.requestMsg(module_handler, {
      event = "login_success",
      project = project
    })
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.Util.Json4lua", function(require)
  local json = {}
  do
    local math, string, table = require("math"), require("string"), require("table")
    local math_floor, math_max, math_type = math.floor, math.max, math.type or function()
    end
    local string_char, string_sub, string_find, string_match, string_gsub, string_format = string.char, string.sub, string.find, string.match, string.gsub, string.format
    local table_insert, table_remove, table_concat = table.insert, table.remove, table.concat
    local type, tostring, pairs, assert, error = type, tostring, pairs, assert, _ENV.error
    local loadstring = loadstring or load
    local null = {
      "This Lua table is used to designate JSON null value, compare your values with json.null to determine JSON nulls"
    }
    json.null = setmetatable(null, {
      __tostring = function()
        return "null"
      end
    })
    local empty = {}
    json.empty = setmetatable(empty, {
      __tostring = function()
        return "{}"
      end,
      __newindex = function()
        error("json.empty is an read-only Lua table", 2)
      end
    })
    local decode, decode_scanArray, decode_scanConstant, decode_scanNumber, decode_scanObject, decode_scanString, decode_scanIdentifier, decode_scanWhitespace, encodeString, isArray, isEncodable, isConvertibleToString, isRegularNumber
    
    function json.encode(obj)
      if nil == obj or obj == null then
        return "null"
      end
      if obj == empty then
        return "{}"
      end
      local obj_type = type(obj)
      if "string" == obj_type then
        return "\"" .. encodeString(obj) .. "\""
      end
      if "boolean" == obj_type then
        do return tostring end
        return tostring, obj, "\"", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
      end
      if "number" == obj_type then
        assert(isRegularNumber(obj), "numeric values Inf and NaN are unsupported")
        return "integer" == math_type(obj) and tostring(obj) or string_format("%.17g", obj)
      end
      if "table" == obj_type then
        local rval = {}
        local bArray, maxCount = isArray(obj)
        if bArray then
          for i = nil ~= obj[0] and 0 or 1, maxCount do
            table_insert(rval, json.encode(obj[i]))
          end
        else
          for i, j in pairs(obj) do
            if isConvertibleToString(i) and isEncodable(j) then
              table_insert(rval, "\"" .. encodeString(i) .. "\":" .. json.encode(j))
            end
          end
        end
        if bArray then
          return "[" .. table_concat(rval, ",") .. "]"
        else
          return "{" .. table_concat(rval, ",") .. "}"
        end
      end
      error("Unable to JSON-encode Lua value of unsupported type \"" .. obj_type .. "\": " .. tostring(obj))
    end
    
    local function create_state(s)
      local state = {disp = 0}
      if "string" == type(s) then
        state.part = s
      else
        state.part = ""
        state.more = s
      end
      return state
    end
    
    function json.decode(s, pos)
      return (decode(create_state(s), pos or 1))
    end
    
    function json.traverse(s, callback, pos)
      decode(create_state(s), pos or 1, {
        path = {},
        callback = callback
      })
    end
    
    local function read_ahead(state, startPos)
      local endPos = startPos + 31
      local part = state.part
      local disp = state.disp
      local more = state.more
      assert(startPos > disp)
      while more and endPos > disp + #part do
        local next_substr = more()
        if not next_substr or "" == next_substr then
          more = nil
        else
          disp, part = disp + #part, string_sub(part, startPos - disp)
          disp, part = disp - #part, part .. next_substr
        end
      end
      state.disp, state.part, state.more = disp, part, more
    end
    
    local function get_word(state, startPos, length)
      if state.more then
        read_ahead(state, startPos)
      end
      local idx = startPos - state.disp
      do return string_sub, state.part, idx end
      return string_sub, state.part, idx, idx + length - 1
    end
    
    local function skip_until_word(state, startPos, word)
      repeat
        if state.more then
          read_ahead(state, startPos)
        end
        local part, disp = state.part, state.disp
        local b, e = string_find(part, word, startPos - disp, true)
        if b then
          return disp + e + 1
        end
        startPos = disp + #part + 2 - #word
      until not state.more
    end
    
    local function match_with_pattern(state, startPos, pattern, operation)
      if "read" == operation then
        local t = {}
        repeat
          if state.more then
            read_ahead(state, startPos)
          end
          local part, disp = state.part, state.disp
          local str = string_match(part, pattern, startPos - disp)
          if str then
            table_insert(t, str)
            startPos = startPos + #str
          end
        until not str or startPos <= disp + #part
        return table_concat(t), startPos
      elseif "skip" == operation then
        repeat
          if state.more then
            read_ahead(state, startPos)
          end
          local part, disp = state.part, state.disp
          local b, e = string_find(part, pattern, startPos - disp)
          if b then
            startPos = startPos + e - b + 1
          end
        until not b or startPos <= disp + #part
        return startPos
      else
        error("Wrong operation name")
      end
    end
    
    function decode(state, startPos, traverse, decode_key)
      local curChar, value, nextPos
      startPos, curChar = decode_scanWhitespace(state, startPos)
      if "{" == curChar and not decode_key then
        if traverse and traverse.callback(traverse.path, "object", nil, startPos, nil) then
          local object, endPos = decode_scanObject(state, startPos)
          traverse.callback(traverse.path, "object", object, startPos, endPos - 1)
          return false, endPos
        end
        do return decode_scanObject, state, startPos end
        return decode_scanObject, state, startPos, traverse, "object", object, startPos, endPos - 1
      elseif "[" == curChar and not decode_key then
        if traverse and traverse.callback(traverse.path, "array", nil, startPos, nil) then
          local array, endPos = decode_scanArray(state, startPos)
          traverse.callback(traverse.path, "array", array, startPos, endPos - 1)
          return false, endPos
        end
        do return decode_scanArray, state, startPos end
        return decode_scanArray, state, startPos, traverse, "array", array, startPos, endPos - 1
      elseif "\"" == curChar then
        value, nextPos = decode_scanString(state, startPos)
        if traverse then
          traverse.callback(traverse.path, "string", value, startPos, nextPos - 1)
        end
      elseif decode_key then
        do return decode_scanIdentifier, state end
        return decode_scanIdentifier, state, startPos, value, startPos, nextPos - 1, startPos, endPos - 1
      elseif string_find(curChar, "^[%d%-]") then
        value, nextPos = decode_scanNumber(state, startPos)
        if traverse then
          traverse.callback(traverse.path, "number", value, startPos, nextPos - 1)
        end
      else
        value, nextPos = decode_scanConstant(state, startPos)
        if traverse then
          traverse.callback(traverse.path, value == null and "null" or "boolean", value, startPos, nextPos - 1)
        end
      end
      return value, nextPos
    end
    
    function decode_scanArray(state, startPos, traverse)
      local array = not traverse and {}
      local elem_index, elem_ready, object = 1
      startPos = startPos + 1
      while true do
        do
          local curChar
          startPos, curChar = decode_scanWhitespace(state, startPos)
          if "]" == curChar then
            return array, startPos + 1
          elseif "," == curChar then
            if not elem_ready then
              if traverse then
                table_insert(traverse.path, elem_index)
                traverse.callback(traverse.path, "null", null, startPos, startPos - 1)
                table_remove(traverse.path)
              else
                array[elem_index] = null
              end
            end
            elem_ready = false
            elem_index = elem_index + 1
            startPos = startPos + 1
          end
        end
        if "," ~= curChar then
          if elem_ready then
            error("Comma is missing in JSON array at position " .. startPos)
          end
          if traverse then
            table_insert(traverse.path, elem_index)
          end
          object, startPos = decode(state, startPos, traverse)
          if traverse then
            table_remove(traverse.path)
          else
            array[elem_index] = object
          end
          elem_ready = true
        end
      end
    end
    
    function decode_scanConstant(state, startPos)
      local w5 = get_word(state, startPos, 5)
      local w4 = string_sub(w5, 1, 4)
      if "false" == w5 then
        return false, startPos + 5
      elseif "true" == w4 then
        return true, startPos + 4
      elseif "null" == w4 then
        return null, startPos + 4
      end
      error("Failed to parse JSON at position " .. startPos)
    end
    
    function decode_scanNumber(state, startPos)
      local stringValue, endPos = match_with_pattern(state, startPos, "^[%+%-%d%.eE]+", "read")
      local stringEval = loadstring("return " .. stringValue)
      if not stringEval then
        error("Failed to scan number " .. stringValue .. " in JSON string at position " .. startPos)
      end
      return stringEval(), endPos
    end
    
    function decode_scanObject(state, startPos, traverse)
      local object, elem_ready = not traverse and empty
      startPos = startPos + 1
      while true do
        do
          local curChar
          startPos, curChar = decode_scanWhitespace(state, startPos)
          if "}" == curChar then
            return object, startPos + 1
          elseif "," == curChar then
            startPos = startPos + 1
            elem_ready = false
          end
        end
        if "," ~= curChar then
          if elem_ready then
            error("Comma is missing in JSON object at " .. startPos)
          end
          local key, value
          key, startPos = decode(state, startPos, nil, true)
          local colon
          startPos, colon = decode_scanWhitespace(state, startPos)
          if ":" ~= colon then
            error("JSON object key-value assignment mal-formed at " .. startPos)
          end
          startPos = decode_scanWhitespace(state, startPos + 1)
          if traverse then
            table_insert(traverse.path, key)
          end
          value, startPos = decode(state, startPos, traverse)
          if traverse then
            table_remove(traverse.path)
          else
            if object == empty then
              object = {}
            end
            object[key] = value
          end
          elem_ready = true
        end
      end
    end
    
    function decode_scanIdentifier(state, startPos)
      local identifier, idx = match_with_pattern(state, startPos, "^[%w_%-%$]+", "read")
      if "" == identifier then
        error("JSON String decoding failed: missing key name at position " .. startPos)
      end
      return identifier, idx
    end
    
    local escapeSequences = {
      t = "\t",
      f = "\f",
      r = "\r",
      n = "\n",
      b = "\b"
    }
    
    function decode_scanString(state, startPos)
      local t, idx, surrogate_pair_started, regular_part = {}, startPos + 1
      while true do
        regular_part, idx = match_with_pattern(state, idx, "^[^\"\\]+", "read")
        table_insert(t, regular_part)
        local w6 = get_word(state, idx, 6)
        local c = string_sub(w6, 1, 1)
        if "\"" == c then
          return table_concat(t), idx + 1
        elseif "\\" == c then
          local esc = string_sub(w6, 2, 2)
          if "u" == esc then
            local n = tonumber(string_sub(w6, 3), 16)
            if not n then
              error("String decoding failed: bad Unicode escape " .. w6 .. " at position " .. idx)
            end
            if n >= 55296 and n < 56320 then
              surrogate_pair_started, n = n
            elseif n >= 56320 and n < 57344 then
              n, surrogate_pair_started = surrogate_pair_started and (surrogate_pair_started - 55296) * 1024 + (n - 56320) + 65536
            end
            if n then
              local x
              if n < 128 then
                x = string_char(n % 128)
              elseif n < 2048 then
                x = string_char(192 + math_floor(n / 64) % 32, 128 + n % 64)
              elseif n < 65536 then
                x = string_char(224 + math_floor(n / 64 / 64) % 16, 128 + math_floor(n / 64) % 64, 128 + n % 64)
              else
                x = string_char(240 + math_floor(n / 64 / 64 / 64) % 8, 128 + math_floor(n / 64 / 64) % 64, 128 + math_floor(n / 64) % 64, 128 + n % 64)
              end
              table_insert(t, x)
            end
            idx = idx + 6
          else
            table_insert(t, escapeSequences[esc] or esc)
            idx = idx + 2
          end
        else
          error("String decoding failed: missing closing \" for string at position " .. startPos)
        end
      end
    end
    
    function decode_scanWhitespace(state, startPos)
      while true do
        startPos = match_with_pattern(state, startPos, "^[ \n\r\t]+", "skip")
        local w2 = get_word(state, startPos, 2)
        if "/*" == w2 then
          local endPos = skip_until_word(state, startPos + 2, "*/")
          if not endPos then
            error("Unterminated comment in JSON string at " .. startPos)
          end
          startPos = endPos
        else
          local next_char = string_sub(w2, 1, 1)
          if "" == next_char then
            error("Unexpected end of JSON")
          end
          return startPos, next_char
        end
      end
    end
    
    local escapeList = {
      ["\""] = "\\\"",
      ["\\"] = "\\\\",
      ["/"] = "\\/",
      ["\b"] = "\\b",
      ["\f"] = "\\f",
      ["\n"] = "\\n",
      ["\r"] = "\\r",
      ["\t"] = "\\t",
      ["\127"] = "\\u007F"
    }
    
    function encodeString(s)
      if "number" == type(s) then
        s = "integer" == math_type(s) and tostring(s) or string_format("%.f", s)
      end
      do return string_gsub, s, "." end
      return string_gsub, s, ".", function(c)
        return escapeList[c] or c:byte() < 32 and string_format("\\u%04X", c:byte())
      end
    end
    
    function isArray(t)
      local maxIndex = 0
      for k, v in pairs(t) do
        if "number" == type(k) and math_floor(k) == k and k >= 0 and k <= 1000000.0 then
          if not isEncodable(v) then
            return false
          end
          maxIndex = math_max(maxIndex, k)
        elseif ("n" ~= k or v ~= #t) and isConvertibleToString(k) and isEncodable(v) then
          return false
        end
      end
      return true, maxIndex
    end
    
    function isEncodable(o)
      local t = type(o)
      return "string" == t or "boolean" == t or "number" == t and isRegularNumber(o) or "nil" == t or "table" == t
    end
    
    function isConvertibleToString(o)
      local t = type(o)
      return "string" == t or "number" == t and isRegularNumber(o) and ("integer" == math_type(o) or math_floor(o) == o)
    end
    
    local is_Inf_or_NaN = {
      [tostring(1 / 0)] = true,
      [tostring(-1 / 0)] = true,
      [tostring(0 / 0)] = true,
      [tostring(-(0 / 0))] = true
    }
    
    function isRegularNumber(v)
      return not is_Inf_or_NaN[tostring(v)]
    end
  end
  return json
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.S6ProtoTestModuleV2", function(require)
  local TimeUtil = require("LuaBoomer.Util.TimeUtil")
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  local cmsgpack = require("cmsgpack")
  local msg_unpack = cmsgpack.unpack
  local msg_pack = cmsgpack.pack
  local Lz4 = require("lz4")
  local NetworkMgr = require("Network.NetworkMgr")
  local M = {}
  local proto_module
  local override_map = {}
  local init_succ = false
  local protoTest_switch = false
  local intercept_swtich = true
  local alter_switch = true
  local CMD = {}
  local fake_request_session = 0
  local remote_config = {}
  
  local function override_register(table, prop, new, origin)
    local record = {
      table = table,
      prop = prop,
      new = new,
      origin = origin
    }
    override_map[tostring(table) .. prop] = record
    print("override_register", prop, new, origin)
  end
  
  local function override_change(isOrigin)
    for key, value in pairs(override_map) do
      if isOrigin then
        value.table[value.prop] = value.origin
      else
        value.table[value.prop] = value.new
      end
    end
  end
  
  local function s6_msg_encode(msg)
    do return Lz4.compress, msg_pack(msg) end
    return Lz4.compress, msg_pack(msg)
  end
  
  local function s6_msg_decode(msg)
    do return msg_unpack, Lz4.decompress(msg) end
    return msg_unpack, Lz4.decompress(msg)
  end
  
  local send_by_remote = false
  local send_by_remote_index = 0
  local fake_session_id = 0
  local host_port = ""
  
  local function do_init()
    if NetworkMgr.Instance ~= nil then
      local origin_onNetworkHook = globalOnNetworkHook
      
      local function new_onNetworkHook(...)
        print("new_onNetworkHook", ...)
        local hookData = {
          ...
        }
        local hookType = hookData[1]
        if "Connect" == hookType then
          local host, post = hookData[2], hookData[3]
          host_port = host .. ":" .. post
        end
        if "Call" == hookType or "DevCall" == hookType then
          local session_id = hookData[2]
          local cmd = hookData[3]
          local params = hookData[4]
          local req_params = {
            key = params.key,
            args = params.args
          }
          req_params.args = s6_msg_decode(req_params.args)
          if req_params then
            local p_request = {
              target_host = host_port,
              proto_name = req_params.key,
              request = req_params,
              session_id = session_id,
              timestamp = TimeUtil.time(),
              send_by_remote = false
            }
            if proto_module then
              if "DevCall" == hookType then
                p_request.send_by_remote = true
                p_request.send_by_remote_index = sendByRemoteIndex
                send_by_remote = false
              end
              proto_module.addRequest(p_request)
            end
          end
        end
        if "Send" == hookType then
          fake_session_id = fake_session_id - 1
          local session_id = fake_session_id
          local cmd = hookData[2]
          local params = hookData[3]
          local req_params = {
            key = params.key,
            args = params.args
          }
          req_params.args = s6_msg_decode(req_params.args)
          if req_params then
            local p_request = {
              target_host = host_port,
              proto_name = req_params.key,
              request = req_params,
              session_id = session_id,
              timestamp = TimeUtil.time(),
              send_by_remote = false
            }
            if proto_module then
              if send_by_remote then
                p_request.send_by_remote = true
                p_request.send_by_remote_index = sendByRemoteIndex
                send_by_remote = false
              end
              proto_module.addRequest(p_request)
            end
          end
        end
        if "onCallResponse" == hookType or "onDevCallResponse" == hookType then
          local session_id, response = hookData[2], hookData[3]
          local unpackV2 = JsonUtil.clone(response)
          local resp_result
          if nil ~= response and nil ~= response.result then
            resp_result = s6_msg_decode(response.result)
            unpackV2.result = resp_result
          end
          if resp_result then
            local p_response = {
              target_host = host_port,
              response = resp_result,
              session_id = session_id,
              timestamp = TimeUtil.time(),
              origin_dispatch_data = {
                p_type = "RESPONSE",
                v1 = session_id,
                v2 = unpackV2,
                v3 = nil,
                v4 = nil
              }
            }
            if proto_module then
              proto_module.addResponse(p_response)
            end
          end
        end
        if "onRequest" == hookType then
          local name, request = hookData[2], hookData[3]
          local copyRequest
          local unpackV2 = JsonUtil.clone(request)
          if request.args and request.key then
            copyRequest = {
              key = request.key,
              args = request.args
            }
            if type(request.args) == "string" then
              copyRequest.args = s6_msg_decode(copyRequest.args)
              unpackV2.args = copyRequest.args
            end
          end
          if copyRequest then
            local p_notify = {
              target_host = host_port,
              proto_name = request.key,
              request = copyRequest,
              timestamp = TimeUtil.time(),
              origin_dispatch_data = {
                p_type = "REQUEST",
                v1 = name,
                v2 = unpackV2,
                v3 = nil,
                v4 = nil
              }
            }
            if proto_module then
              proto_module.addNotify(p_notify)
            end
          end
        end
        return
      end
      
      override_register(_G, "globalOnNetworkHook", new_onNetworkHook, origin_onNetworkHook)
      init_succ = true
      if true == protoTest_switch then
        override_change(false)
      end
      print("protoTest init seccessful")
    end
  end
  
  function M.init(proto_test_module)
    proto_module = proto_test_module
    local result, msg = pcall(do_init)
    if false == result then
      print("prototest init failed", msg)
    end
  end
  
  function M.is_init_succ()
    return init_succ
  end
  
  function M.getStatus()
    local status = ""
    if protoTest_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if intercept_swtich then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if alter_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    return {status = status, remoteConfig = remote_config}
  end
  
  function M.executeCommand(data)
    local command = data.command
    local exe = CMD[command]
    if nil ~= exe then
      exe(data)
    end
  end
  
  function M.update()
  end
  
  function M.updateEveryFrame()
  end
  
  function CMD.start_protoTest()
    protoTest_switch = true
    override_change(false)
  end
  
  function CMD.stop_protoTest()
    protoTest_switch = false
    override_change(true)
  end
  
  function CMD.start_protoTest_intercept()
    intercept_swtich = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_intercept()
    intercept_swtich = false
    remote_config = {}
  end
  
  function CMD.start_protoTest_alter()
    alter_switch = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_alter()
    alter_switch = false
    remote_config = {}
  end
  
  function CMD.update_protoTest_config(data)
    local remote = data.remoteConfig
    remote_config = remote
    remote_config.rpcIndex = 1
    remote_config.ntfIndex = 1
  end
  
  function M.sendProtoGroup(...)
    local params = {
      ...
    }
    local protoRecordPatch = params[1]
    local respCallBack = params[2]
    local data = params[3]
    
    local function send(protos, i)
      local p = protos[i]
      local originRequestData = p.protoRecord.originRequestData
      local key = p.protoRecord.protoName
      local args = s6_msg_encode(p.protoRecord.protoRequest.args)
      send_by_remote = true
      send_by_remote_index = i
      local ServiceUtils = require("ServiceUtils")
      ServiceUtils.ServiceClients.ServiceNetwork:DevCall("Base.CommonCall", {key = key, args = args})
    end
    
    for k = 1, #protoRecordPatch do
      local ok, result = pcall(send, protoRecordPatch, k)
      if not ok then
        print("sendProtoGroup error: ", k, result)
      end
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.CorProtoMgr", function(require)
  local M = {}
  
  function M.gettime()
    return os.clock() * 1000
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.M1ProtoTestModule", function(require)
  local global = require("global")
  local netevent = require("netevent")
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  local TimeUtil = require("LuaBoomer.Util.TimeUtil")
  local corProtoMgr = require("LuaBoomer.LocalModule.ProtoTest.CorProtoMgr")
  local M = {}
  local init_succ = false
  local proto_module
  local intercept_swtich = true
  local protoTest_switch = false
  local CMD = {}
  local override_map = {}
  local target_session_map = {}
  local delay_map = {}
  local alter_switch = true
  local remote_config = {}
  local coroutine_map = {}
  
  local function getTargetUpvalue(fun, upvalueName)
    local isEnd = false
    local result
    local i = 1
    while not isEnd do
      local name, val = debug.getupvalue(fun, i)
      if nil == name then
        isEnd = true
      end
      if name == upvalueName then
        isEnd = true
        result = val
      else
        i = i + 1
      end
    end
    return result
  end
  
  local function override_register(table, prop, new, origin)
    local record = {
      table = table,
      prop = prop,
      new = new,
      origin = origin
    }
    override_map[tostring(table) .. prop] = record
  end
  
  local function override_change(isOrigin)
    for key, value in pairs(override_map) do
      if isOrigin then
        value.table[value.prop] = value.origin
      else
        value.table[value.prop] = value.new
      end
    end
  end
  
  local send_proto_thread_map = {}
  
  local function corMapUpdate()
    for key, value in pairs(send_proto_thread_map) do
      local trigger = value.trigger
      local requesting = value.requesting
      local thread = value.thread
      if not requesting then
        coroutine.resume(thread, trigger())
      end
    end
  end
  
  local function corMapReset()
    for key, value in pairs(send_proto_thread_map) do
      local requesting = value.requesting
      local thread = value.thread
      local isFinish = value.isFinish
      if isFinish then
        send_proto_thread_map[key] = nil
      end
      if not requesting and not isFinish then
        coroutine.resume(thread, -1)
      end
      send_proto_thread_map[key] = nil
    end
    send_proto_thread_map = {}
    coroutine_map = {}
  end
  
  local function send_proto_cb(session, p_response)
    for key, value in pairs(send_proto_thread_map) do
      local s = value.session
      if s == session and value.requesting then
        local cb = value.cb
        cb()
      end
    end
    local notExistRunning = true
    for key, value in pairs(coroutine_map) do
      if coroutine.status(value) == "running" then
        notExistRunning = false
        break
      end
    end
    if notExistRunning and #coroutine_map > 0 then
      global.login_mgr:request_load_role(true)
      coroutine_map = {}
    end
  end
  
  local host_port
  
  local function do_init()
    if global.sproto_service ~= nil then
      local origin_do_process_msg = global.sproto_service.do_process_msg
      
      local function new_do_process_msg(...)
        local now = corProtoMgr.gettime()
        local params = {
          ...
        }
        local ty = params[1]
        local session = params[2]
        local response = params[3]
        local intercept = false
        local dresult = {
          ty,
          session,
          response
        }
        local modify_by_remote = params[4]
        if "RESPONSE" == ty then
          if 1 == 1 or response then
            if nil ~= target_session_map[session] then
              local target = target_session_map[session]
              if "" == target then
                intercept = true
              else
                if nil ~= target.data then
                  dresult[3] = target.data[3]
                end
                if 0 ~= target.delay then
                  intercept = true
                  table.insert(delay_map, {
                    start = now,
                    dresult = JsonUtil.clone(dresult),
                    delay = target.delay
                  })
                end
              end
              target_session_map[session] = nil
            end
            local p_response = {
              response = dresult[3],
              session_id = session,
              timestamp = TimeUtil.time(),
              origin_dispatch_data = {
                ty = ty,
                session = session,
                response = dresult[3]
              }
            }
            if proto_module and not intercept then
              proto_module.addResponse(p_response)
            end
          end
        elseif "REQUEST" == ty and (1 == 1 or response) then
          local flag, data, delay = M.getRemoteOperation(session, "ntf")
          if 1 == flag then
            intercept = true
            modify_by_remote = "intercept"
          elseif 2 == flag then
            if nil ~= data then
              dresult[3] = data[3]
              modify_by_remote = "alter"
            end
            if 0 ~= delay then
              intercept = true
              dresult[4] = "alter"
              table.insert(delay_map, {
                start = now,
                dresult = JsonUtil.clone(dresult),
                delay = delay
              })
            end
          end
          local p_notify = {
            proto_name = session,
            request = dresult[3],
            timestamp = TimeUtil.time(),
            origin_dispatch_data = {
              ty = ty,
              session = session,
              response = dresult[3]
            }
          }
          if nil ~= modify_by_remote then
            p_notify.modify_by_remote = modify_by_remote
          end
          if proto_module and not intercept then
            proto_module.addNotify(p_notify)
          end
        end
        if not intercept then
          send_proto_cb(dresult[2], dresult[3])
          origin_do_process_msg(table.unpack(dresult))
        end
      end
      
      override_register(global.sproto_service, "do_process_msg", new_do_process_msg, origin_do_process_msg)
      local origin_update = global.sproto_service.update
      
      local function new_update(...)
        local now = corProtoMgr.gettime()
        for key, value in pairs(delay_map) do
          if now - value.start > value.delay then
            global.sproto_service.do_process_msg(table.unpack(value.dresult))
            delay_map[key] = nil
          end
        end
        origin_update(...)
      end
      
      override_register(global.sproto_service, "update", new_update, origin_update)
      local origin_request = global.sproto_service.request
      
      local function new_request(...)
        local params = {
          ...
        }
        local typename = params[2]
        local session = getTargetUpvalue(origin_request, "v_session") + 1
        local req = params[3]
        local req_params = req
        local send_by_remote_index = params[4]
        if 1 == 1 or req_params then
          local p_request = {
            proto_name = typename,
            request = req_params,
            session_id = session,
            timestamp = TimeUtil.time(),
            send_by_remote = false
          }
          local flag, data, delay = M.getRemoteOperation(typename, "rpc")
          if 1 == flag then
            target_session_map[session] = ""
            p_request.modify_by_remote = "intercept"
          end
          if 2 == flag then
            target_session_map[session] = {data = data, delay = delay}
            p_request.modify_by_remote = "alter"
          end
          if proto_module then
            if nil ~= send_by_remote_index and send_by_remote_index > 0 then
              p_request.send_by_remote = true
              p_request.send_by_remote_index = send_by_remote_index
            end
            proto_module.addRequest(p_request)
          end
        end
        origin_request(...)
        return session
      end
      
      override_register(global.sproto_service, "request", new_request, origin_request)
      local origin_request_once = global.sproto_service.request_once
      
      local function new_request_once(...)
        local params = {
          ...
        }
        local typename = params[2]
        local session = getTargetUpvalue(origin_request_once, "v_session") + 1
        local req = params[3]
        local req_params = req
        local send_by_remote_index = params[4]
        if 1 == 1 or req_params then
          local p_request = {
            proto_name = typename,
            request = req_params,
            session_id = session,
            timestamp = TimeUtil.time(),
            send_by_remote = false
          }
          local flag, data, delay = M.getRemoteOperation(typename, "rpc")
          if 1 == flag then
            target_session_map[session] = ""
            p_request.modify_by_remote = "intercept"
          end
          if 2 == flag then
            target_session_map[session] = {data = data, delay = delay}
            p_request.modify_by_remote = "alter"
          end
          if proto_module then
            if nil ~= send_by_remote_index and send_by_remote_index > 0 then
              p_request.send_by_remote = true
              p_request.send_by_remote_index = send_by_remote_index
            end
            proto_module.addRequest(p_request)
          end
        end
        origin_request_once(...)
        return session
      end
      
      override_register(global.sproto_service, "request_once", new_request_once, origin_request_once)
      local origin_request_unlimit = global.sproto_service.request_unlimit
      
      local function new_request_unlimit(...)
        local params = {
          ...
        }
        local typename = params[2]
        local session = getTargetUpvalue(origin_request_unlimit, "v_session") + 1
        local req = params[3]
        local req_params = req
        local send_by_remote_index = params[4]
        if 1 == 1 or req_params then
          local p_request = {
            proto_name = typename,
            request = req_params,
            session_id = session,
            timestamp = TimeUtil.time(),
            send_by_remote = false
          }
          local flag, data, delay = M.getRemoteOperation(typename, "rpc")
          if 1 == flag then
            target_session_map[session] = ""
            p_request.modify_by_remote = "intercept"
          end
          if 2 == flag then
            target_session_map[session] = {data = data, delay = delay}
            p_request.modify_by_remote = "alter"
          end
          if proto_module then
            if nil ~= send_by_remote_index and send_by_remote_index > 0 then
              p_request.send_by_remote = true
              p_request.send_by_remote_index = send_by_remote_index
            end
            proto_module.addRequest(p_request)
          end
        end
        origin_request_unlimit(...)
        return session
      end
      
      override_register(global.sproto_service, "request_unlimit", new_request_unlimit, origin_request_unlimit)
      local origin_netevent_request_unlimit = netevent.request_unlimit
      
      local function new_netevent_request_unlimit(...)
        local param = {
          ...
        }
        local obj = param[3]
        if type(obj) == "table" then
          local cb = obj.cb
          local isSendByLuaBoomer = obj.isSendByLuaBoomer
          if type(cb) == "function" and isSendByLuaBoomer then
            return
          end
        end
        origin_netevent_request_unlimit(...)
      end
      
      override_register(netevent, "request_unlimit", new_netevent_request_unlimit, origin_netevent_request_unlimit)
    end
    local fakeSession = 0
    local origin_send = global.sproto_service.send
    
    local function new_send(...)
      local params = {
        ...
      }
      local typename = params[1]
      local req = params[2]
      local req_params = req
      fakeSession = fakeSession - 1
      if 1 == 1 or req_params then
        local p_request = {
          proto_name = typename,
          request = req_params,
          session_id = fakeSession,
          timestamp = TimeUtil.time(),
          send_by_remote = false
        }
        if proto_module then
          proto_module.addRequest(p_request)
        end
      end
      origin_send(...)
    end
    
    override_register(global.sproto_service, "send", new_send, origin_send)
    init_succ = true
  end
  
  function M.getRemoteOperation(proto_name, proto_type)
    if next(remote_config) == nil then
      return 0
    end
    if not intercept_swtich and not alter_switch then
      return 0
    end
    local interceptProtoName = remote_config.interceptProtoName
    if nil ~= interceptProtoName and intercept_swtich then
      local len = #interceptProtoName
      for i = 1, len do
        if proto_name == interceptProtoName[i] then
          return 1
        end
      end
    end
    if "rpc" == proto_type then
      local rpcIndex = remote_config.rpcIndex
      local rpcQueue = remote_config.rpcQueue
      if nil ~= rpcQueue and rpcIndex <= #rpcQueue then
        local name = rpcQueue[rpcIndex].protoName
        local type = rpcQueue[rpcIndex].type
        if name == proto_name then
          remote_config.rpcIndex = rpcIndex + 1
          if "intercept" == type then
            return 1
          end
          if "alter" == type then
            local dispatch_data
            if nil ~= rpcQueue[rpcIndex].response then
              local response = rpcQueue[rpcIndex].response
              dispatch_data = rpcQueue[rpcIndex].dispatch_data
              dispatch_data[3] = JsonUtil.tableDecode(response)
            end
            local delay = rpcQueue[rpcIndex].delay
            if nil == delay then
              delay = 0
            end
            return 2, dispatch_data, delay
          end
        end
      end
    end
    if "ntf" == proto_type then
      local ntfIndex = remote_config.ntfIndex
      local ntfQueue = remote_config.ntfQueue
      if nil ~= ntfQueue and ntfIndex <= #ntfQueue then
        local name = ntfQueue[ntfIndex].protoName
        local type = ntfQueue[ntfIndex].type
        if name == proto_name then
          remote_config.ntfIndex = ntfIndex + 1
          if "intercept" == type then
            return 1
          end
          if "alter" == type then
            local delay = ntfQueue[ntfIndex].delay
            if nil == delay then
              delay = 0
            end
            local dispatch_data
            if nil ~= ntfQueue[ntfIndex].request then
              local request = ntfQueue[ntfIndex].request
              if nil ~= request.args then
                dispatch_data = ntfQueue[ntfIndex].dispatch_data
                dispatch_data[3] = JsonUtil.tableDecode(request)
              end
            end
            return 2, dispatch_data, delay
          end
        end
      end
    end
    return 0
  end
  
  function M.init(proto_test_module)
    proto_module = proto_test_module
    local result, msg = pcall(do_init)
    if false == result then
      print("prototest init failed", msg)
    end
  end
  
  function M.is_init_succ()
    return init_succ
  end
  
  function M.getStatus()
    local status = ""
    if protoTest_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if intercept_swtich then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if alter_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    return {status = status, remoteConfig = remote_config}
  end
  
  function M.executeCommand(data)
    local command = data.command
    local exe = CMD[command]
    if nil ~= exe then
      exe(data)
    end
  end
  
  function M.update()
  end
  
  function M.updateEveryFrame()
    corMapUpdate()
  end
  
  function CMD.start_protoTest()
    protoTest_switch = true
    override_change(false)
  end
  
  function CMD.stop_protoTest()
    protoTest_switch = false
    override_change(true)
  end
  
  function CMD.start_protoTest_intercept()
    intercept_swtich = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_intercept()
    intercept_swtich = false
    remote_config = {}
  end
  
  function CMD.start_protoTest_alter()
    alter_switch = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_alter()
    alter_switch = false
    remote_config = {}
  end
  
  function CMD.update_protoTest_config(data)
    local remote = data.remoteConfig
    remote_config = remote
    remote_config.rpcIndex = 1
    remote_config.ntfIndex = 1
  end
  
  function M.sendProtoGroup(...)
    corMapReset()
    local params = {
      ...
    }
    local protoRecordPatch = params[1]
    local respCallBack = params[2]
    local data = params[3]
    local waiting = data.waiting
    if nil == waiting then
      waiting = true
    end
    
    local function sends(p, i)
      local i_time = corProtoMgr.gettime()
      
      local function trigger()
        local now = corProtoMgr.gettime()
        if p[i].delay == nil then
          return 1
        end
        if now - i_time < p[i].delay then
          return 0
        else
          return 1
        end
      end
      
      local cb
      if i < #p then
        function cb()
          if waiting then
            sends(p, i + 1)
          end
        end
      else
        function cb()
          respCallBack(M)
        end
      end
      local cmd = p[i].protoRecord.protoName
      local body = p[i].protoRecord.protoRequest
      local co = coroutine.create(function()
        local thread = coroutine.running()
        local triggerFlag = 0
        
        local function corCallback()
          send_proto_thread_map[thread].isFinish = true
          cb()
        end
        
        send_proto_thread_map[thread] = {
          thread = thread,
          trigger = trigger,
          cb = corCallback,
          requesting = false,
          isFinish = false
        }
        while 0 == triggerFlag do
          triggerFlag = coroutine.yield()
          if -1 == triggerFlag then
            send_proto_thread_map[thread] = nil
            return
          end
        end
        local session = global.sproto_service.request_unlimit({cb = cb, isSendByLuaBoomer = true}, cmd, body, i)
        send_proto_thread_map[thread].requesting = true
        send_proto_thread_map[thread].session = session
      end)
      table.insert(coroutine_map, co)
      coroutine.resume(co)
    end
    
    if waiting then
      sends(protoRecordPatch, 1)
    else
      for k = 1, #protoRecordPatch do
        sends(protoRecordPatch, k)
      end
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.M5ProtoTestModule", function(require)
  local TimeUtil = require("LuaBoomer.Util.TimeUtil")
  local Sproto = require("3rd.sproto.sproto")
  local corProtoMgr = require("LuaBoomer.LocalModule.ProtoTest.CorProtoMgr")
  local SprotoList = require("Network.SprotoList")
  local revSprotoList = {}
  local proto_module
  local M = {}
  local init_succ = false
  local hook_network
  local network_map = {}
  local current_host_port
  local intercept_list = {}
  local intercept_swtich = true
  local protoTest_switch = false
  local CMD = {}
  local override_map = {}
  local alter_switch = true
  local csInit_success = false
  local remote_config = {}
  local session_de_map = {}
  
  local function override_register(table, prop, new, origin)
    local record = {
      table = table,
      prop = prop,
      new = new,
      origin = origin
    }
    override_map[tostring(table)] = record
    print("override_register", prop, record)
  end
  
  local function override_change(isOrigin)
    for key, value in pairs(override_map) do
      if isOrigin then
        value.table[value.prop] = value.origin
      else
        value.table[value.prop] = value.new
      end
    end
    print("override_change isOrigin: ", isOrigin)
  end
  
  local send_proto_thread_map = {}
  
  local function corMapUpdate()
    for key, value in pairs(send_proto_thread_map) do
      local trigger = value.trigger
      local requesting = value.requesting
      local thread = value.thread
      if not requesting then
        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$update", thread, trigger())
        coroutine.resume(thread, trigger())
      end
    end
  end
  
  local function corMapReset()
    for key, value in pairs(send_proto_thread_map) do
      local requesting = value.requesting
      local thread = value.thread
      if not requesting then
        coroutine.resume(thread, -1)
      end
      send_proto_thread_map[key] = nil
    end
    send_proto_thread_map = {}
  end
  
  local function send_proto_cb(session, p_response)
    for key, value in pairs(send_proto_thread_map) do
      local s = value.session
      if s == session and value.requesting then
        local cb = value.cb
        cb()
      end
    end
  end
  
  local fake_request_session = 0
  local rpcReqHandlerMap = {}
  
  local function csharpReportRequest(...)
    local params = {
      ...
    }
    local buffer = params[1]
    local size = params[2]
    local tag = params[3]
    local session_id = params[4]
    if 0 == session_id then
      fake_request_session = fake_request_session - 1
      session_id = fake_request_session
    end
    local send_by_remote_index = params[5]
    local protoName = revSprotoList[tag]
    if nil == protoName then
      print("cannot find proto, check it please, tag: ", tag)
    end
    local request_data, pName = Network.Sp:request_decode(protoName, buffer, size)
    local p_request = {
      proto_name = protoName,
      request = request_data,
      session_id = session_id,
      timestamp = TimeUtil.time(),
      send_by_remote = false
    }
    if proto_module then
      if nil ~= send_by_remote_index and send_by_remote_index > 0 then
        p_request.send_by_remote = true
        p_request.send_by_remote_index = send_by_remote_index
        print("request: \n" .. TablePrint(p_request))
      end
      proto_module.addRequest(p_request)
      session_de_map[session_id] = protoName
    end
  end
  
  local function csharpReportResponse(...)
    local params = {
      ...
    }
    local buffer = params[1]
    local size = params[2]
    local tag = params[3]
    local session_id = params[4]
    local protoName = revSprotoList[tag]
    if nil == protoName then
      print("cannot find proto, check it please, tag: ", tag)
    end
    if nil == session_id then
      print("csharpReportResponse cannot find session_id, check it please, protoName: ", protoName)
      return
    end
    local response_data, pName = Network.Sp:response_decode(protoName, buffer, size)
    local p_response = {
      response = response_data,
      session_id = session_id,
      timestamp = TimeUtil.time(),
      origin_dispatch_data = response_data
    }
    if proto_module then
      proto_module.addResponse(p_response)
      session_de_map[session_id] = nil
    end
    send_proto_cb(session_id, response_data)
  end
  
  local function csharpReportNotify(...)
    local params = {
      ...
    }
    local buffer = params[1]
    local size = params[2]
    local tag = params[3]
    local protoName = revSprotoList[tag]
    if nil == protoName then
      print("cannot find proto, check it please, tag: ", tag)
    end
    local notify_data, pName = Network.Sp:request_decode(protoName, buffer, size)
    local p_notify = {
      proto_name = protoName,
      request = notify_data,
      timestamp = TimeUtil.time(),
      origin_dispatch_data = notify_data
    }
    if proto_module then
      proto_module.addNotify(p_notify)
    end
  end
  
  local function do_init()
    for k, v in pairs(SprotoList) do
      local tag = v.tag
      revSprotoList[tag] = k
    end
    local origin_request = Network.SendRequest
    
    local function new_request(...)
      local params = {
        ...
      }
      local send_by_remote_index = params[6]
      if proto_module and nil ~= send_by_remote_index and send_by_remote_index > 0 then
        CS.ProtoTest.ProtoTestModule.setSendingByRemoteIndex(send_by_remote_index)
      end
      origin_request(...)
    end
    
    override_register(Network, "SendRequest", new_request, origin_request)
    local origin_request_decode = Sproto.request_decode
    
    local function new_request_decode(...)
      local params = {
        ...
      }
      local proto_name = params[2]
      local notify_data, pName = origin_request_decode(...)
      local p_notify = {
        proto_name = proto_name,
        request = notify_data,
        timestamp = TimeUtil.time(),
        origin_dispatch_data = notify_data
      }
      if proto_module then
        proto_module.addNotify(p_notify)
      end
      return notify_data, pName
    end
    
    init_succ = true
    CS.ProtoTest.ProtoTest.init()
    CS.ProtoTest.ProtoTestModule.setReporthandler(csharpReportRequest, csharpReportResponse, csharpReportNotify)
    if protoTest_switch then
      CMD.start_protoTest()
    end
  end
  
  function M.init(proto_test_module)
    proto_module = proto_test_module
    local result, msg = pcall(do_init)
    if false == result then
      print("prototest init failed", msg)
    end
  end
  
  function M.is_init_succ()
    return init_succ
  end
  
  function M.getStatus()
    local status = ""
    if protoTest_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if intercept_swtich then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if alter_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    return {status = status, remoteConfig = remote_config}
  end
  
  function M.executeCommand(data)
    local command = data.command
    local exe = CMD[command]
    if nil ~= exe then
      exe(data)
    end
  end
  
  function M.update()
    if not csInit_success then
      csInit_success = CS.ProtoTest.ProtoTest.init()
    end
    local len = 0
    for k, v in pairs(session_de_map) do
      len = len + 1
    end
  end
  
  function M.updateEveryFrame()
    corMapUpdate()
  end
  
  function CMD.start_protoTest()
    protoTest_switch = true
    override_change(false)
    print("csInit_success: ", csInit_success)
    if csInit_success then
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
      CS.ProtoTest.ProtoTest.inject()
    end
  end
  
  function CMD.stop_protoTest()
    protoTest_switch = false
    override_change(true)
    print("csInit_success: ", csInit_success)
    if csInit_success then
      print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
      CS.ProtoTest.ProtoTest.eject()
    end
  end
  
  function CMD.start_protoTest_intercept()
    intercept_swtich = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_intercept()
    intercept_swtich = false
    remote_config = {}
  end
  
  function CMD.start_protoTest_alter()
    alter_switch = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_alter()
    alter_switch = false
    remote_config = {}
  end
  
  function CMD.update_protoTest_config(data)
    local remote = data.remoteConfig
    remote_config = remote
    remote_config.rpcIndex = 1
    remote_config.ntfIndex = 1
    print("update_protoTest_config: ", remote)
  end
  
  function M.sendProtoGroup(protoRecordPatch, respCallBack)
    corMapReset()
    
    local function sends(p, i)
      local i_time = corProtoMgr.gettime()
      
      local function trigger()
        local now = corProtoMgr.gettime()
        if p[i].delay == nil then
          return 1
        end
        if now - i_time < p[i].delay then
          return 0
        else
          return 1
        end
      end
      
      local cb
      if i < #p then
        function cb()
          sends(p, i + 1)
        end
      else
        function cb()
          respCallBack(M)
        end
      end
      local cmd = p[i].protoRecord.protoName
      local params = p[i].protoRecord.protoRequest
      local co = coroutine.create(function()
        local thread = coroutine.running()
        local triggerFlag = 0
        send_proto_thread_map[thread] = {
          thread = thread,
          trigger = trigger,
          cb = cb,
          requesting = false,
          isFinish = false
        }
        while 0 == triggerFlag do
          triggerFlag = coroutine.yield()
          if -1 == trigger then
            send_proto_thread_map[thread] = nil
            return
          end
        end
        send_proto_thread_map[thread].requesting = true
        
        local function handler()
          cb()
        end
        
        Network:SendRequest(cmd, params, handler, {}, i)
        send_proto_thread_map[thread].requesting = true
        send_proto_thread_map[thread].session = session
      end)
      coroutine.resume(co)
    end
    
    sends(protoRecordPatch, 1)
  end
  
  function M.csharpSwitchProtoTest(open)
    print(open)
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.S3ProtoTestModule", function(require)
  local Global = require("global")
  local Network = require("network.network")
  local utils = require("ejoy2dx.utils")
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  local TimeUtil = require("LuaBoomer.Util.TimeUtil")
  local proto_module
  local corProtoMgr = require("LuaBoomer.LocalModule.ProtoTest.CorProtoMgr")
  local M = {}
  local init_succ = false
  local hook_network
  local network_map = {}
  local current_host_port
  local intercept_list = {}
  local intercept_swtich = true
  local protoTest_switch = false
  local CMD = {}
  local override_map = {}
  local target_session_map = {}
  local delay_map = {}
  local alter_switch = true
  local corMap = {}
  local remote_config = {}
  
  local function override_register(table, prop, new, origin)
    local record = {
      table = table,
      prop = prop,
      new = new,
      origin = origin
    }
    override_map[tostring(table)] = record
    print("override_register", prop, record)
  end
  
  local function override_change(isOrigin)
    for key, value in pairs(override_map) do
      if isOrigin then
        value.table[value.prop] = value.origin
      else
        value.table[value.prop] = value.new
      end
    end
    print("override_change isOrigin: ", isOrigin)
  end
  
  local function corProtoCallback(corCbParams, ...)
    local thread = corCbParams
    if nil ~= corMap[thread] then
      local cb = corMap[thread].cb
      if type(cb) == "function" then
        cb(corMap[thread].cbParams, ...)
      end
      corMap[thread] = nil
    end
  end
  
  local function asyncSend(cmd, params, cb, cbParams, trigger, sendByRemoteIndex)
    assert(type(trigger) == "function" or type(trigger) == nil, "trigger should be a function or nil")
    local co = coroutine.create(function()
      local thread = coroutine.running()
      local triggerFlag = 0
      corMap[thread] = {
        thread = thread,
        cb = cb,
        cbParams = cbParams,
        trigger = trigger,
        requesting = false
      }
      while 0 == triggerFlag do
        triggerFlag = coroutine.yield()
        if -1 == trigger then
          corMap[thread] = nil
          return
        end
      end
      corMap[thread].requesting = true
      
      local function callback()
        corProtoCallback(thread)
      end
      
      local session_id = Global.network:call(cmd, params, callback, thread, sendByRemoteIndex)
    end)
    coroutine.resume(co)
  end
  
  local function corMapReset()
    for key, value in pairs(corMap) do
      local requesting = value.requesting
      local thread = value.thread
      if not requesting then
        coroutine.resume(thread, -1)
      end
      corMap[key] = nil
    end
    corMap = {}
  end
  
  local function corMapUpdate()
    for key, value in pairs(corMap) do
      local trigger = value.trigger
      local requesting = value.requesting
      local thread = value.thread
      if not requesting then
        coroutine.resume(thread, trigger())
      end
    end
  end
  
  local function do_init()
    if Global.network ~= nil then
      hook_network = Global.network
      local hook_v_client = hook_network.v_client
      local hook_v_client_mt = debug.getmetatable(hook_v_client)
      local origin_dispatch = hook_v_client_mt.__index.dispatch
      
      local function new_dispatch(...)
        local params = {
          ...
        }
        local self = params[1]
        local resp = params[2]
        local dispatch_result = self.dispatch_result
        local hasBeenDispatched = self.hasBeenDispatched
        local dr = {}
        if not hasBeenDispatched then
          local p_type, v1, v2, v3, v4 = origin_dispatch(...)
          dr = {
            p_type,
            v1,
            v2,
            v3,
            v4
          }
        else
          dr = table.remove(dispatch_result, 1)
        end
        local p_type = dr[1]
        local v1 = dr[2]
        local v2 = dr[3]
        local v3 = dr[4]
        local v4 = dr[5]
        if false ~= hasBeenDispatched then
          if "RESPONSE" == p_type then
            local session_id, response = v1, v2
            local resp_result
            resp_result = response
            if resp_result then
              local p_response = {
                target_host = self.host_port,
                response = resp_result,
                session_id = session_id,
                timestamp = TimeUtil.time(),
                origin_dispatch_data = {
                  p_type = p_type,
                  v1 = v1,
                  v2 = v2,
                  v3 = v3,
                  v4 = v4
                }
              }
              if proto_module then
                proto_module.addResponse(p_response)
              end
            end
          elseif "REQUEST" == p_type then
            local name, request, response = v1, v2, v3
            local copyRequest = request
            if copyRequest then
              local p_notify = {
                target_host = self.host_port,
                proto_name = name,
                request = copyRequest,
                timestamp = TimeUtil.time(),
                origin_dispatch_data = {
                  p_type = p_type,
                  v1 = v1,
                  v2 = v2,
                  v3 = v3,
                  v4 = v4
                }
              }
              local modify_by_remote = dr[6]
              if nil ~= modify_by_remote then
                p_notify.modify_by_remote = modify_by_remote
              end
              if proto_module then
                proto_module.addNotify(p_notify)
              end
            end
          end
        end
        return p_type, v1, v2, v3, v4
      end
      
      override_register(hook_v_client_mt.__index, "dispatch", new_dispatch, origin_dispatch)
      local hook_network_mt = debug.getmetatable(hook_network)
      local origin_connect = hook_network_mt.__index.connect
      
      function hook_network_mt.__index.connect(...)
        local params = {
          ...
        }
        local self = params[1]
        local host, port = params[2], params[3]
        local host_port = host .. ":" .. port
        self.host_port = host_port
        network_map[host_port] = self
        local result = {
          origin_connect(...)
        }
        if result[1] then
          local self = params[1]
          local v_conn = self.v_conn
          if v_conn then
            local hook_v_conn_mt = debug.getmetatable(v_conn)
            local origin_recv_msg = hook_v_conn_mt.__index.recv_msg
            
            local function new_recv_msg(...)
              local now = corProtoMgr.gettime()
              local sub_params = {
                ...
              }
              local sub_self = sub_params[1]
              local host, port = "", ""
              if sub_self.v_sock == nil then
                host, port = sub_self.o_host_addr.addr, sub_self.o_port
              else
                host, port = sub_self.v_sock.o_host_addr.addr, sub_self.v_sock.o_port
              end
              local host_port = host .. ":" .. port
              sub_self.v_client.host_port = host_port
              local out = sub_params[2]
              local count = origin_recv_msg(...)
              local intercept_indexes = {}
              local dispatch_result = {}
              sub_self.v_client.dispatch_result = dispatch_result
              sub_self.v_client.hasBeenDispatched = false
              for i = 1, count do
                local resp = out[i]
                local p_type, v1, v2, v3, v4 = sub_self.v_client:dispatch(resp)
                local dresult = {
                  p_type,
                  v1,
                  v2,
                  v3,
                  v4
                }
                local intercept = false
                if "RESPONSE" == p_type then
                  local session_id = v1
                  if nil ~= target_session_map[session_id] then
                    local target = target_session_map[session_id]
                    if "" == target then
                      intercept = true
                    else
                      if nil ~= target.data then
                        dresult[3] = target.data.v2
                      end
                      if 0 ~= target.delay then
                        intercept = true
                        table.insert(delay_map, {
                          resp = resp,
                          start = now,
                          dresult = JsonUtil.clone(dresult),
                          delay = target.delay
                        })
                      end
                    end
                    target_session_map[session_id] = nil
                  end
                elseif "REQUEST" == p_type then
                  local request = v2
                  local flag, data, delay = M.getRemoteOperation(v1, "ntf")
                  if 1 == flag then
                    intercept = true
                    dresult[6] = "intercept"
                  elseif 2 == flag then
                    dresult[6] = "alter"
                    if nil ~= data then
                      dresult[3] = data.v2
                    end
                    if 0 ~= delay then
                      intercept = true
                      table.insert(delay_map, {
                        resp = resp,
                        start = now,
                        dresult = JsonUtil.clone(dresult),
                        delay = delay
                      })
                    end
                  end
                end
                if intercept then
                  table.insert(intercept_indexes, i)
                else
                  table.insert(dispatch_result, dresult)
                end
              end
              local icount = #intercept_indexes
              for j = 1, icount do
                table.remove(out, count - intercept_indexes[j] + 1)
              end
              local dcount = 0
              for key, value in pairs(delay_map) do
                if now - value.start > value.delay then
                  table.insert(out, value.resp)
                  table.insert(dispatch_result, value.dresult)
                  delay_map[key] = nil
                  dcount = dcount + 1
                end
              end
              sub_self.v_client.hasBeenDispatched = true
              return count - icount + dcount
            end
            
            override_register(hook_v_conn_mt.__index, "recv_msg", new_recv_msg, origin_recv_msg)
          end
        end
        return result
      end
      
      local origin_call = hook_network_mt.__index.call
      
      local function new_call(...)
        local params = {
          ...
        }
        local self = params[1]
        local host_port = self.host_port
        local name, t = params[2], params[3]
        local sendByRemoteIndex = params[6]
        if nil == t then
          t = {}
        end
        local req_params = t
        local session_id = self.v_session_index
        if req_params then
          local p_request = {
            target_host = host_port,
            proto_name = name,
            request = req_params,
            session_id = session_id,
            timestamp = TimeUtil.time(),
            send_by_remote = false
          }
          local flag, data, delay = M.getRemoteOperation(name, "rpc")
          if 1 == flag then
            target_session_map[session_id] = ""
            p_request.modify_by_remote = "intercept"
          end
          if 2 == flag then
            target_session_map[session_id] = {data = data, delay = delay}
            p_request.modify_by_remote = "alter"
          end
          if proto_module then
            if nil ~= sendByRemoteIndex then
              p_request.send_by_remote = true
              p_request.send_by_remote_index = t.sendByRemoteIndex
            end
            proto_module.addRequest(p_request)
          end
        end
        local result = origin_call(...)
        return result
      end
      
      local callClosure = {}
      callClosure.call = origin_call
      
      function hook_network_mt.__index.call(...)
        do return callClosure.call, ... end
        return callClosure.call, ...
      end
      
      override_register(callClosure, "call", new_call, origin_call)
      local origin_update = hook_network_mt.__index.update
      
      local function new_update(...)
        local params = {
          ...
        }
        local self = params[1]
        local v_client = self.v_client
        local conn = self.v_conn
        if nil == conn or not conn then
          return
        end
        conn.v_client = v_client
        self.v_conn = conn
        do return origin_update, ... end
        return origin_update, ...
      end
      
      override_register(hook_network_mt.__index, "update", new_update, origin_update)
      init_succ = true
    end
    return true
  end
  
  function M.init(proto_test_module)
    proto_module = proto_test_module
    local result, msg = pcall(do_init)
    if false == result then
      print("prototest init failed", msg)
    end
  end
  
  function M.is_init_succ()
    return init_succ
  end
  
  function M.getProtoName(protoRecord)
    local cmd = protoRecord.protoName
    local key
    if not protoRecord.protoRequest then
      key = protoRecord.protoRequest.key
    end
    if not key then
      return key
    else
      return cmd
    end
  end
  
  function M.sendProto(protoRecord, resp_call_back)
    local cmd = protoRecord.protoName
    local params = {
      key = protoRecord.protoRequest.key,
      args = protoRecord.protoRequest.args
    }
    Global.network:call(cmd, params, resp_call_back, M)
  end
  
  function M.sendProtoGroup(protoRecords, resp_callback, data)
    corMapReset()
    local waiting = data.waiting
    if nil == waiting then
      waiting = true
    end
    
    local function sends(p, i)
      local i_time = corProtoMgr.gettime()
      
      local function trigger()
        local now = corProtoMgr.gettime()
        if p[i].delay == nil then
          return 1
        end
        if now - i_time < p[i].delay then
          return 0
        else
          return 1
        end
      end
      
      local cb
      if i < #p then
        function cb()
          if waiting then
            sends(p, i + 1)
          end
        end
      else
        function cb()
          resp_callback(M)
        end
      end
      local cmd = p[i].protoRecord.protoName
      local params = p[i].protoRecord.protoRequest
      asyncSend(cmd, params, cb, nil, trigger, i)
    end
    
    if waiting then
      sends(protoRecords, 1)
    else
      for k = 1, #protoRecords do
        sends(protoRecords, k)
      end
    end
  end
  
  function M.needIntercept(proto_name)
    if not intercept_swtich then
      return false
    end
    local len = #intercept_list
    if len <= 0 then
      return false
    end
    for i = 1, len do
      if proto_name == intercept_list[i] then
        return true
      end
    end
    return false
  end
  
  function M.setInterceptList(list)
    intercept_list = list
  end
  
  function M.interceptSwtich(switch)
    intercept_swtich = switch
  end
  
  function M.getStatus()
    local status = ""
    if protoTest_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if intercept_swtich then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if alter_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    return {status = status, remoteConfig = remote_config}
  end
  
  function M.getRemoteOperation(proto_name, proto_type)
    if next(remote_config) == nil then
      return 0
    end
    if not intercept_swtich and not alter_switch then
      return 0
    end
    local interceptProtoName = remote_config.interceptProtoName
    if nil ~= interceptProtoName and intercept_swtich then
      local len = #interceptProtoName
      for i = 1, len do
        if proto_name == interceptProtoName[i] then
          return 1
        end
      end
    end
    if "rpc" == proto_type then
      local rpcIndex = remote_config.rpcIndex
      local rpcQueue = remote_config.rpcQueue
      if nil ~= rpcQueue and rpcIndex <= #rpcQueue then
        local name = rpcQueue[rpcIndex].protoName
        local type = rpcQueue[rpcIndex].type
        if name == proto_name then
          remote_config.rpcIndex = rpcIndex + 1
          if "intercept" == type then
            return 1
          end
          if "alter" == type then
            local dispatch_data
            if nil ~= rpcQueue[rpcIndex].response then
              local response = JsonUtil.tableDecode(rpcQueue[rpcIndex].response)
              dispatch_data = rpcQueue[rpcIndex].dispatch_data
              dispatch_data.v2 = response
            end
            local delay = rpcQueue[rpcIndex].delay
            if nil == delay then
              delay = 0
            end
            return 2, dispatch_data, delay
          end
        end
      end
    end
    if "ntf" == proto_type then
      local ntfIndex = remote_config.ntfIndex
      local ntfQueue = remote_config.ntfQueue
      if nil ~= ntfQueue and ntfIndex <= #ntfQueue then
        local name = ntfQueue[ntfIndex].protoName
        local type = ntfQueue[ntfIndex].type
        if name == proto_name then
          remote_config.ntfIndex = ntfIndex + 1
          if "intercept" == type then
            return 1
          end
          if "alter" == type then
            local delay = ntfQueue[ntfIndex].delay
            if nil == delay then
              delay = 0
            end
            local dispatch_data
            if nil ~= ntfQueue[ntfIndex].request then
              local request = ntfQueue[ntfIndex].request
              if nil ~= request.args then
                dispatch_data = ntfQueue[ntfIndex].dispatch_data
                dispatch_data.v2 = JsonUtil.tableDecode(request)
              end
            end
            return 2, dispatch_data, delay
          end
        end
      end
    end
    return 0
  end
  
  function M.executeCommand(data)
    local command = data.command
    local exe = CMD[command]
    if nil ~= exe then
      exe(data)
    end
  end
  
  function M.update()
  end
  
  function M.updateEveryFrame()
    corMapUpdate()
  end
  
  function CMD.start_protoTest()
    protoTest_switch = true
    override_change(false)
  end
  
  function CMD.stop_protoTest()
    protoTest_switch = false
    override_change(true)
  end
  
  function CMD.start_protoTest_intercept()
    intercept_swtich = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_intercept()
    intercept_swtich = false
    remote_config = {}
  end
  
  function CMD.start_protoTest_alter()
    alter_switch = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_alter()
    alter_switch = false
    remote_config = {}
  end
  
  function CMD.update_protoTest_config(data)
    local remote = data.remoteConfig
    remote_config = remote
    remote_config.rpcIndex = 1
    remote_config.ntfIndex = 1
    print("update_protoTest_config: ", remote)
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.M6ProtoTestModule", function(require)
  local connection = require("Share.Core.Network.Connection")
  local msgpack = require("cmsgpack")
  local lz4 = require("lz4")
  local TimeUtil = require("LuaBoomer.Util.TimeUtil")
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  local msg_pack = global.MsgPack
  local msg_unpack = global.MsgUnpack
  local M = {}
  local proto_module
  local override_map = {}
  local init_succ = false
  local protoTest_switch = false
  local intercept_swtich = true
  local alter_switch = true
  local CMD = {}
  local fake_request_session = 0
  local remote_config = {}
  
  local function override_register(table, prop, new, origin)
    local record = {
      table = table,
      prop = prop,
      new = new,
      origin = origin
    }
    override_map[tostring(table) .. prop] = record
  end
  
  local function override_change(isOrigin)
    for key, value in pairs(override_map) do
      if isOrigin then
        value.table[value.prop] = value.origin
      else
        value.table[value.prop] = value.new
      end
    end
  end
  
  local from_upstream = false
  local upstream_body, downstream_body, last_pack_data
  
  local function do_init()
    local hook_network = game.rpc_mgr.network
    if nil == hook_network then
      return
    end
    local hook_client = hook_network.v_client
    hook_network = getmetatable(hook_network).__index
    hook_client = getmetatable(hook_client).__index
    local origin_call = hook_network.call
    
    local function new_call(...)
      local params = {
        ...
      }
      local self = params[1]
      local name = params[2]
      local t = params[3]
      local req_params
      if t.args and t.key then
        req_params = {
          key = t.key,
          args = msg_unpack(t.args)
        }
      end
      local session_id = self.v_session_index
      if req_params then
        local p_request = {
          target_host = nil,
          proto_name = t.key,
          request = req_params,
          session_id = session_id,
          timestamp = TimeUtil.time(),
          send_by_remote = false,
          origin_request_data = {
            cmd = name,
            params = req_params,
            send_type = "call"
          }
        }
        if from_upstream and nil ~= upstream_body then
          p_request.request.args = {
            Param = upstream_body.msg_body
          }
          p_request.origin_request_data.upstream = upstream_body
          from_upstream = false
          upstream_body = nil
        end
        if proto_module then
          if nil ~= t.sendByRemoteIndex then
            p_request.send_by_remote = true
            p_request.send_by_remote_index = t.sendByRemoteIndex
          end
          proto_module.addRequest(p_request)
        end
      end
      do return origin_call, ... end
      return origin_call, ...
    end
    
    override_register(hook_network, "call", new_call, origin_call)
    local origin_invoke = hook_network.invoke
    
    local function new_invoke(...)
      local params = {
        ...
      }
      local self = params[1]
      local name = params[2]
      local t = params[3]
      local req_params
      if t.args and t.key then
        req_params = {
          key = t.key,
          args = msg_unpack(t.args)
        }
      end
      fake_request_session = fake_request_session - 1
      if req_params then
        local p_request = {
          target_host = nil,
          proto_name = t.key,
          request = req_params,
          session_id = fake_request_session,
          timestamp = TimeUtil.time(),
          send_by_remote = false,
          origin_request_data = {
            cmd = name,
            params = req_params,
            send_type = "invoke"
          }
        }
        if from_upstream and nil ~= upstream_body then
          p_request.request.args = {
            Param = upstream_body.msg_body
          }
          p_request.origin_request_data.upstream = upstream_body
          from_upstream = false
          upstream_body = nil
        end
        if proto_module then
          if nil ~= t.sendByRemoteIndex then
            p_request.send_by_remote = true
            p_request.send_by_remote_index = t.sendByRemoteIndex
          end
          proto_module.addRequest(p_request)
        end
      end
      do return origin_invoke, ... end
      return origin_invoke, ...
    end
    
    override_register(hook_network, "invoke", new_invoke, origin_invoke)
    local origin_dispatch = hook_client.dispatch
    
    local function new_dispatch(...)
      local _type, v1, v2, v3 = origin_dispatch(...)
      if "RESPONSE" == _type then
        local session_id, response = v1, v2
        local unpackV2 = JsonUtil.clone(v2)
        local resp_result
        if nil ~= response and nil ~= response.result then
          resp_result = msg_unpack(response.result)
          unpackV2.result = resp_result
        end
        if resp_result then
          local p_response = {
            target_host = nil,
            response = resp_result,
            session_id = session_id,
            timestamp = TimeUtil.time(),
            origin_dispatch_data = {
              _type = _type,
              v1 = v1,
              v2 = unpackV2,
              v3 = v3
            }
          }
          if proto_module then
            proto_module.addResponse(p_response)
          end
        end
      elseif "REQUEST" == _type then
        local name, request, response = v1, v2, v3
        local copyRequest
        local unpackV2 = JsonUtil.clone(v2)
        if request.args and request.key then
          copyRequest = {
            key = request.key,
            args = request.args
          }
          if type(request.args) == "string" then
            copyRequest.args = msg_unpack(copyRequest.args)
            unpackV2.args = copyRequest.args
          end
        end
        if nil ~= copyRequest then
          local p_notify = {
            target_host = nil,
            proto_name = request.key,
            request = copyRequest,
            timestamp = TimeUtil.time(),
            origin_dispatch_data = {
              _type = _type,
              v1 = v1,
              v2 = unpackV2,
              v3 = v3
            }
          }
          if nil ~= string.find(request.key, "LuaRpc", 1) then
            downstream_body = p_notify
          elseif proto_module then
            proto_module.addNotify(p_notify)
          end
        end
      else
        print("new_dispatch receive unknown _type: ", _type)
      end
      return _type, v1, v2, v3
    end
    
    override_register(hook_client, "dispatch", new_dispatch, origin_dispatch)
    local origin_callControlRpc = connection.CallControlRpc
    
    local function new_callControlRpc(...)
      local paramsTable = {
        ...
      }
      local self = paramsTable[1]
      local name = paramsTable[2]
      local params = paramsTable[3]
      local cmd = self.control_cmd
      local msg = {func = name, params = params}
      local msg_body = {
        cmd,
        {msg = msg}
      }
      from_upstream = true
      upstream_body = {
        msg_body = msg_body,
        msg_source = "CallControlRpc",
        msg_params = {name, params}
      }
      do return origin_callControlRpc, ... end
      return origin_callControlRpc, ...
    end
    
    override_register(connection, "CallControlRpc", new_callControlRpc, origin_callControlRpc)
    local origin_callEntityMsg = connection.CallEntityMsg
    
    local function new_callEntityMsg(...)
      local paramsTable = {
        ...
      }
      local self = paramsTable[1]
      local func = paramsTable[2]
      local params = paramsTable[3]
      local ent_id = paramsTable[4] or self.ent_id
      local cmd = self.entity_msg_cmd
      local msg_body = {
        cmd,
        {
          ent_id = ent_id,
          func = func,
          args = params
        }
      }
      from_upstream = true
      upstream_body = {
        msg_body = msg_body,
        msg_source = "CallEntityMsg",
        msg_params = {
          func,
          params,
          ent_id
        }
      }
      do return origin_callEntityMsg, ... end
      return origin_callEntityMsg, ...
    end
    
    override_register(connection, "CallEntityMsg", new_callEntityMsg, origin_callEntityMsg)
    local origin_dispatchLuaRpc = connection.DispatchLuaRpc
    
    local function new_dispatchLuaRpc(...)
      local unpack_param = {}
      local params = {
        ...
      }
      local self, t = params[1], params[2]
      t = JsonUtil.clone(params[2])
      local Bin
      local data_fragments = JsonUtil.clone(self.data_fragments)
      origin_dispatchLuaRpc(...)
      local data_fragments_after = self.data_fragments
      if #data_fragments_after > 0 then
        return
      end
      local offset, complete, param
      offset, complete = msgpack.unpack_one(t.Param)
      offset, param = msgpack.unpack_one(t.Param, offset)
      table.insert(data_fragments, param)
      if 1 == #data_fragments then
        Bin = data_fragments[1]
        data_fragments[1] = nil
      else
        Bin = table.concat(data_fragments)
      end
      if -1 == offset then
        param = msgpack.unpack(Bin)
        local cmd, request = param[1], param[2]
        local copyRequest = JsonUtil.clone(request)
        if cmd == self.entity_msg_cmd then
          copyRequest.args = msgpack.unpack(copyRequest.args)
        else
          if cmd == self.control_cmd then
            copyRequest.msg = msgpack.unpack(copyRequest.msg)
          else
          end
        end
        unpack_param = {cmd, copyRequest}
      else
        local pack_size, pack_data
        offset, pack_size = msgpack.unpack_one(t.Param, offset)
        if -1 ~= offset then
          print("new_dispatchLuaRpc offset is not -1")
          return
        end
        if self.decompressor then
          pack_data = last_pack_data
          last_pack_data = nil
        else
          pack_data = Bin
        end
        offset = nil
        while -1 ~= offset do
          offset, param = msgpack.unpack_one(pack_data, offset)
          table.insert(unpack_param, param)
          local cmd_type, func = param[1], param[3]
          if 1 ~= cmd_type and 2 ~= cmd_type then
            print("new_dispatchLuaRpc cmd_type is neither 1 nor 2....return...")
            return
          end
          if 2 == cmd_type and "Ctrl_Replicate" == func then
            local ent_dict, entity_changes
            offset, ent_dict = msgpack.unpack_one(pack_data, offset)
            offset, entity_changes = msgpack.unpack_one(pack_data, offset)
          end
        end
      end
      if nil ~= downstream_body then
        local p_notify = downstream_body
        p_notify.request.args = {Param = unpack_param}
        if proto_module then
          proto_module.addNotify(p_notify)
        end
      end
    end
    
    override_register(connection, "DispatchLuaRpc", new_dispatchLuaRpc, origin_dispatchLuaRpc)
    local decompression_mt = getmetatable(lz4.new_decompression_stream()).__index
    local origin_decompress_safe = decompression_mt.decompress_safe
    
    local function new_decompress_safe(...)
      local result = origin_decompress_safe(...)
      last_pack_data = result
      return result
    end
    
    override_register(decompression_mt, "decompress_safe", new_decompress_safe, origin_decompress_safe)
    init_succ = true
  end
  
  function M.init(proto_test_module)
    proto_module = proto_test_module
    local result, msg = pcall(do_init)
    if false == result then
      print("prototest init failed", msg)
    end
  end
  
  function M.is_init_succ()
    return init_succ
  end
  
  function M.getStatus()
    local status = ""
    if protoTest_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if intercept_swtich then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if alter_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    return {status = status, remoteConfig = remote_config}
  end
  
  function M.executeCommand(data)
    local command = data.command
    local exe = CMD[command]
    if nil ~= exe then
      exe(data)
    end
  end
  
  function M.update()
  end
  
  function M.updateEveryFrame()
  end
  
  function CMD.start_protoTest()
    protoTest_switch = true
    override_change(false)
  end
  
  function CMD.stop_protoTest()
    protoTest_switch = false
    override_change(true)
  end
  
  function CMD.start_protoTest_intercept()
    intercept_swtich = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_intercept()
    intercept_swtich = false
    remote_config = {}
  end
  
  function CMD.start_protoTest_alter()
    alter_switch = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_alter()
    alter_switch = false
    remote_config = {}
  end
  
  function CMD.update_protoTest_config(data)
    local remote = data.remoteConfig
    remote_config = remote
    remote_config.rpcIndex = 1
    remote_config.ntfIndex = 1
  end
  
  function M.sendProtoGroup(...)
    local params = {
      ...
    }
    local protoRecordPatch = params[1]
    local respCallBack = params[2]
    local data = params[3]
    
    local function send(protos, i)
      local p = protos[i]
      local originRequestData = p.protoRecord.originRequestData
      if originRequestData.upstream == nil then
        local key = p.protoRecord.protoRequest.key
        local args = p.protoRecord.protoRequest.args
        local cmd = originRequestData.cmd
        local cmdParams = {
          key = key,
          args = msg_pack(args),
          sendByRemoteIndex = i
        }
        game.rpc_mgr.network:invoke(cmd, cmdParams)
      else
        local key = p.protoRecord.protoRequest.key
        local cmd = originRequestData.cmd
        local msg_body, msg_source = originRequestData.upstream.msg_body, originRequestData.upstream.msg_source
        local new_msg_body = p.protoRecord.protoRequest.args.Param
        if "CallControlRpc" == msg_source then
          local requestBody = msg_pack(true, msg_pack({
            new_msg_body[1],
            {
              msg = msg_pack(new_msg_body[2].msg)
            }
          }))
          local cmdParams = {
            key = key,
            args = msg_pack({Param = requestBody}),
            sendByRemoteIndex = i
          }
          from_upstream = true
          originRequestData.upstream.msg_body = new_msg_body
          upstream_body = originRequestData.upstream
          game.rpc_mgr.network:invoke(cmd, cmdParams)
        end
        if "CallEntityMsg" == msg_source then
          local requestBody = msg_pack(true, msg_pack({
            new_msg_body[1],
            {
              ent_id = new_msg_body[2].ent_id,
              func = new_msg_body[2].func,
              args = msg_pack(new_msg_body[2].args)
            }
          }))
          local cmdParams = {
            key = key,
            args = msg_pack({Param = requestBody}),
            sendByRemoteIndex = i
          }
          from_upstream = true
          originRequestData.upstream.msg_body = new_msg_body
          upstream_body = originRequestData.upstream
          game.rpc_mgr.network:invoke(cmd, cmdParams)
        end
      end
    end
    
    for k = 1, #protoRecordPatch do
      local ok = pcall(send, protoRecordPatch, k)
      if not ok then
        print("sendProtoGroup error: ", k)
      end
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.K1ProtoTestModule", function(require)
  local TimeUtil = require("LuaBoomer.Util.TimeUtil")
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  local M = {}
  local proto_module
  local override_map = {}
  local init_succ = false
  local protoTest_switch = false
  local intercept_swtich = true
  local alter_switch = true
  local CMD = {}
  local fake_request_session = 0
  local remote_config = {}
  
  local function override_register(table, prop, new, origin)
    local record = {
      table = table,
      prop = prop,
      new = new,
      origin = origin
    }
    override_map[tostring(table) .. prop] = record
  end
  
  local function override_change(isOrigin)
    for key, value in pairs(override_map) do
      if isOrigin then
        value.table[value.prop] = value.origin
      else
        value.table[value.prop] = value.new
      end
    end
  end
  
  local function next_session(lastSession)
    if lastSession >= 1073741824 then
      return 1
    end
    local newSession = lastSession + 1
    return 2 * newSession - 1
  end
  
  local function do_init()
    local pkgSProtoMgr = require("socket/pkgSProtoMgr")
    local client_host = pkgSProtoMgr.client_host
    if _G.c2s_new == nil or nil == client_host then
      return
    end
    local origin_c2s_new = _G.c2s_new
    
    local function new_c2s_new(...)
      print_w("luaboomer new_c2s_new", ...)
      local params = {
        ...
      }
      local name = params[1]
      local args = params[2]
      local noSession = params[3]
      local noPrint = params[4]
      local send_by_remote_index = params[5]
      local session
      if noSession then
        fake_request_session = fake_request_session - 1
        session = fake_request_session
      else
        session = next_session(pkgSProtoMgr.le_session)
      end
      local req_params = args
      local p_request = {
        target_host = nil,
        proto_name = name,
        request = req_params,
        session_id = session,
        timestamp = TimeUtil.time(),
        send_by_remote = false,
        origin_request_data = {cmd = name, params = params}
      }
      if proto_module then
        if nil ~= send_by_remote_index and send_by_remote_index > 0 then
          p_request.send_by_remote = true
          p_request.send_by_remote_index = send_by_remote_index
        end
        proto_module.addRequest(p_request)
      end
      origin_c2s_new(...)
    end
    
    override_register(_G, "c2s_new", new_c2s_new, origin_c2s_new)
    local hook_client_mt = getmetatable(client_host).__index
    local origin_dispatch = hook_client_mt.dispatch
    
    local function new_dispatch(...)
      local msg_type, arg1, arg2, arg3, arg4 = origin_dispatch(...)
      if "RESPONSE" == msg_type then
        local session = arg1
        local msgBody = arg2
        local ud = arg3
        local p_response = {
          target_host = nil,
          response = msgBody,
          session_id = session,
          timestamp = TimeUtil.time(),
          origin_dispatch_data = {
            msg_type = msg_type,
            arg1 = arg1,
            arg2 = arg2,
            arg3 = arg3,
            arg4 = arg4
          }
        }
        if proto_module then
          proto_module.addResponse(p_response)
        end
      else
        local name = arg1
        local msgBody = arg2
        local rspCb = arg3
        local ud = arg4
        local p_notify = {
          target_host = nil,
          proto_name = name,
          request = msgBody,
          timestamp = TimeUtil.time(),
          origin_dispatch_data = {
            msg_type = msg_type,
            arg1 = arg1,
            arg2 = arg2,
            arg3 = arg3,
            arg4 = arg4
          }
        }
        if proto_module then
          proto_module.addNotify(p_notify)
        end
      end
      return msg_type, arg1, arg2, arg3, arg4
    end
    
    override_register(hook_client_mt, "dispatch", new_dispatch, origin_dispatch)
    init_succ = true
  end
  
  function M.init(proto_test_module)
    proto_module = proto_test_module
    local result, msg = pcall(do_init)
    if false == result then
      print("prototest init failed", msg)
    end
  end
  
  function M.is_init_succ()
    return init_succ
  end
  
  function M.getStatus()
    local status = ""
    if protoTest_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if intercept_swtich then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if alter_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    return {status = status, remoteConfig = remote_config}
  end
  
  function M.executeCommand(data)
    local command = data.command
    local exe = CMD[command]
    if nil ~= exe then
      exe(data)
    end
  end
  
  function M.update()
  end
  
  function M.updateEveryFrame()
  end
  
  function CMD.start_protoTest()
    protoTest_switch = true
    override_change(false)
  end
  
  function CMD.stop_protoTest()
    protoTest_switch = false
    override_change(true)
  end
  
  function CMD.start_protoTest_intercept()
    intercept_swtich = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_intercept()
    intercept_swtich = false
    remote_config = {}
  end
  
  function CMD.start_protoTest_alter()
    alter_switch = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_alter()
    alter_switch = false
    remote_config = {}
  end
  
  function CMD.update_protoTest_config(data)
    local remote = data.remoteConfig
    remote_config = remote
    remote_config.rpcIndex = 1
    remote_config.ntfIndex = 1
  end
  
  function M.sendProtoGroup(...)
    local params = {
      ...
    }
    local protoRecordPatch = params[1]
    local respCallBack = params[2]
    local data = params[3]
    
    local function send(protos, i)
      local p = protos[i]
      local originRequestData = p.protoRecord.originRequestData
      local key = p.protoRecord.protoName
      local args = p.protoRecord.protoRequest
      local noSession = originRequestData.params[3]
      local noPrint = originRequestData.params[4]
      _G.c2s_new(key, args, noSession, noPrint, i)
    end
    
    for k = 1, #protoRecordPatch do
      local ok = pcall(send, protoRecordPatch, k)
      if not ok then
        print("sendProtoGroup error: ", k)
      end
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.K2ProtoTestModule", function(require)
  local TimeUtil = require("LuaBoomer.Util.TimeUtil")
  local M = {}
  local proto_module
  local override_map = {}
  local init_succ = false
  local protoTest_switch = false
  local intercept_swtich = true
  local alter_switch = true
  local CMD = {}
  local fake_request_session = 0
  local remote_config = {}
  
  local function override_register(table, prop, new, origin)
    local record = {
      table = table,
      prop = prop,
      new = new,
      origin = origin
    }
    override_map[tostring(table) .. prop] = record
    print("override_register", prop, record)
  end
  
  local function override_change(isOrigin)
    for key, value in pairs(override_map) do
      if isOrigin then
        value.table[value.prop] = value.origin
      else
        value.table[value.prop] = value.new
      end
    end
  end
  
  local function do_init()
    if not (NetManager and NetManager.NetConnect) or not NetManager.NetConnect.network.v_client then
      return
    end
    local network = debug.getmetatable(NetManager.NetConnect.network).__index
    local v_client = NetManager.NetConnect.network.v_client
    local origin_call = network.call
    
    local function new_call(...)
      local params = {
        ...
      }
      local self = params[1]
      local name = params[2]
      local args = params[3]
      local send_by_remote_index = params[5]
      print("luaBoomer new_call", params[5])
      local session = self.v_session_index
      local p_request = {
        target_host = nil,
        proto_name = name,
        request = args,
        session_id = session,
        timestamp = TimeUtil.time(),
        send_by_remote = false,
        origin_request_data = {
          cmd = name,
          params = {name, args}
        }
      }
      if proto_module then
        if nil ~= send_by_remote_index and send_by_remote_index > 0 then
          p_request.send_by_remote = true
          p_request.send_by_remote_index = send_by_remote_index
        end
        proto_module.addRequest(p_request)
      end
      do return origin_call, ... end
      return origin_call, ...
    end
    
    override_register(network, "call", new_call, origin_call)
    local origin_time_out_call = network.time_out_call
    
    local function new_time_out_call(...)
      local params = {
        ...
      }
      local self = params[1]
      local name = params[2]
      local args = params[3]
      local session = self.v_session_index
      local p_request = {
        target_host = nil,
        proto_name = name,
        request = args,
        session_id = session,
        timestamp = TimeUtil.time(),
        send_by_remote = false,
        origin_request_data = {
          cmd = name,
          params = {name, args}
        }
      }
      if proto_module then
        proto_module.addRequest(p_request)
      end
      do return origin_time_out_call, ... end
      return origin_time_out_call, ...
    end
    
    override_register(network, "time_out_call", new_time_out_call, origin_time_out_call)
    local origin_invoke = network.invoke
    
    local function new_invoke(...)
      local params = {
        ...
      }
      local self = params[1]
      local name = params[2]
      local args = params[3]
      fake_request_session = fake_request_session - 1
      local session = fake_request_session
      local p_request = {
        target_host = nil,
        proto_name = name,
        request = args,
        session_id = session,
        timestamp = TimeUtil.time(),
        send_by_remote = false,
        origin_request_data = {
          cmd = name,
          params = {name, args}
        }
      }
      if proto_module then
        proto_module.addRequest(p_request)
      end
      do return origin_invoke, ... end
      return origin_invoke, ...
    end
    
    override_register(network, "invoke", new_invoke, origin_invoke)
    local hook_client_mt = getmetatable(v_client).__index
    local origin_dispatch = hook_client_mt.dispatch
    
    local function new_dispatch(...)
      local _type, v1, v2, v3 = origin_dispatch(...)
      if "RESPONSE" == _type then
        local session, response = v1, v2
        local p_response = {
          target_host = nil,
          response = response,
          session_id = session,
          timestamp = TimeUtil.time(),
          origin_dispatch_data = {
            _type,
            v1,
            v2,
            v3
          }
        }
        if proto_module then
          proto_module.addResponse(p_response)
        end
      elseif "REQUEST" == _type then
        local name, request = v1, v2
        local p_notify = {
          target_host = nil,
          proto_name = name,
          request = request,
          timestamp = TimeUtil.time(),
          origin_dispatch_data = {
            _type,
            v1,
            v2,
            v3
          }
        }
        if proto_module then
          proto_module.addNotify(p_notify)
        end
      else
        print("unKnown dispatch type: " .. tostring(_type))
      end
      return _type, v1, v2, v3
    end
    
    override_register(hook_client_mt, "dispatch", new_dispatch, origin_dispatch)
    init_succ = true
    print("protoTest init seccessful")
  end
  
  function M.init(proto_test_module)
    proto_module = proto_test_module
    local result, msg = pcall(do_init)
    if false == result then
      print("prototest init failed", msg)
    end
  end
  
  function M.is_init_succ()
    return init_succ
  end
  
  function M.getStatus()
    local status = ""
    if protoTest_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if intercept_swtich then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if alter_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    return {status = status, remoteConfig = remote_config}
  end
  
  function M.executeCommand(data)
    local command = data.command
    local exe = CMD[command]
    if nil ~= exe then
      exe(data)
    end
  end
  
  function M.update()
  end
  
  function M.updateEveryFrame()
  end
  
  function CMD.start_protoTest()
    protoTest_switch = true
    override_change(false)
  end
  
  function CMD.stop_protoTest()
    protoTest_switch = false
    override_change(true)
  end
  
  function CMD.start_protoTest_intercept()
    intercept_swtich = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_intercept()
    intercept_swtich = false
    remote_config = {}
  end
  
  function CMD.start_protoTest_alter()
    alter_switch = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_alter()
    alter_switch = false
    remote_config = {}
  end
  
  function CMD.update_protoTest_config(data)
    local remote = data.remoteConfig
    remote_config = remote
    remote_config.rpcIndex = 1
    remote_config.ntfIndex = 1
  end
  
  function M.sendProtoGroup(...)
    local params = {
      ...
    }
    local protoRecordPatch = params[1]
    local respCallBack = params[2]
    local data = params[3]
    
    local function send(protos, i)
      local p = protos[i]
      local originRequestData = p.protoRecord.originRequestData
      local key = p.protoRecord.protoName
      local args = p.protoRecord.protoRequest
      NetManager.NetConnect.network:call(key, args, nil, i)
    end
    
    for k = 1, #protoRecordPatch do
      local ok = pcall(send, protoRecordPatch, k)
      if not ok then
        print("sendProtoGroup error: ", k)
      end
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.Z1ProtoTestModule", function(require)
  local TimeUtil = require("LuaBoomer.Util.TimeUtil")
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  local cmsgpack = require("cmsgpack")
  local msg_pack = cmsgpack.pack
  local msg_unpack = cmsgpack.unpack
  local RpcMgr = require("Network.RpcMgr")
  local M = {}
  local proto_module
  local override_map = {}
  local init_succ = false
  local protoTest_switch = false
  local intercept_swtich = true
  local alter_switch = true
  local CMD = {}
  local fake_request_session = 0
  local remote_config = {}
  
  local function override_register(table, prop, new, origin)
    local record = {
      table = table,
      prop = prop,
      new = new,
      origin = origin
    }
    override_map[tostring(table) .. prop] = record
    print("override_register", prop, record)
  end
  
  local function override_change(isOrigin)
    for key, value in pairs(override_map) do
      if isOrigin then
        value.table[value.prop] = value.origin
      else
        value.table[value.prop] = value.new
      end
    end
  end
  
  local public_cmd = {
    ["Base.CommonCall"] = true,
    ["Base.CommonSend"] = true,
    ["Base.BattleCall"] = true,
    ["Base.BattleSend"] = true
  }
  
  local function network_do_init()
    if not (RpcMgr and RpcMgr.Instance and RpcMgr.Instance.network and RpcMgr.Instance.network.v_client) or init_succ then
      return
    end
    local network = debug.getmetatable(RpcMgr.Instance.network).__index
    local v_client = RpcMgr.Instance.network.v_client
    local origin_call = network.call
    
    local function new_call(...)
      local params = {
        ...
      }
      local self = params[1]
      local name = params[2]
      local args = params[3]
      local send_by_remote_index = params[6]
      local session = self.v_session_index
      local request_param = args
      local key = name
      if public_cmd[name] then
        key = args.key
        request_param = msg_unpack(args.args)
        args = {key = key, args = request_param}
      end
      local p_request = {
        target_host = nil,
        proto_name = key,
        request = request_param,
        session_id = session,
        timestamp = TimeUtil.time(),
        send_by_remote = false,
        origin_request_data = {cmd = name, params = args}
      }
      if proto_module then
        if nil ~= send_by_remote_index and send_by_remote_index > 0 then
          p_request.send_by_remote = true
          p_request.send_by_remote_index = send_by_remote_index
        end
        proto_module.addRequest(p_request)
      end
      do return origin_call, ... end
      return origin_call, ...
    end
    
    override_register(network, "call", new_call, origin_call)
    local origin_invoke = network.invoke
    
    local function new_invoke(...)
      local params = {
        ...
      }
      local self = params[1]
      local name = params[2]
      local args = params[3]
      fake_request_session = fake_request_session - 1
      local session = fake_request_session
      local request_param = args
      local key = name
      if public_cmd[name] then
        key = args.key
        request_param = msg_unpack(args.args)
        args = {key = key, args = request_param}
      end
      local p_request = {
        target_host = nil,
        proto_name = key,
        request = request_param,
        session_id = session,
        timestamp = TimeUtil.time(),
        send_by_remote = false,
        origin_request_data = {cmd = name, params = args}
      }
      if proto_module then
        proto_module.addRequest(p_request)
      end
      do return origin_invoke, ... end
      return origin_invoke, ...
    end
    
    override_register(network, "invoke", new_invoke, origin_invoke)
    local hook_client_mt = getmetatable(v_client).__index
    local origin_dispatch = hook_client_mt.dispatch
    
    local function new_dispatch(...)
      local _type, v1, v2, v3 = origin_dispatch(...)
      if "RESPONSE" == _type then
        local session, response = v1, v2
        if 0 == response.ret then
          response = JsonUtil.clone(v2)
          response.result = RpcMgr.Instance:UnpackParma(response.result)
        end
        local p_response = {
          target_host = nil,
          response = response,
          session_id = session,
          timestamp = TimeUtil.time(),
          origin_dispatch_data = {
            _type,
            v1,
            response,
            v3
          }
        }
        if proto_module then
          proto_module.addResponse(p_response)
        end
      elseif "REQUEST" == _type then
        local name = v1
        local request = JsonUtil.clone(v2)
        request.args = RpcMgr.Instance:UnpackParma(request.args)
        local p_notify = {
          target_host = nil,
          proto_name = name,
          request = request,
          timestamp = TimeUtil.time(),
          origin_dispatch_data = {
            _type,
            v1,
            request,
            v3
          }
        }
        if proto_module then
          proto_module.addNotify(p_notify)
        end
      else
        print("unKnown dispatch type: " .. tostring(_type))
      end
      return _type, v1, v2, v3
    end
    
    override_register(hook_client_mt, "dispatch", new_dispatch, origin_dispatch)
    init_succ = true
    if protoTest_switch then
      override_change(false)
    end
    print("protoTest init successfull")
  end
  
  local rpc_mgr_init_succ = false
  
  local function rpcMgr_do_init()
    if not (RpcMgr and RpcMgr.Instance) or rpc_mgr_init_succ then
      return
    end
    local rpcMgr_mt = debug.getmetatable(RpcMgr.Instance)
    local origin_rpcMgr_connect = rpcMgr_mt.Connect
    
    local function new_rpcMgr_connect(...)
      local result_table = table.pack(origin_rpcMgr_connect(...))
      if not init_succ then
        network_do_init()
        rpcMgr_mt.Connect = origin_rpcMgr_connect
      end
      do return table.unpack end
      return table.unpack, result_table
    end
    
    rpcMgr_mt.Connect = new_rpcMgr_connect
    rpc_mgr_init_succ = true
  end
  
  local function do_init(...)
    rpcMgr_do_init(...)
    network_do_init(...)
  end
  
  function M.init(proto_test_module)
    proto_module = proto_test_module
    local result, msg = pcall(do_init)
    if false == result then
      print("prototest init failed", msg)
    end
  end
  
  function M.is_init_succ()
    return init_succ
  end
  
  function M.getStatus()
    local status = ""
    if protoTest_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if intercept_swtich then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if alter_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    return {status = status, remoteConfig = remote_config}
  end
  
  function M.executeCommand(data)
    local command = data.command
    local exe = CMD[command]
    if nil ~= exe then
      exe(data)
    end
  end
  
  function M.update()
  end
  
  function M.updateEveryFrame()
  end
  
  function CMD.start_protoTest()
    protoTest_switch = true
    override_change(false)
  end
  
  function CMD.stop_protoTest()
    protoTest_switch = false
    override_change(true)
  end
  
  function CMD.start_protoTest_intercept()
    intercept_swtich = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_intercept()
    intercept_swtich = false
    remote_config = {}
  end
  
  function CMD.start_protoTest_alter()
    alter_switch = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_alter()
    alter_switch = false
    remote_config = {}
  end
  
  function CMD.update_protoTest_config(data)
    local remote = data.remoteConfig
    remote_config = remote
    remote_config.rpcIndex = 1
    remote_config.ntfIndex = 1
  end
  
  function M.sendProtoGroup(...)
    local params = {
      ...
    }
    local protoRecordPatch = params[1]
    local respCallBack = params[2]
    local data = params[3]
    
    local function cb()
    end
    
    local function send(protos, i)
      local p = protos[i]
      local originRequestData = p.protoRecord.originRequestData
      local key = p.protoRecord.protoName
      local args = p.protoRecord.protoRequest
      local cmd, request_param = key, args
      if originRequestData then
        cmd = originRequestData.cmd
        if public_cmd[cmd] then
          request_param = {
            key = key,
            args = msg_pack(args)
          }
        end
      end
      RpcMgr.Instance.network:call(cmd, request_param, cb, nil, i)
    end
    
    for k = 1, #protoRecordPatch do
      local ok = pcall(send, protoRecordPatch, k)
      if not ok then
        print("sendProtoGroup error: ", k)
      end
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.Q6ProtoTestModule", function(require)
  local TimeUtil = require("LuaBoomer.Util.TimeUtil")
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  local Net = require("Service.NetService")
  
  local function getTargetUpvalue(fun, upvalueName)
    local isEnd = false
    local result
    local i = 1
    while not isEnd do
      local name, val = debug.getupvalue(fun, i)
      if nil == name then
        isEnd = true
      end
      if name == upvalueName then
        isEnd = true
        result = val
      else
        i = i + 1
      end
    end
    return result
  end
  
  local M = {}
  local proto_module
  local override_map = {}
  local init_succ = false
  local protoTest_switch = false
  local intercept_swtich = true
  local alter_switch = true
  local CMD = {}
  local fake_request_session = 0
  local is_sending_by_remote_index = 0
  local remote_config = {}
  
  local function override_register(table, prop, new, origin)
    local record = {
      table = table,
      prop = prop,
      new = new,
      origin = origin
    }
    override_map[tostring(table) .. prop] = record
    print("override_register", prop, record)
  end
  
  local function override_change(isOrigin)
    for key, value in pairs(override_map) do
      if isOrigin then
        value.table[value.prop] = value.origin
      else
        value.table[value.prop] = value.new
      end
    end
  end
  
  local isConnectHookReady
  
  local function do_main_init()
    if nil ~= Net and nil ~= Net.network and nil ~= Net.network.srpc_obj then
      isConnectHookReady = true
      local network = Net.network.srpc_obj
      local network_mt = debug.getmetatable(network)
      local origin_call = network_mt.call
      
      local function new_call(...)
        local session_id = network.cur_session
        local args = {
          ...
        }
        local proto_name, req_params = args[3], args[4]
        if req_params then
          local send_by_remote = false
          if nil ~= is_sending_by_remote_index and is_sending_by_remote_index > 0 then
            send_by_remote = true
          end
          local p_request = {
            target_host = "",
            proto_name = proto_name,
            request = req_params,
            session_id = session_id,
            timestamp = TimeUtil.time(),
            send_by_remote = send_by_remote
          }
          if proto_module then
            proto_module.addRequest(p_request)
          end
        end
        do return origin_call, ... end
        return origin_call, ...
      end
      
      override_register(network_mt, "call", new_call, origin_call)
      local origin_send = network_mt.send
      
      local function new_send(...)
        fake_request_session = fake_request_session - 1
        local session_id = fake_session_id
        local args = {
          ...
        }
        local proto_name, req_params = args[3], args[4]
        if req_params then
          local p_request = {
            target_host = "",
            proto_name = proto_name,
            request = req_params,
            session_id = session_id,
            timestamp = TimeUtil.time(),
            send_by_remote = false
          }
          if proto_module then
            proto_module.addRequest(p_request)
          end
        end
        do return origin_send, ... end
        return origin_send, ...
      end
      
      override_register(network_mt, "send", new_send, origin_send)
      local origin_dispatch_request = network_mt.dispatch_request
      
      local function new_dispatch_request(...)
        local args = {
          ...
        }
        local msg = args[3]
        local proto_name = msg:headerget("method")
        local ret, err, headers = origin_dispatch_request(...)
        local Codecs = getTargetUpvalue(origin_dispatch_request, "Codecs")
        local codec = Codecs.get_codec(msg:headerget("codec"))
        local ok, payload = codec.unmarshal(msg:get_payload(), proto_name, true)
        if ok then
          local p_notify = {
            target_host = "",
            proto_name = proto_name,
            request = payload,
            timestamp = TimeUtil.time(),
            origin_dispatch_data = {
              msg = msg,
              ret = ret,
              err = err,
              headers = headers
            }
          }
          if proto_module then
            proto_module.addNotify(p_notify)
          end
        end
        return ret, err, headers
      end
      
      override_register(network_mt, "dispatch_request", new_dispatch_request, origin_dispatch_request)
      local origin_dispatch_response = network_mt.dispatch_response
      
      local function new_dispatch_response(...)
        local args = {
          ...
        }
        local msg = args[3]
        local session_id = msg:headerget("session")
        local ctx = network.sessions[session_id]
        local resp = msg
        local code = tonumber(resp:headerget("code"))
        local method = ctx.method
        local valid, data = network.codec.unmarshal(resp:get_payload(), method, false)
        if valid then
          local p_response = {
            target_host = "",
            response = data,
            session_id = session_id,
            timestamp = TimeUtil.time(),
            origin_dispatch_data = {ctx = ctx}
          }
          if proto_module then
            proto_module.addResponse(p_response)
          end
        end
        do return origin_dispatch_response, ... end
        return origin_dispatch_response, ...
      end
      
      override_register(network_mt, "dispatch_response", new_dispatch_response, origin_dispatch_response)
      init_succ = true
      if protoTest_switch then
        override_change(false)
      end
      return true
    end
  end
  
  local function do_connect_init()
    if nil ~= Net and nil ~= Net.Connect then
      local origin_connect = Net.Connect
      
      local function new_connect(...)
        origin_connect(...)
        do_main_init()
      end
      
      override_register(Net, "Connect", new_connect, origin_connect)
      isConnectHookReady = true
    end
  end
  
  local function do_init()
    if not isConnectHookReady then
      do_connect_init()
    end
    if not is_init_succ then
      do_main_init()
    end
  end
  
  function M.init(proto_test_module)
    proto_module = proto_test_module
    local result, msg = pcall(do_init)
    if false == result then
      print("prototest init failed", msg)
    end
  end
  
  function M.is_init_succ()
    return init_succ
  end
  
  function M.getStatus()
    local status = ""
    if protoTest_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if intercept_swtich then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if alter_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    return {status = status, remoteConfig = remote_config}
  end
  
  function M.executeCommand(data)
    local command = data.command
    local exe = CMD[command]
    if nil ~= exe then
      exe(data)
    end
  end
  
  function M.update()
  end
  
  function M.updateEveryFrame()
  end
  
  function CMD.start_protoTest()
    protoTest_switch = true
    override_change(false)
  end
  
  function CMD.stop_protoTest()
    protoTest_switch = false
    override_change(true)
  end
  
  function CMD.start_protoTest_intercept()
    intercept_swtich = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_intercept()
    intercept_swtich = false
    remote_config = {}
  end
  
  function CMD.start_protoTest_alter()
    alter_switch = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_alter()
    alter_switch = false
    remote_config = {}
  end
  
  function CMD.update_protoTest_config(data)
    local remote = data.remoteConfig
    remote_config = remote
    remote_config.rpcIndex = 1
    remote_config.ntfIndex = 1
  end
  
  function M.sendProtoGroup(...)
    local params = {
      ...
    }
    local protoRecordPatch = params[1]
    local respCallBack = params[2]
    local data = params[3]
    
    local function send(protos, i)
      local p = protos[i]
      local originRequestData = p.protoRecord.originRequestData
      local key = p.protoRecord.protoName
      local args = p.protoRecord.protoRequest
      is_sending_by_remote_index = i
      Net:Call(key, args, function()
      end)
      is_sending_by_remote_index = 0
    end
    
    for k = 1, #protoRecordPatch do
      local ok = pcall(send, protoRecordPatch, k)
      if not ok then
        print("sendProtoGroup error: ", k)
      end
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.X30ProtoTestModuleV2", function(require)
  local TimeUtil = require("LuaBoomer.Util.TimeUtil")
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  
  local function getTargetUpvalue(fun, upvalueName)
    local isEnd = false
    local result
    local i = 1
    while not isEnd do
      local name, val = debug.getupvalue(fun, i)
      if nil == name then
        isEnd = true
      end
      if name == upvalueName then
        isEnd = true
        result = val
      else
        i = i + 1
      end
    end
    return result
  end
  
  local M = {}
  local proto_module
  local override_map = {}
  local init_succ = false
  local protoTest_switch = false
  local intercept_swtich = true
  local alter_switch = true
  local CMD = {}
  local fake_request_session = 0
  local is_sending_by_remote_index = 0
  local remote_config = {}
  
  local function override_register(table, prop, new, origin)
    local record = {
      table = table,
      prop = prop,
      new = new,
      origin = origin
    }
    override_map[tostring(table) .. prop] = record
    print("override_register", prop, record, new, origin)
  end
  
  local function override_change(isOrigin)
    for key, value in pairs(override_map) do
      if isOrigin then
        value.table[value.prop] = value.origin
      else
        value.table[value.prop] = value.new
      end
    end
  end
  
  local isConnectHookReady
  
  local function next_session(cur_session)
    local n = tonumber(cur_session)
    if cur_session > 2000000 then
      return "1"
    end
    n = n + 1
    do return tostring end
    return tostring, n
  end
  
  local function do_init()
    if global ~= nil and nil ~= global.netMgr and nil ~= global.netMgr._network and nil ~= global.netMgr._network.srpc_obj then
      local network = global.netMgr
      local srpc_obj = network._network.srpc_obj
      local origin_doSendRequest = network.doSendRequest
      
      local function new_doSendRequest(...)
        local params = {
          ...
        }
        local request = params[2]
        local protoName = request:getProtoName()
        local msg = request:getMsg()
        local session = srpc_obj.cur_session
        local req_params = {key = protoName, args = msg}
        if req_params then
          local p_request = {
            target_host = nil,
            proto_name = req_params.key,
            request = req_params.args,
            session_id = session,
            timestamp = TimeUtil.time(),
            send_by_remote = false
          }
          if proto_module then
            if nil ~= is_sending_by_remote_index and is_sending_by_remote_index > 0 then
              p_request.send_by_remote = true
              p_request.send_by_remote_index = is_sending_by_remote_index
              send_by_remote = false
            end
            proto_module.addRequest(p_request)
          end
        end
        do return origin_doSendRequest, ... end
        return origin_doSendRequest, ...
      end
      
      override_register(network, "doSendRequest", new_doSendRequest, origin_doSendRequest)
      local old_dispatchReq = network._dispatchReq
      
      local function new_dispatchReq(...)
        local params = {
          ...
        }
        local response = params[2]
        local protoName = params[3]
        local p_notify = {
          target_host = nil,
          proto_name = protoName,
          request = response,
          timestamp = TimeUtil.time(),
          origin_dispatch_data = {
            "REQUEST",
            protoName,
            response
          }
        }
        if proto_module then
          proto_module.addNotify(p_notify)
        end
        do return old_dispatchReq, ... end
        return old_dispatchReq, ...
      end
      
      override_register(network, "_dispatchReq", new_dispatchReq, old_dispatchReq)
      local old_handle_response = srpc_obj._handle_response
      
      local function new_handle_response(...)
        local return_value = table.pack(old_handle_response(...))
        local data = return_value[1]
        if nil ~= data then
          local params = {
            ...
          }
          local call = params[2]
          local session = call.msg:headerget("session")
          local response = data
          if nil ~= response then
            local p_response = {
              target_host = nil,
              response = response,
              session_id = session,
              timestamp = TimeUtil.time(),
              origin_dispatch_data = {
                "RESPONSE",
                session,
                response
              }
            }
            if proto_module then
              proto_module.addResponse(p_response)
            end
          end
        end
        do return table.unpack end
        return table.unpack, return_value, call.msg:headerget("session"), data, {
          target_host = nil,
          response = response,
          session_id = session,
          timestamp = TimeUtil.time(),
          origin_dispatch_data = {
            "RESPONSE",
            session,
            response
          }
        }, proto_module.addResponse, p_response, session, response
      end
      
      override_register(srpc_obj, "_handle_response", new_handle_response, old_handle_response)
      init_succ = true
      if true == protoTest_switch then
        override_change(false)
      end
      print("protoTest init seccessful")
    end
  end
  
  function M.init(proto_test_module)
    proto_module = proto_test_module
    local result, msg = pcall(do_init)
    if false == result then
      print("prototest init failed", msg)
    end
  end
  
  function M.is_init_succ()
    return init_succ
  end
  
  function M.getStatus()
    local status = ""
    if protoTest_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if intercept_swtich then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if alter_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    return {status = status, remoteConfig = remote_config}
  end
  
  function M.executeCommand(data)
    local command = data.command
    local exe = CMD[command]
    if nil ~= exe then
      exe(data)
    end
  end
  
  function M.update()
  end
  
  function M.updateEveryFrame()
  end
  
  function CMD.start_protoTest()
    protoTest_switch = true
    override_change(false)
  end
  
  function CMD.stop_protoTest()
    protoTest_switch = false
    override_change(true)
  end
  
  function CMD.start_protoTest_intercept()
    intercept_swtich = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_intercept()
    intercept_swtich = false
    remote_config = {}
  end
  
  function CMD.start_protoTest_alter()
    alter_switch = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_alter()
    alter_switch = false
    remote_config = {}
  end
  
  function CMD.update_protoTest_config(data)
    local remote = data.remoteConfig
    remote_config = remote
    remote_config.rpcIndex = 1
    remote_config.ntfIndex = 1
  end
  
  function M.sendProtoGroup(...)
    local params = {
      ...
    }
    local protoRecordPatch = params[1]
    local respCallBack = params[2]
    local data = params[3]
    
    local function send(protos, i)
      local p = protos[i]
      local originRequestData = p.protoRecord.originRequestData
      local key = p.protoRecord.protoName
      local args = p.protoRecord.protoRequest
      is_sending_by_remote_index = i
      global.netMgr:sendMsg(key, args)
      is_sending_by_remote_index = 0
    end
    
    for k = 1, #protoRecordPatch do
      local ok, error = pcall(send, protoRecordPatch, k)
      if not ok then
        print("sendProtoGroup error: ", k, error)
      end
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.M9ProtoTestModule", function(require)
  local TimeUtil = require("LuaBoomer.Util.TimeUtil")
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  
  local function getTargetUpvalue(fun, upvalueName)
    local isEnd = false
    local result
    local i = 1
    while not isEnd do
      local name, val = debug.getupvalue(fun, i)
      if nil == name then
        isEnd = true
      end
      if name == upvalueName then
        isEnd = true
        result = val
      else
        i = i + 1
      end
    end
    return result
  end
  
  local M = {}
  local proto_module
  local override_map = {}
  local init_succ = false
  local protoTest_switch = false
  local intercept_swtich = true
  local alter_switch = true
  local CMD = {}
  local fake_request_session = 0
  
  local function get_fake_request_session()
    local session_id = fake_request_session
    fake_request_session = fake_request_session - 1
    return session_id
  end
  
  local is_sending_by_remote_index = 0
  local send_by_remote = false
  local remote_config = {}
  
  local function override_register(table, prop, new, origin)
    local record = {
      table = table,
      prop = prop,
      new = new,
      origin = origin
    }
    override_map[tostring(table) .. prop] = record
    print("override_register", prop, record, new, origin)
  end
  
  local function override_change(isOrigin)
    for key, value in pairs(override_map) do
      if isOrigin then
        value.table[value.prop] = value.origin
      else
        value.table[value.prop] = value.new
      end
    end
  end
  
  local function do_init()
    if __worker ~= nil then
      local origin_command_request = __worker._command_request
      
      local function new_command_request(...)
        local params = {
          ...
        }
        local self = params[1]
        local entity_id = params[3]
        local component_id = params[4]
        local cmd = params[5]
        local req = params[6]
        local session_id = params[7]
        session_id = session_id or get_fake_request_session()
        local p_request = {
          target_host = nil,
          proto_name = cmd,
          request = req,
          session_id = session_id,
          timestamp = TimeUtil.time(),
          send_by_remote = false,
          origin_request_data = {entity_id = entity_id, component_id = component_id}
        }
        if proto_module then
          if nil ~= is_sending_by_remote_index and is_sending_by_remote_index > 0 then
            p_request.send_by_remote = true
            p_request.send_by_remote_index = is_sending_by_remote_index
            send_by_remote = false
          end
          proto_module.addRequest(p_request)
        end
        do return origin_command_request, ... end
        return origin_command_request, ...
      end
      
      override_register(__worker, "_command_request", new_command_request, origin_command_request)
      local ViewDiff = require("rw.worker.connection.diff")
      local origin_command_response_callback = ViewDiff.command_response_callback
      
      local function new_command_response_callback(...)
        local params = {
          ...
        }
        local data = params[2]
        local session_id = data.request_id
        local response = data.response
        if nil ~= response then
          local p_response = {
            target_host = nil,
            response = response,
            session_id = session_id,
            timestamp = TimeUtil.time(),
            origin_dispatch_data = {
              "RESPONSE",
              session = session_id,
              response
            }
          }
          if proto_module then
            proto_module.addResponse(p_response)
          end
        end
        do return origin_command_response_callback, ... end
        return origin_command_response_callback, ...
      end
      
      override_register(ViewDiff, "command_response_callback", new_command_response_callback, origin_command_response_callback)
      local origin_command_request_callback = ViewDiff.command_request_callback
      
      local function new_command_request_callback(...)
        local params = {
          ...
        }
        local data = params[2]
        local cmd = data.cmd
        local request = data.request
        local p_notify = {
          target_host = nil,
          proto_name = cmd,
          request = request,
          timestamp = TimeUtil.time(),
          origin_dispatch_data = {
            "REQUEST",
            protoName = cmd,
            request
          }
        }
        if proto_module then
          proto_module.addNotify(p_notify)
        end
        do return origin_command_request_callback, ... end
        return origin_command_request_callback, ...
      end
      
      override_register(ViewDiff, "command_request_callback", new_command_request_callback, origin_command_request_callback)
      init_succ = true
      if true == protoTest_switch then
        override_change(false)
      end
      print("protoTest init seccessful")
    end
  end
  
  function M.init(proto_test_module)
    proto_module = proto_test_module
    local result, msg = pcall(do_init)
    if false == result then
      print("prototest init failed", msg)
    end
  end
  
  function M.is_init_succ()
    return init_succ
  end
  
  function M.getStatus()
    local status = ""
    if protoTest_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if intercept_swtich then
      status = status .. "1"
    else
      status = status .. "0"
    end
    if alter_switch then
      status = status .. "1"
    else
      status = status .. "0"
    end
    return {status = status, remoteConfig = remote_config}
  end
  
  function M.executeCommand(data)
    local command = data.command
    local exe = CMD[command]
    if nil ~= exe then
      exe(data)
    end
  end
  
  function M.update()
  end
  
  function M.updateEveryFrame()
  end
  
  function CMD.start_protoTest()
    protoTest_switch = true
    override_change(false)
  end
  
  function CMD.stop_protoTest()
    protoTest_switch = false
    override_change(true)
  end
  
  function CMD.start_protoTest_intercept()
    intercept_swtich = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_intercept()
    intercept_swtich = false
    remote_config = {}
  end
  
  function CMD.start_protoTest_alter()
    alter_switch = true
    remote_config = {}
  end
  
  function CMD.stop_protoTest_alter()
    alter_switch = false
    remote_config = {}
  end
  
  function CMD.update_protoTest_config(data)
    local remote = data.remoteConfig
    remote_config = remote
    remote_config.rpcIndex = 1
    remote_config.ntfIndex = 1
  end
  
  function M.sendProtoGroup(...)
    local params = {
      ...
    }
    local protoRecordPatch = params[1]
    local respCallBack = params[2]
    local data = params[3]
    
    local function send(protos, i)
      local p = protos[i]
      local originRequestData = p.protoRecord.originRequestData
      local key = p.protoRecord.protoName
      local args = p.protoRecord.protoRequest
      local entity_id = originRequestData.entity_id
      local component_id = originRequestData.component_id
      is_sending_by_remote_index = i
      __worker:call_command(entity_id, component_id, key, args)
      is_sending_by_remote_index = 0
    end
    
    for k = 1, #protoRecordPatch do
      local ok, error = pcall(send, protoRecordPatch, k)
      if not ok then
        print("sendProtoGroup error: ", k, error)
      end
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ProtoTest.ProtoTestModule", function(require)
  local M = {}
  local config
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local proto_test_impl
  local module_handler = "ProtoTestModule"
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  local Json4lua = require("LuaBoomer.Util.Json4lua")
  local sendByRemote = false
  local sendByRemoteIndex = -1
  
  local function _reportStatus()
    if not proto_test_impl then
      return
    end
    assert(type(proto_test_impl.getStatus) == "function", "getStatus should be a function")
    local data = proto_test_impl.getStatus()
    data.type = "protoTestStatus"
    network_core.requestMsg(module_handler, data)
  end
  
  local function _update()
    if not proto_test_impl then
      return
    end
    assert(type(proto_test_impl.update) == "function", "getStatus should be a function")
    proto_test_impl.update()
  end
  
  function M.respCallBack()
  end
  
  function M.isSendingByRemote()
    return sendByRemote
  end
  
  function M.getSendByRemoteIndex()
    return sendByRemoteIndex
  end
  
  function M.sendProto(data)
    if not proto_test_impl then
      return
    end
    if not data.protoRecord then
      return false
    end
    local protoRecord = JsonUtil.decode(data.protoRecord)
    print("do sendProto here", table.tostring(protoRecord))
    sendByRemote = true
    sendByRemoteIndex = protoRecord.sendIndex
    proto_test_impl.sendProto(protoRecord, M.respCallBack)
    sendByRemote = false
  end
  
  function M.sendProtoGroup(data)
    if not proto_test_impl then
      return
    end
    if not data.protoRecords then
      return false
    end
    local interval = 0
    local times = 1
    if data.interval ~= nil then
      interval = data.interval
    end
    if nil ~= data.times then
      times = data.times
    end
    local originProtoRecords = data.protoRecords
    local protoRecords = {}
    for k = 1, #originProtoRecords do
      local protoRecord = M.decode(originProtoRecords[k])
      protoRecords[k] = {protoRecord = protoRecord}
      if nil ~= protoRecord.delay then
        protoRecords[k].delay = protoRecord.delay
      end
    end
    local protoRecordPatch = {}
    for i = 1, times do
      local item = JsonUtil.clone(protoRecords)
      if i > 1 then
        if nil ~= item[1].delay then
          item[1].delay = item[1].delay + interval
        else
          item[1].delay = interval
        end
      end
      JsonUtil.concat(protoRecordPatch, item)
    end
    proto_test_impl.sendProtoGroup(protoRecordPatch, M.respCallBack, data)
  end
  
  local blocks_max_size = 4098
  local current_blocks = ""
  local blocks_list = {}
  
  function M.addBlock(block)
    current_blocks = current_blocks .. block
    if #current_blocks >= blocks_max_size then
      table.insert(blocks_list, current_blocks)
      current_blocks = ""
    end
  end
  
  function M.encode(obj)
    if config.project == "S3" or config.project == "m2" or config.project == "M6" then
      do return Json4lua.encode end
      return Json4lua.encode, obj, nil
    end
    do return JsonUtil.encode, obj end
    return JsonUtil.encode, obj, true
  end
  
  function M.decode(obj)
    if config.project == "S3" or config.project == "m2" or config.project == "M6" then
      do return Json4lua.decode end
      return Json4lua.decode, obj, nil
    end
    do return JsonUtil.decode, obj end
    return JsonUtil.decode, obj, true
  end
  
  function M.addRequest(request)
    local encoded = M.encode(request)
    M.addBlock("req`" .. encoded .. "@%&#")
  end
  
  function M.addResponse(response)
    local encoded = M.encode(response)
    M.addBlock("res`" .. encoded .. "@%&#")
  end
  
  function M.addNotify(notify)
    local encoded = M.encode(notify)
    M.addBlock("ntf`" .. encoded .. "@%&#")
  end
  
  local function splitBlockAndSend(blocks)
    local len = string.len(blocks)
    local splitIndex = 1
    while len >= splitIndex do
      local subBlocks = string.sub(blocks, splitIndex, splitIndex + blocks_max_size - 1)
      network_core.requestMsg(module_handler, {
        blocks = subBlocks,
        type = "clientProtoRecord"
      })
      splitIndex = splitIndex + blocks_max_size
    end
  end
  
  function M.flushSendProto()
    if #blocks_list > 0 then
      for i = 1, #blocks_list do
        local blocks = blocks_list[i]
        splitBlockAndSend(blocks)
      end
      blocks_list = {}
    end
    if #current_blocks > 0 then
      splitBlockAndSend(current_blocks)
      current_blocks = ""
    end
  end
  
  function M.executeCommand(data)
    if not proto_test_impl then
      return
    end
    proto_test_impl.executeCommand(data)
  end
  
  function M.init(conf)
    config = conf
    if conf.project == "s6" then
      proto_test_impl = require("LuaBoomer.LocalModule.ProtoTest.S6ProtoTestModuleV2")
    end
    if conf.project == "m1" or conf.project == "m2" or conf.project == "m1p" then
      proto_test_impl = require("LuaBoomer.LocalModule.ProtoTest.M1ProtoTestModule")
    end
    if conf.project == "m5" then
      proto_test_impl = require("LuaBoomer.LocalModule.ProtoTest.M5ProtoTestModule")
    end
    if conf.project == "S3" or conf.project == "s3g" then
      proto_test_impl = require("LuaBoomer.LocalModule.ProtoTest.S3ProtoTestModule")
    end
    if conf.project == "M6" then
      proto_test_impl = require("LuaBoomer.LocalModule.ProtoTest.M6ProtoTestModule")
    end
    if conf.project == "k1" then
      proto_test_impl = require("LuaBoomer.LocalModule.ProtoTest.K1ProtoTestModule")
    end
    if conf.project == "k2" then
      proto_test_impl = require("LuaBoomer.LocalModule.ProtoTest.K2ProtoTestModule")
    end
    if conf.project == "z1" then
      proto_test_impl = require("LuaBoomer.LocalModule.ProtoTest.Z1ProtoTestModule")
    end
    if conf.project == "q6" then
      proto_test_impl = require("LuaBoomer.LocalModule.ProtoTest.Q6ProtoTestModule")
    end
    if conf.project == "x30" then
      proto_test_impl = require("LuaBoomer.LocalModule.ProtoTest.X30ProtoTestModuleV2")
    end
    if conf.project == "m9" then
      proto_test_impl = require("LuaBoomer.LocalModule.ProtoTest.M9ProtoTestModule")
    end
    if nil ~= proto_test_impl then
      proto_test_impl.init(M)
    end
  end
  
  function M.onReceive(msg)
    local data = msg.data
    local type = data.type
    if "protoRecord" == type then
      M.sendProto(msg.data)
    elseif "protoRecords" == type then
      M.sendProtoGroup(msg.data)
    elseif "command" == type then
      M.executeCommand(msg.data)
    else
      print("unknown protoTest msg type", type)
    end
    _reportStatus()
  end
  
  function M.update(delta_time)
    if nil ~= proto_test_impl and not proto_test_impl.is_init_succ() then
      proto_test_impl.init(M)
    end
    M.flushSendProto()
    _reportStatus()
    _update()
  end
  
  function M.updateEveryFrame(delta_time)
    if not proto_test_impl then
      return
    end
    if nil ~= proto_test_impl then
      assert(type(proto_test_impl.update) == "function", "getStatus should be a function")
      proto_test_impl.updateEveryFrame()
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.FileViewManager.FileViewModule", function(require)
  local M = {}
  local CMD = {}
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local module_handler = "FileViewModule"
  local max_block_size = 16384
  local fileViewImpl
  
  function M.init(conf)
    if conf and conf.fileViewImpl then
      fileViewImpl = require(conf.fileViewImpl)
    end
  end
  
  function CMD.getFileList()
    local file_list = {}
    if fileViewImpl then
      file_list = fileViewImpl.getFileList()
    end
    local data = {
      msg = "file_list",
      data = {file_list = file_list}
    }
    network_core.requestMsg(module_handler, data)
  end
  
  function CMD.getFile(params)
    local fileName = params.file_name
    local filePath = params.file_path
    local sessionId = params.session_id
    local content = ""
    if fileViewImpl then
      content = fileViewImpl.getFile(filePath)
    end
    local block_total_count = math.ceil(#content / max_block_size)
    print(fileName .. " upload count is " .. block_total_count)
    for index = 1, block_total_count do
      local block = string.sub(content, (index - 1) * max_block_size + 1, index * max_block_size)
      local data = {
        msg = "get_file",
        file_name = fileName,
        session_id = sessionId,
        is_end = index == block_total_count,
        index = index
      }
      network_core.requestBinaryMsg(module_handler, block, data)
    end
  end
  
  function M.onReceive(msg)
    local data = msg.data
    local command = data.command
    local command_data = data.command_data
    if command then
      local f = CMD[command]
      f(command_data)
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.LiveCoding.LiveCodingModule", function(require)
  local Queue = require("LuaBoomer.Util.Queue")
  local M = {}
  local CMD = {}
  local target_server
  
  function M.setTargetServer(server)
    target_server = server
  end
  
  local flag_lua_reload = false
  
  function M.setLuaReload(flag)
    flag_lua_reload = flag
  end
  
  local target_dest_dir = global.ProjectPersistentDownloadDir() .. "/Content/Script"
  local StringUtil = require("LuaBoomer.Util.StringUtil")
  local JsonUtil = require("LuaBoomer.Util.JsonUtil")
  local socket_impl, socket
  local is_init = false
  local is_connect = false
  local msg_queue = Queue.create()
  local send_queue = Queue.create()
  local last_heart_beat
  local heart_beat_lost = 10
  
  local function reconnect()
    if socket then
      is_connect = false
      socket.close()
      socket = socket_impl.createSocket()
    end
    socket = socket_impl.createSocket()
    local code = socket.connect(target_server, 8687)
    print("connect live coding server, return code : " .. code)
    is_connect = true
    last_heart_beat = os.time()
  end
  
  local function check_heartbeat()
    if not last_heart_beat then
      last_heart_beat = os.time()
    end
    local current_time = os.time()
    if current_time - last_heart_beat > heart_beat_lost then
      reconnect()
    end
  end
  
  function M.init(conf)
    socket_impl = require(conf.socket_impl)
  end
  
  local function do_init()
    if not is_init then
      is_init = true
      reconnect()
      game.event_mgr:Listen(game.consts.client.UE_HTTP_DOWNLOAD_COMPLETE_CALLBACK, M, M.downLoadComplete)
      game.event_mgr:Listen(game.consts.client.UE_MD5_CALLBACK, M, M.md5Complete)
    end
  end
  
  local function send(req)
    send_queue:pushFront(req)
  end
  
  local function do_send()
    if socket_impl and not socket_impl.is_connect_ready() then
      return
    end
    while true do
      local req = send_queue:popBack()
      if not req then
        break
      end
      local msg = JsonUtil.encode(req)
      local fmt = string.format(">I2c%d", #msg)
      local data = string.pack(fmt, #msg, msg)
      if not socket.send(data) and not req.msg == "Heartbeat" then
        send_queue:pushBack(req)
      end
    end
  end
  
  local function do_recv()
    if not is_connect then
      return false
    end
    local length_str = socket.recv(2)
    if length_str and 2 == #length_str then
      local length = string.unpack(">I2", length_str)
      local data = socket.recv(length)
      if data then
        local json = JsonUtil.decode(data)
        msg_queue:pushFront(json)
        return true
      end
    end
    return false
  end
  
  local function delete_directory(path)
    local local_file_list = global.GetFileListFromDirectory(path, "lua", false)
    for k, v in ipairs(local_file_list) do
      local delete_state = global.DeleteFile(v)
      print("delete file in " .. path, delete_state)
    end
  end
  
  local current_download
  local chunk_size = 1048576
  
  local function handle_msg_queue()
    while not current_download do
      local data = msg_queue:popBack()
      if not data then
        break
      end
      if data.msg == "FileSynchronization" then
        print(data)
        local path = data.path
        current_download = {
          url = "http://" .. target_server .. ":8689" .. path,
          target_path = target_dest_dir .. path,
          path = path
        }
        global.X3DStreamingHttpDownLoad(current_download.url, current_download.target_path, true, chunk_size)
      elseif data.msg == "FileDeletion" then
        local path = target_dest_dir .. data.path
        local delete_state = global.DeleteFile(path)
        print("delete file ", delete_state)
      elseif data.msg == "DirectoryDeletion" then
        local path = target_dest_dir .. data.path
        delete_directory(path)
      elseif data.msg == "Heartbeat" then
        last_heart_beat = os.time()
      elseif data.msg == "DirectoryInformation" then
        CMD.DirectoryInformation()
      end
    end
  end
  
  local function scriptRelativePath2PackagePath(file_path)
    local reload_lua_path = string.gsub(file_path, "/", ".")
    local result = string.sub(reload_lua_path, 2, #reload_lua_path - 4)
    return result
  end
  
  function M:downLoadComplete(url, succeed, response_code)
    if url == current_download.url then
      if not succeed then
        print("downLoad not succeed : " .. response_code .. ", url=" .. url)
      else
        game.log.ScreenPrint("LiveCoding下载文件[%s]完成", current_download.path)
        if flag_lua_reload then
          local relative_path = current_download.path
          if global.FileExists(current_download.target_path) then
            local lua_package_path = scriptRelativePath2PackagePath(relative_path)
            game.reload.ReloadFile(lua_package_path)
            game.log.ScreenPrint("LiveCoding热更文件[%s]完成", current_download.path)
          end
        end
      end
      current_download = nil
    end
  end
  
  local local_save_files
  
  function M:md5Complete(file_path, md5)
    if not local_save_files then
      return
    end
    local relative_path = game.file_util.GetScriptRelativePath(file_path)
    local_save_files[relative_path] = md5
  end
  
  local is_send_directory_info = false
  
  local function _doSendDirectoryInformation(local_save_files)
    local data = {
      msg = "DirectoryInformation",
      file_list = local_save_files,
      workspace = target_dest_dir
    }
    send(data)
    is_send_directory_info = true
  end
  
  local function sendDirectoryInformation()
    if is_send_directory_info then
      return
    end
    if not local_save_files then
      return
    end
    for file_path, md5 in pairs(local_save_files) do
      if 0 == #md5 then
        return
      end
    end
    _doSendDirectoryInformation(local_save_files)
  end
  
  function CMD.DirectoryInformation()
    is_send_directory_info = false
    if not local_save_files then
      local file_list = global.GetFileListFromDirectory(target_dest_dir, "lua", true)
      if file_list and #file_list > 0 then
        local_save_files = {}
        for i, file_path in ipairs(file_list) do
          local relative_path = game.file_util.GetScriptRelativePath(file_path)
          local_save_files[relative_path] = ""
          global.X3DGenerateFileMD5Async(file_path)
        end
      else
        _doSendDirectoryInformation({})
      end
    else
    end
  end
  
  function M.onReceive(msg)
    local data = msg.data
    local command = data.command
    local command_data = data.command_data
    if command then
      local f = CMD[command]
      f(command_data)
    end
  end
  
  local send_heartbeat_interval = 2
  local send_heartbeat_count_time = 0
  
  local function send_heartbeat(delta_time)
    if send_heartbeat_count_time > send_heartbeat_interval then
      send_heartbeat_count_time = 0
      local data = {msg = "Heartbeat"}
      send(data)
      check_heartbeat()
    end
    send_heartbeat_count_time = send_heartbeat_count_time + delta_time
  end
  
  function M.update(delta_time)
    if not target_server then
      return
    end
    send_heartbeat(delta_time)
    do_init()
  end
  
  function M.updateEveryFrame(delta_time)
    if not target_server then
      return
    end
    do_send()
    do_recv()
    handle_msg_queue()
    sendDirectoryInformation()
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.ClientHeartbeatCheckModule", function(require)
  local M = {}
  local module_handler = "ClientHeartbeatCheckModule"
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local check_interval = 2
  local check_timeout = 10
  local tick_time = 0
  local last_heartbeat_recv_time = 0
  
  function M.init(conf)
    last_heartbeat_recv_time = os.time()
  end
  
  function M.onReceive(msg)
    local data = msg.data
    if data == module_handler then
      last_heartbeat_recv_time = os.time()
    end
  end
  
  function M.update(delta_time)
    tick_time = tick_time + delta_time
    if tick_time > check_interval then
      tick_time = 0
      local request = module_handler
      network_core.requestMsg(module_handler, request)
    end
    if os.time() - last_heartbeat_recv_time > check_timeout then
      last_heartbeat_recv_time = os.time()
      network_core.manuallyDisconnect()
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.FpsModule", function(require)
  local M = {}
  local old_frame = 0
  local new_frame = 0
  local old_time = 0
  local new_time = 0
  local show_time = 0.5
  local fps = 0
  
  function M.init(...)
  end
  
  local function _statFps(delta_time)
    new_frame = new_frame + 1
    new_time = new_time + delta_time
    local pass_time = new_time - old_time
    if pass_time > show_time then
      local frame = new_frame - old_frame
      local time = new_time - old_time
      fps = frame / time
      old_frame = new_frame
      old_time = new_time
    end
  end
  
  function M.updateEveryFrame(delta_time)
    _statFps(delta_time)
  end
  
  function M.getFps()
    return fps
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.LocalModule.LuaFlameGraph.LuaFlameModule", function(require)
  local M = {}
  local CMD = {}
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local module_handler = "LuaFlameModule"
  local profiler_status = false
  local start_func, stop_func
  
  local function _report_status(status)
    local data = {
      msg = "ProfileStatus",
      status = status
    }
    network_core.requestMsg(module_handler, data)
  end
  
  function CMD.start_profile()
    if profiler_status then
      print("already start")
      return
    end
    profiler_status = true
    if start_func then
      local no_error, msg = pcall(start_func)
      if no_error then
        _report_status(profiler_status)
        print("start lua flame profile succ")
      else
        print("start lua flame profile failed : ", msg)
      end
    end
  end
  
  function CMD.stop_profile()
    if not profiler_status then
      print("already stop")
      return
    end
    profiler_status = false
    if stop_func then
      local no_error, msg = pcall(stop_func)
      if no_error then
        _report_status(profiler_status)
        print("stop lua flame profile succ")
      else
        print("stop lua flame profile failed : ", msg)
      end
    end
  end
  
  function CMD.status_profile()
    _report_status(profiler_status)
  end
  
  function M.init(conf)
    start_func = conf.start_profiler
    stop_func = conf.stop_profiler
  end
  
  function M.onReceive(msg)
    local data = msg.data
    local command = data.command
    if command then
      local f = CMD[command]
      f()
    end
  end
  
  local report_status_count_time = 0
  local report_status_interval_time = 3
  
  function M.update(delta_time)
    report_status_count_time = report_status_count_time + delta_time
    if report_status_count_time > report_status_interval_time then
      CMD.status_profile()
      report_status_count_time = 0
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.NetworkModule.SocketBaseLsc", function(require)
  local logger = require("LuaBoomer.Util.Logger")
  local M = {}
  local fd
  local connecting = false
  local is_connect_ready = false
  local socket
  
  local function conn_error(errcode)
    return socket.strerror(errcode) .. "[" .. tostring(errcode) .. "]"
  end
  
  function M.isReady()
    return nil ~= socket
  end
  
  function M.initSocket()
    if not socket then
      socket = require("socket.c")
    end
    return socket
  end
  
  function M.is_connect_ready()
    return nil ~= fd and is_connect_ready
  end
  
  function M.connect(ip, port)
    if connecting then
      logger.info("Luaboomer Socket waiting connection, connecting")
      return 1
    end
    fd = socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0)
    fd:setblocking(false)
    local errcode = fd:connect(ip, port)
    logger.info("Luaboomer SocketXLua nonblocking connect...: ", errcode)
    connecting = true
    return 1
  end
  
  local SELECT_MAX_TRIES = 10
  local select_count = 0
  
  function M.check_async_connect()
    if nil == fd then
      return
    end
    if connecting then
      local revents, err = fd:poll(socket.POLLOUT)
      if err then
        logger.info("Luaboomer SocketXLua connect failed", conn_error(err))
        M.close()
      else
        local poll_err = 0 ~= revents & socket.POLLERR
        local poll_out = 0 ~= revents & socket.POLLOUT
        if poll_err then
          logger.info("Luaboomer SocketXLua connect failed", "poll error")
          M.close()
        elseif poll_out then
          logger.info("Luaboomer SocketXLua connect successfully")
          connecting = false
          is_connect_ready = true
        end
        selectCount = select_count + 1
        if select_count > SELECT_MAX_TRIES then
          logger.info("Luaboomer SocketXLua connect failed", "Number of retries exceeded")
          M.close()
        end
      end
    end
  end
  
  function M.getLocalPort()
    if fd then
      peerLocalInfo = fd:getsockname()
    end
    return peerLocalInfo
  end
  
  function M.close()
    if not fd then
      return nil
    end
    fd:close()
    fd = nil
    is_connect_ready = false
    connecting = false
    select_count = 0
  end
  
  function M.recv(len)
    if not fd then
      return nil
    end
    local data = fd:recv(len)
    return data
  end
  
  function M.send(data)
    if not fd then
      return nil
    end
    do return fd.send, fd end
    return fd.send, fd, data
  end
  
  function M.update(delta_time)
    if nil ~= fd and connecting then
      M.check_async_connect()
    end
  end
  
  return M
end)
__DISTILLER:define("LuaBoomer.Core", function(require)
  local M = {}
  local local_mgr = require("LuaBoomer.LocalModule.LocalModuleMgr")
  local network_core = require("LuaBoomer.NetworkModule.LbNet")
  local logger = require("LuaBoomer.Util.Logger")
  local enabled = true
  local tick_time = 0
  local tick_time_interval = 1
  local luaboomer_tick_time = 0
  local lb_server = "127.0.0.1:9019"
  local current_project
  M.is_init_update_done = false
  local is_init_success = false
  local init_params
  
  function M.setInitParams(params)
    init_params = params
  end
  
  function M.getInitParams()
    return init_params
  end
  
  local function startWiths(str, match)
    return string.sub(str, 1, string.len(match)) == match
  end
  
  local function onInitUpdateCallBack(lua_boomer_new_bundle)
    network_core.manuallyDisconnect()
    local device_info = M.getDeviceInfo()
    local init_params = M.getInitParams()
    for id, pkg in pairs(package.loaded) do
      if startWiths(id, "LuaBoomer") or startWiths(id, "luaBoomer") or startWiths(string.lower(id), "luaboomer") then
        package.loaded[id] = nil
      end
    end
    M.loader.FACTORIES = {}
    local newCore = load(lua_boomer_new_bundle, "luaboomer_remote_bundle")()
    for key, value in pairs(newCore) do
      M[key] = value
    end
    M.is_init_update_done = true
    newCore.setInitUpdateDone()
    newCore.setDeviceInfo(device_info)
    newCore.setInitParams(init_params)
    newCore.setLoggerLevel(2)
    newCore.init(init_params[1], init_params[2], init_params[3], init_params[4], init_params[5], init_params[6])
    newCore.setInitSuccess()
  end
  
  function M.setInitUpdateDone()
    M.is_init_update_done = true
  end
  
  function M.setInitSuccess()
    is_init_success = true
  end
  
  local function _shouldUpdate(delta_time)
    tick_time = tick_time + delta_time
    if tick_time > tick_time_interval then
      tick_time = 0
      return true
    end
    return false
  end
  
  function M.init(server, module_conf, start, socket_impl, project)
    if not start then
      M.disable()
      return
    end
    if nil ~= server then
      lb_server = server
    end
    current_project = project
    if not network_core.get_is_init() then
      network_core.setDeviceInfo({project = project})
      network_core.init(lb_server, socket_impl)
    end
    local _module_conf = module_conf or {}
    for k, v in pairs(_module_conf) do
      if type(v) == "table" then
        v.project = project
      end
    end
    if M.is_init_update_done then
      local_mgr.initModules(_module_conf)
    else
      init_params = {
        server,
        module_conf,
        start,
        socket_impl,
        project,
        loader_path
      }
      local_mgr.getInitUpdateModule().init({project = project, onUpdateCallBack = onInitUpdateCallBack})
    end
  end
  
  local last_low_delta_time_timestamp = 0
  
  local function low_delta_time_control(delta_time)
    if delta_time > 0.0083 then
      return false
    end
    local current_timestamp = os.time()
    if current_timestamp - last_low_delta_time_timestamp >= 2 then
      last_low_delta_time_timestamp = current_timestamp
      return true
    end
    return false
  end
  
  function M.update(delta_time)
    if not is_init_success then
      return
    end
    if not enabled then
      return
    end
    network_core.updateEveryFrame(delta_time)
    if M.is_init_update_done then
      local_mgr.updateEveryFrame(delta_time)
    else
      local_mgr.getInitUpdateModule().updateEveryFrame(delta_time)
    end
    luaboomer_tick_time = luaboomer_tick_time + delta_time
    if low_delta_time_control(delta_time) then
      network_core.simpleHeartbeat(delta_time)
    end
    if not _shouldUpdate(delta_time) then
      return
    end
    network_core.heartbeat(luaboomer_tick_time)
    network_core.update(luaboomer_tick_time)
    if M.is_init_update_done then
      local_mgr.update(luaboomer_tick_time)
      if local_mgr.getRemoteModuleMgr() then
        local_mgr.getRemoteModuleMgr().update(luaboomer_tick_time)
      end
    end
    luaboomer_tick_time = 0
  end
  
  function M.enable()
    network_core.manuallyReconnect()
    enabled = true
  end
  
  function M.disable()
    network_core.manuallyDisconnect()
    enabled = false
  end
  
  function M.setInterval(interval)
    tick_time_interval = interval
  end
  
  function M.getLocalPort()
    if network_core then
      do return end
      return network_core.getLocalPort, nil
    end
  end
  
  function M.forward(data)
    local_mgr.forwardData(data)
  end
  
  function M.isModuleOn(module_name)
    do return local_mgr.isModuleOn end
    return local_mgr.isModuleOn, module_name
  end
  
  function M.moduleSwitch(module_name, state, module_conf)
    if module_name then
      local_mgr.moduleSwitch(module_name, state, module_conf)
    end
  end
  
  function M.setLoggerLevel(level)
    logger.setLogLevel(level)
  end
  
  function M.setDeviceInfo(device)
    network_core.setDeviceInfo(device)
  end
  
  function M.getDeviceInfo()
    do return end
    return network_core.getDeviceInfo, nil
  end
  
  function M.getProject()
    return current_project
  end
  
  function M.httpRequest(method, data, api)
    local_mgr.getServerCmdModule().httpRequest(method, data, api)
  end
  
  function M.markTaskTag(tag)
    local module = local_mgr.getModule("ProfileModule")
    if module then
      module.setExtraData(tag)
    end
  end
  
  local task_running = false
  local end_task_callback
  
  function M.setEndTaskCallBack(cb)
    end_task_callback = cb
  end
  
  function M.isTaskRunning()
    return task_running
  end
  
  function M.endTask(notify, extra)
    task_running = false
    if not end_task_callback then
      xpcall(end_task_callback, debug.traceback)
      end_task_callback = nil
    end
    M.moduleSwitch("ProfileModule", false)
    local data = {
      param = {notify = notify, extra = extra},
      body = {}
    }
    M.httpRequest("post", data, "/api/profile/end_task")
    M.markTaskTag(nil)
  end
  
  function M.startTask(userName, taskName, tag)
    local taskId = tostring(os.time())
    M.startTaskEx(userName, taskName, taskId, tag)
  end
  
  function M.startTaskEx(userName, taskName, taskId, tag, taskType)
    task_running = true
    local module = local_mgr.getModule("ProfileModule")
    if module then
      module.startTask(taskId)
      M.moduleSwitch("ProfileModule", true, tag)
    else
      return
    end
    local profileTaskModule = local_mgr.getProfileTaskModule()
    profileTaskModule.startTask(taskId)
    local JsonUtil = require("LuaBoomer.Util.JsonUtil")
    local taskInfo = {
      projectName = current_project,
      markTaskId = taskId,
      userName = userName,
      taskName = taskName,
      taskType = taskType,
      deviceInfo = JsonUtil.encode(M.getDeviceInfo()),
      dataZoom = "[0,100]"
    }
    local data = {
      param = {
        taskInfo = JsonUtil.encode(taskInfo)
      },
      body = {}
    }
    M.httpRequest("post", data, "/api/profile/insert_task")
  end
  
  function M.markScreenshot(...)
    local profileTaskModule = local_mgr.getProfileTaskModule()
    if profileTaskModule then
      profileTaskModule.markScreenshot(...)
    end
  end
  
  function M.markLog(...)
    local profileTaskModule = local_mgr.getProfileTaskModule()
    if profileTaskModule then
      profileTaskModule.markLog(...)
    end
  end
  
  function M.loginSuccess()
    local eventModule = local_mgr.getEventModule()
    print(eventModule)
    if eventModule then
      eventModule.onLoginSuccess()
    end
  end
  
  function M.callLocalModuleMethod(localModule, method, ...)
    local module, switch = local_mgr.getModule(localModule)
    if nil ~= module and switch then
      local methodFun = module[method]
      if nil ~= methodFun and type(methodFun) == "function" then
        local success, result = pcall(methodFun, ...)
        if not success then
          logger.info("callLocalModuleMethod error", localModule, method, ...)
        end
      end
    end
  end
  
  return M
end)
__DISTILLER:define("build.lua_distilled", function(require)
  require("LuaBoomer.LocalModule.FileViewManager.M6FileViewImpl")
  require("LuaBoomer.NetworkModule.SocketBase")
  require("LuaBoomer.NetworkModule.SocketLevent")
  require("LuaBoomer.NetworkModule.SocketM1")
  require("LuaBoomer.NetworkModule.SocketXlua")
  require("LuaBoomer.NetworkModule.SocketS3")
  require("LuaBoomer.NetworkModule.SocketUnityCs")
  require("LuaBoomer.NetworkModule.SocketK1")
  require("LuaBoomer.NetworkModule.SocketRL1")
  require("LuaBoomer.LocalModule.LogViewModule")
  require("LuaBoomer.LocalModule.ProtoCollectorModule")
  require("LuaBoomer.LocalModule.HookModule")
  require("LuaBoomer.LocalModule.ProfileModule")
  require("LuaBoomer.LocalModule.DataForwardModule")
  require("LuaBoomer.LocalModule.NetProfileModule")
  require("LuaBoomer.LocalModule.GMModule")
  require("LuaBoomer.LocalModule.EventModule")
  require("LuaBoomer.LocalModule.ProtoTest.ProtoTestModule")
  require("LuaBoomer.LocalModule.FileViewManager.FileViewModule")
  require("LuaBoomer.LocalModule.LiveCoding.LiveCodingModule")
  require("LuaBoomer.LocalModule.ClientHeartbeatCheckModule")
  require("LuaBoomer.LocalModule.FpsModule")
  require("LuaBoomer.LocalModule.LuaFlameGraph.LuaFlameModule")
  require("LuaBoomer.NetworkModule.SocketBaseLsc")
  do return require end
  return require, "LuaBoomer.Core"
end)
local core = __DISTILLER.require("LuaBoomer.Core")
core.loader = __DISTILLER
return core
