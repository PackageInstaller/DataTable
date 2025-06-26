--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeManager
@Description    : 代号·希望副本数据中心
@date           : 2021-05-10 14:42:40
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup.dup_codeHope.manager.DupCodeHopeManager', Class.impl(Manager))

-- 副本信息更新
EVENT_DUP_INFO_UPDATE = "EVENT_DUP_INFO_UPDATE"
-- 排行榜更新
EVENT_CODE_HOPE_RANK_UPDATE = "EVENT_CODE_HOPE_RANK_UPDATE"


-- 本地缓存，首次显示new
DUP_CODE_HOPE_NEW_SHOW = "DUP_CODE_HOPE_NEW_SHOW"

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

--初始化
function init(self)
    -- 本次激活的buff id
    self.activeBuffId = nil
    self.mHeroInfoData = {}
end

-- 初始化配置表
function parseConfigData(self)
    self.mBaseData = {}
    self.mDupData = {}
    self.mBuffData = {}
    self.mRewardBaseList = {}
    local baseData = RefMgr:getData('code_hope_data')
    for key, data in pairs(baseData) do
        local areaVo = LuaPoolMgr:poolGet(dup.DupCodeHopeDataVo)
        areaVo:parseData(key, data)
        self.mBaseData[key] = areaVo
    end

    baseData = RefMgr:getData('code_hope_dup_data')
    for key, data in pairs(baseData) do
        local dupVo = LuaPoolMgr:poolGet(dup.DupCodeHopeDupVo)
        dupVo:parseData(key, data)
        self.mDupData[key] = dupVo
    end

    baseData = RefMgr:getData('code_hope_buff_data')
    for key, data in pairs(baseData) do
        local dupVo = LuaPoolMgr:poolGet(dup.DupCodeHopeBuffVo)
        dupVo:parseData(key, data)
        self.mBuffData[key] = dupVo
    end

    baseData = RefMgr:getData('code_hope_reward_data')
    for key, data in pairs(baseData) do
        local rewardVo = LuaPoolMgr:poolGet(rank.RankRewardVo)
        rewardVo:parseData(key, data)
        table.insert(self.mRewardBaseList, rewardVo)
    end
    table.sort(self.mRewardBaseList, function(a, b)
        return a.leftRank < b.leftRank
    end)
end

-- 解析副本信息
function parseCodeHopeInfoMsg(self, msg)

    self.mMaxDupId = 0
    self.mDupInfoData = {}
    self.mOpenChapterIds = {}
    self.gainChapterAwards = {}
    self.activeBuffIds = {}
    self.mRoundFastPassTime = {}
    -- 战员信息列表
    self.mHeroInfoData = {}

    for i, info in ipairs(msg.chapter_list) do
        -- 激活的buffId
        for _, buffId in ipairs(info.active_buff) do
            table.insert(self.activeBuffIds, buffId)
        end

        -- 关奖励状态 0-未满足 1-可领取 2-已完成
        self.gainChapterAwards[info.chapter_id] = info.gain_state

        -- 是否开启挑战 1-是 0-否
        if info.is_open == 1 then
            table.insert(self.mOpenChapterIds, info.chapter_id)
        end

        -- 本轮整章最短通关时间
        self.mRoundFastPassTime[info.chapter_id] = info.round_fast_pass

        -- 城池信息
        for _, pt_code_hope_city_info in ipairs(info.city_list) do
            local vo = dup.DupCodeHopeInfoVo.new()
            vo:parseMsg(pt_code_hope_city_info)
            self.mDupInfoData[vo.dupId] = vo
            local dupData = self:getDupVo(vo.dupId)
            if vo.roundPassTime ~= 0 then
                -- 取通关的最大一个副本
                self.mMaxDupId = math.max(vo.dupId, self.mMaxDupId)
            end
        end


        self.mHeroInfoData[info.chapter_id] = {}
        for i, v in ipairs(info.hero_list) do
            local maxCount = sysParam.SysParamManager:getValue(SysParamType.CODE_HOPE_HERO_MAX_STAMINA)
            local remaidCount = math.max(0, maxCount - v.had_cost_stamina)
            self.mHeroInfoData[info.chapter_id][v.hero_id] = { remaidCount = remaidCount, maxCount = maxCount }
        end

    end

    self:dispatchEvent(self.EVENT_DUP_INFO_UPDATE)

    self:checkFlag()
end

-- 解析战员信息
function parseCodeHopeHeroInfoMsg(self, msg)
    self.mHeroInfoData = {}
    self.mHeroInfoData[msg.chapter_id] = {}
    for i, v in ipairs(msg.hero_list) do
        local maxCount = sysParam.SysParamManager:getValue(SysParamType.CODE_HOPE_HERO_MAX_STAMINA)
        local remaidCount = math.max(0, maxCount - v.had_cost_stamina)
        self.mHeroInfoData[msg.chapter_id][v.hero_id] = { remaidCount = remaidCount, maxCount = maxCount }
    end
end

