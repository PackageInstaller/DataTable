module("fashion.FashionManager", Class.impl(Manager))

-- 当前选择的英雄改变
SELECTE_CHANGE = "SELECTE_CHANGE"

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
    -- 配置时装字典
    self.m_fashionConfigDic = nil
    -- 服务器时装字典
    self.m_heroFashionDic = nil

    -- 当前选择的英雄id
    self.m_heroId = nil

    -- 所有战员穿戴的皮肤的部位信息
    self.mFashionColorInfo = {}
    -- 查看过的战员皮肤部位数据
    self.mHeroFashionColorDic = {}
end

-- 初始化配置表
function parseConfigData(self)
    self.m_fashionConfigDic = {}
    self.m_fashionConfigDic[fashion.Type.CLOTHES] = {}
    self.m_fashionConfigDic[fashion.Type.WEAPON] = {}
    local clothesDic = self.m_fashionConfigDic[fashion.Type.CLOTHES]
    local weaponDic = self.m_fashionConfigDic[fashion.Type.WEAPON]
    local baseData = RefMgr:getData("hero_fashion_data")
    for heroTid, data in pairs(baseData) do
        if (not clothesDic[heroTid]) then
            clothesDic[heroTid] = {}
        end
        if (not weaponDic[heroTid]) then
            weaponDic[heroTid] = {}
        end

        local clothesList = data.fashion_body
        for _, clothesData in pairs(clothesList) do
            local vo = fashion.FashionConfigVo.new()
            vo:parseConfigData(heroTid, fashion.Type.CLOTHES, clothesData)
            clothesDic[heroTid][vo.fashionId] = vo
        end

        local weaponList = data.fashion_weapon
        for _, weaponData in pairs(weaponList) do
            local vo = fashion.FashionConfigVo.new()
            vo:parseConfigData(heroTid, fashion.Type.WEAPON, weaponData)
            weaponDic[heroTid][vo.fashionId] = vo
        end
    end
end

function getFashionData(self,heroTid,fashionId)
    if self.clothesDic == nil then
        self:parseConfigData()
    end
    return self.m_fashionConfigDic[fashion.Type.CLOTHES][heroTid][fashionId]
end

-- 初始化皮肤部位配置表
function parseFashionColorData(self)
    self.mFashionColorDic = {} -- 战员id和时装id为索引
    self.mFashionColorModeIdDic = {} -- 模型id为索引
    local baseData = RefMgr:getData("hero_fashion_color_data")
    for id, data in pairs(baseData) do

        if not self.mFashionColorModeIdDic[data.model_id] then
            self.mFashionColorModeIdDic[data.model_id] = {}
        end
        local baseVo = fashion.FashionColorBaseVo.new()
        baseVo:parseData(id, data)
        self.mFashionColorModeIdDic[data.model_id] = baseVo

        if not self.mFashionColorDic[data.tid] then
            self.mFashionColorDic[data.tid] = {}
        end
        if not self.mFashionColorDic[data.tid][data.fashion_id] then
            self.mFashionColorDic[data.tid][data.fashion_id] = {}
        end
        for i = 0, #data.fashion_color_data do
            local vo = fashion.FashionColorVo.new()
            vo:parseData(i, data.fashion_color_data[i])
            table.insert(self.mFashionColorDic[data.tid][data.fashion_id], vo)
        end
    end
end

-- 初始化模型材质配置表
function parseModelHarData(self)
    self.mModelHarDic = {}
    local baseData = RefMgr:getData("model_har_data")
    for id, data in pairs(baseData) do
        self.mModelHarDic[id] = data
    end
end

-- 获取模型材质配置
function getModelHarData(self, modelId)
    if not self.mModelHarDic then
        self:parseModelHarData()
    end
    return self.mModelHarDic[modelId]
end

-- 获取时装部位列表
function getFasionColorList(self, heroTid, fashionId)
    if not self.mFashionColorDic then
        self:parseFashionColorData()
    end
    if not self.mFashionColorDic[heroTid] then
        return nil
    end
    return self.mFashionColorDic[heroTid][fashionId]
end

-- 获取时装部位数据
function getFasionColorVo(self, heroTid, fashionId, colorId)
    if not self.mFashionColorDic then
        self:parseFashionColorData()
    end
    if not self.mFashionColorDic[heroTid] or not self.mFashionColorDic[heroTid][fashionId] then
        return nil
    end
    local list = self.mFashionColorDic[heroTid][fashionId]
    for i, vo in ipairs(list) do
        if vo.id == colorId then
            return vo
        end
    end
    return nil
end

