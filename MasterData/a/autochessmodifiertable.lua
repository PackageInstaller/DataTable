---@class AutoChessModifierTable
---@field public id integer
---@field public name string
---@field public script string
---@field public params table
---@field public conditionList table
---@field public effectId integer
---@field public effectPos table

---@type AutoChessModifierTable[]
local AutoChessModifierTable = {
                [10001] = {
                        id = 10001,
                        name = "减伤",
                        script = "Modifier_DamageAmplification",
                        params = {5},
                        conditionList = {4},
                        effectId = 0,
                        effectPos = nil,
                },

                [10002] = {
                        id = 10002,
                        name = "增伤",
                        script = "Modifier_DamageReduction",
                        params = {0.3},
                        conditionList = {6},
                        effectId = 0,
                        effectPos = nil,
                },

}
return AutoChessModifierTable