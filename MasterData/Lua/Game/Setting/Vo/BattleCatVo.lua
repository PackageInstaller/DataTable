
local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class BattleCatVo
local BattleCatVo = Class("BattleCatVo", SettingRefBase)

local base = SettingRefBase

function BattleCatVo:__init()
    self.id = nil
    self.animatorControl = nil
    self.modeString = nil
    self.catSkin = nil
    self.idleFx = {}
    self.enterFx = nil
    self.endFx = nil
end

function BattleCatVo:__delete()
    self.id = nil
    self.animatorControl = nil
    self.modeString = nil
    self.catSkin = nil
    self.idleFx = {}
    self.enterFx = nil
    self.endFx = nil
end

---FillVo
---@param row TableML.TableFileRow
function BattleCatVo:FillVo(row)
    base.FillVo(self, row)
    self.id = parse_number(row, "id")
    self.animatorControl = parse_string(row, "animatorControl")
    self.modeString = parse_string(row, "modeString")
    self.catSkin = parse_string(row, "catSkin")

    self.idleFx = {
        [1] = parse_string(row, "idle1Fx"),
        [2] = parse_string(row, "idle2Fx"),
        [3] = parse_string(row, "idle3Fx"),
        [4] = parse_string(row, "idle4Fx"),
    }
    self.enterFx = parse_string(row, "enterFx")
    self.endFx = parse_string(row, "endFx")
end

return BattleCatVo