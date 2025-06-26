module("favorable.FavorableManager", Class.impl(Manager))

function ctor(self)
    super.ctor(self)
    self:init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

function init(self)
    self.mHeroFavorableData = nil

    self.mNeedExp = 0
    -- { tid = , num = ,likeAdd =  , }
    self.mSelectProps = {}
    -- 已领取奖励列表
    self.giftGainList = {}
    self.storyRewardGainList = {}
    -- 当前战员id
    self.curHeroId = nil
    -- 是否是满足升级弹窗要求
    self.mIsPopUp = false
    self.mDetailShow3D = true
    self.mPreLv = 0
    self.mRecordFavorChoose = false
    self.mNowActionTime = 0
    self.mNowVoiceTime = 0
end

function setNowActionTime(self, time)
    self.mNowActionTime = time
end

function getNowActionTime(self)
    return self.mNowActionTime
end

function setNowVoiceTime(self, time)
    self.mNowVoiceTime = time
end

function getNowVoiceTime(self)
    return self.mNowVoiceTime
end

function getPreLv(self)
    return self.mPreLv
end

function setPreLv(self, lv)
    self.mPreLv = lv
    GameDispatcher:dispatchEvent(EventName.UPDATE_FAVORABLE_ATTR)
end

function parseHeroFavorableData(self)
    self.mHeroFavorableData = {}
    local baseData = RefMgr:getData("hero_relation_data")
    for tid, data in pairs(baseData) do
        local vo = favorable.HeroFavorableVo.new()
        vo:parseConfigData(data)
        self.mHeroFavorableData[tid] = vo
    end
end

-- 解析好感度礼物领取列表
function parseHeroFavorableRwardMsg(self, msg)
    local showId = 0
    for k, v in pairs(msg.relation_reward_list) do
        if not self.giftGainList[v.hero_tid] then
            self.giftGainList[v.hero_tid] = {}
        end
        for m, n in pairs(v.received_ids) do
            if table.indexof(self.giftGainList[v.hero_tid], n) == false then
                table.insert(self.giftGainList[v.hero_tid], n)
                showId = n > showId and n or showId
            end
        end
        if not self.storyRewardGainList[v.hero_tid] then
            self.storyRewardGainList[v.hero_tid] = {}
        end
        for m, n in pairs(v.received_story_lvs) do
            if table.indexof(self.storyRewardGainList[v.hero_tid], n) == false then
                table.insert(self.storyRewardGainList[v.hero_tid], n)
            end
        end
    end
    GameDispatcher:dispatchEvent(EventName.FAVORABLE_REWARD_GAIN_UPDATE, showId)
    GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_STORY_REWARD)
end

-- 解锁奖励领取返回
function parseReceiveReawrdMsg(self, msg)
    local hasHeroRecord = false
    if (self.giftGainList[msg.hero_tid] == nil) then
        self.giftGainList[msg.hero_tid] = {}
    end
    if not table.indexof(self.giftGainList[msg.hero_tid], msg.id) then
        table.insert(self.giftGainList[msg.hero_tid], msg.id)
    end
    GameDispatcher:dispatchEvent(EventName.FAVORABLE_REWARD_GAIN_UPDATE, msg.id)
end

-- 获取好感度配置数据
function getHeroFavorableData(self, tid)
    if self.mHeroFavorableData == nil then
        self:parseHeroFavorableData()
    end
    return self.mHeroFavorableData[tid]
end

-- 判断资料奖励是否已经领取
function checkCaseRewardGain(self, heroTid, id)
    if (self.giftGainList[heroTid]) then
        return table.indexof(self.giftGainList[heroTid], id) ~= false
    else
        return false
    end
end

-- 对应的资料条是否有奖励可领取
function getHasCaseReward(self, heroId, id)
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    local list = self:getCaseList(heroVo.tid)
    for i, vo in ipairs(list) do
        if heroVo.favorableLevel >= vo.relationLv and self:checkCaseRewardGain(heroVo.tid, id) == false then
            return true
        end
    end
    return false
end
-- 获取下一个资料是否未解锁
function getIsNextNotUnlock(self, heroId, curVo)
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    if heroVo then
        local list = self:getCaseList(heroVo.tid)
        if (list) then
            for index, vo in ipairs(list) do
                if vo.id == curVo.id then
                    if ((list[index + 1]) and (self:checkCaseRewardGain(heroVo.tid, list[index + 1].id) == false)) then
                        return true
                    else
                        return false
                    end
                end
            end
        end
    end
