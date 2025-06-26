--[[ 
-----------------------------------------------------
@filename       : MazeDupConfigVo
@Description    : 迷宫副本配置数据
@date           : 2021-08-07 14:16:01
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('maze.MazeDupConfigVo', Class.impl())


function parseData(self, cusId, cusData)
    self.dupId = cusId
    self.cost = { cusData.need_tid, cusData.need_num }
    self.mMonsterIdList = cusData.dup_guard
    self.showAwardId = cusData.show_drop
    self.mMusicId = cusData.music_id
    self.mSceneId = cusData.scene_id
    self.mRecommandFight = cusData.recommend_force
    self.formationId = cusData.formation_id
    self.enemyList = cusData.dup_guard
    -- 推荐等级
    self.suggestLevel = cusData.suggest_level
    -- 推荐属性
    self.suggestEle = cusData.suggest_ele
    self.dupName = cusData.dup_name
    self.dupScr = cusData.dup_scr
    self.show_drop = cusData.show_drop
    self.posEffectId = cusData.pos_effect_id
end

function getMonsterIdList(self)
    return self.mMonsterIdList
end

function getMusicId(self)
    return self.mMusicId
end

function getSceneId(self)
    return self.mSceneId
end

function getRecommandFight(self)
    return self.mRecommandFight
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]