--[[ 
-----------------------------------------------------
@filename       : CovenantTalentBaseVo
@Description    : 战盟天赋
@date           : 2021-06-17 15:20:33
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.covenantTalent.manager.vo.CovenantTalentBaseVo', Class.impl())

function parseData(self, cusData)
    self.id = cusData.id
    -- 解锁所需声望等阶
    self.needPrestige = cusData.need_prestige
    -- 1.普通天赋（直接填技能id）
    -- 2.攻击序列物槽位
    -- 3.防御序列物槽位
    -- 4.效果序列物槽位
    self.type = cusData.type
    self.mutex = cusData.mutex

    self.preIds = cusData.pre_id
    self.style = cusData.style

    self.skillLvlUp = {}
    for k, v in pairs(cusData.skill_levelup) do
        self.skillLvlUp[v.level] = { gene = v.gene, payId = v.pay_id, payNum = v.pay_num }
    end

    self.skillLvlAttrs = {}
    for k, v in pairs(cusData.skill_levelup) do
        for _, attr in pairs(v.skill_attr) do
            if not self.skillLvlAttrs[v.level] then
                self.skillLvlAttrs[v.level] = {}
            end
            local value = attr[3]
            if attr[2] == 1 then
                value = value / 10000
            end
            table.insert(self.skillLvlAttrs[v.level], value)
        end
    end

end

-- 天赋技能升级消耗
function getSkillLvCost(self, lvl)
    return self.skillLvlUp[lvl]
end

-- 天赋技能升级属性值列表
function getSkillLvAttrs(self, lvl)
    return self.skillLvlAttrs[lvl]
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
