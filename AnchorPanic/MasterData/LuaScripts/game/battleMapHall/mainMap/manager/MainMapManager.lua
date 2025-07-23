module("battleMap.MainMapManager", Class.impl(Manager))

--[[ 
    主线关卡数据管理器
    @autor Jacob 
]]
-- 主线关卡信息更新
EVENT_DUP_UPDATE = "EVENT_DUP_UPDATE"
-- 主线章节滚动器选择触发
MAIN_MAP_CHAPTER_SELECT_CHANGE = "MAIN_MAP_CHAPTER_SELECT_CHANGE"
-- 主线关卡阶段奖励更新
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
    self.mStageStyle = battleMap.MainMapStyleType.Easy

    -- 是否初始化完成
    self.isDataInit = false
end

-- 初始化章节配置表
function parseChapterConfig(self)
    self.m_chapterDic = {}
    self.m_chapterList = {}
    local baseData = RefMgr:getData("main_story_chapter_data")
    for chapterId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(battleMap.MainMapChapterVo)
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
    local baseData = RefMgr:getData("main_story_stage_data")
    for stageId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(battleMap.MainMapStageVo)
        vo:parseData(stageId, data)
        self.m_stageDic[stageId] = vo
    end
end

-- 解析数据
function parseMsg(self, msg)
    self.m_canFightStageDic = {}
    for i = 1, #msg.now_stage_list do
        self.m_canFightStageDic[msg.now_stage_list[i]] = true
    end
    local isInit = self.mRecordPassStageDic == nil
    if (isInit) then
        self.mRecordPassStageDic = {}
    end
    self.m_passStageDic = {}
    for i = 1, #msg.pass_stage_list do
        local passStageId = msg.pass_stage_list[i]
        self.m_passStageDic[passStageId] = true

        -- 通知上报关卡信息
        if (not isInit and not self.mRecordPassStageDic[passStageId]) then
            local stageVo = self:getStageVo(passStageId)
            sdk.SdkManager:notifyRoleStagePassSuc(stageVo.chapter, stageVo.chapter .. "-" .. string.format("%02d", stageVo.sort))
        end
        self.mRecordPassStageDic[passStageId] = true
    end
    self.mExploreStageId = msg.ongoing_stage_id

    self.mChaterPicList = {}
    for i = 1, #msg.play_chapter_pic_list do
        self.mChaterPicList[msg.play_chapter_pic_list[i]] = true
    end
    self:dispatchEvent(self.EVENT_DUP_UPDATE)
end

-- 解析章节已领取阶段id
function parseReceivedStageAwardListMsg(self, stageList)
    self.mReceivedStageAwardList = {}
    for i, id in ipairs(stageList) do
        table.insert(self.mReceivedStageAwardList, id)
    end
    self:getIsChapterHasBubble()
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
    -- if chater > 7 then
    --     return false
    -- end
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

-- 获取章节是否有红点
function getIsChapterHasBubble(self)
    local isShowRed = false
    for styleType = 0, 1 do
        for i = 1, #self:getChapterList() do
            local chapterVo = self:getChapterList()[i]
            local progress, sum = chapterVo:getStage(styleType)
            for _, stageVo in ipairs(chapterVo:getStageVoList(styleType)) do
                if (progress >= stageVo.sort) and (#stageVo.stageAwardList > 0) and (table.indexof(self:getReceivedStageAwardList(), stageVo.stageId) == false) then
                    isShowRed = true
                    break
                end
            end
        end
    end
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, isShowRed, funcopen.FuncOpenConst.FUNC_ID_MAINMAP)
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
    return self.m_canFightStageDic[cusStageId]
end

-- 获取当前正在探索中的关卡id
function getCurExploreStageId(self)
    return self.mExploreStageId or 0
end

-- 判断指定关卡是否已通关
function isStagePass(self, cusStageId)
    -- if(cusStageId == 0)then
    --     return true
    -- else
    return self.m_passStageDic[cusStageId]
    -- end
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
    return self.style and self.style or battleMap.MainMapStyleType.Easy
end

-- 修改章节难易度风格类型
function setStageStyle(self, style)
    self.mStageStyle = style
end
-- 获取章节难易度风格类型
function getStageStyle(self)
    return self.mStageStyle and self.style or battleMap.MainMapStyleType.Easy
end

-- 根据关卡id获取章节vo
function getChapterVoByStageId(self, stageId)
    local stageVo = self:getStageVo(stageId)
    if (stageVo) then
        local chapterVo = self:getChapterVo(stageVo.chapter)
        return chapterVo, stageVo
    end
    return nil, nil

    -- local chapterList = self:getChapterList()
    -- for i = 1, #chapterList do
    --     local chapterVo = chapterList[i]
    --     local isBelong = chapterVo:isStageBelongChapter(stageVo)
    --     if (isBelong) then
    --         return chapterVo, stageVo
    --     end
    -- end
    -- return nil, nil
end

-- 主线当前可打关卡
function getMainMapCurStage(self)
    local stageId = -1
    local style = self.style and self.style or battleMap.MainMapStyleType.Easy
    for k, v in pairs(self.m_canFightStageDic) do
        local stageVo = battleMap.MainMapManager:getStageVo(k)
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

-- 主页面展示主线数据
function getMainMapShowStage(self)
    local stageId = -1
    local style = battleMap.MainMapStyleType.Easy
    for k, v in pairs(self.m_canFightStageDic) do
        local stageVo = battleMap.MainMapManager:getStageVo(k)
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
            if (chapterVo and stageVo and stageVo.styleType == style) then
                stageId = math.max(k, stageId)
            end
        end
    end
    return stageId
end

function getMaxChapterStageId(self)
    local stageId = 0
    local style = battleMap.MainMapStyleType.Easy
     -- 没有当前可打关卡，则遍历返回配置的最大关卡
     for k, v in pairs(self:getStageDic()) do
        local chapterVo, stageVo = self:getChapterVoByStageId(k)
        if (chapterVo and stageVo and stageVo.styleType == style) then
            stageId = math.max(k, stageId)
        end
    end
    return stageId
end

-- 获取当前类型关卡进度
function getCurTypeStageTd(self, type)
    local stageId = -1
    local style = type and type or battleMap.MainMapStyleType.Easy
    for k, v in pairs(self.m_canFightStageDic) do
        local stageVo = battleMap.MainMapManager:getStageVo(k)
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

function getMainMapProgress(self,type)
    local allCount = 0
    local passCount = 0

    local dic = self:getStageDic()
    for id, vo in pairs(dic) do
        if vo.chapter ==  sysParam.SysParamManager:getValue(SysParamType.MainActivityChapter) and vo.styleType == type then
            allCount = allCount + 1
            if(self:isStagePass(id)) then
                passCount = passCount + 1
            end
        end
    end
    return  math.ceil(passCount / allCount * 100) 
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]