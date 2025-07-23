--[[ 
-----------------------------------------------------
@filename       : FormationTeamVo
@Description    : 阵型队列数据vo
@date           : 2022-03-1 20:03:20
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationTeamVo", Class.impl())

function setData(self, teamId, formationId, teamName, petId)
    -- 队列id
    self.teamId = teamId
    -- 当前的阵型id
    self.formationId = formationId
    -- 队列名字
    self.teamName = teamName
    -- 宠物id
    self.petId = petId
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
