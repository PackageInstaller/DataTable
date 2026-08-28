--[[
    author:luqucheng
    time:2022-08-09 15:21:07
]]

local BattleConfig = {}

BattleConfig.battleConfigs = {}
BattleConfig.loadFromLua = false

local RowPrototype = {
    Get = function (self, header_name, defaultV)
        return self[header_name] or ""
    end,
    GetPrimaryKey = function (self)
        return self.primaryKey
    end,
    isLuaTable = true,
}

local TablePrototype = {
    GetRowCount = function (self)
        return #self.array
    end,
    GetRow = function (self, index)
        local row = self.array[index]
        setmetatable(row, {__index = RowPrototype})
        return row
    end,
    GetByPrimaryKey = function (self, key)
        local index = self.dic[checkString(key)]
        local row = self.array[index]
        if not row then
            printError("找不到配表对应的id:" .. key .. "    " .. self.path)
        else
            setmetatable(row, {__index = RowPrototype})
            row.primaryKey = checkString(key)
        end
        return row
    end,
    SetVoName = function (self, voName)
        self.voName = voName
        self.voMoudle = import(string.format("Game.Setting.Vo.%s", self.voName))
    end,
    Get = function (self, key)
        if not self.voMoudle then
            return
        end
        local row = self:GetByPrimaryKey(key)
        local vo = self.voMoudle.New()
        if row == nil then
            return vo
        end
        vo:FillVo(row)
        return vo
    end,
}

function BattleConfig:GetSetting(path)
    if self.loadFromLua then
        local table = self:LoadConfigData(path)
        return table
    else
        return SettingMgr:GetInstance():Get(path)
    end
end

-- function BattleConfig:GetSettingByPrimaryKey(path, key)
--     local table = self:LoadConfigData(path)
--     local index = table.dic[key]
--     local row = table.array[index]
--     if row then
--         printError("找不到配表对应的id:" .. key .. "    " .. path)
--     else
--         setmetatable(row, {__index = RowPrototype})
--     end

--     return row
-- end

function BattleConfig:GetSettingVo(path, voName)
    -- print("GetSettingVo", path, voName)
    if self.loadFromLua then
        local table = BattleConfig:GetSetting(path)
        table:SetVoName(voName)
        return table
    else
        return SettingMgr:GetInstance():GetSetting(path, voName)
    end
end

-- function BattleConfig:GetSettingVoByPrimaryKey(path, key, voName)
--     local row = BattleConfig:GetSettingByPrimaryKey(path, key)
--     if row then
--         setmetatable(row, {__index = RowPrototype})
--         local tt = import(string.format("Game.Setting.Vo.%s", self.voName))
--         local vo = tt.New()
--         vo:FillVo(row)

--         return vo
--     end
-- end

function BattleConfig:LoadConfigData(path, csvString)
    if self.battleConfigs and self.battleConfigs[path] then
        return self.battleConfigs[path]
    end
    if Tools.isNullKey(csvString) then
        csvString = CS.Engine.Modules.SettingModule.LoadSettingString(path)
    end
    
    local lines = string.split(csvString, "\n")
    local titles = string.split(lines[1], '\t')
    local types = string.split(lines[2], '\t')

    --local pattern = "^#"
    local dataArray = {}
    local dataDic = {}
    for i = 3, #lines do
        local content = string.split(lines[i], '\t')
        --state的保护
        local id = content[1]
        if dataDic[id] then
            printError("检测到重复id:" .. id .. "    " .. path)
        else
            local data = {}
            for j = 1, #titles do
                -- if types[j] == "int" then
                --     data[titles[j]] = checkNumber(content[j])
                -- else
                --     data[titles[j]] = content[j]
                -- end
                data[titles[j]] = content[j]
            end
            -- setmetatable(config, {__index = RowPrototype})
            table.insert(dataArray, data)
            dataDic[id] = #dataArray
        end
    end
    local config = {array = dataArray, dic = dataDic, path = path}
    -- setmetatable(config, {__index = TablePrototype})
    self.battleConfigs[path] = config
    setmetatable(config, {__index = TablePrototype})
    return self.battleConfigs[path]
end

function BattleConfig:GetConfigData(path, id)
    local config = self:LoadConfigData(path)
    if not config or not config.array or not config.dic then
        printError("配置读取失败:%s", path)
        return
    end
    local index = config.dic[id] or -1
    return config.array[index]
end

return BattleConfig