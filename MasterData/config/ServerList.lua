local System = require("System.System")
local readonly = System.readonly
local ServerList = readonly({
  [1] = {
    ServerID = 1,
    ServerName = "ServerList_1_ServerName|第一礼堂",
    ServerIP = "39.98.131.4",
    ServerPort = "14100",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [2] = {
    ServerID = 2,
    ServerName = "ServerList_2_ServerName|周版本外服",
    ServerIP = "39.98.131.4",
    ServerPort = "14110",
    ServerState = 3,
    Priority = 100,
    IsReconnect = true,
    IsShow = true
  },
  [3] = {
    ServerID = 3,
    ServerName = "ServerList_3_ServerName|策划服（按需更新）",
    ServerIP = "30.210.200.182",
    ServerPort = "43200",
    ServerState = 3,
    Priority = 98,
    IsReconnect = true,
    IsShow = true
  },
  [4] = {
    ServerID = 4,
    ServerName = "ServerList_4_ServerName|QA1服（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "43400",
    ServerState = 3,
    Priority = 96,
    IsReconnect = true,
    IsShow = true
  },
  [5] = {
    ServerID = 5,
    ServerName = "ServerList_5_ServerName|QA2服（保留）",
    ServerIP = "30.210.200.182",
    ServerPort = "43500",
    ServerState = 3,
    Priority = 95,
    IsReconnect = true,
    IsShow = true
  },
  [6] = {
    ServerID = 6,
    ServerName = "ServerList_6_ServerName|QA6服（保留）",
    ServerIP = "30.210.200.182",
    ServerPort = "43600",
    ServerState = 3,
    Priority = 93,
    IsReconnect = true,
    IsShow = true
  },
  [7] = {
    ServerID = 7,
    ServerName = "ServerList_7_ServerName|开发服（随时更新）",
    ServerIP = "30.210.200.182",
    ServerPort = "43100",
    ServerState = 3,
    Priority = 99,
    IsReconnect = true,
    IsShow = true
  },
  [8] = {
    ServerID = 8,
    ServerName = "ServerList_8_ServerName|中台测试-袁阳（不稳定）",
    ServerIP = "30.210.208.190",
    ServerPort = "9002",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [9] = {
    ServerID = 9,
    ServerName = "ServerList_9_ServerName|个人服-LHH（不稳定）",
    ServerIP = "30.210.144.80",
    ServerPort = "8052",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [10] = {
    ServerID = 10,
    ServerName = "ServerList_10_ServerName|个人服-JYB（不稳定）",
    ServerIP = "11.238.116.92",
    ServerPort = "7183",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [11] = {
    ServerID = 11,
    ServerName = "ServerList_11_ServerName|周版本服-内网",
    ServerIP = "30.210.200.182",
    ServerPort = "43300",
    ServerState = 3,
    Priority = 100,
    IsReconnect = true,
    IsShow = true
  },
  [12] = {
    ServerID = 12,
    ServerName = "ServerList_12_ServerName|个人服-Wu(不稳定)",
    ServerIP = "11.238.116.92",
    ServerPort = "7372",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [13] = {
    ServerID = 13,
    ServerName = "ServerList_13_ServerName|个人服-ZZH(不稳定)",
    ServerIP = "30.210.200.182",
    ServerPort = "40600",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [14] = {
    ServerID = 14,
    ServerName = "ServerList_14_ServerName|个人服-ZYT（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "40700",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [15] = {
    ServerID = 15,
    ServerName = "ServerList_15_ServerName|个人服-CHK（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "41500",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [17] = {
    ServerID = 17,
    ServerName = "ServerList_17_ServerName|个人服-WL（不稳定）",
    ServerIP = "huyu-proxy13.ejoy.com",
    ServerPort = "7482",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [18] = {
    ServerID = 18,
    ServerName = "ServerList_18_ServerName|个人服-YL（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "42100",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [19] = {
    ServerID = 19,
    ServerName = "ServerList_19_ServerName|个人服-TZX（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "42200",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [20] = {
    ServerID = 20,
    ServerName = "ServerList_20_ServerName|个人服-BEAU",
    ServerIP = "30.210.200.182",
    ServerPort = "41900",
    ServerState = 3,
    Priority = 2,
    IsReconnect = true,
    IsShow = true
  },
  [21] = {
    ServerID = 21,
    ServerName = "ServerList_21_ServerName|个人服-BJJ",
    ServerIP = "30.210.200.182",
    ServerPort = "40000",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [22] = {
    ServerID = 22,
    ServerName = "ServerList_22_ServerName|个人服-YCM（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "42400",
    ServerState = 3,
    Priority = 5,
    IsReconnect = true,
    IsShow = true
  },
  [23] = {
    ServerID = 23,
    ServerName = "ServerList_23_ServerName|个人服-TL（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "42600",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [24] = {
    ServerID = 24,
    ServerName = "ServerList_24_ServerName|个人服-LY-Local",
    ServerIP = "30.210.200.182",
    ServerPort = "42700",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [25] = {
    ServerID = 25,
    ServerName = "ServerList_25_ServerName|个人服-LY-Remote",
    ServerIP = "30.210.144.80",
    ServerPort = "12230",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [26] = {
    ServerID = 26,
    ServerName = "ServerList_26_ServerName|个人服-LZP（不稳定）",
    ServerIP = "30.210.200.182",
    ServerPort = "43000",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [27] = {
    ServerID = 27,
    ServerName = "ServerList_27_ServerName|个人服-CSC2",
    ServerIP = "11.238.116.92",
    ServerPort = "7382",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [28] = {
    ServerID = 28,
    ServerName = "ServerList_28_ServerName|个人服-ZD",
    ServerIP = "30.210.215.241",
    ServerPort = "7142",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [29] = {
    ServerID = 29,
    ServerName = "ServerList_29_ServerName|个人服-ZKN",
    ServerIP = "30.210.200.182",
    ServerPort = "43700",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [30] = {
    ServerID = 30,
    ServerName = "ServerList_30_ServerName|个人服-LHH1",
    ServerIP = "30.210.200.188",
    ServerPort = "9002",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [31] = {
    ServerID = 31,
    ServerName = "ServerList_31_ServerName|个人服-hf",
    ServerIP = "30.210.200.182",
    ServerPort = "43800",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [32] = {
    ServerID = 32,
    ServerName = "ServerList_32_ServerName|个人服-hyf",
    ServerIP = "30.210.200.182",
    ServerPort = "44000",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [33] = {
    ServerID = 33,
    ServerName = "ServerList_33_ServerName|个人服-liym",
    ServerIP = "30.210.200.182",
    ServerPort = "43900",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [34] = {
    ServerID = 34,
    ServerName = "ServerList_34_ServerName|个人服-lzz",
    ServerIP = "11.164.206.24",
    ServerPort = "7102",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [35] = {
    ServerID = 35,
    ServerName = "ServerList_35_ServerName|个人服-jhl",
    ServerIP = "30.210.200.182",
    ServerPort = "44500",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [36] = {
    ServerID = 36,
    ServerName = "ServerList_36_ServerName|UX专服",
    ServerIP = "30.210.200.182",
    ServerPort = "44600",
    ServerState = 3,
    Priority = 2,
    IsReconnect = true,
    IsShow = true
  },
  [37] = {
    ServerID = 37,
    ServerName = "ServerList_37_ServerName|专有服-平台测试服",
    ServerIP = "47.113.187.233",
    ServerPort = "4200",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [38] = {
    ServerID = 38,
    ServerName = "ServerList_38_ServerName|司测-内服(release)",
    ServerIP = "30.210.200.182",
    ServerPort = "44700",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [39] = {
    ServerID = 39,
    ServerName = "ServerList_39_ServerName|司测-开发服(candidate)",
    ServerIP = "30.210.200.182",
    ServerPort = "44800",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [40] = {
    ServerID = 40,
    ServerName = "ServerList_40_ServerName|个人服-yzx",
    ServerIP = "30.210.200.182",
    ServerPort = "44900",
    ServerState = 3,
    Priority = 17,
    IsReconnect = true,
    IsShow = true
  },
  [41] = {
    ServerID = 41,
    ServerName = "ServerList_41_ServerName|个人服-TEST",
    ServerIP = "30.210.200.182",
    ServerPort = "40100",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true,
    GameList = {
      "z1_game_yyserver",
      "z1_game_yyserver_2"
    }
  },
  [42] = {
    ServerID = 42,
    ServerName = "ServerList_42_ServerName|个人服-bwg",
    ServerIP = "30.210.144.80",
    ServerPort = "9825",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [43] = {
    ServerID = 43,
    ServerName = "ServerList_43_ServerName|内网全环境QA服",
    ServerIP = "30.210.204.188",
    ServerPort = "10100",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true,
    GameList = {
      "Z1_GAME_ALLENV_QA_1",
      "Z1_GAME_ALLENV_QA_2",
      "Z1_GAME_ALLENV_QA_3"
    }
  },
  [44] = {
    ServerID = 44,
    ServerName = "ServerList_44_ServerName|个人服-思华",
    ServerIP = "30.210.204.188",
    ServerPort = "15000",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  },
  [45] = {
    ServerID = 45,
    ServerName = "ServerList_45_ServerName|专有服-双周版本外服",
    ServerIP = "47.113.187.233",
    ServerPort = "4400",
    ServerState = 3,
    Priority = 1,
    IsReconnect = true,
    IsShow = true
  }
})
return ServerList
