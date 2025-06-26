
module("hero.HeroVo", Class.impl(hero.HeroConfigVo))

-- 更新完整详细信息
UPDATE_DETAIL = "UPDATE_DETAIL"
-- 更新技能预览信息
UPDATE_SKILL_UP_EFFECT = "UPDATE_SKILL_UP_EFFECT"

function ctor(self)
    self:__init()
end

function checkIsPreData(self)
    if (self.m_isPreData) then
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_DATA, {heroId = self.id})
    end
    return self.m_isPreData
end

function __init(self)
    -- 是否预览数据
    self.m_isPreData = true

    self.id = nil
    -- 品质
    self.color = nil
    -- 等级
    self.lvl = nil
    -- 经验
    self.exp = nil
    -- 经验上限
    self.maxExp = nil
    -- 进化等级/星级
    self.evolutionLvl = nil
    -- 军阶
    self.militaryRank = nil
    -- 英雄战力
    self.power = nil
    -- 亲密度(无用)
    self.intimacy = nil
    -- 是否上锁，1是0否
    self.isLock = nil
    -- 是否喜欢
    self.isLike = nil
    -- 关联的盟约助手id（无关联助手默认为0）
    --self.covanantHelperId = nil
    -- 已装备列表
    self.equipList = nil
    -- 好友战员装备列表
    self.otherPlayerEquipList = nil
    -- 属性列表
    self.attrList = nil
    -- 属性字典
    self.attrDic = nil
    -- 军衔预览属性字典
    self.m_militaryRankPreAttrDic = nil
    -- 进化预览属性字典
    self.m_starUpPreAttrDic = nil
    -- 进化所有星级的预览属性字典
    self.m_starUpAllPreAttrDic = nil
    -- 升品预览属性字典
    self.m_colorUpPreAttrDic = nil
    -- 亲密度预览属性
    self.mFavorablePreAttrDic = nil

    --战员增幅等级
    self.growLv = nil
    --战员增幅属性字典
    self.growUpAttrDic = nil

    -- 当前的出战技能字典
    self.fightSkillDic = nil
    -- 当前的出战技能列表
    self.fightSkillList = nil

    -- 已激活的主动技能等级字典
    self.activeSkillDic = nil
    -- 已激活的主动技能id列表
    self.activeSkillList = nil

    -- 已激活的被动技能等级字典
    self.activePassSkillDic = nil
    -- 已激活的被动技能id列表
    self.activePassSkillList = nil
    -- 原数据
    self.m_orgConfigVo = nil

    --亲密度等级
    self.favorableLevel = nil
    --亲密度经验
    self.favorableExp = nil
    self.allElementDemage = 0 --全属性增伤
    self.allElementDefine = 0 --全属性减伤
    self.extraSkillLv = {}
    self.emptyEquipPosList = {}

    -- 设置已穿戴装备的总的装备属性列表(后端说这里是4维属性，包含手环)
    self.equipAttrList = nil
    -- 设置已穿戴装备的总的装备属性字典(后端说这里是4维属性，包含手环)
    self.equipAttrDic = nil
    -- 已穿戴芯片装备全部属性字典(全部属性，不包含手环)
    self.equipAttrDicAll = nil
    -- 已穿戴芯片装备全部属性列表(全部属性，不包含手环)
    self.equipAttrListAll = nil
end

-- 获取战员穿戴的时装id
function getHeroModel(self)
    local fashionVo = fashion.FashionManager:getHeroWearingFashionVo(fashion.Type.CLOTHES, self.id)
    if (not fashionVo) then
        return self.model
    end
    local fashionConfigVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.tid, fashionVo.fashionId)
    if (not fashionConfigVo) then
        return self.model
    end
    return fashionConfigVo.model
end

-- 获取战员的高模ID（时装通用）
function getHeroHighModel(self)
    local fashionVo = fashion.FashionManager:getHeroWearingFashionVo(fashion.Type.CLOTHES, self.id)
    if not fashionVo then
        return nil
    end
    local fashionConfigVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.tid, fashionVo.fashionId)
    return fashionConfigVo.highModel
end

