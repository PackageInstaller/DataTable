-- @FileName:   SandPlayStageConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.configVo.SandPlayStageConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.dupId = key
    self.mMonsterIdList = cusData.mon
    self.formationId = cusData.formation_id
    self.first_award = cusData.first_award
    self.posEffectId = cusData.pos_effect_id
    self.mIsLock = cusData.lock_formation
    self.mSceneId = cusData.scene_id
    self.suggestEle = cusData.suggest_ele
    self.suggestLevel = cusData.suggest_level
    self.extra_hero = cusData.extra_hero
    self.mMusicId = cusData.music_id
    self.enemyList = cusData.mon

    self.dup_guard_extra = cusData.dup_guard_extra
    self.describe = cusData.describe
    self.name = cusData.name
    self.hero_exp = cusData.hero_exp
    self.role_exp = cusData.role_exp
    self.cost = cusData.cost

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
