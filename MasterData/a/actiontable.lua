---@class ActionTable
---@field public id integer
---@field public group string
---@field public character integer
---@field public resource string
---@field public basicType integer
---@field public actType integer
---@field public loop integer

---@type ActionTable[]
local ActionTable = {
                [1] = {
                        id = 1,
                        group = "明石_默认",
                        character = 10004,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [2] = {
                        id = 2,
                        group = "明石_默认",
                        character = 10004,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [3] = {
                        id = 3,
                        group = "明石_生气",
                        character = 10004,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [4] = {
                        id = 4,
                        group = "明石_生气",
                        character = 10004,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [5] = {
                        id = 5,
                        group = "明石_闭眼",
                        character = 10004,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [6] = {
                        id = 6,
                        group = "明石_闭眼",
                        character = 10004,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [7] = {
                        id = 7,
                        group = "明石_笑",
                        character = 10004,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [8] = {
                        id = 8,
                        group = "明石_笑",
                        character = 10004,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [9] = {
                        id = 9,
                        group = "明石_悲伤",
                        character = 10004,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [10] = {
                        id = 10,
                        group = "明石_悲伤",
                        character = 10004,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [11] = {
                        id = 11,
                        group = "明石_害怕",
                        character = 10004,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [12] = {
                        id = 12,
                        group = "明石_害怕",
                        character = 10004,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [13] = {
                        id = 13,
                        group = "明石_害羞",
                        character = 10004,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [14] = {
                        id = 14,
                        group = "明石_害羞",
                        character = 10004,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [15] = {
                        id = 15,
                        group = "明石_害羞2",
                        character = 10004,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [16] = {
                        id = 16,
                        group = "明石_害羞2",
                        character = 10004,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [17] = {
                        id = 17,
                        group = "明石_惊讶",
                        character = 10004,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [18] = {
                        id = 18,
                        group = "明石_惊讶",
                        character = 10004,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [19] = {
                        id = 19,
                        group = "明石_嘲讽",
                        character = 10004,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [20] = {
                        id = 20,
                        group = "明石_嘲讽",
                        character = 10004,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [21] = {
                        id = 21,
                        group = "明石_财迷",
                        character = 10004,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [22] = {
                        id = 22,
                        group = "明石_财迷",
                        character = 10004,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [23] = {
                        id = 23,
                        group = "明石_前倾害羞",
                        character = 10004,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [24] = {
                        id = 24,
                        group = "明石_前倾害羞",
                        character = 10004,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [25] = {
                        id = 25,
                        group = "明石_前倾嘲讽",
                        character = 10004,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [26] = {
                        id = 26,
                        group = "明石_前倾嘲讽",
                        character = 10004,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [27] = {
                        id = 27,
                        group = "明石_前倾财迷",
                        character = 10004,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [28] = {
                        id = 28,
                        group = "明石_前倾财迷",
                        character = 10004,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [29] = {
                        id = 29,
                        group = "重庆_默认",
                        character = 10006,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [30] = {
                        id = 30,
                        group = "重庆_默认",
                        character = 10006,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [31] = {
                        id = 31,
                        group = "重庆_害羞",
                        character = 10006,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [32] = {
                        id = 32,
                        group = "重庆_害羞",
                        character = 10006,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [33] = {
                        id = 33,
                        group = "重庆_害羞2",
                        character = 10006,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [34] = {
                        id = 34,
                        group = "重庆_害羞2",
                        character = 10006,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [35] = {
                        id = 35,
                        group = "重庆_生气",
                        character = 10006,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [36] = {
                        id = 36,
                        group = "重庆_生气",
                        character = 10006,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [37] = {
                        id = 37,
                        group = "重庆_闭眼",
                        character = 10006,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [38] = {
                        id = 38,
                        group = "重庆_闭眼",
                        character = 10006,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [39] = {
                        id = 39,
                        group = "重庆_笑",
                        character = 10006,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [40] = {
                        id = 40,
                        group = "重庆_笑",
                        character = 10006,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [41] = {
                        id = 41,
                        group = "重庆_笑2",
                        character = 10006,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [42] = {
                        id = 42,
                        group = "重庆_笑2",
                        character = 10006,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [43] = {
                        id = 43,
                        group = "重庆_笑3",
                        character = 10006,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [44] = {
                        id = 44,
                        group = "重庆_笑3",
                        character = 10006,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [45] = {
                        id = 45,
                        group = "重庆_悲伤",
                        character = 10006,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [46] = {
                        id = 46,
                        group = "重庆_悲伤",
                        character = 10006,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [47] = {
                        id = 47,
                        group = "重庆_害怕",
                        character = 10006,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [48] = {
                        id = 48,
                        group = "重庆_害怕",
                        character = 10006,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [49] = {
                        id = 49,
                        group = "重庆_惊讶",
                        character = 10006,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [50] = {
                        id = 50,
                        group = "重庆_惊讶",
                        character = 10006,
                        resource = "surprise_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [51] = {
                        id = 51,
                        group = "重庆_防御害羞",
                        character = 10006,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [52] = {
                        id = 52,
                        group = "重庆_防御害羞",
                        character = 10006,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [53] = {
                        id = 53,
                        group = "重庆_防御害羞2",
                        character = 10006,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [54] = {
                        id = 54,
                        group = "重庆_防御害羞2",
                        character = 10006,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [55] = {
                        id = 55,
                        group = "重庆_防御生气",
                        character = 10006,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [56] = {
                        id = 56,
                        group = "重庆_防御生气",
                        character = 10006,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [57] = {
                        id = 57,
                        group = "重庆_防御害怕",
                        character = 10006,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [58] = {
                        id = 58,
                        group = "重庆_防御害怕",
                        character = 10006,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [59] = {
                        id = 59,
                        group = "重庆_防御杀意",
                        character = 10006,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [60] = {
                        id = 60,
                        group = "重庆_防御杀意",
                        character = 10006,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [61] = {
                        id = 61,
                        group = "基德_默认",
                        character = 10002,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [62] = {
                        id = 62,
                        group = "基德_默认",
                        character = 10002,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [63] = {
                        id = 63,
                        group = "基德_生气",
                        character = 10002,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [64] = {
                        id = 64,
                        group = "基德_生气",
                        character = 10002,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [65] = {
                        id = 65,
                        group = "基德_生气2",
                        character = 10002,
                        resource = "angry2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [66] = {
                        id = 66,
                        group = "基德_生气2",
                        character = 10002,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [67] = {
                        id = 67,
                        group = "基德_闭眼",
                        character = 10002,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [68] = {
                        id = 68,
                        group = "基德_闭眼",
                        character = 10002,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [69] = {
                        id = 69,
                        group = "基德_笑",
                        character = 10002,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [70] = {
                        id = 70,
                        group = "基德_笑",
                        character = 10002,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [71] = {
                        id = 71,
                        group = "基德_惊讶",
                        character = 10002,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [72] = {
                        id = 72,
                        group = "基德_惊讶",
                        character = 10002,
                        resource = "surprise_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [73] = {
                        id = 73,
                        group = "基德_悲伤",
                        character = 10002,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [74] = {
                        id = 74,
                        group = "基德_悲伤",
                        character = 10002,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [75] = {
                        id = 75,
                        group = "基德_耸肩悲伤",
                        character = 10002,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [76] = {
                        id = 76,
                        group = "基德_耸肩悲伤",
                        character = 10002,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [77] = {
                        id = 77,
                        group = "基德_害怕",
                        character = 10002,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [78] = {
                        id = 78,
                        group = "基德_害怕",
                        character = 10002,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [79] = {
                        id = 79,
                        group = "基德_后仰害怕",
                        character = 10002,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [80] = {
                        id = 80,
                        group = "基德_后仰害怕",
                        character = 10002,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [81] = {
                        id = 81,
                        group = "基德_害羞",
                        character = 10002,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [82] = {
                        id = 82,
                        group = "基德_害羞",
                        character = 10002,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [83] = {
                        id = 83,
                        group = "基德_害羞2",
                        character = 10002,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [84] = {
                        id = 84,
                        group = "基德_害羞2",
                        character = 10002,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [85] = {
                        id = 85,
                        group = "基德_兴奋",
                        character = 10002,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [86] = {
                        id = 86,
                        group = "基德_兴奋",
                        character = 10002,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [87] = {
                        id = 87,
                        group = "基德_星星笑",
                        character = 10002,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [88] = {
                        id = 88,
                        group = "基德_星星笑",
                        character = 10002,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [89] = {
                        id = 89,
                        group = "敦刻尔克_默认",
                        character = 10001,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [90] = {
                        id = 90,
                        group = "敦刻尔克_默认",
                        character = 10001,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [91] = {
                        id = 91,
                        group = "敦刻尔克_害羞",
                        character = 10001,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [92] = {
                        id = 92,
                        group = "敦刻尔克_害羞",
                        character = 10001,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [93] = {
                        id = 93,
                        group = "敦刻尔克_害羞2",
                        character = 10001,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [94] = {
                        id = 94,
                        group = "敦刻尔克_害羞2",
                        character = 10001,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [95] = {
                        id = 95,
                        group = "敦刻尔克_笑1",
                        character = 10001,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [96] = {
                        id = 96,
                        group = "敦刻尔克_笑1",
                        character = 10001,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [97] = {
                        id = 97,
                        group = "敦刻尔克_笑2",
                        character = 10001,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [98] = {
                        id = 98,
                        group = "敦刻尔克_笑2",
                        character = 10001,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [99] = {
                        id = 99,
                        group = "敦刻尔克_闭眼",
                        character = 10001,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [100] = {
                        id = 100,
                        group = "敦刻尔克_闭眼",
                        character = 10001,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [101] = {
                        id = 101,
                        group = "敦刻尔克_闭眼2",
                        character = 10001,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [102] = {
                        id = 102,
                        group = "敦刻尔克_闭眼2",
                        character = 10001,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [103] = {
                        id = 103,
                        group = "敦刻尔克_嫌弃",
                        character = 10001,
                        resource = "dislike_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [104] = {
                        id = 104,
                        group = "敦刻尔克_嫌弃",
                        character = 10001,
                        resource = "dislike_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [105] = {
                        id = 105,
                        group = "敦刻尔克_生气",
                        character = 10001,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [106] = {
                        id = 106,
                        group = "敦刻尔克_生气",
                        character = 10001,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [107] = {
                        id = 107,
                        group = "敦刻尔克_悲伤",
                        character = 10001,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [108] = {
                        id = 108,
                        group = "敦刻尔克_悲伤",
                        character = 10001,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [109] = {
                        id = 109,
                        group = "敦刻尔克_害怕1",
                        character = 10001,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [110] = {
                        id = 110,
                        group = "敦刻尔克_害怕1",
                        character = 10001,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [111] = {
                        id = 111,
                        group = "敦刻尔克_害怕2",
                        character = 10001,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [112] = {
                        id = 112,
                        group = "敦刻尔克_害怕2",
                        character = 10001,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [113] = {
                        id = 113,
                        group = "敦刻尔克_自信",
                        character = 10001,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [114] = {
                        id = 114,
                        group = "敦刻尔克_自信",
                        character = 10001,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [115] = {
                        id = 115,
                        group = "敦刻尔克_无语",
                        character = 10001,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [116] = {
                        id = 116,
                        group = "敦刻尔克_无语",
                        character = 10001,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [117] = {
                        id = 117,
                        group = "敦刻尔克_不满",
                        character = 10001,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [118] = {
                        id = 118,
                        group = "敦刻尔克_不满",
                        character = 10001,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [119] = {
                        id = 119,
                        group = "敦刻尔克_害怕挥扇",
                        character = 10001,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [120] = {
                        id = 120,
                        group = "敦刻尔克_害怕挥扇",
                        character = 10001,
                        resource = "touchscare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [121] = {
                        id = 121,
                        group = "敦刻尔克_自信挥扇",
                        character = 10001,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [122] = {
                        id = 122,
                        group = "敦刻尔克_自信挥扇",
                        character = 10001,
                        resource = "touchsp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [123] = {
                        id = 123,
                        group = "敦刻尔克_黑影",
                        character = 10001,
                        resource = "idle_action_dark",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [124] = {
                        id = 124,
                        group = "敦刻尔克_黑影",
                        character = 10001,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [125] = {
                        id = 125,
                        group = "吕佐夫_默认",
                        character = 10003,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [126] = {
                        id = 126,
                        group = "吕佐夫_默认",
                        character = 10003,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [127] = {
                        id = 127,
                        group = "吕佐夫_惊讶",
                        character = 10003,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [128] = {
                        id = 128,
                        group = "吕佐夫_惊讶",
                        character = 10003,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [129] = {
                        id = 129,
                        group = "吕佐夫_生气",
                        character = 10003,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [130] = {
                        id = 130,
                        group = "吕佐夫_生气",
                        character = 10003,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [131] = {
                        id = 131,
                        group = "吕佐夫_叉腰默认",
                        character = 10003,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [132] = {
                        id = 132,
                        group = "吕佐夫_叉腰默认",
                        character = 10003,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [133] = {
                        id = 133,
                        group = "吕佐夫_闭眼",
                        character = 10003,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [134] = {
                        id = 134,
                        group = "吕佐夫_闭眼",
                        character = 10003,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [135] = {
                        id = 135,
                        group = "吕佐夫_叉腰闭眼",
                        character = 10003,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [136] = {
                        id = 136,
                        group = "吕佐夫_叉腰闭眼",
                        character = 10003,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [137] = {
                        id = 137,
                        group = "吕佐夫_严肃",
                        character = 10003,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [138] = {
                        id = 138,
                        group = "吕佐夫_严肃",
                        character = 10003,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [139] = {
                        id = 139,
                        group = "吕佐夫_叉腰严肃",
                        character = 10003,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [140] = {
                        id = 140,
                        group = "吕佐夫_叉腰严肃",
                        character = 10003,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [141] = {
                        id = 141,
                        group = "吕佐夫_笑",
                        character = 10003,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [142] = {
                        id = 142,
                        group = "吕佐夫_笑",
                        character = 10003,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [143] = {
                        id = 143,
                        group = "吕佐夫_悲伤",
                        character = 10003,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [144] = {
                        id = 144,
                        group = "吕佐夫_悲伤",
                        character = 10003,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [145] = {
                        id = 145,
                        group = "吕佐夫_托腮悲伤",
                        character = 10003,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [146] = {
                        id = 146,
                        group = "吕佐夫_托腮悲伤",
                        character = 10003,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [147] = {
                        id = 147,
                        group = "吕佐夫_害怕",
                        character = 10003,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [148] = {
                        id = 148,
                        group = "吕佐夫_害怕",
                        character = 10003,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [149] = {
                        id = 149,
                        group = "吕佐夫_后仰惊讶",
                        character = 10003,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [150] = {
                        id = 150,
                        group = "吕佐夫_后仰惊讶",
                        character = 10003,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [151] = {
                        id = 151,
                        group = "吕佐夫_害羞",
                        character = 10003,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [152] = {
                        id = 152,
                        group = "吕佐夫_害羞",
                        character = 10003,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [153] = {
                        id = 153,
                        group = "吕佐夫_害羞喊叫",
                        character = 10003,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [154] = {
                        id = 154,
                        group = "吕佐夫_害羞喊叫",
                        character = 10003,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [155] = {
                        id = 155,
                        group = "吕佐夫_斜眼",
                        character = 10003,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [156] = {
                        id = 156,
                        group = "吕佐夫_斜眼",
                        character = 10003,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [157] = {
                        id = 157,
                        group = "胡德_认真",
                        character = 10007,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [158] = {
                        id = 158,
                        group = "胡德_认真",
                        character = 10007,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [159] = {
                        id = 159,
                        group = "胡德_害怕",
                        character = 10007,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [160] = {
                        id = 160,
                        group = "胡德_害怕",
                        character = 10007,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [161] = {
                        id = 161,
                        group = "胡德_惊讶",
                        character = 10007,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [162] = {
                        id = 162,
                        group = "胡德_惊讶",
                        character = 10007,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [163] = {
                        id = 163,
                        group = "胡德_笑",
                        character = 10007,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [164] = {
                        id = 164,
                        group = "胡德_笑",
                        character = 10007,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [165] = {
                        id = 165,
                        group = "胡德_笑2",
                        character = 10007,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [166] = {
                        id = 166,
                        group = "胡德_笑2",
                        character = 10007,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [167] = {
                        id = 167,
                        group = "胡德_悲伤",
                        character = 10007,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [168] = {
                        id = 168,
                        group = "胡德_悲伤",
                        character = 10007,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [169] = {
                        id = 169,
                        group = "胡德_害羞",
                        character = 10007,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [170] = {
                        id = 170,
                        group = "胡德_害羞",
                        character = 10007,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [171] = {
                        id = 171,
                        group = "胡德_问号脸",
                        character = 10007,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [172] = {
                        id = 172,
                        group = "胡德_问号脸",
                        character = 10007,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [173] = {
                        id = 173,
                        group = "胡德_默认",
                        character = 10007,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [174] = {
                        id = 174,
                        group = "胡德_默认",
                        character = 10007,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [175] = {
                        id = 175,
                        group = "胡德_闭眼1",
                        character = 10007,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [176] = {
                        id = 176,
                        group = "胡德_闭眼1",
                        character = 10007,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [177] = {
                        id = 177,
                        group = "胡德_闭眼2",
                        character = 10007,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [178] = {
                        id = 178,
                        group = "胡德_闭眼2",
                        character = 10007,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [179] = {
                        id = 179,
                        group = "胡德_生气",
                        character = 10007,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [180] = {
                        id = 180,
                        group = "胡德_生气",
                        character = 10007,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [181] = {
                        id = 181,
                        group = "胡德_警觉",
                        character = 10007,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [182] = {
                        id = 182,
                        group = "胡德_警觉",
                        character = 10007,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [183] = {
                        id = 183,
                        group = "胡德_严肃",
                        character = 10007,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [184] = {
                        id = 184,
                        group = "胡德_严肃",
                        character = 10007,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [185] = {
                        id = 185,
                        group = "胡德_严肃2",
                        character = 10007,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [186] = {
                        id = 186,
                        group = "胡德_严肃2",
                        character = 10007,
                        resource = "serious2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [187] = {
                        id = 187,
                        group = "胡德_慌张",
                        character = 10007,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [188] = {
                        id = 188,
                        group = "胡德_慌张",
                        character = 10007,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [189] = {
                        id = 189,
                        group = "胡德_抱猫笑",
                        character = 10007,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [190] = {
                        id = 190,
                        group = "胡德_抱猫笑",
                        character = 10007,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [191] = {
                        id = 191,
                        group = "胡德_抱猫害羞",
                        character = 10007,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [192] = {
                        id = 192,
                        group = "胡德_抱猫害羞",
                        character = 10007,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [193] = {
                        id = 193,
                        group = "胡德_默认害怕",
                        character = 10007,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [194] = {
                        id = 194,
                        group = "胡德_默认害怕",
                        character = 10007,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [195] = {
                        id = 195,
                        group = "胡德_默认惊讶",
                        character = 10007,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [196] = {
                        id = 196,
                        group = "胡德_默认惊讶",
                        character = 10007,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [197] = {
                        id = 197,
                        group = "胡德_默认悲伤",
                        character = 10007,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [198] = {
                        id = 198,
                        group = "胡德_默认悲伤",
                        character = 10007,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [199] = {
                        id = 199,
                        group = "胡德_无猫害怕",
                        character = 10007,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [200] = {
                        id = 200,
                        group = "胡德_无猫害怕",
                        character = 10007,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [201] = {
                        id = 201,
                        group = "胡德_无猫惊讶",
                        character = 10007,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [202] = {
                        id = 202,
                        group = "胡德_无猫惊讶",
                        character = 10007,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [203] = {
                        id = 203,
                        group = "胡德_无猫笑",
                        character = 10007,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [204] = {
                        id = 204,
                        group = "胡德_无猫笑",
                        character = 10007,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [205] = {
                        id = 205,
                        group = "胡德_无猫悲伤",
                        character = 10007,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [206] = {
                        id = 206,
                        group = "胡德_无猫悲伤",
                        character = 10007,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [207] = {
                        id = 207,
                        group = "胡德_无猫害羞",
                        character = 10007,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [208] = {
                        id = 208,
                        group = "胡德_无猫害羞",
                        character = 10007,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [209] = {
                        id = 209,
                        group = "胡德_无猫问号脸",
                        character = 10007,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [210] = {
                        id = 210,
                        group = "胡德_无猫问号脸",
                        character = 10007,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [211] = {
                        id = 211,
                        group = "胡德_无猫默认",
                        character = 10007,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [212] = {
                        id = 212,
                        group = "胡德_无猫默认",
                        character = 10007,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [213] = {
                        id = 213,
                        group = "胡德_无猫闭眼",
                        character = 10007,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [214] = {
                        id = 214,
                        group = "胡德_无猫闭眼",
                        character = 10007,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [215] = {
                        id = 215,
                        group = "胡德_无猫生气",
                        character = 10007,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [216] = {
                        id = 216,
                        group = "胡德_无猫生气",
                        character = 10007,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [217] = {
                        id = 217,
                        group = "胡德_无猫认真",
                        character = 10007,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [218] = {
                        id = 218,
                        group = "胡德_无猫认真",
                        character = 10007,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [219] = {
                        id = 219,
                        group = "指挥官_默认",
                        character = 999,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [220] = {
                        id = 220,
                        group = "指挥官_默认",
                        character = 999,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [221] = {
                        id = 221,
                        group = "艾塔_默认",
                        character = 10000,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [222] = {
                        id = 222,
                        group = "艾塔_默认",
                        character = 10000,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [223] = {
                        id = 223,
                        group = "艾塔_惊讶1",
                        character = 10000,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [224] = {
                        id = 224,
                        group = "艾塔_惊讶1",
                        character = 10000,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [225] = {
                        id = 225,
                        group = "艾塔_惊讶2",
                        character = 10000,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [226] = {
                        id = 226,
                        group = "艾塔_惊讶2",
                        character = 10000,
                        resource = "amazed2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [227] = {
                        id = 227,
                        group = "艾塔_生气",
                        character = 10000,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [228] = {
                        id = 228,
                        group = "艾塔_生气",
                        character = 10000,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [229] = {
                        id = 229,
                        group = "艾塔_严肃",
                        character = 10000,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [230] = {
                        id = 230,
                        group = "艾塔_严肃",
                        character = 10000,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [231] = {
                        id = 231,
                        group = "艾塔_闭眼",
                        character = 10000,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [232] = {
                        id = 232,
                        group = "艾塔_闭眼",
                        character = 10000,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [233] = {
                        id = 233,
                        group = "艾塔_笑",
                        character = 10000,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [234] = {
                        id = 234,
                        group = "艾塔_笑",
                        character = 10000,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [235] = {
                        id = 235,
                        group = "艾塔_悲伤",
                        character = 10000,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [236] = {
                        id = 236,
                        group = "艾塔_悲伤",
                        character = 10000,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [237] = {
                        id = 237,
                        group = "艾塔_害怕",
                        character = 10000,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [238] = {
                        id = 238,
                        group = "艾塔_害怕",
                        character = 10000,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [239] = {
                        id = 239,
                        group = "艾塔_害羞",
                        character = 10000,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [240] = {
                        id = 240,
                        group = "艾塔_害羞",
                        character = 10000,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [241] = {
                        id = 241,
                        group = "艾塔_闪星星笑",
                        character = 10000,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [242] = {
                        id = 242,
                        group = "艾塔_闪星星笑",
                        character = 10000,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [243] = {
                        id = 243,
                        group = "艾塔_闪花笑",
                        character = 10000,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [244] = {
                        id = 244,
                        group = "艾塔_闪花笑",
                        character = 10000,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [245] = {
                        id = 245,
                        group = "艾塔_害羞笑",
                        character = 10000,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [246] = {
                        id = 246,
                        group = "艾塔_害羞笑",
                        character = 10000,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [247] = {
                        id = 247,
                        group = "艾塔_闪花害羞笑",
                        character = 10000,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [248] = {
                        id = 248,
                        group = "艾塔_闪花害羞笑",
                        character = 10000,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [249] = {
                        id = 249,
                        group = "艾塔_装傻",
                        character = 10000,
                        resource = "sp4_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [250] = {
                        id = 250,
                        group = "艾塔_装傻",
                        character = 10000,
                        resource = "sp4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [251] = {
                        id = 251,
                        group = "U81_默认",
                        character = 10009,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [252] = {
                        id = 252,
                        group = "U81_默认",
                        character = 10009,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [253] = {
                        id = 253,
                        group = "U81_直立笑",
                        character = 10009,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [254] = {
                        id = 254,
                        group = "U81_直立笑",
                        character = 10009,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [255] = {
                        id = 255,
                        group = "U81_闭眼",
                        character = 10009,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [256] = {
                        id = 256,
                        group = "U81_闭眼",
                        character = 10009,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [257] = {
                        id = 257,
                        group = "U81_嫌弃",
                        character = 10009,
                        resource = "dislike_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [258] = {
                        id = 258,
                        group = "U81_嫌弃",
                        character = 10009,
                        resource = "dislike_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [259] = {
                        id = 259,
                        group = "U81_直立生气",
                        character = 10009,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [260] = {
                        id = 260,
                        group = "U81_直立生气",
                        character = 10009,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [261] = {
                        id = 261,
                        group = "U81_悲伤",
                        character = 10009,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [262] = {
                        id = 262,
                        group = "U81_悲伤",
                        character = 10009,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [263] = {
                        id = 263,
                        group = "U81_流泪",
                        character = 10009,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [264] = {
                        id = 264,
                        group = "U81_流泪",
                        character = 10009,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [265] = {
                        id = 265,
                        group = "U81_直立害怕",
                        character = 10009,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [266] = {
                        id = 266,
                        group = "U81_直立害怕",
                        character = 10009,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [267] = {
                        id = 267,
                        group = "U81_蜷缩害羞",
                        character = 10009,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [268] = {
                        id = 268,
                        group = "U81_蜷缩害羞",
                        character = 10009,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [269] = {
                        id = 269,
                        group = "U81_眯眼生气",
                        character = 10009,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [270] = {
                        id = 270,
                        group = "U81_眯眼生气",
                        character = 10009,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [271] = {
                        id = 271,
                        group = "U81_无奈叹气",
                        character = 10009,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [272] = {
                        id = 272,
                        group = "U81_无奈叹气",
                        character = 10009,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [273] = {
                        id = 273,
                        group = "U81_笑",
                        character = 10009,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [274] = {
                        id = 274,
                        group = "U81_笑",
                        character = 10009,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [275] = {
                        id = 275,
                        group = "U81_害羞",
                        character = 10009,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [276] = {
                        id = 276,
                        group = "U81_害羞",
                        character = 10009,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [277] = {
                        id = 277,
                        group = "赤城_默认",
                        character = 10008,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [278] = {
                        id = 278,
                        group = "赤城_默认",
                        character = 10008,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [279] = {
                        id = 279,
                        group = "赤城_笑",
                        character = 10008,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [280] = {
                        id = 280,
                        group = "赤城_笑",
                        character = 10008,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [281] = {
                        id = 281,
                        group = "赤城_摇摆笑",
                        character = 10008,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [282] = {
                        id = 282,
                        group = "赤城_摇摆笑",
                        character = 10008,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [283] = {
                        id = 283,
                        group = "赤城_闭眼",
                        character = 10008,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [284] = {
                        id = 284,
                        group = "赤城_闭眼",
                        character = 10008,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [285] = {
                        id = 285,
                        group = "赤城_生气",
                        character = 10008,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [286] = {
                        id = 286,
                        group = "赤城_生气",
                        character = 10008,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [287] = {
                        id = 287,
                        group = "赤城_悲伤",
                        character = 10008,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [288] = {
                        id = 288,
                        group = "赤城_悲伤",
                        character = 10008,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [289] = {
                        id = 289,
                        group = "赤城_耸肩悲伤",
                        character = 10008,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [290] = {
                        id = 290,
                        group = "赤城_耸肩悲伤",
                        character = 10008,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [291] = {
                        id = 291,
                        group = "赤城_害怕",
                        character = 10008,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [292] = {
                        id = 292,
                        group = "赤城_害怕",
                        character = 10008,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [293] = {
                        id = 293,
                        group = "赤城_后仰害怕",
                        character = 10008,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [294] = {
                        id = 294,
                        group = "赤城_后仰害怕",
                        character = 10008,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [295] = {
                        id = 295,
                        group = "赤城_害羞",
                        character = 10008,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [296] = {
                        id = 296,
                        group = "赤城_害羞",
                        character = 10008,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [297] = {
                        id = 297,
                        group = "赤城_垂肩害羞",
                        character = 10008,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [298] = {
                        id = 298,
                        group = "赤城_垂肩害羞",
                        character = 10008,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [299] = {
                        id = 299,
                        group = "赤城_惊讶",
                        character = 10008,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [300] = {
                        id = 300,
                        group = "赤城_惊讶",
                        character = 10008,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [301] = {
                        id = 301,
                        group = "赤城_倾斜惊讶",
                        character = 10008,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [302] = {
                        id = 302,
                        group = "赤城_倾斜惊讶",
                        character = 10008,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [303] = {
                        id = 303,
                        group = "赤城_得意",
                        character = 10008,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [304] = {
                        id = 304,
                        group = "赤城_得意",
                        character = 10008,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [305] = {
                        id = 305,
                        group = "赤城_闭眼2",
                        character = 10008,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [306] = {
                        id = 306,
                        group = "赤城_闭眼2",
                        character = 10008,
                        resource = "closeeye2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [307] = {
                        id = 307,
                        group = "托戈_默认",
                        character = 10010,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [308] = {
                        id = 308,
                        group = "托戈_默认",
                        character = 10010,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [309] = {
                        id = 309,
                        group = "托戈_笑",
                        character = 10010,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [310] = {
                        id = 310,
                        group = "托戈_笑",
                        character = 10010,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [311] = {
                        id = 311,
                        group = "托戈_闭眼",
                        character = 10010,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [312] = {
                        id = 312,
                        group = "托戈_闭眼",
                        character = 10010,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [313] = {
                        id = 313,
                        group = "托戈_生气",
                        character = 10010,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [314] = {
                        id = 314,
                        group = "托戈_生气",
                        character = 10010,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [315] = {
                        id = 315,
                        group = "托戈_悲伤",
                        character = 10010,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [316] = {
                        id = 316,
                        group = "托戈_悲伤",
                        character = 10010,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [317] = {
                        id = 317,
                        group = "托戈_害怕",
                        character = 10010,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [318] = {
                        id = 318,
                        group = "托戈_害怕",
                        character = 10010,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [319] = {
                        id = 319,
                        group = "托戈_害羞",
                        character = 10010,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [320] = {
                        id = 320,
                        group = "托戈_害羞",
                        character = 10010,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [321] = {
                        id = 321,
                        group = "托戈_惊讶",
                        character = 10010,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [322] = {
                        id = 322,
                        group = "托戈_惊讶",
                        character = 10010,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [323] = {
                        id = 323,
                        group = "托戈_鄙视",
                        character = 10010,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [324] = {
                        id = 324,
                        group = "托戈_鄙视",
                        character = 10010,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [325] = {
                        id = 325,
                        group = "托戈_闭眼悲伤",
                        character = 10010,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [326] = {
                        id = 326,
                        group = "托戈_闭眼悲伤",
                        character = 10010,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [327] = {
                        id = 327,
                        group = "托戈_得意",
                        character = 10010,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [328] = {
                        id = 328,
                        group = "托戈_得意",
                        character = 10010,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [329] = {
                        id = 329,
                        group = "托戈_摇晃笑",
                        character = 10010,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [330] = {
                        id = 330,
                        group = "托戈_摇晃笑",
                        character = 10010,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [331] = {
                        id = 331,
                        group = "托戈_防御害怕",
                        character = 10010,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [332] = {
                        id = 332,
                        group = "托戈_防御害怕",
                        character = 10010,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [333] = {
                        id = 333,
                        group = "托戈_扭捏害羞",
                        character = 10010,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [334] = {
                        id = 334,
                        group = "托戈_扭捏害羞",
                        character = 10010,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [335] = {
                        id = 335,
                        group = "托戈_耸肩悲伤",
                        character = 10010,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [336] = {
                        id = 336,
                        group = "托戈_耸肩悲伤",
                        character = 10010,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [337] = {
                        id = 337,
                        group = "长春_默认",
                        character = 10015,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [338] = {
                        id = 338,
                        group = "长春_默认",
                        character = 10015,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [339] = {
                        id = 339,
                        group = "长春_笑",
                        character = 10015,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [340] = {
                        id = 340,
                        group = "长春_笑",
                        character = 10015,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [341] = {
                        id = 341,
                        group = "长春_闭眼",
                        character = 10015,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [342] = {
                        id = 342,
                        group = "长春_闭眼",
                        character = 10015,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [343] = {
                        id = 343,
                        group = "长春_生气",
                        character = 10015,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [344] = {
                        id = 344,
                        group = "长春_生气",
                        character = 10015,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [345] = {
                        id = 345,
                        group = "长春_悲伤",
                        character = 10015,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [346] = {
                        id = 346,
                        group = "长春_悲伤",
                        character = 10015,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [347] = {
                        id = 347,
                        group = "长春_害怕",
                        character = 10015,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [348] = {
                        id = 348,
                        group = "长春_害怕",
                        character = 10015,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [349] = {
                        id = 349,
                        group = "长春_害羞",
                        character = 10015,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [350] = {
                        id = 350,
                        group = "长春_害羞",
                        character = 10015,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [351] = {
                        id = 351,
                        group = "长春_自信",
                        character = 10015,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [352] = {
                        id = 352,
                        group = "长春_自信",
                        character = 10015,
                        resource = "confidence_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [353] = {
                        id = 353,
                        group = "长春_自信2",
                        character = 10015,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [354] = {
                        id = 354,
                        group = "长春_自信2",
                        character = 10015,
                        resource = "confidence2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [355] = {
                        id = 355,
                        group = "长春_摇摆笑",
                        character = 10015,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [356] = {
                        id = 356,
                        group = "长春_摇摆笑",
                        character = 10015,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [357] = {
                        id = 357,
                        group = "长春_流汗",
                        character = 10015,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [358] = {
                        id = 358,
                        group = "长春_流汗",
                        character = 10015,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [359] = {
                        id = 359,
                        group = "长春_背手流汗",
                        character = 10015,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [360] = {
                        id = 360,
                        group = "长春_背手流汗",
                        character = 10015,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [361] = {
                        id = 361,
                        group = "克利俄_默认",
                        character = 20000,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [362] = {
                        id = 362,
                        group = "克利俄_默认",
                        character = 20000,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [363] = {
                        id = 363,
                        group = "克利俄_笑",
                        character = 20000,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [364] = {
                        id = 364,
                        group = "克利俄_笑",
                        character = 20000,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [365] = {
                        id = 365,
                        group = "克利俄_闭眼",
                        character = 20000,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [366] = {
                        id = 366,
                        group = "克利俄_闭眼",
                        character = 20000,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [367] = {
                        id = 367,
                        group = "克利俄_生气",
                        character = 20000,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [368] = {
                        id = 368,
                        group = "克利俄_生气",
                        character = 20000,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [369] = {
                        id = 369,
                        group = "克利俄_悲伤",
                        character = 20000,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [370] = {
                        id = 370,
                        group = "克利俄_悲伤",
                        character = 20000,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [371] = {
                        id = 371,
                        group = "克利俄_害怕",
                        character = 20000,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [372] = {
                        id = 372,
                        group = "克利俄_害怕",
                        character = 20000,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [373] = {
                        id = 373,
                        group = "克利俄_害羞1",
                        character = 20000,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [374] = {
                        id = 374,
                        group = "克利俄_害羞1",
                        character = 20000,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [375] = {
                        id = 375,
                        group = "克利俄_害羞2",
                        character = 20000,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [376] = {
                        id = 376,
                        group = "克利俄_害羞2",
                        character = 20000,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [377] = {
                        id = 377,
                        group = "克利俄_害羞3",
                        character = 20000,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [378] = {
                        id = 378,
                        group = "克利俄_害羞3",
                        character = 20000,
                        resource = "shy3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [379] = {
                        id = 379,
                        group = "克利俄_惊讶",
                        character = 20000,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [380] = {
                        id = 380,
                        group = "克利俄_惊讶",
                        character = 20000,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [381] = {
                        id = 381,
                        group = "克利俄_后仰惊讶",
                        character = 20000,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [382] = {
                        id = 382,
                        group = "克利俄_后仰惊讶",
                        character = 20000,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [383] = {
                        id = 383,
                        group = "克利俄_无语",
                        character = 20000,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [384] = {
                        id = 384,
                        group = "克利俄_无语",
                        character = 20000,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [385] = {
                        id = 385,
                        group = "克利俄_难为情",
                        character = 20000,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [386] = {
                        id = 386,
                        group = "克利俄_难为情",
                        character = 20000,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [387] = {
                        id = 387,
                        group = "威尔士亲王_默认",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [388] = {
                        id = 388,
                        group = "威尔士亲王_默认",
                        character = 10005,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [389] = {
                        id = 389,
                        group = "威尔士亲王_笑",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [390] = {
                        id = 390,
                        group = "威尔士亲王_笑",
                        character = 10005,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [391] = {
                        id = 391,
                        group = "威尔士亲王_闭眼",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [392] = {
                        id = 392,
                        group = "威尔士亲王_闭眼",
                        character = 10005,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [393] = {
                        id = 393,
                        group = "威尔士亲王_生气",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [394] = {
                        id = 394,
                        group = "威尔士亲王_生气",
                        character = 10005,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [395] = {
                        id = 395,
                        group = "威尔士亲王_生气2",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [396] = {
                        id = 396,
                        group = "威尔士亲王_生气2",
                        character = 10005,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [397] = {
                        id = 397,
                        group = "威尔士亲王_悲伤",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [398] = {
                        id = 398,
                        group = "威尔士亲王_悲伤",
                        character = 10005,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [399] = {
                        id = 399,
                        group = "威尔士亲王_害怕",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [400] = {
                        id = 400,
                        group = "威尔士亲王_害怕",
                        character = 10005,
                        resource = "scared_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [401] = {
                        id = 401,
                        group = "威尔士亲王_害羞",
                        character = 10005,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [402] = {
                        id = 402,
                        group = "威尔士亲王_害羞",
                        character = 10005,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [403] = {
                        id = 403,
                        group = "威尔士亲王_惊讶",
                        character = 10005,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [404] = {
                        id = 404,
                        group = "威尔士亲王_惊讶",
                        character = 10005,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [405] = {
                        id = 405,
                        group = "威尔士亲王_惊讶2",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [406] = {
                        id = 406,
                        group = "威尔士亲王_惊讶2",
                        character = 10005,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [407] = {
                        id = 407,
                        group = "威尔士亲王_惊讶3",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [408] = {
                        id = 408,
                        group = "威尔士亲王_惊讶3",
                        character = 10005,
                        resource = "amazed2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [409] = {
                        id = 409,
                        group = "威尔士亲王_惊讶4",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [410] = {
                        id = 410,
                        group = "威尔士亲王_惊讶4",
                        character = 10005,
                        resource = "amazed3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [411] = {
                        id = 411,
                        group = "威尔士亲王_严肃",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [412] = {
                        id = 412,
                        group = "威尔士亲王_严肃",
                        character = 10005,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [413] = {
                        id = 413,
                        group = "威尔士亲王_严肃2",
                        character = 10005,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [414] = {
                        id = 414,
                        group = "威尔士亲王_严肃2",
                        character = 10005,
                        resource = "serious2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [415] = {
                        id = 415,
                        group = "威尔士亲王_备战",
                        character = 10005,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [416] = {
                        id = 416,
                        group = "威尔士亲王_备战",
                        character = 10005,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [417] = {
                        id = 417,
                        group = "威尔士亲王_难过",
                        character = 10005,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [418] = {
                        id = 418,
                        group = "威尔士亲王_难过",
                        character = 10005,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [419] = {
                        id = 419,
                        group = "威尔士亲王_甩剑",
                        character = 10005,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [420] = {
                        id = 420,
                        group = "威尔士亲王_甩剑",
                        character = 10005,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [421] = {
                        id = 421,
                        group = "威尔士亲王_耸肩悲伤",
                        character = 10005,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [422] = {
                        id = 422,
                        group = "威尔士亲王_耸肩悲伤",
                        character = 10005,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [423] = {
                        id = 423,
                        group = "威尔士亲王_后仰害怕",
                        character = 10005,
                        resource = "scared_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [424] = {
                        id = 424,
                        group = "威尔士亲王_后仰害怕",
                        character = 10005,
                        resource = "scared_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [425] = {
                        id = 425,
                        group = "威尔士亲王_背手笑",
                        character = 10005,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [426] = {
                        id = 426,
                        group = "威尔士亲王_背手笑",
                        character = 10005,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [427] = {
                        id = 427,
                        group = "昆西_默认",
                        character = 10013,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [428] = {
                        id = 428,
                        group = "昆西_默认",
                        character = 10013,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [429] = {
                        id = 429,
                        group = "昆西_笑",
                        character = 10013,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [430] = {
                        id = 430,
                        group = "昆西_笑",
                        character = 10013,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [431] = {
                        id = 431,
                        group = "昆西_闪花笑",
                        character = 10013,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [432] = {
                        id = 432,
                        group = "昆西_闪花笑",
                        character = 10013,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [433] = {
                        id = 433,
                        group = "昆西_闭眼",
                        character = 10013,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [434] = {
                        id = 434,
                        group = "昆西_闭眼",
                        character = 10013,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [435] = {
                        id = 435,
                        group = "昆西_生气",
                        character = 10013,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [436] = {
                        id = 436,
                        group = "昆西_生气",
                        character = 10013,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [437] = {
                        id = 437,
                        group = "昆西_悲伤",
                        character = 10013,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [438] = {
                        id = 438,
                        group = "昆西_悲伤",
                        character = 10013,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [439] = {
                        id = 439,
                        group = "昆西_害怕",
                        character = 10013,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [440] = {
                        id = 440,
                        group = "昆西_害怕",
                        character = 10013,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [441] = {
                        id = 441,
                        group = "昆西_害羞",
                        character = 10013,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [442] = {
                        id = 442,
                        group = "昆西_害羞",
                        character = 10013,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [443] = {
                        id = 443,
                        group = "昆西_害羞2",
                        character = 10013,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [444] = {
                        id = 444,
                        group = "昆西_害羞2",
                        character = 10013,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [445] = {
                        id = 445,
                        group = "昆西_困惑",
                        character = 10013,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [446] = {
                        id = 446,
                        group = "昆西_困惑",
                        character = 10013,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [447] = {
                        id = 447,
                        group = "昆西_问号困惑",
                        character = 10013,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [448] = {
                        id = 448,
                        group = "昆西_问号困惑",
                        character = 10013,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [449] = {
                        id = 449,
                        group = "昆西_呆愣",
                        character = 10013,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [450] = {
                        id = 450,
                        group = "昆西_呆愣",
                        character = 10013,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [451] = {
                        id = 451,
                        group = "昆西_标志表情",
                        character = 10013,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [452] = {
                        id = 452,
                        group = "昆西_标志表情",
                        character = 10013,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [453] = {
                        id = 453,
                        group = "昆西_闪星标志表情",
                        character = 10013,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [454] = {
                        id = 454,
                        group = "昆西_闪星标志表情",
                        character = 10013,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [455] = {
                        id = 455,
                        group = "昆西_羡慕",
                        character = 10013,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [456] = {
                        id = 456,
                        group = "昆西_羡慕",
                        character = 10013,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [457] = {
                        id = 457,
                        group = "昆西_闪花羡慕",
                        character = 10013,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [458] = {
                        id = 458,
                        group = "昆西_闪花羡慕",
                        character = 10013,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [459] = {
                        id = 459,
                        group = "昆西_敬礼",
                        character = 10013,
                        resource = "touch1_idle",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [460] = {
                        id = 460,
                        group = "昆西_敬礼",
                        character = 10013,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [461] = {
                        id = 461,
                        group = "昆西_后仰害怕",
                        character = 10013,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [462] = {
                        id = 462,
                        group = "昆西_后仰害怕",
                        character = 10013,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [463] = {
                        id = 463,
                        group = "昆西_歪头害羞",
                        character = 10013,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [464] = {
                        id = 464,
                        group = "昆西_歪头害羞",
                        character = 10013,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [465] = {
                        id = 465,
                        group = "昆西_歪头害羞2",
                        character = 10013,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [466] = {
                        id = 466,
                        group = "昆西_歪头害羞2",
                        character = 10013,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [467] = {
                        id = 467,
                        group = "昆西_耸肩悲伤",
                        character = 10013,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [468] = {
                        id = 468,
                        group = "昆西_耸肩悲伤",
                        character = 10013,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [469] = {
                        id = 469,
                        group = "皇家方舟_默认",
                        character = 10014,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [470] = {
                        id = 470,
                        group = "皇家方舟_默认",
                        character = 10014,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [471] = {
                        id = 471,
                        group = "皇家方舟_笑",
                        character = 10014,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [472] = {
                        id = 472,
                        group = "皇家方舟_笑",
                        character = 10014,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [473] = {
                        id = 473,
                        group = "皇家方舟_闭眼",
                        character = 10014,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [474] = {
                        id = 474,
                        group = "皇家方舟_闭眼",
                        character = 10014,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [475] = {
                        id = 475,
                        group = "皇家方舟_生气",
                        character = 10014,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [476] = {
                        id = 476,
                        group = "皇家方舟_生气",
                        character = 10014,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [477] = {
                        id = 477,
                        group = "皇家方舟_悲伤",
                        character = 10014,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [478] = {
                        id = 478,
                        group = "皇家方舟_悲伤",
                        character = 10014,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [479] = {
                        id = 479,
                        group = "皇家方舟_害怕",
                        character = 10014,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [480] = {
                        id = 480,
                        group = "皇家方舟_害怕",
                        character = 10014,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [481] = {
                        id = 481,
                        group = "皇家方舟_害羞",
                        character = 10014,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [482] = {
                        id = 482,
                        group = "皇家方舟_害羞",
                        character = 10014,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [483] = {
                        id = 483,
                        group = "皇家方舟_惊讶",
                        character = 10014,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [484] = {
                        id = 484,
                        group = "皇家方舟_惊讶",
                        character = 10014,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [485] = {
                        id = 485,
                        group = "皇家方舟_得意",
                        character = 10014,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [486] = {
                        id = 486,
                        group = "皇家方舟_得意",
                        character = 10014,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [487] = {
                        id = 487,
                        group = "皇家方舟_后仰害怕",
                        character = 10014,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [488] = {
                        id = 488,
                        group = "皇家方舟_后仰害怕",
                        character = 10014,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [489] = {
                        id = 489,
                        group = "皇家方舟_摇晃笑",
                        character = 10014,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [490] = {
                        id = 490,
                        group = "皇家方舟_摇晃笑",
                        character = 10014,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [491] = {
                        id = 491,
                        group = "皇家方舟_笑2",
                        character = 10014,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [492] = {
                        id = 492,
                        group = "皇家方舟_笑2",
                        character = 10014,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [493] = {
                        id = 493,
                        group = "弗莱彻_默认",
                        character = 10016,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [494] = {
                        id = 494,
                        group = "弗莱彻_默认",
                        character = 10016,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [495] = {
                        id = 495,
                        group = "弗莱彻_笑",
                        character = 10016,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [496] = {
                        id = 496,
                        group = "弗莱彻_笑",
                        character = 10016,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [497] = {
                        id = 497,
                        group = "弗莱彻_闭眼",
                        character = 10016,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [498] = {
                        id = 498,
                        group = "弗莱彻_闭眼",
                        character = 10016,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [499] = {
                        id = 499,
                        group = "弗莱彻_生气",
                        character = 10016,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [500] = {
                        id = 500,
                        group = "弗莱彻_生气",
                        character = 10016,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [501] = {
                        id = 501,
                        group = "弗莱彻_悲伤",
                        character = 10016,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [502] = {
                        id = 502,
                        group = "弗莱彻_悲伤",
                        character = 10016,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [503] = {
                        id = 503,
                        group = "弗莱彻_悲伤2",
                        character = 10016,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [504] = {
                        id = 504,
                        group = "弗莱彻_悲伤2",
                        character = 10016,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [505] = {
                        id = 505,
                        group = "弗莱彻_害怕",
                        character = 10016,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [506] = {
                        id = 506,
                        group = "弗莱彻_害怕",
                        character = 10016,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [507] = {
                        id = 507,
                        group = "弗莱彻_害羞",
                        character = 10016,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [508] = {
                        id = 508,
                        group = "弗莱彻_害羞",
                        character = 10016,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [509] = {
                        id = 509,
                        group = "弗莱彻_惊讶",
                        character = 10016,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [510] = {
                        id = 510,
                        group = "弗莱彻_惊讶",
                        character = 10016,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [511] = {
                        id = 511,
                        group = "弗莱彻_火大",
                        character = 10016,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [512] = {
                        id = 512,
                        group = "弗莱彻_火大",
                        character = 10016,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [513] = {
                        id = 513,
                        group = "弗莱彻_感动",
                        character = 10016,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [514] = {
                        id = 514,
                        group = "弗莱彻_感动",
                        character = 10016,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [515] = {
                        id = 515,
                        group = "弗莱彻_严肃",
                        character = 10016,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [516] = {
                        id = 516,
                        group = "弗莱彻_严肃",
                        character = 10016,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [517] = {
                        id = 517,
                        group = "弗莱彻_慌张",
                        character = 10016,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [518] = {
                        id = 518,
                        group = "弗莱彻_慌张",
                        character = 10016,
                        resource = "flustered_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [519] = {
                        id = 519,
                        group = "弗莱彻_慌张2",
                        character = 10016,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [520] = {
                        id = 520,
                        group = "弗莱彻_慌张2",
                        character = 10016,
                        resource = "flustered2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [521] = {
                        id = 521,
                        group = "弗莱彻_晃耳笑",
                        character = 10016,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [522] = {
                        id = 522,
                        group = "弗莱彻_晃耳笑",
                        character = 10016,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [523] = {
                        id = 523,
                        group = "弗莱彻_下蹲害怕",
                        character = 10016,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [524] = {
                        id = 524,
                        group = "弗莱彻_下蹲害怕",
                        character = 10016,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [525] = {
                        id = 525,
                        group = "弗莱彻_后仰惊讶",
                        character = 10016,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [526] = {
                        id = 526,
                        group = "弗莱彻_后仰惊讶",
                        character = 10016,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [527] = {
                        id = 527,
                        group = "弗莱彻_晃耳闭眼",
                        character = 10016,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [528] = {
                        id = 528,
                        group = "弗莱彻_晃耳闭眼",
                        character = 10016,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [529] = {
                        id = 529,
                        group = "乌妮妮_默认",
                        character = 10018,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [530] = {
                        id = 530,
                        group = "乌妮妮_默认",
                        character = 10018,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [531] = {
                        id = 531,
                        group = "乌妮妮_笑",
                        character = 10018,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [532] = {
                        id = 532,
                        group = "乌妮妮_笑",
                        character = 10018,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [533] = {
                        id = 533,
                        group = "乌妮妮_闭眼",
                        character = 10018,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [534] = {
                        id = 534,
                        group = "乌妮妮_闭眼",
                        character = 10018,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [535] = {
                        id = 535,
                        group = "乌妮妮_生气",
                        character = 10018,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [536] = {
                        id = 536,
                        group = "乌妮妮_生气",
                        character = 10018,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [537] = {
                        id = 537,
                        group = "乌妮妮_悲伤",
                        character = 10018,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [538] = {
                        id = 538,
                        group = "乌妮妮_悲伤",
                        character = 10018,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [539] = {
                        id = 539,
                        group = "乌妮妮_害怕",
                        character = 10018,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [540] = {
                        id = 540,
                        group = "乌妮妮_害怕",
                        character = 10018,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [541] = {
                        id = 541,
                        group = "乌妮妮_害羞",
                        character = 10018,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [542] = {
                        id = 542,
                        group = "乌妮妮_害羞",
                        character = 10018,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [543] = {
                        id = 543,
                        group = "乌妮妮_惊讶",
                        character = 10018,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [544] = {
                        id = 544,
                        group = "乌妮妮_惊讶",
                        character = 10018,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [545] = {
                        id = 545,
                        group = "乌妮妮_奸笑",
                        character = 10018,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [546] = {
                        id = 546,
                        group = "乌妮妮_奸笑",
                        character = 10018,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [547] = {
                        id = 547,
                        group = "拉菲_默认",
                        character = 10017,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [548] = {
                        id = 548,
                        group = "拉菲_默认",
                        character = 10017,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [549] = {
                        id = 549,
                        group = "拉菲_笑",
                        character = 10017,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [550] = {
                        id = 550,
                        group = "拉菲_笑",
                        character = 10017,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [551] = {
                        id = 551,
                        group = "拉菲_笑2",
                        character = 10017,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [552] = {
                        id = 552,
                        group = "拉菲_笑2",
                        character = 10017,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [553] = {
                        id = 553,
                        group = "拉菲_闭眼",
                        character = 10017,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [554] = {
                        id = 554,
                        group = "拉菲_闭眼",
                        character = 10017,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [555] = {
                        id = 555,
                        group = "拉菲_生气",
                        character = 10017,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [556] = {
                        id = 556,
                        group = "拉菲_生气",
                        character = 10017,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [557] = {
                        id = 557,
                        group = "拉菲_悲伤",
                        character = 10017,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [558] = {
                        id = 558,
                        group = "拉菲_悲伤",
                        character = 10017,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [559] = {
                        id = 559,
                        group = "拉菲_害怕",
                        character = 10017,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [560] = {
                        id = 560,
                        group = "拉菲_害怕",
                        character = 10017,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [561] = {
                        id = 561,
                        group = "拉菲_害羞",
                        character = 10017,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [562] = {
                        id = 562,
                        group = "拉菲_害羞",
                        character = 10017,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [563] = {
                        id = 563,
                        group = "拉菲_惊讶",
                        character = 10017,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [564] = {
                        id = 564,
                        group = "拉菲_惊讶",
                        character = 10017,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [565] = {
                        id = 565,
                        group = "拉菲_嘟嘴",
                        character = 10017,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [566] = {
                        id = 566,
                        group = "拉菲_嘟嘴",
                        character = 10017,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [567] = {
                        id = 567,
                        group = "拉菲_心虚",
                        character = 10017,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [568] = {
                        id = 568,
                        group = "拉菲_心虚",
                        character = 10017,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [569] = {
                        id = 569,
                        group = "拉菲_抬手闭眼",
                        character = 10017,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [570] = {
                        id = 570,
                        group = "拉菲_抬手闭眼",
                        character = 10017,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [571] = {
                        id = 571,
                        group = "拉菲_握拳生气",
                        character = 10017,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [572] = {
                        id = 572,
                        group = "拉菲_握拳生气",
                        character = 10017,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [573] = {
                        id = 573,
                        group = "拉菲_耸肩害羞",
                        character = 10017,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [574] = {
                        id = 574,
                        group = "拉菲_耸肩害羞",
                        character = 10017,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [575] = {
                        id = 575,
                        group = "拉菲_后仰惊讶",
                        character = 10017,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [576] = {
                        id = 576,
                        group = "拉菲_后仰惊讶",
                        character = 10017,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [577] = {
                        id = 577,
                        group = "拉菲_耸肩悲伤",
                        character = 10017,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [578] = {
                        id = 578,
                        group = "拉菲_耸肩悲伤",
                        character = 10017,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [579] = {
                        id = 579,
                        group = "Z16_默认",
                        character = 10019,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [580] = {
                        id = 580,
                        group = "Z16_默认",
                        character = 10019,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [581] = {
                        id = 581,
                        group = "Z16_笑",
                        character = 10019,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [582] = {
                        id = 582,
                        group = "Z16_笑",
                        character = 10019,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [583] = {
                        id = 583,
                        group = "Z16_闭眼",
                        character = 10019,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [584] = {
                        id = 584,
                        group = "Z16_闭眼",
                        character = 10019,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [585] = {
                        id = 585,
                        group = "Z16_生气",
                        character = 10019,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [586] = {
                        id = 586,
                        group = "Z16_生气",
                        character = 10019,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [587] = {
                        id = 587,
                        group = "Z16_悲伤",
                        character = 10019,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [588] = {
                        id = 588,
                        group = "Z16_悲伤",
                        character = 10019,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [589] = {
                        id = 589,
                        group = "Z16_悲伤2",
                        character = 10019,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [590] = {
                        id = 590,
                        group = "Z16_悲伤2",
                        character = 10019,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [591] = {
                        id = 591,
                        group = "Z16_害怕",
                        character = 10019,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [592] = {
                        id = 592,
                        group = "Z16_害怕",
                        character = 10019,
                        resource = "scared_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [593] = {
                        id = 593,
                        group = "Z16_害羞",
                        character = 10019,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [594] = {
                        id = 594,
                        group = "Z16_害羞",
                        character = 10019,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [595] = {
                        id = 595,
                        group = "Z16_惊讶",
                        character = 10019,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [596] = {
                        id = 596,
                        group = "Z16_惊讶",
                        character = 10019,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [597] = {
                        id = 597,
                        group = "Z16_摇晃笑",
                        character = 10019,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [598] = {
                        id = 598,
                        group = "Z16_摇晃笑",
                        character = 10019,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [599] = {
                        id = 599,
                        group = "Z16_自信",
                        character = 10019,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [600] = {
                        id = 600,
                        group = "Z16_自信",
                        character = 10019,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [601] = {
                        id = 601,
                        group = "Z16_赌气",
                        character = 10019,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [602] = {
                        id = 602,
                        group = "Z16_赌气",
                        character = 10019,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [603] = {
                        id = 603,
                        group = "Z16_严肃",
                        character = 10019,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [604] = {
                        id = 604,
                        group = "Z16_严肃",
                        character = 10019,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [605] = {
                        id = 605,
                        group = "Z16_认真",
                        character = 10019,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [606] = {
                        id = 606,
                        group = "Z16_认真",
                        character = 10019,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [607] = {
                        id = 607,
                        group = "Z16_耸肩悲伤",
                        character = 10019,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [608] = {
                        id = 608,
                        group = "Z16_耸肩悲伤",
                        character = 10019,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [609] = {
                        id = 609,
                        group = "Z16_耸肩悲伤2",
                        character = 10019,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [610] = {
                        id = 610,
                        group = "Z16_耸肩悲伤2",
                        character = 10019,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [611] = {
                        id = 611,
                        group = "Z16_后仰害羞",
                        character = 10019,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [612] = {
                        id = 612,
                        group = "Z16_后仰害羞",
                        character = 10019,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [613] = {
                        id = 613,
                        group = "Z16_后仰惊讶",
                        character = 10019,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [614] = {
                        id = 614,
                        group = "Z16_后仰惊讶",
                        character = 10019,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [615] = {
                        id = 615,
                        group = "Z16_后仰害怕",
                        character = 10019,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [616] = {
                        id = 616,
                        group = "Z16_后仰害怕",
                        character = 10019,
                        resource = "scared_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [617] = {
                        id = 617,
                        group = "欧根亲王_默认",
                        character = 10012,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [618] = {
                        id = 618,
                        group = "欧根亲王_默认",
                        character = 10012,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [619] = {
                        id = 619,
                        group = "欧根亲王_笑",
                        character = 10012,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [620] = {
                        id = 620,
                        group = "欧根亲王_笑",
                        character = 10012,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [621] = {
                        id = 621,
                        group = "欧根亲王_闭眼",
                        character = 10012,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [622] = {
                        id = 622,
                        group = "欧根亲王_闭眼",
                        character = 10012,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [623] = {
                        id = 623,
                        group = "欧根亲王_生气",
                        character = 10012,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [624] = {
                        id = 624,
                        group = "欧根亲王_生气",
                        character = 10012,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [625] = {
                        id = 625,
                        group = "欧根亲王_悲伤",
                        character = 10012,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [626] = {
                        id = 626,
                        group = "欧根亲王_悲伤",
                        character = 10012,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [627] = {
                        id = 627,
                        group = "欧根亲王_害怕",
                        character = 10012,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [628] = {
                        id = 628,
                        group = "欧根亲王_害怕",
                        character = 10012,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [629] = {
                        id = 629,
                        group = "欧根亲王_害羞",
                        character = 10012,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [630] = {
                        id = 630,
                        group = "欧根亲王_害羞",
                        character = 10012,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [631] = {
                        id = 631,
                        group = "欧根亲王_惊讶",
                        character = 10012,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [632] = {
                        id = 632,
                        group = "欧根亲王_惊讶",
                        character = 10012,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [633] = {
                        id = 633,
                        group = "欧根亲王_笑容",
                        character = 10012,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [634] = {
                        id = 634,
                        group = "欧根亲王_笑容",
                        character = 10012,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [635] = {
                        id = 635,
                        group = "欧根亲王_流汗",
                        character = 10012,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [636] = {
                        id = 636,
                        group = "欧根亲王_流汗",
                        character = 10012,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [637] = {
                        id = 637,
                        group = "欧根亲王_摇晃笑",
                        character = 10012,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [638] = {
                        id = 638,
                        group = "欧根亲王_摇晃笑",
                        character = 10012,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [639] = {
                        id = 639,
                        group = "欧根亲王_抬手生气",
                        character = 10012,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [640] = {
                        id = 640,
                        group = "欧根亲王_抬手生气",
                        character = 10012,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [641] = {
                        id = 641,
                        group = "欧根亲王_后仰惊讶",
                        character = 10012,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [642] = {
                        id = 642,
                        group = "欧根亲王_后仰惊讶",
                        character = 10012,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [643] = {
                        id = 643,
                        group = "欧根亲王_黑影",
                        character = 10012,
                        resource = "idle_action_dark",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [644] = {
                        id = 644,
                        group = "欧根亲王_黑影",
                        character = 10012,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [645] = {
                        id = 645,
                        group = "欧根亲王_严肃",
                        character = 10012,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [646] = {
                        id = 646,
                        group = "欧根亲王_严肃",
                        character = 10012,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [647] = {
                        id = 647,
                        group = "长门_默认",
                        character = 10022,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [648] = {
                        id = 648,
                        group = "长门_默认",
                        character = 10022,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [649] = {
                        id = 649,
                        group = "长门_笑",
                        character = 10022,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [650] = {
                        id = 650,
                        group = "长门_笑",
                        character = 10022,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [651] = {
                        id = 651,
                        group = "长门_闭眼",
                        character = 10022,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [652] = {
                        id = 652,
                        group = "长门_闭眼",
                        character = 10022,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [653] = {
                        id = 653,
                        group = "长门_生气",
                        character = 10022,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [654] = {
                        id = 654,
                        group = "长门_生气",
                        character = 10022,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [655] = {
                        id = 655,
                        group = "长门_悲伤",
                        character = 10022,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [656] = {
                        id = 656,
                        group = "长门_悲伤",
                        character = 10022,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [657] = {
                        id = 657,
                        group = "长门_害怕",
                        character = 10022,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [658] = {
                        id = 658,
                        group = "长门_害怕",
                        character = 10022,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [659] = {
                        id = 659,
                        group = "长门_害羞",
                        character = 10022,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [660] = {
                        id = 660,
                        group = "长门_害羞",
                        character = 10022,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [661] = {
                        id = 661,
                        group = "长门_惊讶",
                        character = 10022,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [662] = {
                        id = 662,
                        group = "长门_惊讶",
                        character = 10022,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [663] = {
                        id = 663,
                        group = "长门_微笑",
                        character = 10022,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [664] = {
                        id = 664,
                        group = "长门_微笑",
                        character = 10022,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [665] = {
                        id = 665,
                        group = "长门_仰头笑",
                        character = 10022,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [666] = {
                        id = 666,
                        group = "长门_仰头笑",
                        character = 10022,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [667] = {
                        id = 667,
                        group = "长门_抬手闭眼",
                        character = 10022,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [668] = {
                        id = 668,
                        group = "长门_抬手闭眼",
                        character = 10022,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [669] = {
                        id = 669,
                        group = "长门_警戒生气",
                        character = 10022,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [670] = {
                        id = 670,
                        group = "长门_警戒生气",
                        character = 10022,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [671] = {
                        id = 671,
                        group = "长门_后仰害怕",
                        character = 10022,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [672] = {
                        id = 672,
                        group = "长门_后仰害怕",
                        character = 10022,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [673] = {
                        id = 673,
                        group = "长门_耸肩害羞",
                        character = 10022,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [674] = {
                        id = 674,
                        group = "长门_耸肩害羞",
                        character = 10022,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [675] = {
                        id = 675,
                        group = "长门_后仰惊讶",
                        character = 10022,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [676] = {
                        id = 676,
                        group = "长门_后仰惊讶",
                        character = 10022,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [677] = {
                        id = 677,
                        group = "维纳斯_默认",
                        character = 10026,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [678] = {
                        id = 678,
                        group = "维纳斯_默认",
                        character = 10026,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [679] = {
                        id = 679,
                        group = "维纳斯_笑",
                        character = 10026,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [680] = {
                        id = 680,
                        group = "维纳斯_笑",
                        character = 10026,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [681] = {
                        id = 681,
                        group = "维纳斯_闭眼",
                        character = 10026,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [682] = {
                        id = 682,
                        group = "维纳斯_闭眼",
                        character = 10026,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [683] = {
                        id = 683,
                        group = "维纳斯_生气",
                        character = 10026,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [684] = {
                        id = 684,
                        group = "维纳斯_生气",
                        character = 10026,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [685] = {
                        id = 685,
                        group = "维纳斯_悲伤",
                        character = 10026,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [686] = {
                        id = 686,
                        group = "维纳斯_悲伤",
                        character = 10026,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [687] = {
                        id = 687,
                        group = "维纳斯_害怕",
                        character = 10026,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [688] = {
                        id = 688,
                        group = "维纳斯_害怕",
                        character = 10026,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [689] = {
                        id = 689,
                        group = "维纳斯_害羞",
                        character = 10026,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [690] = {
                        id = 690,
                        group = "维纳斯_害羞",
                        character = 10026,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [691] = {
                        id = 691,
                        group = "维纳斯_摇晃笑",
                        character = 10026,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [692] = {
                        id = 692,
                        group = "维纳斯_摇晃笑",
                        character = 10026,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [693] = {
                        id = 693,
                        group = "维纳斯_直立生气",
                        character = 10026,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [694] = {
                        id = 694,
                        group = "维纳斯_直立生气",
                        character = 10026,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [695] = {
                        id = 695,
                        group = "维纳斯_直立害怕",
                        character = 10026,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [696] = {
                        id = 696,
                        group = "维纳斯_直立害怕",
                        character = 10026,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [697] = {
                        id = 697,
                        group = "维纳斯_生气2",
                        character = 10026,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [698] = {
                        id = 698,
                        group = "维纳斯_生气2",
                        character = 10026,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [699] = {
                        id = 699,
                        group = "马卡龙(明石)_默认",
                        character = 998,
                        resource = "idle1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [700] = {
                        id = 700,
                        group = "马卡龙(明石)_默认",
                        character = 998,
                        resource = "idle1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [701] = {
                        id = 701,
                        group = "马卡龙(基德)_默认",
                        character = 998,
                        resource = "idle2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [702] = {
                        id = 702,
                        group = "马卡龙(基德)_默认",
                        character = 998,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [703] = {
                        id = 703,
                        group = "马卡龙(吕佐夫)_默认",
                        character = 998,
                        resource = "idle3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [704] = {
                        id = 704,
                        group = "马卡龙(吕佐夫)_默认",
                        character = 998,
                        resource = "idle3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [705] = {
                        id = 705,
                        group = "深海_默认",
                        character = 20001,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [706] = {
                        id = 706,
                        group = "深海_默认",
                        character = 20001,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [707] = {
                        id = 707,
                        group = "深海_笑",
                        character = 20001,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [708] = {
                        id = 708,
                        group = "深海_笑",
                        character = 20001,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [709] = {
                        id = 709,
                        group = "加贺_黑影",
                        character = 997,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [710] = {
                        id = 710,
                        group = "加贺_黑影",
                        character = 997,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [711] = {
                        id = 711,
                        group = "U47_默认",
                        character = 10027,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [712] = {
                        id = 712,
                        group = "U47_默认",
                        character = 10027,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [713] = {
                        id = 713,
                        group = "U47_笑",
                        character = 10027,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [714] = {
                        id = 714,
                        group = "U47_笑",
                        character = 10027,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [715] = {
                        id = 715,
                        group = "U47_闭眼",
                        character = 10027,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [716] = {
                        id = 716,
                        group = "U47_闭眼",
                        character = 10027,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [717] = {
                        id = 717,
                        group = "U47_生气",
                        character = 10027,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [718] = {
                        id = 718,
                        group = "U47_生气",
                        character = 10027,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [719] = {
                        id = 719,
                        group = "U47_生气2",
                        character = 10027,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [720] = {
                        id = 720,
                        group = "U47_生气2",
                        character = 10027,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [721] = {
                        id = 721,
                        group = "U47_悲伤",
                        character = 10027,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [722] = {
                        id = 722,
                        group = "U47_悲伤",
                        character = 10027,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [723] = {
                        id = 723,
                        group = "U47_害怕",
                        character = 10027,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [724] = {
                        id = 724,
                        group = "U47_害怕",
                        character = 10027,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [725] = {
                        id = 725,
                        group = "U47_害羞",
                        character = 10027,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [726] = {
                        id = 726,
                        group = "U47_害羞",
                        character = 10027,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [727] = {
                        id = 727,
                        group = "U47_惊讶",
                        character = 10027,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [728] = {
                        id = 728,
                        group = "U47_惊讶",
                        character = 10027,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [729] = {
                        id = 729,
                        group = "U47_wink",
                        character = 10027,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [730] = {
                        id = 730,
                        group = "U47_wink",
                        character = 10027,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [731] = {
                        id = 731,
                        group = "U47_猫眼",
                        character = 10027,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [732] = {
                        id = 732,
                        group = "U47_猫眼",
                        character = 10027,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [733] = {
                        id = 733,
                        group = "U47_闭眼2",
                        character = 10027,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [734] = {
                        id = 734,
                        group = "U47_闭眼2",
                        character = 10027,
                        resource = "closeeye2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [735] = {
                        id = 735,
                        group = "U47_直立笑",
                        character = 10027,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [736] = {
                        id = 736,
                        group = "U47_直立笑",
                        character = 10027,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [737] = {
                        id = 737,
                        group = "U47_叉腰生气",
                        character = 10027,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [738] = {
                        id = 738,
                        group = "U47_叉腰生气",
                        character = 10027,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [739] = {
                        id = 739,
                        group = "U47_叉腰生气2",
                        character = 10027,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [740] = {
                        id = 740,
                        group = "U47_叉腰生气2",
                        character = 10027,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [741] = {
                        id = 741,
                        group = "U47_背手悲伤",
                        character = 10027,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [742] = {
                        id = 742,
                        group = "U47_背手悲伤",
                        character = 10027,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [743] = {
                        id = 743,
                        group = "U47_后仰害怕",
                        character = 10027,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [744] = {
                        id = 744,
                        group = "U47_后仰害怕",
                        character = 10027,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [745] = {
                        id = 745,
                        group = "俾斯麦_默认",
                        character = 10020,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [746] = {
                        id = 746,
                        group = "俾斯麦_默认",
                        character = 10020,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [747] = {
                        id = 747,
                        group = "俾斯麦_笑",
                        character = 10020,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [748] = {
                        id = 748,
                        group = "俾斯麦_笑",
                        character = 10020,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [749] = {
                        id = 749,
                        group = "俾斯麦_闭眼",
                        character = 10020,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [750] = {
                        id = 750,
                        group = "俾斯麦_闭眼",
                        character = 10020,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [751] = {
                        id = 751,
                        group = "俾斯麦_生气",
                        character = 10020,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [752] = {
                        id = 752,
                        group = "俾斯麦_生气",
                        character = 10020,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [753] = {
                        id = 753,
                        group = "俾斯麦_生气2",
                        character = 10020,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [754] = {
                        id = 754,
                        group = "俾斯麦_生气2",
                        character = 10020,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [755] = {
                        id = 755,
                        group = "俾斯麦_悲伤",
                        character = 10020,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [756] = {
                        id = 756,
                        group = "俾斯麦_悲伤",
                        character = 10020,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [757] = {
                        id = 757,
                        group = "俾斯麦_悲伤2",
                        character = 10020,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [758] = {
                        id = 758,
                        group = "俾斯麦_悲伤2",
                        character = 10020,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [759] = {
                        id = 759,
                        group = "俾斯麦_害怕",
                        character = 10020,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [760] = {
                        id = 760,
                        group = "俾斯麦_害怕",
                        character = 10020,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [761] = {
                        id = 761,
                        group = "俾斯麦_害羞",
                        character = 10020,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [762] = {
                        id = 762,
                        group = "俾斯麦_害羞",
                        character = 10020,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [763] = {
                        id = 763,
                        group = "俾斯麦_害羞2",
                        character = 10020,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [764] = {
                        id = 764,
                        group = "俾斯麦_害羞2",
                        character = 10020,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [765] = {
                        id = 765,
                        group = "俾斯麦_亮眼",
                        character = 10020,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [766] = {
                        id = 766,
                        group = "俾斯麦_亮眼",
                        character = 10020,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [767] = {
                        id = 767,
                        group = "俾斯麦_猫眼",
                        character = 10020,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [768] = {
                        id = 768,
                        group = "俾斯麦_猫眼",
                        character = 10020,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [769] = {
                        id = 769,
                        group = "俾斯麦_警戒生气",
                        character = 10020,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [770] = {
                        id = 770,
                        group = "俾斯麦_警戒生气",
                        character = 10020,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [771] = {
                        id = 771,
                        group = "俾斯麦_警戒生气2",
                        character = 10020,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [772] = {
                        id = 772,
                        group = "俾斯麦_警戒生气2",
                        character = 10020,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [773] = {
                        id = 773,
                        group = "俾斯麦_搭手悲伤",
                        character = 10020,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [774] = {
                        id = 774,
                        group = "俾斯麦_搭手悲伤",
                        character = 10020,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [775] = {
                        id = 775,
                        group = "俾斯麦_搭手悲伤2",
                        character = 10020,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [776] = {
                        id = 776,
                        group = "俾斯麦_搭手悲伤2",
                        character = 10020,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [777] = {
                        id = 777,
                        group = "俾斯麦_后仰害怕",
                        character = 10020,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [778] = {
                        id = 778,
                        group = "俾斯麦_后仰害怕",
                        character = 10020,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [779] = {
                        id = 779,
                        group = "俾斯麦_搭手害羞",
                        character = 10020,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [780] = {
                        id = 780,
                        group = "俾斯麦_搭手害羞",
                        character = 10020,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [781] = {
                        id = 781,
                        group = "俾斯麦_搭手害羞2",
                        character = 10020,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [782] = {
                        id = 782,
                        group = "俾斯麦_搭手害羞2",
                        character = 10020,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [783] = {
                        id = 783,
                        group = "光辉_默认",
                        character = 10029,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [784] = {
                        id = 784,
                        group = "光辉_默认",
                        character = 10029,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [785] = {
                        id = 785,
                        group = "光辉_默认2",
                        character = 10029,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [786] = {
                        id = 786,
                        group = "光辉_默认2",
                        character = 10029,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [787] = {
                        id = 787,
                        group = "光辉_笑",
                        character = 10029,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [788] = {
                        id = 788,
                        group = "光辉_笑",
                        character = 10029,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [789] = {
                        id = 789,
                        group = "光辉_闭眼",
                        character = 10029,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [790] = {
                        id = 790,
                        group = "光辉_闭眼",
                        character = 10029,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [791] = {
                        id = 791,
                        group = "光辉_生气",
                        character = 10029,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [792] = {
                        id = 792,
                        group = "光辉_生气",
                        character = 10029,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [793] = {
                        id = 793,
                        group = "光辉_悲伤",
                        character = 10029,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [794] = {
                        id = 794,
                        group = "光辉_悲伤",
                        character = 10029,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [795] = {
                        id = 795,
                        group = "光辉_害怕",
                        character = 10029,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [796] = {
                        id = 796,
                        group = "光辉_害怕",
                        character = 10029,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [797] = {
                        id = 797,
                        group = "光辉_害羞",
                        character = 10029,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [798] = {
                        id = 798,
                        group = "光辉_害羞",
                        character = 10029,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [799] = {
                        id = 799,
                        group = "光辉_wink",
                        character = 10029,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [800] = {
                        id = 800,
                        group = "光辉_wink",
                        character = 10029,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [801] = {
                        id = 801,
                        group = "光辉_冷漠",
                        character = 10029,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [802] = {
                        id = 802,
                        group = "光辉_冷漠",
                        character = 10029,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [803] = {
                        id = 803,
                        group = "光辉_摇摆笑",
                        character = 10029,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [804] = {
                        id = 804,
                        group = "光辉_摇摆笑",
                        character = 10029,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [805] = {
                        id = 805,
                        group = "光辉_摇摆wink",
                        character = 10029,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [806] = {
                        id = 806,
                        group = "光辉_摇摆wink",
                        character = 10029,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [807] = {
                        id = 807,
                        group = "光辉_展肩生气",
                        character = 10029,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [808] = {
                        id = 808,
                        group = "光辉_展肩生气",
                        character = 10029,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [809] = {
                        id = 809,
                        group = "光辉_耸肩悲伤",
                        character = 10029,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [810] = {
                        id = 810,
                        group = "光辉_耸肩悲伤",
                        character = 10029,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [811] = {
                        id = 811,
                        group = "光辉_抬手害怕",
                        character = 10029,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [812] = {
                        id = 812,
                        group = "光辉_抬手害怕",
                        character = 10029,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [813] = {
                        id = 813,
                        group = "光辉_背手害羞",
                        character = 10029,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [814] = {
                        id = 814,
                        group = "光辉_背手害羞",
                        character = 10029,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [815] = {
                        id = 815,
                        group = "普林斯顿_默认",
                        character = 10040,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [816] = {
                        id = 816,
                        group = "普林斯顿_默认",
                        character = 10040,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [817] = {
                        id = 817,
                        group = "普林斯顿_认真",
                        character = 10040,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [818] = {
                        id = 818,
                        group = "普林斯顿_认真",
                        character = 10040,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [819] = {
                        id = 819,
                        group = "普林斯顿_笑",
                        character = 10040,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [820] = {
                        id = 820,
                        group = "普林斯顿_笑",
                        character = 10040,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [821] = {
                        id = 821,
                        group = "普林斯顿_笑2",
                        character = 10040,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [822] = {
                        id = 822,
                        group = "普林斯顿_笑2",
                        character = 10040,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [823] = {
                        id = 823,
                        group = "普林斯顿_闭眼",
                        character = 10040,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [824] = {
                        id = 824,
                        group = "普林斯顿_闭眼",
                        character = 10040,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [825] = {
                        id = 825,
                        group = "普林斯顿_闭眼2",
                        character = 10040,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [826] = {
                        id = 826,
                        group = "普林斯顿_闭眼2",
                        character = 10040,
                        resource = "closeeye2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [827] = {
                        id = 827,
                        group = "普林斯顿_生气",
                        character = 10040,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [828] = {
                        id = 828,
                        group = "普林斯顿_生气",
                        character = 10040,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [829] = {
                        id = 829,
                        group = "普林斯顿_悲伤",
                        character = 10040,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [830] = {
                        id = 830,
                        group = "普林斯顿_悲伤",
                        character = 10040,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [831] = {
                        id = 831,
                        group = "普林斯顿_悲伤2",
                        character = 10040,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [832] = {
                        id = 832,
                        group = "普林斯顿_悲伤2",
                        character = 10040,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [833] = {
                        id = 833,
                        group = "普林斯顿_害怕",
                        character = 10040,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [834] = {
                        id = 834,
                        group = "普林斯顿_害怕",
                        character = 10040,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [835] = {
                        id = 835,
                        group = "普林斯顿_害羞",
                        character = 10040,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [836] = {
                        id = 836,
                        group = "普林斯顿_害羞",
                        character = 10040,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [837] = {
                        id = 837,
                        group = "普林斯顿_爱心眼",
                        character = 10040,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [838] = {
                        id = 838,
                        group = "普林斯顿_爱心眼",
                        character = 10040,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [839] = {
                        id = 839,
                        group = "普林斯顿_摸头笑",
                        character = 10040,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [840] = {
                        id = 840,
                        group = "普林斯顿_摸头笑",
                        character = 10040,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [841] = {
                        id = 841,
                        group = "普林斯顿_摸头认真",
                        character = 10040,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [842] = {
                        id = 842,
                        group = "普林斯顿_摸头认真",
                        character = 10040,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [843] = {
                        id = 843,
                        group = "普林斯顿_摸头笑2",
                        character = 10040,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [844] = {
                        id = 844,
                        group = "普林斯顿_摸头笑2",
                        character = 10040,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [845] = {
                        id = 845,
                        group = "普林斯顿_歪头闭眼",
                        character = 10040,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [846] = {
                        id = 846,
                        group = "普林斯顿_歪头闭眼",
                        character = 10040,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [847] = {
                        id = 847,
                        group = "普林斯顿_歪头闭眼2",
                        character = 10040,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [848] = {
                        id = 848,
                        group = "普林斯顿_歪头闭眼2",
                        character = 10040,
                        resource = "closeeye2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [849] = {
                        id = 849,
                        group = "普林斯顿_耸肩悲伤",
                        character = 10040,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [850] = {
                        id = 850,
                        group = "普林斯顿_耸肩悲伤",
                        character = 10040,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [851] = {
                        id = 851,
                        group = "普林斯顿_耸肩悲伤2",
                        character = 10040,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [852] = {
                        id = 852,
                        group = "普林斯顿_耸肩悲伤2",
                        character = 10040,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [853] = {
                        id = 853,
                        group = "普林斯顿_后仰害怕",
                        character = 10040,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [854] = {
                        id = 854,
                        group = "普林斯顿_后仰害怕",
                        character = 10040,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [855] = {
                        id = 855,
                        group = "普林斯顿_背手害羞",
                        character = 10040,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [856] = {
                        id = 856,
                        group = "普林斯顿_背手害羞",
                        character = 10040,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [857] = {
                        id = 857,
                        group = "普林斯顿_敬礼爱心眼",
                        character = 10040,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [858] = {
                        id = 858,
                        group = "普林斯顿_敬礼爱心眼",
                        character = 10040,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [859] = {
                        id = 859,
                        group = "普林斯顿_敬礼默认",
                        character = 10040,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [860] = {
                        id = 860,
                        group = "普林斯顿_敬礼默认",
                        character = 10040,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [861] = {
                        id = 861,
                        group = "普林斯顿_敬礼认真",
                        character = 10040,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [862] = {
                        id = 862,
                        group = "普林斯顿_敬礼认真",
                        character = 10040,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [863] = {
                        id = 863,
                        group = "普林斯顿_敬礼笑",
                        character = 10040,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [864] = {
                        id = 864,
                        group = "普林斯顿_敬礼笑",
                        character = 10040,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [865] = {
                        id = 865,
                        group = "普林斯顿_敬礼笑2",
                        character = 10040,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [866] = {
                        id = 866,
                        group = "普林斯顿_敬礼笑2",
                        character = 10040,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [867] = {
                        id = 867,
                        group = "柯蒂斯_默认",
                        character = 10043,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [868] = {
                        id = 868,
                        group = "柯蒂斯_默认",
                        character = 10043,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [869] = {
                        id = 869,
                        group = "柯蒂斯_笑",
                        character = 10043,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [870] = {
                        id = 870,
                        group = "柯蒂斯_笑",
                        character = 10043,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [871] = {
                        id = 871,
                        group = "柯蒂斯_闭眼",
                        character = 10043,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [872] = {
                        id = 872,
                        group = "柯蒂斯_闭眼",
                        character = 10043,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [873] = {
                        id = 873,
                        group = "柯蒂斯_生气",
                        character = 10043,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [874] = {
                        id = 874,
                        group = "柯蒂斯_生气",
                        character = 10043,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [875] = {
                        id = 875,
                        group = "柯蒂斯_生气2",
                        character = 10043,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [876] = {
                        id = 876,
                        group = "柯蒂斯_生气2",
                        character = 10043,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [877] = {
                        id = 877,
                        group = "柯蒂斯_悲伤",
                        character = 10043,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [878] = {
                        id = 878,
                        group = "柯蒂斯_悲伤",
                        character = 10043,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [879] = {
                        id = 879,
                        group = "柯蒂斯_害怕",
                        character = 10043,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [880] = {
                        id = 880,
                        group = "柯蒂斯_害怕",
                        character = 10043,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [881] = {
                        id = 881,
                        group = "柯蒂斯_害羞",
                        character = 10043,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [882] = {
                        id = 882,
                        group = "柯蒂斯_害羞",
                        character = 10043,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [883] = {
                        id = 883,
                        group = "柯蒂斯_幸福",
                        character = 10043,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [884] = {
                        id = 884,
                        group = "柯蒂斯_幸福",
                        character = 10043,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [885] = {
                        id = 885,
                        group = "柯蒂斯_担忧",
                        character = 10043,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [886] = {
                        id = 886,
                        group = "柯蒂斯_担忧",
                        character = 10043,
                        resource = "worry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [887] = {
                        id = 887,
                        group = "柯蒂斯_摇摆笑",
                        character = 10043,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [888] = {
                        id = 888,
                        group = "柯蒂斯_摇摆笑",
                        character = 10043,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [889] = {
                        id = 889,
                        group = "柯蒂斯_摇摆幸福",
                        character = 10043,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [890] = {
                        id = 890,
                        group = "柯蒂斯_摇摆幸福",
                        character = 10043,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [891] = {
                        id = 891,
                        group = "柯蒂斯_背手生气",
                        character = 10043,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [892] = {
                        id = 892,
                        group = "柯蒂斯_背手生气",
                        character = 10043,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [893] = {
                        id = 893,
                        group = "柯蒂斯_背手生气2",
                        character = 10043,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [894] = {
                        id = 894,
                        group = "柯蒂斯_背手生气2",
                        character = 10043,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [895] = {
                        id = 895,
                        group = "柯蒂斯_后仰害怕",
                        character = 10043,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [896] = {
                        id = 896,
                        group = "柯蒂斯_后仰害怕",
                        character = 10043,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [897] = {
                        id = 897,
                        group = "柯蒂斯_点手害羞",
                        character = 10043,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [898] = {
                        id = 898,
                        group = "柯蒂斯_点手害羞",
                        character = 10043,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [899] = {
                        id = 899,
                        group = "柯蒂斯_抬手担忧",
                        character = 10043,
                        resource = "worry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [900] = {
                        id = 900,
                        group = "柯蒂斯_抬手担忧",
                        character = 10043,
                        resource = "worry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [901] = {
                        id = 901,
                        group = "柯蒂斯_黑影",
                        character = 10043,
                        resource = "idle_action_dark",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [902] = {
                        id = 902,
                        group = "柯蒂斯_黑影",
                        character = 10043,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [903] = {
                        id = 903,
                        group = "西安_默认",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [904] = {
                        id = 904,
                        group = "西安_默认",
                        character = 10011,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [905] = {
                        id = 905,
                        group = "西安_笑",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [906] = {
                        id = 906,
                        group = "西安_笑",
                        character = 10011,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [907] = {
                        id = 907,
                        group = "西安_闭眼",
                        character = 10011,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [908] = {
                        id = 908,
                        group = "西安_闭眼",
                        character = 10011,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [909] = {
                        id = 909,
                        group = "西安_生气",
                        character = 10011,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [910] = {
                        id = 910,
                        group = "西安_生气",
                        character = 10011,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [911] = {
                        id = 911,
                        group = "西安_悲伤",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [912] = {
                        id = 912,
                        group = "西安_悲伤",
                        character = 10011,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [913] = {
                        id = 913,
                        group = "西安_悲伤2",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [914] = {
                        id = 914,
                        group = "西安_悲伤2",
                        character = 10011,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [915] = {
                        id = 915,
                        group = "西安_害怕",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [916] = {
                        id = 916,
                        group = "西安_害怕",
                        character = 10011,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [917] = {
                        id = 917,
                        group = "西安_害羞",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [918] = {
                        id = 918,
                        group = "西安_害羞",
                        character = 10011,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [919] = {
                        id = 919,
                        group = "西安_害羞2",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [920] = {
                        id = 920,
                        group = "西安_害羞2",
                        character = 10011,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [921] = {
                        id = 921,
                        group = "西安_惊讶",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [922] = {
                        id = 922,
                        group = "西安_惊讶",
                        character = 10011,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [923] = {
                        id = 923,
                        group = "西安_惊讶2",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [924] = {
                        id = 924,
                        group = "西安_惊讶2",
                        character = 10011,
                        resource = "amazed2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [925] = {
                        id = 925,
                        group = "西安_失望",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [926] = {
                        id = 926,
                        group = "西安_失望",
                        character = 10011,
                        resource = "helpless_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [927] = {
                        id = 927,
                        group = "西安_调侃",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [928] = {
                        id = 928,
                        group = "西安_调侃",
                        character = 10011,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [929] = {
                        id = 929,
                        group = "西安_吐舌",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [930] = {
                        id = 930,
                        group = "西安_吐舌",
                        character = 10011,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [931] = {
                        id = 931,
                        group = "西安_wink",
                        character = 10011,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [932] = {
                        id = 932,
                        group = "西安_wink",
                        character = 10011,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [933] = {
                        id = 933,
                        group = "西安_摇晃笑",
                        character = 10011,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [934] = {
                        id = 934,
                        group = "西安_摇晃笑",
                        character = 10011,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [935] = {
                        id = 935,
                        group = "西安_局促悲伤",
                        character = 10011,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [936] = {
                        id = 936,
                        group = "西安_局促悲伤",
                        character = 10011,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [937] = {
                        id = 937,
                        group = "西安_局促悲伤2",
                        character = 10011,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [938] = {
                        id = 938,
                        group = "西安_局促悲伤2",
                        character = 10011,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [939] = {
                        id = 939,
                        group = "西安_后仰害怕",
                        character = 10011,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [940] = {
                        id = 940,
                        group = "西安_后仰害怕",
                        character = 10011,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [941] = {
                        id = 941,
                        group = "西安_扭捏害羞",
                        character = 10011,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [942] = {
                        id = 942,
                        group = "西安_扭捏害羞",
                        character = 10011,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [943] = {
                        id = 943,
                        group = "西安_扭捏害羞2",
                        character = 10011,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [944] = {
                        id = 944,
                        group = "西安_扭捏害羞2",
                        character = 10011,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [945] = {
                        id = 945,
                        group = "西安_后仰惊讶",
                        character = 10011,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [946] = {
                        id = 946,
                        group = "西安_后仰惊讶",
                        character = 10011,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [947] = {
                        id = 947,
                        group = "西安_后仰惊讶2",
                        character = 10011,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [948] = {
                        id = 948,
                        group = "西安_后仰惊讶2",
                        character = 10011,
                        resource = "amazed2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [949] = {
                        id = 949,
                        group = "西安_后仰调侃",
                        character = 10011,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [950] = {
                        id = 950,
                        group = "西安_后仰调侃",
                        character = 10011,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [951] = {
                        id = 951,
                        group = "西安_后仰生气",
                        character = 10011,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [952] = {
                        id = 952,
                        group = "西安_后仰生气",
                        character = 10011,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [953] = {
                        id = 953,
                        group = "西安_摇摆吐舌",
                        character = 10011,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [954] = {
                        id = 954,
                        group = "西安_摇摆吐舌",
                        character = 10011,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [955] = {
                        id = 955,
                        group = "甘比尔湾_默认",
                        character = 10021,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [956] = {
                        id = 956,
                        group = "甘比尔湾_默认",
                        character = 10021,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [957] = {
                        id = 957,
                        group = "甘比尔湾_笑",
                        character = 10021,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [958] = {
                        id = 958,
                        group = "甘比尔湾_笑",
                        character = 10021,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [959] = {
                        id = 959,
                        group = "甘比尔湾_手势笑",
                        character = 10021,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [960] = {
                        id = 960,
                        group = "甘比尔湾_手势笑",
                        character = 10021,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [961] = {
                        id = 961,
                        group = "甘比尔湾_闭眼",
                        character = 10021,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [962] = {
                        id = 962,
                        group = "甘比尔湾_闭眼",
                        character = 10021,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [963] = {
                        id = 963,
                        group = "甘比尔湾_生气",
                        character = 10021,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [964] = {
                        id = 964,
                        group = "甘比尔湾_生气",
                        character = 10021,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [965] = {
                        id = 965,
                        group = "甘比尔湾_悲伤",
                        character = 10021,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [966] = {
                        id = 966,
                        group = "甘比尔湾_悲伤",
                        character = 10021,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [967] = {
                        id = 967,
                        group = "甘比尔湾_害怕",
                        character = 10021,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [968] = {
                        id = 968,
                        group = "甘比尔湾_害怕",
                        character = 10021,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [969] = {
                        id = 969,
                        group = "甘比尔湾_手势害怕",
                        character = 10021,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [970] = {
                        id = 970,
                        group = "甘比尔湾_手势害怕",
                        character = 10021,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [971] = {
                        id = 971,
                        group = "甘比尔湾_害羞",
                        character = 10021,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [972] = {
                        id = 972,
                        group = "甘比尔湾_害羞",
                        character = 10021,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [973] = {
                        id = 973,
                        group = "甘比尔湾_害羞2",
                        character = 10021,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [974] = {
                        id = 974,
                        group = "甘比尔湾_害羞2",
                        character = 10021,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [975] = {
                        id = 975,
                        group = "甘比尔湾_得意",
                        character = 10021,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [976] = {
                        id = 976,
                        group = "甘比尔湾_得意",
                        character = 10021,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [977] = {
                        id = 977,
                        group = "甘比尔湾_手势得意2",
                        character = 10021,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [978] = {
                        id = 978,
                        group = "甘比尔湾_手势得意2",
                        character = 10021,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [979] = {
                        id = 979,
                        group = "甘比尔湾_慌张",
                        character = 10021,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [980] = {
                        id = 980,
                        group = "甘比尔湾_慌张",
                        character = 10021,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [981] = {
                        id = 981,
                        group = "高雄_默认",
                        character = 10039,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [982] = {
                        id = 982,
                        group = "高雄_默认",
                        character = 10039,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [983] = {
                        id = 983,
                        group = "高雄_笑",
                        character = 10039,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [984] = {
                        id = 984,
                        group = "高雄_笑",
                        character = 10039,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [985] = {
                        id = 985,
                        group = "高雄_摇摆笑",
                        character = 10039,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [986] = {
                        id = 986,
                        group = "高雄_摇摆笑",
                        character = 10039,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [987] = {
                        id = 987,
                        group = "高雄_闭眼",
                        character = 10039,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [988] = {
                        id = 988,
                        group = "高雄_闭眼",
                        character = 10039,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [989] = {
                        id = 989,
                        group = "高雄_举手闭眼",
                        character = 10039,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [990] = {
                        id = 990,
                        group = "高雄_举手闭眼",
                        character = 10039,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [991] = {
                        id = 991,
                        group = "高雄_生气",
                        character = 10039,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [992] = {
                        id = 992,
                        group = "高雄_生气",
                        character = 10039,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [993] = {
                        id = 993,
                        group = "高雄_悲伤",
                        character = 10039,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [994] = {
                        id = 994,
                        group = "高雄_悲伤",
                        character = 10039,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [995] = {
                        id = 995,
                        group = "高雄_悲伤2",
                        character = 10039,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [996] = {
                        id = 996,
                        group = "高雄_悲伤2",
                        character = 10039,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [997] = {
                        id = 997,
                        group = "高雄_害怕",
                        character = 10039,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [998] = {
                        id = 998,
                        group = "高雄_害怕",
                        character = 10039,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [999] = {
                        id = 999,
                        group = "高雄_后退害怕",
                        character = 10039,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1000] = {
                        id = 1000,
                        group = "高雄_后退害怕",
                        character = 10039,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1001] = {
                        id = 1001,
                        group = "高雄_害羞",
                        character = 10039,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1002] = {
                        id = 1002,
                        group = "高雄_害羞",
                        character = 10039,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1003] = {
                        id = 1003,
                        group = "高雄_捂脸害羞",
                        character = 10039,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1004] = {
                        id = 1004,
                        group = "高雄_捂脸害羞",
                        character = 10039,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1005] = {
                        id = 1005,
                        group = "高雄_害羞2",
                        character = 10039,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1006] = {
                        id = 1006,
                        group = "高雄_害羞2",
                        character = 10039,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1007] = {
                        id = 1007,
                        group = "高雄_惊讶",
                        character = 10039,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1008] = {
                        id = 1008,
                        group = "高雄_惊讶",
                        character = 10039,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1009] = {
                        id = 1009,
                        group = "高雄_严肃",
                        character = 10039,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1010] = {
                        id = 1010,
                        group = "高雄_严肃",
                        character = 10039,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1011] = {
                        id = 1011,
                        group = "女灶神_默认",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1012] = {
                        id = 1012,
                        group = "女灶神_默认",
                        character = 10033,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1013] = {
                        id = 1013,
                        group = "女灶神_默认2",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1014] = {
                        id = 1014,
                        group = "女灶神_默认2",
                        character = 10033,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1015] = {
                        id = 1015,
                        group = "女灶神_笑",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1016] = {
                        id = 1016,
                        group = "女灶神_笑",
                        character = 10033,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1017] = {
                        id = 1017,
                        group = "女灶神_放松笑",
                        character = 10033,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1018] = {
                        id = 1018,
                        group = "女灶神_放松笑",
                        character = 10033,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1019] = {
                        id = 1019,
                        group = "女灶神_笑2",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1020] = {
                        id = 1020,
                        group = "女灶神_笑2",
                        character = 10033,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1021] = {
                        id = 1021,
                        group = "女灶神_闭眼",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1022] = {
                        id = 1022,
                        group = "女灶神_闭眼",
                        character = 10033,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1023] = {
                        id = 1023,
                        group = "女灶神_生气",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1024] = {
                        id = 1024,
                        group = "女灶神_生气",
                        character = 10033,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1025] = {
                        id = 1025,
                        group = "女灶神_站立生气",
                        character = 10033,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1026] = {
                        id = 1026,
                        group = "女灶神_站立生气",
                        character = 10033,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1027] = {
                        id = 1027,
                        group = "女灶神_生气2",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1028] = {
                        id = 1028,
                        group = "女灶神_生气2",
                        character = 10033,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1029] = {
                        id = 1029,
                        group = "女灶神_悲伤",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1030] = {
                        id = 1030,
                        group = "女灶神_悲伤",
                        character = 10033,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1031] = {
                        id = 1031,
                        group = "女灶神_害怕",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1032] = {
                        id = 1032,
                        group = "女灶神_害怕",
                        character = 10033,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1033] = {
                        id = 1033,
                        group = "女灶神_惊吓害怕",
                        character = 10033,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1034] = {
                        id = 1034,
                        group = "女灶神_惊吓害怕",
                        character = 10033,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1035] = {
                        id = 1035,
                        group = "女灶神_害羞",
                        character = 10033,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1036] = {
                        id = 1036,
                        group = "女灶神_害羞",
                        character = 10033,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1037] = {
                        id = 1037,
                        group = "女灶神_害羞2",
                        character = 10033,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1038] = {
                        id = 1038,
                        group = "女灶神_害羞2",
                        character = 10033,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1039] = {
                        id = 1039,
                        group = "女灶神_害羞3",
                        character = 10033,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1040] = {
                        id = 1040,
                        group = "女灶神_害羞3",
                        character = 10033,
                        resource = "shy3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1041] = {
                        id = 1041,
                        group = "女灶神_害羞4",
                        character = 10033,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1042] = {
                        id = 1042,
                        group = "女灶神_害羞4",
                        character = 10033,
                        resource = "shy4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1043] = {
                        id = 1043,
                        group = "女灶神_惊讶",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1044] = {
                        id = 1044,
                        group = "女灶神_惊讶",
                        character = 10033,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1045] = {
                        id = 1045,
                        group = "女灶神_后仰惊讶",
                        character = 10033,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1046] = {
                        id = 1046,
                        group = "女灶神_后仰惊讶",
                        character = 10033,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1047] = {
                        id = 1047,
                        group = "女灶神_严肃",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1048] = {
                        id = 1048,
                        group = "女灶神_严肃",
                        character = 10033,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1049] = {
                        id = 1049,
                        group = "女灶神_直立严肃",
                        character = 10033,
                        resource = "serious_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1050] = {
                        id = 1050,
                        group = "女灶神_直立严肃",
                        character = 10033,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1051] = {
                        id = 1051,
                        group = "女灶神_嫌弃",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1052] = {
                        id = 1052,
                        group = "女灶神_嫌弃",
                        character = 10033,
                        resource = "dislike_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1053] = {
                        id = 1053,
                        group = "女灶神_说教",
                        character = 10033,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1054] = {
                        id = 1054,
                        group = "女灶神_说教",
                        character = 10033,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1055] = {
                        id = 1055,
                        group = "女灶神_无奈",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1056] = {
                        id = 1056,
                        group = "女灶神_无奈",
                        character = 10033,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1057] = {
                        id = 1057,
                        group = "女灶神_吃饭",
                        character = 10033,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1058] = {
                        id = 1058,
                        group = "女灶神_吃饭",
                        character = 10033,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1059] = {
                        id = 1059,
                        group = "女灶神_惊喜",
                        character = 10033,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1060] = {
                        id = 1060,
                        group = "女灶神_惊喜",
                        character = 10033,
                        resource = "sp4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1061] = {
                        id = 1061,
                        group = "吹雪_默认",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1062] = {
                        id = 1062,
                        group = "吹雪_默认",
                        character = 10037,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1063] = {
                        id = 1063,
                        group = "吹雪_默认2",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1064] = {
                        id = 1064,
                        group = "吹雪_默认2",
                        character = 10037,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1065] = {
                        id = 1065,
                        group = "吹雪_笑",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1066] = {
                        id = 1066,
                        group = "吹雪_笑",
                        character = 10037,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1067] = {
                        id = 1067,
                        group = "吹雪_笑2",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1068] = {
                        id = 1068,
                        group = "吹雪_笑2",
                        character = 10037,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1069] = {
                        id = 1069,
                        group = "吹雪_摇摆笑",
                        character = 10037,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1070] = {
                        id = 1070,
                        group = "吹雪_摇摆笑",
                        character = 10037,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1071] = {
                        id = 1071,
                        group = "吹雪_闭眼",
                        character = 10037,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1072] = {
                        id = 1072,
                        group = "吹雪_闭眼",
                        character = 10037,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1073] = {
                        id = 1073,
                        group = "吹雪_闭眼2",
                        character = 10037,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1074] = {
                        id = 1074,
                        group = "吹雪_闭眼2",
                        character = 10037,
                        resource = "closeeye2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1075] = {
                        id = 1075,
                        group = "吹雪_生气",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1076] = {
                        id = 1076,
                        group = "吹雪_生气",
                        character = 10037,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1077] = {
                        id = 1077,
                        group = "吹雪_生气2",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1078] = {
                        id = 1078,
                        group = "吹雪_生气2",
                        character = 10037,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1079] = {
                        id = 1079,
                        group = "吹雪_攥拳生气",
                        character = 10037,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1080] = {
                        id = 1080,
                        group = "吹雪_攥拳生气",
                        character = 10037,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1081] = {
                        id = 1081,
                        group = "吹雪_悲伤",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1082] = {
                        id = 1082,
                        group = "吹雪_悲伤",
                        character = 10037,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1083] = {
                        id = 1083,
                        group = "吹雪_悲伤2",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1084] = {
                        id = 1084,
                        group = "吹雪_悲伤2",
                        character = 10037,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1085] = {
                        id = 1085,
                        group = "吹雪_站立悲伤",
                        character = 10037,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1086] = {
                        id = 1086,
                        group = "吹雪_站立悲伤",
                        character = 10037,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1087] = {
                        id = 1087,
                        group = "吹雪_害怕",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1088] = {
                        id = 1088,
                        group = "吹雪_害怕",
                        character = 10037,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1089] = {
                        id = 1089,
                        group = "吹雪_害怕2",
                        character = 10037,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1090] = {
                        id = 1090,
                        group = "吹雪_害怕2",
                        character = 10037,
                        resource = "scare2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1091] = {
                        id = 1091,
                        group = "吹雪_后仰害怕",
                        character = 10037,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1092] = {
                        id = 1092,
                        group = "吹雪_后仰害怕",
                        character = 10037,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1093] = {
                        id = 1093,
                        group = "吹雪_害羞",
                        character = 10037,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1094] = {
                        id = 1094,
                        group = "吹雪_害羞",
                        character = 10037,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1095] = {
                        id = 1095,
                        group = "吹雪_害羞2",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1096] = {
                        id = 1096,
                        group = "吹雪_害羞2",
                        character = 10037,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1097] = {
                        id = 1097,
                        group = "吹雪_害羞3",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1098] = {
                        id = 1098,
                        group = "吹雪_害羞3",
                        character = 10037,
                        resource = "shy3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1099] = {
                        id = 1099,
                        group = "吹雪_惊讶",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1100] = {
                        id = 1100,
                        group = "吹雪_惊讶",
                        character = 10037,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1101] = {
                        id = 1101,
                        group = "吹雪_后仰惊讶",
                        character = 10037,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1102] = {
                        id = 1102,
                        group = "吹雪_后仰惊讶",
                        character = 10037,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1103] = {
                        id = 1103,
                        group = "吹雪_严肃",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1104] = {
                        id = 1104,
                        group = "吹雪_严肃",
                        character = 10037,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1105] = {
                        id = 1105,
                        group = "吹雪_wink",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1106] = {
                        id = 1106,
                        group = "吹雪_wink",
                        character = 10037,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1107] = {
                        id = 1107,
                        group = "吹雪_心虚",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1108] = {
                        id = 1108,
                        group = "吹雪_心虚",
                        character = 10037,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1109] = {
                        id = 1109,
                        group = "吹雪_疑惑",
                        character = 10037,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1110] = {
                        id = 1110,
                        group = "吹雪_疑惑",
                        character = 10037,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1111] = {
                        id = 1111,
                        group = "矶风_默认",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1112] = {
                        id = 1112,
                        group = "矶风_默认",
                        character = 10053,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1113] = {
                        id = 1113,
                        group = "矶风_笑",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1114] = {
                        id = 1114,
                        group = "矶风_笑",
                        character = 10053,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1115] = {
                        id = 1115,
                        group = "矶风_笑2",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1116] = {
                        id = 1116,
                        group = "矶风_笑2",
                        character = 10053,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1117] = {
                        id = 1117,
                        group = "矶风_闭眼",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1118] = {
                        id = 1118,
                        group = "矶风_闭眼",
                        character = 10053,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1119] = {
                        id = 1119,
                        group = "矶风_闭眼2",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1120] = {
                        id = 1120,
                        group = "矶风_闭眼2",
                        character = 10053,
                        resource = "closeeye2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1121] = {
                        id = 1121,
                        group = "矶风_闭眼3",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1122] = {
                        id = 1122,
                        group = "矶风_闭眼3",
                        character = 10053,
                        resource = "closeeye3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1123] = {
                        id = 1123,
                        group = "矶风_生气",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1124] = {
                        id = 1124,
                        group = "矶风_生气",
                        character = 10053,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1125] = {
                        id = 1125,
                        group = "矶风_生气2",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1126] = {
                        id = 1126,
                        group = "矶风_生气2",
                        character = 10053,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1127] = {
                        id = 1127,
                        group = "矶风_悲伤",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1128] = {
                        id = 1128,
                        group = "矶风_悲伤",
                        character = 10053,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1129] = {
                        id = 1129,
                        group = "矶风_悲伤2",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1130] = {
                        id = 1130,
                        group = "矶风_悲伤2",
                        character = 10053,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1131] = {
                        id = 1131,
                        group = "矶风_直立悲伤",
                        character = 10053,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1132] = {
                        id = 1132,
                        group = "矶风_直立悲伤",
                        character = 10053,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1133] = {
                        id = 1133,
                        group = "矶风_直立悲伤2",
                        character = 10053,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1134] = {
                        id = 1134,
                        group = "矶风_直立悲伤2",
                        character = 10053,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1135] = {
                        id = 1135,
                        group = "矶风_害怕",
                        character = 10053,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1136] = {
                        id = 1136,
                        group = "矶风_害怕",
                        character = 10053,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1137] = {
                        id = 1137,
                        group = "矶风_害羞",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1138] = {
                        id = 1138,
                        group = "矶风_害羞",
                        character = 10053,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1139] = {
                        id = 1139,
                        group = "矶风_害羞2",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1140] = {
                        id = 1140,
                        group = "矶风_害羞2",
                        character = 10053,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1141] = {
                        id = 1141,
                        group = "矶风_害羞3",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1142] = {
                        id = 1142,
                        group = "矶风_害羞3",
                        character = 10053,
                        resource = "shy3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1143] = {
                        id = 1143,
                        group = "矶风_惊讶",
                        character = 10053,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1144] = {
                        id = 1144,
                        group = "矶风_惊讶",
                        character = 10053,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1145] = {
                        id = 1145,
                        group = "矶风_惊讶2",
                        character = 10053,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1146] = {
                        id = 1146,
                        group = "矶风_惊讶2",
                        character = 10053,
                        resource = "amazed2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1147] = {
                        id = 1147,
                        group = "矶风_严肃",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1148] = {
                        id = 1148,
                        group = "矶风_严肃",
                        character = 10053,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1149] = {
                        id = 1149,
                        group = "矶风_站立严肃",
                        character = 10053,
                        resource = "serious_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1150] = {
                        id = 1150,
                        group = "矶风_站立严肃",
                        character = 10053,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1151] = {
                        id = 1151,
                        group = "矶风_担忧",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1152] = {
                        id = 1152,
                        group = "矶风_担忧",
                        character = 10053,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1153] = {
                        id = 1153,
                        group = "矶风_强颜欢笑",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1154] = {
                        id = 1154,
                        group = "矶风_强颜欢笑",
                        character = 10053,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1155] = {
                        id = 1155,
                        group = "矶风_感动",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1156] = {
                        id = 1156,
                        group = "矶风_感动",
                        character = 10053,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1157] = {
                        id = 1157,
                        group = "矶风_苦笑",
                        character = 10053,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1158] = {
                        id = 1158,
                        group = "矶风_苦笑",
                        character = 10053,
                        resource = "sp4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1159] = {
                        id = 1159,
                        group = "戈本_惊讶",
                        character = 10028,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1160] = {
                        id = 1160,
                        group = "戈本_惊讶",
                        character = 10028,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1161] = {
                        id = 1161,
                        group = "戈本_抬手生气",
                        character = 10028,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1162] = {
                        id = 1162,
                        group = "戈本_抬手生气",
                        character = 10028,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1163] = {
                        id = 1163,
                        group = "戈本_抚胸闭眼",
                        character = 10028,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1164] = {
                        id = 1164,
                        group = "戈本_抚胸闭眼",
                        character = 10028,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1165] = {
                        id = 1165,
                        group = "戈本_抬手疑惑",
                        character = 10028,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1166] = {
                        id = 1166,
                        group = "戈本_抬手疑惑",
                        character = 10028,
                        resource = "closeeye3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1167] = {
                        id = 1167,
                        group = "戈本_抚胸苦笑",
                        character = 10028,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1168] = {
                        id = 1168,
                        group = "戈本_抚胸苦笑",
                        character = 10028,
                        resource = "closeeye4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1169] = {
                        id = 1169,
                        group = "戈本_抬手苦笑",
                        character = 10028,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1170] = {
                        id = 1170,
                        group = "戈本_抬手苦笑",
                        character = 10028,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1171] = {
                        id = 1171,
                        group = "戈本_嫌弃",
                        character = 10028,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1172] = {
                        id = 1172,
                        group = "戈本_嫌弃",
                        character = 10028,
                        resource = "dislike_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1173] = {
                        id = 1173,
                        group = "戈本_默认",
                        character = 10028,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1174] = {
                        id = 1174,
                        group = "戈本_默认",
                        character = 10028,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1175] = {
                        id = 1175,
                        group = "戈本_默认2",
                        character = 10028,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1176] = {
                        id = 1176,
                        group = "戈本_默认2",
                        character = 10028,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1177] = {
                        id = 1177,
                        group = "戈本_笑",
                        character = 10028,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1178] = {
                        id = 1178,
                        group = "戈本_笑",
                        character = 10028,
                        resource = "closeeye2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1179] = {
                        id = 1179,
                        group = "戈本_摇摆笑",
                        character = 10028,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1180] = {
                        id = 1180,
                        group = "戈本_摇摆笑",
                        character = 10028,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1181] = {
                        id = 1181,
                        group = "戈本_流汗笑",
                        character = 10028,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1182] = {
                        id = 1182,
                        group = "戈本_流汗笑",
                        character = 10028,
                        resource = "laugh3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1183] = {
                        id = 1183,
                        group = "戈本_抚胸悲伤",
                        character = 10028,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1184] = {
                        id = 1184,
                        group = "戈本_抚胸悲伤",
                        character = 10028,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1185] = {
                        id = 1185,
                        group = "戈本_害怕",
                        character = 10028,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1186] = {
                        id = 1186,
                        group = "戈本_害怕",
                        character = 10028,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1187] = {
                        id = 1187,
                        group = "戈本_抚胸严肃",
                        character = 10028,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1188] = {
                        id = 1188,
                        group = "戈本_抚胸严肃",
                        character = 10028,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1189] = {
                        id = 1189,
                        group = "戈本_手势害羞",
                        character = 10028,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1190] = {
                        id = 1190,
                        group = "戈本_手势害羞",
                        character = 10028,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1191] = {
                        id = 1191,
                        group = "戈本_手势害羞2",
                        character = 10028,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1192] = {
                        id = 1192,
                        group = "戈本_手势害羞2",
                        character = 10028,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1193] = {
                        id = 1193,
                        group = "戈本_抚胸害羞",
                        character = 10028,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1194] = {
                        id = 1194,
                        group = "戈本_抚胸害羞",
                        character = 10028,
                        resource = "shy3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1195] = {
                        id = 1195,
                        group = "戈本_猫嘴",
                        character = 10028,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1196] = {
                        id = 1196,
                        group = "戈本_猫嘴",
                        character = 10028,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1197] = {
                        id = 1197,
                        group = "隼鹰_抬手惊讶",
                        character = 10031,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1198] = {
                        id = 1198,
                        group = "隼鹰_抬手惊讶",
                        character = 10031,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1199] = {
                        id = 1199,
                        group = "隼鹰_抬手惊讶2",
                        character = 10031,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1200] = {
                        id = 1200,
                        group = "隼鹰_抬手惊讶2",
                        character = 10031,
                        resource = "amazed2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1201] = {
                        id = 1201,
                        group = "隼鹰_垂手生气",
                        character = 10031,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1202] = {
                        id = 1202,
                        group = "隼鹰_垂手生气",
                        character = 10031,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1203] = {
                        id = 1203,
                        group = "隼鹰_垂手生气2",
                        character = 10031,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1204] = {
                        id = 1204,
                        group = "隼鹰_垂手生气2",
                        character = 10031,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1205] = {
                        id = 1205,
                        group = "隼鹰_垂手生气3",
                        character = 10031,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1206] = {
                        id = 1206,
                        group = "隼鹰_垂手生气3",
                        character = 10031,
                        resource = "angry3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1207] = {
                        id = 1207,
                        group = "隼鹰_托腮闭眼",
                        character = 10031,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1208] = {
                        id = 1208,
                        group = "隼鹰_托腮闭眼",
                        character = 10031,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1209] = {
                        id = 1209,
                        group = "隼鹰_苦笑",
                        character = 10031,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1210] = {
                        id = 1210,
                        group = "隼鹰_苦笑",
                        character = 10031,
                        resource = "closeeye2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1211] = {
                        id = 1211,
                        group = "隼鹰_默认",
                        character = 10031,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1212] = {
                        id = 1212,
                        group = "隼鹰_默认",
                        character = 10031,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1213] = {
                        id = 1213,
                        group = "隼鹰_托腮疑惑",
                        character = 10031,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1214] = {
                        id = 1214,
                        group = "隼鹰_托腮疑惑",
                        character = 10031,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1215] = {
                        id = 1215,
                        group = "隼鹰_摇摆笑",
                        character = 10031,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1216] = {
                        id = 1216,
                        group = "隼鹰_摇摆笑",
                        character = 10031,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1217] = {
                        id = 1217,
                        group = "隼鹰_摇摆笑2",
                        character = 10031,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1218] = {
                        id = 1218,
                        group = "隼鹰_摇摆笑2",
                        character = 10031,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1219] = {
                        id = 1219,
                        group = "隼鹰_托腮笑",
                        character = 10031,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1220] = {
                        id = 1220,
                        group = "隼鹰_托腮笑",
                        character = 10031,
                        resource = "laugh3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1221] = {
                        id = 1221,
                        group = "隼鹰_悲伤",
                        character = 10031,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1222] = {
                        id = 1222,
                        group = "隼鹰_悲伤",
                        character = 10031,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1223] = {
                        id = 1223,
                        group = "隼鹰_悲伤2",
                        character = 10031,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1224] = {
                        id = 1224,
                        group = "隼鹰_悲伤2",
                        character = 10031,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1225] = {
                        id = 1225,
                        group = "隼鹰_抬手悲伤",
                        character = 10031,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1226] = {
                        id = 1226,
                        group = "隼鹰_抬手悲伤",
                        character = 10031,
                        resource = "sad3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1227] = {
                        id = 1227,
                        group = "隼鹰_后仰害怕",
                        character = 10031,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1228] = {
                        id = 1228,
                        group = "隼鹰_后仰害怕",
                        character = 10031,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1229] = {
                        id = 1229,
                        group = "隼鹰_后仰害怕2",
                        character = 10031,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1230] = {
                        id = 1230,
                        group = "隼鹰_后仰害怕2",
                        character = 10031,
                        resource = "scare2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1231] = {
                        id = 1231,
                        group = "隼鹰_后仰害怕3",
                        character = 10031,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1232] = {
                        id = 1232,
                        group = "隼鹰_后仰害怕3",
                        character = 10031,
                        resource = "scare3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1233] = {
                        id = 1233,
                        group = "隼鹰_严肃",
                        character = 10031,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1234] = {
                        id = 1234,
                        group = "隼鹰_严肃",
                        character = 10031,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1235] = {
                        id = 1235,
                        group = "隼鹰_托腮害羞",
                        character = 10031,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1236] = {
                        id = 1236,
                        group = "隼鹰_托腮害羞",
                        character = 10031,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1237] = {
                        id = 1237,
                        group = "隼鹰_托腮害羞2",
                        character = 10031,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1238] = {
                        id = 1238,
                        group = "隼鹰_托腮害羞2",
                        character = 10031,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1239] = {
                        id = 1239,
                        group = "隼鹰_托腮害羞3",
                        character = 10031,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1240] = {
                        id = 1240,
                        group = "隼鹰_托腮害羞3",
                        character = 10031,
                        resource = "shy3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1241] = {
                        id = 1241,
                        group = "隼鹰_托腮害羞4",
                        character = 10031,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1242] = {
                        id = 1242,
                        group = "隼鹰_托腮害羞4",
                        character = 10031,
                        resource = "shy4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1243] = {
                        id = 1243,
                        group = "隼鹰_摇摆自信",
                        character = 10031,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1244] = {
                        id = 1244,
                        group = "隼鹰_摇摆自信",
                        character = 10031,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1245] = {
                        id = 1245,
                        group = "隼鹰_摇摆自信2",
                        character = 10031,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1246] = {
                        id = 1246,
                        group = "隼鹰_摇摆自信2",
                        character = 10031,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1247] = {
                        id = 1247,
                        group = "隼鹰_垂手失望",
                        character = 10031,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1248] = {
                        id = 1248,
                        group = "隼鹰_垂手失望",
                        character = 10031,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1249] = {
                        id = 1249,
                        group = "隼鹰_垂手失望2",
                        character = 10031,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1250] = {
                        id = 1250,
                        group = "隼鹰_垂手失望2",
                        character = 10031,
                        resource = "sp4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1251] = {
                        id = 1251,
                        group = "隼鹰_垂手担忧",
                        character = 10031,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1252] = {
                        id = 1252,
                        group = "隼鹰_垂手担忧",
                        character = 10031,
                        resource = "sp5_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1253] = {
                        id = 1253,
                        group = "隼鹰_垂手睡眠",
                        character = 10031,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1254] = {
                        id = 1254,
                        group = "隼鹰_垂手睡眠",
                        character = 10031,
                        resource = "laugh3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1255] = {
                        id = 1255,
                        group = "基林_抬手惊讶",
                        character = 10038,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1256] = {
                        id = 1256,
                        group = "基林_抬手惊讶",
                        character = 10038,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1257] = {
                        id = 1257,
                        group = "基林_抬手惊讶2",
                        character = 10038,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1258] = {
                        id = 1258,
                        group = "基林_抬手惊讶2",
                        character = 10038,
                        resource = "amazed2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1259] = {
                        id = 1259,
                        group = "基林_生气",
                        character = 10038,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1260] = {
                        id = 1260,
                        group = "基林_生气",
                        character = 10038,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1261] = {
                        id = 1261,
                        group = "基林_生气2",
                        character = 10038,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1262] = {
                        id = 1262,
                        group = "基林_生气2",
                        character = 10038,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1263] = {
                        id = 1263,
                        group = "基林_抬手苦笑",
                        character = 10038,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1264] = {
                        id = 1264,
                        group = "基林_抬手苦笑",
                        character = 10038,
                        resource = "closeeye2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1265] = {
                        id = 1265,
                        group = "基林_默认",
                        character = 10038,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1266] = {
                        id = 1266,
                        group = "基林_默认",
                        character = 10038,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1267] = {
                        id = 1267,
                        group = "基林_抬手疑惑",
                        character = 10038,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1268] = {
                        id = 1268,
                        group = "基林_抬手疑惑",
                        character = 10038,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1269] = {
                        id = 1269,
                        group = "基林_抬手笑",
                        character = 10038,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1270] = {
                        id = 1270,
                        group = "基林_抬手笑",
                        character = 10038,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1271] = {
                        id = 1271,
                        group = "基林_举手摇摆笑",
                        character = 10038,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1272] = {
                        id = 1272,
                        group = "基林_举手摇摆笑",
                        character = 10038,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1273] = {
                        id = 1273,
                        group = "基林_笑3",
                        character = 10038,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1274] = {
                        id = 1274,
                        group = "基林_笑3",
                        character = 10038,
                        resource = "laugh3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1275] = {
                        id = 1275,
                        group = "基林_抬手悲伤",
                        character = 10038,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1276] = {
                        id = 1276,
                        group = "基林_抬手悲伤",
                        character = 10038,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1277] = {
                        id = 1277,
                        group = "基林_抬手悲伤2",
                        character = 10038,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1278] = {
                        id = 1278,
                        group = "基林_抬手悲伤2",
                        character = 10038,
                        resource = "sad3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1279] = {
                        id = 1279,
                        group = "基林_抬手失望",
                        character = 10038,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1280] = {
                        id = 1280,
                        group = "基林_抬手失望",
                        character = 10038,
                        resource = "sad4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1281] = {
                        id = 1281,
                        group = "基林_歪头困扰",
                        character = 10038,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1282] = {
                        id = 1282,
                        group = "基林_歪头困扰",
                        character = 10038,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1283] = {
                        id = 1283,
                        group = "基林_抬手害怕",
                        character = 10038,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1284] = {
                        id = 1284,
                        group = "基林_抬手害怕",
                        character = 10038,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1285] = {
                        id = 1285,
                        group = "基林_严肃",
                        character = 10038,
                        resource = "serious_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1286] = {
                        id = 1286,
                        group = "基林_严肃",
                        character = 10038,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1287] = {
                        id = 1287,
                        group = "基林_斜视害羞",
                        character = 10038,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1288] = {
                        id = 1288,
                        group = "基林_斜视害羞",
                        character = 10038,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1289] = {
                        id = 1289,
                        group = "基林_斜视害羞2",
                        character = 10038,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1290] = {
                        id = 1290,
                        group = "基林_斜视害羞2",
                        character = 10038,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1291] = {
                        id = 1291,
                        group = "基林_抬手害羞",
                        character = 10038,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1292] = {
                        id = 1292,
                        group = "基林_抬手害羞",
                        character = 10038,
                        resource = "shy3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1293] = {
                        id = 1293,
                        group = "基林_得意",
                        character = 10038,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1294] = {
                        id = 1294,
                        group = "基林_得意",
                        character = 10038,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1295] = {
                        id = 1295,
                        group = "基林_得意2",
                        character = 10038,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1296] = {
                        id = 1296,
                        group = "基林_得意2",
                        character = 10038,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1297] = {
                        id = 1297,
                        group = "基林_歪头鬼点子",
                        character = 10038,
                        resource = "sp3_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1298] = {
                        id = 1298,
                        group = "基林_歪头鬼点子",
                        character = 10038,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1299] = {
                        id = 1299,
                        group = "基林_斜视自责",
                        character = 10038,
                        resource = "sp4_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1300] = {
                        id = 1300,
                        group = "基林_斜视自责",
                        character = 10038,
                        resource = "sp4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1301] = {
                        id = 1301,
                        group = "基林_挥手自信",
                        character = 10038,
                        resource = "sp5_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1302] = {
                        id = 1302,
                        group = "基林_挥手自信",
                        character = 10038,
                        resource = "sp5_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1303] = {
                        id = 1303,
                        group = "萤火虫_默认",
                        character = 10032,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1304] = {
                        id = 1304,
                        group = "萤火虫_默认",
                        character = 10032,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1305] = {
                        id = 1305,
                        group = "萤火虫_收手默认",
                        character = 10032,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1306] = {
                        id = 1306,
                        group = "萤火虫_收手默认",
                        character = 10032,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1307] = {
                        id = 1307,
                        group = "萤火虫_星星默认",
                        character = 10032,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1308] = {
                        id = 1308,
                        group = "萤火虫_星星默认",
                        character = 10032,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1309] = {
                        id = 1309,
                        group = "萤火虫_笑",
                        character = 10032,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1310] = {
                        id = 1310,
                        group = "萤火虫_笑",
                        character = 10032,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1311] = {
                        id = 1311,
                        group = "萤火虫_收手笑",
                        character = 10032,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1312] = {
                        id = 1312,
                        group = "萤火虫_收手笑",
                        character = 10032,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1313] = {
                        id = 1313,
                        group = "萤火虫_闭眼",
                        character = 10032,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1314] = {
                        id = 1314,
                        group = "萤火虫_闭眼",
                        character = 10032,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1315] = {
                        id = 1315,
                        group = "萤火虫_闭眼2",
                        character = 10032,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1316] = {
                        id = 1316,
                        group = "萤火虫_闭眼2",
                        character = 10032,
                        resource = "closeeye2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1317] = {
                        id = 1317,
                        group = "萤火虫_生气",
                        character = 10032,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1318] = {
                        id = 1318,
                        group = "萤火虫_生气",
                        character = 10032,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1319] = {
                        id = 1319,
                        group = "萤火虫_生气2",
                        character = 10032,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1320] = {
                        id = 1320,
                        group = "萤火虫_生气2",
                        character = 10032,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1321] = {
                        id = 1321,
                        group = "萤火虫_收手生气",
                        character = 10032,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1322] = {
                        id = 1322,
                        group = "萤火虫_收手生气",
                        character = 10032,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1323] = {
                        id = 1323,
                        group = "萤火虫_收手生气2",
                        character = 10032,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1324] = {
                        id = 1324,
                        group = "萤火虫_收手生气2",
                        character = 10032,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1325] = {
                        id = 1325,
                        group = "萤火虫_悲伤",
                        character = 10032,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1326] = {
                        id = 1326,
                        group = "萤火虫_悲伤",
                        character = 10032,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1327] = {
                        id = 1327,
                        group = "萤火虫_悲伤2",
                        character = 10032,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1328] = {
                        id = 1328,
                        group = "萤火虫_悲伤2",
                        character = 10032,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1329] = {
                        id = 1329,
                        group = "萤火虫_收手悲伤2",
                        character = 10032,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1330] = {
                        id = 1330,
                        group = "萤火虫_收手悲伤2",
                        character = 10032,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1331] = {
                        id = 1331,
                        group = "萤火虫_悲伤3",
                        character = 10032,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1332] = {
                        id = 1332,
                        group = "萤火虫_悲伤3",
                        character = 10032,
                        resource = "sad3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1333] = {
                        id = 1333,
                        group = "萤火虫_害怕",
                        character = 10032,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1334] = {
                        id = 1334,
                        group = "萤火虫_害怕",
                        character = 10032,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1335] = {
                        id = 1335,
                        group = "萤火虫_害怕2",
                        character = 10032,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1336] = {
                        id = 1336,
                        group = "萤火虫_害怕2",
                        character = 10032,
                        resource = "scare2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1337] = {
                        id = 1337,
                        group = "萤火虫_害羞",
                        character = 10032,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1338] = {
                        id = 1338,
                        group = "萤火虫_害羞",
                        character = 10032,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1339] = {
                        id = 1339,
                        group = "萤火虫_害羞2",
                        character = 10032,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1340] = {
                        id = 1340,
                        group = "萤火虫_害羞2",
                        character = 10032,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1341] = {
                        id = 1341,
                        group = "萤火虫_合手害羞2",
                        character = 10032,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1342] = {
                        id = 1342,
                        group = "萤火虫_合手害羞2",
                        character = 10032,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1343] = {
                        id = 1343,
                        group = "萤火虫_自豪",
                        character = 10032,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1344] = {
                        id = 1344,
                        group = "萤火虫_自豪",
                        character = 10032,
                        resource = "proud_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1345] = {
                        id = 1345,
                        group = "萤火虫_期望",
                        character = 10032,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1346] = {
                        id = 1346,
                        group = "萤火虫_期望",
                        character = 10032,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1347] = {
                        id = 1347,
                        group = "圣地亚哥_默认",
                        character = 10030,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1348] = {
                        id = 1348,
                        group = "圣地亚哥_默认",
                        character = 10030,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1349] = {
                        id = 1349,
                        group = "列克星敦_默认",
                        character = 10042,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1350] = {
                        id = 1350,
                        group = "列克星敦_默认",
                        character = 10042,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1351] = {
                        id = 1351,
                        group = "U2336_默认",
                        character = 10050,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1352] = {
                        id = 1352,
                        group = "U2336_默认",
                        character = 10050,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1353] = {
                        id = 1353,
                        group = "U2336_双手惊讶",
                        character = 10050,
                        resource = "sp4_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1354] = {
                        id = 1354,
                        group = "U2336_双手惊讶",
                        character = 10050,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1355] = {
                        id = 1355,
                        group = "U2336_失望",
                        character = 10050,
                        resource = "serious_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1356] = {
                        id = 1356,
                        group = "U2336_失望",
                        character = 10050,
                        resource = "amazed2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1357] = {
                        id = 1357,
                        group = "U2336_胡言乱语",
                        character = 10050,
                        resource = "serious_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1358] = {
                        id = 1358,
                        group = "U2336_胡言乱语",
                        character = 10050,
                        resource = "amazed3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1359] = {
                        id = 1359,
                        group = "U2336_双手生气",
                        character = 10050,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1360] = {
                        id = 1360,
                        group = "U2336_双手生气",
                        character = 10050,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1361] = {
                        id = 1361,
                        group = "U2336_双手生气2",
                        character = 10050,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1362] = {
                        id = 1362,
                        group = "U2336_双手生气2",
                        character = 10050,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1363] = {
                        id = 1363,
                        group = "U2336_微笑",
                        character = 10050,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1364] = {
                        id = 1364,
                        group = "U2336_微笑",
                        character = 10050,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1365] = {
                        id = 1365,
                        group = "U2336_疑惑",
                        character = 10050,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1366] = {
                        id = 1366,
                        group = "U2336_疑惑",
                        character = 10050,
                        resource = "idle3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1367] = {
                        id = 1367,
                        group = "U2336_手势笑",
                        character = 10050,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1368] = {
                        id = 1368,
                        group = "U2336_手势笑",
                        character = 10050,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1369] = {
                        id = 1369,
                        group = "U2336_手势笑2",
                        character = 10050,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1370] = {
                        id = 1370,
                        group = "U2336_手势笑2",
                        character = 10050,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1371] = {
                        id = 1371,
                        group = "U2336_手势得意",
                        character = 10050,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1372] = {
                        id = 1372,
                        group = "U2336_手势得意",
                        character = 10050,
                        resource = "laugh3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1373] = {
                        id = 1373,
                        group = "U2336_手势默认",
                        character = 10050,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1374] = {
                        id = 1374,
                        group = "U2336_手势默认",
                        character = 10050,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1375] = {
                        id = 1375,
                        group = "U2336_双手苦笑",
                        character = 10050,
                        resource = "sp4_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1376] = {
                        id = 1376,
                        group = "U2336_双手苦笑",
                        character = 10050,
                        resource = "laugh4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1377] = {
                        id = 1377,
                        group = "U2336_双手悲伤",
                        character = 10050,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1378] = {
                        id = 1378,
                        group = "U2336_双手悲伤",
                        character = 10050,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1379] = {
                        id = 1379,
                        group = "U2336_严肃",
                        character = 10050,
                        resource = "serious_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1380] = {
                        id = 1380,
                        group = "U2336_严肃",
                        character = 10050,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1381] = {
                        id = 1381,
                        group = "U2336_双手害羞",
                        character = 10050,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1382] = {
                        id = 1382,
                        group = "U2336_双手害羞",
                        character = 10050,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1383] = {
                        id = 1383,
                        group = "U2336_双手害羞2",
                        character = 10050,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1384] = {
                        id = 1384,
                        group = "U2336_双手害羞2",
                        character = 10050,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1385] = {
                        id = 1385,
                        group = "U2336_双手难为情",
                        character = 10050,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1386] = {
                        id = 1386,
                        group = "U2336_双手难为情",
                        character = 10050,
                        resource = "shy3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1387] = {
                        id = 1387,
                        group = "U2336_得意",
                        character = 10050,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1388] = {
                        id = 1388,
                        group = "U2336_得意",
                        character = 10050,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1389] = {
                        id = 1389,
                        group = "U2336_闭眼",
                        character = 10050,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1390] = {
                        id = 1390,
                        group = "U2336_闭眼",
                        character = 10050,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1391] = {
                        id = 1391,
                        group = "U2336_吐槽",
                        character = 10050,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1392] = {
                        id = 1392,
                        group = "U2336_吐槽",
                        character = 10050,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1393] = {
                        id = 1393,
                        group = "U2336_双手撞到",
                        character = 10050,
                        resource = "sp4_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1394] = {
                        id = 1394,
                        group = "U2336_双手撞到",
                        character = 10050,
                        resource = "sp4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1395] = {
                        id = 1395,
                        group = "U2336_空手默认",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1396] = {
                        id = 1396,
                        group = "U2336_空手默认",
                        character = 10050,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1397] = {
                        id = 1397,
                        group = "U2336_空手惊讶",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1398] = {
                        id = 1398,
                        group = "U2336_空手惊讶",
                        character = 10050,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1399] = {
                        id = 1399,
                        group = "U2336_空手失望",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1400] = {
                        id = 1400,
                        group = "U2336_空手失望",
                        character = 10050,
                        resource = "amazed2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1401] = {
                        id = 1401,
                        group = "U2336_空手胡言乱语",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1402] = {
                        id = 1402,
                        group = "U2336_空手胡言乱语",
                        character = 10050,
                        resource = "amazed3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1403] = {
                        id = 1403,
                        group = "U2336_空手生气",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1404] = {
                        id = 1404,
                        group = "U2336_空手生气",
                        character = 10050,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1405] = {
                        id = 1405,
                        group = "U2336_空手微笑",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1406] = {
                        id = 1406,
                        group = "U2336_空手微笑",
                        character = 10050,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1407] = {
                        id = 1407,
                        group = "U2336_空手疑惑",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1408] = {
                        id = 1408,
                        group = "U2336_空手疑惑",
                        character = 10050,
                        resource = "idle3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1409] = {
                        id = 1409,
                        group = "U2336_空手笑",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1410] = {
                        id = 1410,
                        group = "U2336_空手笑",
                        character = 10050,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1411] = {
                        id = 1411,
                        group = "U2336_空手笑2",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1412] = {
                        id = 1412,
                        group = "U2336_空手笑2",
                        character = 10050,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1413] = {
                        id = 1413,
                        group = "U2336_空手得意",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1414] = {
                        id = 1414,
                        group = "U2336_空手得意",
                        character = 10050,
                        resource = "laugh3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1415] = {
                        id = 1415,
                        group = "U2336_空手苦笑",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1416] = {
                        id = 1416,
                        group = "U2336_空手苦笑",
                        character = 10050,
                        resource = "laugh4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1417] = {
                        id = 1417,
                        group = "U2336_空手悲伤",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1418] = {
                        id = 1418,
                        group = "U2336_空手悲伤",
                        character = 10050,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1419] = {
                        id = 1419,
                        group = "U2336_空手严肃",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1420] = {
                        id = 1420,
                        group = "U2336_空手严肃",
                        character = 10050,
                        resource = "serious_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1421] = {
                        id = 1421,
                        group = "U2336_空手害羞",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1422] = {
                        id = 1422,
                        group = "U2336_空手害羞",
                        character = 10050,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1423] = {
                        id = 1423,
                        group = "U2336_空手害羞2",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1424] = {
                        id = 1424,
                        group = "U2336_空手害羞2",
                        character = 10050,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1425] = {
                        id = 1425,
                        group = "U2336_空手难为情",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1426] = {
                        id = 1426,
                        group = "U2336_空手难为情",
                        character = 10050,
                        resource = "shy3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1427] = {
                        id = 1427,
                        group = "U2336_空手得意2",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1428] = {
                        id = 1428,
                        group = "U2336_空手得意2",
                        character = 10050,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1429] = {
                        id = 1429,
                        group = "U2336_空手闭眼",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1430] = {
                        id = 1430,
                        group = "U2336_空手闭眼",
                        character = 10050,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1431] = {
                        id = 1431,
                        group = "U2336_空手吐槽",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1432] = {
                        id = 1432,
                        group = "U2336_空手吐槽",
                        character = 10050,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1433] = {
                        id = 1433,
                        group = "U2336_空手撞到",
                        character = 10050,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1434] = {
                        id = 1434,
                        group = "U2336_空手撞到",
                        character = 10050,
                        resource = "sp4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1435] = {
                        id = 1435,
                        group = "阿肯色_默认",
                        character = 10052,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1436] = {
                        id = 1436,
                        group = "阿肯色_默认",
                        character = 10052,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1437] = {
                        id = 1437,
                        group = "阿肯色_后仰惊讶",
                        character = 10052,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1438] = {
                        id = 1438,
                        group = "阿肯色_后仰惊讶",
                        character = 10052,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1439] = {
                        id = 1439,
                        group = "阿肯色_后仰惊讶2",
                        character = 10052,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1440] = {
                        id = 1440,
                        group = "阿肯色_后仰惊讶2",
                        character = 10052,
                        resource = "amazed2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1441] = {
                        id = 1441,
                        group = "阿肯色_前倾生气",
                        character = 10052,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1442] = {
                        id = 1442,
                        group = "阿肯色_前倾生气",
                        character = 10052,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1443] = {
                        id = 1443,
                        group = "阿肯色_疑惑",
                        character = 10052,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1444] = {
                        id = 1444,
                        group = "阿肯色_疑惑",
                        character = 10052,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1445] = {
                        id = 1445,
                        group = "阿肯色_前倾笑",
                        character = 10052,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1446] = {
                        id = 1446,
                        group = "阿肯色_前倾笑",
                        character = 10052,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1447] = {
                        id = 1447,
                        group = "阿肯色_前倾笑2",
                        character = 10052,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1448] = {
                        id = 1448,
                        group = "阿肯色_前倾笑2",
                        character = 10052,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1449] = {
                        id = 1449,
                        group = "阿肯色_手势苦笑",
                        character = 10052,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1450] = {
                        id = 1450,
                        group = "阿肯色_手势苦笑",
                        character = 10052,
                        resource = "laugh3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1451] = {
                        id = 1451,
                        group = "阿肯色_前倾悲伤",
                        character = 10052,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1452] = {
                        id = 1452,
                        group = "阿肯色_前倾悲伤",
                        character = 10052,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1453] = {
                        id = 1453,
                        group = "阿肯色_手势害怕",
                        character = 10052,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1454] = {
                        id = 1454,
                        group = "阿肯色_手势害怕",
                        character = 10052,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1455] = {
                        id = 1455,
                        group = "阿肯色_手势害怕2",
                        character = 10052,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1456] = {
                        id = 1456,
                        group = "阿肯色_手势害怕2",
                        character = 10052,
                        resource = "scare2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1457] = {
                        id = 1457,
                        group = "阿肯色_手势害羞",
                        character = 10052,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1458] = {
                        id = 1458,
                        group = "阿肯色_手势害羞",
                        character = 10052,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1459] = {
                        id = 1459,
                        group = "阿肯色_手势难为情",
                        character = 10052,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1460] = {
                        id = 1460,
                        group = "阿肯色_手势难为情",
                        character = 10052,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1461] = {
                        id = 1461,
                        group = "阿肯色_放松",
                        character = 10052,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1462] = {
                        id = 1462,
                        group = "阿肯色_放松",
                        character = 10052,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1463] = {
                        id = 1463,
                        group = "阿肯色_失望",
                        character = 10052,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1464] = {
                        id = 1464,
                        group = "阿肯色_失望",
                        character = 10052,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1465] = {
                        id = 1465,
                        group = "阿肯色_得意",
                        character = 10052,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1466] = {
                        id = 1466,
                        group = "阿肯色_得意",
                        character = 10052,
                        resource = "sp3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1467] = {
                        id = 1467,
                        group = "阿肯色_闭眼",
                        character = 10052,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1468] = {
                        id = 1468,
                        group = "阿肯色_闭眼",
                        character = 10052,
                        resource = "sp4_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1469] = {
                        id = 1469,
                        group = "安德烈亚_默认",
                        character = 10044,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1470] = {
                        id = 1470,
                        group = "安德烈亚_默认",
                        character = 10044,
                        resource = "idle_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1471] = {
                        id = 1471,
                        group = "安德烈亚_害羞",
                        character = 10044,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1472] = {
                        id = 1472,
                        group = "安德烈亚_害羞",
                        character = 10044,
                        resource = "idle2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1473] = {
                        id = 1473,
                        group = "安德烈亚_笑",
                        character = 10044,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1474] = {
                        id = 1474,
                        group = "安德烈亚_笑",
                        character = 10044,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1475] = {
                        id = 1475,
                        group = "安德烈亚_摇晃笑",
                        character = 10044,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1476] = {
                        id = 1476,
                        group = "安德烈亚_摇晃笑",
                        character = 10044,
                        resource = "laugh_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1477] = {
                        id = 1477,
                        group = "安德烈亚_摇晃害羞笑",
                        character = 10044,
                        resource = "laugh_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1478] = {
                        id = 1478,
                        group = "安德烈亚_摇晃害羞笑",
                        character = 10044,
                        resource = "laugh2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1479] = {
                        id = 1479,
                        group = "安德烈亚_生气笑",
                        character = 10044,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1480] = {
                        id = 1480,
                        group = "安德烈亚_生气笑",
                        character = 10044,
                        resource = "laugh3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1481] = {
                        id = 1481,
                        group = "安德烈亚_微笑闭眼",
                        character = 10044,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1482] = {
                        id = 1482,
                        group = "安德烈亚_微笑闭眼",
                        character = 10044,
                        resource = "closeeye_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1483] = {
                        id = 1483,
                        group = "安德烈亚_害羞闭眼",
                        character = 10044,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1484] = {
                        id = 1484,
                        group = "安德烈亚_害羞闭眼",
                        character = 10044,
                        resource = "closeeye2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1485] = {
                        id = 1485,
                        group = "安德烈亚_生气闭眼",
                        character = 10044,
                        resource = "closeeye_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1486] = {
                        id = 1486,
                        group = "安德烈亚_生气闭眼",
                        character = 10044,
                        resource = "closeeye3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1487] = {
                        id = 1487,
                        group = "安德烈亚_嫌弃",
                        character = 10044,
                        resource = "dislike_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1488] = {
                        id = 1488,
                        group = "安德烈亚_嫌弃",
                        character = 10044,
                        resource = "dislike_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1489] = {
                        id = 1489,
                        group = "安德烈亚_害羞嫌弃",
                        character = 10044,
                        resource = "dislike_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1490] = {
                        id = 1490,
                        group = "安德烈亚_害羞嫌弃",
                        character = 10044,
                        resource = "dislike2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1491] = {
                        id = 1491,
                        group = "安德烈亚_生气嫌弃",
                        character = 10044,
                        resource = "dislike_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1492] = {
                        id = 1492,
                        group = "安德烈亚_生气嫌弃",
                        character = 10044,
                        resource = "dislike3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1493] = {
                        id = 1493,
                        group = "安德烈亚_生气",
                        character = 10044,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1494] = {
                        id = 1494,
                        group = "安德烈亚_生气",
                        character = 10044,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1495] = {
                        id = 1495,
                        group = "安德烈亚_叉手生气",
                        character = 10044,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1496] = {
                        id = 1496,
                        group = "安德烈亚_叉手生气",
                        character = 10044,
                        resource = "angry_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1497] = {
                        id = 1497,
                        group = "安德烈亚_叉手生气2",
                        character = 10044,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1498] = {
                        id = 1498,
                        group = "安德烈亚_叉手生气2",
                        character = 10044,
                        resource = "angry2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1499] = {
                        id = 1499,
                        group = "安德烈亚_叉手生气3",
                        character = 10044,
                        resource = "angry_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1500] = {
                        id = 1500,
                        group = "安德烈亚_叉手生气3",
                        character = 10044,
                        resource = "angry3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1501] = {
                        id = 1501,
                        group = "安德烈亚_悲伤",
                        character = 10044,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1502] = {
                        id = 1502,
                        group = "安德烈亚_悲伤",
                        character = 10044,
                        resource = "sad_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1503] = {
                        id = 1503,
                        group = "安德烈亚_害羞悲伤",
                        character = 10044,
                        resource = "sad_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1504] = {
                        id = 1504,
                        group = "安德烈亚_害羞悲伤",
                        character = 10044,
                        resource = "sad2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1505] = {
                        id = 1505,
                        group = "安德烈亚_叉手悲伤",
                        character = 10044,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1506] = {
                        id = 1506,
                        group = "安德烈亚_叉手悲伤",
                        character = 10044,
                        resource = "sad3_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1507] = {
                        id = 1507,
                        group = "安德烈亚_害怕",
                        character = 10044,
                        resource = "idle_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1508] = {
                        id = 1508,
                        group = "安德烈亚_害怕",
                        character = 10044,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1509] = {
                        id = 1509,
                        group = "安德烈亚_后撤害怕",
                        character = 10044,
                        resource = "scare_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1510] = {
                        id = 1510,
                        group = "安德烈亚_后撤害怕",
                        character = 10044,
                        resource = "scare_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1511] = {
                        id = 1511,
                        group = "安德烈亚_叉手害羞",
                        character = 10044,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1512] = {
                        id = 1512,
                        group = "安德烈亚_叉手害羞",
                        character = 10044,
                        resource = "shy_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1513] = {
                        id = 1513,
                        group = "安德烈亚_叉手害羞2",
                        character = 10044,
                        resource = "shy_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1514] = {
                        id = 1514,
                        group = "安德烈亚_叉手害羞2",
                        character = 10044,
                        resource = "shy2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1515] = {
                        id = 1515,
                        group = "安德烈亚_惊讶",
                        character = 10044,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1516] = {
                        id = 1516,
                        group = "安德烈亚_惊讶",
                        character = 10044,
                        resource = "amazed_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1517] = {
                        id = 1517,
                        group = "安德烈亚_惊讶2",
                        character = 10044,
                        resource = "amazed_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1518] = {
                        id = 1518,
                        group = "安德烈亚_惊讶2",
                        character = 10044,
                        resource = "amazed2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1519] = {
                        id = 1519,
                        group = "安德烈亚_自信",
                        character = 10044,
                        resource = "sp1_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1520] = {
                        id = 1520,
                        group = "安德烈亚_自信",
                        character = 10044,
                        resource = "sp1_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

                [1521] = {
                        id = 1521,
                        group = "安德烈亚_无语",
                        character = 10044,
                        resource = "sp2_action",
                        basicType = 1,
                        actType = 1,
                        loop = 0,
                },

                [1522] = {
                        id = 1522,
                        group = "安德烈亚_无语",
                        character = 10044,
                        resource = "sp2_talk",
                        basicType = 2,
                        actType = 1,
                        loop = 0,
                },

}
return ActionTable