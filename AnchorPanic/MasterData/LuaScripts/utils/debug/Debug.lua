--日志系统
module("Debug", Class.impl())

-- 日志等级
LogType = {
    All = 0,
    Trace = 1,
    Debug = 2,
    Info = 3,
    Warning = 4,
    Error = 5,
    Custom = 6
}

function ctor(self)
    self.m_beOpen = true
end
--设置日志显示等级
function setLogType(self, type)
    self.gLogType = type
end

--显示tags(与忽略tags互斥) 日志等级及以上显示
function setNeedLog(self, tags)
    self.gNeedTags = tags
end

--忽略tags 日志等级及以上
function setIgnoreLog(self, tags)
    self.gIgnoreTags = tags
end
-- 设置是否开启打印
function setOpenLog(self, beOpen)
    self.m_beOpen = beOpen
end
-- 设置是否允许弹出日志
function setLogAllow(self, isAllow)
    CS.Lylibs.DebugView:GetInstance().IsAllowed = isAllow
end

--检测是否显示
function checkIsShowLog(self, tag, type)
    if type < self.gLogType then
        return false
    end

    if #self.gNeedTags > 0 then
        for _, v in ipairs(self.gNeedTags) do
            if v == tag then
                return true
            end
        end
        return false
    elseif #self.gIgnoreTags > 0 then
        for _, v in ipairs(self.gIgnoreTags) do
            if v == tag then
                return false
            end
        end
    end
    return true
end

local function tracebackex(level)
    local ret = {}
    level = level or 3
    while true do
        --get stack info
        local info = debug.getinfo(level, "Sln")
        if not info then
            break
        end
        if info.what == "C" then -- C function
            --ret = ret .. tostring(level) .. "\tC function\n"
            table.insert(ret, level)
            table.insert(ret, "\tC function\n")
        else -- Lua function
            --ret = ret .. string.format("\t[%s]:%d in function `%s`\n", info.short_src, info.currentline, info.name or "")
            table.insert(
                ret,
                string.format("\t[%s]:%d in function `%s`\n", info.short_src, info.currentline, info.name or "")
            )
        end
        --[[get local vars  
		local i = 1  
		while true do  
			local name, value = debug.getlocal(level, i)  
			if not name then break end  
			ret = ret .. "\t\t" .. name .. " =\t" .. tostringex(value, 3) .. "\n"  
			i = i + 1  
		end 
		--]]
        if level > 8 then
            break
        end
        level = level + 1
    end
    if table.empty(ret) then
        return
    end

    table.insert(ret, 1, "stack traceback:\n")
    return table.concat(ret)
