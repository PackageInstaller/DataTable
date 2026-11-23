
local pprint = require "Tools/pprint"
local Debug=CS.Laigu.Debug;
pprint.defaults.show_all = true

local pformat = pprint.pformat

local levels = {
    debug = 1,
    info  = 2,
    warn  = 3,
    error = 4,

    Ndebug = 100,
    Ninfo  = 200,
    Nwarn  = 300,
    Nerror = 400,
}

local loggers
local logpath
local progname










LuaDebug = { }

local function console_logger(threhold)
    return function (lv, msg)
        if lv >= threhold then
local logger
            if lv == levels.debug then
                logger = Debug.Log
            elseif lv == levels.info then
                logger = Debug.Log
            elseif lv == levels.warn then
                logger = Debug.LogWarning
            elseif lv == levels.Ndebug then
                logger = Debug.Log
            elseif lv == levels.Ninfo then
                logger = Debug.LogWarning
            elseif lv == levels.Nwarn then
                logger = Debug.LogWarning
            else

                if (UnityEngine.Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or UnityEngine.Application.platform == UnityEngine.RuntimePlatform.OSXEditor ) then
                    logger = Debug.LogError
                else
                    logger = Debug.LogWarning
                end


            end
            logger(msg)
        end
    end
end

local function file_logger(name, level)







    return function (lv, msg)





    end
end

local function log(level, msg)
    for _, logger in pairs(loggers) do
        logger(level, msg)
    end
end

function LuaDebug.init(prog, path, threhold)
    progname = prog
    logpath  = path
    loggers  = { }
    threhold = levels[threhold or 'debug']


table.insert(loggers, console_logger(threhold))





    for level, value in pairs(levels) do
        table.insert(loggers, file_logger(level, value))
    end
end

function LuaDebug.free()
    loggers = nil
end

local function format_args( ... )
    local buff = { }

    for i = 1, select('#', ...) do
        local arg = select(i, ...)
        table.insert(buff, pformat(arg) .. ' ')
    end

    return buff
end

LuaDebug = setmetatable(LuaDebug,{
    __index = function (LuaDebug, key)
        local level = assert(levels[key])

        local date   = os.date
        local unpack = table.unpack or unpack
        local string_upper  = string.upper
        local string_format = string.format

        return function(fmt, ...)
            local msg

            if level % 100 > 0 then
                msg = string_format('[tribal][%s][%s] [[ %s\n', date('%Y-%m-%d %H:%M:%S'), string_upper(key), string_format(fmt, unpack(format_args(...))))
            else
                msg = string_format('[tribal][%s][%s] [[ %s\n', date('%Y-%m-%d %H:%M:%S'), string_upper(key), table.concat(format_args(fmt, ...)))
            end
            log(level, msg)
        end
    end
})


return LuaDebug;