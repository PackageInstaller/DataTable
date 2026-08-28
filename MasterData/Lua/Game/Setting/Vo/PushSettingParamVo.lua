local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PushSettingParamVo : SettingRefBase
local PushSettingParamVo = Class('PushSettingParamVo', SettingRefBase)


function PushSettingParamVo:__init()
    self.id    = nil  -- id
    --self.name  = nil  -- 参数名
    self.num = nil  -- 参数值
end


function PushSettingParamVo:__delete()
end


---@param row TableML.TableFileRow
function PushSettingParamVo:FillVo(row)
    SettingRefBase.FillVo(self, row)
    
    self.id    = parse_number(row, 'id')
    --self.name  = nil
    self.num = parse_string(row, 'switch')
end


return PushSettingParamVo