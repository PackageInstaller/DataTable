---@class HomeMoveTable
---@field public id integer
---@field public way table
---@field public belongArea integer
---@field public actionGroup integer
---@field public moveMode integer
---@field public exclusive table
---@field public jobExclusive table

---@type HomeMoveTable[]
local HomeMoveTable = {
                [1001] = {
                        id = 1001,
                        way = {100001,100002,100003,100004,100005,100006,100007,100008,100009,100010,100011,100012,100013,100014,100015,100016,100017,100018,100019,100020,100021,100022,100023,100024},
                        belongArea = 1,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [1002] = {
                        id = 1002,
                        way = {100029,100030,100031,100032,100033,100034,100035,100036,100037,100038,100040,100041,100042,100043,100044,100045,100046,100047,100048},
                        belongArea = 1,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [1003] = {
                        id = 1003,
                        way = {100013,100014,100015,100016,100017,100018,100019,100020,100021,100022,100023,100024},
                        belongArea = 1,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [1004] = {
                        id = 1004,
                        way = {100027,100028,100029,100030,100031,100032,100033,100034,100035,100036,100037,100038,100040,100041,100042,100043,100044,100045,100046,100047,100048},
                        belongArea = 1,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [1005] = {
                        id = 1005,
                        way = {100006,100007,100008,100009,100010,100011,100012,100013,100014,100015,100016,100017,100018,100019,100020,100021,100022,100023,100024},
                        belongArea = 1,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [1006] = {
                        id = 1006,
                        way = {100035,100036,100037,100038,100040,100041,100042,100043,100044,100045,100046,100047,100048},
                        belongArea = 1,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [1007] = {
                        id = 1007,
                        way = {100049,100050},
                        belongArea = 1,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [1008] = {
                        id = 1008,
                        way = {100051,100052},
                        belongArea = 1,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [1009] = {
                        id = 1009,
                        way = {100026,100025,100001,100008,100009,100010,100011,100037,100034,100018,100030,100022,100027,100026},
                        belongArea = 1,
                        actionGroup = 1,
                        moveMode = 4,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2001] = {
                        id = 2001,
                        way = {200042,200043,200044,200045,200042,200043,200044,200045,200042,200043,200044,200045,200042,200043,200044,200045,200052},
                        belongArea = 2,
                        actionGroup = 1,
                        moveMode = 4,
                        exclusive = {10002},
                        jobExclusive = {},
                },

                [2002] = {
                        id = 2002,
                        way = {200046,200047,200048,200049,200046,200047,200048,200049,200046,200047,200048,200049,200046,200047,200048,200049,200053},
                        belongArea = 2,
                        actionGroup = 1,
                        moveMode = 4,
                        exclusive = {10002},
                        jobExclusive = {},
                },

                [2003] = {
                        id = 2003,
                        way = {200001,200002},
                        belongArea = 2,
                        actionGroup = 8,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2004] = {
                        id = 2004,
                        way = {200003,200004},
                        belongArea = 2,
                        actionGroup = 8,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2005] = {
                        id = 2005,
                        way = {200013,200014},
                        belongArea = 2,
                        actionGroup = 8,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2006] = {
                        id = 2006,
                        way = {200015,200016},
                        belongArea = 2,
                        actionGroup = 8,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2007] = {
                        id = 2007,
                        way = {200017,200018},
                        belongArea = 2,
                        actionGroup = 8,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2008] = {
                        id = 2008,
                        way = {200019,200020},
                        belongArea = 2,
                        actionGroup = 8,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2009] = {
                        id = 2009,
                        way = {200021,200022},
                        belongArea = 2,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2010] = {
                        id = 2010,
                        way = {200023,200024},
                        belongArea = 2,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2011] = {
                        id = 2011,
                        way = {200025,200026},
                        belongArea = 2,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2012] = {
                        id = 2012,
                        way = {200027,200028,200029,200030,200031,200032,200033,200034,200035,200036,200037},
                        belongArea = 2,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2013] = {
                        id = 2013,
                        way = {200038,200039,200040,200041},
                        belongArea = 2,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [2014] = {
                        id = 2014,
                        way = {200050,200051,200039,200038},
                        belongArea = 2,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [3001] = {
                        id = 3001,
                        way = {300001,300002},
                        belongArea = 3,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [3002] = {
                        id = 3002,
                        way = {300003,300004},
                        belongArea = 3,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [3003] = {
                        id = 3003,
                        way = {300005,300006},
                        belongArea = 3,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [3004] = {
                        id = 3004,
                        way = {300007,300008},
                        belongArea = 3,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [4001] = {
                        id = 4001,
                        way = {400001,400002,400001},
                        belongArea = 4,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [4002] = {
                        id = 4002,
                        way = {400001,400002,400003},
                        belongArea = 4,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [4003] = {
                        id = 4003,
                        way = {400003,400004},
                        belongArea = 4,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [4004] = {
                        id = 4004,
                        way = {400001,400002,400003,400004},
                        belongArea = 4,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [5001] = {
                        id = 5001,
                        way = {500001,500002},
                        belongArea = 5,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [5002] = {
                        id = 5002,
                        way = {500003,500004},
                        belongArea = 5,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [5003] = {
                        id = 5003,
                        way = {500005,500006},
                        belongArea = 5,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [5004] = {
                        id = 5004,
                        way = {500007,500008},
                        belongArea = 5,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [5005] = {
                        id = 5005,
                        way = {500009,500010},
                        belongArea = 5,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [5006] = {
                        id = 5006,
                        way = {500011,500012},
                        belongArea = 5,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [5007] = {
                        id = 5007,
                        way = {500013,500014},
                        belongArea = 5,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [5008] = {
                        id = 5008,
                        way = {500015,500016},
                        belongArea = 5,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [9001] = {
                        id = 9001,
                        way = {900001,900002},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,1},
                },

                [9002] = {
                        id = 9002,
                        way = {900003,900004},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,1},
                },

                [9003] = {
                        id = 9003,
                        way = {900009,900010},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,1},
                },

                [9004] = {
                        id = 9004,
                        way = {900019,900020},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,1},
                },

                [9005] = {
                        id = 9005,
                        way = {900005,900006},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,2},
                },

                [9006] = {
                        id = 9006,
                        way = {900011,900012},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,2},
                },

                [9007] = {
                        id = 9007,
                        way = {900017,900018},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,2},
                },

                [9008] = {
                        id = 9008,
                        way = {900027,900028},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,2},
                },

                [9009] = {
                        id = 9009,
                        way = {900007,900008},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,3},
                },

                [9010] = {
                        id = 9010,
                        way = {900013,900014},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,3},
                },

                [9011] = {
                        id = 9011,
                        way = {900021,900022},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,3},
                },

                [9012] = {
                        id = 9012,
                        way = {900025,900026},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,4},
                },

                [9013] = {
                        id = 9013,
                        way = {900015,900016},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,4},
                },

                [9014] = {
                        id = 9014,
                        way = {900023,900024},
                        belongArea = 9,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {10009,4},
                },

                [11001] = {
                        id = 11001,
                        way = {1100001,1100002},
                        belongArea = 11,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [11002] = {
                        id = 11002,
                        way = {1100003,1100004},
                        belongArea = 11,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [12001] = {
                        id = 12001,
                        way = {1200001,1200002},
                        belongArea = 12,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [12002] = {
                        id = 12002,
                        way = {1200003,1200004,1200005,1200006,1200007},
                        belongArea = 12,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [13001] = {
                        id = 13001,
                        way = {1300001,1300002},
                        belongArea = 13,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [13002] = {
                        id = 13002,
                        way = {1300003,1300004,1300005},
                        belongArea = 13,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [14001] = {
                        id = 14001,
                        way = {1400001,1400002},
                        belongArea = 14,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [14002] = {
                        id = 14002,
                        way = {1400003,1400004},
                        belongArea = 14,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [14003] = {
                        id = 14003,
                        way = {1400005,1400006},
                        belongArea = 14,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [14004] = {
                        id = 14004,
                        way = {1400007,1400008},
                        belongArea = 14,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [14005] = {
                        id = 14005,
                        way = {1400009,1400010},
                        belongArea = 14,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [14006] = {
                        id = 14006,
                        way = {1400011,1400012},
                        belongArea = 14,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [14007] = {
                        id = 14007,
                        way = {1400013,1400014},
                        belongArea = 14,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [14008] = {
                        id = 14008,
                        way = {1400015,1400016},
                        belongArea = 14,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [15001] = {
                        id = 15001,
                        way = {1500005,1500006},
                        belongArea = 15,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [15002] = {
                        id = 15002,
                        way = {1500007,1500008},
                        belongArea = 15,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [15003] = {
                        id = 15003,
                        way = {1500009,1500010},
                        belongArea = 15,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [15004] = {
                        id = 15004,
                        way = {1500011,1500012},
                        belongArea = 15,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [15005] = {
                        id = 15005,
                        way = {1500013,1500014},
                        belongArea = 15,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [15006] = {
                        id = 15006,
                        way = {1500015,1500016},
                        belongArea = 15,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [15007] = {
                        id = 15007,
                        way = {1500017,1500018},
                        belongArea = 15,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [15008] = {
                        id = 15008,
                        way = {1500019,1500020},
                        belongArea = 15,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [15009] = {
                        id = 15009,
                        way = {1500021,1500022},
                        belongArea = 15,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [15010] = {
                        id = 15010,
                        way = {1500023,1500024},
                        belongArea = 15,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [16001] = {
                        id = 16001,
                        way = {1600001,1600002},
                        belongArea = 16,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [16002] = {
                        id = 16002,
                        way = {1600003,1600004},
                        belongArea = 16,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [17001] = {
                        id = 17001,
                        way = {1700001,1700002},
                        belongArea = 17,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [17002] = {
                        id = 17002,
                        way = {1700003,1700004},
                        belongArea = 17,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [17003] = {
                        id = 17003,
                        way = {1700005,1700006},
                        belongArea = 17,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [17004] = {
                        id = 17004,
                        way = {1700007,1700008},
                        belongArea = 17,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [17005] = {
                        id = 17005,
                        way = {1700009,1700010},
                        belongArea = 17,
                        actionGroup = 1,
                        moveMode = 3,
                        exclusive = {},
                        jobExclusive = {},
                },

                [99001] = {
                        id = 99001,
                        way = {9900001,9900002,9900003,9900004},
                        belongArea = 99,
                        actionGroup = 1,
                        moveMode = 5,
                        exclusive = {},
                        jobExclusive = {10099,1},
                },

                [99002] = {
                        id = 99002,
                        way = {9900005,9900006,9900007,9900008,9900009,9900010,9900011,9900012},
                        belongArea = 99,
                        actionGroup = 1,
                        moveMode = 5,
                        exclusive = {},
                        jobExclusive = {10099,2},
                },

                [99003] = {
                        id = 99003,
                        way = {9900013,9900014,9900015,9900016,9900017,9900018,9900019,9900020,9900021,9900022,9900023},
                        belongArea = 99,
                        actionGroup = 1,
                        moveMode = 5,
                        exclusive = {},
                        jobExclusive = {10099,3},
                },

                [99004] = {
                        id = 99004,
                        way = {9900024,9900025,9900026,9900027,9900028},
                        belongArea = 99,
                        actionGroup = 1,
                        moveMode = 5,
                        exclusive = {},
                        jobExclusive = {10099,4},
                },

}
return HomeMoveTable