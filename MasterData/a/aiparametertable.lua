---@class AiParameterTable
---@field public id integer
---@field public siftType integer
---@field public siftCondition table

---@type AiParameterTable[]
local AiParameterTable = {
                [2001] = {
                        id = 2001,
                        siftType = 1,
                        siftCondition = nil,
                },

                [2002] = {
                        id = 2002,
                        siftType = 2,
                        siftCondition = nil,
                },

                [2003] = {
                        id = 2003,
                        siftType = 3,
                        siftCondition = {0.9},
                },

                [2004] = {
                        id = 2004,
                        siftType = 4,
                        siftCondition = {1,2},
                },

                [2005] = {
                        id = 2005,
                        siftType = 4,
                        siftCondition = {0.9,2},
                },

                [2006] = {
                        id = 2006,
                        siftType = 6,
                        siftCondition = {1,2},
                },

                [2007] = {
                        id = 2007,
                        siftType = 5,
                        siftCondition = nil,
                },

                [2008] = {
                        id = 2008,
                        siftType = 5,
                        siftCondition = {1,2},
                },

                [2009] = {
                        id = 2009,
                        siftType = 5,
                        siftCondition = {0.9,2},
                },

                [2010] = {
                        id = 2010,
                        siftType = 5,
                        siftCondition = {0.7,1},
                },

}
return AiParameterTable