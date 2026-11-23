ConfigMainLineMgr = {}

local this = {
    switchTime = nil

};


ConfigMainLineMgr.Init = function()

    if ConfigMgr and ConfigMgr.Config then

        print("ConfigMainLineMgr 初始化完成")
    else
        LuaDebug.error("ConfigMgr 或 ConfigMgr.Config 不存在，初始化失败")
    end
end

ConfigMainLineMgr.CheckCanSwitch = function()
    if (this.switchTime == nil) then
        local activity_group_config = ConfigMgr.Config.activityGroup["4000"]  
        local function parse_time(timestr)           
            local year, month, day, hour, min, sec = timestr:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
            local time_components = {
                year = tonumber(year),
                month = tonumber(month),
                day = tonumber(day),
                hour = tonumber(hour),
                min = tonumber(min),
                sec = tonumber(sec)
            }        
            local timestamp_as_local = os.time(time_components)        
            local now = os.time()
            local local_table = os.date("*t", now)
            local utc_table = os.date("!*t", now)            
            local_table.isdst = false
            utc_table.isdst = false        
            local local_offset_sec = os.time(local_table) - os.time(utc_table)            
            local timestamp_as_utc = timestamp_as_local + local_offset_sec        
            local beijing_offset_sec = 8 * 3600        
            return timestamp_as_utc - beijing_offset_sec
        end

        if(activity_group_config ~= nil and activity_group_config.text ~= nil) then
            this.switchTime = parse_time(activity_group_config.text)
        else
            this.switchTime = 0
            LuaDebug.error("ConfigMainLineMgr.CheckCanSwitch() activity_group_config.text 不存在")
        end       
    end
    local now_timestamp = LuaMgr.Timestamp()
    return now_timestamp <= this.switchTime
end

ConfigMainLineMgr.Clear = function()
    this.switchTime = nil;
end