-- 获取UI上的模型id（优先使用高模）
function getUIModel(self)
    if self:getHeroHighModel() and self:getHeroHighModel() ~= "" then
        return self:getHeroHighModel()
    end
    return self:getHeroModel()
end

function getHostelModel(self)
    local fashionVo = fashion.FashionManager:getHeroWearingFashionVo(fashion.Type.CLOTHES, self.id)
    if not fashionVo then
        return nil
    end
    local fashionConfigVo = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, self.tid, fashionVo.fashionId)
    return fashionConfigVo.hostelModel
end

function getConfigVo(self)
    return self.m_orgConfigVo
end

function setConfigData(self, cusConfigVo)
    self.m_orgConfigVo = cusConfigVo
    self.tid = cusConfigVo.tid
    self.name = cusConfigVo.name
    self.englishName = cusConfigVo.englishName
    self.zhCVName = cusConfigVo.zhCVName
    self.jpCVName = cusConfigVo.jpCVName
    self.zhCVId = cusConfigVo.zhCVId
    self.jpCVId = cusConfigVo.jpCVId
    self.life = cusConfigVo.life
    self.blood = cusConfigVo.blood
    self.stature = cusConfigVo.stature
    self.weight = cusConfigVo.weight
    self.birthday = cusConfigVo.birthday
    self.camp = cusConfigVo.camp
    self.eleType = cusConfigVo.eleType
    self.needFragment = cusConfigVo.needFragment
    self.professionType = cusConfigVo.professionType
    self.color = cusConfigVo.color
    self.defineType = cusConfigVo.defineType
    self.model = cusConfigVo.model
    self.showModel = cusConfigVo.showModel
    self.head = cusConfigVo.head
    self.painting = cusConfigVo.painting
    self.bodyImg = cusConfigVo.bodyImg
    self.shadowHead = cusConfigVo.shadowHead
    self.baseSkillIdList = cusConfigVo.baseSkillIdList
    self.basePassiveSkillList = cusConfigVo.basePassiveSkillList
    self.abilityList = cusConfigVo.abilityList
    self.abilityWeightDic = cusConfigVo.abilityWeightDic
    self.basicAttrDic = cusConfigVo.basicAttrDic
    self.showQ_model = cusConfigVo.showQ_model
    self.initskilllist = cusConfigVo.initskilllist
    self.inBornSkill = cusConfigVo.inBornSkill
    self.warshipSkill = cusConfigVo.warship_skill
    self.isLimit = cusConfigVo.isLimit
end

function parsePreMsgData(self, pt_hero_pre_info)
    local tid = pt_hero_pre_info.tid
    local configVo = hero.HeroManager:getHeroConfigVo(tid)
    if (not configVo) then
        Debug:log_error("HeroVo", "找不到对应英雄配置：" .. tid)
        return false
    end
    self:setConfigData(configVo)
    self.id = pt_hero_pre_info.id
    self.color = pt_hero_pre_info.color
    self.lvl = pt_hero_pre_info.level
    self.exp = pt_hero_pre_info.exp
    self.maxExp = hero.HeroLvlUpManager:getHeroMaxExp(self.tid, self.lvl) or 0
    self.evolutionLvl = pt_hero_pre_info.evolution
    self.militaryRank = pt_hero_pre_info.military_rank
    self.power = pt_hero_pre_info.power
    self.isLock = pt_hero_pre_info.is_lock
    self.isLike = pt_hero_pre_info.is_like
    --self.covanantHelperId = pt_hero_pre_info.connect_helper_id

    self.favorableLevel = pt_hero_pre_info.relation_level
    self.favorableExp = pt_hero_pre_info.relation_exp
    self.growLv = pt_hero_pre_info.increases_lv

    -- 该字段只在初始登录作为预览数据使用，不做维护（用于判断装备空槽部位红点）
    self.emptyEquipPosList = pt_hero_pre_info.empty_equip_pos_list

    self:setActiveSkillList(pt_hero_pre_info.active_skill_list)

    if pt_hero_pre_info.resonance_id_list then
        self:setActiveResonancePos(pt_hero_pre_info.resonance_id_list)
    end

    self.m_isPreData = true

    return true
end

