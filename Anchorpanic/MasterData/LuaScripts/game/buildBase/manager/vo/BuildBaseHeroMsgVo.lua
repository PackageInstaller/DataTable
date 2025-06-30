module("buildBase.BuildBaseHeroMsgVo", Class.impl())

function parseData(self, data)
    self.tid = data.hero_tid
    -- 入驻建筑id
    self.buildId = data.building_id
    -- --状态 1:入住 2：派遣
    -- self.workType = data.work_type
    -- 入驻位置
    self.pos = data.pos
    -- 剩余疲劳
    self.stamina = data.stamina
    -- 疲劳恢复时间
    self.staminaTime = data.stamina_time
    -- 携带技能列表 {skill_id，skill_lv}
    self.skillList = data.skill_list
end

--获得英雄技能  id lv
function getHeroSkillInfos(self)
    local skillInfo1, skillInfo2 = nil, nil
    if next(self.skillList) then
        if #self.skillList > 1 then
            skillInfo1 = {
                id = self.skillList[1].skill_id,
                lv = self.skillList[1].skill_lv
            }
            skillInfo2 = {
                id = self.skillList[2].skill_id,
                lv = self.skillList[2].skill_lv
            }
        end
        if #self.skillList < 2 then
            skillInfo1 = {
                id = self.skillList[1].skill_id,
                lv = self.skillList[1].skill_lv
            }
        end
    end
    return skillInfo1, skillInfo2
end

return _M