--[[ 
-----------------------------------------------------
@filename       : FormationVo
@Description    : 阵型数据vo
@date           : 2022-03-1 20:03:20
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationVo", Class.impl())

function parseMsgData(self, pt_hero_formation)
    -- 队列id
    self.teamId = pt_hero_formation.team_id 
    -- 队列名字
    self.teamName = pt_hero_formation.name 
    -- 阵型id
    self.formationId = pt_hero_formation.formation_id
    -- 是否出战
    self.isReady = pt_hero_formation.is_ready == 1
    -- 英雄列表
    self.heroList = {}
    for i = 1, #pt_hero_formation.formation_hero_list do
        local vo = LuaPoolMgr:poolGet(formation.FormationHeroVo)
        vo:parseMsgData(pt_hero_formation.formation_hero_list[i])
        table.insert(self.heroList, vo)
    end
    -- 助战战员列表
    self.assisList = {}
    for i = 1, #pt_hero_formation.assist_fight_list do
        local vo = LuaPoolMgr:poolGet(formation.FormationAssistVo)
        vo:parseMsgData(pt_hero_formation.assist_fight_list[i])
        table.insert(self.assisList, vo)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
