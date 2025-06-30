module("HeroResonanceConfigVo", Class.impl())

function parseConfigData(self, pos, cusData)
    self.pos = pos

    self.type = cusData.type
    self.color = cusData.color
    self.pre_id = cusData.pre_id
    self.cost_item = cusData.cost_item
    self.pay_tid = cusData.pay_tid
    self.pay_num = cusData.pay_num
    self.title = cusData.name
    self.des = cusData.des
    self.icon = cusData.icon
    self.attr = cusData.attr
    self.skill_level = cusData.skill_level
end

function getCost(self)
    local costList = {}
    for _, cost in pairs(self.cost_item) do
        local item = {tid = cost[1], num = cost[2]}
        table.insert(costList, item)
    end

    return costList
end

function getDesc(self)
    return _TT(self.des)
end

function getIcon(self)
    if self.type == 2 then
        local skill_id = self.skill_level[1]
        local skillVo = fight.SkillManager:getSkillRo(skill_id)
        return UrlManager:getSkillIconPath(skillVo:getIcon())
    end
    return UrlManager:getIconPath(self.icon)
end

function getTitle(self)
    if self.type == 2 then
        local skill_id = self.skill_level[1]
        local skillVo = fight.SkillManager:getSkillRo(skill_id)
        return skillVo:getName()
    else
        -- return AttConst.getName(self.attr[1])
        return _TT(self.title)
    end
end

function getQualityColor(self)
    local color =
    {
        "ffffffFF",
        "ff3535FF",
        "156dffFF",
        "ec15ffFF",
        "ffb135FF",
    }

    return color[self.color + 1]
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
