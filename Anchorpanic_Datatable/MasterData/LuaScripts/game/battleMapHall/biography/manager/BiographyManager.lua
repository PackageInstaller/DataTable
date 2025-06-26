module("battleMap.BiographyManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    -- 英雄传记列表字典
    self.m_biographyConfigDic = nil
    -- 传记信息字典
    self.m_biographyInfoConfigDic = nil
    -- 传记具体副本字典
    self.m_dupInfoConfigDic = nil

    -- 标记是否新获得的
    self.gainDic = {}
    -- 服务器已开启的传记字典
    self.m_biographyDic = nil
    -- 奖励信息字典
    self.m_awardInfoDic = {}
end

-- 解析英雄传记列配置表
function parseHeroBiographyData(self)
    self.m_biographyConfigDic = {}
    local baseData = RefMgr:getData("hero_biography_data")
    for heroTid, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(battleMap.HeroBiographyDataRo)
        ro:parseData(heroTid, data)
        self.m_biographyConfigDic[heroTid] = ro
    end
end

-- 解析传记信息配置表
function parseBiographyDupData(self)
    self.m_biographyInfoConfigDic = {}
    local baseData = RefMgr:getData("hero_biography_chapter_data")
    for biographyId, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(battleMap.HeroBiographyChapterDataRo)
        ro:parseData(biographyId, data)
        self.m_biographyInfoConfigDic[biographyId] = ro
    end
end

-- 解析传记具体副本配置表
function parseDupData(self)
    self.m_dupInfoConfigDic = {}
    local baseData = RefMgr:getData("hero_biography_dup_data")
    for dupId, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(battleMap.HeroBiographyDupDataRo)
        ro:parseData(dupId, data)
        self.m_dupInfoConfigDic[dupId] = ro
    end
end

-- 获取英雄传记配置列表
function getHeroBiographyConfigVo(self, heroTid)
    if (not self.m_biographyConfigDic) then
        self:parseHeroBiographyData()
    end
    return self.m_biographyConfigDic[heroTid]
end

-- 获取英雄传记配置数据
function getBiographyConfigVo(self, biographyId)
    if (not self.m_biographyInfoConfigDic) then
        self:parseBiographyDupData()
    end
    return self.m_biographyInfoConfigDic[biographyId]
end

-- 获取传记副本配置列表
function getDupList(self, biographyId)
    local biographyConfigVo = self:getBiographyConfigVo(biographyId)
    if (biographyConfigVo) then
        return biographyConfigVo:getChapterList()
    end
    return {}
end

-- 获取传记副本配置数据
function getDupConfigVo(self, dupId)
    if (not self.m_dupInfoConfigDic) then
        self:parseDupData()
    end
    return self.m_dupInfoConfigDic[dupId]
end

----------------------------------------------------------------------------------------------------------------------------------------------- 
-- 解析服务器英雄传记
function parseMsgHeroBiography(self, cusMsg)
    self.resTimes = cusMsg.challenge_times
    local msgList = cusMsg.hero_biography_list
    if (self.m_biographyDic ~= nil) then
        for i = 1, #msgList do
            -- 是否新增的英雄传记
            if (not self.m_biographyDic[msgList[i].hero_tid]) then
                self.gainDic[msgList[i].hero_tid] = true
            end
        end
    end

    self.m_biographyDic = {}
    for i = 1, #msgList do
        local vo = battleMap.BiographyVo.new()
        vo:parseData(msgList[i])
        if (not self.m_biographyDic[vo.heroTid]) then
            self.m_biographyDic[vo.heroTid] = {}
        end
        table.insert(self.m_biographyDic[vo.heroTid], vo)
    end
    -- GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_BIOGRAPHY, {})
end

function getResTimes(self)
    return self.resTimes
end

function getHeroConfigList(self, professionType, eleType)
    local list = {}
    local heroConfigDic = hero.HeroManager:getHeroConfigDic()
    for tid, configVo in pairs(heroConfigDic) do
        if self:getHeroBiographyConfigVo(tid) then
            if (professionType == nil or professionType == -1 or configVo.professionType == professionType) then
                if eleType ~= -1 then
                    if (configVo.eleType == eleType) then
                        table.insert(list, configVo)
                    end
                else
                    table.insert(list, configVo)
                end
            end
        end
    end
    table.sort(list, self.__sortHeroList)
    return list
end

