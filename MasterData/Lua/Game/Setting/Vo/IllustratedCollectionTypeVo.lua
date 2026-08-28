-------------------------------------------------------------------------------
-- 海外图鉴 - 收集类型表vo
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-04-10 16:06:19
-------------------------------------------------------------------------------

-- from: AutoIds.IdSetting913
local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class IllustratedCollectionTypeVo : SettingRefBase
local IllustratedCollectionTypeVo = Class('IllustratedCollectionTypeVo', SettingRefBase)


function IllustratedCollectionTypeVo:__init()
    ---@type string @ 类型id
    self.typeId = 0
    ---@type string @ 图标
    self.icon  = nil
    ---@type string @ 标题
    self.label = nil
    ---@type integer @ 奖励id
    self.rewardId = nil
    ---@type integer @ 奖励数量
    self.rewardNum = nil
end


function IllustratedCollectionTypeVo:__delete()
    self.typeId    = nil
    self.icon      = nil
    self.label     = nil
    self.rewardId  = nil
    self.rewardNum = nil
end


---@param row TableML.TableFileRow
function IllustratedCollectionTypeVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.typeId    = parse_number(row, 'id')
    self.icon      = parse_pathName(row, 'icon')
    self.label     = parse_localizeText(row, 'label')
    self.rewardId  = parse_number(row, 'itemId')
    self.rewardNum = parse_number(row, 'num')
end


return IllustratedCollectionTypeVo
