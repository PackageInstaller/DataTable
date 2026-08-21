---@class GuideMainTable
---@field public id integer
---@field public Group integer
---@field public Condition table
---@field public Steps table
---@field public NextGuide integer
---@field public StopStepCon integer
---@field public StopSteps table

---@type GuideMainTable[]
local GuideMainTable = {
                [1010] = {
                        id = 1010,
                        Group = 1,
                        Condition = {{1,10101}},
                        Steps = {20010,20020,20030,20040,20050,20060,20070,20080,20090,20100,20110},
                        NextGuide = 1020,
                        StopStepCon = 0,
                        StopSteps = {20010,20020,20030,20040,20050,20060,20070,20080,20090,20100,20110},
                },

                [1020] = {
                        id = 1020,
                        Group = 1,
                        Condition = {{1,10102}},
                        Steps = {20120,20130,20140},
                        NextGuide = 1025,
                        StopStepCon = 0,
                        StopSteps = {20120,20130,20140},
                },

                [1025] = {
                        id = 1025,
                        Group = 1,
                        Condition = {},
                        Steps = {10010,10011,10020,10030,10040,10050},
                        NextGuide = 1030,
                        StopStepCon = 0,
                        StopSteps = {10010,10011,10020,10030,10040,10050},
                },

                [1030] = {
                        id = 1030,
                        Group = 1,
                        Condition = {},
                        Steps = {10079,10080,10090,10091,10092,10093,10094},
                        NextGuide = 1031,
                        StopStepCon = 10102,
                        StopSteps = {10078,10079,10080,10090,10091,10092,10093,10094},
                },

                [1031] = {
                        id = 1031,
                        Group = 1,
                        Condition = {{1,10201}},
                        Steps = {10100,10110,10120,10130,10140,10150,10160,20160,20170,20180,20190,20200,20210,20215,20220},
                        NextGuide = 1040,
                        StopStepCon = 10102,
                        StopSteps = {10130,10140,10150,10160,20160,20170,20180,20190,20200,20210,20215,20220},
                },

                [1040] = {
                        id = 1040,
                        Group = 1,
                        Condition = {},
                        Steps = {10170,10180,10190,10200,10210,10220,10230,10240},
                        NextGuide = 1050,
                        StopStepCon = 10201,
                        StopSteps = {10230,10240},
                },

                [1050] = {
                        id = 1050,
                        Group = 1,
                        Condition = {},
                        Steps = {10250,10260,10270,10280,10290,10300,10310,10320,10330},
                        NextGuide = 1055,
                        StopStepCon = 10201,
                        StopSteps = {10290,10300,10310,10320,10330},
                },

                [1055] = {
                        id = 1055,
                        Group = 1,
                        Condition = {{1,10203}},
                        Steps = {10335},
                        NextGuide = 1066,
                        StopStepCon = 10201,
                        StopSteps = {10336},
                },

                [1066] = {
                        id = 1066,
                        Group = 1,
                        Condition = {{1,1020301}},
                        Steps = {10350,10351,10352},
                        NextGuide = 1067,
                        StopStepCon = 10203,
                        StopSteps = {10348,10349,10350,10351,10352},
                },

                [1067] = {
                        id = 1067,
                        Group = 1,
                        Condition = {{1,10204}},
                        Steps = {20310,20320,20330,20340,20350},
                        NextGuide = 1070,
                        StopStepCon = 0,
                        StopSteps = {20310,20320,20330,20340,20350},
                },

                [1070] = {
                        id = 1070,
                        Group = 1,
                        Condition = {},
                        Steps = {10410,10420,10430,10440,10450,10460,10470,10480,10481,10482,10483,10484},
                        NextGuide = 1071,
                        StopStepCon = 10204,
                        StopSteps = {10450,10460,10470,10480,10481,10482,10483,10484},
                },

                [1071] = {
                        id = 1071,
                        Group = 1,
                        Condition = {},
                        Steps = {10495,10496,10497,10498,10499},
                        NextGuide = 1075,
                        StopStepCon = 10204,
                        StopSteps = {10491,10492,10493,10494,10495,10496,10497,10498,10499},
                },

                [1075] = {
                        id = 1075,
                        Group = 1,
                        Condition = {{1,1020401}},
                        Steps = {20410,20420},
                        NextGuide = 1076,
                        StopStepCon = 0,
                        StopSteps = {20410,20420},
                },

                [1076] = {
                        id = 1076,
                        Group = 1,
                        Condition = {},
                        Steps = {10501,10502,10503,10504,10505,10506},
                        NextGuide = 1077,
                        StopStepCon = 10205,
                        StopSteps = {10503,10504,10505,10506},
                },

                [1077] = {
                        id = 1077,
                        Group = 1,
                        Condition = {{1,1020501}},
                        Steps = {10517,10518,10519,10520,10521,10522,10523},
                        NextGuide = 1078,
                        StopStepCon = 10205,
                        StopSteps = {10516,10517,10518,10519,10520,10521,10522,10523},
                },

                [1078] = {
                        id = 1078,
                        Group = 1,
                        Condition = {{1,1020501}},
                        Steps = {10524,10525,10526,10527,10529,10530},
                        NextGuide = 1080,
                        StopStepCon = 10205,
                        StopSteps = {10525,10526,10527,10528,10529,10530},
                },

                [1080] = {
                        id = 1080,
                        Group = 1,
                        Condition = {{1,1020601}},
                        Steps = {10531,10532,10533,10534,10535,10536,10537,10538,10539,10540,10541},
                        NextGuide = 1085,
                        StopStepCon = 10206,
                        StopSteps = {10532,10533,10534,10535,10536,10537,10538,10539,10540,10541},
                },

                [1085] = {
                        id = 1085,
                        Group = 1,
                        Condition = {{1,1020701}},
                        Steps = {10561,10562,10564,10565,10566,10567},
                        NextGuide = 1090,
                        StopStepCon = 10207,
                        StopSteps = {10563,10564,10565,10566,10567},
                },

                [1090] = {
                        id = 1090,
                        Group = 1,
                        Condition = {},
                        Steps = {10591,10592,10593,10594,10595,10596,10597,10598},
                        NextGuide = 1100,
                        StopStepCon = 10209,
                        StopSteps = {10595,10596,10597,10598},
                },

                [1100] = {
                        id = 1100,
                        Group = 1,
                        Condition = {},
                        Steps = {10611,10612,10614,10615,10616,10617,10618,10619,10620},
                        NextGuide = 1101,
                        StopStepCon = 10209,
                        StopSteps = {10610,10611,10612,10614,10615,10616,10617,10618,10619,10620},
                },

                [1101] = {
                        id = 1101,
                        Group = 1,
                        Condition = {},
                        Steps = {10621,10622,10623,10624,10625,10626,10627,10628,10629,10630,10631,10632,10633},
                        NextGuide = 1102,
                        StopStepCon = 10209,
                        StopSteps = {10622,10623,10624,10625,10626,10627,10628,10629,10630,10631,10632,10633,10635},
                },

                [1102] = {
                        id = 1102,
                        Group = 1,
                        Condition = {{1,10301}},
                        Steps = {10636,10637,10638},
                        NextGuide = 1110,
                        StopStepCon = 10209,
                        StopSteps = {10635,10636,10637,10638},
                },

                [1110] = {
                        id = 1110,
                        Group = 1,
                        Condition = {{1,1030101}},
                        Steps = {10761,10762,10763,10764,10765,10766,10767,10768},
                        NextGuide = 1120,
                        StopStepCon = 10301,
                        StopSteps = {10762,10763,10764,10765,10766,10767,10768},
                },

                [1120] = {
                        id = 1120,
                        Group = 1,
                        Condition = {{1,1030201}},
                        Steps = {10791,10792,10794,10795,10796,10797},
                        NextGuide = 1130,
                        StopStepCon = 10302,
                        StopSteps = {10793,10794,10795,10796,10797},
                },

                [1130] = {
                        id = 1130,
                        Group = 1,
                        Condition = {},
                        Steps = {10801,10802,10803,10805,10806,10807,10808,10809},
                        NextGuide = 1135,
                        StopStepCon = 10304,
                        StopSteps = {10806,10807,10808,10809},
                },

                [1135] = {
                        id = 1135,
                        Group = 1,
                        Condition = {{1,1030401}},
                        Steps = {10816,10817,10818,10819,10820},
                        NextGuide = 1140,
                        StopStepCon = 10304,
                        StopSteps = {10815,10816,10817,10818,10819,10820},
                },

                [1140] = {
                        id = 1140,
                        Group = 1,
                        Condition = {{1,1040301}},
                        Steps = {10831,10832,10834,10835,10836,10837},
                        NextGuide = 1150,
                        StopStepCon = 10403,
                        StopSteps = {10833,10834,10835,10836,10837},
                },

                [1150] = {
                        id = 1150,
                        Group = 1,
                        Condition = {{1,10501}},
                        Steps = {10861,10862,10864,10865,10866},
                        NextGuide = 1160,
                        StopStepCon = 10408,
                        StopSteps = {10863,10864,10865,10866},
                },

                [1160] = {
                        id = 1160,
                        Group = 1,
                        Condition = {},
                        Steps = {11011,11012,11013,11015,11016,11017},
                        NextGuide = 1165,
                        StopStepCon = 10502,
                        StopSteps = {11012,11013,11015,11016,11017},
                },

                [1165] = {
                        id = 1165,
                        Group = 1,
                        Condition = {{1,1050201}},
                        Steps = {11031,11032,11033,11034,11035},
                        NextGuide = 1170,
                        StopStepCon = 10502,
                        StopSteps = {11031,11032,11033,11034,11035},
                },

                [1170] = {
                        id = 1170,
                        Group = 1,
                        Condition = {{1,10601}},
                        Steps = {11111,11112,11113,11114,11115,11116,11117,11118},
                        NextGuide = 1180,
                        StopStepCon = 10507,
                        StopSteps = {11112,11113,11114,11115,11116,11117,11118},
                },

                [1180] = {
                        id = 1180,
                        Group = 1,
                        Condition = {},
                        Steps = {11151,11152,11153,11154,11155,11156,11157,11158},
                        NextGuide = 0,
                        StopStepCon = 10606,
                        StopSteps = {11152,11153,11154,11155,11156,11157,11158},
                },

                [2010] = {
                        id = 2010,
                        Group = 2,
                        Condition = {},
                        Steps = {30110,30120,30130,30140},
                        NextGuide = 0,
                        StopStepCon = 0,
                        StopSteps = {30110,30120,30130,30140},
                },

                [3010] = {
                        id = 3010,
                        Group = 3,
                        Condition = {},
                        Steps = {40011,40012,40014,40015,40016,40018,40019,40020,40021},
                        NextGuide = 0,
                        StopStepCon = 51201,
                        StopSteps = {40013,40014,40015,40016,40018,40019,40020,40021},
                },

                [3020] = {
                        id = 3020,
                        Group = 4,
                        Condition = {},
                        Steps = {40031,40032,40033,40034,40035},
                        NextGuide = 0,
                        StopStepCon = 10307,
                        StopSteps = {40031,40032,40033,40034,40035},
                },

                [1060] = {
                        id = 1060,
                        Group = 5,
                        Condition = {},
                        Steps = {20230,20240},
                        NextGuide = 1065,
                        StopStepCon = 10202,
                        StopSteps = {20230,20240},
                },

                [1065] = {
                        id = 1065,
                        Group = 5,
                        Condition = {},
                        Steps = {20250,20260,20270,20280},
                        NextGuide = 0,
                        StopStepCon = 10202,
                        StopSteps = {20230,20240,20250,20260,20270,20280},
                },

                [1068] = {
                        id = 1068,
                        Group = 6,
                        Condition = {},
                        Steps = {20300},
                        NextGuide = 1069,
                        StopStepCon = 0,
                        StopSteps = {20300},
                },

                [1069] = {
                        id = 1069,
                        Group = 6,
                        Condition = {},
                        Steps = {20500},
                        NextGuide = 0,
                        StopStepCon = 0,
                        StopSteps = {20500},
                },

}
return GuideMainTable