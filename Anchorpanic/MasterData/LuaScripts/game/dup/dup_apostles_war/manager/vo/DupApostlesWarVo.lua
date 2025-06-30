--[[ 
-----------------------------------------------------
@filename       : DupApostlesWarVo
@Description    : 使徒之战
@date           : 2021-08-12 17:10:26
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostles_war.manager.vo.DupApostlesWarVo', Class.impl())

-- 解析数据
function parseData(self, cusId, cusData)
    self.id = cusId
    self.bossId = cusData.boss_id
    self.featuresList = cusData.features
    self.size = cusData.size

    self.m_sceneId = cusData.scene_id
end

function getFeaturesList(self)
    return self.featuresList
end

function getBossName(self)
    return self:getBossConfigVo().name
end

function getBossSkills(self)
    return self:getBossConfigVo().skillList
end

function getBossModel(self)
    return self:getBossConfigVo().model
end

function getBossConfigVo(self)
    return monster.MonsterManager:getMonsterVo01(self.bossId)
end

function getMusicId(self)
	return self.m_musicId
end

function getSceneId(self)
	return self.m_sceneId
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
