-------------------------------------------------------------------------------
-- 和风战牌 - 参数定义
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-16 14:24:31
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class BattleCardGameComParamsVo : SettingRefBase @ AutoIds.IdSetting10008
local BattleCardGameComParamsVo = Class('BattleCardGameComParamsVo', SettingRefBase)


function BattleCardGameComParamsVo:__init()
    ---@type integer @ 参数id
    self.paramId = 0

    ---@type string @ 参数值
    self.paramValue = 0
end


function BattleCardGameComParamsVo:__delete()
    self.paramId    = nil
    self.paramValue = nil
end


---@param row TableML.TableFileRow
---@return BattleCardGameComParamsVo
function BattleCardGameComParamsVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.paramId    = parse_number(row, 'id')
    self.paramValue = parse_string(row, 'num')

    return self
end


return BattleCardGameComParamsVo
