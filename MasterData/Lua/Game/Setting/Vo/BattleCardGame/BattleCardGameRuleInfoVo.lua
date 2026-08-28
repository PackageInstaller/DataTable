-------------------------------------------------------------------------------
-- 和风战牌 - 规则信息
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-16 14:24:31
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class BattleCardGameRuleInfoVo : SettingRefBase @ AutoIds.IdSetting10007
local BattleCardGameRuleInfoVo = Class('BattleCardGameRuleInfoVo', SettingRefBase)


function BattleCardGameRuleInfoVo:__init()
    ---@type integer @ 规则id
    self.ruleId = 0

    ---@type integer @ 规则类型
    self.ruleType = 0

    ---@type string @ 规则名称
    self.ruleName = ''

    ---@type string @ 规则描述
    self.ruleDescr = ''

    ---@type integer @ 规则目标id
    self.targetId = 0

    ---@type integer @ 规则目标数量
    self.targetNum = 0
end


function BattleCardGameRuleInfoVo:__delete()
    self.ruleId    = nil
    self.ruleType  = nil
    self.ruleName  = nil
    self.ruleDescr = nil
    self.targetId  = nil
    self.targetNum = nil
end


---@param row TableML.TableFileRow
---@return BattleCardGameRuleInfoVo
function BattleCardGameRuleInfoVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.ruleId    = parse_number(row, 'id')
    self.ruleType  = parse_number(row, 'type')
    self.ruleName  = parse_localizeText(row, 'name')
    self.ruleDescr = parse_localizeText(row, 'descr', true)
    self.targetId  = parse_number(row, 'targetId')
    self.targetNum = parse_number(row, 'targetNum')
    
    return self
end


return BattleCardGameRuleInfoVo