end
-- 解析日志
function parseLog(self, type, tag, format, ...)
    if self.m_beOpen and format then
        if self:checkIsShowLog(tag, type) then
            local logStr
            if select("#", ...) > 0 then
                logStr = string.format(format, ...)
            else
                logStr = format
            end
            local level = 3
            local trace = debug.getinfo(level)
            local file = nil
            local line = nil
            local fun = nil
            if trace then
                if (string.find(trace.source, "/Require")) then
                    level = 4
                    trace = debug.getinfo(level)
                end
                file = trace.source
                line = trace.linedefined
                fun = trace.name
            end

            if file == nil then
                file = "[unknown file]"
            else
                local arr = string.split(file, "/")
                if not table.empty(arr) then
                    file = arr[#arr]
                end
            end
            local t = {}
            table.insert(t, file)

            if line then
                table.insert(t, "[line]:")
                table.insert(t, line)
            end
            if (fun == nil or fun == "v") then
                table.insert(t, "[unknown fun]")
            else
                table.insert(t, "[fun]:")
                table.insert(t, fun)
            end

            if tag and tag ~= "" then
                table.insert(t, "[")
                table.insert(t, tag)
                table.insert(t, "]")
            end
            if not table.empty(t) then
                table.insert(t, 1, "<")
                table.insert(t, ">")
                logStr = logStr .. " -- " .. table.concat(t, " ")
            end

            -- -- 末尾加行号信息
            -- local temStr = ""
            -- local s = debug.getinfo(3)
            -- if tag ~= nil then
            -- 	temStr = temStr .. tag .. ".lua"
            -- end
            -- if s.currentline ~= nil then
            -- 	temStr = temStr .. " " .. s.currentline
            -- end
            -- if s.name ~= nil and s.name ~= "func" then
            -- 	temStr = temStr .. "  " .. s.name

            -- 	if s.linedefined ~= nil then
            -- 		temStr = temStr .. " " .. s.linedefined
            -- 	end
            -- end
            -- if #temStr > 0 then
            -- 	logStr = logStr .. "    [" .. temStr .. "]"
            -- end

            if type == LogType.Error then
                -- gs.Debuger.LogLua(logStr, type, debug.traceback())
                gs.Debuger.LogLua(logStr, type, tracebackex(level + 1))
            else
                gs.Debuger.LogLua(logStr, type)
            end
        end
    else
        gs.Debuger.LogLua("Error：format == nil", LogType.Error, tracebackex(3 + 1))
    end
end

-- 解析自定义日志
function parseCusLog(self,tag)
    if self.m_beOpen  then
        local level = 4
        local trace = debug.getinfo(level)
        gs.Debuger.LogCus(tag,trace,tracebackex(5))
        --gs.Debuger.LogCus(tag,"堆栈信息:"..)
    end
end

--error输出
function log_error(self, tag, format, ...)
    self:parseLog(LogType.Error, tag, format, ...)
end

--warn输出
function log_warn(self, tag, format, ...)
    self:parseLog(LogType.Warning, tag, format, ...)
end

--info输出
function log_info(self, tag, format, ...)
    self:parseLog(LogType.Info, tag, format, ...)
end

--debug输出
function log_debug(self, tag, format, ...)
    self:parseLog(LogType.Debug, tag, format, ...)
end

--trace输出
function log_trace(self, tag, format, ...)
    self:parseLog(LogType.Trace, tag, format, ...)
end

--自定义的输出
function cuslog_info(self, tag)
    self:parseCusLog(tag)
end

-- 打印table
function print_table(self, tab)
    local str = {"\n", "len=>", #tab, "\n"}

    local function internal(tab, str, indent)
        for k, v in pairs(tab) do
            if type(v) == "table" then
                table.insert(str, indent .. tostring(k) .. ": len=> " .. #v .. "\n")
                internal(v, str, indent .. "    ")
            else
                table.insert(str, indent .. tostring(k) .. ": " .. tostring(v) .. "\n")
            end
        end
    end

    internal(tab, str, "")
    self:log_trace(nil, table.concat(str, ""))
end

--可以打印一切
function Log(t, m)
    m = m or ""
    if t == nil then
        CS.UnityEngine.Debug.Log("Lua: nil " .. m .. "\n" .. tracebackex(3))
        return
    end
    local print_r_cache = {}
    local msg = ""
    if type(m) == "string" then msg = m end
    local function IsLuaType(obj) 
        return type(obj) == "table" or type(obj) == "number" or type(obj) == "string" or type(obj) == "boolean" 
    end
    local function sub_print_r(t, indent, str)
        if str == nil then
            str = ""
        end
        if (print_r_cache[tostring(t)]) then
            str = str .. (indent .. " ***** " .. tostring(t))
        else
            print_r_cache[tostring(t)] = true
            if (type(t) == "table") then
                for pos, val in pairs(t) do
                    if IsLuaType(pos) then
                        if (type(val) == "table") then
                            str = str .. (indent .. tostring(pos) .. "=" .. "{") .. "\n"
                            str = str .. sub_print_r(val, indent .. string.rep(" ", string.len(pos) + 6))
                            str = str .. (indent .. string.rep(" ", string.len(pos) + 4) .. "}\n")
                        elseif (type(val) == "string") then
                            str = str .. (indent .."[" ..  tostring(pos) .. ']="' .. val .. '"') .. "\n"
                        elseif type(val) == "function" then  --默认去掉方法
                            str = str .. (indent .. "[" .. tostring(pos) .. ']="' .. "func(...)" .. '"') .. "\n"
                        else
                            str = str .. (indent .."[" ..  tostring(pos) .. "]=" .. tostring(val)) .. "\n"
                        end
                    end
                end
            elseif (type(t) == "string") or (type(t) == "number") or (type(t) == "boolean") then
                str = str .. (indent .. tostring(t)) .. "\n"
            end
        end
        return str
    end
    if (type(t) == "table") then
        msg = msg .. (tostring(t) .. " \n{\n")
        msg = msg .. sub_print_r(t, "  ")
        msg = msg .. ("\n}")
    elseif (type(t) == "string") or (type(t) == "number") or (type(t) == "boolean") then
        msg = msg .. sub_print_r(t, "  ")
    else
        msg = msg .. tostring(t)
    end
    CS.UnityEngine.Debug.Log("Lua: " .. msg .."\n" .. tracebackex(3))
end

-- -- 重写pcall，使得使用pcall调用的函数，所有异常都会被__G__TRACKBACK__所接收到
-- local function pcall(...)
-- 	return xcall(__G__TRACKBACK__, ...)
-- end
-- _G.pcall = pcall
-- function __G__TRACKBACK__(msg)
-- 	local error_msg = "\n\t" .. tostring(msg) .. "\n" .. debug.traceback()
-- 	self:log_error("Debug", error_msg)
-- end

return _M
