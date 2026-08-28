

local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class FashionPassParamVo
local FashionPassParamVo = Class("FashionPassParamVo", SettingRefBase)

function FashionPassParamVo:__init()
    self:CleanFields()
end

function FashionPassParamVo:__delete()
    self:CleanFields()
end

function FashionPassParamVo:CleanFields()
    self.id = nil
    self.name = nil
    self.num = nil
    self.status = nil

end

---FillVo
---@param row TableML.TableFileRow
function FashionPassParamVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, 'id') -- 状态ID
    self.name = parse_localizeText(row, 'name') -- 参数名称
    self.num = parse_string(row, 'num') -- 参数
    self.status = parse_number(row, 'status') -- 状态

end

return FashionPassParamVo