function parseMsgData(self, pt_hero_info)
    local tid = pt_hero_info.tid
    local configVo = hero.HeroManager:getHeroConfigVo(tid)
    if (not configVo) then
        Debug:log_error("HeroVo", "找不到对应英雄配置：", tid)
        return false
    end

    self:setConfigData(configVo)
    self.id = pt_hero_info.id
    self.color = pt_hero_info.color
    self.lvl = pt_hero_info.level
    self.exp = pt_hero_info.exp
    self.maxExp = pt_hero_info.exp_max
    self.evolutionLvl = pt_hero_info.evolution
    self.militaryRank = pt_hero_info.military_rank
    self.power = pt_hero_info.power
    self.intimacy = pt_hero_info.intimacy
    self.isLock = pt_hero_info.is_lock
    self.isLike = pt_hero_info.is_like
    self.favorableLevel = pt_hero_info.relation_level
    self.favorableExp = pt_hero_info.relation_exp
    self.growLv = pt_hero_info.increases_lv

    --self.covanantHelperId = pt_hero_info.connect_helper_id
    self:setFightSkillList(pt_hero_info.fight_skill_list)
    self:setActiveSkillList(pt_hero_info.active_skill_list)
    self:setActivePassiveSkillList(pt_hero_info.passive_skill_list)
    self:setEquipList(pt_hero_info.equip_list)
    self:setAttrList(pt_hero_info.attr_list)
    self:setEquipAttrList(pt_hero_info.equip_attr_list)

    if pt_hero_info.resonance_id_list then
        self:setActiveResonancePos(pt_hero_info.resonance_id_list)
    end
    self:setDnaEggInfo(pt_hero_info)

    self.m_isPreData = false

    return true
end

-- 从预览数据更新到完整详细信息
function parseDetailMsgData(self, pt_hero_info)
    self.color = pt_hero_info.color
    self.lvl = pt_hero_info.level
    self.exp = pt_hero_info.exp
    self.maxExp = pt_hero_info.exp_max
    self.evolutionLvl = pt_hero_info.evolution
    self.militaryRank = pt_hero_info.military_rank
    self.power = pt_hero_info.power
    self.intimacy = pt_hero_info.intimacy
    self.isLock = pt_hero_info.is_lock
    self.isLike = pt_hero_info.is_like
    self.favorableExp = pt_hero_info.relation_exp
    self.favorableLevel = pt_hero_info.relation_level
    --self.covanantHelperId = pt_hero_info.connect_helper_id

    self.growLv = pt_hero_info.increases_lv

    self:setFightSkillList(pt_hero_info.fight_skill_list)
    self:setActiveSkillList(pt_hero_info.active_skill_list)
    self:setActivePassiveSkillList(pt_hero_info.passive_skill_list)
    self:setEquipList(pt_hero_info.equip_list)
    self:setAttrList(pt_hero_info.attr_list)
    self:setEquipAttrList(pt_hero_info.equip_attr_list)
    if pt_hero_info.resonance_id_list then
        self:setActiveResonancePos(pt_hero_info.resonance_id_list)
    end
    self:setDnaEggInfo(pt_hero_info)

    self.m_isPreData = false

    self:dispatchEvent(self.UPDATE_DETAIL)
    return true
end

