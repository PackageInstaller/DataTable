---@class BannerTable
---@field public id integer
---@field public resourceName string
---@field public startTime string
---@field public endTime string
---@field public showPriority integer
---@field public turnTo table

---@type BannerTable[]
local BannerTable = {
                [1001] = {
                        id = 1001,
                        resourceName = "main_banner_img01",
                        startTime = "2024-11-13",
                        endTime = "2026-11-13",
                        showPriority = 1,
                        turnTo = {1910001},
                },

                [1002] = {
                        id = 1002,
                        resourceName = "main_banner_img02",
                        startTime = "2024-11-13",
                        endTime = "2026-11-14",
                        showPriority = 2,
                        turnTo = {1010001},
                },

                [1003] = {
                        id = 1003,
                        resourceName = "main_banner_img03",
                        startTime = "2024-11-13",
                        endTime = "2026-11-15",
                        showPriority = 3,
                        turnTo = {1310006},
                },

}
return BannerTable