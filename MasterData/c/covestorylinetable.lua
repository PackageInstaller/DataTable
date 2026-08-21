---@class CoveStoryLineTable
---@field public id integer
---@field public group integer
---@field public objName string
---@field public eventType integer
---@field public eventParam string
---@field public finishParam string
---@field public activationConditions table

---@type CoveStoryLineTable[]
local CoveStoryLineTable = {
                [1000001] = {
                        id = 1000001,
                        group = 100,
                        objName = "",
                        eventType = 0,
                        eventParam = "",
                        finishParam = "1000011",
                        activationConditions = {{3,10004,1}},
                },

                [1000011] = {
                        id = 1000011,
                        group = 100,
                        objName = "timeline_01",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1000102",
                        activationConditions = nil,
                },

                [1000012] = {
                        id = 1000012,
                        group = 100,
                        objName = "timeline_02",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1000103",
                        activationConditions = nil,
                },

                [1000013] = {
                        id = 1000013,
                        group = 100,
                        objName = "timeline_03",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1000014",
                        activationConditions = nil,
                },

                [1000014] = {
                        id = 1000014,
                        group = 100,
                        objName = "timeline_04",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1000104",
                        activationConditions = nil,
                },

                [1000015] = {
                        id = 1000015,
                        group = 100,
                        objName = "timeline_05",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1000011",
                        activationConditions = nil,
                },

                [1000016] = {
                        id = 1000016,
                        group = 100,
                        objName = "timeline_06",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1000017",
                        activationConditions = nil,
                },

                [1000017] = {
                        id = 1000017,
                        group = 100,
                        objName = "timeline_07",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1000011",
                        activationConditions = nil,
                },

                [1000018] = {
                        id = 1000018,
                        group = 100,
                        objName = "timeline_08",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1000011",
                        activationConditions = nil,
                },

                [1000102] = {
                        id = 1000102,
                        group = 100,
                        objName = "",
                        eventType = 8,
                        eventParam = "",
                        finishParam = "1000011|1000012",
                        activationConditions = nil,
                },

                [1000103] = {
                        id = 1000103,
                        group = 100,
                        objName = "",
                        eventType = 8,
                        eventParam = "",
                        finishParam = "1000013|1000015|1000016|1000018",
                        activationConditions = nil,
                },

                [1000104] = {
                        id = 1000104,
                        group = 100,
                        objName = "",
                        eventType = 8,
                        eventParam = "",
                        finishParam = "1000015|1000016|1000018",
                        activationConditions = nil,
                },

                [1010001] = {
                        id = 1010001,
                        group = 101,
                        objName = "",
                        eventType = 0,
                        eventParam = "",
                        finishParam = "1010010",
                        activationConditions = {{3,10010,1}},
                },

                [1010010] = {
                        id = 1010010,
                        group = 101,
                        objName = "timeline_10100",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010024",
                        activationConditions = nil,
                },

                [1010011] = {
                        id = 1010011,
                        group = 101,
                        objName = "timeline_10101",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010022",
                        activationConditions = nil,
                },

                [1010012] = {
                        id = 1010012,
                        group = 101,
                        objName = "timeline_10102",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010013",
                        activationConditions = nil,
                },

                [1010013] = {
                        id = 1010013,
                        group = 101,
                        objName = "timeline_10103",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010014",
                        activationConditions = nil,
                },

                [1010014] = {
                        id = 1010014,
                        group = 101,
                        objName = "timeline_10104",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010015",
                        activationConditions = nil,
                },

                [1010015] = {
                        id = 1010015,
                        group = 101,
                        objName = "timeline_10105",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010016",
                        activationConditions = nil,
                },

                [1010016] = {
                        id = 1010016,
                        group = 101,
                        objName = "timeline_10106",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010026",
                        activationConditions = nil,
                },

                [1010017] = {
                        id = 1010017,
                        group = 101,
                        objName = "timeline_10107",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010025",
                        activationConditions = nil,
                },

                [1010018] = {
                        id = 1010018,
                        group = 101,
                        objName = "timeline_10108",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010020",
                        activationConditions = nil,
                },

                [1010019] = {
                        id = 1010019,
                        group = 101,
                        objName = "timeline_10109",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010010",
                        activationConditions = nil,
                },

                [1010020] = {
                        id = 1010020,
                        group = 101,
                        objName = "timeline_10110",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010021",
                        activationConditions = nil,
                },

                [1010021] = {
                        id = 1010021,
                        group = 101,
                        objName = "timeline_10111",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "",
                        activationConditions = nil,
                },

                [1010022] = {
                        id = 1010022,
                        group = 101,
                        objName = "timeline_10112",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "",
                        activationConditions = nil,
                },

                [1010023] = {
                        id = 1010023,
                        group = 101,
                        objName = "timeline_10113",
                        eventType = 11,
                        eventParam = "",
                        finishParam = "1010015",
                        activationConditions = nil,
                },

                [1010024] = {
                        id = 1010024,
                        group = 101,
                        objName = "",
                        eventType = 8,
                        eventParam = "",
                        finishParam = "1010010|1010028",
                        activationConditions = nil,
                },

                [1010025] = {
                        id = 1010025,
                        group = 101,
                        objName = "",
                        eventType = 8,
                        eventParam = "",
                        finishParam = "1010019|1010027",
                        activationConditions = nil,
                },

                [1010026] = {
                        id = 1010026,
                        group = 101,
                        objName = "",
                        eventType = 0,
                        eventParam = "",
                        finishParam = "1010018,1010017",
                        activationConditions = nil,
                },

                [1010027] = {
                        id = 1010027,
                        group = 101,
                        objName = "",
                        eventType = 0,
                        eventParam = "",
                        finishParam = "1010011,1010023",
                        activationConditions = nil,
                },

                [1010028] = {
                        id = 1010028,
                        group = 101,
                        objName = "",
                        eventType = 0,
                        eventParam = "",
                        finishParam = "1010011,1010012",
                        activationConditions = nil,
                },

}
return CoveStoryLineTable