-- 解析其他玩家英雄数据
function parseOtherMsg(self, pt_other_hero_info)
    local tid = pt_other_hero_info.tid
    local configVo = hero.HeroManager:getHeroConfigVo(tid)
    if (not configVo) then
        Debug:log_error("HeroVo", "找不到对应英雄配置：", tid)
        return false
    end
    self:setConfigData(configVo)
    self.id = pt_other_hero_info.id
    self.color = pt_other_hero_info.color
    self.lvl = pt_other_hero_info.level
    self.exp = pt_other_hero_info.exp
    self.maxExp = pt_other_hero_info.exp_max
    self.evolutionLvl = pt_other_hero_info.evolution
    self.militaryRank = pt_other_hero_info.military_rank
    self.power = pt_other_hero_info.power
    self.intimacy = pt_other_hero_info.intimacy
    self.isLock = pt_other_hero_info.is_lock
    self.isLike = pt_other_hero_info.is_like
    self.fashionBodyId = pt_other_hero_info.fashion_body_id
    self.favorableExp = pt_other_hero_info.relation_exp
    self.favorableLevel = pt_other_hero_info.relation_level
    self.growLv = pt_other_hero_info.increases_lv

    --self.covanantHelperId = pt_other_hero_info.connect_helper_id
    -- 其他玩家英雄数据多了个展示位置
    self.showPos = pt_other_hero_info.pos
    self:setFightSkillList(pt_other_hero_info.fight_skill_list)
    self:setActiveSkillList(pt_other_hero_info.active_skill_list)
    self:setActivePassiveSkillList(pt_other_hero_info.passive_skill_list)
    self:setEquipDetailList(pt_other_hero_info.equip_list) -- 不同点！！！不要问为什么两个一样的方法，这里是不一样的
    self:setEquipDetailMsgList(pt_other_hero_info.equip_list)
    self:setAttrList(pt_other_hero_info.attr_list)
    self:setEquipAttrList(pt_other_hero_info.equip_attr_list)
    if pt_other_hero_info.resonance_id_list then
        self:setActiveResonancePos(pt_other_hero_info.resonance_id_list)
    end

    for i = 1, #self.equipList do
        self.equipList[i]:setOtherRoleHeroEquipList(self.equipList)
    end
    self.m_isPreData = false

    return true
end

function setDnaEggInfo(self, pt_hero_info)
    ----dna蛋信息
    --战员蛋当前形态
    local isLvl
    if self.egg_form and self.egg_form == pt_hero_info.egg_form then
        if self.egg_lv ~= pt_hero_info.egg_lv then
            isLvl = true
        end
    end
    self.egg_form = pt_hero_info.egg_form or hero.eggType.none
    --[[ --当前蛋id
        desc:
            在 == hero.eggType.egg 时 此id代表是蛋品质123索引
            在 == hero.eggType.role 时 此id代表是战员形态配置索引
    --]]
    self.egg_id = pt_hero_info.egg_id
    --当前培养等级
    self.egg_lv = pt_hero_info.egg_lv
    --战员蛋属性是否计算(有某个属性id在内即为这个属性id不计算属性)
    self.egg_attr_cal = {}
    for i, v in ipairs(pt_hero_info.egg_attr_cal or {}) do
        self.egg_attr_cal[i] = v
    end
    if isLvl then
        GameDispatcher:dispatchEvent(EventName.DNA_LV_UP, self.id)
    end
end

-- 设置出战的技能列表
function setFightSkillList(self, cusList)
    if (not cusList) then
        return
    end
    self.fightSkillDic = {}
    self.fightSkillList = {}
    for i = 1, #cusList do
        local vo = hero.HeroFightSkillVo.new()
        vo:parseData(cusList[i])
        self.fightSkillDic[vo.pos] = vo
        table.insert(self.fightSkillList, vo)
    end
end

-- 设置已激活的主动技能列表
function setActiveSkillList(self, cusList)
    if (not cusList) then
        return
    end
    self.activeSkillDic = {}
    self.activeSkillList = {}
    for i = 1, #cusList do
        self.activeSkillDic[cusList[i].id] = cusList[i].lv
        self.extraSkillLv[cusList[i].id] = cusList[i].extra_lv
        table.insert(self.activeSkillList, cusList[i].id)
    end
end

function getActiveSkill(self, skillId)
    return self.activeSkillDic[skillId] or 1
end

function getExtraLv(self, skillId)
    return self.extraSkillLv[skillId] or 0
end

-- 设置已激活的被动技能列表
function setActivePassiveSkillList(self, cusList)
    if (not cusList) then
        return
    end
    self.activePassSkillDic = {}
    self.activePassSkillList = {}
    for i = 1, #cusList do
        self.activePassSkillDic[cusList[i].id] = cusList[i].lv
        self.extraSkillLv[cusList[i].id] = cusList[i].extra_lv
        table.insert(self.activePassSkillList, cusList[i].id)
    end
end

function getActivePassiveSkill(self, skillId)
    return self.activePassSkillDic[skillId] or 1
end

