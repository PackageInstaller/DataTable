---@class AiOperateTable
---@field public id integer
---@field public aiType integer
---@field public skillList table
---@field public moveType integer
---@field public moveTypeValue table

---@type AiOperateTable[]
local AiOperateTable = {
                [1001] = {
                        id = 1001,
                        aiType = 0,
                        skillList = {},
                        moveType = 2,
                        moveTypeValue = {},
                },

                [1002] = {
                        id = 1002,
                        aiType = 1,
                        skillList = {84,21,11,51,71,72,91,92,81,82,83,41,42,61,31,1},
                        moveType = 1,
                        moveTypeValue = nil,
                },

                [1003] = {
                        id = 1003,
                        aiType = 1,
                        skillList = {21,11,51,71,72,91,92,81,82,83,41,42,61,31,1},
                        moveType = 1,
                        moveTypeValue = nil,
                },

                [1004] = {
                        id = 1004,
                        aiType = 3,
                        skillList = {13,12,11},
                        moveType = 3,
                        moveTypeValue = {},
                },

                [1005] = {
                        id = 1005,
                        aiType = 0,
                        skillList = nil,
                        moveType = 0,
                        moveTypeValue = nil,
                },

                [1006] = {
                        id = 1006,
                        aiType = 0,
                        skillList = nil,
                        moveType = 0,
                        moveTypeValue = nil,
                },

                [1007] = {
                        id = 1007,
                        aiType = 0,
                        skillList = nil,
                        moveType = 0,
                        moveTypeValue = nil,
                },

                [1008] = {
                        id = 1008,
                        aiType = 2,
                        skillList = {11,12,13},
                        moveType = 2,
                        moveTypeValue = nil,
                },

                [1009] = {
                        id = 1009,
                        aiType = 1,
                        skillList = {84,21,11,51,71,72,91,92,81,82,83,41,42,61,31,1},
                        moveType = 2,
                        moveTypeValue = nil,
                },

}
return AiOperateTable