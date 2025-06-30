module("hero.HeroManager", Class.impl(Manager))

----------------------------- 数据字段更新事件 -----------------------------
-- 英雄相关字段更新
UPDATE_FIELD = "UPDATE_FIELD"
-- 英雄等级更新
UPDATE_FIELD_LVL = "UPDATE_FIELD_LVL"
-- 英雄经验更新
UPDATE_FIELD_EXP = "UPDATE_FIELD_EXP"
-- 英雄经验上限更新
UPDATE_FIELD_MAX_EXP = "UPDATE_FIELD_MAX_EXP"
-- 英雄进化等级更新
UPDATE_FIELD_EVOLUTION_LVL = "UPDATE_FIELD_EVOLUTION_LVL"
-- 英雄军阶更新
UPDATE_FIELD_MILITARY_RANK = "UPDATE_FIELD_MILITARY_RANK"
-- 英雄战力更新
UPDATE_FIELD_POWER = "UPDATE_FIELD_POWER"
-- 英雄亲密度更新
UPDATE_FIELD_INTIMACY = "UPDATE_FIELD_INTIMACY"
-- 英雄是否上锁更新
UPDATE_FIELD_IS_LOCK = "UPDATE_FIELD_IS_LOCK"
-- 英雄是否喜欢更新
UPDATE_FIELD_IS_LIKE = "UPDATE_FIELD_IS_LIKE"
-- 英雄品质更新
UPDATE_FIELD_COLOR = "UPDATE_FIELD_COLOR"
-- 英雄关联助手更新
UPDATE_FIELD_COVENANT_HELPER = "UPDATE_FIELD_COVENANT_HELPER"

--英雄亲密度等级更新
UPDATE_FIELD_RELATION_LEVEL = "UPDATE_FIELD_RELATION_LEVEL"
--英雄亲密度经验更新
UPDATE_FIELD_RELATION_EXP = "UPDATE_FIELD_RELATION_EXP"

--增幅等级变动
UPDATE_GROW_LV = "UPDATE_GROW_LV"

----------------------------- 事件 -----------------------------
-- 英雄界面查看的英雄单选改变
PANEL_SINGLE_SELECT_HERO = "PANEL_SINGLE_SELECT_HERO"
-- 英雄界面查看的英雄改变
PANEL_SHOW_HERO_CHANGE = "PANEL_SHOW_HERO_CHANGE"
-- 英雄通用才来哦界面英雄选择
HERO_MATERIAL_SELECT = "HERO_MATERIAL_SELECT"

-- 英雄界面列表选择更改
HERO_LIST_SELECT = "HERO_LIST_SELECT"

-- 英雄列表初始化
HERO_LIST_INIT = "HERO_LIST_INIT"
-- 英雄列表更新
HERO_LIST_UPDATE = "HERO_LIST_UPDATE"
-- 英雄数据更新
HERO_DATA_UPDATE = "HERO_DATA_UPDATE"
-- 英雄装备属性列表数据更新 仅芯片
HERO_EQUIP_ALL_TOTAL_ATTR_UPDATE = "HERO_EQUIP_ALL_TOTAL_ATTR_UPDATE"
-- 英雄属性更新
HERO_ATTR_UPDATE = "HERO_ATTR_UPDATE"
-- 英雄等级经验更新
HERO_LVL_EXP_UPDATE = "HERO_LVL_EXP_UPDATE"
-- 英雄增加出战技能更新
HERO_ADD_FIGHT_SKILL_RESULT = "HERO_ADD_FIGHT_SKILL_RESULT"
-- 英雄删除出战技能更新
HERO_DEL_FIGHT_SKILL_RESULT = "HERO_DEL_FIGHT_SKILL_RESULT"
-- 英雄技能效果信息更新
HERO_SKILLUP_EFFECT_UPDATE = "HERO_SKILLUP_EFFECT_UPDATE"
-- 战员Develop iew层内部事件
BLOCK_GROUP_TOP_CLICK = "BLOCK_GROUP_TOP_CLICK"

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
    self.m_heroDic = {}
    self.mHeroList = {}
    self.mHeroEleAndOccConfigDic = nil
    self.m_heroConfigDic = nil
    self.m_heroIncreasesDic = nil
    self.mShowHeroList = {}
    self.liveActionList = nil
    self.mAllSortList = nil
    self.mIsVerticalSort = StorageUtil:getBool0("listType")
    self.mIsFormationHeroList = false