-- 设置已穿戴装备列表
function setEquipList(self, cusList)
    if (not cusList) then
        return
    end
    self.equipList = {}
    for i = 1, #cusList do
        local equipVo = bag.BagManager:getPropsVoById(cusList[i].equip_id)
        --local equipVo = props.PropsManager:getTypePropsVoByTid(cusList[i].equip_id)
        --equipVo:setPropsBagMsgData(nil, cusList[i])
        table.insert(self.equipList, equipVo)
    end
end

-- 解析装备详细信息
function setEquipDetailList(self, cusList)
    if (not cusList) then
        return
    end
    self.equipList = {}

    for i = 1, #cusList do
        local equipVo = bag.BagManager:getPropsVoById(cusList[i].equip_id)
        --local equipVo = props.PropsManager:getTypePropsVoByTid(cusList[i].tid)
        --equipVo:setEquipDetailMsgData(cusList[i])
        table.insert(self.equipList, equipVo)
    end
end

-- 解析来自服务器装备详细信息
function setEquipDetailMsgList(self, cusList)
    if (not cusList) then
        return
    end
    self.otherPlayerEquipList = {}
    self.equipList = {}
    for i = 1, #cusList do
        local equipVo = LuaPoolMgr:poolGet(props.EquipVo)
        equipVo:setEquipDetailMsgData(cusList[i])
        table.insert(self.otherPlayerEquipList, equipVo)
        table.insert(self.equipList, equipVo)
    end
    table.sort(self.otherPlayerEquipList, function (a, b) return a.subType < b.subType end)
end

-- 根据装备id获取穿在身上的装备vo
function getEquipById(self, cusId)
    if not self.equipList then
        return nil
    end
    for j = 1, #self.equipList do
        local equipVo = self.equipList[j]
        if (equipVo.id == cusId) then
            return equipVo
        end
    end
end

-- 根据卡槽装备部位获取穿在身上的装备vo
function getEquipByPos(self, cusPos)
    if not self.equipList then
        return nil
    end
    for j = 1, #self.equipList do
        local equipVo = self.equipList[j]
        if (equipVo.subType == cusPos) then
            return equipVo
        end
    end
end

-- 卸下已穿戴装备列表
function delEquipList(self, cusSlotPosList)
    if (not cusSlotPosList) then
        return
    end
    if (self.equipList) then
        for i = 1, #cusSlotPosList do
            for j = 1, #self.equipList do
                local equipVo = self.equipList[j]
                if (equipVo.subType == cusSlotPosList[i]) then
                    table.remove(self.equipList, j)
                    break
                end
            end
        end
    end
end

-- 更新已穿戴装备列表
function updateEquipList(self, cusList)
    if (not cusList) then
        return
    end
    if (not self.equipList) then
        self.equipList = {}
    end
    for i = 1, #cusList do
        local isUpdate = false

        local equipVo = bag.BagManager:getPropsVoById(cusList[i].equip_id)
        local configVo = props.PropsManager:getPropsConfigVo(equipVo.tid)
        for j = 1, #self.equipList do
            if (configVo.subType == self.equipList[j].subType and cusList[i].equip_id == self.equipList[j].id) then
                isUpdate = true
                --self.equipList[j]:setPropsBagMsgData(nil, cusList[i])
                break
            end
        end
        if (not isUpdate) then
            --local equipVo = props.PropsManager:getTypePropsVoByTid(cusList[i].tid)
            equipVo:setConfigData(configVo)
            --equipVo.count = cusList[i].num
            --equipVo:setPropsBagMsgData(nil, cusList[i])
            table.insert(self.equipList, equipVo)
        end
    end
end

-- 设置已穿戴装备的总的装备属性列表
function setEquipAttrList(self, cusList)
    if (not cusList) then
        return
    end
    self.equipAttrList = {}
    self.equipAttrDic = {}
    for i = 1, #cusList do
        local attrVo = {key = cusList[i].key, value = cusList[i].value}
        table.insert(self.equipAttrList, attrVo)
        self.equipAttrDic[attrVo.key] = attrVo.value
    end
    table.sort(self.equipAttrList, AttConst.sort)
end

