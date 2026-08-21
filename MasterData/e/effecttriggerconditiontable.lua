---@class EffectTriggerConditionTable
---@field public id integer
---@field public name string
---@field public conditionType integer
---@field public conditionValue table
---@field public compareType integer
---@field public conditionTarget table
---@field public SiftCondition table

---@type EffectTriggerConditionTable[]
local EffectTriggerConditionTable = {
                [2] = {
                        id = 2,
                        name = "战斗开始时（整局战斗）",
                        conditionType = 1,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [3] = {
                        id = 3,
                        name = "回合开始时（效果所属方的回合）",
                        conditionType = 1,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [10] = {
                        id = 10,
                        name = "移动后",
                        conditionType = 1,
                        conditionValue = {10},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [12] = {
                        id = 12,
                        name = "行动前",
                        conditionType = 1,
                        conditionValue = {12},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [4] = {
                        id = 4,
                        name = "战斗前",
                        conditionType = 1,
                        conditionValue = {4},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [5] = {
                        id = 5,
                        name = "战斗中（表现时机）",
                        conditionType = 1,
                        conditionValue = {5},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [6] = {
                        id = 6,
                        name = "战斗中-反击时机（表现后，战斗后之前）",
                        conditionType = 1,
                        conditionValue = {6},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [7] = {
                        id = 7,
                        name = "战斗后",
                        conditionType = 1,
                        conditionValue = {7},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [11] = {
                        id = 11,
                        name = "释放技能后",
                        conditionType = 1,
                        conditionValue = {11},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [8] = {
                        id = 8,
                        name = "行动结束后",
                        conditionType = 1,
                        conditionValue = {8},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [15] = {
                        id = 15,
                        name = "任意单位血量发生变化时",
                        conditionType = 1,
                        conditionValue = {15},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [23] = {
                        id = 23,
                        name = "发生过战斗（使用技能/普攻）",
                        conditionType = 2,
                        conditionValue = {},
                        compareType = 1,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [24] = {
                        id = 24,
                        name = "没有单位死亡",
                        conditionType = 2,
                        conditionValue = {},
                        compareType = 6,
                        conditionTarget = {},
                        SiftCondition = {},
                },

                [100101] = {
                        id = 100101,
                        name = "判断我方目标释放单体技能",
                        conditionType = 100,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [100102] = {
                        id = 100102,
                        name = "判断我方目标释放范围技能",
                        conditionType = 100,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [100103] = {
                        id = 100103,
                        name = "判断我方目标释放辅助技能",
                        conditionType = 100,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [100201] = {
                        id = 100201,
                        name = "判断敌方目标释放单体技能",
                        conditionType = 100,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [100202] = {
                        id = 100202,
                        name = "判断敌方目标释放范围技能",
                        conditionType = 100,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [101101] = {
                        id = 101101,
                        name = "判断我方目标释放技能的伤害类型=炮击时",
                        conditionType = 101,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [101102] = {
                        id = 101102,
                        name = "判断我方目标释放技能的伤害类型=雷击时",
                        conditionType = 101,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [101201] = {
                        id = 101201,
                        name = "判断敌方目标释放技能的伤害类型=炮击时",
                        conditionType = 101,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [101202] = {
                        id = 101202,
                        name = "判断敌方目标释放技能的伤害类型=雷击时",
                        conditionType = 101,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [101301] = {
                        id = 101301,
                        name = "光环专用，判断行动目标释放技能的伤害类型=炮击时",
                        conditionType = 101,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {6},
                        SiftCondition = {},
                },

                [101302] = {
                        id = 101302,
                        name = "光环专用，判断行动目标释放技能的伤害类型=雷击时",
                        conditionType = 101,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {6},
                        SiftCondition = {},
                },

                [102011] = {
                        id = 102011,
                        name = "主动时",
                        conditionType = 102,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102012] = {
                        id = 102012,
                        name = "被动时",
                        conditionType = 102,
                        conditionValue = {1},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102013] = {
                        id = 102013,
                        name = "光环专用，友方单位行动时",
                        conditionType = 102,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {6},
                        SiftCondition = {},
                },

                [102014] = {
                        id = 102014,
                        name = "光环专用，敌方单位行动时",
                        conditionType = 102,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {2},
                        SiftCondition = {},
                },

                [102021] = {
                        id = 102021,
                        name = "受到过伤害",
                        conditionType = 102,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102022] = {
                        id = 102022,
                        name = "未受到伤害",
                        conditionType = 102,
                        conditionValue = {2},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102031] = {
                        id = 102031,
                        name = "造成过伤害",
                        conditionType = 102,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102032] = {
                        id = 102032,
                        name = "未造成过伤害",
                        conditionType = 102,
                        conditionValue = {3},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102041] = {
                        id = 102041,
                        name = "造成暴击",
                        conditionType = 102,
                        conditionValue = {4},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102042] = {
                        id = 102042,
                        name = "未造成暴击",
                        conditionType = 102,
                        conditionValue = {4},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102051] = {
                        id = 102051,
                        name = "受到暴击",
                        conditionType = 102,
                        conditionValue = {5},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102052] = {
                        id = 102052,
                        name = "未受到暴击",
                        conditionType = 102,
                        conditionValue = {5},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102061] = {
                        id = 102061,
                        name = "造成治疗",
                        conditionType = 102,
                        conditionValue = {6},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102062] = {
                        id = 102062,
                        name = "未造成治疗",
                        conditionType = 102,
                        conditionValue = {6},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102071] = {
                        id = 102071,
                        name = "受到治疗",
                        conditionType = 102,
                        conditionValue = {7},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102072] = {
                        id = 102072,
                        name = "未受到治疗",
                        conditionType = 102,
                        conditionValue = {7},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102081] = {
                        id = 102081,
                        name = "使用技能",
                        conditionType = 102,
                        conditionValue = {8},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102082] = {
                        id = 102082,
                        name = "未使用技能",
                        conditionType = 102,
                        conditionValue = {8},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102091] = {
                        id = 102091,
                        name = "使用普攻",
                        conditionType = 102,
                        conditionValue = {9},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102092] = {
                        id = 102092,
                        name = "未使用普攻",
                        conditionType = 102,
                        conditionValue = {9},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102101] = {
                        id = 102101,
                        name = "发生战斗",
                        conditionType = 102,
                        conditionValue = {10},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102102] = {
                        id = 102102,
                        name = "未发生战斗（治疗和辅助技能不算战斗）",
                        conditionType = 102,
                        conditionValue = {10},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102103] = {
                        id = 102103,
                        name = "发生战斗(被动时判断，判读交互方使用了攻击技能）",
                        conditionType = 102,
                        conditionValue = {10},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [102104] = {
                        id = 102104,
                        name = "光环专用，友方单位发生战斗",
                        conditionType = 102,
                        conditionValue = {10},
                        compareType = 1,
                        conditionTarget = {6},
                        SiftCondition = {},
                },

                [102105] = {
                        id = 102105,
                        name = "当前行动单位发生战斗",
                        conditionType = 102,
                        conditionValue = {10},
                        compareType = 1,
                        conditionTarget = {302},
                        SiftCondition = {},
                },

                [102111] = {
                        id = 102111,
                        name = "仅待机",
                        conditionType = 102,
                        conditionValue = {11},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102112] = {
                        id = 102112,
                        name = "未待机（使用技能或普攻）",
                        conditionType = 102,
                        conditionValue = {11},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102121] = {
                        id = 102121,
                        name = "消灭过单位",
                        conditionType = 102,
                        conditionValue = {12},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102122] = {
                        id = 102122,
                        name = "未消灭过单位",
                        conditionType = 102,
                        conditionValue = {12},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102131] = {
                        id = 102131,
                        name = "血量发生过变化",
                        conditionType = 102,
                        conditionValue = {13},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102151] = {
                        id = 102151,
                        name = "触发了免死",
                        conditionType = 102,
                        conditionValue = {15},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102161] = {
                        id = 102161,
                        name = "触发再行动",
                        conditionType = 102,
                        conditionValue = {16},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102171] = {
                        id = 102171,
                        name = "触发护卫",
                        conditionType = 102,
                        conditionValue = {17},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102311] = {
                        id = 102311,
                        name = "受到炮击伤害",
                        conditionType = 102,
                        conditionValue = {31},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102321] = {
                        id = 102321,
                        name = "受到雷击伤害",
                        conditionType = 102,
                        conditionValue = {32},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102331] = {
                        id = 102331,
                        name = "受到航空炮击伤害",
                        conditionType = 102,
                        conditionValue = {33},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102341] = {
                        id = 102341,
                        name = "受到航空雷击伤害",
                        conditionType = 102,
                        conditionValue = {34},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102351] = {
                        id = 102351,
                        name = "受到维修",
                        conditionType = 102,
                        conditionValue = {35},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102361] = {
                        id = 102361,
                        name = "受到范围伤害",
                        conditionType = 102,
                        conditionValue = {36},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102371] = {
                        id = 102371,
                        name = "受到航空伤害",
                        conditionType = 102,
                        conditionValue = {37},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [102381] = {
                        id = 102381,
                        name = "受到常规伤害（非航空伤害）",
                        conditionType = 102,
                        conditionValue = {38},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [103101] = {
                        id = 103101,
                        name = "目标是战列舰",
                        conditionType = 103,
                        conditionValue = {11,12,13,14,15},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103102] = {
                        id = 103102,
                        name = "目标是非战列舰",
                        conditionType = 103,
                        conditionValue = {11,12,13,14,15},
                        compareType = 6,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103103] = {
                        id = 103103,
                        name = "交互方是战列舰",
                        conditionType = 103,
                        conditionValue = {11,12,13,14,15},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [103105] = {
                        id = 103105,
                        name = "自己是战列舰",
                        conditionType = 103,
                        conditionValue = {11,12,13,14,15},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [103201] = {
                        id = 103201,
                        name = "目标是巡洋舰",
                        conditionType = 103,
                        conditionValue = {21,22,23,24},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103202] = {
                        id = 103202,
                        name = "目标是非巡洋舰",
                        conditionType = 103,
                        conditionValue = {21,22,23,24},
                        compareType = 6,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103203] = {
                        id = 103203,
                        name = "交互方是巡洋舰",
                        conditionType = 103,
                        conditionValue = {21,22,23,24},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [103205] = {
                        id = 103205,
                        name = "自己是巡洋舰",
                        conditionType = 103,
                        conditionValue = {21,22,23,24},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [103301] = {
                        id = 103301,
                        name = "目标是驱逐舰",
                        conditionType = 103,
                        conditionValue = {31,32,33},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103302] = {
                        id = 103302,
                        name = "目标是非驱逐舰",
                        conditionType = 103,
                        conditionValue = {31,32,33},
                        compareType = 6,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103303] = {
                        id = 103303,
                        name = "交互方是驱逐舰",
                        conditionType = 103,
                        conditionValue = {31,32,33},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [103305] = {
                        id = 103305,
                        name = "自己是驱逐舰",
                        conditionType = 103,
                        conditionValue = {31,32,33},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [103401] = {
                        id = 103401,
                        name = "目标是功能舰",
                        conditionType = 103,
                        conditionValue = {41,42,43},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103402] = {
                        id = 103402,
                        name = "目标是非功能舰",
                        conditionType = 103,
                        conditionValue = {41,42,43},
                        compareType = 6,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103405] = {
                        id = 103405,
                        name = "自己是功能舰",
                        conditionType = 103,
                        conditionValue = {41,42,43},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [103501] = {
                        id = 103501,
                        name = "目标是航母",
                        conditionType = 103,
                        conditionValue = {51,52,53},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103502] = {
                        id = 103502,
                        name = "目标是非航母",
                        conditionType = 103,
                        conditionValue = {51,52,53},
                        compareType = 6,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103503] = {
                        id = 103503,
                        name = "交互方是航母（被动用）",
                        conditionType = 103,
                        conditionValue = {51,52,53},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [103504] = {
                        id = 103504,
                        name = "交互方是非航母（被动用）",
                        conditionType = 103,
                        conditionValue = {51,52,53},
                        compareType = 6,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [103505] = {
                        id = 103505,
                        name = "自己是航母",
                        conditionType = 103,
                        conditionValue = {51,52,53},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [103601] = {
                        id = 103601,
                        name = "目标是潜艇",
                        conditionType = 103,
                        conditionValue = {61,62},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103602] = {
                        id = 103602,
                        name = "目标是非潜艇",
                        conditionType = 103,
                        conditionValue = {61,62},
                        compareType = 6,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103603] = {
                        id = 103603,
                        name = "交互方是潜艇",
                        conditionType = 103,
                        conditionValue = {61,62},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [103605] = {
                        id = 103605,
                        name = "自己是潜艇",
                        conditionType = 103,
                        conditionValue = {61,62},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [103701] = {
                        id = 103701,
                        name = "交互方是航母或潜艇（被动用）",
                        conditionType = 103,
                        conditionValue = {51,52,53,61,62},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [103702] = {
                        id = 103702,
                        name = "目标是航母或潜艇",
                        conditionType = 103,
                        conditionValue = {51,52,53,61,62},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103703] = {
                        id = 103703,
                        name = "目标是驱逐或潜艇",
                        conditionType = 103,
                        conditionValue = {31,32,33,61,62},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103704] = {
                        id = 103704,
                        name = "目标是航母或战列",
                        conditionType = 103,
                        conditionValue = {11,12,13,14,15,51,52,53},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [103705] = {
                        id = 103705,
                        name = "交互方是战列或巡洋（被动用）",
                        conditionType = 103,
                        conditionValue = {11,12,13,14,15,21,22,23,24},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [103706] = {
                        id = 103706,
                        name = "交互方是巡洋、驱逐、辅助（被动用）",
                        conditionType = 103,
                        conditionValue = {21,22,23,24,31,32,33,41,42,43},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [103707] = {
                        id = 103707,
                        name = "自己是驱逐或潜艇",
                        conditionType = 103,
                        conditionValue = {31,32,33,61,62},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [103708] = {
                        id = 103708,
                        name = "交互方是驱逐或潜艇",
                        conditionType = 103,
                        conditionValue = {31,32,33,61,62},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [103709] = {
                        id = 103709,
                        name = "交互方是航母或飞行（被动用）",
                        conditionType = 103,
                        conditionValue = {51,52,53,71,72},
                        compareType = 1,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [103801] = {
                        id = 103801,
                        name = "目标不是航母或战列",
                        conditionType = 103,
                        conditionValue = {11,12,13,14,15,51,52,53},
                        compareType = 6,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [104101] = {
                        id = 104101,
                        name = "移动距离大于等于1",
                        conditionType = 104,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104102] = {
                        id = 104102,
                        name = "移动距离大于等于2",
                        conditionType = 104,
                        conditionValue = {2},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104103] = {
                        id = 104103,
                        name = "移动距离大于等于3",
                        conditionType = 104,
                        conditionValue = {3},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104104] = {
                        id = 104104,
                        name = "移动距离大于等于4",
                        conditionType = 104,
                        conditionValue = {4},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104105] = {
                        id = 104105,
                        name = "移动距离大于等于5",
                        conditionType = 104,
                        conditionValue = {5},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104106] = {
                        id = 104106,
                        name = "移动距离大于等于6",
                        conditionType = 104,
                        conditionValue = {6},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104107] = {
                        id = 104107,
                        name = "移动距离大于等于7",
                        conditionType = 104,
                        conditionValue = {7},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104108] = {
                        id = 104108,
                        name = "移动距离大于等于8",
                        conditionType = 104,
                        conditionValue = {8},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104109] = {
                        id = 104109,
                        name = "移动距离大于等于9",
                        conditionType = 104,
                        conditionValue = {9},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104110] = {
                        id = 104110,
                        name = "移动距离大于等于10",
                        conditionType = 104,
                        conditionValue = {10},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104201] = {
                        id = 104201,
                        name = "移动距离小于等于1",
                        conditionType = 104,
                        conditionValue = {1},
                        compareType = 5,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104202] = {
                        id = 104202,
                        name = "移动距离小于等于2",
                        conditionType = 104,
                        conditionValue = {2},
                        compareType = 5,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104203] = {
                        id = 104203,
                        name = "移动距离小于等于3",
                        conditionType = 104,
                        conditionValue = {3},
                        compareType = 5,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104204] = {
                        id = 104204,
                        name = "移动距离小于等于4",
                        conditionType = 104,
                        conditionValue = {4},
                        compareType = 5,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104205] = {
                        id = 104205,
                        name = "移动距离小于等于5",
                        conditionType = 104,
                        conditionValue = {5},
                        compareType = 5,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104300] = {
                        id = 104300,
                        name = "移动距离等于0（没有移动时）",
                        conditionType = 104,
                        conditionValue = {0},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104301] = {
                        id = 104301,
                        name = "移动距离等于1",
                        conditionType = 104,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104302] = {
                        id = 104302,
                        name = "移动距离等于2",
                        conditionType = 104,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104303] = {
                        id = 104303,
                        name = "移动距离等于3",
                        conditionType = 104,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104304] = {
                        id = 104304,
                        name = "移动距离等于4",
                        conditionType = 104,
                        conditionValue = {4},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104305] = {
                        id = 104305,
                        name = "移动距离等于5",
                        conditionType = 104,
                        conditionValue = {5},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104306] = {
                        id = 104306,
                        name = "移动距离等于6",
                        conditionType = 104,
                        conditionValue = {6},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104307] = {
                        id = 104307,
                        name = "移动距离等于7",
                        conditionType = 104,
                        conditionValue = {7},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104308] = {
                        id = 104308,
                        name = "移动距离等于8",
                        conditionType = 104,
                        conditionValue = {8},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104309] = {
                        id = 104309,
                        name = "移动距离等于9",
                        conditionType = 104,
                        conditionValue = {9},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104310] = {
                        id = 104310,
                        name = "移动距离等于10",
                        conditionType = 104,
                        conditionValue = {10},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104311] = {
                        id = 104311,
                        name = "移动距离等于11",
                        conditionType = 104,
                        conditionValue = {11},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [104312] = {
                        id = 104312,
                        name = "移动距离等于12",
                        conditionType = 104,
                        conditionValue = {12},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [105101] = {
                        id = 105101,
                        name = "当前技能目标（单体）与我的距离大于等于1",
                        conditionType = 105,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105102] = {
                        id = 105102,
                        name = "当前技能目标（单体）与我的距离大于等于2",
                        conditionType = 105,
                        conditionValue = {2},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105103] = {
                        id = 105103,
                        name = "当前技能目标（单体）与我的距离大于等于3",
                        conditionType = 105,
                        conditionValue = {3},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105104] = {
                        id = 105104,
                        name = "当前技能目标（单体）与我的距离大于等于4",
                        conditionType = 105,
                        conditionValue = {4},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105105] = {
                        id = 105105,
                        name = "当前技能目标（单体）与我的距离大于等于5",
                        conditionType = 105,
                        conditionValue = {5},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105201] = {
                        id = 105201,
                        name = "当前技能目标（单体）与我的距离小于等于1",
                        conditionType = 105,
                        conditionValue = {1},
                        compareType = 5,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105202] = {
                        id = 105202,
                        name = "当前技能目标（单体）与我的距离小于等于2",
                        conditionType = 105,
                        conditionValue = {2},
                        compareType = 5,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105203] = {
                        id = 105203,
                        name = "当前技能目标（单体）与我的距离小于等于3",
                        conditionType = 105,
                        conditionValue = {3},
                        compareType = 5,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105204] = {
                        id = 105204,
                        name = "当前技能目标（单体）与我的距离小于等于4",
                        conditionType = 105,
                        conditionValue = {4},
                        compareType = 5,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105301] = {
                        id = 105301,
                        name = "当前交互方与我的距离小于等于1",
                        conditionType = 105,
                        conditionValue = {1},
                        compareType = 5,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [105302] = {
                        id = 105302,
                        name = "当前交互方与我的距离小于等于2",
                        conditionType = 105,
                        conditionValue = {2},
                        compareType = 5,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [105303] = {
                        id = 105303,
                        name = "当前交互方与我的距离小于等于3",
                        conditionType = 105,
                        conditionValue = {3},
                        compareType = 5,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [105304] = {
                        id = 105304,
                        name = "当前交互方与我的距离小于等于4",
                        conditionType = 105,
                        conditionValue = {4},
                        compareType = 5,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [105401] = {
                        id = 105401,
                        name = "当前交互方与我的距离大于等于1",
                        conditionType = 105,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [105402] = {
                        id = 105402,
                        name = "当前交互方与我的距离大于等于2",
                        conditionType = 105,
                        conditionValue = {2},
                        compareType = 3,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [105403] = {
                        id = 105403,
                        name = "当前交互方与我的距离大于等于3",
                        conditionType = 105,
                        conditionValue = {3},
                        compareType = 3,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [105404] = {
                        id = 105404,
                        name = "当前交互方与我的距离大于等于4",
                        conditionType = 105,
                        conditionValue = {4},
                        compareType = 3,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [105501] = {
                        id = 105501,
                        name = "当前技能目标（单体）与我的距离等于1",
                        conditionType = 105,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105502] = {
                        id = 105502,
                        name = "当前技能目标（单体）与我的距离等于2",
                        conditionType = 105,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105503] = {
                        id = 105503,
                        name = "当前技能目标（单体）与我的距离等于3",
                        conditionType = 105,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105504] = {
                        id = 105504,
                        name = "当前技能目标（单体）与我的距离等于4",
                        conditionType = 105,
                        conditionValue = {4},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [105505] = {
                        id = 105505,
                        name = "当前技能目标（单体）与我的距离等于5",
                        conditionType = 105,
                        conditionValue = {5},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [107011] = {
                        id = 107011,
                        name = "场上我方驱逐系数量大于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 2,
                        conditionTarget = {100},
                        SiftCondition = {705},
                },

                [107012] = {
                        id = 107012,
                        name = "场上我方驱逐系数量大于2",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 2,
                        conditionTarget = {100},
                        SiftCondition = {705},
                },

                [107013] = {
                        id = 107013,
                        name = "场上我方驱逐系数量大于3",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 2,
                        conditionTarget = {100},
                        SiftCondition = {705},
                },

                [107016] = {
                        id = 107016,
                        name = "场上我方驱逐系数量小于等于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 5,
                        conditionTarget = {100},
                        SiftCondition = {705},
                },

                [107017] = {
                        id = 107017,
                        name = "场上我方驱逐系数量小于等于2",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 5,
                        conditionTarget = {100},
                        SiftCondition = {705},
                },

                [107021] = {
                        id = 107021,
                        name = "场上我方巡洋系数量大于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 2,
                        conditionTarget = {100},
                        SiftCondition = {707},
                },

                [107026] = {
                        id = 107026,
                        name = "场上我方巡洋系数量小于等于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 5,
                        conditionTarget = {100},
                        SiftCondition = {707},
                },

                [107031] = {
                        id = 107031,
                        name = "场上我方战列系数量大于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 2,
                        conditionTarget = {100},
                        SiftCondition = {701},
                },

                [107036] = {
                        id = 107036,
                        name = "场上我方战列系数量小于等于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 5,
                        conditionTarget = {100},
                        SiftCondition = {701},
                },

                [107041] = {
                        id = 107041,
                        name = "场上我方航母系数量大于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 2,
                        conditionTarget = {100},
                        SiftCondition = {704},
                },

                [107046] = {
                        id = 107046,
                        name = "场上我方航母系数量小于等于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 5,
                        conditionTarget = {100},
                        SiftCondition = {704},
                },

                [107051] = {
                        id = 107051,
                        name = "场上我方潜艇系数量大于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 2,
                        conditionTarget = {100},
                        SiftCondition = {709},
                },

                [107056] = {
                        id = 107056,
                        name = "场上我方潜艇系数量小于等于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 5,
                        conditionTarget = {100},
                        SiftCondition = {709},
                },

                [107061] = {
                        id = 107061,
                        name = "场上我方飞行系数量大于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 2,
                        conditionTarget = {100},
                        SiftCondition = {715},
                },

                [107066] = {
                        id = 107066,
                        name = "场上我方飞行系数量小于等于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 5,
                        conditionTarget = {100},
                        SiftCondition = {715},
                },

                [107071] = {
                        id = 107071,
                        name = "4格范围内任一敌方存在下潜标签",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {102},
                        SiftCondition = {904,1502},
                },

                [107101] = {
                        id = 107101,
                        name = "自身2格范围内存友军数量大于等于2",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [107102] = {
                        id = 107102,
                        name = "自身2格范围内存友军数量等于0(不存在友军）",
                        conditionType = 107,
                        conditionValue = {0},
                        compareType = 5,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [107103] = {
                        id = 107103,
                        name = "当前技能作用目标等于1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [107104] = {
                        id = 107104,
                        name = "当前技能作用目标等于2",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [107111] = {
                        id = 107111,
                        name = "单次行动中死亡敌方单位=1",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {301},
                        SiftCondition = {15},
                },

                [107112] = {
                        id = 107112,
                        name = "单次行动中死亡敌方单位=2",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {301},
                        SiftCondition = {15},
                },

                [107113] = {
                        id = 107113,
                        name = "单次行动中死亡敌方单位=3",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {301},
                        SiftCondition = {15},
                },

                [107114] = {
                        id = 107114,
                        name = "单次行动中死亡敌方单位=4",
                        conditionType = 107,
                        conditionValue = {4},
                        compareType = 1,
                        conditionTarget = {301},
                        SiftCondition = {15},
                },

                [107115] = {
                        id = 107115,
                        name = "单次行动中死亡敌方单位>=5",
                        conditionType = 107,
                        conditionValue = {5},
                        compareType = 3,
                        conditionTarget = {301},
                        SiftCondition = {15},
                },

                [10700000] = {
                        id = 10700000,
                        name = "2格范围内没有敌人",
                        conditionType = 107,
                        conditionValue = {0},
                        compareType = 1,
                        conditionTarget = {102},
                        SiftCondition = {902},
                },

                [10711102] = {
                        id = 10711102,
                        name = "2格范围内存在1名敌军",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {102},
                        SiftCondition = {902},
                },

                [10713102] = {
                        id = 10713102,
                        name = "2格范围内存在>=1名敌军",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {102},
                        SiftCondition = {902},
                },

                [10721102] = {
                        id = 10721102,
                        name = "2格范围内存在=2名敌军",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {102},
                        SiftCondition = {902},
                },

                [10723102] = {
                        id = 10723102,
                        name = "2格范围内存在>=2名敌军",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 3,
                        conditionTarget = {102},
                        SiftCondition = {902},
                },

                [10733102] = {
                        id = 10733102,
                        name = "2格范围内存在>=3名敌军",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 3,
                        conditionTarget = {102},
                        SiftCondition = {902},
                },

                [107001] = {
                        id = 107001,
                        name = "场上不存在其他友军时",
                        conditionType = 107,
                        conditionValue = {0},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {},
                },

                [107002] = {
                        id = 107002,
                        name = "场上除自身以为的航母数量>=1时",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {704},
                },

                [107003] = {
                        id = 107003,
                        name = "场上除自身以为的航母数量>=0时",
                        conditionType = 107,
                        conditionValue = {0},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {704},
                },

                [107110] = {
                        id = 107110,
                        name = "1格范围内存在0名敌军",
                        conditionType = 107,
                        conditionValue = {0},
                        compareType = 5,
                        conditionTarget = {102},
                        SiftCondition = {901},
                },

                [107100] = {
                        id = 107100,
                        name = "1格范围内没有友军",
                        conditionType = 107,
                        conditionValue = {0},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {901},
                },

                [107200] = {
                        id = 107200,
                        name = "2格范围内没有友军",
                        conditionType = 107,
                        conditionValue = {0},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [107201] = {
                        id = 107201,
                        name = "2格范围内存在1名友军",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [1072011] = {
                        id = 1072011,
                        name = "2格范围内存在1名以上友军",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [1072013] = {
                        id = 1072013,
                        name = "2格范围内存在1名及以上驱逐",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {902,705},
                },

                [1072014] = {
                        id = 1072014,
                        name = "2格范围内存在1名及以上巡洋",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {902,707},
                },

                [1072015] = {
                        id = 1072015,
                        name = "2格范围内存在1名及以上战列",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {902,701},
                },

                [1072016] = {
                        id = 1072016,
                        name = "2格范围内存在1名及以上航母",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {902,704},
                },

                [1072017] = {
                        id = 1072017,
                        name = "2格范围内存在1名及以上潜艇",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {902,709},
                },

                [1072018] = {
                        id = 1072018,
                        name = "2格范围内存在1名及以上功能",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {902,711},
                },

                [1072020] = {
                        id = 1072020,
                        name = "2格范围内存友军等于0(不存在友军）",
                        conditionType = 107,
                        conditionValue = {0},
                        compareType = 5,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [107202] = {
                        id = 107202,
                        name = "2格范围内存在2名友军",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [1072022] = {
                        id = 1072022,
                        name = "2格范围内存在2名及以上友军",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [107203] = {
                        id = 107203,
                        name = "2格范围内存在3名友军",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [1072032] = {
                        id = 1072032,
                        name = "2格范围内存在3名以上友军",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [107204] = {
                        id = 107204,
                        name = "2格范围内存在4名友军",
                        conditionType = 107,
                        conditionValue = {4},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [107205] = {
                        id = 107205,
                        name = "2格范围内存在5名以上友军",
                        conditionType = 107,
                        conditionValue = {5},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {902},
                },

                [1073101] = {
                        id = 1073101,
                        name = "3格范围内存在1名以上中破、大破敌军",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {102},
                        SiftCondition = {903,1501},
                },

                [107300] = {
                        id = 107300,
                        name = "3格范围内没有友军",
                        conditionType = 107,
                        conditionValue = {0},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {903},
                },

                [107301] = {
                        id = 107301,
                        name = "3格范围内存在1名友军",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {903},
                },

                [107302] = {
                        id = 107302,
                        name = "3格范围内存在2名友军",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {903},
                },

                [1073021] = {
                        id = 1073021,
                        name = "3格范围内存在>=2友军",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {903},
                },

                [107303] = {
                        id = 107303,
                        name = "3格范围内存在3名友军",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {903},
                },

                [107304] = {
                        id = 107304,
                        name = "3格范围内存在4名友军",
                        conditionType = 107,
                        conditionValue = {4},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {903},
                },

                [107305] = {
                        id = 107305,
                        name = "3格范围内存在5名以上友军",
                        conditionType = 107,
                        conditionValue = {5},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {903},
                },

                [107401] = {
                        id = 107401,
                        name = "4格范围内存在1名友军",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {904},
                },

                [107402] = {
                        id = 107402,
                        name = "4格范围内存在2名友军",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {904},
                },

                [107403] = {
                        id = 107403,
                        name = "4格范围内存在3名友军",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {904},
                },

                [107404] = {
                        id = 107404,
                        name = "4格范围内存在4名友军",
                        conditionType = 107,
                        conditionValue = {4},
                        compareType = 1,
                        conditionTarget = {101},
                        SiftCondition = {904},
                },

                [107405] = {
                        id = 107405,
                        name = "4格范围内存在5名以上友军",
                        conditionType = 107,
                        conditionValue = {5},
                        compareType = 3,
                        conditionTarget = {101},
                        SiftCondition = {904},
                },

                [107501] = {
                        id = 107501,
                        name = "3格范围内存在1名敌军",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {102},
                        SiftCondition = {903},
                },

                [107502] = {
                        id = 107502,
                        name = "3格范围内存在2名敌军",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {102},
                        SiftCondition = {903},
                },

                [107503] = {
                        id = 107503,
                        name = "3格范围内存在3名敌军",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {102},
                        SiftCondition = {903},
                },

                [1073031] = {
                        id = 1073031,
                        name = "3格范围内存在>=3名敌军",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 3,
                        conditionTarget = {102},
                        SiftCondition = {903},
                },

                [1079011] = {
                        id = 1079011,
                        name = "场上每存在=1个拥有【狼群战术】的友方单位",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {100},
                        SiftCondition = {1211},
                },

                [1079012] = {
                        id = 1079012,
                        name = "场上每存在=2个拥有【狼群战术】的友方单位",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {100},
                        SiftCondition = {1211},
                },

                [1079013] = {
                        id = 1079013,
                        name = "场上每存在>=3个拥有【狼群战术】的友方单位",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 3,
                        conditionTarget = {100},
                        SiftCondition = {1211},
                },

                [1079021] = {
                        id = 1079021,
                        name = "场上每存在=1个拥有【弗莱彻级】的友方单位",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {100},
                        SiftCondition = {1212},
                },

                [1079022] = {
                        id = 1079022,
                        name = "场上每存在=2个拥有【弗莱彻级】的友方单位",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {100},
                        SiftCondition = {1212},
                },

                [1079023] = {
                        id = 1079023,
                        name = "场上每存在>=3个拥有【弗莱彻级】的友方单位",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 3,
                        conditionTarget = {100},
                        SiftCondition = {1212},
                },

                [1079031] = {
                        id = 1079031,
                        name = "场上存在俾斯麦时",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {100},
                        SiftCondition = {1213},
                },

                [1079032] = {
                        id = 1079032,
                        name = "场上存在【磁性水雷】时",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {100},
                        SiftCondition = {1299},
                },

                [1079033] = {
                        id = 1079033,
                        name = "场上不存在【磁性水雷】时",
                        conditionType = 107,
                        conditionValue = {0},
                        compareType = 1,
                        conditionTarget = {100},
                        SiftCondition = {1299},
                },

                [1079041] = {
                        id = 1079041,
                        name = "技能命中1个目标时",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1079042] = {
                        id = 1079042,
                        name = "技能命中2个目标时",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1079043] = {
                        id = 1079043,
                        name = "技能命中3个目标时",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1079044] = {
                        id = 1079044,
                        name = "技能命中4个目标时",
                        conditionType = 107,
                        conditionValue = {4},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1079045] = {
                        id = 1079045,
                        name = "技能命中5个以上目标时",
                        conditionType = 107,
                        conditionValue = {5},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1079051] = {
                        id = 1079051,
                        name = "场上每存在>=1个拥有【小触手】的友方单位",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {100},
                        SiftCondition = {1295},
                },

                [1079052] = {
                        id = 1079052,
                        name = "场上每存在＜2个拥有【小触手】的友方单位",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 4,
                        conditionTarget = {100},
                        SiftCondition = {1295},
                },

                [1079053] = {
                        id = 1079053,
                        name = "场上每存在>=2个拥有【小触手】的友方单位",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 3,
                        conditionTarget = {100},
                        SiftCondition = {1295},
                },

                [1079056] = {
                        id = 1079056,
                        name = "场上每存在>=1个拥有【大触手】的友方单位",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {100},
                        SiftCondition = {1296},
                },

                [1079061] = {
                        id = 1079061,
                        name = "场上每存在=1个拥有【触手】的友方单位",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {100},
                        SiftCondition = {1297},
                },

                [1079062] = {
                        id = 1079062,
                        name = "场上每存在=2个拥有【触手】的友方单位",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {100},
                        SiftCondition = {1297},
                },

                [1079063] = {
                        id = 1079063,
                        name = "场上每存在>=3个拥有【触手】的友方单位",
                        conditionType = 107,
                        conditionValue = {3},
                        compareType = 3,
                        conditionTarget = {100},
                        SiftCondition = {1297},
                },

                [1079071] = {
                        id = 1079071,
                        name = "场上每存在=1个拥有【航空战队】的友方单位",
                        conditionType = 107,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {100},
                        SiftCondition = {1214},
                },

                [1079072] = {
                        id = 1079072,
                        name = "场上每存在>=2个拥有【航空战队】的友方单位",
                        conditionType = 107,
                        conditionValue = {2},
                        compareType = 3,
                        conditionTarget = {100},
                        SiftCondition = {1214},
                },

                [108101] = {
                        id = 108101,
                        name = "我的炮击值大于等于150",
                        conditionType = 108,
                        conditionValue = {2,324},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [109101] = {
                        id = 109101,
                        name = "我的炮击值大于等于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {2,2},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109102] = {
                        id = 109102,
                        name = "我的炮击值大于等于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {2,2},
                        compareType = 2,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109103] = {
                        id = 109103,
                        name = "我的炮击值小于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {2,2},
                        compareType = 4,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109104] = {
                        id = 109104,
                        name = "我的炮击值大于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {2,2},
                        compareType = 2,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109105] = {
                        id = 109105,
                        name = "我的炮击值小于等于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {2,2},
                        compareType = 5,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109201] = {
                        id = 109201,
                        name = "我的耐久值大于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {1,1},
                        compareType = 2,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109202] = {
                        id = 109202,
                        name = "我的耐久值大于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {1,1},
                        compareType = 2,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109203] = {
                        id = 109203,
                        name = "我的耐久值小于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {1,1},
                        compareType = 4,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109205] = {
                        id = 109205,
                        name = "我的耐久值小于等于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {1,1},
                        compareType = 5,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109301] = {
                        id = 109301,
                        name = "我的雷击值大于等于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {3,3},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109302] = {
                        id = 109302,
                        name = "我的雷击值大于等于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {3,3},
                        compareType = 3,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109303] = {
                        id = 109303,
                        name = "我的雷击值小于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {3,3},
                        compareType = 4,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109304] = {
                        id = 109304,
                        name = "我的雷击值大于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {3,3},
                        compareType = 2,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109305] = {
                        id = 109305,
                        name = "我的雷击值小于等于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {3,3},
                        compareType = 5,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109306] = {
                        id = 109306,
                        name = "我的雷击值大于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {3,3},
                        compareType = 2,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109401] = {
                        id = 109401,
                        name = "我的机动值大于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {5,5},
                        compareType = 2,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109402] = {
                        id = 109402,
                        name = "我的机动值大于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {5,5},
                        compareType = 2,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109403] = {
                        id = 109403,
                        name = "我的机动值小于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {5,5},
                        compareType = 4,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109405] = {
                        id = 109405,
                        name = "我的机动值小于等于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {5,5},
                        compareType = 5,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109501] = {
                        id = 109501,
                        name = "我的装甲值大于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {4,4},
                        compareType = 2,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109503] = {
                        id = 109503,
                        name = "我的装甲值小于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {4,4},
                        compareType = 4,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109505] = {
                        id = 109505,
                        name = "我的装甲值小于等于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {4,4},
                        compareType = 5,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109601] = {
                        id = 109601,
                        name = "我的防空值大于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {6,6},
                        compareType = 2,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109603] = {
                        id = 109603,
                        name = "我的防空值小于当前交互方（单体）",
                        conditionType = 109,
                        conditionValue = {6,6},
                        compareType = 4,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [109605] = {
                        id = 109605,
                        name = "我的防空值小于等于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {6,6},
                        compareType = 5,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109701] = {
                        id = 109701,
                        name = "我的幸运值大于当前技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {7,7},
                        compareType = 2,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109801] = {
                        id = 109801,
                        name = "我的移动力大于等于技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {10,10},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [109802] = {
                        id = 109802,
                        name = "我的移动力大于技能目标（单体）",
                        conditionType = 109,
                        conditionValue = {10,10},
                        compareType = 2,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110101] = {
                        id = 110101,
                        name = "自己生命值大于等于100%",
                        conditionType = 110,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110102] = {
                        id = 110102,
                        name = "自己生命值大于等于95%",
                        conditionType = 110,
                        conditionValue = {0.95},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110103] = {
                        id = 110103,
                        name = "自己生命值大于等于90%",
                        conditionType = 110,
                        conditionValue = {0.9},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110104] = {
                        id = 110104,
                        name = "自己生命值大于等于85%",
                        conditionType = 110,
                        conditionValue = {0.85},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110105] = {
                        id = 110105,
                        name = "自己生命值大于等于80%",
                        conditionType = 110,
                        conditionValue = {0.8},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110106] = {
                        id = 110106,
                        name = "自己生命值大于等于75%",
                        conditionType = 110,
                        conditionValue = {0.75},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110107] = {
                        id = 110107,
                        name = "自己生命值大于等于70%",
                        conditionType = 110,
                        conditionValue = {0.7},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110108] = {
                        id = 110108,
                        name = "自己生命值大于等于65%",
                        conditionType = 110,
                        conditionValue = {0.65},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110109] = {
                        id = 110109,
                        name = "自己生命值大于等于60%",
                        conditionType = 110,
                        conditionValue = {0.6},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110110] = {
                        id = 110110,
                        name = "自己生命值大于等于55%",
                        conditionType = 110,
                        conditionValue = {0.55},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110111] = {
                        id = 110111,
                        name = "自己生命值大于等于50%",
                        conditionType = 110,
                        conditionValue = {0.5},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110112] = {
                        id = 110112,
                        name = "自己生命值大于等于45%",
                        conditionType = 110,
                        conditionValue = {0.45},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110113] = {
                        id = 110113,
                        name = "自己生命值大于等于40%",
                        conditionType = 110,
                        conditionValue = {0.40},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110114] = {
                        id = 110114,
                        name = "自己生命值大于等于35%",
                        conditionType = 110,
                        conditionValue = {0.35},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110115] = {
                        id = 110115,
                        name = "自己生命值大于等于30%",
                        conditionType = 110,
                        conditionValue = {0.30},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110201] = {
                        id = 110201,
                        name = "自己生命值小于100%",
                        conditionType = 110,
                        conditionValue = {1},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110202] = {
                        id = 110202,
                        name = "自己生命值小于95%",
                        conditionType = 110,
                        conditionValue = {0.95},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110203] = {
                        id = 110203,
                        name = "自己生命值小于90%",
                        conditionType = 110,
                        conditionValue = {0.9},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110204] = {
                        id = 110204,
                        name = "自己生命值小于85%",
                        conditionType = 110,
                        conditionValue = {0.85},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110205] = {
                        id = 110205,
                        name = "自己生命值小于80%",
                        conditionType = 110,
                        conditionValue = {0.8},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110206] = {
                        id = 110206,
                        name = "自己生命值小于75%",
                        conditionType = 110,
                        conditionValue = {0.75},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110207] = {
                        id = 110207,
                        name = "自己生命值小于70%",
                        conditionType = 110,
                        conditionValue = {0.7},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110208] = {
                        id = 110208,
                        name = "自己生命值小于65%",
                        conditionType = 110,
                        conditionValue = {0.65},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110209] = {
                        id = 110209,
                        name = "自己生命值小于60%",
                        conditionType = 110,
                        conditionValue = {0.6},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110210] = {
                        id = 110210,
                        name = "自己生命值小于55%",
                        conditionType = 110,
                        conditionValue = {0.55},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110211] = {
                        id = 110211,
                        name = "自己生命值小于50%",
                        conditionType = 110,
                        conditionValue = {0.5},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110212] = {
                        id = 110212,
                        name = "自己生命值小于45%",
                        conditionType = 110,
                        conditionValue = {0.45},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110213] = {
                        id = 110213,
                        name = "自己生命值小于40%",
                        conditionType = 110,
                        conditionValue = {0.40},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110214] = {
                        id = 110214,
                        name = "自己生命值小于35%",
                        conditionType = 110,
                        conditionValue = {0.35},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110215] = {
                        id = 110215,
                        name = "自己生命值小于30%",
                        conditionType = 110,
                        conditionValue = {0.30},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [110301] = {
                        id = 110301,
                        name = "目标的耐久值大于等于100%",
                        conditionType = 110,
                        conditionValue = {1},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110302] = {
                        id = 110302,
                        name = "目标的耐久值大于等于95%",
                        conditionType = 110,
                        conditionValue = {0.95},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110303] = {
                        id = 110303,
                        name = "目标的耐久值大于等于90%",
                        conditionType = 110,
                        conditionValue = {0.9},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110304] = {
                        id = 110304,
                        name = "目标的耐久值大于等于85%",
                        conditionType = 110,
                        conditionValue = {0.85},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110305] = {
                        id = 110305,
                        name = "目标的耐久值大于等于80%",
                        conditionType = 110,
                        conditionValue = {0.8},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110306] = {
                        id = 110306,
                        name = "目标的耐久值大于等于75%",
                        conditionType = 110,
                        conditionValue = {0.75},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110307] = {
                        id = 110307,
                        name = "目标的耐久值大于等于70%",
                        conditionType = 110,
                        conditionValue = {0.7},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110308] = {
                        id = 110308,
                        name = "目标的耐久值大于等于65%",
                        conditionType = 110,
                        conditionValue = {0.65},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110309] = {
                        id = 110309,
                        name = "目标的耐久值大于等于60%",
                        conditionType = 110,
                        conditionValue = {0.6},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110310] = {
                        id = 110310,
                        name = "目标的耐久值大于等于55%",
                        conditionType = 110,
                        conditionValue = {0.55},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110311] = {
                        id = 110311,
                        name = "目标的耐久值大于等于50%",
                        conditionType = 110,
                        conditionValue = {0.5},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110312] = {
                        id = 110312,
                        name = "目标的耐久值大于等于45%",
                        conditionType = 110,
                        conditionValue = {0.45},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110313] = {
                        id = 110313,
                        name = "目标的耐久值大于等于40%",
                        conditionType = 110,
                        conditionValue = {0.40},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110314] = {
                        id = 110314,
                        name = "目标的耐久值大于等于35%",
                        conditionType = 110,
                        conditionValue = {0.35},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110315] = {
                        id = 110315,
                        name = "目标的耐久值大于等于30%",
                        conditionType = 110,
                        conditionValue = {0.30},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110401] = {
                        id = 110401,
                        name = "目标的耐久值小于100%",
                        conditionType = 110,
                        conditionValue = {1},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110402] = {
                        id = 110402,
                        name = "目标的耐久值小于95%",
                        conditionType = 110,
                        conditionValue = {0.95},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110403] = {
                        id = 110403,
                        name = "目标的耐久值小于90%",
                        conditionType = 110,
                        conditionValue = {0.9},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110404] = {
                        id = 110404,
                        name = "目标的耐久值小于85%",
                        conditionType = 110,
                        conditionValue = {0.85},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110405] = {
                        id = 110405,
                        name = "目标的耐久值小于80%",
                        conditionType = 110,
                        conditionValue = {0.8},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110406] = {
                        id = 110406,
                        name = "目标的耐久值小于75%",
                        conditionType = 110,
                        conditionValue = {0.75},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110407] = {
                        id = 110407,
                        name = "目标的耐久值小于70%",
                        conditionType = 110,
                        conditionValue = {0.7},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110408] = {
                        id = 110408,
                        name = "目标的耐久值小于65%",
                        conditionType = 110,
                        conditionValue = {0.65},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110409] = {
                        id = 110409,
                        name = "目标的耐久值小于60%",
                        conditionType = 110,
                        conditionValue = {0.6},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110410] = {
                        id = 110410,
                        name = "目标的耐久值小于55%",
                        conditionType = 110,
                        conditionValue = {0.55},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110411] = {
                        id = 110411,
                        name = "目标的耐久值小于50%",
                        conditionType = 110,
                        conditionValue = {0.5},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110412] = {
                        id = 110412,
                        name = "目标的耐久值小于45%",
                        conditionType = 110,
                        conditionValue = {0.45},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110413] = {
                        id = 110413,
                        name = "目标的耐久值小于40%",
                        conditionType = 110,
                        conditionValue = {0.40},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110414] = {
                        id = 110414,
                        name = "目标的耐久值小于35%",
                        conditionType = 110,
                        conditionValue = {0.35},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [110415] = {
                        id = 110415,
                        name = "目标的耐久值小于30%",
                        conditionType = 110,
                        conditionValue = {0.30},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [111000] = {
                        id = 111000,
                        name = "判断自己身上存在下潜标签时",
                        conditionType = 111,
                        conditionValue = {23,1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [111001] = {
                        id = 111001,
                        name = "自己身上存在1个以上增益时",
                        conditionType = 111,
                        conditionValue = {1,1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [111002] = {
                        id = 111002,
                        name = "判断身上存在下特殊潜标签时",
                        conditionType = 111,
                        conditionValue = {1001,1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [111003] = {
                        id = 111003,
                        name = "目标身上存在受到伤害增加标签",
                        conditionType = 111,
                        conditionValue = {203,1},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [111004] = {
                        id = 111004,
                        name = "自己身上不存在免死标签",
                        conditionType = 111,
                        conditionValue = {},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [111005] = {
                        id = 111005,
                        name = "自己身上不存在中破标签",
                        conditionType = 111,
                        conditionValue = {21,0},
                        compareType = 5,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [111006] = {
                        id = 111006,
                        name = "自己身上不存在大破标签",
                        conditionType = 111,
                        conditionValue = {22,0},
                        compareType = 5,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [111007] = {
                        id = 111007,
                        name = "判断自己身上不存在下潜标签时",
                        conditionType = 111,
                        conditionValue = {23,1},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [111008] = {
                        id = 111008,
                        name = "判断自己身上不存在夜间标签时",
                        conditionType = 111,
                        conditionValue = {24,1},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [111009] = {
                        id = 111009,
                        name = "判断自己身上存在夜间标签时",
                        conditionType = 111,
                        conditionValue = {24,1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [111010] = {
                        id = 111010,
                        name = "判断目标身上存在下潜标签时",
                        conditionType = 111,
                        conditionValue = {23,1},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [111011] = {
                        id = 111011,
                        name = "判断自己身上存在发生下潜事件标记",
                        conditionType = 111,
                        conditionValue = {8802002,1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11101100] = {
                        id = 11101100,
                        name = "自己身上不存在增益时",
                        conditionType = 111,
                        conditionValue = {1,0},
                        compareType = 5,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11101101] = {
                        id = 11101101,
                        name = "自己身上存在1个增益时",
                        conditionType = 111,
                        conditionValue = {1,1},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11101102] = {
                        id = 11101102,
                        name = "自己身上存在2个增益时",
                        conditionType = 111,
                        conditionValue = {1,2},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11101103] = {
                        id = 11101103,
                        name = "自己身上存在3个增益时",
                        conditionType = 111,
                        conditionValue = {1,3},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11101104] = {
                        id = 11101104,
                        name = "自己身上存在4个增益时",
                        conditionType = 111,
                        conditionValue = {1,4},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11101105] = {
                        id = 11101105,
                        name = "自己身上存在5个增益时",
                        conditionType = 111,
                        conditionValue = {1,5},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11101201] = {
                        id = 11101201,
                        name = "自己身上存在1个以上增益时",
                        conditionType = 111,
                        conditionValue = {1,1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11101202] = {
                        id = 11101202,
                        name = "自己身上存在2个以上增益时",
                        conditionType = 111,
                        conditionValue = {1,2},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11101203] = {
                        id = 11101203,
                        name = "自己身上存在3个以上增益时",
                        conditionType = 111,
                        conditionValue = {1,3},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11101204] = {
                        id = 11101204,
                        name = "自己身上存在4个以上增益时",
                        conditionType = 111,
                        conditionValue = {1,4},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11101205] = {
                        id = 11101205,
                        name = "自己身上存在5个以上增益时",
                        conditionType = 111,
                        conditionValue = {1,5},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [111014] = {
                        id = 111014,
                        name = "自己身上存在中破标签",
                        conditionType = 111,
                        conditionValue = {21,1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [111015] = {
                        id = 111015,
                        name = "自己身上存在大破标签",
                        conditionType = 111,
                        conditionValue = {22,1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110161] = {
                        id = 1110161,
                        name = "目标身上存在1个负面效果",
                        conditionType = 111,
                        conditionValue = {2,1},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1110162] = {
                        id = 1110162,
                        name = "目标身上存在2个负面效果",
                        conditionType = 111,
                        conditionValue = {2,2},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1110163] = {
                        id = 1110163,
                        name = "目标身上存在3个负面效果",
                        conditionType = 111,
                        conditionValue = {2,3},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1110164] = {
                        id = 1110164,
                        name = "目标身上存在4个负面效果",
                        conditionType = 111,
                        conditionValue = {2,4},
                        compareType = 1,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1110171] = {
                        id = 1110171,
                        name = "交互方身上存在1个以上负面效果",
                        conditionType = 111,
                        conditionValue = {2,1},
                        compareType = 3,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [1110172] = {
                        id = 1110172,
                        name = "交互方身上存在2个以上负面效果",
                        conditionType = 111,
                        conditionValue = {2,2},
                        compareType = 3,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [1110173] = {
                        id = 1110173,
                        name = "交互方身上存在3个以上负面效果",
                        conditionType = 111,
                        conditionValue = {2,3},
                        compareType = 3,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [1110174] = {
                        id = 1110174,
                        name = "交互方身上存在4个以上负面效果",
                        conditionType = 111,
                        conditionValue = {2,4},
                        compareType = 3,
                        conditionTarget = {201},
                        SiftCondition = {},
                },

                [1110181] = {
                        id = 1110181,
                        name = "目标身上存在1个以上负面效果",
                        conditionType = 111,
                        conditionValue = {2,1},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1110182] = {
                        id = 1110182,
                        name = "目标身上存在2个以上负面效果",
                        conditionType = 111,
                        conditionValue = {2,2},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1110183] = {
                        id = 1110183,
                        name = "目标身上存在3个以上负面效果",
                        conditionType = 111,
                        conditionValue = {2,3},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1110184] = {
                        id = 1110184,
                        name = "目标身上存在4个以上负面效果",
                        conditionType = 111,
                        conditionValue = {2,4},
                        compareType = 3,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [1110191] = {
                        id = 1110191,
                        name = "自己身上驱逐>=3标记",
                        conditionType = 111,
                        conditionValue = {44037010,1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110192] = {
                        id = 1110192,
                        name = "自己身上驱逐<3标记",
                        conditionType = 111,
                        conditionValue = {44037020,1},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110201] = {
                        id = 1110201,
                        name = "自己身上存在1个【绝命孤舰】",
                        conditionType = 111,
                        conditionValue = {44020011,1},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110202] = {
                        id = 1110202,
                        name = "自己身上存在2个【绝命孤舰】",
                        conditionType = 111,
                        conditionValue = {44020011,2},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110203] = {
                        id = 1110203,
                        name = "自己身上存在3个【绝命孤舰】",
                        conditionType = 111,
                        conditionValue = {44020011,3},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [11102033] = {
                        id = 11102033,
                        name = "自己身上存在【绝命孤舰】>=3",
                        conditionType = 111,
                        conditionValue = {44020011,3},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110204] = {
                        id = 1110204,
                        name = "自己身上存在4个【绝命孤舰】",
                        conditionType = 111,
                        conditionValue = {44020011,4},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110205] = {
                        id = 1110205,
                        name = "自己身上存在5个【绝命孤舰】",
                        conditionType = 111,
                        conditionValue = {44020011,5},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110211] = {
                        id = 1110211,
                        name = "自己身上存在1个【改装效果】",
                        conditionType = 111,
                        conditionValue = {4046,1},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110212] = {
                        id = 1110212,
                        name = "自己身上存在2个【改装效果】",
                        conditionType = 111,
                        conditionValue = {4046,2},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110213] = {
                        id = 1110213,
                        name = "自己身上存在3个【改装效果】",
                        conditionType = 111,
                        conditionValue = {4046,3},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110221] = {
                        id = 1110221,
                        name = "自身胜势等于5",
                        conditionType = 111,
                        conditionValue = {44041001,5},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110222] = {
                        id = 1110222,
                        name = "自身胜势等于4",
                        conditionType = 111,
                        conditionValue = {44041001,4},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110223] = {
                        id = 1110223,
                        name = "自身胜势等于3",
                        conditionType = 111,
                        conditionValue = {44041001,3},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110224] = {
                        id = 1110224,
                        name = "自身胜势等于2",
                        conditionType = 111,
                        conditionValue = {44041001,2},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110225] = {
                        id = 1110225,
                        name = "自身胜势等于1",
                        conditionType = 111,
                        conditionValue = {44041001,1},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [1110226] = {
                        id = 1110226,
                        name = "自身有“大招判断战前5层胜势”buff",
                        conditionType = 111,
                        conditionValue = {44041027,1},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [112001] = {
                        id = 112001,
                        name = "自己位于深海格子上时",
                        conditionType = 112,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [112002] = {
                        id = 112002,
                        name = "自己位于深海格子上时",
                        conditionType = 112,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [113001] = {
                        id = 113001,
                        name = "自己处于危险范围内时",
                        conditionType = 113,
                        conditionValue = {},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [113002] = {
                        id = 113002,
                        name = "自己处于危险范围外时",
                        conditionType = 113,
                        conditionValue = {},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [114001] = {
                        id = 114001,
                        name = "自己与其他目标发生过交互",
                        conditionType = 114,
                        conditionValue = {},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [114002] = {
                        id = 114002,
                        name = "自己与其他目标未发生过交互",
                        conditionType = 114,
                        conditionValue = {},
                        compareType = 6,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [115] = {
                        id = 115,
                        name = "tigger所属的技能是当前释放的技能",
                        conditionType = 115,
                        conditionValue = {},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [116001] = {
                        id = 116001,
                        name = "自己的炮击值大于雷击值时",
                        conditionType = 116,
                        conditionValue = {2,3},
                        compareType = 2,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [116002] = {
                        id = 116002,
                        name = "自己的雷击值大于炮击值时",
                        conditionType = 116,
                        conditionValue = {2,3},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [116003] = {
                        id = 116003,
                        name = "自己的装甲值大于机动值时",
                        conditionType = 116,
                        conditionValue = {4,5},
                        compareType = 2,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [116004] = {
                        id = 116004,
                        name = "自己的机动值大于装甲值时",
                        conditionType = 116,
                        conditionValue = {4,5},
                        compareType = 4,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [116005] = {
                        id = 116005,
                        name = "自己的炮击值大于等于雷击值时",
                        conditionType = 116,
                        conditionValue = {2,3},
                        compareType = 3,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [117101] = {
                        id = 117101,
                        name = "我的耐久值大于当前技能目标（单体）",
                        conditionType = 117,
                        conditionValue = {},
                        compareType = 2,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [118001] = {
                        id = 118001,
                        name = "判断tigger所属方是否死亡",
                        conditionType = 118,
                        conditionValue = {},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [118002] = {
                        id = 118002,
                        name = "判断tigger目标是否存活",
                        conditionType = 118,
                        conditionValue = {},
                        compareType = 6,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [119000] = {
                        id = 119000,
                        name = "自身剩余移动力小于等于0",
                        conditionType = 119,
                        conditionValue = {0},
                        compareType = 5,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [119001] = {
                        id = 119001,
                        name = "自身剩余移动力等于1",
                        conditionType = 119,
                        conditionValue = {1},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [119002] = {
                        id = 119002,
                        name = "自身剩余移动力等于2",
                        conditionType = 119,
                        conditionValue = {2},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [119003] = {
                        id = 119003,
                        name = "自身剩余移动力等于3",
                        conditionType = 119,
                        conditionValue = {3},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [119004] = {
                        id = 119004,
                        name = "自身剩余移动力等于4",
                        conditionType = 119,
                        conditionValue = {4},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [119005] = {
                        id = 119005,
                        name = "自身剩余移动力等于5",
                        conditionType = 119,
                        conditionValue = {5},
                        compareType = 1,
                        conditionTarget = {1},
                        SiftCondition = {},
                },

                [120001] = {
                        id = 120001,
                        name = "检测自己与当前技能作用目标处于同一直线上时",
                        conditionType = 120,
                        conditionValue = {},
                        compareType = 1,
                        conditionTarget = {202},
                        SiftCondition = {},
                },

                [120002] = {
                        id = 120002,
                        name = "检测自己与当前技能作用目标不处于同一直线上时",
                        conditionType = 120,
                        conditionValue = {},
                        compareType = 6,
                        conditionTarget = {202},
                        SiftCondition = {},
                },

                [121001] = {
                        id = 121001,
                        name = "克制目标时（克制系数>1)",
                        conditionType = 121,
                        conditionValue = {1},
                        compareType = 2,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [121002] = {
                        id = 121002,
                        name = "被目标克制时（克制系数<1)",
                        conditionType = 121,
                        conditionValue = {1},
                        compareType = 4,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

                [121003] = {
                        id = 121003,
                        name = "非克制目标时（克制系数<=1)",
                        conditionType = 121,
                        conditionValue = {1},
                        compareType = 5,
                        conditionTarget = {203},
                        SiftCondition = {},
                },

}
return EffectTriggerConditionTable