-------------------------------------------------------------------------------
-- 和风战牌 - 牌组信息
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-16 14:24:31
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class BattleCardGameDeckInfoVo : SettingRefBase @ AutoIds.IdSetting10004
local BattleCardGameDeckInfoVo = Class('BattleCardGameDeckInfoVo', SettingRefBase)


function BattleCardGameDeckInfoVo:__init()
    ---@type integer @ 牌组id
    self.deckId = 0

    ---@type integer @ 解锁要求收集数量
    self.collectNum = 0

    ---@type integer @ 非队长可编入级别上限
    self.levelLimit = 0

    ---@type string @ 等级文本
    self.levelText = ''
end


function BattleCardGameDeckInfoVo:__delete()
    self.deckId     = nil
    self.collectNum = nil
    self.levelLimit = nil
    self.levelText  = nil
end


---@param row TableML.TableFileRow
---@return BattleCardGameDeckInfoVo
function BattleCardGameDeckInfoVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.deckId     = parse_number(row, 'id')
    self.collectNum = parse_number(row, 'collectNum')
    self.levelLimit = parse_number(row, 'levelLimit')
    self.levelText  = parse_localizeText(row, 'levelTxt')

    return self
end


return BattleCardGameDeckInfoVo