end

function getIsFormationList(self)
    return self.mIsFormationHeroList
end

function getIsVer(self)
    return self.mIsVerticalSort
end

function setIsVer(self, isVer)
    self.mIsVerticalSort = isVer
    StorageUtil:saveBool0("listType", self.mIsVerticalSort)
end

-- 初始化英雄配置表
function parseConfigData(self)
    self.m_heroConfigDic = {}
    self.mHeroConfigList = {}

    local baseData = nil
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if(GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3))then
        if(web.WebManager.net_type == web.NET_TYPE.OUTER_TEST)then
            baseData = RefMgr:getData("hero_data_channel_test")
        else
            baseData = RefMgr:getData("hero_data_channel")
        end
    else
        baseData = RefMgr:getData("hero_data")
    end
    for key, data in pairs(baseData) do
        if data.is_hide == 0 then -- 策划配置不显示战员
            local vo = hero.HeroConfigVo.new()
            vo:parseConfigData(key, data)
            self.m_heroConfigDic[vo.tid] = vo
            table.insert(self.mHeroConfigList, vo)
        end
    end
end

-- 职业与属性配置表
function parseOccAndEleConfigData(self)
    self.mHeroEleAndOccConfigDic = {}
    local baseData = RefMgr:getData("hero_tips_data")
    for _, data in pairs(baseData) do
        local vo = hero.HeroEleAndOccVo.new()
        vo:parseConfigData(data)
        if not self.mHeroEleAndOccConfigDic[vo.type] then
            self.mHeroEleAndOccConfigDic[vo.type] = {}
        end
        if table.indexof(self.mHeroEleAndOccConfigDic[vo.type], vo) == false then
            table.insert(self.mHeroEleAndOccConfigDic[vo.type], vo)
        end
    end
    for _, listVo in pairs(self.mHeroEleAndOccConfigDic) do
        table.sort(listVo, function(Vo1, Vo2) return Vo1.subType < Vo2.subType end)
    end
end
-- 根据类型获取相应列表数据
function getOccAndEleConfigList(self, type)
    if not self.mHeroEleAndOccConfigDic then
        self:parseOccAndEleConfigData()
    end
    return self.mHeroEleAndOccConfigDic[type] or {}
end

-- 初始化增幅配置表
function parseHeroIncreasesData(self)
    self.m_heroIncreasesDic = {}
    local baseData = RefMgr:getData("hero_increases_data")
    for id, data in pairs(baseData) do
        local vo = hero.HeroIncreasesVo.new()
        vo:parseHeroIncreasesData(data)
        self.m_heroIncreasesDic[id] = vo
    end
end

-----------------------------------------------------------------------数据响应 start---------------------------------------------------------------------------
--解锁战员的看板娘动作
function addUnlockLiveAction(self, model_id, aciton_id)
    if not self.liveActionList then
        self.liveActionList = {}
    end

    if not self.liveActionList[model_id] then
        self.liveActionList[model_id] = {}
    end

    self.liveActionList[model_id][aciton_id] = aciton_id
end

--获取看板娘动作是否解锁了
function isUnlockLiveAction(self, model_id, actionHash)
    if not hero.HeroActionManager:getActionIsNeedItemOpen(model_id, actionHash) then
        return true
    end

    if not self.liveActionList then
        return false
    end

    if not self.liveActionList[model_id] then
        return false
    end

    local configData = hero.HeroActionManager:getConfigData(model_id)
    local aciton_id = configData.action[actionHash].action_id
    return self.liveActionList[model_id][aciton_id] ~= nil
end

-- 解析英雄预览列表
function parseMsgHeroPreList(self, cusMsgList)
    local isRealUpdate = false
    local len = #cusMsgList
    for i = 1, len do
        if (not self.m_heroDic[cusMsgList[i].id]) then
            isRealUpdate = true
            local heroVo = hero.HeroVo.new()
            local parseResult = heroVo:parsePreMsgData(cusMsgList[i])
            if (parseResult) then
                self.m_heroDic[heroVo.id] = heroVo
            end
        end
    end
    GameDispatcher:dispatchEvent(EventName.HERO_LIST_INIT)
end

