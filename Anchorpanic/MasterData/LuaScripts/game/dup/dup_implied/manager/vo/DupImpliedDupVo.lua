--[[ 
-----------------------------------------------------
@filename       : DupImpliedDupVo
@Description    : 默示之境副本数据
@date           : 2021-07-05 19:59:04
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_implied.manager.vo.DupImpliedDupVo', Class.impl())

-- 解析数据
function parseData(self, cusId, cusData)
    self.dupId = cusId
    self.name = cusData.name
    self.stageName = cusData.stage_name
    self.stage = cusData.area_id
    self.sort = cusData.sort
    self.preId = cusData.pre_id
    self.mon = cusData.mon
    self.needTid = cusData.need_tid
    self.needNum = cusData.need_num
    self.limitNum = cusData.limit_num
    self.diffId = cusData.difficulty

    self.m_musicId = cusData.music_id
    self.m_sceneId = cusData.scene_id

    self.showDrop = AwardPackManager:getAwardListById(cusData.drop[1])

    self.recommandFight = cusData.recommend_force
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

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
