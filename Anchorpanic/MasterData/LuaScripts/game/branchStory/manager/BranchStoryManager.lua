module("branchStory.BranchStoryManager", Class.impl(Manager))

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
    -- 配置
    self.mChapterDic = nil
    self.mChapterList = nil
    self.mStageDic = nil

    -- 服务器数据
    -- 已领取奖励的章节id列表
    self.recAwardChapterList = {}
    -- 已通过的关卡id列表
    self.passStageList = {}

    self.lastIndex = nil
end


--------------------------------------------------------------------------------------------

-- 初始化章节配置表
function parseChapterConfig(self)
    self.mChapterDic = {}
    self.mChapterList = {}
    local baseData = RefMgr:getData("chip_branch_chapter_data")
    for chapterId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(branchStory.BranchEquipChapterVo)
        vo:parseData(chapterId, data)
        self.mChapterDic[chapterId] = vo
        table.insert(self.mChapterList, vo)
    end
    table.sort(self.mChapterList, self.__sortChapterList)
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

-- 初始化关卡配置表
function parseStageConfig(self)
    self.mStageDic = {}
    local baseData = RefMgr:getData("chip_branch_dup_data")
    for stageId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(branchStory.BranchEquipStageVo)
        vo:parseData(stageId, data)
        self.mStageDic[stageId] = vo
    end
end

-- 获取章节配置列表
function getChapterConfigList(self)
    if(not self.mChapterList)then
        self:parseChapterConfig()
    end
    return self.mChapterList
end

-- 获取章节配置vo
function getChapterConfigVo(self, chapterId)
    if(not self.mChapterDic)then
        self:parseChapterConfig()
    end
    return self.mChapterDic[chapterId]
end

-- 获取关卡配置vo
function getStageConfigVo(self, stageId)
    if(not self.mStageDic)then
        self:parseStageConfig()
    end
    return self.mStageDic[stageId]
end

-- 战斗结算界面用
function getDupName(self, stageId)
    local stageVo = self:getStageConfigVo(stageId)
    return stageVo:getName()
end

function getRecommandFight(self, cusId)
    local stageVo = self:getStageConfigVo(cusId)
    return stageVo.recommandFight
end

-- 解析服务器信息
function parseDupInfo(self, msg)
    self.recAwardChapterList = msg.gain_chapter_list
    self.passStageList = msg.pass_list
end

function isStagePass(self, stageId)
    if(table.indexof(self.passStageList, stageId) == false)then
        return false
    else
        return true
    end
end

function canStageFight(self, stageId)
    local stageVo = self:getStageConfigVo(stageId)
    local canChapterFight = self:canChapterFight(stageVo.chapterId)
    if(canChapterFight)then
        local chapterVo = self:getChapterConfigVo(stageVo.chapterId)
        local passStageId = nil
        for i = 1, #chapterVo.stageIdList do
            passStageId = chapterVo.stageIdList[i]
            local isStagePass = self:isStagePass(passStageId)
            if(not isStagePass)then
                break
            elseif(i == #chapterVo.stageIdList)then
                passStageId = nil
            end
        end
        return passStageId == stageId
    else
        return false
    end
end

function canChapterFight(self, chapterId)
    local chapterVo = self:getChapterConfigVo(chapterId)
    if(battleMap.MainMapManager:isStagePass(chapterVo.needMainStageId))then
        local canFight = 2

        for i = 1, chapterId do
            if i == 1 then
                canFight = 3
            else
                if (self:getPassStageCount(i-1) == #self.mChapterDic[i-1].stageIdList) then
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

function getPassStageCount(self, chapterId)
    local count = 0
    local chapterVo = self:getChapterConfigVo(chapterId)
    for _, stageId in pairs(chapterVo.stageIdList) do 
        if(table.indexof(self.passStageList, stageId) ~= false)then
            count = count + 1
        end
    end
    return count
end

function canRecChapterAward(self, chapterId)
    if(self:hasRecChapterAward(chapterId) == false)then
        local chapterVo = self:getChapterConfigVo(chapterId)
        local passCount = branchStory.BranchStoryManager:getPassStageCount(chapterId)
        if(passCount >= #chapterVo.stageIdList)then
            return true
        else
            return false
        end
    else
        return false
    end
end

function hasRecChapterAward(self, chapterId)
    return table.indexof(self.recAwardChapterList, chapterId)
end

function isTypeBubble(self, type)
    local isBubble = false
    if(type == branchStory.BranchStoryConst.EQUIP)then
        for _, chapterVo in pairs(self:getChapterConfigList()) do
            isBubble = self:canRecChapterAward(chapterVo.chapterId)
            if(isBubble)then
                break
            end
        end
    elseif(type == branchStory.BranchStoryConst.MAIN)then

    elseif(type == branchStory.BranchStoryConst.TACTIVS) then

    end
    return isBubble
end

function isBubble(self)
    local isBubble = false
    if(not isBubble)then
        isBubble = self:isTypeBubble(branchStory.BranchStoryConst.EQUIP)
    end
    if(not isBubble)then
        isBubble = self:isTypeBubble(branchStory.BranchStoryConst.MAIN)
    end
    if(not isBubble) then
        isBubble = self:isTypeBubble(branchStory.BranchStoryConst.TACTIVS)
    end
    return isBubble
end

function setBranchStoryReshow(self, isReshow)
    self.isReshow = isReshow
end

function getBranchStoryReshow(self)
    return self.isReshow
end

function setLastIndex(self,index)
    self.lastIndex = index
end

function getLastIndex(self)
    if self.lastIndex == nil then
        return 1
    else
        return self.lastIndex
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
