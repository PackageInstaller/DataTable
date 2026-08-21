---@class DispatchBattleTable
---@field public id integer
---@field public energeticNumber integer
---@field public fireCoefficient integer
---@field public adjustedValue integer

---@type DispatchBattleTable[]
local DispatchBattleTable = {
                [1] = {
                        id = 1,
                        energeticNumber = 1,
                        fireCoefficient = 3,
                        adjustedValue = 10,
                },

                [2] = {
                        id = 2,
                        energeticNumber = 2,
                        fireCoefficient = 1.5,
                        adjustedValue = 10,
                },

                [3] = {
                        id = 3,
                        energeticNumber = 3,
                        fireCoefficient = 1,
                        adjustedValue = 10,
                },

                [4] = {
                        id = 4,
                        energeticNumber = 4,
                        fireCoefficient = 0.75,
                        adjustedValue = 10,
                },

                [5] = {
                        id = 5,
                        energeticNumber = 5,
                        fireCoefficient = 0.6,
                        adjustedValue = 10,
                },

}
return DispatchBattleTable