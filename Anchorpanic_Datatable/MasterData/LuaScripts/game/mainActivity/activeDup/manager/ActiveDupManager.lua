-- 1.1副本活动
module("mainActivity.ActiveDupManager", Class.impl(Manager))

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
    self.mStageStepDic = nil
    self.m_stageDic = nil
    self.mStageAwardDic = nil
    -- 服务器数据

    -- -- 可以打的关卡id列表
    -- self.m_canFightStageDic = {}
    -- getStageVo
    self.m_passStageDic = {}

    self.mRecordPassStageDic = {}
    -- 已领取阶段奖励id列表
    self.mReceivedStageAwardList = {}
    -- 当前正在进行中的走地图探索关卡id
    self.mExploreStageId = nil

    -- 已经显示过的章节动画
    self.mChaterPicList = {}

    -- 章节类型
    self.style = mainActivity.ActiveDupStyleType.Easy
    -- 是否初始化完成
    self.isDataInit = false
    self.mMaxConfigStarNum = {}
    self.mNewestDupId = 0

    self.mActiveViewList = {}
end

-- 初始化星级奖励配置表
function parseStageStepConfig(self)
    self.mStageStepDic = {}
    local baseData = RefMgr:getData("activity_stage_step_data")
    for stageId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(mainActivity.ActiveDupStageStepVo)
        vo:parseData(stageId, data)
        self.mStageStepDic[stageId] = vo
        if not self.mMaxConfigStarNum[vo.stageType] then
            self.mMaxConfigStarNum[vo.stageType] = 0
        end
        self.mMaxConfigStarNum[vo.stageType] = self.mMaxConfigStarNum[vo.stageType] > vo.starNum and
                                                   self.mMaxConfigStarNum[vo.stageType] or vo.starNum
    end
end

-- 获得 关卡星级任务配置表
function getAllStepConfig(self)
    if not self.mStageStepDic then
        self:parseStageStepConfig()
    end
    return self.mStageStepDic
end

function getMsgAwardList(self)
    local list = {}
    for k, v in pairs(self:getAllStepConfig()) do
        if (v.stageType == self.style) then
            table.insert(list, v)
        end
    end
    local allStarNum = self:getAllStarNum()

    for k, v in pairs(list) do
        if self:getStageAwardByStep(v.stepId) then
            v.type = 2 -- 已领取
        else
            if v.starNum <= allStarNum then
                v.type = 0 -- 可领取
            else
                v.type = 1 -- 进行中
            end
        end

    end
    table.sort(list, function(a, b)
        if a.type == b.type then
            return a.stepId < b.stepId
        else
            return a.type < b.type
        end
    end)
    return list
end

function getStepCanRec(self, stepId)
    local allStep = self:getAllStepConfig()
    local allStarNum = self:getAllStarNum()
    return allStep[stageId].starNum <= allStarNum
end

function getCanRecAll(self)
    if not self.mStageStepDic then
        self:parseStageStepConfig()
    end

    local allStarNum = self:getAllStarNum()

    for _, taskVo in pairs(self.mStageStepDic) do
        local mAwardMsgVo = self:getStageAwardByStep(taskVo.stepId)
        if taskVo.starNum <= allStarNum and mAwardMsgVo == nil and taskVo.stageType == self.style then
            return true
        end
    end
    return false
end

function getCanRecAllByStyle(self, style)
    local isMain = sysParam.SysParamManager:getValue(SysParamType.MainActivityType) == 1
    if isMain then
        return self:getCanOpenRed(style)
    else
        if not self.mStageStepDic then
            self:parseStageStepConfig()
        end
        local red = false
        local allStarNum = self:getAllStarNumByStyle(style)
        for _, taskVo in pairs(self.mStageStepDic) do
            local mAwardMsgVo = self:getStageAwardByStep(taskVo.stepId)
            if taskVo.starNum <= allStarNum and mAwardMsgVo == nil and taskVo.stageType == style then
                return true
            end
        end
        return red or self:getCanOpenRed(style)
    end
