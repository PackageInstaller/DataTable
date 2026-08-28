-------------------------------------------------------------------------------
-- 和风战牌 - 卡牌种类
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-16 14:24:31
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class BattleCardGameCardKindVo : SettingRefBase @ AutoIds.IdSetting10003
local BattleCardGameCardKindVo = Class('BattleCardGameCardKindVo', SettingRefBase)


function BattleCardGameCardKindVo:__init()
    ---@type integer @ 种类id
    self.kindId = 0

    ---@type string @ 种类名字
    self.kindName = ''
end


function BattleCardGameCardKindVo:__delete()
    self.kindId   = nil
    self.kindName = nil
end


---@param row TableML.TableFileRow
---@return BattleCardGameCardKindVo
function BattleCardGameCardKindVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.kindId   = parse_number(row, 'id')
    self.kindName = parse_localizeText(row, 'name')

    return self
end


return BattleCardGameCardKindVo
