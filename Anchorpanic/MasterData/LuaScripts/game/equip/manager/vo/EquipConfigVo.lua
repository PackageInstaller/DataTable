module("equip.EquipConfigVo", Class.impl())

function ctor(self)
end

function parseConfigData(self, cusTid, cusData)
    self.tid = cusTid
    self.suitId = cusData.suit
    -- 技能id（部分装备才有）
    self.skillId = cusData.skill
    -- 1级的默认技能效果
    self.defaultSkillDes = cusData.skill_des
    -- 1级的默认属性
    self.defaultAttrList = cusData.bracelets_attr

    self.skill_des = cusData.skill_des

    self.nuclearAttrDic = {}
    -- for index, data in pairs(cusData.nuclear_attr) do
    -- 	self.nuclearAttrDic[data.key] = {minValue = data.value_min, maxValue = data.value_max, des = data.describe}
    -- end
end

-- 获取核能属性描述
function getNuclearAttrDes(self, attrVo)
    local vo = self.nuclearAttrDic[attrVo.key]
    if (vo) then
        local colorStr = ""
        if (attrVo.value >= vo.maxValue) then
            colorStr = ColorUtil.RED_NUM
        else
            colorStr = ColorUtil.BLUE_NUM
        end
        local des = ""
        if (AttConst.isAttrPercent(attrVo.key)) then
            des = string.substitute(vo.des, HtmlUtil:color(AttConst.getPreciseDecimal(attrVo.value / 100, 1), colorStr))
        else
            des = string.substitute(vo.des, HtmlUtil:color(attrVo.value, colorStr))
        end

        return des
    end
    return "xx"
end

-- 获取核能属性的当前值显示及范围区间字符串
function getNuclearAttrRange(self, attrVo)
    local vo = self.nuclearAttrDic[attrVo.key]
    local des = "xx"
    if (vo) then
        local colorStr = ""
        if (attrVo.value >= vo.maxValue) then
            colorStr = ColorUtil.RED_NUM
        else
            colorStr = ColorUtil.BLUE_NUM
        end
        des = HtmlUtil:color(AttConst.getValueStr(attrVo.key, attrVo.value), colorStr) .. "(" .. AttConst.getValueStr(attrVo.key, vo.minValue) .. "~" .. AttConst.getValueStr(attrVo.key, vo.maxValue) .. ")"
    end
    return des
end

function getIsNew(self)
    return read.ReadManager:isModuleRead(ReadConst.MANUAL_BRACELET, self.tid)
end

-- 技能说明
function getSkillDesc(self)
    return self.skill_des
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]