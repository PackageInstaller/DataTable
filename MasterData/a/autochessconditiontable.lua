---@class AutoChessConditionTable
---@field public id integer
---@field public type integer
---@field public params table
---@field public targetType integer
---@field public targetFlow table
---@field public conditionTarget integer
---@field public conditionTargetFlow table
---@field public isSort integer
---@field public compareType integer

---@type AutoChessConditionTable[]
local AutoChessConditionTable = {
                [10001] = {
                        id = 10001,
                        type = 1,
                        params = {5},
                        targetType = 1,
                        targetFlow = {},
                        conditionTarget = 0,
                        conditionTargetFlow = nil,
                        isSort = 0,
                        compareType = 4,
                },

                [10002] = {
                        id = 10002,
                        type = 2,
                        params = {0.3},
                        targetType = 101,
                        targetFlow = {},
                        conditionTarget = 0,
                        conditionTargetFlow = nil,
                        isSort = 0,
                        compareType = 6,
                },

                [10003] = {
                        id = 10003,
                        type = 3,
                        params = {0.4},
                        targetType = 1,
                        targetFlow = {},
                        conditionTarget = 0,
                        conditionTargetFlow = nil,
                        isSort = 0,
                        compareType = 6,
                },

                [10004] = {
                        id = 10004,
                        type = 4,
                        params = {{15,150},{16,150}},
                        targetType = 1,
                        targetFlow = {902,501},
                        conditionTarget = 101,
                        conditionTargetFlow = 101,
                        isSort = 0,
                        compareType = 3,
                },

                [10005] = {
                        id = 10005,
                        type = 5,
                        params = {{10001}},
                        targetType = 1,
                        targetFlow = {},
                        conditionTarget = 203,
                        conditionTargetFlow = 203,
                        isSort = 0,
                        compareType = 1,
                },

                [10006] = {
                        id = 10006,
                        type = 6,
                        params = nil,
                        targetType = 1,
                        targetFlow = nil,
                        conditionTarget = 0,
                        conditionTargetFlow = nil,
                        isSort = 0,
                        compareType = 1,
                },

                [10007] = {
                        id = 10007,
                        type = 7,
                        params = {1,2,3},
                        targetType = 1,
                        targetFlow = nil,
                        conditionTarget = 0,
                        conditionTargetFlow = nil,
                        isSort = 0,
                        compareType = 1,
                },

                [10008] = {
                        id = 10008,
                        type = 8,
                        params = {1,2,3},
                        targetType = 1,
                        targetFlow = nil,
                        conditionTarget = 0,
                        conditionTargetFlow = nil,
                        isSort = 0,
                        compareType = 1,
                },

                [10009] = {
                        id = 10009,
                        type = 9,
                        params = {1,2,3},
                        targetType = 1,
                        targetFlow = nil,
                        conditionTarget = 0,
                        conditionTargetFlow = nil,
                        isSort = 0,
                        compareType = 1,
                },

                [10010] = {
                        id = 10010,
                        type = 10,
                        params = {3},
                        targetType = 1,
                        targetFlow = nil,
                        conditionTarget = 0,
                        conditionTargetFlow = nil,
                        isSort = 0,
                        compareType = 1,
                },

                [10011] = {
                        id = 10011,
                        type = 11,
                        params = {{20001,10010,10002}},
                        targetType = 102,
                        targetFlow = nil,
                        conditionTarget = 0,
                        conditionTargetFlow = nil,
                        isSort = 0,
                        compareType = 1,
                },

}
return AutoChessConditionTable