-- 解析英雄列表
function parseMsgHeroList(self, cusMsgList)
    local isRealUpdate = false
    local len = #cusMsgList
    for i = 1, len do
        if (not self.m_heroDic[cusMsgList[i].id]) then
            isRealUpdate = true

            local heroVo = hero.HeroVo.new()
            local parseResult = heroVo:parseMsgData(cusMsgList[i])
            if (parseResult) then
                self.m_heroDic[heroVo.id] = heroVo
            end
        end
    end
    if (isRealUpdate) then
        GameDispatcher:dispatchEvent(EventName.HERO_LIST_INIT)
    end
end

-- 更新英雄列表
function parseMsgUpdateHeroList(self, cusAddList, cusDelList)
    local addSucList = {}
    local len = #cusAddList
    for i = 1, len do
        local heroVo = hero.HeroVo.new()
        local parseResult = heroVo:parseMsgData(cusAddList[i])
        if (parseResult) then
            self.m_heroDic[heroVo.id] = heroVo
            table.insert(addSucList, heroVo.id)
        end
    end

    len = #cusDelList
    for i = 1, len do
        local heroId = cusDelList[i]
        if (self.m_heroDic[heroId]) then
            self.m_heroDic[heroId] = nil
        end
    end
    GameDispatcher:dispatchEvent(EventName.HERO_LIST_UPDATE, {addList = addSucList, delList = cusDelList})
end

-- 更新英雄详细数据
function parseMsgHeroDataUpdate(self, cusMsg)
    local parseResult = false
    local heroVo = self.m_heroDic[cusMsg.id]
    if not heroVo then
        heroVo = hero.HeroVo.new()
        parseResult = heroVo:parseMsgData(cusMsg)
        self.m_heroDic[heroVo.id] = heroVo
    else
        parseResult = heroVo:parseDetailMsgData(cusMsg)
    end
    if (parseResult) then
        GameDispatcher:dispatchEvent(EventName.HERO_DATA_UPDATE, {heroId = heroVo.id})
    end
end

-- 英雄装备总属性数据更新
function parseMsgHeroEquipTotalAttrUpdate(self, cusMsg)
    -- print("英雄装备全部模块总属性数据更新", cusMsg.id)
    local heroVo = self:getHeroVo(cusMsg.id)
    if (heroVo) then
        heroVo:setEquipAttrList(cusMsg.equip_attr_list)
        GameDispatcher:dispatchEvent(EventName.HERO_DATA_UPDATE, {heroId = heroVo.id})
    end
end

-- 英雄装备全部总属性数据更新（英雄装备总属性界面专用(6芯片部位)）
-- 当前只有芯片会发 且跟在总属性更新之后
function parseMsgHeroEquipAllTotalAttrUpdate(self, cusMsg)
    -- print("英雄装备全部总属性数据更新", cusMsg.id)
    local heroVo = self:getHeroVo(cusMsg.id)
    if (heroVo and cusMsg.equip_type == 1) then
        heroVo:setEquipAttrListAll(cusMsg.equip_attr_list)
        self:dispatchEvent(self.HERO_EQUIP_ALL_TOTAL_ATTR_UPDATE, {heroId = heroVo.id})
    end
end

-- 更新英雄属性列表
function parseMsgHeroAttrList(self, cusHeroId, pt_attr)
    local heroVo = self:getHeroVo(cusHeroId)
    if (heroVo) then
        heroVo:setAttrList(pt_attr)
        self:dispatchEvent(self.HERO_ATTR_UPDATE, {heroId = cusHeroId})
    end
end

-- 更新英雄新增出站技能
function parseMsgHeroAddFightSkill(self, cusMsg)
    if (cusMsg.result) then
        local heroVo = self:getHeroVo(cusMsg.hero_id)
        if (heroVo) then
            heroVo:setFightSkillList(cusMsg.fight_skill_list)
            local addSkillId = cusMsg.skill_id
            self:dispatchEvent(self.HERO_ADD_FIGHT_SKILL_RESULT, {heroId = heroVo.id, addSkillId = addSkillId})
        end
    end
end

-- 更新英雄删除出战技能
function parseMsgHeroDelFightSkill(self, cusMsg)
    if (cusMsg.result) then
        local heroVo = self:getHeroVo(cusMsg.hero_id)
        if (heroVo) then
            heroVo:setFightSkillList(cusMsg.fight_skill_list)
            local delSkillId = cusMsg.skill_id
            self:dispatchEvent(self.HERO_DEL_FIGHT_SKILL_RESULT, {heroId = heroVo.id, delSkillId = delSkillId})
        end
    end