-- 英雄列表排序
function __sortHeroList(heroConfigVo_1, heroConfigVo_2)
    if (heroConfigVo_1 and heroConfigVo_2) then

        local isOpen_1 = battleMap.BiographyManager:isBiographyOpen(heroConfigVo_1.tid)
        local isOpen_2 = battleMap.BiographyManager:isBiographyOpen(heroConfigVo_2.tid)

        if (isOpen_1 and isOpen_2) then
            local allCount = 0
            local allPassCount = 0
            local biographyList1 = battleMap.BiographyManager:getBiographyList(heroConfigVo_1.tid)
            local biographyList2 = battleMap.BiographyManager:getBiographyList(heroConfigVo_2.tid)
            if (biographyList1[1].isFollow ~= biographyList2[1].isFollow) then
                return biographyList1[1].isFollow > biographyList2[1].isFollow
            else
                for i = 1, #biographyList1 do
                    local biographyVo = biographyList1[i]
                    local dupConfiglist = battleMap.BiographyManager:getDupList(biographyVo.biographyId)
                    allCount = allCount + #dupConfiglist
                    allPassCount = allPassCount + #biographyVo.passDupList
                end
                local pro_1 = allPassCount / allCount

                allCount = 0
                allPassCount = 0
                for i = 1, #biographyList2 do
                    local biographyVo = biographyList2[i]
                    local dupConfiglist = battleMap.BiographyManager:getDupList(biographyVo.biographyId)
                    allCount = allCount + #dupConfiglist
                    allPassCount = allPassCount + #biographyVo.passDupList
                end
                local pro_2 = allPassCount / allCount

                if ((pro_1 == 1 and pro_2 ~= 1) or (pro_1 ~= 1 and pro_2 == 1)) then
                    -- 进度100的直接往后放
                    if (pro_1 == 1 and pro_1 > pro_2) then
                        return false
                    end
                    if (pro_2 == 1 and pro_1 < pro_2) then
                        return true
                    end
                else
                    -- tid从小到大
                    if (heroConfigVo_1.tid ~= heroConfigVo_2.tid) then
                        return heroConfigVo_1.tid < heroConfigVo_2.tid
                    end
                end
            end
        elseif (not isOpen_1 and isOpen_2) then
            return false
        elseif (isOpen_1 and not isOpen_2) then
            return true
        else
            return heroConfigVo_1.tid < heroConfigVo_2.tid
        end
    end
    return false
end

-- 判断对应的的英雄是否已开启传记
function isBiographyOpen(self, heroTid)
    if (self.m_biographyDic and self.m_biographyDic[heroTid]) then
        return true
    else
        return false
    end
end

-- 获取对应的的英雄的已开启传记列表
function getBiographyList(self, heroTid)
    if (self:isBiographyOpen(heroTid)) then
        table.sort(self.m_biographyDic[heroTid], self.__sortBiographyList)
        return self.m_biographyDic[heroTid]
    else
        return {}
    end
end

function setHeroFollow(self, heroTid, follow)
    local vo = self:getBiographyList(heroTid)

end

-- 根据英雄tid和传记id获取传记数据
function getBiographyVo(self, heroTid, biographyId)
    if (self:isBiographyOpen(heroTid)) then
        for i = 1, #self.m_biographyDic[heroTid] do
            if (self.m_biographyDic[heroTid][i].biographyId == biographyId) then
                return self.m_biographyDic[heroTid][i]
            end
        end
    end
end

-- 根据传记的副本id获取传记数据
function getBiographyVoById(self, dupId)
    local biographyId = -1
    local heroTid = -1
    -- 通过副本id反向查找传记id
    for _biographyId, configVo in pairs(self.m_biographyInfoConfigDic) do
        local dupList = configVo:getChapterList()
        for j = 1, #dupList do
            if (dupList[j] == dupId) then
                biographyId = _biographyId
            end
        end
    end

    if (biographyId == -1) then
        return nil
    end

    -- 通过传记id反向查找英雄tid
    for _heroTid, configVo in pairs(self.m_biographyConfigDic) do
        local biographyList = configVo:getBiographyList()
        for j = 1, #biographyList do
            if (biographyList[j] == biographyId) then
                heroTid = _heroTid
            end
        end
    end

    if (heroTid == -1) then
        return nil
    end

    return self:getBiographyVo(heroTid, biographyId)
end

-- 英雄传记列表排序
function __sortBiographyList(biographyVo_1, biographyVo_2)
    if (biographyVo_1 and biographyVo_2) then
        -- biographyId从小到大
        if (biographyVo_1.biographyId > biographyVo_2.biographyId) then
            return false
        end
        if (biographyVo_1.biographyId < biographyVo_2.biographyId) then
            return true
        end
    end
    return false
end

-- 根据传记id和副本id获取奖励列表
function getAwardList(self, dupId)
    local propsList = {}
    local dupConfigVo = self:getDupConfigVo(dupId)
    local awardList = dupConfigVo:getChapterAward()
    for i = 1, #awardList do
        local data = awardList[i]
        local propsVo = props.PropsVo.new()
        propsVo:setTid(data[1])
        propsVo.count = data[2]
        table.insert(propsList, propsVo)
    end
    return propsList
end

-- 获取副本章节名和副本名
function getDupName(self, cusId)
    local dupVo = self:getDupConfigVo(cusId)
    local chapterVo = self:getBiographyConfigVo(dupVo:getBiographyId())
    return chapterVo:getName(), dupVo:getName()
end

-- 获取副本章节名和副本名
function getRecommandFight(self, cusId)
    local dupVo = self:getDupConfigVo(cusId)
    return dupVo:getRecommendForce()
end

-- 本地记录下每次进入的英雄tid和传记id
function setLastData(self, heroTid, biographyId)
    self.mLastHeroTid, self.mLastBiographyId = heroTid, biographyId
end
function getLastData(self)
    return self.mLastHeroTid, self.mLastBiographyId
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]