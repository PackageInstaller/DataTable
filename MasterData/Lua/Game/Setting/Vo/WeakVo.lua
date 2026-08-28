
------------ define ------------
local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
------------ define ------------

---@class WeakVo
local WeakVo = {}
WeakVo = Class("WeakVo", SettingRefBase)

function WeakVo:Init()
   self:CleanProperty()
end

function WeakVo:__delete()
    self:CleanProperty()
end

function WeakVo:CleanProperty()
    self.id = nil
    self.weakness = nil
    self.weakStars = nil
    self.weakAttribute = nil
    self.weakShow = nil -- 解体效果
    self.weakLength = nil -- 解体时长（回合数）
    self.sleepShow = nil -- 休眠状态描述
    self.sleepLength = nil -- 休眠时长（回合数）
    self.rageShow = nil -- 狂暴状态描述
end

function WeakVo:__init()
    self:Init()
end

---FillVo
---@param row TableML.TableFileRow
function WeakVo:FillVo(row)
    base.FillVo(self, row)
    self.id = parse_number(row, "id", 0)
    local w = parse_string(row, "stars", '')
    local condition = not w or w == '' or w == '0'
    self.weakStars = condition and {} or Tools.splitToNum(w, ';')
    self.weakAttribute = parse_string(row, "weakAttribute", '')
    self.weakShow = parse_string(row, "weakShow", '')
    self.weakLength = parse_number(row, "weakLength", 0)
    self.sleepShow = parse_string(row, "sleepShow", '')
    self.sleepLength = parse_number(row, "sleepLength", 0)
    self.rageShow = parse_string(row, "rage", '')
end

return WeakVo