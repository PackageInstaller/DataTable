-------------------------------------------------------------------------------
-- 和风战牌 - 收集手册
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-07-16 14:24:31
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class BattleCardGameCollectionVo : SettingRefBase @ AutoIds.IdSetting10005
local BattleCardGameCollectionVo = Class('BattleCardGameCollectionVo', SettingRefBase)


function BattleCardGameCollectionVo:__init()
    ---@type integer @ 收集id
    self.collectId = 0

    ---@type string @ 手册名字
    self.albumName = ''

    ---@type integer[] @ 卡牌列表
    self.cardList = {}

    ---@type table @ 奖励列表
    self.rewards = {}

    ---@type string @ 图标路径
    self.iconPath = ''
end


function BattleCardGameCollectionVo:__delete()
    self.collectId = nil
    self.albumName = nil
    self.cardList  = nil
    self.rewards   = nil
    self.iconPath  = nil
end


---@param row TableML.TableFileRow
---@return BattleCardGameCollectionVo
function BattleCardGameCollectionVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.collectId = parse_number(row, 'id')
    self.albumName = parse_localizeText(row, 'name')
    self.cardList  = parse_numbers(row, 'cardId')
    self.rewards   = parse_rewardData(row, 'rewardId', 'rewardNum')
    self.iconPath  = parse_pathName(row, 'picture')

    return self
end


return BattleCardGameCollectionVo
