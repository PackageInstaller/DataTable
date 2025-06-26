module('guild.GuildBossStageDupConfigVo', Class.impl())

function parseData(self, id, cusData)
    self.dupId = id
    self.mMonsterIdList = cusData.monster_list
    self.boss_id = cusData.boss_id
    self.formationId = cusData.formation_id
    self.kill_award = cusData.kill_award
    self.posEffectId = cusData.pos_effect_id
    self.mIsLock = cusData.lock_formation
    self.mSceneId = cusData.scene_id
    self.boss_img = cusData.boss_img
    self.pos = cusData.pos
    self.suggestEle = cusData.suggest_ele
    self.suggestLevel = cusData.suggest_level
    self.extra_hero = cusData.extra_hero
    self.mMusicId = cusData.music_id
    self.enemyList = cusData.monster_list
end

function getKillAward(self)
    return AwardPackManager:getAwardListById(self.kill_award)
end

function getFormationId(self)
    return self.mIsLock
end

--是否直接锁定（无关等级）
function isLock(self)
    return self.mIsLock ~= 0
end

function getMusicId(self)
    return self.mMusicId
end

function getSceneId(self)
    return self.mSceneId
end

return _M