-- 取模型id对应的部位
function getFColorBaseVoByModeId(self, modelId)
    if not self.mFashionColorModeIdDic then
        self:parseFashionColorData()
    end
    return self.mFashionColorModeIdDic[modelId]
end

-- 根据时装类型获取对应类型的时装字典
function getFashionConfigDic(self, fashionType)
    if (not self.m_fashionConfigDic) then
        self:parseConfigData()
    end
    return self.m_fashionConfigDic[fashionType]
end

function getAllFashionListByType(self, fashionType)
    local list = {}
    for k, heroVo in pairs(self:getFashionConfigDic(fashionType)) do
        for i, fashionVo in ipairs(heroVo) do
            if fashionVo.fashionId ~= 1 then
                table.insert(list, fashionVo)
            end
        end
    end
    return list or {}
end

-- 判断对应英雄是否有时装
function getFashionEnable(self, heroTid)
    if (not self.m_fashionConfigDic) then
        self:parseConfigData()
    end
    for fashionType, dic in pairs(self.m_fashionConfigDic) do
        if (dic[heroTid]) then
            return true
        end
    end
    return false
end

-- 获取英雄装饰配置字典
function getHeroFashionConfigDic(self, fashionType, heroTid)
    if (not self.m_fashionConfigDic) then
        self:parseConfigData()
    end
    local fashionDic = self:getFashionConfigDic(fashionType)
    if (fashionDic) then
        return fashionDic[heroTid]
    else
        return nil
    end
end

-- 获取英雄装饰配置vo
function getHeroFashionConfigVo(self, fashionType, heroTid, fashionId)
    local heroFashionDic = self:getHeroFashionConfigDic(fashionType, heroTid)
    if (heroFashionDic) then
        return heroFashionDic[fashionId]
    else
        return nil
    end
end

-- 根据sortIndex获取服饰配置vo
function getHeroFashionConfigVoBySort(self, fashionType, heroTid, sortIndex)
    local heroFashionDic = self:getHeroFashionConfigDic(fashionType, heroTid)
    if (heroFashionDic) then
        for fashionId, vo in pairs(heroFashionDic) do
            if (vo.sortIndex == sortIndex) then
                return vo
            end
        end
        return nil
    else
        return nil
    end
end

function setHeroId(self, heroId)
    if (heroId == self.m_heroId) then
        return
    end
    self.m_heroId = heroId
    self:dispatchEvent(self.SELECTE_CHANGE, {})
end

function getHeroId(self)
    return self.m_heroId
end

--------------------------------------------------------------start 红点------------------------------------------------------------------------
function isHeroFashionBubble(self, heroId)
    local isBubble = false
    if (not isBubble) then
        if (not self.m_fashionConfigDic) then
            self:parseConfigData()
        end
        local heroVo = hero.HeroManager:getHeroVo(heroId)
        for fashionType, heroFashionDic in pairs(self.m_fashionConfigDic) do
            for heroTid, fashionDic in pairs(heroFashionDic) do
                if (heroTid == heroVo.tid) then
                    isBubble = self:isHeroFashionListBubble(fashionType, heroId)
                    if (isBubble) then
                        break
                    end
                end
            end
            if (isBubble) then
                break
            end
        end
    end
    return isBubble
end

function isHeroFashionListBubble(self, fashionType, heroId)
    local isBubble = false
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    local heroFashionDic = self:getHeroFashionConfigDic(fashionType, heroVo.tid)
    for fashionId, vo in pairs(heroFashionDic) do
        isBubble = self:isHeroFashionIdBubble(fashionType, heroId, fashionId)
        if (isBubble) then
            break
        end
    end
    return isBubble
end

function isHeroFashionIdBubble(self, fashionType, heroId, fashionId)
    local isBubble = false
    -- 只判断进攻队列中或者防守队列中的英雄
    -- if (hero.HeroUseCodeManager:isInUse(heroId, hero.HeroUseCodeManager.IN_TEAM_FORMATION) or hero.HeroUseCodeManager:isInUse(heroId, hero.HeroUseCodeManager.IN_ARENA_DEFENSE)) then
    local fashionVo, state = fashion.FashionManager:getHeroFashionVo(fashionType, heroId, fashionId)
    if (state == fashion.State.LOCK) then
        local heroVo = hero.HeroManager:getHeroVo(heroId)
        local vo = self:getHeroFashionConfigVo(fashionType, heroVo.tid, fashionId)
        isBubble = bag.BagManager:getPropsCountByTid(vo.costTid) > 0
    end
    -- end

    return isBubble
end
--------------------------------------------------------------end 红点------------------------------------------------------------------------

