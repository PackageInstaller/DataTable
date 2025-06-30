module("battleMap.FragmentMapManager", Class.impl(Manager))

--[[ 
    支线关卡数据管理器
    @autor Jacob 
]]
-- 支线关卡信息更新
EVENT_DUP_UPDATE = "EVENT_DUP_UPDATE"
-- 支线章节滚动器选择触发
-- MAIN_MAP_CHAPTER_SELECT_CHANGE = "MAIN_MAP_CHAPTER_SELECT_CHANGE"
-- 支线关卡阶段奖励更新
EVENT_STAGE_AWARD_UPDATE = "EVENT_STAGE_AWARD_UPDATE"

-- 构造函数
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
    -- 当前进入界面默认显示的难易度风格类型
    self.style = nil
    -- 配置
    self.m_chapterDic = nil
    self.m_chapterList = nil
    self.m_stageDic = nil
    self.mStageAwardDic = nil
    -- 服务器数据
    -- 可以打的关卡id列表
    self.m_canFightStageDic = {}
    -- 已通过的关卡id列表
    self.m_passStageDic = {}
    self.mRecordPassStageDic = nil
    --已领取阶段奖励id列表
    self.mReceivedStageAwardList = {}
    -- 当前正在进行中的走地图探索关卡id
    self.mExploreStageId = nil

    --已经显示过的章节动画
    self.mChaterPicList = {}

    --章节类型
    self.mStageStyle = battleMap.FragmentMapStyleType.Easy

    -- 是否初始化完成
    self.isDataInit = false
    self.mNowSelectChapter = 1 
    -- 已消耗的解锁章节次数 
    self.mUnlockTime = 0
end

function setNowSelectChapter(self, id)
    self.mNowSelectChapter = id  
    GameDispatcher:dispatchEvent(EventName.UPDATA_FRAGMENT_CHAPTERVIEW, self.mNowSelectChapter)
end

function getNowSelectChapter(self)
    return self.mNowSelectChapter
end

-- 初始化章节配置表
function parseChapterConfig(self)
    self.m_chapterDic = {}
    self.m_chapterList = {}
    local baseData = RefMgr:getData("story_chapter_data")
    for chapterId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(battleMap.FragmentMapChapterVo)
        vo:parseData(chapterId, data)
        self.m_chapterDic[chapterId] = vo
        table.insert(self.m_chapterList, vo)
    end
    table.sort(self.m_chapterList, self.__sortChapterList)
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
    self.m_stageDic = {}
    local baseData = RefMgr:getData("story_stage_data")
    for stageId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(battleMap.FragmentMapStageVo)
        vo:parseData(stageId, data)
        self.m_stageDic[stageId] = vo
    end
end

-- 解析数据
function parseMsg(self, msg)
    self.mUnlockTime = msg.unlock_times
    self.m_canFightStageDic = {}
    for i = 1, #msg.chapter_list do
        local vo = LuaPoolMgr:poolGet(battleMap.FragmentMapMsgChapterVo)
        vo:parseData(msg.chapter_list[i])
        self.m_canFightStageDic[vo.chapterId] = vo
    end
    self:getIsChapterHasBubble()
    GameDispatcher:dispatchEvent(EventName.UPDATA_FRAGMENT_CHAPTERVIEW, self.mNowSelectChapter)
end

function unLockChapter(self, msg)
    self.mUnlockTime = self.mUnlockTime + 1
    local vo = LuaPoolMgr:poolGet(battleMap.FragmentMapMsgChapterVo)
    vo:parseData({chapter_id = msg.chapter_id, pass_list = {}})
    self.m_canFightStageDic[vo.chapterId] = vo

    local name = _TT(self:getChapterDic()[vo.chapterId].m_name)
    gs.Message.Show(string.substitute("解锁章节{0}", name))
    self:getIsChapterHasBubble()
    GameDispatcher:dispatchEvent(EventName.UPDATA_FRAGMENT_CHAPTERVIEW, msg.chapter_id)
end

function updateChapter(self, msg)
    self.m_canFightStageDic[msg.chapter_info.chapter_id]:parseData(msg.chapter_info)
    GameDispatcher:dispatchEvent(EventName.UPDATA_FRAGMENT_CHAPTERVIEW, msg.chapter_info.chapter_id)
end

function getChapterComplete(self, chapterId)
    if not self:getChapterIsLock(chapterId) then 
        local nowPassNum = #self.m_canFightStageDic[chapterId].passList
        local allStageNum = #self:getChapterVo(chapterId).m_stageIdList
        return nowPassNum >= allStageNum
    end
    return false
end

function getChapterIsLock(self, chapterId)
    return self.m_canFightStageDic[chapterId] == nil
end

-- 解析章节已领取阶段id
function parseReceivedStageAwardListMsg(self, stageList)
    self.mReceivedStageAwardList = {}
    for i, id in ipairs(stageList) do
        table.insert(self.mReceivedStageAwardList, id)
    end
    
    self:dispatchEvent(self.EVENT_STAGE_AWARD_UPDATE)
end

