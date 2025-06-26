module("equip.EquipVo", Class.impl(props.PropsVo))

-- 更新装备详细信息
UPDATE_EQUIP_DETAIL_DATA = "UPDATE_EQUIP_DETAIL_DATA"

function ctor(self)
    self:__init()
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    self:__init()
    LuaPoolMgr:poolRecover(self)
end

function __init(self)
    -- 英雄id（0：默认在背包中，其他为英雄id）
    self.heroId = 0
    -- 强化等级
    self.strengthenLvl = nil
    -- 强化经验
    self.strengthenExp = nil
    -- 突破阶段
    self.tuPoRank = nil
    -- 精炼等级/策划叫做星级
    self.refineLvl = nil

    -- 总属性列表
    self.m_totalAttrList = nil
    -- 总属性字典
    self.m_totalAttrDic = nil
    -- 筛选主属性列表（给筛选过滤专用，只在一开始没有属性时使用，后端只作初始化）
    self.m_filterMainAttrList = nil
    -- 筛选主属性字典（给筛选过滤专用，只在一开始没有属性时使用，后端只作初始化）
    self.m_filterMainAttrDic = nil
    -- 筛选附加属性列表（给筛选过滤专用，只在一开始没有属性时使用，后端只作初始化）
    self.m_filterAttachAttrList = nil
    -- 筛选附加属性字典（给筛选过滤专用，只在一开始没有属性时使用，后端只作初始化）
    self.m_filterAttachAttrDic = nil

    -- 突破附加属性列表
    self.m_tuPoAttachAttrList = nil
    -- 突破附加属性字典
    self.m_tuPoAttachAttrDic = nil

    -- 核能属性列表
    self.m_nuclearAttrList = nil
    -- 核能属性字典
    self.m_nuclearAttrDic = nil

    -- 技能效果值列表
    self.m_skillEffectList = nil
    -- 技能效果值字典
    self.m_skillEffectDic = nil

    -- 精炼技能预览效果值列表
    self.m_refineSkillEffectList = nil
    -- 精炼技能预览效果值字典
    self.m_refineSkillEffectDic = nil

    -- 下一强化预览属性
    self.m_strengthenPreAttrList = nil
    -- 下一突破预览属性
    self.m_tuPoPreAttrList = nil

    -- 改造属性列表
    self.m_remakePosAttrList = nil
    -- 改造属性字典
    self.m_remakePosAttrDic = nil

    -- 该装备英雄身上的装备列表（在其他玩家身上使用）
    self.m_otherRoleHeroEquipList = nil

    --是否是新的(没有被查看过)
    self.m_isNew = nil
end

-- 针对其他玩家设置装备英雄身上的装备列表
function setOtherRoleHeroEquipList(self, list)
    self.m_otherRoleHeroEquipList = list
end

function getOtherRoleHeroEquipList(self)
    return self.m_otherRoleHeroEquipList
end

-- 设置附加属性
function setTuPoAttachAttr(self, cusList, isDispatch)
    if (not cusList) then
        self.m_tuPoAttachAttrList = nil
        self.m_tuPoAttachAttrDic = nil
        return
    end
    self.m_tuPoAttachAttrList = {}
    self.m_tuPoAttachAttrDic = {}
    for i = 1, #cusList do
        local vo = cusList[i]
        local isActive = nil
        if(vo.isActive ~= nil)then
            isActive = vo.isActive
        else
            isActive = vo.is_active == 1
        end
        local data = {key = vo.key, value = vo.value, isActive = isActive, breakUpRank = vo.breakUpRank or vo.breakup_rank}
        table.insert(self.m_tuPoAttachAttrList, data)
        self.m_tuPoAttachAttrDic[cusList[i].key] = data
    end
    self:__dispatchUpdateDetailData(isDispatch)
end

