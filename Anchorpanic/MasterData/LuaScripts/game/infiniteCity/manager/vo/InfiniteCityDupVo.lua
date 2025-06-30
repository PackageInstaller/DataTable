--[[ 
-----------------------------------------------------
@filename       : InfiniteCityDupVo
@Description    : 无限城副本配置
@date           : 2021-03-02 16:23:38
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.manager.vo.InfiniteCityDupVo', Class.impl())

function ctor(self)

    -- 随机的bossId
    self.bossId = nil
    -- 是否已通关
    self.isPass = nil
    -- 本关历史灾难最高等级
    self.topDisasterLv = nil
    -- 本关历史最高分(大于0分则已首通)
    self.topScore = nil
    -- 选择的战利品0-放弃选择
    self.selectTrophyId = nil
end

function parseData(self, cusId, cusData)
    self.id = cusId
    self.name = cusData.name
    self.stageName = cusData.state_name
    self.sort = cusData.sort
    self.needTid = cusData.need_tid
    self.needNum = cusData.need_num
    self.musicId = cusData.music_id
    self.sceneId = cusData.scene_id
    self.score = cusData.score
    self.bossData = cusData.boss_data

    self.showDrop = AwardPackManager:getAwardListById(cusData.show_drop)
    self.firstAward = AwardPackManager:getAwardListById(cusData.first_award[1])
end

function parseMsg(self, cusMsg)
    self.bossId = cusMsg.boss_id
    self.isPass = cusMsg.is_pass
    self.topDisasterLv = cusMsg.top_disaster_level
    self.topScore = cusMsg.top_score
    self.selectTrophyId = cusMsg.pass_select_buff
end

-- 获取该boss拥有的灾害列表
function getDisasterList(self, cusBossId)
    local id = cusBossId or self.bossId
    local data = self.bossData[id]
    if not data then
        logError("infinite_city_dup_data 配置表没有对应的bossId" .. id)
        return nil
    end
    return data.disaster
end

-- 获取该boss的特性列表
function getFeaturesList(self, cusBossId)
    local id = cusBossId or self.bossId
    local data = self.bossData[id]
    if not data then
        logError("infinite_city_dup_data 配置表没有对应的bossId" .. id)
        return nil
    end
    return data.features
end

-- boss技能列表
function getBossSkillList(self)
    if not self.bossId then
        return {}
    end
    local vo = monster.MonsterManager:getMonsterVo(self.bossId)
    local vo1 = monster.MonsterManager:getMonsterVo01(vo.tid)
    if not vo then
        logError(string.format("bossId%s没有配置", self.bossId))
        return {}
    end
    return vo1.skillList
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
