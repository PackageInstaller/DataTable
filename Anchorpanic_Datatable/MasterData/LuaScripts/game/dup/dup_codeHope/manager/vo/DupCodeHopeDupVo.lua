--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeDupVo
@Description    : 代号·希望副本数据
@date           : 2021-05-10 15:28:01
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup.dup_codeHope.manager.vo.DupCodeHopeDupVo', Class.impl())

-- 解析数据
function parseData(self, cusId, cusData)
    self.dupId = cusId
    self.name = cusData.name
    self.stageType = cusData.stage_type
    self.stageName = cusData.stage_name
    self.chapter = cusData.chapter
    self.describe = cusData.stage_describe
    self.preIds = cusData.pre_id
    self.enemyList = cusData.mon
    self.needNum = cusData.need_num
    self.limitNum = cusData.limit_num

    self.m_musicId = cusData.music_id
    self.m_sceneId = cusData.scene_id

    self.levelRequire = cusData.level_require

    self.buffId = cusData.buff_id

    self.lineId = cusData.line_id
    self.localId = cusData.local_id
    -- 推荐等级
    self.suggestLevel = cusData.suggest_level
    -- 推荐属性
    self.suggestEle = cusData.suggest_ele
    self.formationId = cusData.formation_id

    self.firstAward = AwardPackManager:getAwardListById(cusData.first_award[1])
    self.showDrop = AwardPackManager:getAwardListById(cusData.show_drop)

    self.recommandFight = cusData.recommend_force
    
    --战场环境id
    self.posEffectId = cusData.pos_effect_id
end

function getName(self)
    return self.name
end

function getStageName(self)
    return _TT(self.stageName)
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

function getSuggestEleList(self)
    return self.suggestEle
end

-----------------------------------------------
-- 副本服务器信息
function dupInfo(self)
    return dup.DupCodeHopeManager:getDupInfo(self.dupId)
end

-- 首通标识0-从未通过1-之前通过过
function getFirstPassFlag(self)
    return self:dupInfo().firstPassFlag
end

-- 本轮通关时间 >0已通关 =0本轮未通关
function getRoundPassTime(self)
    return self:dupInfo().roundPassTime
end

-- 历史最短通关时间
function getHistroyPassTime(self)
    return self:dupInfo().histroyPassTime
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
