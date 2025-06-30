--[[ 
-----------------------------------------------------
@filename       : DupImpliedManager
@Description    : 默示之境副本
@date           : 2021-07-05 11:51:33
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup.dupImplied.manager.DupImpliedManager', Class.impl(Manager))

-- 默示之境数据更新
EVENT_IMPLIED_INFO_UPDATE = "EVENT_IMPLIED_INFO_UPDATE"
-- 默示之境排行榜更新
EVENT_IMPLIED_RANK_UPDATE = "EVENT_IMPLIED_RANK_UPDATE"

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
end

-- 初始化配置表
function parseConfigData(self)
    self.mStageData = {}
    self.mDupData = {}
    self.mRewardBaseList = {}
    self.mMatrixBaseData = {}
    self.mAbnormalBaseData = {}
    self.mDifficutyBaseData = {}
    self.mDiffDataList = {}
    local baseData = RefMgr:getData('implied_data')
    for key, data in pairs(baseData) do
        local stageVo = LuaPoolMgr:poolGet(dup.DupImpliedStageVo)
        stageVo:parseData(key, data)
        self.mStageData[key] = stageVo
    end

    baseData = RefMgr:getData("implied_difficulty_data")
    for key,data in pairs(baseData) do
       local dupVo = LuaPoolMgr:poolGet(dup.DupImpliedDifficultyVo)
        dupVo:parseData(key, data)
        self.mDifficutyBaseData[key] = dupVo
    end

    baseData = RefMgr:getData('implied_dup_data')
    for key, data in pairs(baseData) do
        local dupVo = LuaPoolMgr:poolGet(dup.DupImpliedDupVo)
        dupVo:parseData(key, data)
        self.mDupData[key] = dupVo
        if not self.mDiffDataList[dupVo.diffId] then 
            self.mDiffDataList[dupVo.diffId] = dupVo.diffId
        end
    end

    baseData = RefMgr:getData('implied_reward_data')
    for key, data in pairs(baseData) do
        local rewardVo = LuaPoolMgr:poolGet(rank.RankRewardVo)
        rewardVo:parseData(key, data)
        table.insert(self.mRewardBaseList, rewardVo)
    end
    table.sort(self.mRewardBaseList, function(a, b)
        return a.leftRank < b.leftRank
    end)

    baseData = RefMgr:getData('implied_matrix_data')
    for key, data in pairs(baseData) do
        local matrixVo = LuaPoolMgr:poolGet(dup.DupImpliedMatrixVo)
        matrixVo:parseData(key, data)
        self.mMatrixBaseData[key] = matrixVo
    end

    baseData = RefMgr:getData('implied_abnormal_data')
    for key, data in pairs(baseData) do
        local matrixVo = LuaPoolMgr:poolGet(dup.DupImpliedMatrixVo)
        matrixVo:parseData(key, data)
        self.mAbnormalBaseData[key] = matrixVo
    end
end

-- 获取Buff的战力提升
function getDupImpliedBuffPowerUp(self,value,cusStageId)
    local add = 1
    local list = self:getOwnMatrixList(cusStageId)
    if list and #list > 0 then
        for i = 1, #list, 1 do
            local data = self:getMatrixBaseData(list[i])
            add = add * (1 +  data.improveEfficiency / 1000 ) 
        end
    end
    
    return math.ceil(value * add)
end

--设置当前副本难度
function setImpliedDiffId(self,diff_id)
    self.mCurdiff = diff_id
end

--获取当前副本难度
function getImpliedDiffId(self)
    return self.mCurdiff or 0
end

-- 解析默示之境基础数据
function parseImplideInfoMsg(self, msg)
    self.mDupInfo = {}
    self.mAbnormalData = {}
    self:setImpliedDiffId(msg.difficulty)
    for i, v in ipairs(msg.tower_list) do
        local vo = dup.DupImpliedInfoVo.new()
        vo:parseMsg(v)
        self.mDupInfo[vo.dupId] = vo
    end

    -- 境界携带的异常环境
    for i, v in ipairs(msg.chapter_list) do
        if not self.mAbnormalData[v.chapter_id] then
            self.mAbnormalData[v.chapter_id] = {}
        end
        self.mAbnormalData[v.chapter_id] = v.abnormal_id_list
    end
    self:dispatchEvent(self.EVENT_IMPLIED_INFO_UPDATE)
end

-- 解析默示之境战利品
function parseImliedPassSelectBuffMsg(self, msg)
    self.matrixSelectData = msg
end

-- 章节结束
function parseImpliedChapterEndMsg(self, msg)
    self.isStageEnd = true
end

-- 副本信息
function getDupInfo(self, cusId)
    return self.mDupInfo[cusId]
end

-- 获取境界的异常环境列表
function getAbnormalList(self, cusStageId)
    return self.mAbnormalData[cusStageId]
end

-- 获取开放的章节数据列表
function getOpenStageList(self)
    local data = {}
    for k, v in pairs(self.mDupInfo) do
        local dupVo = self:getDupVo(k)
        local stageVo = self:getStageData(dupVo.stage)
        if not data[dupVo.stage] then
            data[dupVo.stage] = stageVo
        end
    end
    return table.values(data)
end
-- 判断章节是否开放
function getStageIsOpen(self, cusStageId)
    local list = self:getOpenStageList()
    for _, v in pairs(list) do
        if v.id == cusStageId then
            return true
        end
    end
    return false
end

-- 章节是否已通关
function getStageIsPass(self, cusStageId)
    local dupList = self:getCurDiffStageList(cusStageId)
    for i, v in ipairs(dupList) do
        local info = self:getDupInfo(v)
        if info then
            if info.roundPassTime <= 0 then
                return false
            end
        end
    end
    return true
end

-- 计算章节通关总时间
function getStageAllTime(self, cusStageId)
    if not self:getStageIsPass(cusStageId) then
        -- 未通关
        return 0
    end
    local time = 0

    local dupList = self:getCurDiffStageList(cusStageId)
    for i, v in ipairs(dupList) do
        local info = self:getDupInfo(v)
        if info then
            time = time + info.roundPassTime
        end
    end
    return time
end

-- 获取已选择的战利品列表
function getOwnMatrixList(self, cusStageId)
    local list = {}
    local dupList = self:getCurDiffStageList(cusStageId)
    for i, v in ipairs(dupList) do
        local info = self:getDupInfo(v)
        if info.selectBuffId and info.selectBuffId > 0 then
            table.insert(list, info.selectBuffId)
        end
    end
    return list
end

-- 当前可挑战副本vo
function getCurDupVo(self, cusStageId)
    local dupList = self:getCurDiffStageList(cusStageId)
    for i, dupId in ipairs(dupList) do
        local dupVo = self:getDupVo(dupId)
        local info = self:getDupInfo(dupId)
        local preInfo = self:getDupInfo(dupVo.preId)
        if (not preInfo or preInfo.roundPassTime > 0) and info.roundPassTime <= 0 then
            return dupVo
        end
    end
    return nil
end

--是否可以重选难度
function getIsCanSelectDiffLevel(self)
    for dupId, infoVo in pairs(self.mDupInfo) do
        if infoVo.roundPassTime ~= 0 then
            return false
        end
    end

    return true
end

--获取难度Vo
function getStageDifficultyVo(self,diff_id)
    if not self.mDifficutyBaseData then 
        self:parseConfigData()
    end

    return self.mDifficutyBaseData[diff_id]
end

--获取所有难度
function getImpliedLevelList(self)
    if not self.mDiffDataList then 
        self:parseConfigData()
    end

    return self.mDiffDataList
end

-- 章节里最大的副本id
function getMaxDupId(self, cusStageId)
    local maxId = 0
    local dupList = self:getCurDiffStageList(cusStageId)
    for i, dupId in ipairs(dupList) do
        maxId = math.max(maxId, dupId)
    end
    return maxId
end

-- 获取该章节通关率（通关副本数量，章节总副本数）
function getStageProgress(self, cusStageId)
    local dupList = self:getCurDiffStageList(cusStageId)
    local progress = 0
    local allCount = #dupList
    for i, dupId in ipairs(dupList) do
        local info = self:getDupInfo(dupId)
        if info and info.roundPassTime > 0 then
            progress = progress + 1    
        end
    end
    return progress, allCount
end

--获取当前难度的关卡列表
function getCurDiffStageList(self,cusStageId)
    local list = {}
    for dupId,infoVo in pairs(self.mDupInfo) do
        local dupVo = self:getDupData()[dupId]
        if dupVo.stage == cusStageId then 
            table.insert(list,dupId)
        end
    end

    table.sort( list, function (a,b)
        return a < b
    end )

    return list
end

-- 基础数据
function getStageData(self, cusStageId)
    if self.mStageData == nil then
        self:parseConfigData()
    end
    return self.mStageData[cusStageId]
end

-- 副本数据
function getDupData(self)
    if self.mDupData == nil then
        self:parseConfigData()
    end
    return self.mDupData
end

-- 排行奖励数据
function getRewardList(self)
    if self.mRewardBaseList == nil then
        self:parseConfigData()
    end
    return self.mRewardBaseList
end

-- 获取某个副本数据
function getDupVo(self, cusId)
    local vo = self:getDupData()[cusId]
    if not vo then
        logError('DupImpliedManager', '默示之境副本不存在副本id：' .. cusId)
    end
    return vo
end

-- 获取矩阵数据
function getMatrixBaseData(self, cusId)
    if self.mMatrixBaseData == nil then
        self:parseConfigData()
    end
    return self.mMatrixBaseData[cusId]
end

--获取全部矩阵配置
function getMatrixBaseConifg(self)
    if self.mMatrixBaseData == nil then
        self:parseConfigData()
    end
    return self.mMatrixBaseData
end

-- 获取异常状态数据
function getAbnormalBaseData(self, cusId)
    return self.mAbnormalBaseData[cusId]
end

-- 获取副本章节名和副本名
function getDupName(self, cusId)
    local dupVo = self:getDupVo(cusId)
    local chapterVo = self:getStageData(dupVo.stage)
    return chapterVo:getName(), dupVo:getName()
end

function getRecommandFight(self, cusId)
    local dupVo = self:getDupVo(cusId)
    return dupVo.recommandFight
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