-- 设置英雄已穿戴装备的总的属性列表 仅包含芯片
function setEquipAttrListAll(self, cusList)
    if (not cusList) then
        return
    end
    self.equipAttrListAll = {}
    self.equipAttrDicAll = {}
    for i = 1, #cusList do
        local attrVo = {key = cusList[i].key, value = cusList[i].value}
        table.insert(self.equipAttrListAll, attrVo)
        self.equipAttrDicAll[attrVo.key] = attrVo.value
    end
    table.sort(self.equipAttrListAll, AttConst.sort)
end

-- 设置属性列表
function setAttrList(self, cusList)
    if (not cusList) then
        return
    end

    self.attrList = {}
    self.attrDic = {}
    self.allElementDemage = 0 --全属性增伤
    self.allElementDefine = 0 --全属性减伤
    for i = 1, #cusList do
        -- if cusList[i].key == 112 then
        --     self.allElementDemage = cusList[i].value
        -- elseif cusList[i].key == 113 then
        --     self.allElementDefine = cusList[i].value
        -- else
        local attrVo = {key = cusList[i].key, value = cusList[i].value}
        table.insert(self.attrList, attrVo)
        self.attrDic[attrVo.key] = attrVo.value
        --end
    end
    table.sort(self.attrList, AttConst.sort)
end

-- 获取指定类型的属性列表
function getAttrListByType(self, cusAttrType)
    local attrList = {}
    for i = 1, #self.attrList do
        local attrVo = self.attrList[i]
        if(AttConst.getAttrType(attrVo.key) == cusAttrType)then
            table.insert(attrList, attrVo)
        end
    end
    table.sort(attrList, AttConst.sort)
    return attrList
end

-- 获取所有类型的属性列表
function getAttrListByType(self)
    return self.attrList
end

-- 获取当前军阶对应的最大等级
function getMaxMilitaryLvl(self)
    local militaryRankConfigVo = hero.HeroMilitaryRankManager:getMilitaryRankConfigVo(self.tid, self.militaryRank)
    if (militaryRankConfigVo) then
        return militaryRankConfigVo.heroMaxLvl
    end
    return - 1
end

-- 设置军阶预览属性列表
function setMilitaryRankPreviewAttr(self, cusList)

    if (not cusList) then
        self.m_militaryRankPreAttrDic = nil
        return
    end
    self.m_militaryRankPreAttrDic = {}
    for i = 1, #cusList do
        self.m_militaryRankPreAttrDic[cusList[i].key] = cusList[i].value
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_PREVIEW_ATTR, {heroId = self.id, previewType = hero.PreviewAttrType.MILITARY_RANK})

end

-- 获取军阶预览属性列表
function getMilitaryRankPreviewAttrDic(self)
    if (not self.m_militaryRankPreAttrDic) then
        -- 请求下一阶预览属性
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_PREVIEW_ATTR, {heroId = self.id, previewType = hero.PreviewAttrType.MILITARY_RANK})
        return
    end
    local dic = {}
    for key, value in pairs(self.m_militaryRankPreAttrDic) do
        dic[key] = value
    end
    -- 后端无法在其他模块变动引起军衔下一属性列表更新主动推送，故前端需要每次使用完都手动设置nil，下次使用请求最新值
    -- self:setMilitaryRankPreviewAttr(nil)
    return dic
end

-- 设置进化预览属性列表
function setStarUpPreviewAttr(self, cusList, paramInt)
    if (not cusList) then
        self.m_starUpPreAttrDic = nil
        return
    end
    self.m_starUpPreAttrDic = {}
    for i = 1, #cusList do
        self.m_starUpPreAttrDic[cusList[i].key] = cusList[i].value
    end

    local dic = {}
    for key, value in pairs(self.m_starUpPreAttrDic) do
        dic[key] = value
    end

    --进化界面单独添加的额外参数  进化：下一星增加的品质系数差值
    dic[-1] = paramInt

    GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_STAR_ATTR, dic)

    GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_PREVIEW_ATTR, {heroId = self.id, previewType = hero.PreviewAttrType.STAR_UP})
end

-- 获取进化预览属性列表
function getStarUpPreviewAttrDic(self)
    if (not self.m_starUpPreAttrDic) then
        -- 请求下一星级预览属性
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_PREVIEW_ATTR, {heroId = self.id, previewType = hero.PreviewAttrType.STAR_UP})
        return
    end
    local dic = {}
    for key, value in pairs(self.m_starUpPreAttrDic) do
        dic[key] = value
    end
    -- 后端无法在其他模块变动引起进化属性列表更新主动推送，故前端需要每次使用完都手动设置nil，下次使用请求最新值
    self:setStarUpPreviewAttr(nil)
    return dic