-- 获取附加属性
function getTuPoAttachAttr(self)
    if(self.id)then
        -- 含有id向服务器获取属性
        if (not self.m_tuPoAttachAttrList) then
            self:__dispatchReqDetailData()
            return
        end
        local function __sortAttachAttrList(vo_1, vo_2)
            if (vo_1 and vo_2) then
                -- breakUpRank从小到大
                if (vo_1.breakUpRank > vo_2.breakUpRank) then
                    return false
                end
                if (vo_1.breakUpRank < vo_2.breakUpRank) then
                    return true
                end
            end
            return false
        end
        table.sort(self.m_tuPoAttachAttrList, __sortAttachAttrList)
        return self.m_tuPoAttachAttrList, self.m_tuPoAttachAttrDic
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        self.m_tuPoAttachAttrList = self.m_tuPoAttachAttrList or {}
        self.m_tuPoAttachAttrDic = self.m_tuPoAttachAttrDic or {}
        local function __sortAttachAttrList(vo_1, vo_2)
            if (vo_1 and vo_2) then
                -- breakUpRank从小到大
                if (vo_1.breakUpRank > vo_2.breakUpRank) then
                    return false
                end
                if (vo_1.breakUpRank < vo_2.breakUpRank) then
                    return true
                end
            end
            return false
        end
        table.sort(self.m_tuPoAttachAttrList, __sortAttachAttrList)
        return self.m_tuPoAttachAttrList, self.m_tuPoAttachAttrDic
    end
end

-- 设置核能属性
function setNuclearAttr(self, cusList, isDispatch)
    if (not cusList) then
        self.m_nuclearAttrList = nil
        self.m_nuclearAttrDic = nil
        return
    end
    self.m_nuclearAttrList = {}
    self.m_nuclearAttrDic = {}
    for i = 1, #cusList do
        table.insert(self.m_nuclearAttrList, cusList[i])
        self.m_nuclearAttrDic[cusList[i].key] = cusList[i].value
    end
    table.sort(self.m_nuclearAttrList, self.__sortAttrList)
    self:__dispatchUpdateDetailData(isDispatch)
end

-- 获取核能属性
function getNuclearAttr(self)
    if(self.id)then
        -- 含有id向服务器获取属性
        if (not self.m_nuclearAttrList) then
            self:__dispatchReqDetailData()
            return
        end
        return self.m_nuclearAttrList, self.m_nuclearAttrDic
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        self.m_nuclearAttrList = self.m_nuclearAttrList or {}
        self.m_nuclearAttrDic = self.m_nuclearAttrDic or {}
        return self.m_nuclearAttrList, self.m_nuclearAttrDic
    end
end

-- 设置下一强化预览属性
function setStrengthenPreAttr(self, cusList, isDispatch)
    if (not cusList) then
        self.m_strengthenPreAttrList = nil
        return
    end
    self.m_strengthenPreAttrList = {}
    for i = 1, #cusList do
        table.insert(self.m_strengthenPreAttrList, cusList[i])
    end
    table.sort(self.m_strengthenPreAttrList, self.__sortAttrList)
    self:__dispatchUpdateDetailData(isDispatch)
end

-- 获取下一强化预览属性
function getStrengthenPreAttr(self)
    if(self.id)then
        -- 含有id向服务器获取属性
        if (not self.m_strengthenPreAttrList) then
            self:__dispatchReqDetailData()
            return
        end
        return self.m_strengthenPreAttrList
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        self.m_strengthenPreAttrList = self.m_strengthenPreAttrList or {}
        return self.m_strengthenPreAttrList
    end
end

-- 获取所有等级的强化属性
function getStrengthenAttrByLvl(self, lvl)
    if(self.id)then
        -- 含有id向服务器获取属性
        if (not self.m_strengthenAttrListDic) then
            GameDispatcher:dispatchEvent(EventName.REQ_ALL_PREVIEW_ATTR, {previewType = hero.AllPreviewAttrType.EQUIP_STRENGTHEN, heroId = self.heroId, param = self.id})
            return
        end
        return self.m_strengthenAttrListDic[lvl]
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        self.m_strengthenAttrListDic = self.m_strengthenAttrListDic or {}
        return self.m_strengthenAttrListDic[lvl] or {}
    end
end

-- 设置所有等级的强化属性
function setAllLvStrengthenAttr(self, data)
    self.m_strengthenAttrListDic = {}
    for i = 1, #data do
        local attrData = data[i]
        self.m_strengthenAttrListDic[attrData.lv] = attrData.attr_list
        table.sort(self.m_strengthenAttrListDic[attrData.lv], self.__sortAttrList)
    end
    self:__dispatchUpdateDetailData(true)
    -- table.print(self.m_strengthenAttrListDic)
end

