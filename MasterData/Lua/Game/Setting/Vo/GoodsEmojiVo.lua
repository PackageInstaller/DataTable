---
--- Created by pikaqiu.
--- DateTime: 2022-10-20 17:25
---

local SettingRefBase = require('Game.Setting.SettingRefBase')

---@class GoodsEmojiVo
local GoodsEmojiVo = Class("GoodsEmojiVo", SettingRefBase)
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

---__int
function GoodsEmojiVo:__init()
    self.id = nil
    self.type = nil
    self.showType = nil
    self.name = nil
    self.desc = nil
    self.description = nil
    self.quality = nil
    self.stackMax = nil
    self.jumpAway = nil
    ---@type integer[]
    self.jumpParameter = nil
    self.photoPath = nil
    self.prefabPath = nil
    ---@type number @ spine动画时长（毫秒）
    self.animationDuration = nil
    self.effectType = nil
    self.effectId = nil
    self.effectNum = nil
end

---FillVo
---@param row TableML.TableFileRow
function GoodsEmojiVo:FillVo(row)
    base.FillVo(self, row)
    self.id = parse_number(row, "id", 0)
    self.type = parse_number(row, "type", 0)
    self.showType = parse_number(row, "showType", 0)
    self.name = ParseUtils.ParseLocalizeText(row, "name", "")
    self.desc = string.gsub(ParseUtils.ParseLocalizeText(row, "description", ""), "\\n", "\n")
    self.description = string.gsub(ParseUtils.ParseLocalizeText(row, "desc", ""), "\\n", "\n")
    -- QualityType
    self.quality = parse_number(row, "quality", 0)

    self.stackMax = parse_number(row, "stack", 0)

    ---跳转的逻辑
    local openType = parse_string(row, "openType", "")
    if not string.isEmpty(openType) then
        local openTypes = string.split(openType, ";")
        local t = {}
        for i, v in pairs(openTypes) do
            if checkInt(v) > 0 then
                table.insert(t, checkInt(v))
            end
        end
        self.jumpAway = t
        ---只有跳转不为空时参数才有存在的意义
        local openParameter = parse_string(row, "openParameter", "")
        if not string.isEmpty(openParameter) then
            local params = string.split(openParameter, ";")
            local t = {}
            for i, v in pairs(params) do
                if checkInt(v) > 0 then
                    table.insert(t, checkInt(v))
                end
            end
            self.jumpParameter = t
        end
    end

    self.photoPath = ParseUtils.ParsePathName(row, "photoId")
    self.prefabPath = ParseUtils.ParsePathName(row, "prefab", ".prefab")
    self.animationDuration = parse_number(row, "animationTime", 0)

    -- GoodsEffectType
    self.effectType = parse_number(row, "effectType", 0)
    
    self.effectId = parse_number(row, "effectId", 0)

    self.effectNum = parse_number(row, "effectNum", 0)
end

function GoodsEmojiVo:__delete()
    self.id = nil
    self.type = nil
    self.name = nil
    self.desc = nil
    self.description = nil
    self.quality = nil
    self.stackMax = nil
    self.jumpAway = nil
    self.jumpParameter = nil
    self.photoPath = nil
    self.prefabPath = nil
    self.animationDuration = nil
    self.effectType = nil
    self.effectId = nil
    self.effectNum = nil
end

return GoodsEmojiVo