local SettingRefBase = require('Game.Setting.SettingRefBase')

---@class UIBattlingSkillCardVo
local UIBattlingSkillCardVo = Class("UIBattlingSkillCardVo", SettingRefBase)
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

local EffectCount = 7

function UIBattlingSkillCardVo:__init()
    self.skillId = nil -- 技能 Id
    self.skillName = nil -- 技能名称
    self.skillDesc_1 = nil -- 技能描述1
    self.skillDesc_2 = nil -- 技能描述2
    self.skillDesc_3 = nil -- 技能描述3
    self.skillDesc_4 = nil -- 技能描述4
    self.skillComboType = 0 -- 技能连协类型
    self.skillType = 0 -- 技能类型（1、buff 2、进攻3、debuff 4、恢复）
    self.skillIconPath = nil -- 技能 Icon 路径
    self.skillClickType = 0 -- 技能释放类型（1 友方 2敌方 3全体4自身）
    self.skillIndex = 0 -- 技能 序号(1:普通,2:高级,3:大招)
    self.damageEffect = nil
    self.effect1 = nil
    self.effect2 = nil
    self.effect3 = nil
    self.effect4 = nil
    self.functionLabel = nil
    self.skillStarMax = nil
end

function UIBattlingSkillCardVo:__delete()
    self.skillId = nil
    self.skillName = nil
    self.skillDesc_1 = nil
    self.skillDesc_2 = nil
    self.skillDesc_3 = nil
    self.skillDesc_4 = nil
    self.skillComboType = nil
    self.skillType = nil
    self.skillIconPath = nil
    self.skillClickType = nil
    self.skillIndex = nil
    self.damageEffect = nil
    self.effect1 = nil
    self.effect2 = nil
    self.effect3 = nil
    self.effect4 = nil
    self.functionLabel = nil
    self.skillStarMax = nil
end

---FillVo
---@param row TableML.TableFileRow
function UIBattlingSkillCardVo:FillVo(row)
    base.FillVo(self, row)
    local _parseLocalizeText = ParseLocalizeText
    self.skillName = _parseLocalizeText(row, "skillName")
    self.skillDesc_1 = _parseLocalizeText(row, "skillDesc1", '')
    self.skillDesc_2 = _parseLocalizeText(row, "skillDesc2", '')
    self.skillDesc_3 = _parseLocalizeText(row, "skillDesc3", '')
    self.skillDesc_4 = _parseLocalizeText(row, "skillDesc4", '')
    self.descOther = ""
    -- self.skillComboType = parse_number(row, "involvedPosition", 0)
    self.label = parse_number(row, "label", 0)
    -- self.skillClickType = parse_number(row, "clickType", 0)
    self.damageTarget = parse_number(row, "damageTarget", 0)
    for i = 1, EffectCount do
        local targetName = string.format("effectTarget%s", i)
        self[targetName] = parse_number(row, targetName, 0)
    end
    self.damageEffect = parse_number(row, "damageEffect", 0)
    for i = 1, EffectCount do
        local effectName = string.format("effect%s", i)
        self[effectName] = parse_number(row, effectName, 0)
    end
    
    self.skillId = parse_number(row, "skillId", 0)
    self.skillType = parse_number(row, "skillType", 0)
    self.skillIconPath = {}
    -- local skillPathInConfig = string.format("%s.png",ParseUtils.ParsePathName(row, "icon", ""))
    -- table.insert(self.skillIconPath, skillPathInConfig)
    self.functionLabel = 0 --TODO 等待配表引用添加
    self.skillStarMax = parse_number(row, "skillStarMax",0)
end

return UIBattlingSkillCardVo