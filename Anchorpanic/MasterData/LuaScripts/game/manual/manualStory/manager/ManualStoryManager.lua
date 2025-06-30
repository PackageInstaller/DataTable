--[[ 
-----------------------------------------------------
@filename       : ManualStoryManager
@Description    : 图鉴-故事
@date           : 2023-3-6 16:23:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.manual.manualStory.manager.ManualStoryManager", Class.impl(Manager))

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

--初始化
function __init(self)
    self.mManualStoryMsgList = {}
    self.mManualStoryConfigList = {}
    self.mManualStoryConfigDic = nil
    self.mManualStoryDialogueDic = nil
    self.mManualStoryDialogueList = {}
end

-- 解析图鉴配置
function parseManualStoryConfig(self)
    self.mManualStoryConfigDic = {}
    self.mManualStoryConfigList = {}
    local baseData = RefMgr:getData("manual_story_data")
    for key, data in pairs(baseData) do
        local vo = manual.ManualStoryVo.new()
        vo:parseData(key, data)
        self.mManualStoryConfigDic[vo:getChapterId()] = vo
        table.insert(self.mManualStoryConfigList, vo)
    end
    table.sort(self.mManualStoryConfigList, function(vo1, vo2) return vo1.sort < vo2.sort end)
end

-- 解析图鉴配置
function parseManualStoryDialogueConfig(self)
    self.mManualStoryDialogueDic = {}
    self.mManualStoryDialogueList = {}
    local baseData = RefMgr:getData("manual_dialogue_data")
    for key, data in pairs(baseData) do
        local vo = manual.ManualStoryDialogueVo.new()
        vo:parseData(key, data)
        if not self.mManualStoryDialogueDic[vo.storyId] then
            self.mManualStoryDialogueDic[vo.storyId] = {}
        end
        table.insert(self.mManualStoryDialogueDic[vo.storyId], vo)
        table.insert(self.mManualStoryDialogueList, vo)
    end
    for _, list in pairs(self.mManualStoryDialogueDic) do
        table.sort(list, function(vo1, vo2) return vo1.stageId < vo2.stageId end)
    end
end
--获取子列表数据
function getStoryLitleListByChapterId(self, storyId)
    if not self.mManualStoryDialogueDic then
        self:parseManualStoryDialogueConfig()
    end
    return self.mManualStoryDialogueDic[storyId]
end

--获取总列表
function getStoryLitleList(self)
    if #self.mManualStoryDialogueList <= 0 then
        self:parseManualStoryDialogueConfig()
    end
    return self.mManualStoryDialogueList
end

--解析已解锁的故事章节
function parseManualStoryMsg(self, msg)
    if msg then
        for _, storyId in ipairs(msg.story_list) do
            if table.insert(self.mManualStoryMsgList, storyId) == false then
                table.insert(self.mManualStoryMsgList, storyId)
            end
        end
    end
end

function getIsUnlockById(self, id)
    return (table.indexof(self.mManualStoryMsgList, id) ~= false)
end

function getIsUnlockMainById(self, type)
    local isOpen = false
    for _, stageVo in ipairs(self:getStoryLitleListByChapterId(type)) do
        isOpen = self:getIsUnlockById(stageVo.stageId)
        if isOpen then
            return isOpen
        end
    end
end

function getAllHaveNew(self)
    for _, stageVo in ipairs(self:getManualStoryListByType(1)) do
        if stageVo:getIsNew() then
            return true
        end
    end
    return false
end

function getNewStateByType(self, type)
    for _, stageVo in ipairs(self:getManualStoryListByType(type)) do
        if stageVo:getIsNew() then
            return true
        end
    end
    return false
end

function getListByViewType(self, viewType)
    local list = {}
    for _, mainStoryVo in ipairs(self:getManualStoryListByType(viewType)) do
        for _, storyVo in pairs(self:getStoryLitleListByChapterId(mainStoryVo.chapterId)) do
            table.insert(list, storyVo)
        end
    end
    return list or {}
end

function getStoryLitleUnlockListByType(self, type)
    local list = {}
    for _, storyVo in pairs(self:getStoryLitleListByChapterId(type)) do
        if (self:getIsUnlockById(storyVo.stageId) ~= false) then
            table.insert(list, storyVo)
        end
    end
    return list or {}
end

function getUnlockNumByType(self, type)
    local count = 0
    local Viewtype = type and type or 1
    for _, storyVo in ipairs(self:getListByViewType(Viewtype)) do
        if (self:getIsUnlockById(storyVo.stageId)) then
            count = count + 1
        end
    end
    return math.floor(count / #self:getListByViewType(Viewtype) * 100)
end

function getUnlockSubNum(self)
    local count = 0
    local list = self:getMainStoryList()
    for _, storyVo in ipairs(list) do
        if (table.indexof(self.mManualStoryMsgList, storyVo.stageId) ~= false) then
            count = count + 1
        end
    end
    return math.floor(count / #list * 100)
end

-- 取主线列表
function getMainStoryList(self)
    local list = {}
    for _, storyVo in ipairs(self:getStoryLitleList()) do
        local chapterVo = self:getManualStoryVoByChapterId(storyVo.storyId)
        if chapterVo.type == manual.ManualStoryType.mainStory then
            table.insert(list, storyVo)
        end
    end
    return list
end

--获取故事列表通过类型
function getManualStoryListByType(self, type)
    if #self.mManualStoryConfigList <= 0 then
        self:parseManualStoryConfig()
    end
    local list = {}
    for _, storyVo in ipairs(self.mManualStoryConfigList) do
        if storyVo.type == type then
            table.insert(list, storyVo)
        end
    end
    table.sort(list, function(a, b) return a.sort < b.sort end)
    return list
end
--获取故事主章节数据
function getManualStoryVoByChapterId(self, chapterId)
    if not self.mManualStoryConfigDic then
        self:parseManualStoryConfig()
    end
    return self.mManualStoryConfigDic[chapterId]
end
-- 获取图鉴怪物配置数据
function getMonsterConfigVo(self, model)

end

-- 获取图鉴怪物配置列表
function getMonsterConfigList(self)

end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]