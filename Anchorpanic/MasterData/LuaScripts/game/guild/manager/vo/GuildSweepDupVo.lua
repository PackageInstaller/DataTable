

module('guild.GuildSweepDupVo', Class.impl())
--[[ 
    主线关卡城池数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.stageId = cusId

    self.areaId = cusData.area_id

    self.difficulty = cusData.difficulty

    -- 关卡类型
    --self.type = cusData.type
    -- 敌物tid列表
    self.enemyList = cusData.dup_guard
    -- 怪物阵型ID
    self.formationId = cusData.formation_id


    self.m_musicId = cusData.music_id
    self.m_sceneId = cusData.scene_id

    -- 推荐等级
    self.suggestLevel = cusData.suggest_level
    -- 推荐属性
    self.suggestEle = cusData.suggest_ele

    --是否锁着阵型
    self.mIsLock = cusData.lock_formation

    --战场环境id
    self.posEffectId = cusData.pos_effect_id

    
    -- 额外上阵的战员列表
    self.extraHeros = cusData.extra_hero
end

function getName(self)
    return self.indexName
end

--是否直接锁定（无关等级）
function isLock(self)
    return self.mIsLock ~= 0
end

--获取当前副本对应的阵型ID
function getFormationId(self)
    return self.formationId
end

function getMusicId(self)
    return self.m_musicId
end

function getSceneId(self)
    return self.m_sceneId
end

return _M