--获取手环的突破预览属性
function getBracelesAttrLvl(self, lvl)
    if (self.id) then
        if (not self.m_braceletsAttrList) then
            GameDispatcher:dispatchEvent(EventName.REQ_ALL_PREVIEW_ATTR, {previewType = hero.AllPreviewAttrType.BRACELET_TUPO, heroId = self.heroId, param = self.id})
            return
        end
        return self.m_braceletsAttrList[lvl]
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        self.m_braceletsAttrList = self.m_braceletsAttrList or {}
        return self.m_braceletsAttrList[lvl] or {}
    end
end

--设置手环的突破预览属性
function setAllBraceletsAttr(self, data)
    self.m_braceletsAttrList = {}
    for i = 1, #data do
        local attrData = data[i]
        self.m_braceletsAttrList[attrData.lv] = attrData.attr_list
        table.sort(self.m_braceletsAttrList[attrData.lv], self.__sortAttrList)
    end
    self:__dispatchUpdateDetailData(true)
end

-- 设置下一突破预览属性
function setTuPoPreAttr(self, cusList, isDispatch)
    if (not cusList) then
        self.m_tuPoPreAttrList = nil
        return
    end
    self.m_tuPoPreAttrList = {}
    for i = 1, #cusList do
        table.insert(self.m_tuPoPreAttrList, cusList[i])
    end
    table.sort(self.m_tuPoPreAttrList, self.__sortAttrList)
    self:__dispatchUpdateDetailData(isDispatch)
end

-- 获取下一突破预览属性
function getTuPoPreAttr(self)
    if(self.id)then
        -- 含有id向服务器获取属性
        if (not self.m_tuPoPreAttrList) then
            self:__dispatchReqDetailData()
            return
        end
        return self.m_tuPoPreAttrList
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        self.m_tuPoPreAttrList = self.m_tuPoPreAttrList or {}
        return self.m_tuPoPreAttrList
    end
end

-- 设置总属性
function setTotalAttr(self, cusList, isDispatch)
    if (not cusList) then
        self.m_totalAttrList = nil
        self.m_totalAttrDic = nil
        return
    end
    self.m_totalAttrList = {}
    self.m_totalAttrDic = {}
    for i = 1, #cusList do
        table.insert(self.m_totalAttrList, cusList[i])
        self.m_totalAttrDic[cusList[i].key] = cusList[i].value
    end
    table.sort(self.m_totalAttrList, self.__sortAttrList)
    self:__dispatchUpdateDetailData(isDispatch)
end

-- 获取总属性
function getTotalAttr(self)
    if(self.id)then
        -- 含有id向服务器获取属性
        if (not self.m_totalAttrList) then
            self:__dispatchReqDetailData()
            return
        end
        return self.m_totalAttrList, self.m_totalAttrDic
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        self.m_totalAttrList = self.m_totalAttrList or {}
        self.m_totalAttrDic = self.m_totalAttrDic or {}
        return self.m_totalAttrList, self.m_totalAttrDic
    end
end

-- 设置筛选主属性和附近属性（给筛选过滤专用，只在一开始没有属性时使用，后端只作初始化）
function setFilterAttr(self, cusMainList, cusAttachList)
    if (not cusMainList) then
        self.m_filterMainAttrList = nil
        self.m_filterMainAttrDic = nil
        self.m_filterAttachAttrList = nil
        self.m_filterAttachAttrDic = nil
        return
    end

    self.m_filterMainAttrList = {}
    self.m_filterMainAttrDic = {}
    for i = 1, #cusMainList do
        table.insert(self.m_filterMainAttrList, cusMainList[i])
        self.m_filterMainAttrDic[cusMainList[i].key] = cusMainList[i].value
    end
    table.sort(self.m_filterMainAttrList, self.__sortAttrList)

    self.m_filterAttachAttrList = {}
    self.m_filterAttachAttrDic = {}
    for i = 1, #cusAttachList do
        table.insert(self.m_filterAttachAttrList, cusAttachList[i])
        self.m_filterAttachAttrDic[cusAttachList[i].key] = cusAttachList[i].value
    end
    table.sort(self.m_filterAttachAttrList, self.__sortAttrList)
end

-- 获取筛选属性（给筛选过滤专用，后端只作初始话，后续本地和总属性保持同步，别碰）
function getFilterAttr(self)
    self.m_filterMainAttrList = self.m_filterMainAttrList or {}
    self.m_filterMainAttrDic = self.m_filterMainAttrDic or {}
    self.m_filterAttachAttrList = self.m_filterAttachAttrList or {}
    self.m_filterAttachAttrDic = self.m_filterAttachAttrDic or {}
    return self.m_filterMainAttrList, self.m_filterMainAttrDic, self.m_filterAttachAttrList, self.m_filterAttachAttrDic
