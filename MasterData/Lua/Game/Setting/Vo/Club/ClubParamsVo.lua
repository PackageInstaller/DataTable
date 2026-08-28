-------------------------------------------------------------------------------
-- 社团 - 社团参数表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-25 11:41:46
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class ClubParamsVo : SettingRefBase @see AutoIds.IdSetting6001
local ClubParamsVo = Class('ClubParamsVo', SettingRefBase)


function ClubParamsVo:__init()
    ---@type integer @ 参数id
    self.paramId = nil
    ---@type integer @ 参数值
    self.paramNum = nil
end


function ClubParamsVo:__delete()
    self.paramId  = nil
    self.paramNum = nil
end


---@param row TableML.TableFileRow
function ClubParamsVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.paramId  = parse_number(row, 'id')
    self.paramNum = parse_number(row, 'num')
end


return ClubParamsVo