end

function getCanOpenRed(self, style)
    local red = false
    local activityId = 0
    local isOpen = true
    local isMain = sysParam.SysParamManager:getValue(SysParamType.MainActivityType) == 1

    if isMain then
        if style == mainActivity.ActiveDupStyleType.Easy then
            activityId = activity.ActivityId.NomalLevel
        elseif style == mainActivity.ActiveDupStyleType.Difficulty then
            activityId = activity.ActivityId.DifficultyLevel
        elseif style == mainActivity.ActiveDupStyleType.Hard then
            activityId = activity.ActivityId.HellLevel
        end
    else
        if style == mainActivity.ActiveDupStyleType.Easy then
            activityId = activity.ActivityId.NomalLevel
        elseif style == mainActivity.ActiveDupStyleType.Difficulty then
            local newestDupId = mainActivity.ActiveDupManager:getNewestDupId(mainActivity.ActiveDupStyleType.Easy)
            isOpen = newestDupId >= mainActivity.ActiveDupManager:getFirstDupByStype(mainActivity.ActiveDupStyleType.Easy)
            activityId = activity.ActivityId.DifficultyLevel
        elseif style == mainActivity.ActiveDupStyleType.Hard then
            local newestDupId = mainActivity.ActiveDupManager:getNewestDupId(mainActivity.ActiveDupStyleType.Difficulty)
            isOpen = newestDupId >= mainActivity.ActiveDupManager:getFirstDupByStype(mainActivity.ActiveDupStyleType.Difficulty)
            activityId = activity.ActivityId.HellLevel
        end
    end

    

    local prefixVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)

    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activityId)
    if isOpen and activityVo:getIsCanOpen() and not StorageUtil:getBool1(prefixVersion .. "mainActivity" .. style) then
        red = true
    else
        red = false
    end
    return red
end

function parseStarConfig(self)
    self.mStarDic = {}
    self.mStarList = {}
    local baseData = RefMgr:getData("activity_stage_star_data")
    for stageId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(mainActivity.ActiveDupStarVo)
        vo:parseData(stageId, data)
        self.mStarDic[stageId] = vo
        table.insert(self.mStarList, vo)
    end
end

function getStarConfigData(self, starId)
    if not self.mStarDic then
        self:parseStarConfig()
    end
    return self.mStarDic[starId]
end

-- 章节列表按照章节id排序
function __sortStepList(stepVo_1, stepVo_2)
    if (stepVo_1 and stepVo_2) then
        return stepVo_1.stepId < stepVo_2.stepId
    end
    return false
end

-- 初始化关卡配置表
function parseStageConfig(self)
    self.m_stageDic = {}
    self.m_hellStageDic = {}
    self.styleMaxIdDic = {}
    local baseData = RefMgr:getData("activity_stage_data")
    for stageId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(mainActivity.ActiveDupStageVo)
        local hellVo = LuaPoolMgr:poolGet(mainActivity.ActiveDupStageHellVo)

        vo:parseData(stageId, data)
        hellVo:parseData(stageId, data)
        if self.styleMaxIdDic[vo.styleType] == nil or self.styleMaxIdDic[vo.styleType] < stageId then
            self.styleMaxIdDic[vo.styleType] = stageId
        end

        self.m_stageDic[stageId] = vo
        self.m_hellStageDic[stageId] = hellVo
    end
end

function getStageListByType(self, type)
    local list = {}
    for k, v in pairs(self:getStageDic()) do
        if v.styleType == type then
            table.insert(list, v)
        end
    end
    table.sort(list, function(a, b)
        return a.sort < b.sort
    end)
    return list
end