end

-- 更新英雄的字段信息
function parseMsgHeroFieldValue(self, heroId, attrList)
    local heroVo = self:getHeroVo(heroId)
    if (heroVo) then
        local len = #attrList
        for i = 1, len do
            local key = attrList[i].key
            local value = tonumber(attrList[i].value)
            self:updateHeroField(heroVo, key, value, i == len)
            --print("英雄数据字段更新, heroId=" .. heroId .. ", key=" .. key .. ", value=" .. value)
        end
    end
end

-- 更新英雄字段信息
function updateHeroField(self, heroVo, key, value, isDispatchAllField)
    if (heroVo and key and value) then
        local fieldType = ""
        local updateFieldType = ""
        local heroId = heroVo.id
        if (key == hero.DataFieldKey.HERO_LEVEL) then
            heroVo.lvl = value
            fieldType = hero.DataFieldKey.HERO_LEVEL
            updateFieldType = self.UPDATE_FIELD_LVL
        elseif (key == hero.DataFieldKey.HERO_MAX_EXP) then
            heroVo.maxExp = value
            fieldType = hero.DataFieldKey.HERO_MAX_EXP
            updateFieldType = self.UPDATE_FIELD_MAX_EXP
        elseif (key == hero.DataFieldKey.HERO_EXP) then
            heroVo.exp = value
            fieldType = hero.DataFieldKey.HERO_EXP
            updateFieldType = self.UPDATE_FIELD_EXP
        elseif (key == hero.DataFieldKey.HERO_EVOLUTION_LVL) then
            heroVo.evolutionLvl = value
            fieldType = hero.DataFieldKey.HERO_EVOLUTION_LVL
            updateFieldType = self.UPDATE_FIELD_EVOLUTION_LVL
        elseif (key == hero.DataFieldKey.HERO_MILITARY_RANK) then
            heroVo.militaryRank = value
            fieldType = hero.DataFieldKey.HERO_MILITARY_RANK
            updateFieldType = self.UPDATE_FIELD_MILITARY_RANK
        elseif (key == hero.DataFieldKey.HERO_POWER) then
            heroVo.power = value
            fieldType = hero.DataFieldKey.HERO_POWER
            updateFieldType = self.UPDATE_FIELD_POWER
        elseif (key == hero.DataFieldKey.HERO_INTIMACY) then
            heroVo.intimacy = value
            fieldType = hero.DataFieldKey.HERO_INTIMACY
            updateFieldType = self.UPDATE_FIELD_INTIMACY
        elseif (key == hero.DataFieldKey.HERO_IS_LOCK) then
            heroVo.isLock = value
            fieldType = hero.DataFieldKey.HERO_IS_LOCK
            updateFieldType = self.UPDATE_FIELD_IS_LOCK
        elseif (key == hero.DataFieldKey.HERO_IS_LIKE) then
            heroVo.isLike = value
            fieldType = hero.DataFieldKey.HERO_IS_LIKE
            updateFieldType = self.UPDATE_FIELD_IS_LIKE
        elseif (key == hero.DataFieldKey.HERO_COLOR) then
            heroVo.color = value
            fieldType = hero.DataFieldKey.HERO_COLOR
            updateFieldType = self.UPDATE_FIELD_COLOR
        elseif (key == hero.DataFieldKey.COVENANT_HELPER) then
            heroVo.covanantHelperId = value
            fieldType = hero.DataFieldKey.COVENANT_HELPER
            updateFieldType = self.UPDATE_FIELD_COVENANT_HELPER
        elseif (key == hero.DataFieldKey.HERO_RELATION_LEVEL) then
            heroVo.favorableLevel = value
            fieldType = hero.DataFieldKey.HERO_RELATION_LEVEL
            updateFieldType = self.UPDATE_FIELD_RELATION_LEVEL
        elseif (key == hero.DataFieldKey.HERO_RELATION_EXP) then
            heroVo.favorableExp = value
            fieldType = hero.DataFieldKey.HERO_RELATION_EXP
            updateFieldType = self.UPDATE_FIELD_RELATION_EXP
        elseif (key == hero.DataFieldKey.HERO_GROW_LV) then
            heroVo.growLv = value
            fieldType = hero.DataFieldKey.HERO_GROW_LV
            updateFieldType = self.UPDATE_GROW_LV
        end

        if (updateFieldType ~= "" and fieldType ~= "") then
            self:dispatchEvent(updateFieldType, {fieldType = fieldType, heroId = heroId})
        end
        if (isDispatchAllField) then
            self:dispatchEvent(self.UPDATE_FIELD, {fieldType = fieldType, heroId = heroId})
        end
    end
