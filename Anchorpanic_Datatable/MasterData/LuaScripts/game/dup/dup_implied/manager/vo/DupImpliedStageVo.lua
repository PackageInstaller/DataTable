--[[ 
-----------------------------------------------------
@filename       : DupImpliedStageVo
@Description    : 默示之境章节数据
@date           : 2021-07-07 11:50:08
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_implied.manager.vo.DupImpliedStageVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.name = cusData.name
    self.dupList = cusData.stage
    self.imgId = cusData.image_id
    -- self.abnormalData = {}
    -- for k, v in pairs(cusData.abnormal_environment) do
    --     local vo = dup.DupImpliedTrophyVo.new()
    --     vo:parseData(key, v)
    --     self.abnormalData[key] = vo
    -- end
end

function getName(self)
    return _TT(self.name)
end

-- 异常携带的buff
-- function getAbnormalVo(self, cusId)
--     return self.abnormalData[cusId]
-- end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