function getCurStageProgress(self, type)
    local allList = self:getStageListByType(type)
    local passNum = 0
    for index, stageVo in ipairs(allList) do
        if self:isStagePass(stageVo.stageId) then
            passNum = passNum + 1
        end
    end
    local curNum = (passNum / #allList)

    return math.ceil(curNum * 100)
end

-- 解析数据
function parseMsg(self, msg)
    for i, id in pairs(msg.received_star_id) do
        self.mReceivedStageAwardList[id] = id
    end
    self:dispatchEvent(self.EVENT_STAGE_AWARD_UPDATE)
    local isInit = next(self.mRecordPassStageDic) == nil
    for i = 1, #msg.dup_info do
        local passStageId = msg.dup_info[i].dup_id

        self.m_passStageDic[passStageId] = true

        -- 通知上报关卡信息
        if (not isInit and not self.mRecordPassStageDic[passStageId]) then
            local stageVo = self:getStageVo(passStageId)
            sdk.SdkManager:notifyRoleStagePassSuc(stageVo.stepId,
                self:getStyle() .. "-" .. string.format("%02d", stageVo.sort))
        end
        self.mRecordPassStageDic[passStageId] = msg.dup_info[i].star_list
    end
    self:dispatchEvent(self.EVENT_DUP_UPDATE)
end

function getNoRecStepStar(self, type)
    for k, v in pairs(self.mStageStepDic) do
        if v.stageType == type and self.mReceivedStageAwardList[k] == nil then
            return v.starNum
        end
    end
    return self.mMaxConfigStarNum[type]
end

function addRecAward(self, id)
    if self.mReceivedStageAwardList[id] == nil then
        self.mReceivedStageAwardList[id] = id
    end
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function updateStageInfo(self, msg)
    local dupId = msg.battle_end_dup.dup_id
    self.m_passStageDic[dupId] = true
    if (not self.mRecordPassStageDic[dupId]) then
        local stageVo = self:getStageVo(dupId)
        sdk.SdkManager:notifyRoleStagePassSuc(stageVo.stepId,
            self:getStyle() .. "-" .. string.format("%02d", stageVo.sort))
    end
    if msg.battle_end_dup.star_list ~= nil then
        local m_starList = self.mRecordPassStageDic[dupId]
        if m_starList == nil then
            self.mRecordPassStageDic[dupId] = {}
            m_starList = self.mRecordPassStageDic[dupId]
        end
        if #m_starList <= #msg.battle_end_dup.star_list then
            self.mRecordPassStageDic[dupId] = msg.battle_end_dup.star_list
        end
    end
    self:dispatchEvent(self.EVENT_DUP_UPDATE)
end

function getReceivedStageAwardList(self)
    return self.mReceivedStageAwardList
end

function getStageAwardByStep(self, stepId)
    return self.mReceivedStageAwardList[stepId]
end

function getStarListByStage(self, stageId)
    return (self.mRecordPassStageDic and self.mRecordPassStageDic[stageId]) and self.mRecordPassStageDic[stageId] or {}
end

function getAllStarNum(self)
    local allStarNum = 0
    local m_style = self:getStyle()
    if self.mRecordPassStageDic then
        for dupId, starList in pairs(self.mRecordPassStageDic) do
            local m_dupVo = self:getStageVoByDupId(dupId)
            if m_dupVo and m_dupVo.styleType == m_style then
                allStarNum = allStarNum + #starList
            end
        end
    end
    return allStarNum
end

function getAllStarNumByStyle(self, style)
    local allStarNum = 0
    local m_style = style
    if self.mRecordPassStageDic then
        for dupId, starList in pairs(self.mRecordPassStageDic) do
            local m_dupVo = self:getStageVoByDupId(dupId)
            if m_dupVo and m_dupVo.styleType == m_style then
                allStarNum = allStarNum + #starList
            end
        end
    end
    return allStarNum
end

-- 获取关卡字典
function getStageDic(self)
    if self.m_stageDic == nil then
        self:parseStageConfig()
    end
    return self.m_stageDic
end

function getStageHellDic(self)
    if self.m_hellStageDic == nil then
        self:parseStageConfig()
    end
    return self.m_hellStageDic
end

-- 获取关卡Vo
function getStageVoByDupId(self, dupId)
    if self.m_stageDic == nil then
        self:parseStageConfig()
    end
    local m_mainActivityDupVo = self.m_stageDic[dupId]
    if m_mainActivityDupVo then
        return m_mainActivityDupVo
    else
        logError("======   活动关卡dupId,不在配置表中。请检查配置, 或为非法输入  ======")
    end
end

-- 判断指定关卡是否可以打（没有打赢过且已开启的）
function isStageCanFight(self, cusStageId)
    local mDupVo = self:getStageVoByDupId(cusStageId)
    local mPreDupId = mDupVo.preIdList[1]
    if mPreDupId > 0 then
        return self.m_passStageDic[mPreDupId] ~= nil
    else
        return true
    end
end

function getNewestDupId(self, type)
    local m_style = type == nil and self:getStyle() or type
    if next(self.m_passStageDic) then
        local m_dupIdHelper = 0
        for dupId, _ in pairs(self.m_passStageDic) do
            local m_dupVo = self:getStageVo(dupId)
            if m_dupVo.styleType == m_style then
                if dupId > m_dupIdHelper then
                    m_dupIdHelper = dupId
                end
            end
        end
        return m_dupIdHelper
    else
        return 0
    end
end

function getFirstDupByStype(self, style)
    -- 2001 7001 8001
    -- local id = 2001
    -- if style == mainActivity.ActiveDupStyleType.Easy then
    --     id = self.styleMaxIdDic[style]
    -- elseif style == mainActivity.ActiveDupStyleType.Difficulty then
    --     id = 7010
    -- elseif style == mainActivity.ActiveDupStyleType.Hard then
    --     id = 8010
    -- end
    return self.styleMaxIdDic[style]
    -- return style == 0 and 1001 or 1022
end

-- 获取当前正在探索中的关卡id
function getCurExploreStageId(self)
    return self.mExploreStageId or 0
end

-- 判断指定关卡是否已通关
function isStagePass(self, cusStageId)
    return self.m_passStageDic[cusStageId]
end

-- 获取某个关卡数据
function getStageVo(self, cusStageId)
    local stageVo = self:getStageDic()[cusStageId]
    if stageVo then
        return stageVo
    else
        logError("查询的 stageId, 不在前端配置表中 " .. cusStageId)
    end
end

function getStageVoByHell(self, cusStageId)
    local stageVo = self:getStageHellDic()[cusStageId]
    if stageVo then
        return stageVo
    else
        logError("查询的 stageId, 不在前端配置表中 " .. cusStageId)
    end
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
    return self.style and self.style or mainActivity.ActiveDupStyleType.Easy
end

-- -- 修改章节难易度风格类型
-- function setStageStyle(self, style)
--     self.mStageStyle = style
-- end
-- 获取章节难易度风格类型
function getStageStyle(self)
    return self.style and self.style or mainActivity.ActiveDupStyleType.Easy
end

-- 根据关卡id获取章节vo
function getChapterVoByStageId(self, stageId)
    local stageVo = self:getStageVo(stageId)
    return stageVo
end

-- 获取额外上阵的战员列表
function getExtraHeros(self, cusId)
    local stageVo = self:getStageVo(cusId)
    return stageVo.extraHeros
end

-- 获取副本章节名和副本名
function getDupName(self, cusId)
    local stageVo = self:getChapterVoByStageId(cusId)
    return "", stageVo:getName()
end

function getRecommandFight(self, cusId)
    local stageVo = self:getChapterVoByStageId(cusId)
    return stageVo.recommendForce
end

-- 当前选中的mainMapStage
function setCurSelectMapStageId(self, stageId)
    self.mCurSelectMainStageId = stageId
end

function getCurSelectMapStageId(self)
    return self.mCurSelectMainStageId
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