end

-- 设置进化的所有星级的预览属性列表
function setStarUpAllPreviewAttr(self, cusList)
    if (not cusList) then
        self.m_starUpAllPreAttrDic = nil
        return
    end
    self.m_starUpAllPreAttrDic = {}
    for i = 1, #cusList do
        local data = cusList[i]
        if(not self.m_starUpAllPreAttrDic[data.lv])then
            self.m_starUpAllPreAttrDic[data.lv] = {}
        end
        for j = 1, #data.attr_list do
            self.m_starUpAllPreAttrDic[data.lv][data.attr_list[j].key] = data.attr_list[j].value
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_PREVIEW_ALL_ATTR, {heroId = self.id, previewType = hero.AllPreviewAttrType.STAR_UP})
end

-- 获取进化的所有星级的预览属性列表
function getStarUpAllPreviewAttrDic(self)
    if (not self.m_starUpAllPreAttrDic) then
        -- 请求所有星级预览属性
        GameDispatcher:dispatchEvent(EventName.REQ_ALL_PREVIEW_ATTR, {previewType = hero.AllPreviewAttrType.STAR_UP, heroId = self.id, param = 0})
        return
    end
    local dic = {}
    for _starLvl, _dic in pairs(self.m_starUpAllPreAttrDic) do
        if(not dic[_starLvl])then
            dic[_starLvl] = {}
        end
        for key, value in pairs(_dic) do
            dic[_starLvl][key] = value
        end
    end
    -- 后端无法在其他模块变动引起进化属性列表更新主动推送，故前端需要每次使用完都手动设置nil，下次使用请求最新值（每次进化后的预览属性值会变动）
    self:setStarUpAllPreviewAttr(nil)
    return dic
end

-- 设置升品预览属性列表
function setColorUpPreviewAttr(self, cusList)
    if (not cusList) then
        self.m_colorUpPreAttrDic = nil
        return
    end
    self.m_colorUpPreAttrDic = {}
    for i = 1, #cusList do
        self.m_colorUpPreAttrDic[cusList[i].key] = cusList[i].value
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_PREVIEW_ATTR, {heroId = self.id, previewType = hero.PreviewAttrType.COLOR_UP})
end

-- 获取升品预览属性列表
function getColorUpPreviewAttrDic(self)
    if (not self.m_colorUpPreAttrDic) then
        -- 请求下一品质预览属性
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_PREVIEW_ATTR, {heroId = self.id, previewType = hero.PreviewAttrType.COLOR_UP})
        return
    end
    local dic = {}
    for key, value in pairs(self.m_colorUpPreAttrDic) do
        dic[key] = value
    end
    -- 后端无法在其他模块变动引起升品属性列表更新主动推送，故前端需要每次使用完都手动设置nil，下次使用请求最新值
    self:setColorUpPreviewAttr(nil)
    return dic
end

