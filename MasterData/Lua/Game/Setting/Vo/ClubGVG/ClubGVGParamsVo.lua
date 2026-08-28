-------------------------------------------------------------------------------
-- 社团 - 社团GVG参数表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-25 11:41:46
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class ClubGVGParamsVo : SettingRefBase @see AutoIds.IdSetting5100
local ClubGVGParamsVo = Class('ClubGVGParamsVo', SettingRefBase)


function ClubGVGParamsVo:__init()
    ---@type integer @ 参数ID
    self.paramId = nil

    ---@type string @ 参数值
    self.paramNum = nil

    ---@type string @ 参数描述
    self.paramTxt = nil
end


function ClubGVGParamsVo:__delete()
    self.paramId  = nil
    self.paramNum = nil
    self.paramTxt = nil
end


---@param row TableML.TableFileRow
function ClubGVGParamsVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.paramId  = parse_number(row, 'id')
    self.paramNum = parse_string(row, 'num')
    self.paramTxt = parse_localizeText(row, 'txt', true)
end


return ClubGVGParamsVo
