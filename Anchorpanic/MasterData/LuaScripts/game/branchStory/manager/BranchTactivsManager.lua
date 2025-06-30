module("branchStory.BranchTactivsManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    -- 战术训练 opt
    self.mTactivsChapterDic = nil
    self.mTactivsChapterList = nil

    self.mTactivsStageDic = nil
    --server
    self.mTactivsDic = {}
    -- 已领取奖励的章节id列表
    self.recAwardChapterList = {}
end

function parseTactivsChapterConfig(self)
    self.mTactivsChapterDic = {}
    self.mTactivsChapterList = {}
    local baseData = RefMgr:getData("tactics_training_data")
    for chapterId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(branchStory.BranchTactivsChapterVo)
        vo:parseData(chapterId, data)
        self.mTactivsChapterDic[chapterId] = vo
        table.insert(self.mTactivsChapterList, vo)
    end
    table.sort(self.mTactivsChapterList, self.__sortChapterList)
end

-- 初始化关卡配置表
function parseTactivsStageConfig(self)
    self.mTactivsStageDic = {}
    local baseData = RefMgr:getData("tactics_training_dup_data")
    for stageId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(branchStory.BranchTactivsStageVo)
        vo:parseData(stageId, data)
        self.mTactivsStageDic[stageId] = vo
    end
end

function getTactivsChapterConfig(self)
    if (not self.mTactivsChapterList) then
        self:parseTactivsChapterConfig()
    end
    return self.mTactivsChapterList
end

function getTactivsChapterConfigById(self, stageId)
    if (not self.mTactivsChapterDic) then
        self:parseTactivsChapterConfig()
    end
    return self.mTactivsChapterDic[stageId]
end

function getTactivsStageConfigVo(self, stageId)
    if (not self.mTactivsStageDic) then
        self:parseTactivsStageConfig()
    end
    return self.mTactivsStageDic[stageId]
end

function isTactivsStagePass(self, type, stageId)
    if (not table.indexof(self.mTactivsDic[type].pass_stage_list, stageId)) then
        return false
    else
        return true
    end
end

function canTactivsStageFight(self, type, stageId)
    local stageVo = self:getTactivsStageConfigVo(stageId)
    local canChapterFight = self:canTactivsChapterFight(stageVo.chapterId)
    if (canChapterFight == 3) then
        local chapterVo = self:getTactivsChapterConfigById(stageVo.chapterId)
        local passStageId = nil
        for i = 1, #chapterVo.stageIdList do
            passStageId = chapterVo.stageIdList[i]
            local isStagePass = self:isTactivsStagePass(type, passStageId)
            if (not isStagePass) then
                break
            elseif (i == #chapterVo.stageIdList) then
                passStageId = nil
            end
        end
        return passStageId == stageId
    else
        return false
    end
end

-- retValue 1 -- 服务器未解锁
-- retValue 2 -- 前置章节未解锁
-- retValue 3 -- 全解锁
function canTactivsChapterFight(self, chapterId)
    local chapterVo = self:getTactivsChapterConfigById(chapterId)
    if (battleMap.MainMapManager:isStagePass(chapterVo.needMainStageId)) then
        local canFight = 2

        for i = 1, chapterId do
            if i == 1 then
                canFight = 3
            else
                if (#self.mTactivsDic[i - 1].pass_stage_list == #self.mTactivsChapterDic[i - 1].stageIdList) then
                    canFight = 3
                else
                    canFight = 2
                end
            end
        end
        return canFight
    else
        return 1
    end
end

function canRecTactivsChapterAward(self, type, chapterId)
    if self.mTactivsDic[type] == nil then
        return false
    else
        return self.mTactivsDic[type].now_stage_list == chapterId
    end
end

function parseTactivsInfo(self, msg)
    for i = 1, #msg.info_list do
        self.mTactivsDic[msg.info_list[i].chapter] = msg.info_list[i]
    end
end

-- 战斗结算界面用
function getDupName(self, stageId)
    local stageVo = self:getTactivsStageConfigVo(stageId)
    return stageVo:getName()
end

function isTypeBubble(self, type)
    local isBubble = false
    if (type == branchStory.BranchStoryConst.EQUIP) then
        for _, chapterVo in pairs(self.mChapterList) do
            isBubble = self:canRecChapterAward(chapterVo.chapterId)
            if (isBubble) then
                break
            end
        end
    elseif (type == branchStory.BranchStoryConst.MAIN) then
    elseif (type == branchStory.BranchStoryConst.TACTIVS) then
    end
    return isBubble
end

function isBubble(self)
    local isBubble = false
    if (not isBubble) then
        isBubble = self:isTypeBubble(branchStory.BranchStoryConst.EQUIP)
    end
    if (not isBubble) then
        isBubble = self:isTypeBubble(branchStory.BranchStoryConst.MAIN)
    end
    if (not isBubble) then
        isBubble = self:isTypeBubble(branchStory.BranchStoryConst.TACTIVS)
    end
    return isBubble
end

-- 章节列表按照章节id排序
function __sortChapterList(chapterVo_1, chapterVo_2)
    if (chapterVo_1 and chapterVo_2) then
        -- 章节id从小到大
        if (chapterVo_1.chapterId > chapterVo_2.chapterId) then
            return false
        end
        if (chapterVo_1.chapterId < chapterVo_2.chapterId) then
            return true
        end
    end
    return false
end

function getPassStageCount(self, chapterId)
    local count = 0
    local chapterVo = self:getTactivsChapterConfigById(chapterId)
    for _, stageId in pairs(chapterVo.stageIdList) do
        if (self:isTactivsStagePass(chapterId, stageId)) then
            count = count + 1
        end
    end
    return count
end

function hasRecChapterAward(self)
    return table.indexof(self.recAwardChapterList, chapterId)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