-- 设置技能效果预览数据
function setSkillUpEffect(self, curSkillEffect, preSkillEffect, isDispatch)
    if (not curSkillEffect or not preSkillEffect) then
        return
    end

    self.m_preSkillEffectDic = {}
    for _, effectData in pairs(preSkillEffect) do
        local isMsgData = effectData.skill_id ~= nil and effectData.effect_values ~= nil
        local skillId = isMsgData and effectData.skill_id or effectData.skillId
        local skillLvl = isMsgData and effectData.skill_lv or effectData.skillLvl
        local buffValueList = {}
        local values = isMsgData and effectData.effect_values or effectData.buffValues
        for j = 1, #values do
            local data = values[j]
            local buffData = {buffId = isMsgData and data.effect_id or data.buffId, buffValue = isMsgData and data.value or data.buffValue}
            table.insert(buffValueList, buffData)
        end
        self.m_preSkillEffectDic[skillId] = buffValueList
    end

    local skillId = nil
    self.m_curSkillEffectDic = {}
    for _, effectData in pairs(curSkillEffect) do
        local isMsgData = effectData.skill_id ~= nil and effectData.effect_values ~= nil
        skillId = isMsgData and effectData.skill_id or effectData.skillId
        local skillLvl = isMsgData and effectData.skill_lv or effectData.skillLvl
        local buffValueList = {}
        local values = isMsgData and effectData.effect_values or effectData.buffValues
        for j = 1, #values do
            local data = values[j]
            local buffData = {buffId = isMsgData and data.effect_id or data.buffId, buffValue = isMsgData and data.value or data.buffValue}
            table.insert(buffValueList, buffData)
        end
        self.m_curSkillEffectDic[skillId] = buffValueList

        -- 维护本地已有技能的等级
        if(isMsgData and self.activeSkillDic and self.activeSkillList)then
            local index = table.indexof(self.activeSkillList, skillId)
            if(index ~= false)then
                self.activeSkillDic[skillId] = skillLvl
            end
        end
    end

    if(isDispatch and skillId)then
        self:dispatchEvent(self.UPDATE_SKILL_UP_EFFECT, {skillId = skillId})
    end
end

-- 获取技能效果预览数据
function getSkillUpEffect(self)
    return self.m_curSkillEffectDic, self.m_preSkillEffectDic
end

-- 通过技能id获取技能效果预览数据
function getSkillUpEffectBySkillId(self, cusSkillId)
    if(not self.m_curSkillEffectDic or not self.m_curSkillEffectDic[cusSkillId])then
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_SKILL_UP_EFFECT, {heroId = self.id, skillId = cusSkillId})
    else
        return self.m_curSkillEffectDic[cusSkillId], self.m_preSkillEffectDic[cusSkillId]
    end
end

-- 设置亲密度预览属性列表
function setFavorablePreviewAttr(self, cusList)
    if (not cusList) then
        self.mFavorablePreAttrDic = nil
        return
    end
    self.mFavorablePreAttrDic = {}
    for i = 1, #cusList do
        local data = cusList[i]
        if(not self.mFavorablePreAttrDic[data.lv])then
            self.mFavorablePreAttrDic[data.lv] = {}
        end
        for j = 1, #data.attr_list do
            self.mFavorablePreAttrDic[data.lv][data.attr_list[j].key] = data.attr_list[j].value
        end
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_PREVIEW_ALL_ATTR, {heroId = self.id, previewType = hero.AllPreviewAttrType.FAVORABLE})
end

function getNowFavorablePreviewAttrDic(self, lv)
    if (not self.mFavorablePreAttrDic) then
        -- 请求所有等级预览属性
        GameDispatcher:dispatchEvent(EventName.REQ_ALL_PREVIEW_ATTR, {previewType = hero.AllPreviewAttrType.FAVORABLE, heroId = self.id, param = 0})
        return
    end

    local targetLv = lv
    if(targetLv == nil) then
        targetLv = self.favorableLevel
    end

    local dic = {}
    for lvl, _dic in pairs(self.mFavorablePreAttrDic) do
        if(lvl == targetLv) then
            for key, value in pairs(_dic) do
                dic[key] = value
            end
        end
    end
    return dic
end

function getEquipAllLv(self)
    local allLv = 0
    for i = 1, 6 do
        local equip = self:getEquipByPos(i)
        if equip then
            allLv = allLv + equip.strengthenLvl
        end
    end
    return allLv
end

function setActiveResonancePos(self, resonanceList)
    self.mActiveResonanceList = {}
    for _, pos in pairs(resonanceList) do
        self.mActiveResonanceList[pos] = 1
    end
end

function getActiveResonancePos(self, pos)
    if not self.mActiveResonanceList then
        return false
    end

    return self.mActiveResonanceList[pos] == 1
end

function getActivesSkillResonanceCount(self)
    local resonanceConfigVo = hero.HeroManager:getHeroResonanceConfigVo(self.tid)
    local count = 0
    for i = 1, #resonanceConfigVo do
        if self:getActiveResonancePos(i) and resonanceConfigVo[i].type == 2 then
            count = count + 1
        end
    end

    return count
end

--判断当前战员dna状态
function checkDnaStatus(self, eggType)
    return self.egg_form == eggType
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
