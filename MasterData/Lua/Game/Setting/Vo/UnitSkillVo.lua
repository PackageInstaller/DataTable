local SettingRefBase = require('Game.Setting.SettingRefBase')

---@class UnitSkillVo
local UnitSkillVo = {}
UnitSkillVo = Class("UnitSkillVo", SettingRefBase)

local ParseUtils = CS.ParseUtils
local base = SettingRefBase

function UnitSkillVo:Init()
    self.skillId = nil
    self.startUnit = nil    --起始合卡次数
    self.compose = nil
    self.unlockType = nil
    self.unlockId = nil
    self.sort = nil
    self.typeOne = nil
    self.typeOneColor = nil
    self.typeTwo = nil
    self.typeTwoColor = nil

    self.photoPath = nil  --合卡技能图片路径
    self.photo2Path = nil  --合卡技能图片路径
    self.photo3Path = nil  --合卡技能图片路径

    self.status = nil
end

function UnitSkillVo:__init()
    self:Init()
end

---FillVo
---@param row TableML.TableFileRow
function UnitSkillVo:FillVo(row)
    base.FillVo(self, row)
    self.skillId = parse_number(row, "skillId", 0)
    self.startUnit = parse_number(row, "compose", 0)
    self.unlockType = parse_string(row, "unlockType", "")
    self.unlockId = parse_string(row, "unlockId", "")
    self.photoPath = ParseUtils.ParsePathName(row, "photoPath")
    self.photo2Path = ParseUtils.ParsePathName(row, "photo2Path")
    self.photo3Path = ParseUtils.ParsePathName(row, "photo3Path")

    self.sort = parse_number(row, "sort")
    self.typeOne = parse_localizeText(row, "typeOne")
    self.typeOneColor = parse_number(row, "typeOneColor")
    self.typeTwo = parse_localizeText(row, "typeTwo")
    self.typeTwoColor = parse_number(row, "typeTwoColor")

    self.status = parse_number(row, "status")
end

function UnitSkillVo:__delete()
    self:Init()
end

return UnitSkillVo