--[[ 
-----------------------------------------------------
@filename       : MainExploreSceneManager
@Description    : 主线探索场景数据管理器
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreSceneManager", Class.impl(Manager))

-- 玩家攻击事件更新
PLAYER_TARGET_ATTACK_UPDATE = "PLAYER_TARGET_ATTACK_UPDATE"
-- 玩家提示事件更新
PLAYER_TARGET_REMIND_UPDATE = "PLAYER_TARGET_REMIND_UPDATE"
-- 初次对话事件更新
PLAYER_FIRST_INTRODUCE_UPDATE = "PLAYER_FIRST_INTRODUCE_UPDATE"
-- 交互对象列表更新
PLAYER_INTERACT_UPDATE = "PLAYER_INTERACT_UPDATE"
-- 环境对象列表更新
PLAYER_ENVIROMENT_UPDATE = "PLAYER_ENVIROMENT_UPDATE"

--构造函数
function ctor(self)
    super.ctor(self)

    self:__initConfigData()
    self:__initClientData()
    self:__initMsgData()
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)

     self:__initConfigData()
     self:__initClientData()
     self:__initMsgData()
end

---------------------------------------------------------------start 配置数据相关---------------------------------------------------------------
function __initConfigData(self)
    -- 地图配置
    self.mMapConfigDic = nil
    -- 客户端地图配置
    self.mClientMapConfigDic = nil
    -- 客户端地图格子配置
    self.mClientMapGridConfigDic = nil
    -- 副本对应地图配置
    self.mDupMapConfigDic = nil
    -- 物件配置
    self.mItemConfigDic = nil
    -- 事件配置
    self.mEventConfigDic = nil
    -- 副本配置
    self.mDupConfigDic = nil
    -- 玩家配置
    self.mPlayerConfigDic = nil
    -- 物资配置
    self.mGoodsConfigDic = nil
    -- 玩法配置
    self.mPlayConfigDic = nil
    -- 介绍配置
    self.mIntroduceConfigDic = nil
end

-- 解析探索地图配置
function parseMapConfig(self)
    self.mMapConfigDic = {}
    self.mDupMapConfigDic = {}
    self.mEventConfigDic = {}
    local baseData = RefMgr:getData("mainExplore/main_explore_data")
    for mapId, mapData in pairs(baseData) do
        local mapConfigVo = mainExplore.MainExploreMapConfigVo.new()
        mapConfigVo:parseConfig(mapId, mapData)
        self.mMapConfigDic[mapId] = mapConfigVo
        self.mDupMapConfigDic[mapConfigVo.dupType .. "_" .. mapConfigVo.dupId] = mapConfigVo

        if(not self.mEventConfigDic[mapId])then
            self.mEventConfigDic[mapId] = {}
        end
        local eventData = mapData.event_list
        for eventId, list in pairs(eventData) do
            local vo = mainExplore.MainExploreEventConfigVo.new()
            vo:parseConfig(mapId, eventId, list)
            self.mEventConfigDic[mapId][eventId] = vo
        end
    end
end

-- 解析探索地图格子配置
function parseMapGridConfig(self, mapId)
    self.mClientMapConfigDic = self.mClientMapConfigDic or {}
    self.mClientMapGridConfigDic = self.mClientMapGridConfigDic or {}
    self.mClientMapConfigDic[mapId] = {}
    self.mClientMapGridConfigDic[mapId] = {}

    local baseData = RefMgr:getData(string.format("mainExplore/main_explore_map_data_%s", mapId))
    local mapConfigVo = mainExplore.MainExploreClientMapConfigVo.new()
    mapConfigVo:parseConfig(mapId, baseData)
    self.mClientMapConfigDic[mapId] = mapConfigVo

    for _, gridData in pairs(baseData.grid_list) do
        local gridConfigVo = mainExplore.MainExploreClientMapGridConfigVo.new()
        gridConfigVo:parseConfig(mapId, gridData)
        local key = self:getMapGridKey(gridConfigVo.gridRow, gridConfigVo.gridCol)
        self.mClientMapGridConfigDic[mapId][key] = gridConfigVo
    end
end

-- 获取探索地图格子key
function getMapGridKey(self, gridRow, gridCol)
    return gridRow .. "_" .. gridCol
end

-- 获取探索地图配置
function getClientMapConfigVo(self, mapId)
    if(not self.mClientMapConfigDic)then
        self:parseMapGridConfig(mapId)
    end
    return self.mClientMapConfigDic[mapId]
end

-- 获取探索地图格子配置
function getClientMapGridConfigVo(self, mapId, gridRow, gridCol)
    if(not self.mClientMapGridConfigDic)then
        self:parseMapGridConfig(mapId)
    end
    local key = self:getMapGridKey(gridRow, gridCol)
    return self.mClientMapGridConfigDic[mapId][key]
end

-- 解析探索地图对应物件配置
function parseThingConfig(self)
    local mapConfigDic = self:getMapConfigDic()
    self.mItemConfigDic = {}
    for mapId, mapConfigVo in pairs(mapConfigDic) do
        self.mItemConfigDic[mapId] = {}
        local thingBaseData = RefMgr:getData(string.format("mainExplore/main_explore_thing_data_%s", mapId))
        for eventId, itemData in pairs(thingBaseData) do
            eventId = tonumber(eventId)
            local itemConfigVo = mainExplore.MainExploreItemConfigVo.new()
            itemConfigVo:parseConfig(mapId, eventId, itemData)
            self.mItemConfigDic[mapId][eventId] = itemConfigVo
        end
    end
end

-- 解析副本配置
function parseDupConfig(self)
    self.mDupConfigDic = {}
    local baseData = RefMgr:getData("mainExplore/main_explore_dup_data")
    for dupId, list in pairs(baseData) do
        local vo = mainExplore.MainExploreDupConfigVo.new()
        vo:parseConfig(dupId, list)
        self.mDupConfigDic[dupId] = vo
    end
end

-- 解析玩家配置
function parsePlayerConfig(self)
    self.mPlayerConfigDic = {}
    local baseData = RefMgr:getData("mainExplore/main_explore_hero_data")
    for heroTid, list in pairs(baseData) do
        local vo = mainExplore.MainExplorePlayerConfigVo.new()
        vo:parseConfig(heroTid, list)
        self.mPlayerConfigDic[heroTid] = vo
    end
end

-- 解析物资配置
function parseGoodsConfig(self)
    self.mGoodsConfigDic = {}
    local baseData = RefMgr:getData('mainExplore/main_explore_supplies_data')
    for buffId, data in pairs(baseData) do
        local configVo = LuaPoolMgr:poolGet(mainExplore.MainExploreGoodsConfigVo)
        configVo:parseData(buffId, data)
        self.mGoodsConfigDic[buffId] = configVo
    end
end

-- 解析玩法配置（按照副本类型定的）
function parsePlayConfig(self)
    self.mPlayConfigDic = {}
    local baseData = RefMgr:getData('mainExplore/main_explore_play_data')
    for dupType, data in pairs(baseData) do
        local configVo = LuaPoolMgr:poolGet(mainExplore.MainExplorePlayConfigVo)
        configVo:parseData(dupType, data)
        self.mPlayConfigDic[dupType] = configVo
    end
end

-- 解析初次介绍配置
function parseFirstIntroduceConfig(self)
    self.mIntroduceConfigDic = {}
    local baseData = RefMgr:getData('mainExplore/main_explore_introduce_data')
    for introduceId, data in pairs(baseData) do
        local configVo = LuaPoolMgr:poolGet(mainExplore.MainExploreIntroduceConfigVo)
        configVo:parseData(introduceId, data)
        self.mIntroduceConfigDic[introduceId] = configVo
    end
end

-- 获取地图配置
function getMapConfigDic(self)
    if(not self.mMapConfigDic)then
        self:parseMapConfig()
    end
    return self.mMapConfigDic, self.mDupMapConfigDic
end

-- 根据探索地图id获取配置
function getMapConfigVo(self, mapId)
    local mapConfigDic, dupMapConfigDic = self:getMapConfigDic()
    return mapConfigDic[mapId]
end

-- 根据副本类型和副本id获取配置
function getDupMapConfigVo(self, dupType, dupId)
    if(dupType and dupId)then
        local mapConfigDic, dupMapConfigDic = self:getMapConfigDic()
        return dupMapConfigDic[dupType .. "_" .. dupId]
    end
end

-- 获取物件配置
function getItemConfigDic(self)
    if(not self.mItemConfigDic)then
        self:parseThingConfig()
    end
    return self.mItemConfigDic
end

function getItemConfigVo(self, mapId, eventId)
    local configDic = self:getItemConfigDic()
    local thingConfigDic = configDic[mapId]
    if(thingConfigDic)then
        return thingConfigDic[eventId]
    end
end

-- 获取事件配置
function getEventConfigDic(self)
    if(not self.mEventConfigDic)then
        self:parseMapConfig()
    end
    return self.mEventConfigDic
end

function getEventConfigVo(self, mapId, eventId)
    local configDic = self:getEventConfigDic()
    if(configDic[mapId])then
        return configDic[mapId][eventId]
    else
        return nil
    end
end

-- 获取副本配置
function getDupConfigDic(self)
    if(not self.mDupConfigDic)then
        self:parseDupConfig()
    end
    return self.mDupConfigDic
end

function getDupConfigVo(self, dupId)
    local configDic = self:getDupConfigDic()
    return configDic[dupId]
end

-- 获取玩家配置
function getPlayerConfigDic(self)
    if(not self.mPlayerConfigDic)then
        self:parsePlayerConfig()
    end
    return self.mPlayerConfigDic
end

function getPlayerConfigVo(self, eventId)
    local configDic = self:getPlayerConfigDic()
    return configDic[eventId]
end

-- 获取物资数据
function getGoodsConfigVo(self, buffId)
    if(not self.mGoodsConfigDic)then
        self:parseGoodsConfig()
    end
    return self.mGoodsConfigDic[buffId]
end

-- 获取玩法配置数据
function getPlayConfigVo(self, dupType)
    if(not self.mPlayConfigDic)then
        self:parsePlayConfig()
    end
    return self.mPlayConfigDic[dupType]
end

-- 获取玩法配置数据
function getFirstIntroduceConfigVo(self, introduceId)
    if(not self.mIntroduceConfigDic)then
        self:parseFirstIntroduceConfig()
    end
    return self.mIntroduceConfigDic[introduceId]
end

---------------------------------------------------------------end 配置数据相关---------------------------------------------------------------


---------------------------------------------------------------start 本地数据---------------------------------------------------------------
function __initClientData(self)
    self.mThingVoDic = nil
    self.mShowTipList = nil
end

-- 物件数据相关
function addThingVo(self, eventId, aiCtrl, loadFinish)
    local thingVo = nil
    local mapId = mainExplore.MainExploreManager:getTriggerDupData().mapId
    local eventConfigVo = self:getEventConfigVo(mapId, eventId)
    if(not eventConfigVo)then
        Debug:log_error("MainExploreSceneManager", string.format("找不到事件id%s的事件信息配置", eventId))
        return
    end
    if(eventConfigVo.eventType == mainExplore.EventType.DUP_MONSTER or eventConfigVo.eventType == mainExplore.EventType.DUP_BOSS)then
        thingVo = mainExplore.getThingVo(mainExplore.ThingType.MONSTER)
        aiCtrl = aiCtrl or mainExplore.MainExploreMonsterAiCtrl:poolGet()
    elseif(eventConfigVo.eventType == mainExplore.EventType.NPC_TALK)then
        thingVo = mainExplore.getThingVo(mainExplore.ThingType.NPC)
    else
        thingVo = mainExplore.getThingVo(mainExplore.ThingType.NORMAL)
    end

    local itemConfigVo = mainExplore.MainExploreSceneManager:getItemConfigVo(mapId, eventId)
    if(not itemConfigVo)then
        Debug:log_error("MainExploreSceneManager", string.format("找不到事件id%s的位置信息配置", eventId))
        return
    end
    local showData = itemConfigVo.list[1]
    thingVo:setEventConfigVo(eventConfigVo)
    thingVo:setPosXYZ(showData.position.x, showData.position.y, showData.position.z)
    thingVo:setRotationXYZ(showData.rotation.x, showData.rotation.y, showData.rotation.z)

    if(not self.mThingVoDic)then
        self.mThingVoDic = {}
    end
    if(not self.mThingVoDic[eventConfigVo.eventType])then
        self.mThingVoDic[eventConfigVo.eventType] = {}
    end
    table.insert(self.mThingVoDic[eventConfigVo.eventType], thingVo)
    
    mainExplore.MainExploreSceneThingManager:addThing(thingVo, aiCtrl, loadFinish)
end

function removeThingVo(self, eventId)
    local mapId = mainExplore.MainExploreManager:getTriggerDupData().mapId
    local eventConfigVo = self:getEventConfigVo(mapId, eventId)
    local dic = self.mThingVoDic
    if(dic)then
        local list = dic[eventConfigVo.eventType]
        if(list)then
            for i = #list, 1, -1 do
                local thingVo = list[i]
                if(eventId == thingVo:getEventConfigVo().eventId)then
                    if(mainExplore.MainExploreSceneThingManager:removeThing(thingVo))then
                        LuaPoolMgr:poolRecover(table.remove(list, i))
                        return true
                    end
                end
            end
        end
    end
    return false
end

function getThingVo(self, eventId)
    local mapId = mainExplore.MainExploreManager:getTriggerDupData().mapId
    local eventConfigVo = self:getEventConfigVo(mapId, eventId)
    local dic = self.mThingVoDic
    if(dic)then
        local list = dic[eventConfigVo.eventType]
        if(list)then
            for i = 1, #list do
                local thingVo = list[i]
                if(thingVo:getEventConfigVo().eventId == eventId)then
                    return thingVo
                end
            end
        end
    end
end

-- 添加玩家
function addPlayerThingVo(self, playThingVo, aiCtrl, loadFinish)
    mainExplore.MainExploreSceneThingManager:addPlayerThing(playThingVo, aiCtrl, loadFinish)
end

-- 添加消息提示
function setShowTip(self, eventConfigVo, content)
    if(not self.mShowTipList)then
        self.mShowTipList = {}
    end
    table.insert(self.mShowTipList, {eventConfigVo = eventConfigVo, content = content})
    table.sort(self.mShowTipList, self.sortShowTipFun)
    GameDispatcher:dispatchEvent(EventName.SHOW_MAIN_EXPLORE_MESSAGE)
end
function getShowTip(self)
    if(self.mShowTipList and #self.mShowTipList > 0 )then
        return table.remove(self.mShowTipList, 1)
    end
end
-- 从小到大
function sortShowTipFun(data1, data2)
    if (data1.eventConfigVo.eventId < data2.eventConfigVo.eventId) then
        return true
    end
    if (data1.eventConfigVo.eventId > data2.eventConfigVo.eventId) then
        return false
    end
    return false
end

function resetExploreData(self, isResetThing)
    if(isResetThing)then
        mainExplore.MainExploreSceneThingManager:resetExploreData()
    end
	if(self.mThingVoDic)then
		for thingType, thingVoList in pairs(self.mThingVoDic) do
			for _, thingVo in pairs(thingVoList) do
				LuaPoolMgr:poolRecover(thingVo)
			end
		end
	end
	self.mThingVoDic = {}
end
---------------------------------------------------------------end 本地数据---------------------------------------------------------------


---------------------------------------------------------------start 服务器数据相关---------------------------------------------------------------
function __initMsgData(self)
end
---------------------------------------------------------------end 服务器数据相关---------------------------------------------------------------

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
