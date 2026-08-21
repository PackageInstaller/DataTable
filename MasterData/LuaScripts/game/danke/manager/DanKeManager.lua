-- @FileName:   DanKeManager.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-28 15:28:41
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.manager.DanKeManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:init()
end

--初始化
function init(self)
    self.m_passStageDic = {}
    self.m_taskInfoDic = {}
    self.m_rewardInfoDic = {}
end

function getSceneConfigVo(self, map_id)
    if not self.m_mapConfigVoDic then
        self.m_mapConfigVoDic = {}
        local baseData = RefMgr:getData("danke_map_data")
        for key, data in pairs(baseData) do
            local baseVo = danke.DanKeMapConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_mapConfigVoDic[key] = baseVo
        end
    end

    return self.m_mapConfigVoDic[map_id]
end

function getHeroConfigVo(self, hero_id)
    if not self.m_heroConfigVoDic then
        self.m_heroConfigVoDic = {}
        local baseData = RefMgr:getData("danke_hero_data")
        for key, data in pairs(baseData) do
            local baseVo = danke.DanKeHeroConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_heroConfigVoDic[key] = baseVo
        end
    end

    return self.m_heroConfigVoDic[hero_id]
end

function getMonsterConfigVo(self, monster_id)
    if not self.m_monsterConfigVoDic then
        self.m_monsterConfigVoDic = {}
        local baseData = RefMgr:getData("danke_monster_data")
        for key, data in pairs(baseData) do
            local baseVo = danke.DanKeMonsterConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_monsterConfigVoDic[key] = baseVo
        end
    end

    return self.m_monsterConfigVoDic[monster_id]
end

function getStageConfigVoDic(self)
    if not self.m_stageConfigVoDic then
        self.m_stageConfigVoDic = {}
        local baseData = RefMgr:getData("danke_stage_data")
        for key, data in pairs(baseData) do
            local baseVo = danke.DanKeStageConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_stageConfigVoDic[key] = baseVo
        end
    end
    return self.m_stageConfigVoDic
end

function getStageConfigVo(self, stage_id)
    local stageConfigVoDic = self:getStageConfigVoDic()
    return stageConfigVoDic[stage_id]
end

function getPlayerSkillConfigVo(self, skill_id)
    if not self.m_weaponSkillConfigVoDic then
        self.m_weaponSkillConfigVoDic = {}
        local baseData = RefMgr:getData("danke_skill_data")
        for key, data in pairs(baseData) do
            local baseVo = danke.DanKePlayerSkillConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_weaponSkillConfigVoDic[key] = baseVo
        end
    end

    return self.m_weaponSkillConfigVoDic[skill_id]
end

function getDropConfigVo(self, drop_id)
    if not self.m_dropConfigVoDic then
        self.m_dropConfigVoDic = {}
        local baseData = RefMgr:getData("danke_drop_data")
        for key, data in pairs(baseData) do
            local baseVo = danke.DanKeDropConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_dropConfigVoDic[key] = baseVo
        end
    end

    return self.m_dropConfigVoDic[drop_id]
end

function getTaskConfigVoDic(self)
    if not self.m_taskConfigVoDic then
        self.m_taskConfigVoDic = {}
        local baseData = RefMgr:getData("danke_task_data")
        for key, data in pairs(baseData) do
            local baseVo = danke.DanKeTaskConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_taskConfigVoDic[key] = baseVo
        end
    end
    return self.m_taskConfigVoDic
end

function getRewardConfigVoDic(self)
    if not self.m_rewardConfigVoDic then
        self.m_rewardConfigVoDic = {}
        local baseData = RefMgr:getData("danke_reward_data")
        for key, data in pairs(baseData) do
            local baseVo = danke.DanKeRewardConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_rewardConfigVoDic[key] = baseVo
        end
    end
    return self.m_rewardConfigVoDic
end

function getTaskConfigVo(self, taskId)
    local taskConfigDic = self:getTaskConfigVoDic()

    return taskConfigDic[taskId]
end