--------------------------------------------------------------start 服务器数据----------------------------------------------------------------------
-- 返回所有战员的穿戴时装
function parseMsgFashionList(self, msgList)
    self.m_heroFashionDic = {}
    for i = 1, #msgList do
        self:__parseHeroFashionInfo(msgList[i].hero_id, msgList[i].fashion_info)
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_PANEL, {})
end

-- 返回单个战员穿戴时装数据
function parseMsgFashionInfo(self, msgList)
    if (not self.m_heroFashionDic) then
        self.m_heroFashionDic = {}
    end
    for i = 1, #msgList do
        local heroId = msgList[i].hero_id
        local msgFashionList = msgList[i].fashion_info
        if (#msgFashionList > 0) then
            self:__parseHeroFashionInfo(heroId, msgFashionList)
            GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_FASHION_DATA, {})
            GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_PANEL, {
                heroId = heroId
            })
        else
            self.m_heroFashionDic[heroId] = nil
            GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_FASHION_DATA, {})
        end
    end
end

function __parseHeroFashionInfo(self, heroId, msgFashionList)
    local list = {}
    for _, msgFashionVo in pairs(msgFashionList) do
        local fashionVo = fashion.FashionVo.new()
        fashionVo:parseMsgData(heroId, msgFashionVo)
        table.insert(list, fashionVo)
    end
    self.m_heroFashionDic[heroId] = list
end

-- 返回战员穿戴时装结果
function parseMsgWearFashionResult(self, msgFashionType, heroId, fashionId)
    if (not self.m_heroFashionDic) then
        return
    end
    local fashionType = fashion.getFashionTypeByMsg(msgFashionType)
    local list = self.m_heroFashionDic[heroId]
    if (list) then
        for _, vo in pairs(list) do
            if (vo.fashionType == fashionType) then
                if (vo.fashionId == fashionId) then
                    vo.isWear = true
                else
                    vo.isWear = false
                end
            end
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_WEAR_FASHION, {})
        GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_PANEL, {
            heroId = heroId,
            fashionType = fashionType,
            fashionId = fashionId
        })
    end
end

-- 返回战员时装解锁
function parseMsgWearFashionUnlock(self, msgFashionType, heroTid, fashionId)
    if (not self.m_heroFashionDic) then
        return
    end
    local fashionType = fashion.getFashionTypeByMsg(msgFashionType)
    for heroId, list in pairs(self.m_heroFashionDic) do
        local heroVo = hero.HeroManager:getHeroVo(heroId)
        if (not heroVo) then
            Debug:log_error("FashionManager", "找不到英雄数据：" .. heroId)
        end
        if (heroVo.tid == heroTid) then
            for i = #list, 1, -1 do
                local vo = list[i]
                if (vo.fashionType == fashionType and vo.fashionId == fashionId) then
                    table.remove(list, i)
                end
            end
            local fashionVo = fashion.FashionVo.new()
            fashionVo.heroId = heroId
            fashionVo.fashionId = fashionId
            fashionVo.isWear = false
            fashionVo.fashionType = fashionType
            table.insert(list, fashionVo)
            GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_PANEL, {
                heroId = heroId,
                fashionType = fashionType,
                fashionId = fashionId
            })
        end
    end
    gs.Message.Show2(_TT(62505))
end

-- 获取战员对应时装列表(不包含未解锁的)
function getHeroFashionCount(self, fashionType, heroId)
    if (not self.m_heroFashionDic) then
        return
    end
    local count = 0
    local list = self.m_heroFashionDic[heroId]
    for _, vo in pairs(list) do
        if (vo.fashionType == fashionType) then
            count = count + 1
        end
    end
    return count
end

-- 获取战员对应时装数据和状态
function getHeroFashionVo(self, fashionType, heroId, fashionId)
    if (not self.m_heroFashionDic) then
        return
    end
    local searchFashionVo = nil
    local list = self.m_heroFashionDic[heroId] or {}
    for _, vo in ipairs(list) do
        if (vo.fashionType == fashionType and vo.fashionId == fashionId) then
            searchFashionVo = vo
            break
        end
    end
    local state = nil
    if (searchFashionVo) then
        if (searchFashionVo.isWear) then
            state = fashion.State.WEARING
        else
            state = fashion.State.UNLOCK
        end
    else
        state = fashion.State.LOCK
    end
    return searchFashionVo, state
end

-- 获取战员穿戴的时装id
function getHeroWearingFashionVo(self, fashionType, heroId)
    if (not self.m_heroFashionDic) then
        return
    end
    local list = self.m_heroFashionDic[heroId]
    if (list == nil) then
        return
    end
    for _, vo in pairs(list) do
        if (vo.fashionType == fashionType) then
            if (vo.isWear) then
                return vo
            end
        end
    end
