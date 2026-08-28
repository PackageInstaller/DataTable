-------------------------------------------------------------------------------
-- 社团 - 社团等级经验表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-25 11:22:17
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class ClubLevelVo : SettingRefBase @see AutoIds.IdSetting6003
local ClubLevelVo = Class('ClubLevelVo', SettingRefBase)


function ClubLevelVo:__init()
    ---@type integer @ 社团等级
    self.level = nil
    ---@type integer @ 升级所需经验值（总经验需要自己累加）
    self.expNum = nil
    ---@type integer @ 人数上限
    self.members = nil
end


function ClubLevelVo:__delete()
    self.level   = nil
    self.expNum  = nil
    self.members = nil
end


---@param row TableML.TableFileRow
function ClubLevelVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.level   = parse_number(row, 'level')
    self.expNum  = parse_number(row, 'exp')
    self.members = parse_number(row, 'maxNum')
end


return ClubLevelVo