-- 解析本次激活的副本id
function parseCodeHopeActiveBuffMsg(self, msg)
    if self.activeBuffIds then
        table.insert(self.activeBuffIds, msg.buff_id)
    end
    self.activeBuffId = msg.buff_id
end
-- 章节奖励领取返回
function parseCodeHopeChapterAwardMsg(self, msg)
    if msg.result == 1 then
        self.gainChapterAwards[msg.chapter_id] = 2

        self:dispatchEvent(self.EVENT_DUP_INFO_UPDATE)

        self:checkFlag()
    end
end

-- 解析完成章节
function parseCodeHopeChapterEndMsg(self, msg)
    self.isChapterEnd = true
end

-- 解析排行榜数据
function parseCodeHopeRankInfoMsg(self, msg)
    self.mRankList = {}
    self.myRank = msg.my_rank
    self.myPassTime = msg.my_pass_cost_time
    for i, v in ipairs(msg.rank_list) do
        local vo = dup.DupImpliedRankVo.new()
        -- local vo = rank.RankBaseVo.new()
        vo:parseMsg(v)
        table.insert(self.mRankList, vo)
    end
    -- self:dispatchEvent(self.EVENT_CODE_HOPE_RANK_UPDATE)
    GameDispatcher:dispatchEvent(EventName.EVENT_RANK_UPDATE)
end

-- 副本服务器信息
function getDupInfo(self, cusDupId)
    if not self.mDupInfoData then
        return nil
    end
    return self.mDupInfoData[cusDupId]
end

-- 取排行榜列表
function getRankList(self)
    return self.mRankList
end

-- 获取战员耐力信息
function getHeroInfo(self, chapterId, cusId)
    if not self.mHeroInfoData[chapterId] then
        self.mHeroInfoData[chapterId] = {}
    end

    if not self.mHeroInfoData[chapterId][cusId] then
        local maxCount = sysParam.SysParamManager:getValue(SysParamType.CODE_HOPE_HERO_MAX_STAMINA)
        self.mHeroInfoData[chapterId][cusId] = { remaidCount = maxCount, maxCount = maxCount }
    end

    return self.mHeroInfoData[chapterId][cusId]
end

-- buff是否已激活
function buffIsActive(self, cusId)
    if table.indexof(self.activeBuffIds, cusId) == false then
        return false
    end
    return true
end

-- 章节奖励是否已领取
function chapterAwardIsGain(self, chapter)
    if self.gainChapterAwards and self.gainChapterAwards[chapter] == 2 then
        return true
    end
    return false
end

-- 章节奖励是否可领取
function chapterAwardIsCanGet(self, chapter)
    if self.gainChapterAwards and self.gainChapterAwards[chapter] == 1 then
        return true
    end
    return false
end



-- 基础数据
function getBaseData(self)
    if self.mBaseData == nil then
        self:parseConfigData()
    end
    return self.mBaseData
end

-- 副本数据
function getDupData(self)
    if self.mDupData == nil then
        self:parseConfigData()
    end
    return self.mDupData
end

-- buff数据
function getBuffData(self, cusBuffId)
    if self.mBuffData == nil then
        self:parseConfigData()
    end
    return self.mBuffData[cusBuffId]
end

-- 取章节数据
function getChapterData(self, cusChapter)
    return self:getBaseData()[cusChapter]
end

-- 获取某个副本数据
function getDupVo(self, cusId)
    local vo = self:getDupData()[cusId]
    if not vo then
        logError('DupCodeHopeManager', '希望副本不存在副本id：' .. cusId)
    end
    return vo
end

-- 排行奖励数据
function getRewardList(self)
    if self.mRewardBaseList == nil then
        self:parseConfigData()
    end
    return self.mRewardBaseList
end


-- 当前可打副本
function curDupId(self)
    if self:maxDupId() == 0 then
        -- 默认
        local chapterVo = self:getChapterData(1)
        return chapterVo.stageList[1]
    end

    local dupVo = self:getDupVo(self:maxDupId())
    if not dupVo then
        return 0
    end
    local chapterVo = self:getChapterData(dupVo.chapter)
    if not chapterVo then
        return 0
    end
    local chapter = dupVo.chapter

    local maxStageDupId = 0
    for i, v in ipairs(chapterVo.stageList) do
        local dupVo = self:getDupVo(v)
        --if dupVo.stageType == 1 then
        maxStageDupId = math.max(maxStageDupId, v)
        --end
    end

    if self:maxDupId() == maxStageDupId then
        -- 跨章节了，取下一章第一个副本（唯一）+
        local chapterVo = self:getChapterData(chapter + 1)
        if not chapterVo then
            -- 全部通关
            return self:maxDupId()
        end
        return chapterVo.stageList[1]
    end

    -- 从正常多个开放副本里取id最小的一个
    local list = {}
    for i, v in ipairs(chapterVo.stageList) do
        local dupVo = self:getDupVo(v)
        if self:getDupIsOpen(v) and not self:getDupIsPass(v) then
            table.insert(list, v)
        end
    end

    table.sort(list)
    return list[1]

end