end

-- 该英雄是否有资料奖励可领取
function getCaseRewardHasRed(self, heroId)
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    if heroVo then
        local list = self:getCaseList(heroVo.tid)
        if (list) then
            for i, vo in pairs(list) do
                if heroVo.favorableLevel >= vo.relationLv and self:checkCaseRewardGain(heroVo.tid, vo.id) == false and
                    vo.title ~= 47011 then
                    return true
                end
            end
        end
    end
    return false
end

-- 是否为喜欢的礼物
function checkIsLike(self, propsTid)
    local heroVo = hero.HeroManager:getHeroVo(self.curHeroId)
    local data = self:getHeroFavorableData(heroVo.tid)
    for _, v in ipairs(data.likegift) do
        if v[1] == propsTid then
            return true, v[2]
        end
    end
    return false, 0
end

-- 是否为不喜欢的礼物
function checkIsDislike(self, propsTid)
    local heroVo = hero.HeroManager:getHeroVo(self.curHeroId)
    local data = self:getHeroFavorableData(heroVo.tid)
    for _, v in ipairs(data.dislikegift) do
        if v[1] == propsTid then
            return true, v[2]
        end
    end
    return false, 0
end

function setNeedExp(self, exp)
    self.mNeedExp = exp
end

function getNeedExp(self)
end

function addProps(self, oneData)
    local max = self:getMax(oneData)
    if (max >= oneData.num) then
        self.mSelectProps[oneData.tid] = {
            num = oneData.num,
            likeAdd = oneData.likeAdd,
            id = oneData.id
        }
        return true
    else
        return false
    end
end

function setProps(self, oneData)
    self.mSelectProps[oneData.tid] = {
        num = oneData.num,
        likeAdd = oneData.likeAdd,
        id = oneData.id
    }
end

function subProps(self, oneData)
    self.mSelectProps[oneData.tid] = {
        num = oneData.num,
        likeAdd = oneData.likeAdd,
        id = oneData.id
    }
end

function getMax(self, oneData)
    local selectNum = 0
    for id, data in pairs(self.mSelectProps) do
        if id == oneData.tid then
            -- 如果是同一个道具id的不予计算
        else
            selectNum = selectNum + data.num * data.likeAdd
        end
    end

    local need = self.mNeedExp - selectNum
    local max = math.ceil(need / oneData.likeAdd)
    if max <= 0 then
        max = 0
    end
    return max
end

-- 选的道具预览提升等级
function getSelectUpLvl(self)
    local needExp = 0

    local heroVo = hero.HeroManager:getHeroVo(self.curHeroId)
    local heroFavorableData = self:getHeroFavorableData(heroVo.tid)

    local lvNeedExpList = {0}
    for lv, data in pairs(heroFavorableData.favorableData) do
        needExp = needExp + data.favorableExp
        if (data.favorableExp > 0) then
            table.insert(lvNeedExpList, needExp)
        end
    end

    local preLv = 0
    local currentExp = self:getSelectNum() + lvNeedExpList[heroVo.favorableLevel] + heroVo.favorableExp
    for i = 1, #lvNeedExpList do
        if (currentExp >= lvNeedExpList[i]) then
            preLv = i
        end
    end
    if preLv == heroVo.favorableLevel then
        -- 预览必须大于自己当前等级
        preLv = heroVo.favorableLevel + 1
    end

    return preLv
end

-- 选择的道具增加的亲密度值
function getSelectNum(self)
    local selectNum = 0
    for id, data in pairs(self.mSelectProps) do
        selectNum = selectNum + data.num * data.likeAdd
    end
    return selectNum
end

-- 选择的道具列表
function getSelectProps(self)
    local retList = {}
    for id, data in pairs(self.mSelectProps) do
        if data.num ~= 0 then
            local pt_item_num = {
                item_id = data.id,
                num = data.num
            }
            table.insert(retList, pt_item_num)
        end
        -- selectNum = selectNum + data.num * data.likeAdd
    end
    return retList
end

function initSelectProps(self)
    self.mSelectProps = {}
end

