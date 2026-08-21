module('vision.VisionMirrorStageVo', Class.impl())

function parseData(self, id, data)
    self.stageId = id
    self.enemyList = data.mon
    self.formationId = data.formation_id
    self.firstAwardId = data.first_award
    self.m_musicId = data.music_id
    self.m_sceneId = data.scene_id
    self.suggestLevel = data.suggest_level
    self.suggestEle = data.suggest_ele
    self.posEffectId = data.pos_effect_id
    self.maxPoint = data.max_point
    self.limitPoint = data.max_point
    self.targetList = data.target_list or {}
    self.extraHeros = data.extra_hero or {}
    self.isNormal = data.is_normal
    self.indexName = data.number or id
    self.mIsLock = data.lock_formation or 0
end

function getName(self)
    return self.indexName
end

function isLock(self)
    return self.mIsLock ~= 0
end

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
