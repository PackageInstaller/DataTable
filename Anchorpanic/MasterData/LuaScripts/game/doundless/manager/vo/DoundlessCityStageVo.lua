module('doundless.DoundlessCityStageVo', Class.impl())
--[[ 
    主线关卡城池数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self, cusId, cusData)
    self.stageId = cusId

    --战区id
    self.warId = cusData.war_id
    --城区id
    self.cityId = cusData.city_id
    -- 关卡顺序
    self.sort = cusData.sort
    -- 前置关卡id列表
    self.preIdList = cusData.pre_id
    -- 下一关id
    self.nextId = cusData.next_id
    -- 关卡类型
    --self.type = cusData.type
    -- 敌物tid列表
    self.enemyList = cusData.mon
    -- 怪物阵型ID
    self.formationId = cusData.formation_id

    -- 首通奖励包
    self.firstAwardId = cusData.first_award


    self.des = cusData.describe
    -- 关卡序号名：x-x
    self.indexName = cusData.number

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
    --最大积分
    self.maxPoint = cusData.max_point
    --挑战目标
    self.targetList = cusData.target_list

    --最大积分
    self.limitPoint = cusData.limit_point
    
    -- 额外上阵的战员列表
    self.extraHeros = cusData.extra_hero

    -- 是不是默认阵型
    self.isNormal = cusData.is_normal
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
    return self.mIsLock
end

function getMusicId(self)
    return self.m_musicId
end

function getSceneId(self)
    return self.m_sceneId
end

return _M