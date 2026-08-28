---
--- 12队副本参数表
--- Author: dawanfan
--- Date: 2024-7-8 15:25:15
---


local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---@class FairylandParameterVo
local FairylandParameterVo = Class("FairylandParameterVo", SettingRefBase)

---__int
function FairylandParameterVo:__init()
    self.id = nil              --状态ID
    self.name = nil              --参数名称
    self.num = nil              --数量
    self.status = nil              --状态
end

---FillVo
---@param row TableML.TableFileRow
function FairylandParameterVo:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.name = ParseUtils.ParseLocalizeText(row, "name")
    self.num = parse_string(row, "num")
    self.status = parse_number(row, "status")
end

function FairylandParameterVo:__delete()
    self.id = nil
    self.name = nil
    self.num = nil
    self.status = nil
end

return FairylandParameterVo
