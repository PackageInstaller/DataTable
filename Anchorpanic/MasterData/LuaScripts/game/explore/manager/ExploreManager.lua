module("explore.ExploreManager", Class.impl(Manager))

--探索战员变更
EXPLORE_HERO_SELECT_CHANGE = "EXPLORE_HERO_SELECT_CHANGE"
EVENT_DATA_UPDATE = "EVENT_DATA_UPDATE"

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
    self.m_exploreDataDic = nil
    self.m_exploreArenaData = nil
    self.m_heroList = nil
end

--服务端下发信息
function parseExploreMsg(self, msg)
    self.m_exploreArenaData = {}
    for i = 1, #msg.area_list do
        local vo = explore.ExploreArenaVo.new()
        vo:parseArenaData(msg.area_list[i])
        self.m_exploreArenaData[msg.area_list[i].area_id] = vo
    end
    self:dispatchEvent(self.EVENT_DATA_UPDATE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVENANT_RED_FLAG)
end

function parseUpdateExploreMsg(self, msg)
    if(not self.m_exploreArenaData[msg.area_info.area_id]) then 
        self.m_exploreArenaData[msg.area_info.area_id] = explore.ExploreArenaVo.new()
    end

    self.m_exploreArenaData[msg.area_info.area_id]:parseArenaData(msg.area_info)
    GameDispatcher:dispatchEvent(EventName.UPDATE_EXPLORE_SELECT, {id = msg.area_info.area_id, event = self.m_exploreArenaData[msg.area_info.area_id]})
    GameDispatcher:dispatchEvent(EventName.UPDATE_CONVENANT_RED_FLAG)
end

--获取事件配置
function getExploreMsgData(self)
    if (self.m_exploreArenaData == nil) then
        logInfo("未收到服务器下发的消息!!!!")
        return
    end

    return self.m_exploreArenaData
end

--解析探索的配置信息
function parseExploreData(self)
    self.m_exploreDataDic = {}
    local baseData = RefMgr:getData("area_explore_data")
    for id, data in pairs(baseData) do
        local vo = explore.ExploreDataVo.new()
        vo:parseConfigData(data)
        self.m_exploreDataDic[id] = vo
    end
end

--获取探索的配置信息
function getExploreData(self)
    if (self.m_exploreDataDic == nil) then
        self:parseExploreData()
    end

    return self.m_exploreDataDic
end

--获取所有战员
function getHeroDic(self)
    local heroDic = hero.HeroManager:getHeroDic()
    return heroDic
end

--获取所有已经探索中的战员
function getAllExploreHero(self)
    local ids = {}
    local data = self:getExploreMsgData()

    for j = 1, 5 do
        for i = 1, #data[j].heroIdList do
            table.insert(ids, data[j].heroIdList[i])
        end
    end
    return ids
end

--通过Id 获取出站的战员
function getHerosById(self, id)
    local retList = {}
    local data = self:getExploreMsgData()
    for i = 1, #(data[id].heroIdList) do
        local heroVo = hero.HeroManager:getHeroVo(data[id].heroIdList[i])
        table.insert(retList, heroVo)
    end
    return retList
end

--通过Id 获取战员是否已经探索
function getExploreHeroById(self, id)
    local ids = self:getAllExploreHero()
    return table.indexof01(ids, id) > 0
end

function getData(self)
    return formation.FormationManager:getData()
end

--设置英雄选择列表
function setHeroList(self, heroList)
    self.m_heroList = heroList
end

--获取英雄选择列表
function getHeroList(self)
    return self.m_heroList
end

--获取该id角色是否被选择
function getHeroSelect(self, id)
    if self.m_heroList == nil then
        return false
    end
    return table.indexof01(self.m_heroList, id) > 0
end

--变更该id角色被选状态
function changeHeroList(self, id, showFull)
    if self:getExploreHeroById(id) then
        if (showFull == nil or showFull) then
            gs.Message.Show(_TT(40031))--"战员已经在探索中")
        end
        return false
    end

    local idx = table.indexof01(self.m_heroList, id)
    local reIdx = table.indexof01(self.m_heroList, -1)

    if idx > 0 then
        self.m_heroList[idx] = -1
    else
        if reIdx == 0 then
            if (showFull == nil or showFull) then
                gs.Message.Show(_TT(40032))--"战员已经选满了")
            end
            return false
        end
        self.m_heroList[reIdx] = id
    end
    return true
end

function getExploreRed(self)
    --声望等级
    local level = role.RoleManager:getRoleVo():getPlayerLvl() --covenant.CovenantManager:getPerstigeStage()
    --探索配置信息
    local dic = self:getExploreData()
    local events = self:getExploreMsgData()
    if not events then
        return false
    end

    for i = 1, #events do
        local needLevel = dic[i].level
        if (level and needLevel and needLevel <= level) then
            if (events[i].state ~= 1) then
                if (events[i].todayExploreTimes ~= 1) then
                    return true
                end
            end
        end
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
