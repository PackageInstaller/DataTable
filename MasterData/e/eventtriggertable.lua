---@class EventTriggerTable
---@field public id integer
---@field public system integer
---@field public parameter table
---@field public type integer
---@field public num integer
---@field public ExtraCondition table
---@field public prop integer
---@field public limit table

---@type EventTriggerTable[]
local EventTriggerTable = {
                [1001] = {
                        id = 1001,
                        system = 1,
                        parameter = {},
                        type = 1,
                        num = 1,
                        ExtraCondition = {12,24},
                        prop = 100,
                        limit = {1,1},
                },

                [1002] = {
                        id = 1002,
                        system = 1,
                        parameter = {},
                        type = 1,
                        num = 5,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {2,1},
                },

                [1003] = {
                        id = 1003,
                        system = 1,
                        parameter = {},
                        type = 1,
                        num = 10,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {3,1},
                },

                [1004] = {
                        id = 1004,
                        system = 1,
                        parameter = {},
                        type = 2,
                        num = 2,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {1,1},
                },

                [1005] = {
                        id = 1005,
                        system = 1,
                        parameter = {},
                        type = 3,
                        num = 5,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {2,1},
                },

                [1006] = {
                        id = 1006,
                        system = 1,
                        parameter = {},
                        type = 4,
                        num = 100,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {3,1},
                },

                [1007] = {
                        id = 1007,
                        system = 1,
                        parameter = {},
                        type = 5,
                        num = 10000,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {1,1},
                },

                [1008] = {
                        id = 1008,
                        system = 1,
                        parameter = {},
                        type = 4,
                        num = 1000,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {2,1},
                },

                [1009] = {
                        id = 1009,
                        system = 1,
                        parameter = {},
                        type = 3,
                        num = 20,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {3,1},
                },

                [1010] = {
                        id = 1010,
                        system = 1,
                        parameter = {},
                        type = 2,
                        num = 1,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {1,1},
                },

                [2001] = {
                        id = 2001,
                        system = 2,
                        parameter = {},
                        type = 4,
                        num = 60,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {1,1},
                },

                [2002] = {
                        id = 2002,
                        system = 2,
                        parameter = {},
                        type = 4,
                        num = 480,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {2,1},
                },

                [2003] = {
                        id = 2003,
                        system = 2,
                        parameter = {},
                        type = 4,
                        num = 1680,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {3,1},
                },

                [2004] = {
                        id = 2004,
                        system = 2,
                        parameter = {},
                        type = 2,
                        num = 30,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {2,1},
                },

                [2005] = {
                        id = 2005,
                        system = 2,
                        parameter = {},
                        type = 2,
                        num = 80,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {3,1},
                },

                [3001] = {
                        id = 3001,
                        system = 3,
                        parameter = {4},
                        type = 4,
                        num = 1,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {1,1},
                },

                [3002] = {
                        id = 3002,
                        system = 3,
                        parameter = {5},
                        type = 4,
                        num = 180,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {1,1},
                },

                [3003] = {
                        id = 3003,
                        system = 3,
                        parameter = {6},
                        type = 4,
                        num = 360,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {2,1},
                },

                [3004] = {
                        id = 3004,
                        system = 3,
                        parameter = {10},
                        type = 2,
                        num = 10,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {2,1},
                },

                [3005] = {
                        id = 3005,
                        system = 3,
                        parameter = {4},
                        type = 4,
                        num = 120,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {1,1},
                },

                [3006] = {
                        id = 3006,
                        system = 3,
                        parameter = {4},
                        type = 2,
                        num = 5,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {1,1},
                },

                [4001] = {
                        id = 4001,
                        system = 4,
                        parameter = {},
                        type = 4,
                        num = 100,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {1,1},
                },

                [4002] = {
                        id = 4002,
                        system = 4,
                        parameter = {},
                        type = 4,
                        num = 200,
                        ExtraCondition = {},
                        prop = 100,
                        limit = {1,1},
                },

}
return EventTriggerTable