end

-----------------------------------------------------------------------数据响应 end---------------------------------------------------------------------------
-- 获取英雄配置数据字典
function getHeroConfigDic(self)
    if (not self.m_heroConfigDic) then
        self:parseConfigData()
    end
    return self.m_heroConfigDic
end

-- 获取全部英雄数量
function getHeroListNum(self)
    if (not self.mHeroConfigList) then
        self:parseConfigData()
    end
    return #self.mHeroConfigList
end

-- 获取英雄数据字典
function getHeroDic(self)
    return self.m_heroDic
end

-- 根据tid英雄id
function getHeroIdByTid(self, tid)
    for k, v in pairs(self:getHeroDic()) do
        if v.tid == tid then return k end
    end
    return nil
end

-- 根据tid获取英雄数据
function getHeroVoByTid(self, tid)
    local id = self:getHeroIdByTid(tid)
    return self:getHeroVo(id)
end

-- 根据tid获取英雄配置
function getHeroConfigVo(self, cusTid)
    self:getHeroConfigDic()
    return self.m_heroConfigDic[cusTid]
end
--获取全部英雄列表
function getAllHeroList(self)
    if #self.mHeroList > 0 then
        self.mHeroList = {}
    end
    for _, vo in ipairs(self.m_heroDic) do
        table.insert(self.mHeroList, vo)
    end
    return self.mHeroList
end
--根据tid获取英雄Index
function getIndexByHeroConfigVo(self, cusTid)
    for i, v in ipairs(self.mShowHeroList) do
        if v.tid == cusTid then
            return i
        end
    end
end

-- 根据id获取英雄数据
function getHeroVo(self, cusId)
    return self:getHeroDic()[cusId]
end

function getFirstHeroId(self)
    local heroId = nil
    local heroList = hero.HeroManager:getHeroList(true)
    for i = 1, #heroList do
        heroId = heroList[i].id
        break
    end
    return heroId
end

-- 获取所有的英雄tid列表
function getAllHeroTidList(self)
    local tidList = {}
    for id, heroVo in pairs(self.m_heroDic) do
        if (table.indexof(tidList, heroVo.tid) == false) then
            table.insert(tidList, heroVo.tid)
        end
    end
    return tidList
end

-- 获取所有的英雄id列表
function getAllHeroIdList(self)
    local idList = {}
    for id, heroVo in pairs(self.m_heroDic) do
        if (table.indexof(idList, heroVo.id) == false) then
            table.insert(idList, heroVo.id)
        end
    end
    return idList
end

-- 根据指定类型获取英雄列表
-- checkHeroId：检测是否包含该英雄id
function getHeroScrollList(self, selectType, selectSubType, checkHeroId, isSort)
    local isInclude = false
    isSort = isSort == nil and true or isSort
    selectType = selectType == nil and hero.panelSortType.ALL or selectType
    local heroScrollList = {}
    for id, heroVo in pairs(self.m_heroDic) do
        local isSelect = false
        if (not isSelect and selectType == hero.panelSortType.ALL) then
            isSelect = true
        elseif (not isSelect and selectType == hero.panelSortType.COLOR) then
            if (heroVo.color == selectSubType) then
                isSelect = true
            end
        elseif (not isSelect and selectType == hero.panelSortType.PROFESSION) then
            if (heroVo.professionType == selectSubType) then
                isSelect = true
            end
        end
        if (isSelect) then
            if (not isInclude and id == checkHeroId) then
                isInclude = true
            end
            local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollVo:setDataVo(heroVo)
            table.insert(heroScrollList, scrollVo)
        end
    end
    if (isSort) then
        local sortHeroScrollList = function(heroScrollVo_1, heroScrollVo_2)
            return hero.descendingColorFun(heroScrollVo_1:getDataVo(), heroScrollVo_2:getDataVo())
        end
        table.sort(heroScrollList, sortHeroScrollList)
    end
    return heroScrollList, isInclude