end

-- 所有战员穿戴的炫彩时装
function parseFashionColorInfoMsg(self, msg)
    self.mFashionColorInfo = {}
    for i, v in ipairs(msg.hero_fashion_color_info) do
        self.mFashionColorInfo[v.hero_id .. "_" .. v.fashion_id] = v.color_id
    end
end

-- 获取当前战员穿戴的皮肤穿戴部位
function getFashionColorData(self, modelId)
    if not self.mFashionColorInfo then
        return nil
    end
    local baseVo = self:getFColorBaseVoByModeId(modelId)
    if not baseVo then
        return nil
    end
    local heroId = hero.HeroManager:getHeroIdByTid(baseVo.heroTid)
    if not heroId then
        return nil
    end
    local fashionId = baseVo.fashionId
    local id = self.mFashionColorInfo[heroId .. "_" .. fashionId]
    if not id or id == 0 then
        local msgVo = self:getHeroFashionColor(heroId, fashionId)
        if msgVo then
            id = msgVo.colorId
        else
            return nil
        end
    end
    return baseVo.colorList[id]
end

--- *s2c* 查看战员时装的炫彩 13345
function parseLookFashionColorMsg(self, msg)
    local msgVo = fashion.FashionColorMsgVo.new()
    msgVo:parseMsg(msg)
    self.mHeroFashionColorDic[msgVo.heroTid .. "_" .. msgVo.fashionId] = msgVo

    GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_FASHION_COLOR, msgVo)
end

-- 获取战员对应皮肤的部位信息
function getHeroFashionColor(self, heroTid, fashionId)
    return self.mHeroFashionColorDic[heroTid .. "_" .. fashionId]
end

-- 战员皮肤部位解锁
function onParseWearFashionColorMsg(self, msg)
    if not self.mFashionColorInfo then
        self.mFashionColorInfo = {}
    end
    self.mFashionColorInfo[msg.hero_id .. "_" .. msg.fashion_id] = msg.color_id
end

--------------------------------------------------------------end 服务器数据------------------------------------------------------------------------

-- 战员时装解锁信息
function parseHeroFashionHaveInfo(self, msg)
    self.mHeroHaveFashionDic = {}
    self.mHeroHaveFashionDic[fashion.Type.CLOTHES] = {}
    self.mHeroHaveFashionDic[fashion.Type.WEAPON] = {}
    for i = 1, #msg.hero_have_body_fashion do
        if self.mHeroHaveFashionDic[fashion.Type.CLOTHES][msg.hero_have_body_fashion[i].hero_tid] == nil then
            self.mHeroHaveFashionDic[fashion.Type.CLOTHES][msg.hero_have_body_fashion[i].hero_tid] = {}
        end
        self.mHeroHaveFashionDic[fashion.Type.CLOTHES][msg.hero_have_body_fashion[i].hero_tid] = msg.hero_have_body_fashion[i].have_fashion_id_list
    end

    for i = 1, #msg.hero_have_weapons_fashion do
        if self.mHeroHaveFashionDic[fashion.Type.WEAPON][msg.hero_have_body_fashion[i].hero_tid] == nil then
            self.mHeroHaveFashionDic[fashion.Type.WEAPON][msg.hero_have_body_fashion[i].hero_tid] = {}
        end
        self.mHeroHaveFashionDic[fashion.Type.WEAPON][msg.hero_have_weapons_fashion[i].hero_tid] = msg.hero_have_body_fashion[i].have_fashion_id_list
    end
end

function parseHeroFashionAddHaveInfo(self,msgFashionType,tid,fashionId)
    if self.mHeroHaveFashionDic == nil then
        self.mHeroHaveFashionDic = {}
        self.mHeroHaveFashionDic[fashion.Type.CLOTHES] = {}
        self.mHeroHaveFashionDic[fashion.Type.WEAPON] = {}
    end
    
    local fashionType = fashion.getFashionTypeByMsg(msgFashionType)
    if self.mHeroHaveFashionDic[fashionType][tid] == nil then
        self.mHeroHaveFashionDic[fashionType][tid] = {}
    end
    table.insert(self.mHeroHaveFashionDic[fashionType][tid],fashionId)
end

function getHeroFashionHaveInfo(self, fashionType, tid, fashionId)
    if self.mHeroHaveFashionDic == nil then
        return false
    end

    local data = self.mHeroHaveFashionDic[fashionType]
    if data[tid] == nil then
        return false
    end

    return table.indexof01(data[tid], fashionId) > 0
end

-- 析构函数
function dtor(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(62505):	"解锁成功"
]]
