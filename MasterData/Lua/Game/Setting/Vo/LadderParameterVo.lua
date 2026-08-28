-------------------------------------------------------------------------------
-- 天梯竞技 - 参数表结构
-- 
-- Author: fengtu
-- 
-- Create: 2022-08-08 16:16:28
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class LadderParameterVo : SettingRefBase
local LadderParameterVo = Class('LadderParameterVo', SettingRefBase)


function LadderParameterVo:__init()
    self.id    = nil  -- id
    --self.name  = nil  -- 参数名
    self.num = nil  -- 参数值
end


function LadderParameterVo:__delete()
end


---@param row TableML.TableFileRow
function LadderParameterVo:FillVo(row)
    SettingRefBase.FillVo(self, row)
    
    self.id    = parse_number(row, 'id')
    --self.name  = nil
    self.num = parse_string(row, 'num')
end


return LadderParameterVo