end

-- 获取已有的英雄
function getHeroList(self, isSort, exceptHeroIdList)
    local heroList = {}
    if (self.m_heroDic) then
        for k, heroVo in pairs(self.m_heroDic) do
            if (exceptHeroIdList) then
                if (table.indexof(exceptHeroIdList, heroVo.id) == false) then
                    table.insert(heroList, heroVo)
                end
            else
                table.insert(heroList, heroVo)
            end
        end
        if (isSort == nil or isSort == true) then
            table.sort(heroList, hero.descendingColorFun)
        end
    end
    return heroList
end

--通过tid判断是否已获得本战员
function getIsObtain(self, cusTid)
    for _, v in ipairs(self:getHeroList(false)) do
        if v.tid == cusTid then
            return true, v
        end
    end
    return false
end

-- 获取本地缓存的是否过滤相同英雄 "1" or "0"
function getFilterSameHero(self)
    return StorageUtil:getString0('HeroListSort_filterSameHero')
end
-- 设置本地缓存的是否过滤相同英雄
function setFilterSameHero(self, state)
    StorageUtil:saveString0('HeroListSort_filterSameHero', state)
end

--获取增幅配置信息
function getHeroIncreaseData(self, tid)
    if self.m_heroIncreasesDic == nil then
        self:parseHeroIncreasesData()
    end
    return self.m_heroIncreasesDic[tid]
end

-- 获取id最小战员
function getMinHeroId(self)
    return sysParam.SysParamManager:getValue(SysParamType.FIRST_HERO_ID)
end

-- 获取未获得的英雄
function getUnGetHeroList(self)
    local hasHeroTidList = self:getAllHeroTidList()
    local unGetCanComposeList = {}
    local unGetUnComposeList = {}
    local heroConfigDic = self:getHeroConfigDic()
    for tid, heroConfigVo in pairs(heroConfigDic) do
        if (table.indexof(hasHeroTidList, tid) == false) then
            local isEnough = hero.HeroFlagManager:isHeroCanUnLock(heroConfigVo)
            if (isEnough) then
                table.insert(unGetCanComposeList, heroConfigVo)
            else
                table.insert(unGetUnComposeList, heroConfigVo)
            end
        end
    end
    return unGetCanComposeList, unGetUnComposeList
end
--获取未获得英雄-结合集满和未集满
function getAllUnGetHeroList(self)
    local hasHeroTidList = self:getAllHeroTidList()
    local unGetCanComposeList = {}
    local unGetUnComposeList = {}
    local heroConfigDic = self:getHeroConfigDic()
    for tid, heroConfigVo in pairs(heroConfigDic) do
        if (table.indexof(hasHeroTidList, tid) == false) then
            local isEnough = hero.HeroFlagManager:isHeroCanUnLock(heroConfigVo)
            if (isEnough) then
                table.insert(unGetCanComposeList, heroConfigVo)
            else
                table.insert(unGetUnComposeList, heroConfigVo)
            end
        end
    end
    for _, vo in ipairs(unGetUnComposeList) do
        table.insert(unGetCanComposeList, vo)
    end
    return unGetCanComposeList
end
--获取当前战员列表
function getCurShowHeroList(self)
    return self.mShowHeroList
end

--获取当前展示的战员列表
function setCurHeroList(self, heroList)
    if #self.mShowHeroList > 0 then
        self.mShowHeroList = {}
    end
    for _, vo in ipairs(heroList) do
        table.insert(self.mShowHeroList, vo)
    end
end
--------------------------------------------------------------------------界面设定使用的数据----------------------------------------------------------------------------
function setFilterData(self, data)
    self.mFilterData = data
    self:setRsyncSingleFilterData()
end
function getFilterData(self)
    return self.mFilterData
end

function setRsyncSingleFilterData(self)
    self.mSingleFilterData = table.copy(self.mFilterData)
end
function getRsyncSingleFilterData(self)
    return self.mSingleFilterData
end

