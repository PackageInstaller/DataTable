---@class HomeActivateTable
---@field public id integer
---@field public activateType integer
---@field public param integer
---@field public actionGroup integer
---@field public maxCount integer
---@field public limitBuildingLv integer
---@field public heroRewardList table
---@field public rewardList table
---@field public statusShow table

---@type HomeActivateTable[]
local HomeActivateTable = {
                [10201] = {
                        id = 10201,
                        activateType = 2,
                        param = 10003,
                        actionGroup = 1,
                        maxCount = 1,
                        limitBuildingLv = 1,
                        heroRewardList = {{1,-10}},
                        rewardList = {},
                        statusShow = nil,
                },

                [10202] = {
                        id = 10202,
                        activateType = 2,
                        param = 10004,
                        actionGroup = 1,
                        maxCount = 1,
                        limitBuildingLv = 1,
                        heroRewardList = {{1,-10}},
                        rewardList = {},
                        statusShow = nil,
                },

                [10203] = {
                        id = 10203,
                        activateType = 2,
                        param = 10009,
                        actionGroup = 1,
                        maxCount = 1,
                        limitBuildingLv = 4,
                        heroRewardList = {{1,-10}},
                        rewardList = {},
                        statusShow = nil,
                },

                [10204] = {
                        id = 10204,
                        activateType = 2,
                        param = 10011,
                        actionGroup = 1,
                        maxCount = 1,
                        limitBuildingLv = 1,
                        heroRewardList = {{3,-10}},
                        rewardList = {},
                        statusShow = nil,
                },

                [10205] = {
                        id = 10205,
                        activateType = 2,
                        param = 10012,
                        actionGroup = 1,
                        maxCount = 1,
                        limitBuildingLv = 1,
                        heroRewardList = {{3,-10}},
                        rewardList = {},
                        statusShow = nil,
                },

                [10206] = {
                        id = 10206,
                        activateType = 2,
                        param = 10013,
                        actionGroup = 1,
                        maxCount = 1,
                        limitBuildingLv = 1,
                        heroRewardList = {{3,-10}},
                        rewardList = {},
                        statusShow = nil,
                },

                [10501] = {
                        id = 10501,
                        activateType = 5,
                        param = 10005,
                        actionGroup = 1,
                        maxCount = 2,
                        limitBuildingLv = 0,
                        heroRewardList = {{3,1200}},
                        rewardList = {},
                        statusShow = {"mood_food",2},
                },

                [10502] = {
                        id = 10502,
                        activateType = 5,
                        param = 10017,
                        actionGroup = 1,
                        maxCount = 2,
                        limitBuildingLv = 0,
                        heroRewardList = {{3,1200}},
                        rewardList = {},
                        statusShow = {"mood_food",2},
                },

                [10601] = {
                        id = 10601,
                        activateType = 6,
                        param = 10015,
                        actionGroup = 1,
                        maxCount = 4,
                        limitBuildingLv = 0,
                        heroRewardList = {{1,1200}},
                        rewardList = {},
                        statusShow = {"mood_energy",1},
                },

                [10701] = {
                        id = 10701,
                        activateType = 7,
                        param = 10099,
                        actionGroup = 1,
                        maxCount = 4,
                        limitBuildingLv = 0,
                        heroRewardList = {{1,-30}},
                        rewardList = {},
                        statusShow = nil,
                },

                [10801] = {
                        id = 10801,
                        activateType = 8,
                        param = 10002,
                        actionGroup = 1,
                        maxCount = 4,
                        limitBuildingLv = 0,
                        heroRewardList = {{2,1200}},
                        rewardList = {},
                        statusShow = {"mood_happy",2},
                },

                [10802] = {
                        id = 10802,
                        activateType = 8,
                        param = 10004,
                        actionGroup = 1,
                        maxCount = 1,
                        limitBuildingLv = 0,
                        heroRewardList = {{2,1200}},
                        rewardList = {},
                        statusShow = {"mood_shop",2},
                },

                [10803] = {
                        id = 10803,
                        activateType = 8,
                        param = 10016,
                        actionGroup = 1,
                        maxCount = 2,
                        limitBuildingLv = 0,
                        heroRewardList = {{2,1200}},
                        rewardList = {},
                        statusShow = {"mood_happy",2},
                },

                [11001] = {
                        id = 11001,
                        activateType = 10,
                        param = 10002,
                        actionGroup = 8,
                        maxCount = 4,
                        limitBuildingLv = 0,
                        heroRewardList = {{4,1200}},
                        rewardList = {},
                        statusShow = nil,
                },

                [1000] = {
                        id = 1000,
                        activateType = 9,
                        param = 10014,
                        actionGroup = 0,
                        maxCount = 0,
                        limitBuildingLv = 0,
                        heroRewardList = {},
                        rewardList = {},
                        statusShow = nil,
                },

                [9001] = {
                        id = 9001,
                        activateType = 1,
                        param = 10001,
                        actionGroup = 1,
                        maxCount = 8,
                        limitBuildingLv = 0,
                        heroRewardList = {{1,-20},{3,-15}},
                        rewardList = {},
                        statusShow = nil,
                },

                [94001] = {
                        id = 94001,
                        activateType = 4,
                        param = 10001,
                        actionGroup = 0,
                        maxCount = 0,
                        limitBuildingLv = 0,
                        heroRewardList = {},
                        rewardList = {},
                        statusShow = nil,
                },

                [94002] = {
                        id = 94002,
                        activateType = 4,
                        param = 10002,
                        actionGroup = 0,
                        maxCount = 0,
                        limitBuildingLv = 0,
                        heroRewardList = {},
                        rewardList = {},
                        statusShow = nil,
                },

                [94003] = {
                        id = 94003,
                        activateType = 4,
                        param = 10003,
                        actionGroup = 0,
                        maxCount = 0,
                        limitBuildingLv = 1,
                        heroRewardList = {},
                        rewardList = {},
                        statusShow = nil,
                },

                [94004] = {
                        id = 94004,
                        activateType = 4,
                        param = 10004,
                        actionGroup = 0,
                        maxCount = 0,
                        limitBuildingLv = 0,
                        heroRewardList = {},
                        rewardList = {},
                        statusShow = nil,
                },

                [94005] = {
                        id = 94005,
                        activateType = 4,
                        param = 10005,
                        actionGroup = 0,
                        maxCount = 0,
                        limitBuildingLv = 0,
                        heroRewardList = {},
                        rewardList = {},
                        statusShow = nil,
                },

                [94009] = {
                        id = 94009,
                        activateType = 4,
                        param = 10009,
                        actionGroup = 0,
                        maxCount = 0,
                        limitBuildingLv = 1,
                        heroRewardList = {},
                        rewardList = {},
                        statusShow = nil,
                },

}
return HomeActivateTable