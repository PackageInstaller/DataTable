--[[ 
-----------------------------------------------------
@filename       : DupApostlesDataVo
@Description    : 使徒之战副本数据
@date           : 2022-06-13 10:28:47
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostles_war.manager.vo.DupApostlesDataVo', Class.impl())

-- 解析数据
function parseData(self, cusId, cusData)
    self.id = cusId
    self.bossId = cusData.boss_id
    self.enemyList = cusData.dup_guard
    self.musicId = cusData.music_id
    self.sceneId = cusData.scene_id
    self.difficultyStep = cusData.difficulty_step
    self.matrixList = cusData.matrix_list
    self.starList = cusData.star_list
    self.extraHeros = cusData.extra_hero

    self.recommandFight = cusData.recommend_force

    self.bossId = cusData.boss
    self.bossCha = cusData.boss_cha
    -- 推荐等级
    self.suggestLevel = cusData.suggest_level
    -- 推荐属性
    self.suggestEle = cusData.suggest_ele
    self.formationId = cusData.formation_id

    --战场环境id
    self.posEffectId = cusData.pos_effect_id   
    
    --是否锁着阵型
    self.mIsLock = cusData.lock_formation
    self.desc = cusData.des
end

--是否直接锁定（无关等级）
function isLock(self)
    return self.mIsLock ~= 0
end

--获取当前副本对应的阵型ID
function getFormationId(self)
    return self.mIsLock
end

function getSceneId(self)
	return self.sceneId
end

function getMusicId(self)
	return self.musicId
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