function getReceivedStageAwardList(self)
    return self.mReceivedStageAwardList
end

function updateChaterPic(self, msg)
    self.mChaterPicList[msg.chapter_id] = true
end

--是否可以播放章节动画
function canChaterPic(self, chater)
    if chater > 3 then
        return false
    end
    return self.mChaterPicList[chater] == nil
end

-- 获取章节字典
function getChapterDic(self)
    if self.m_chapterDic == nil then
        self:parseChapterConfig()
    end
    return self.m_chapterDic
end

-- 获取章节列表
function getChapterList(self)
    if self.m_chapterList == nil then
        self:parseChapterConfig()
    end
    return self.m_chapterList
end

-- 获取某一章是否有红点
function getChapterRed(self, chapterId)
    local isShowRed = not read.ReadManager:isModuleRead(ReadConst.FRAGMENTS, chapterId) -- not self:getChapterIsLock(chapterId)
    -- isShowRed = isShowRed and not read.ReadManager:isModuleRead(ReadConst.FRAGMENTS, chapterId)
    return isShowRed

end

-- 获取章节是否有红点
function getIsChapterHasBubble(self)
    local isShowRed = false
    for k,v in pairs(self:getChapterDic()) do
        isShowRed = self:getChapterRed(k)
        if isShowRed then 
            break
        end
    end 
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, isShowRed, funcopen.FuncOpenConst.FUNC_ID_FRAGMENTMAP)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FRAGMENT_RED)
    return isShowRed
end

-- 获取关卡字典
function getStageDic(self)
    if self.m_stageDic == nil then
        self:parseStageConfig()
    end
    return self.m_stageDic
end

-- 判断指定关卡是否可以打（没有打赢过且已开启的）
function isStageCanFight(self, cusStageId)
    local configPassList = self:getChapterVo(self.mNowSelectChapter).m_stageIdList
    local index = table.indexof(configPassList, cusStageId)
    if index then 
        local passList = self.m_canFightStageDic[self.mNowSelectChapter].passList
        return index - #passList == 1
    end
    return false
end

-- 判断指定关卡是否已通关
function isStagePass(self, cusStageId)
    local passList = self.m_canFightStageDic[self.mNowSelectChapter].passList
    return table.indexof(passList, cusStageId)
end

-- 获取某个关卡数据
function getStageVo(self, cusStageId)
    local stageDic = self:getStageDic()
    return stageDic[cusStageId]
end

-- 获取某个章节数据
function getChapterVo(self, cusChapterId)
    local chapterDic = self:getChapterDic()
    return chapterDic[cusChapterId]
end

function setStyle(self, style)
    self.style = style
end

-- 获取难易度风格类型
function getStyle(self)
    return self.style and self.style or battleMap.FragmentMapStyleType.Easy
end

-- 修改章节难易度风格类型
function setStageStyle(self, style)
    self.mStageStyle = style
end
-- 获取章节难易度风格类型
function getStageStyle(self)
    return self.mStageStyle and self.style or battleMap.FragmentMapStyleType.Easy
end

-- 根据关卡id获取章节vo
function getChapterVoByStageId(self, stageId)
    local stageVo = self:getStageVo(stageId)
    if (stageVo) then
        local chapterVo = self:getChapterVo(stageVo.chapter)
        return chapterVo, stageVo
    end
    return nil, nil
end

-- 获取当前类型关卡进度
function getCurTypeStageTd(self, type)
    local stageId = -1
    local style = type and type or battleMap.FragmentMapStyleType.Easy
    for k, v in pairs(self.m_canFightStageDic) do
        local stageVo = self:getStageVo(k)
        if stageVo and not self.m_passStageDic[k] and stageVo.styleType == style then
            stageId = stageVo.stageId
        end
    end
    if (stageId == -1) then
        for k, v in pairs(self.m_passStageDic) do
            local chapterVo, stageVo = self:getChapterVoByStageId(k)
            if stageVo.styleType == style then
                stageId = math.max(k, stageId)
            end
        end
    end
    if (stageId == -1) then
        -- 没有当前可打关卡，则遍历返回配置的最大关卡
        for k, v in pairs(self:getStageDic()) do
            local chapterVo, stageVo = self:getChapterVoByStageId(v)
            if (chapterVo and stageVo) then
                stageId = math.max(k, stageId)
            end
        end
    end
    return stageId
end

-- 获取额外上阵的战员列表
function getExtraHeros(self, cusId)
    local stageVo = self:getStageVo(cusId)
    return stageVo.extraHeros
end

-- 获取副本章节名和副本名
function getDupName(self, cusId)
    local chapterVo, stageVo = self:getChapterVoByStageId(cusId)
    return chapterVo:getName(), stageVo:getName()
end

function getRecommandFight(self, cusId)
    local chapterVo, stageVo = self:getChapterVoByStageId(cusId)
    return stageVo.recommendForce
end

--当前选中的mainMapStage
function setCurSelectMapStageId(self,stageId)
    self.mCurSelectMainStageId = stageId
end

function getCurSelectMapStageId(self)
    return self.mCurSelectMainStageId
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]