-- 通关的最高副本
function maxDupId(self)
    -- local dupInfo = dup.DupMainManager:getDupInfoData(DupType.DUP_CODE_HOPE)
    -- if not dupInfo then
    --     return 0
    -- end
    -- return dupInfo.maxId
    return self.mMaxDupId
end

-- 当前所在章节
function curChapter(self)
    local dupVo = self:getDupVo(self:curDupId())
    if dupVo then
        return dupVo.chapter
    end
    return 1
end

-- 章节是否已通关
function getChapterIsPass(self, chapter)
    local chapterVo = self:getChapterData(chapter)
    if not chapterVo then
        return nil --false作为判断未开放，nil可用来判断第一章
    end
    local count = 0
    for i, v in ipairs(chapterVo.stageList) do
        local dupData = self:getDupVo(v)
        --if dupData.stageType == 1 then
        if not self:getDupIsPass(v) then
            return false
        end
        --end
    end
    return true
end

-- 章节是否已开放
function getChapterIsOpen(self, chapter)
    if not self.mOpenChapterIds or table.indexof(self.mOpenChapterIds, chapter) == false then
        return false
    end
    return true
    -- if self:getChapterIsPass(chapter - 1) ~= false then
    --     return true
    -- end
end

-- 获取副本归属章节
function getChapterByDupId(self, cusDupId)
    local dupVo = self:getDupVo(cusDupId)
    return dupVo.chapter
end

-- 副本是否开放
function getDupIsOpen(self, cusDupId)
    local dupVo = self:getDupVo(cusDupId)
    for i, v in ipairs(dupVo.preIds) do
        local preDupVo = self:getDupVo(v)
        local isPass = self:getDupIsPass(v)
        if isPass == false then
            if dupVo.chapter ~= preDupVo.chapter then
                -- 前置副本不是同一章的，可能是章节第一个副本，直接判断本章节是否开放
                return self:getChapterIsOpen(dupVo.chapter)
            end
            return false
        end
    end
    return true
end

-- 副本是否已通关
function getDupIsPass(self, cusId)
    local info = self:getDupInfo(cusId)
    if info and info.roundPassTime ~= 0 then
        return true
    end
    return false
end

-- 获取该章节通关率（通关副本数量，章节总副本数）
function getChapterProgress(self, chapter)
    chapter = chapter or self:curChapter()
    local chapterVo = self:getChapterData(chapter)
    if not chapterVo then
        logError("代号·希望副本没有章节：" .. chapter)
        return 0, 0
    end
    local progress = 0
    local allCount = 0
    for i, v in ipairs(chapterVo.stageList) do
        local dupData = self:getDupVo(v)
        --if dupData.stageType == 1 then
        allCount = allCount + 1
        if self:getDupIsPass(v) then
            progress = progress + 1
        end
        --end
    end

    return progress, allCount, chapterVo:getName()
end

-- 获取该章的最短通关时间
function getChapterPassTime(self, chapter)
    chapter = chapter or self:curChapter()
    return self.mRoundFastPassTime[chapter]
    -- local chapterVo = self:getChapterData(chapter)
    -- if not chapterVo then
    --     logError("代号·希望副本没有章节：" .. chapter)
    --     return 0, 0
    -- end
    -- local time = 0
    -- for i, v in ipairs(chapterVo.stageList) do
    --     local dupInfo = self:getDupInfo(v)
    --     local dupData = self:getDupVo(v)
    --     if dupData.stageType == 1 then
    --         if dupInfo.firstPassFlag == 0 then
    --             return 0
    --         else
    --             time = time + dupInfo.histroyPassTime
    --         end
    --     end
    -- end
    -- return time
end

-- 检查章节对应奖励是否需要红点提示
function getChapterFlag(self, cusChapter)
    local chapterAwardIsCanGet = self:chapterAwardIsCanGet(cusChapter)
    if chapterAwardIsCanGet then
        return true
    end
    return false
end

function checkFlag(self)
    local isFlag = false
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CODE_HOPE)
    if isOpen then
        for i, chapterVo in ipairs(self:getBaseData()) do
            if self:getChapterFlag(chapterVo.id) then
                isFlag = true
                break
            end
        end
    end

    if not StorageUtil:getBool1(self.DUP_CODE_HOPE_NEW_SHOW) and isOpen then
        isFlag = true
    end

    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, isFlag, funcopen.FuncOpenConst.FUNC_ID_CODE_HOPE)

    return isFlag
end

-- 完成首次new
function setFinishFirstNew(self)
    if not StorageUtil:getBool1(self.DUP_CODE_HOPE_NEW_SHOW) then
        StorageUtil:saveBool1(self.DUP_CODE_HOPE_NEW_SHOW, true)
    end
end

-- 获取副本章节名和副本名
function getDupName(self, cusId)
    local dupVo = self:getDupVo(cusId)
    local chapterVo = self:getChapterData(dupVo.chapter)
    return chapterVo:getName(), dupVo:getName()
end

function getRecommandFight(self, cusId)
    local dupVo = self:getDupVo(cusId)
    return dupVo.recommandFight
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]