-- 初始化配置表
function parseConfigData(self)
    self.mCaseData = {}
    self.mVoiceData = {}
    self.mInteractData = {}
    local baseData = RefMgr:getData("hero_case_data")
    for key, data in pairs(baseData) do
        if not self.mCaseData[key] then
            self.mCaseData[key] = {}
        end
        -- 临时数据 初始资料 暂时写死
        local tempVo = LuaPoolMgr:poolGet(favorable.FavorableCaseVo)
        tempVo:parseData(0, data.hero_case[1], key)
        tempVo.relationLv = 0
        tempVo.title = 47011
        table.insert(self.mCaseData[key], tempVo)
        for i, v in ipairs(data.hero_case) do
            local vo = LuaPoolMgr:poolGet(favorable.FavorableCaseVo)
            vo:parseData(i, v)
            table.insert(self.mCaseData[key], vo)
        end
    end
    local baseData = RefMgr:getData("hero_voice_data")
    for key, data in pairs(baseData) do
        if not self.mVoiceData[key] then
            self.mVoiceData[key] = {}
        end

        for i, v in ipairs(data.hero_voice) do
            local vo = LuaPoolMgr:poolGet(favorable.FavorableVoiceVo)
            vo:parseData(i, v)
            table.insert(self.mVoiceData[key], vo)
        end
    end
    local baseData = RefMgr:getData("hero_interact_data")
    for key, data in pairs(baseData) do
        if not self.mInteractData[key] then
            self.mInteractData[key] = {}
        end

        for i, v in ipairs(data.interact) do
            local vo = LuaPoolMgr:poolGet(favorable.FavorableInteractVo)
            vo:parseData(i, v)
            table.insert(self.mInteractData[key], vo)
        end
    end
end

function getCaseList(self, cusTid)
    if not self.mCaseData then
        self:parseConfigData()
    end
    return self.mCaseData[cusTid]
end

function getVoiceList(self, cusTid)
    if not self.mVoiceData then
        self:parseConfigData()
    end
    return self.mVoiceData[cusTid]
end

function getInteractList(self, cusTid)
    if not self.mInteractData then
        self:parseConfigData()
    end
    return self.mInteractData[cusTid]
end

function getStoryList(self, cusTid)
    if self.mHeroFavorableData == nil then
        self:parseHeroFavorableData()
    end
    return self.mHeroFavorableData[cusTid]
end
-- 获取是否满足升级弹窗要求
function getIsPopUp(self)
    return self.mIsPopUp
end

function setIsPopUp(self, isPopUp)
    self.mIsPopUp = isPopUp
end

function setOldHeroVo(self, heroVo)
    -- self.oldHeroVo = heroVo
    local oldHeroVo = hero.HeroVo.new()
    oldHeroVo.id = heroVo.id
    oldHeroVo.tid = heroVo.tid
    oldHeroVo.evolutionLvl = heroVo.evolutionLvl
    oldHeroVo.militaryRank = heroVo.militaryRank
    oldHeroVo.favorableLevel = heroVo.favorableLevel
    oldHeroVo:setAttrList(heroVo.attrList)
    self.oldHeroVo = oldHeroVo
end

function getOldHeroVo(self)
    return self.oldHeroVo
end

-- function parseHeroStoryRewardMsg(self,msg)
--     self.relationStoryList = msg.relation_story_reward_list
-- end

function getHeroStoryRewardGeted(self, tid, lv)
    if self.storyRewardGainList == nil then
        return false
    end

    if self.storyRewardGainList[tid] == nil then
        return false
    end
    return table.indexof01(self.storyRewardGainList[tid], lv) > 0
end

function updateHeroStoryReward(self, msg)
    if not self.storyRewardGainList[msg.hero_tid] then
        self.storyRewardGainList[msg.hero_tid] = {}
    end

    table.insert(self.storyRewardGainList[msg.hero_tid], msg.relation_lv)

    GameDispatcher:dispatchEvent(EventName.FAVORABLE_REWARD_GAIN_UPDATE)
    GameDispatcher:dispatchEvent(EventName.UPDATE_HERO_STORY_REWARD)
end

-- 该英雄是否有资料奖励可领取
function getStoryRewardHasRed(self, heroId)
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    if heroVo then
        local dic = favorable.FavorableManager:getStoryList(heroVo.tid).favorableData
        local list = {}
        for id, data in pairs(dic) do
            if data.storyId > 0 then
                table.insert(list, data)
            end
        end
        -- local list = self:getCaseList(heroVo.tid)
        if (list) then
            for i = 1, #list do
                local canFavorable = heroVo.favorableLevel >= list[i].favorableLevel
                local noGet = self:getHeroStoryRewardGeted(heroVo.tid, list[i].favorableLevel) == false
                if canFavorable and noGet then
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
