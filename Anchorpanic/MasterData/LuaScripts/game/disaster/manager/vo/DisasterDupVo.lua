module('disaster.DisasterDupVo', Class.impl())
--[[ 
    主线关卡城池数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.dupId = cusId

    --战区id
    self.difficulty = cusData.difficulty

    -- 关卡类型
    --self.type = cusData.type
    -- 敌物tid列表
    self.enemyList = cusData.dup_guard

    --bossId
    self.bossId = cusData.boss_id
    --背景图
    self.img = cusData.img 
    --boss半身像
    self.bossImg = cusData.boss_img 
    
    -- 怪物阵型ID
    self.formationId = cusData.formation_id

    -- 首通奖励包
    self.firstAwardId = cusData.first_award

    self.m_musicId = cusData.music_id
    self.m_sceneId = cusData.scene_id

    -- 推荐等级
    self.suggestLevel = cusData.suggest_level
    -- 推荐属性
    self.suggestEle = cusData.suggest_ele
    --战场环境id
    self.posEffectId = cusData.pos_effect_id
end


--获取当前副本对应的阵型ID
function getFormationId(self)
    return self.mIsLock
end

function getMusicId(self)
    return self.m_musicId
end

function getSceneId(self)
    return self.m_sceneId
end

return _M