end

--设置手环的改造属性
function setBracelet_remake_attr(self, attrList)
    self.m_braceletsEmpowerAttrList = {}
    for _, attr in pairs(attrList or {}) do
        self.m_braceletsEmpowerAttrList[attr.remake_pos] = {attrType = attr.key, attrValue = attr.value, level = attr.level, maxLevel = attr.max_level, is_lock = attr.is_lock == 1, pos = attr.remake_pos}
    end
end

function getBracelet_remake_attr(self)
    return self.m_braceletsEmpowerAttrList or {}
end

-- 设置改造属性
function setRemakeAttr(self, cusList, isDispatch)
    if (not cusList) then
        self.m_remakePosAttrList = nil
        self.m_remakePosAttrDic = nil
        return
    end
    self.m_remakePosAttrList = {}
    self.m_remakePosAttrDic = {}
    for i = 1, #cusList do
        local value = {remakePos = cusList[i].remakePos or cusList[i].remake_pos, key = cusList[i].key, value = cusList[i].value, maxValue = cusList[i].maxValue or cusList[i].max_value, minValue = cusList[i].minValue or cusList[i].min_value}
        table.insert(self.m_remakePosAttrList, value)
        self.m_remakePosAttrDic[value.remakePos] = value
    end
    table.sort(self.m_remakePosAttrList, self.__sortAttrList)
    self:__dispatchUpdateDetailData(isDispatch)
end

-- 获取改造属性
function getRemakeAttr(self)
    if(self.id)then
        -- 含有id向服务器获取属性
        if (not self.m_remakePosAttrList) then
            self:__dispatchReqDetailData()
            return
        end
        return self.m_remakePosAttrList, self.m_remakePosAttrDic
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        self.m_remakePosAttrList = self.m_remakePosAttrList or {}
        self.m_remakePosAttrDic = self.m_remakePosAttrDic or {}
        return self.m_remakePosAttrList, self.m_remakePosAttrDic
    end
end

-- 获取主属性
function getMainAttr(self)
    -- 基础属性 = 总属性 - 核能属性 - 突破附加属性 - 改造属性
    local totalAttrList, _ = self:getTotalAttr()
    local _, nuclearAttrDic = self:getNuclearAttr()
    local _, attachAttrDic = self:getTuPoAttachAttr()
    local _, remakeAttrDic = self:getRemakeAttr()
    local bracelet_remake_attr = self:getBracelet_remake_attr()

    local arr = {}
    local dic = {}

    if totalAttrList == nil then
        --cusLog("获取到了空的totalAttrList")
        return arr, dic
    end

    for i = 1, #totalAttrList do
        local attrVo = totalAttrList[i]
        local attrTValue = attrVo.value -
        (nuclearAttrDic and nuclearAttrDic[attrVo.key] or 0) -
        (attachAttrDic and (attachAttrDic[attrVo.key] and attachAttrDic[attrVo.key].isActive and attachAttrDic[attrVo.key].value or 0) or 0)

        if remakeAttrDic then
            for _, rVo in pairs(remakeAttrDic) do
                if rVo.key == attrVo.key then
                    attrTValue = attrTValue - rVo.value
                end
            end
        end

        if bracelet_remake_attr then
            for _, rVo in pairs(bracelet_remake_attr) do
                if rVo.attrType == attrVo.key then
                    attrTValue = attrTValue - rVo.attrValue
                    logAll(attrTValue)
                    break
                end
            end
        end

        if attrTValue > 0 then
            table.insert(arr, {key = attrVo.key, value = attrTValue})
            dic[attrVo.key] = attrTValue
        end
    end
    return arr, dic
end

-- 获取改造属性数量
function getRemakeCount(self)
    if (not self.m_remakePosAttrList) then
        return 0
    end
    return #self.m_remakePosAttrList
end