-- 设置英雄界面查看的英雄
function setPanelShowHeroId(self, heroId)
    if (self.mPanelShowHeroId == nil or heroId == nil) then
        self.mPanelShowHeroId = heroId
    elseif (self.mPanelShowHeroId ~= heroId) then
        self.mPanelShowHeroId = heroId
        hero.setHeroPanelOffset(nil)
        hero.setSingleSelectOffset(nil)
        self:dispatchEvent(self.PANEL_SHOW_HERO_CHANGE)
    end
end
function getPanelShowHeroId(self)
    return self.mPanelShowHeroId
end
-- 当前界面查看的英雄列表
function setPanelShowHeroIdList(self, heroIdList, isFormation)
    self.mIsFormationHeroList = isFormation
    self.mPanelShowHeroIdList = heroIdList
end
-- 获取当前界面查看的英雄列表
function getPanelShowHeroIdList(self)
    return self.mPanelShowHeroIdList
end
function getPanelShowLastHeroId(self, heroId)
    local lastHeroId = nil
    if (self.mPanelShowHeroIdList) then
        local isSearched = false
        for i = #self.mPanelShowHeroIdList, 1, -1 do
            if (heroId == self.mPanelShowHeroIdList[i]) then
                isSearched = true
            elseif (isSearched) then
                lastHeroId = self.mPanelShowHeroIdList[i]
                if (self:getHeroVo(lastHeroId)) then
                    return lastHeroId
                else
                    lastHeroId = nil
                end
            end
        end
    end
    return lastHeroId
end

function getPanelShowNextHeroId(self, heroId)
    local nextHeroId = nil
    if (self.mPanelShowHeroIdList) then
        local isSearched = false
        for i = 1, #self.mPanelShowHeroIdList do
            if (heroId == self.mPanelShowHeroIdList[i]) then
                isSearched = true
            elseif (isSearched) then
                nextHeroId = self.mPanelShowHeroIdList[i]
                if (self:getHeroVo(nextHeroId)) then
                    return nextHeroId
                else
                    nextHeroId = nil
                end
            end
        end
    end
    return nextHeroId
end

function setAllSortList(self, list)
    self.mAllSortList = list
end

-- 全列表的排序，内为LyScrollerSelectVo数据
function getAllSortList(self, list)
    return self.mAllSortList
end

--------------------------------------------------------------------------英雄升星提升----------------------------------------------------------------------------
function parseStarUpData(self)
    --attr_coefficient
    self.mStarUpDic = {}
    local baseData = RefMgr:getData("hero_type_data")
    for k, v in pairs(baseData) do
        self.mStarUpDic[k] = v.attr_coefficient
    end
end

function getStarUpCoefficient(self, color)
    if self.mStarUpDic == nil then
        self:parseStarUpData()
    end
    return self.mStarUpDic[color]
end

----------------------------------------------------------------------共鸣---------------------------
function getHeroResonanceConfigVo(self, heroTid)
    if not self.m_heroResonanceConfigDic then
        self.m_heroResonanceConfigDic = {}

        local baseData = RefMgr:getData("hero_resonance_data")
        for key, data in pairs(baseData) do
            self.m_heroResonanceConfigDic[key] = {}
            for pos, resonance in pairs(data.resonance_attr) do
                local vo = hero.HeroResonanceConfigVo.new()
                vo:parseConfigData(pos, resonance)
                self.m_heroResonanceConfigDic[key][pos] = vo
            end
        end
    end

    return self.m_heroResonanceConfigDic[heroTid]
end

----------------------------------------------------------------------场景---------------------------

function parseHeroSceneData(self, msg)
    self.mHeroSceneDic = {}
    for i = 1, #msg.fashion_scene_list do
        self.mHeroSceneDic[msg.fashion_scene_list[i].hero_tid] = msg.fashion_scene_list[i].scene_list
    end
end

function getHeroSceneUnlock(self, heroTid, sceneId)
    if self.mHeroSceneDic and self.mHeroSceneDic[heroTid] then
        for i = 1, #self.mHeroSceneDic[heroTid] do
            return table.indexof01(self.mHeroSceneDic[heroTid], sceneId) > 0
        end
    end
    return false
end

function parseHeroSceneUnlockData(self, msg)
    if msg.result == 1 then
        if not self.mHeroSceneDic[msg.hero_tid] then
            self.mHeroSceneDic[msg.hero_tid] = {}
        end

        table.insert(self.mHeroSceneDic[msg.hero_tid], msg.fashion_id)
    end
end

--析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
