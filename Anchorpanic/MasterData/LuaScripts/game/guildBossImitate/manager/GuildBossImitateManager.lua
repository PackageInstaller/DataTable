-- @FileName:   GuildBossImitateManager.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-21 10:59:29
-- @Copyright:   (LY) 2023 雷焰网络

module('game.guildBossImitate.manager.GuildBossImitateManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

--初始化
function init(self)

end

-------------------------------------------SeverData ---------------
function setDupInfoData(self, data)
    self.m_dupInfo = data
end

function getDupInfoData(self)
    return self.m_dupInfo
end

--------------------------------------------cacheData---------------

function parseDupConfigData(self)
    self.m_dupConfigDic = {}

    local levelDic = {}
    local attrDic = {}
    local baseData = RefMgr:getData("guild_train_data")
    for key, data in pairs(baseData) do
        local baseVo = guildBossImitate.GuildImitateDupVo.new()
        baseVo:parseCogfigData(key, data)
        self.m_dupConfigDic[key] = baseVo

        levelDic[baseVo.difficulty] = 1
        attrDic[baseVo.weakness_ele] = 1
    end

    self.m_levelConfigList = {}
    self.m_attrConfigList = {}

    for difficulty, _ in pairs(levelDic) do
        table.insert(self.m_levelConfigList, difficulty)
    end

    for weakness_ele, _ in pairs(attrDic) do
        table.insert(self.m_attrConfigList, weakness_ele)
    end

    table.sort(self.m_levelConfigList, function (a, b)
        return a < b
    end)

    table.sort(self.m_attrConfigList, function (a, b)
        return a < b
    end)
end

function getLevelConfigList(self)
    if not self.m_levelConfigList then
        self:parseDupConfigData()
    end

    return self.m_levelConfigList
end

function getAttrConfigList(self)
    if not self.m_attrConfigList then
        self:parseDupConfigData()
    end

    return self.m_attrConfigList
end

function getDupConfig(self, dupId)
    if not self.m_dupConfigDic then
        self:parseDupConfigData()
    end
    return self.m_dupConfigDic[dupId]
end

function getDupConfigDic(self)
    if not self.m_dupConfigDic then
        self:parseDupConfigData()
    end
    return self.m_dupConfigDic
end

-----------------------------------------Util------------------
function getSaveCacheDupId(self)
    if self.m_cacheDupId == nil or self.m_cacheDupId == 0 then
        self.m_cacheDupId = StorageUtil:getNumber1(gstor.GUILDBOSSIMITATE_CACHE_DUPID)
        if self.m_cacheDupId == 0 then
            if not self.m_dupConfigDic then
                self:parseDupConfigData()
            end

            for dupid, dupConfigVo in pairs(self.m_dupConfigDic) do
                if self.m_cacheDupId == 0 or dupid < self.m_cacheDupId then
                    self.m_cacheDupId = dupid
                end
            end
        end
    end

    return self.m_cacheDupId
end

function saveCacheDupId(self, dupId)
    self.m_cacheDupId = dupId
    StorageUtil:getNumber1(gstor.GUILDBOSSIMITATE_CACHE_DUPID, self.m_cacheDupId)
end

function getDupName(self, fieldID, battleType)
    local dupConfigVo = self:getDupConfig(fieldID)
    if dupConfigVo  then 
        return dupConfigVo.stage_name
    end

    return ""
end

return _M