-- 设置技能效果值列表
function setSkillEffect(self, cusList, isDispatch)
    if (not cusList) then
        self.m_skillEffectList = nil
        self.m_skillEffectDic = nil
        return
    end
    self.m_skillEffectList = {}
    self.m_skillEffectDic = {}
    for i = 1, #cusList do
        local isMsgData = cusList[i].skill_id ~= nil and cusList[i].effect_values ~= nil
        local skillId = isMsgData and cusList[i].skill_id or cusList[i].skillId
        local buffValueList = {}
        local values = isMsgData and cusList[i].effect_values or cusList[i].buffValues
        for j = 1, #values do
            local data = values[j]
            local buffData = {buffId = isMsgData and data.effect_id or data.buffId, buffValue = isMsgData and data.value or data.buffValue}
            table.insert(buffValueList, buffData)
        end
        table.insert(self.m_skillEffectList, {skillId = skillId, buffValues = buffValueList})
        self.m_skillEffectDic[skillId] = buffValueList
    end
    self:__dispatchUpdateDetailData(isDispatch)
end

-- 获取技能效果
function getSkillEffect(self)
    if(self.id)then
        -- 含有id向服务器获取属性
        if (not self.m_skillEffectList) then
            self:__dispatchReqDetailData()
            return
        end
        return self.m_skillEffectList, self.m_skillEffectDic
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        self.m_skillEffectList = self.m_skillEffectList or {}
        self.m_skillEffectDic = self.m_skillEffectDic or {}
        return self.m_skillEffectList, self.m_skillEffectDic
    end
end

-- 设置精炼技能预览效果
function setRefineSkillPreEffect(self, cusList, isDispatch)
    if (not cusList) then
        self.m_refineSkillEffectList = nil
        self.m_refineSkillEffectDic = nil
        return
    end
    self.m_refineSkillEffectList = {}
    self.m_refineSkillEffectDic = {}
    for i = 1, #cusList do
        local isMsgData = cusList[i].skill_id ~= nil and cusList[i].effect_values ~= nil
        local skillId = isMsgData and cusList[i].skill_id or cusList[i].skillId
        local buffValueList = {}
        local values = isMsgData and cusList[i].effect_values or cusList[i].buffValues
        for j = 1, #values do
            local data = values[j]
            local buffData = {buffId = isMsgData and data.effect_id or data.buffId, buffValue = isMsgData and data.value or data.buffValue}
            table.insert(buffValueList, buffData)
        end
        table.insert(self.m_refineSkillEffectList, {skillId = skillId, buffValues = buffValueList})
        self.m_refineSkillEffectDic[skillId] = buffValueList
    end
    self:__dispatchUpdateDetailData(isDispatch)
end

-- 获取精炼技能预览效果
function getRefineSkillPreEffect(self)
    if(self.id)then
        -- 含有id向服务器获取属性
        if (not self.m_refineSkillEffectList) then
            self:__dispatchReqDetailData()
            return
        end
        return self.m_refineSkillEffectList, self.m_refineSkillEffectDic
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        self.m_refineSkillEffectList = self.m_refineSkillEffectList or {}
        self.m_refineSkillEffectDic = self.m_refineSkillEffectDic or {}
        return self.m_refineSkillEffectList, self.m_refineSkillEffectDic
    end
end

-- 请求详细数据
function __dispatchReqDetailData(self)
    if(self.id and self.id ~= 0)then
        -- 含有id向服务器获取属性
        GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_DETAIL_DATA, {heroId = self.heroId, equipId = self.id})
    else
        -- 此类情况是，该装备没穿戴在英雄身上，也没在背包内，即作为单纯奖励展示，则属性全读配置表，根据需求实现获取方式
        Debug:log_warn("EquipVo", "某些配置属性数据未实现本地获取")
    end
end

-- 更新详细数据
function __dispatchUpdateDetailData(self, cusIsDispatch)
    local function _tryParse()
        if (cusIsDispatch == true) then
            self:dispatchEvent(self.UPDATE_EQUIP_DETAIL_DATA, {})
        end
        --return JsonUtil.decode(jsonStr)
    end
    local isParseOk, value = pcall(_tryParse)
end

-- 解析已进包的道具数据
function setPropsBagMsgData(self, cusBagType, pt_prop_bag)
    super.setPropsBagMsgData(self, cusBagType, pt_prop_bag)
    self.heroId = pt_prop_bag.hero_id
    self.strengthenLvl = pt_prop_bag.strength_lv
    self.strengthenExp = pt_prop_bag.strength_exp
    self.tuPoRank = pt_prop_bag.breakup_rank
    self.refineLvl = pt_prop_bag.refine_lv

    -- self:setNuclearAttr(nil)
    self:setRemakeAttr(pt_prop_bag.remake_attr)
    self:setBracelet_remake_attr(pt_prop_bag.bracelet_remake_attr)
    self:setFilterAttr(pt_prop_bag.filter_base_attr, pt_prop_bag.filter_subjoin_attr)
    -- self:setStrengthenPreAttr(nil)
    -- self:setTuPoPreAttr(nil)
    -- self:setSkillEffect(nil)
    -- self:setRefineSkillPreEffect(nil)
    -- self:setTuPoAttachAttr(nil)
