__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local ServerList_Test = readonly({
  [1] = {
    ServerID = 1,
    ServerName = "第一礼堂",
    ServerIP = "39.98.131.4",
    ServerPort = "14100",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [2] = {
    ServerID = 2,
    ServerName = "周版本外服",
    ServerIP = "39.98.131.4",
    ServerPort = "14110",
    ServerState = 3,
    Priority = 100,
    IsReconnect = true,
    IsShow = true
  },
  [3] = {
    ServerID = 3,
    ServerName = "策划服（按需更新）",
    ServerIP = "30.210.200.182",
    ServerPort = "43200",
    ServerState = 3,
    Priority = 98,
    IsReconnect = true,
    IsShow = true
  },
  [4] = {
    ServerID = 4,
    ServerName = "QA1服（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "43400",
    ServerState = 3,
    Priority = 96,
    IsReconnect = true,
    IsShow = true
  },
  [5] = {
    ServerID = 5,
    ServerName = "QA2服（保留）",
    ServerIP = "30.210.200.182",
    ServerPort = "43500",
    ServerState = 3,
    Priority = 95,
    IsReconnect = true,
    IsShow = true
  },
  [6] = {
    ServerID = 6,
    ServerName = "QA6服（保留）",
    ServerIP = "30.210.200.182",
    ServerPort = "43600",
    ServerState = 3,
    Priority = 93,
    IsReconnect = true,
    IsShow = true
  },
  [7] = {
    ServerID = 7,
    ServerName = "开发服（随时更新）",
    ServerIP = "30.210.200.182",
    ServerPort = "43100",
    ServerState = 3,
    Priority = 99,
    IsReconnect = true,
    IsShow = true
  },
  [8] = {
    ServerID = 8,
    ServerName = "中台测试-袁阳（不稳定）",
    ServerIP = "30.210.208.190",
    ServerPort = "9002",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [9] = {
    ServerID = 9,
    ServerName = "个人服-LHH（不稳定）",
    ServerIP = "30.210.144.80",
    ServerPort = "8052",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [10] = {
    ServerID = 10,
    ServerName = "个人服-JYB（不稳定）",
    ServerIP = "11.238.116.92",
    ServerPort = "7183",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [11] = {
    ServerID = 11,
    ServerName = "周版本服-内网",
    ServerIP = "30.210.200.182",
    ServerPort = "43300",
    ServerState = 3,
    Priority = 100,
    IsReconnect = true,
    IsShow = true
  },
  [12] = {
    ServerID = 12,
    ServerName = "个人服-Wu(不稳定)",
    ServerIP = "11.238.116.92",
    ServerPort = "7372",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [13] = {
    ServerID = 13,
    ServerName = "个人服-ZZH(不稳定)",
    ServerIP = "30.210.200.182",
    ServerPort = "40600",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [14] = {
    ServerID = 14,
    ServerName = "个人服-ZYT（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "40700",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [15] = {
    ServerID = 15,
    ServerName = "个人服-CHK（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "41500",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [17] = {
    ServerID = 17,
    ServerName = "个人服-WL（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "41300",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [18] = {
    ServerID = 18,
    ServerName = "个人服-YL（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "42100",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [19] = {
    ServerID = 19,
    ServerName = "个人服-TZX（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "42200",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [20] = {
    ServerID = 20,
    ServerName = "个人服-BEAU",
    ServerIP = "30.210.200.182",
    ServerPort = "41900",
    ServerState = 3,
    Priority = 2,
    IsReconnect = true,
    IsShow = true
  },
  [21] = {
    ServerID = 21,
    ServerName = "个人服-BJJ",
    ServerIP = "30.210.200.182",
    ServerPort = "40000",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true,
    GameList = readonly({
      "z1_game_bjjserver",
      "z1_game_bjjserver_2"
    })
  },
  [22] = {
    ServerID = 22,
    ServerName = "个人服-YCM（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "42400",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [23] = {
    ServerID = 23,
    ServerName = "个人服-TL（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "42600",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [24] = {
    ServerID = 24,
    ServerName = "个人服-LY-Local",
    ServerIP = "30.210.200.182",
    ServerPort = "42700",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [25] = {
    ServerID = 25,
    ServerName = "个人服-LY-Remote",
    ServerIP = "30.210.144.80",
    ServerPort = "12230",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [26] = {
    ServerID = 26,
    ServerName = "个人服-LZP（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "43000",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [27] = {
    ServerID = 27,
    ServerName = "个人服-CSC2",
    ServerIP = "11.238.116.92",
    ServerPort = "7382",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [28] = {
    ServerID = 28,
    ServerName = "个人服-ZD",
    ServerIP = "30.210.215.241",
    ServerPort = "7142",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [29] = {
    ServerID = 29,
    ServerName = "个人服-ZKN",
    ServerIP = "30.210.200.182",
    ServerPort = "43700",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [30] = {
    ServerID = 30,
    ServerName = "个人服-LHH1",
    ServerIP = "30.210.200.188",
    ServerPort = "9002",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [31] = {
    ServerID = 31,
    ServerName = "个人服-hf",
    ServerIP = "30.210.200.182",
    ServerPort = "43800",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [32] = {
    ServerID = 32,
    ServerName = "个人服-hyf",
    ServerIP = "30.210.200.182",
    ServerPort = "44000",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [33] = {
    ServerID = 33,
    ServerName = "个人服-liym",
    ServerIP = "30.210.200.182",
    ServerPort = "43900",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [34] = {
    ServerID = 34,
    ServerName = "个人服-lzz",
    ServerIP = "30.210.200.121",
    ServerPort = "9002",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [35] = {
    ServerID = 35,
    ServerName = "个人服-jhl",
    ServerIP = "30.210.200.182",
    ServerPort = "44500",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [36] = {
    ServerID = 36,
    ServerName = "UX专服",
    ServerIP = "30.210.200.182",
    ServerPort = "44600",
    ServerState = 3,
    Priority = 2,
    IsReconnect = true,
    IsShow = true
  },
  [37] = {
    ServerID = 37,
    ServerName = "专有服-平台测试服",
    ServerIP = "47.113.187.233",
    ServerPort = "4200",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [38] = {
    ServerID = 38,
    ServerName = "司测-内服(release)",
    ServerIP = "30.210.200.182",
    ServerPort = "44700",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [39] = {
    ServerID = 39,
    ServerName = "司测-开发服(candidate)",
    ServerIP = "30.210.200.182",
    ServerPort = "44800",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [40] = {
    ServerID = 40,
    ServerName = "个人服-yzx",
    ServerIP = "30.210.200.182",
    ServerPort = "44900",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [41] = {
    ServerID = 41,
    ServerName = "个人服-TEST",
    ServerIP = "30.210.200.182",
    ServerPort = "40100",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true,
    GameList = readonly({
      "z1_game_yyserver",
      "z1_game_yyserver_2"
    })
  }
})
return ServerList_Test
