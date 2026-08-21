module("branchStory.BranchMainManager", Class.impl(Manager))

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
    self.mMainChapterDic = nil
    self.mMainChapterList = nil

    self.mMainStageDic = nil
    --server
    self.mMainDic = {}
end

function parseMainChapterConfig(self)
    self.mMainChapterDic = {}
    self.mMainChapterList = {}
    local baseData = RefMgr:getData("branch_story_data")
    for chapterId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(branchStory.BranchMainChapterVo)
        vo:parseData(chapterId, data)
        self.mMainChapterDic[chapterId] = vo
        table.insert(self.mMainChapterList, vo)
    end
    table.sort(self.mMainChapterList, self.__sortChapterList)
end

-- 初始化关卡配置表
function parseMainStageConfig(self)
    self.mMainStageDic = {}
    local baseData = RefMgr:getData("branch_story_dup_data")
    for stageId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(branchStory.BranchMainStageVo)
        vo:parseData(stageId, data)
        self.mMainStageDic[stageId] = vo
    end
end

function getMainChapterConfig(self)
    if (not self.mMainChapterList) then
        self:parseMainChapterConfig()
    end
    return self.mMainChapterList
end

function getMainChapterConfigById(self, stageId)
    if (not self.mMainChapterDic) then
        self:parseMainChapterConfig()
    end
    return self.mMainChapterDic[stageId]
end

function getMainStageConfigVo(self, stageId)
    if (not self.mMainStageDic) then
        self:parseMainStageConfig()
    end
    return self.mMainStageDic[stageId]
end

function isMainStagePass(self, type, stageId)
    if (table.indexof(self.mMainDic[type].pass_stage_list, stageId) == false) then
        return false
    else
        return true
    end
end

function canMainStageFight(self, type, stageId)
    local stageVo = self:getMainStageConfigVo(stageId)
    local canChapterFight = self:canMainChapterFight(stageVo.chapterId)
    if (canChapterFight) then
        local chapterVo = self:getMainChapterConfigById(stageVo.chapterId)
        local passStageId = nil
        for i = 1, #chapterVo.stageIdList do
            passStageId = chapterVo.stageIdList[i]
            local isStagePass = self:isMainStagePass(type, passStageId)
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
function canMainChapterFight(self, chapterId)
    local chapterVo = self:getMainChapterConfigById(chapterId)
    if (battleMap.MainMapManager:isStagePass(chapterVo.needMainStageId)) then
        local canFight = 2

        for i = 1, chapterId do
            if i == 1 then
                canFight = 3
            else
                if (#self.mMainDic[i - 1].pass_stage_list == #self.mMainChapterDic[i - 1].stageIdList) then
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

function canRecMainChapterAward(self, type, chapterId)
    if self.mMainDic[type] == nil then
        return false
    else
        return self.mMainDic[type].now_stage_list == chapterId
    end
end

function parseMainInfo(self, msg)
    for i = 1, #msg.info_list do
        self.mMainDic[msg.info_list[i].chapter] = msg.info_list[i]
    end
end

-- 战斗结算界面用
function getDupName(self, stageId)
    local stageVo = self:getMainStageConfigVo(stageId)
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
    elseif (type == branchStory.BranchStoryConst.Main) then
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
        isBubble = self:isTypeBubble(branchStory.BranchStoryConst.Main)
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
    local chapterVo = self:getMainChapterConfigById(chapterId)
    for _, stageId in pairs(chapterVo.stageIdList) do
        if (table.indexof(self.mMainDic[chapterId].pass_stage_list, stageId) ~= false) then
            count = count + 1
        end
    end
    return count
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