end

-- 解析装备详细数据
function setEquipDetailMsgData(self, prop_bag_detail)
    super.setPropsBagMsgData(self, nil, prop_bag_detail)
    -- 该字段暂时无法确定用于何处，后端默认发的0，屏蔽
    -- self.id = prop_bag_detail.equip_id
    self.heroId = prop_bag_detail.hero_id
    self.isLock = prop_bag_detail.is_lock
    self.strengthenLvl = prop_bag_detail.strength_lv
    self.strengthenExp = prop_bag_detail.strength_exp
    self.tuPoRank = prop_bag_detail.breakup_rank
    self.refineLvl = prop_bag_detail.refine_lv

    self:setNuclearAttr(prop_bag_detail.nuclear_attr)
    self:setRemakeAttr(prop_bag_detail.remake_attr)
    self:setBracelet_remake_attr(prop_bag_detail.bracelet_remake_attr)
    self:setTotalAttr(prop_bag_detail.total_attr)
    self:setStrengthenPreAttr(prop_bag_detail.strength_pre_attr)
    self:setTuPoPreAttr(prop_bag_detail.break_pre_attr)
    self:setSkillEffect(prop_bag_detail.skill_effect)
    self:setRefineSkillPreEffect(prop_bag_detail.pre_bracelet_refine_skill_attr)
    self:setTuPoAttachAttr(prop_bag_detail.break_add_attr)
end

-- 解析服务器道具奖励数据
function setPropsAwardMsgData(self, pt_prop_award)
    super.setPropsAwardMsgData(self, pt_prop_award)
    self:setTotalAttr(pt_prop_award.total_attr)
    self:setTuPoAttachAttr(pt_prop_award.break_add_attr)
    self:setSkillEffect(pt_prop_award.skill_effect)
    self.refineLvl = pt_prop_award.refine_lv
    --self.isLock = pt_prop_award.is_lock
end

-- 设置奖励展示道具数据(本地奖励包)
function setAwardPackgeData(self, AwardPackageBaseVo)
    super.setAwardPackgeData(self, AwardPackageBaseVo)
end

function clone(self)
    local vo = super.clone(self)
    vo.heroId = self.heroId
    vo.isLock = self.is_lock
    vo.strengthenLvl = self.strengthenLvl
    vo.strengthenExp = self.strengthenExp
    vo.tuPoRank = self.tuPoRank
    vo.refineLvl = self.refineLvl

    vo:setNuclearAttr(self:getNuclearAttr())
    vo:setRemakeAttr(self:getRemakeAttr())

    local bracelet_remake_attr = {}
    local attList = self:getBracelet_remake_attr()
    for k, v in pairs(attList) do
        table.insert(bracelet_remake_attr, {key = v.attrType, value = v.attrValue, level = v.level, max_level = v.maxLevel, is_lock = v.is_lock and 1 or 0, remake_pos = v.pos})
    end
    vo:setBracelet_remake_attr(bracelet_remake_attr)

    vo:setTotalAttr(self:getTotalAttr())
    local filterMainAttrList, filterMainAttrDic, filterAttachAttrList, filterAttachAttrDic = self:getFilterAttr()
    vo:setFilterAttr(filterMainAttrList, filterAttachAttrList)
    vo:setStrengthenPreAttr(self:getStrengthenPreAttr())
    vo:setTuPoPreAttr(self:getTuPoPreAttr())
    vo:setSkillEffect(self:getSkillEffect())
    vo:setRefineSkillPreEffect(self:getRefineSkillPreEffect())
    vo:setTuPoAttachAttr(self:getTuPoAttachAttr())

    return vo
end

-- 属性排序
function __sortAttrList(attrVo_1, attrVo_2)
    if (attrVo_1 and attrVo_2) then
        -- key从小到大
        if (attrVo_1.key > attrVo_2.key) then
            return false
        end
        if (attrVo_1.key < attrVo_2.key) then
            return true
        end
    end
    return false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