function getMonsterSkillConfigVo(self, skill_id)
    if not self.m_monsterSkillConfigVoDic then
        self.m_monsterSkillConfigVoDic = {}
        local baseData = RefMgr:getData("danke_monster_skill_data")
        for key, data in pairs(baseData) do
            local baseVo = danke.DanKeMonsterSkillConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_monsterSkillConfigVoDic[key] = baseVo
        end
    end
    return self.m_monsterSkillConfigVoDic[skill_id]
end

function getStarConfigVo(self, star_id)
    if not self.m_stageStarConfigVoDic then
        self.m_stageStarConfigVoDic = {}
        local baseData = RefMgr:getData("danke_star_data")
        for key, data in pairs(baseData) do
            local baseVo = danke.DanKeStarConfigVo.new()
            baseVo:parseCogfigData(key, data)
            self.m_stageStarConfigVoDic[key] = baseVo
        end
    end
    return self.m_stageStarConfigVoDic[star_id]
end

function getStageStarByInfo(self, stage_id, kill_count, kill_monster_id)
    local star_count = 0
    local stageConfigVo = self:getStageConfigVo(stage_id)
    if stageConfigVo then
        local star_list = stageConfigVo:getStageStarConfigList()
        for _, starConfig in pairs(star_list) do
            if starConfig.type == 1 then
                if kill_count >= starConfig.param then
                    star_count = star_count + 1
                end
            elseif starConfig.type == 2 then
                if kill_monster_id == starConfig.param then
                    star_count = star_count + 1
                end
            end
        end
    end

    return star_count
end

----------------------------------------------数据
function setPassStageStar(self, stage_info)
    self.m_passStageDic[stage_info.dup_id] = stage_info.star_list
end

function getPassStageStar(self, stage_id)
    return self.m_passStageDic[stage_id]
end

function getPassStageMaxStar(self, stage_id)
    local cacheStar_list = self:getPassStageStar(stage_id)
    if not cacheStar_list then return 0 end

    local cacheMaxStar = 0
    for i = 1, #cacheStar_list do
        cacheMaxStar = cacheMaxStar + 1
    end

    return cacheMaxStar
end

function getPassAllStarCount(self)
    local star_count = 0
    for stage_id, starList in pairs(self.m_passStageDic) do
        for _, v in pairs(starList) do
            star_count = star_count + 1
        end
    end

    return star_count
end

function isPassStage(self, stage_id)
    return not table.empty(self.m_passStageDic[stage_id])
end

-- function setTaskInfo(self, taskInfo)
--     self.m_taskInfoDic[taskInfo.id] = {id = taskInfo.id, count = taskInfo.count, state = taskInfo.state}
-- end

-- function getTaskInfo(self, talkId)
--     return self.m_taskInfoDic[talkId] or {}
-- end

function setRewardState(self, reward_id)
    self.m_rewardInfoDic[reward_id] = 2
end

function getRewardState(self, reward_id)
    return self.m_rewardInfoDic[reward_id] or nil
end

--前端本地临时数据
function setStage_id(self, stage_id)
    self.m_stageId = stage_id
end

function getStage_id(self)
    return self.m_stageId
end

function getCurStageVo(self)
    if not self.m_stageId then
        return nil
    end

    return self:getStageConfigVo(self.m_stageId)
end

function getDanKeGuideRedState(self)
    if self:getDanKeActivityOpenRedState() then
        return true
    end

    if self:getDanKeTaskRedState() then
        return true
    end

    if self:getDankeStarRewardState() then 
        return true
    end

    return false
end

function getDanKeActivityOpenRedState(self)
    local lasetClickRedDt = StorageUtil:getNumber1(gstor.SANDPLAY_DANKE_OPENRED)
    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity.ActivityId.DanKe)
    if activityVo and lasetClickRedDt < activityVo.startTime then
        return true
    end

    return false
end

function getDanKeTaskRedState(self)
    for taskId, taskInfo in pairs(self.m_taskInfoDic) do
        if taskInfo.state == 0 then
            return true
        end
    end

    return false
end

function getDankeStarRewardState(self)
    local passStarCount = self:getPassAllStarCount()
    local rewardConfigDic = self:getRewardConfigVoDic()
    for rewardId, rewardConfigVo in pairs(rewardConfigDic) do
        local rewardState = self:getRewardState(rewardId)
        if rewardState == nil then
            if passStarCount >= rewardConfigVo.star_num then
                return true
            end
        end
    end

    return false
end

return _M
