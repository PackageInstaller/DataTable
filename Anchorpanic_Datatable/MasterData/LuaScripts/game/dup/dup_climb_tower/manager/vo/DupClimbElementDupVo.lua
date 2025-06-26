module('dup.DupClimbElementDupVo', Class.impl())
--[[ 
    爬塔副本副本数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.dupId = cusId
    self.areaId = cusData.tower_id
    self.name = cusData.name
    self.describe = cusData.describe
    self.pre_id = cusData.pre_id
    self.next_id = cusData.next_id
    self.formationId = cusData.formation_id
    self.firstAward = AwardPackManager:getAwardListById(cusData.first_award)
    self.m_sceneId = cusData.scene_id
    self.pointLine = cusData.point_line
    self.eleType = cusData.ele_type
    self.eleTypeNum = cusData.ele_type_num
    self.enemyList = cusData.mon
    -- self.support_skill = cusData.support_skill
    -- self.recommend_force = cusData.recommend_force
    -- self.stageName = cusData.stage_name
    -- self.m_musicId = cusData.music_id

    --bossId
    self.bossId = cusData.boss_id 
    --boss特性
    self.bossCha = cusData.boss_cha

    self.suggestLevel = cusData.suggest_level
    self.suggestEle = cusData.suggest_ele
    self.formationId = cusData.formation_id

    --战场环境id
    self.posEffectId = cusData.pos_effect_id
    --是否锁着阵型
    self.mIsLock = cusData.lock_formation
    self.extraHeros = cusData.extra_hero
    self.layer = cusData.layer
end

--是否直接锁定（无关等级）
function isLock(self)
    return self.mIsLock ~= 0
end

--获取当前副本对应的阵型ID
function getFormationId(self)
    return self.mIsLock
end

function getBossId(self)
    return self.bossId
end

function getBossCha(self)
    return self.bossCha
end

function getName(self)
    return _TT(self.name)
end

function getDescribe(self)
    return _TT(self.describe)
end

function getMusicId(self)
    return self.m_musicId
end

function getSceneId(self)
    return self.m_sceneId
end

--获取边境映射名字
function getStageName(self)
    return self.stageName
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
