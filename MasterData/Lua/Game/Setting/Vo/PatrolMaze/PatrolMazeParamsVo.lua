-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫参数表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 11:08:20
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeParamsVo : SettingRefBase @see AutoIds.IdSetting359
local PatrolMazeParamsVo = Class('PatrolMazeParamsVo', SettingRefBase)


function PatrolMazeParamsVo:__init()
    ---@type integer @ 参数ID
    self.paramId = nil

    ---@type integer @ 参数值
    self.paramNum = nil

    ---@type string @ 参数描述
    self.paramTxt = nil
end


function PatrolMazeParamsVo:__delete()
    self.paramId  = nil
    self.paramNum = nil
    self.paramTxt = nil
end


---@param row TableML.TableFileRow
function PatrolMazeParamsVo:FillVo(row)
    SettingRefBase.FillVo(self,row)

    self.paramId  = parse_number(row, 'id')
    self.paramNum = parse_string(row, 'num')
    self.paramTxt = parse_localizeText(row, 'txt', true)
end


return PatrolMazeParamsVo
