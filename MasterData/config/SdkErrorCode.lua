local System = require("System.System")
local readonly = System.readonly
local SdkErrorCode = readonly({
  [68170] = {
    ID = 68170,
    CnID = "Sdk错误码@1",
    BaseSortID = 1,
    Code = -1001,
    OSType = "Android",
    Content = "SdkErrorCode_68170_Content|网络繁忙，请稍后重试"
  },
  [68172] = {
    ID = 68172,
    CnID = "Sdk错误码@2",
    BaseSortID = 2
  },
  [68171] = {
    ID = 68171,
    CnID = "Sdk错误码@3",
    BaseSortID = 3
  },
  [68174] = {
    ID = 68174,
    CnID = "Sdk错误码@4",
    BaseSortID = 4,
    Code = -1002,
    OSType = "Android",
    Content = "SdkErrorCode_68174_Content|网络繁忙，请稍后重试"
  },
  [68173] = {
    ID = 68173,
    CnID = "Sdk错误码@5",
    BaseSortID = 5,
    Code = -1003,
    OSType = "Android",
    Content = "SdkErrorCode_68173_Content|网络繁忙，请稍后重试"
  },
  [68176] = {
    ID = 68176,
    CnID = "Sdk错误码@6",
    BaseSortID = 6,
    Code = -1004,
    OSType = "Android",
    Content = "SdkErrorCode_68176_Content|没有网络连接，请检查网络"
  },
  [68175] = {
    ID = 68175,
    CnID = "Sdk错误码@7",
    BaseSortID = 7,
    Code = -1005,
    OSType = "Android",
    Content = "SdkErrorCode_68175_Content|网络繁忙，请稍后重试"
  },
  [68248] = {
    ID = 68248,
    CnID = "Sdk错误码@8",
    BaseSortID = 8,
    Code = -1006,
    OSType = "Android",
    Content = "SdkErrorCode_68248_Content|网络繁忙，请稍后重试"
  },
  [68158] = {
    ID = 68158,
    CnID = "Sdk错误码@9",
    BaseSortID = 9,
    Code = -1100,
    OSType = "Android",
    Content = "SdkErrorCode_68158_Content|网络繁忙，请稍后重试"
  },
  [68240] = {
    ID = 68240,
    CnID = "Sdk错误码@10",
    BaseSortID = 10
  },
  [68239] = {
    ID = 68239,
    CnID = "Sdk错误码@11",
    BaseSortID = 11
  },
  [68242] = {
    ID = 68242,
    CnID = "Sdk错误码@12",
    BaseSortID = 12
  },
  [68241] = {
    ID = 68241,
    CnID = "Sdk错误码@13",
    BaseSortID = 13,
    Code = -999,
    OSType = "Apple",
    Content = "SdkErrorCode_68241_Content|网络不佳，请检查网络并重试"
  },
  [68244] = {
    ID = 68244,
    CnID = "Sdk错误码@14",
    BaseSortID = 14,
    Code = -1000,
    OSType = "Apple"
  },
  [68160] = {
    ID = 68160,
    CnID = "Sdk错误码@15",
    BaseSortID = 15
  },
  [68246] = {
    ID = 68246,
    CnID = "Sdk错误码@16",
    BaseSortID = 16,
    Code = -1001,
    OSType = "Apple",
    Content = "SdkErrorCode_68246_Content|网络不佳，请检查网络并重试"
  },
  [68245] = {
    ID = 68245,
    CnID = "Sdk错误码@17",
    BaseSortID = 17,
    Code = -1002,
    OSType = "Apple",
    Content = "SdkErrorCode_68245_Content|网络连接异常，请检查网络并重试"
  },
  [68236] = {
    ID = 68236,
    CnID = "Sdk错误码@18",
    BaseSortID = 18,
    Code = -1003,
    OSType = "Apple",
    Content = "SdkErrorCode_68236_Content|无网络连接，请检查网络并重试"
  },
  [68235] = {
    ID = 68235,
    CnID = "Sdk错误码@19",
    BaseSortID = 19,
    Code = -1004,
    OSType = "Apple",
    Content = "SdkErrorCode_68235_Content|网络不佳，请检查网络并重试"
  },
  [68023] = {
    ID = 68023,
    CnID = "Sdk错误码@20",
    BaseSortID = 20,
    Code = -1005,
    OSType = "Apple",
    Content = "SdkErrorCode_68023_Content|网络不佳，请检查网络并重试"
  },
  [68024] = {
    ID = 68024,
    CnID = "Sdk错误码@21",
    BaseSortID = 21,
    Code = -1006,
    OSType = "Apple",
    Content = "SdkErrorCode_68024_Content|无网络连接，请检查网络并重试"
  },
  [68025] = {
    ID = 68025,
    CnID = "Sdk错误码@22",
    BaseSortID = 22,
    Code = -1007,
    OSType = "Apple"
  },
  [68026] = {
    ID = 68026,
    CnID = "Sdk错误码@23",
    BaseSortID = 23,
    Code = -1008,
    OSType = "Apple"
  },
  [68027] = {
    ID = 68027,
    CnID = "Sdk错误码@24",
    BaseSortID = 24,
    Code = -1009,
    OSType = "Apple",
    Content = "SdkErrorCode_68027_Content|无网络连接，请检查网络并重试"
  },
  [68028] = {
    ID = 68028,
    CnID = "Sdk错误码@25",
    BaseSortID = 25,
    OSType = "Apple"
  },
  [68029] = {
    ID = 68029,
    CnID = "Sdk错误码@26",
    BaseSortID = 26,
    Code = -1010,
    OSType = "Apple"
  },
  [68030] = {
    ID = 68030,
    CnID = "Sdk错误码@27",
    BaseSortID = 27,
    Code = -1011,
    OSType = "Apple"
  },
  [68031] = {
    ID = 68031,
    CnID = "Sdk错误码@28",
    BaseSortID = 28,
    Code = -1012,
    OSType = "Apple"
  },
  [68032] = {
    ID = 68032,
    CnID = "Sdk错误码@29",
    BaseSortID = 29,
    OSType = "Apple"
  },
  [67997] = {
    ID = 67997,
    CnID = "Sdk错误码@30",
    BaseSortID = 30,
    Code = -1013,
    OSType = "Apple"
  },
  [67996] = {
    ID = 67996,
    CnID = "Sdk错误码@31",
    BaseSortID = 31,
    OSType = "Apple"
  },
  [67995] = {
    ID = 67995,
    CnID = "Sdk错误码@32",
    BaseSortID = 32,
    OSType = "Apple"
  },
  [67994] = {
    ID = 67994,
    CnID = "Sdk错误码@33",
    BaseSortID = 33,
    Code = -1,
    OSType = "Apple",
    Content = "SdkErrorCode_67994_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [67993] = {
    ID = 67993,
    CnID = "Sdk错误码@34",
    BaseSortID = 34,
    Code = -995,
    OSType = "Apple",
    Content = "SdkErrorCode_67993_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [67992] = {
    ID = 67992,
    CnID = "Sdk错误码@35",
    BaseSortID = 35,
    Code = -996,
    OSType = "Apple",
    Content = "SdkErrorCode_67992_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [67991] = {
    ID = 67991,
    CnID = "Sdk错误码@36",
    BaseSortID = 36,
    Code = -997,
    OSType = "Apple",
    Content = "SdkErrorCode_67991_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [67990] = {
    ID = 67990,
    CnID = "Sdk错误码@37",
    BaseSortID = 37,
    Code = -999,
    OSType = "Apple",
    Content = "SdkErrorCode_67990_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [67989] = {
    ID = 67989,
    CnID = "Sdk错误码@38",
    BaseSortID = 38,
    Code = -1000,
    OSType = "Apple",
    Content = "SdkErrorCode_67989_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [67988] = {
    ID = 67988,
    CnID = "Sdk错误码@39",
    BaseSortID = 39,
    Code = -1001,
    OSType = "Apple",
    Content = "SdkErrorCode_67988_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68115] = {
    ID = 68115,
    CnID = "Sdk错误码@40",
    BaseSortID = 40,
    Code = -1002,
    OSType = "Apple",
    Content = "SdkErrorCode_68115_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68116] = {
    ID = 68116,
    CnID = "Sdk错误码@41",
    BaseSortID = 41,
    Code = -1003,
    OSType = "Apple",
    Content = "SdkErrorCode_68116_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68113] = {
    ID = 68113,
    CnID = "Sdk错误码@42",
    BaseSortID = 42,
    Code = -1004,
    OSType = "Apple",
    Content = "SdkErrorCode_68113_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68114] = {
    ID = 68114,
    CnID = "Sdk错误码@43",
    BaseSortID = 43,
    Code = -1005,
    OSType = "Apple",
    Content = "SdkErrorCode_68114_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68111] = {
    ID = 68111,
    CnID = "Sdk错误码@44",
    BaseSortID = 44,
    Code = -1006,
    OSType = "Apple",
    Content = "SdkErrorCode_68111_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68112] = {
    ID = 68112,
    CnID = "Sdk错误码@45",
    BaseSortID = 45,
    Code = -1007,
    OSType = "Apple",
    Content = "SdkErrorCode_68112_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68109] = {
    ID = 68109,
    CnID = "Sdk错误码@46",
    BaseSortID = 46,
    OSType = "Apple",
    Content = "SdkErrorCode_68109_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68110] = {
    ID = 68110,
    CnID = "Sdk错误码@47",
    BaseSortID = 47,
    Code = -1008,
    OSType = "Apple",
    Content = "SdkErrorCode_68110_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68121] = {
    ID = 68121,
    CnID = "Sdk错误码@48",
    BaseSortID = 48,
    Code = -1009,
    OSType = "Apple",
    Content = "SdkErrorCode_68121_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68122] = {
    ID = 68122,
    CnID = "Sdk错误码@49",
    BaseSortID = 49
  },
  [68067] = {
    ID = 68067,
    CnID = "Sdk错误码@50",
    BaseSortID = 50,
    Code = -1010,
    OSType = "Apple",
    Content = "SdkErrorCode_68067_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68066] = {
    ID = 68066,
    CnID = "Sdk错误码@51",
    BaseSortID = 51,
    Code = -1011,
    OSType = "Apple",
    Content = "SdkErrorCode_68066_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68069] = {
    ID = 68069,
    CnID = "Sdk错误码@52",
    BaseSortID = 52,
    Code = -1012,
    OSType = "Apple",
    Content = "SdkErrorCode_68069_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68068] = {
    ID = 68068,
    CnID = "Sdk错误码@53",
    BaseSortID = 53,
    Code = -1013,
    OSType = "Apple",
    Content = "SdkErrorCode_68068_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68063] = {
    ID = 68063,
    CnID = "Sdk错误码@54",
    BaseSortID = 54,
    Code = -1014,
    OSType = "Apple",
    Content = "SdkErrorCode_68063_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68062] = {
    ID = 68062,
    CnID = "Sdk错误码@55",
    BaseSortID = 55,
    Code = -1015,
    OSType = "Apple",
    Content = "SdkErrorCode_68062_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68065] = {
    ID = 68065,
    CnID = "Sdk错误码@56",
    BaseSortID = 56,
    Code = -1016,
    OSType = "Apple",
    Content = "SdkErrorCode_68065_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68064] = {
    ID = 68064,
    CnID = "Sdk错误码@57",
    BaseSortID = 57,
    Code = -1017,
    OSType = "Apple",
    Content = "SdkErrorCode_68064_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68072] = {
    ID = 68072,
    CnID = "Sdk错误码@58",
    BaseSortID = 58,
    Code = -1018,
    OSType = "Apple",
    Content = "SdkErrorCode_68072_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68071] = {
    ID = 68071,
    CnID = "Sdk错误码@59",
    BaseSortID = 59,
    Code = -1019,
    OSType = "Apple",
    Content = "SdkErrorCode_68071_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68060] = {
    ID = 68060,
    CnID = "Sdk错误码@60",
    BaseSortID = 60,
    Code = -1020,
    OSType = "Apple",
    Content = "SdkErrorCode_68060_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68078] = {
    ID = 68078,
    CnID = "Sdk错误码@61",
    BaseSortID = 61,
    Code = -1021,
    OSType = "Apple",
    Content = "SdkErrorCode_68078_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68100] = {
    ID = 68100,
    CnID = "Sdk错误码@62",
    BaseSortID = 62,
    Code = -1022,
    OSType = "Apple",
    Content = "SdkErrorCode_68100_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68278] = {
    ID = 68278,
    CnID = "Sdk错误码@63",
    BaseSortID = 63,
    Code = -1100,
    OSType = "Apple",
    Content = "SdkErrorCode_68278_Content|文件读写异常，请尝试重启游戏或修复客户端"
  },
  [67975] = {
    ID = 67975,
    CnID = "Sdk错误码@64",
    BaseSortID = 64,
    Code = -1101,
    OSType = "Apple",
    Content = "SdkErrorCode_67975_Content|文件读写异常，请尝试重启游戏或修复客户端"
  },
  [68058] = {
    ID = 68058,
    CnID = "Sdk错误码@65",
    BaseSortID = 65,
    Code = -1102,
    OSType = "Apple",
    Content = "SdkErrorCode_68058_Content|文件读写异常，请尝试重启游戏或检查应用权限"
  },
  [68022] = {
    ID = 68022,
    CnID = "Sdk错误码@66",
    BaseSortID = 66,
    Code = -1103,
    OSType = "Apple",
    Content = "SdkErrorCode_68022_Content|文件下载异常，请检查设备剩余空间"
  },
  [68250] = {
    ID = 68250,
    CnID = "Sdk错误码@67",
    BaseSortID = 67,
    Code = -1104,
    OSType = "Apple",
    Content = "SdkErrorCode_68250_Content|文件下载异常，请检查设备剩余空间"
  },
  [68189] = {
    ID = 68189,
    CnID = "Sdk错误码@68",
    BaseSortID = 68,
    Code = -1200,
    OSType = "Apple",
    Content = "SdkErrorCode_68189_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68190] = {
    ID = 68190,
    CnID = "Sdk错误码@69",
    BaseSortID = 69,
    Code = -1201,
    OSType = "Apple",
    Content = "SdkErrorCode_68190_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68153] = {
    ID = 68153,
    CnID = "Sdk错误码@70",
    BaseSortID = 70,
    Code = -1202,
    OSType = "Apple",
    Content = "SdkErrorCode_68153_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68061] = {
    ID = 68061,
    CnID = "Sdk错误码@71",
    BaseSortID = 71,
    Code = -1203,
    OSType = "Apple",
    Content = "SdkErrorCode_68061_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68118] = {
    ID = 68118,
    CnID = "Sdk错误码@72",
    BaseSortID = 72,
    Code = -1204,
    OSType = "Apple",
    Content = "SdkErrorCode_68118_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68020] = {
    ID = 68020,
    CnID = "Sdk错误码@73",
    BaseSortID = 73,
    Code = -1205,
    OSType = "Apple",
    Content = "SdkErrorCode_68020_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68082] = {
    ID = 68082,
    CnID = "Sdk错误码@74",
    BaseSortID = 74,
    Code = -1206,
    OSType = "Apple",
    Content = "SdkErrorCode_68082_Content|网络连接异常，请尝试重启游戏或检查网络"
  },
  [68077] = {
    ID = 68077,
    CnID = "Sdk错误码@75",
    BaseSortID = 75,
    Code = -2000,
    OSType = "Apple",
    Content = "SdkErrorCode_68077_Content|缓存读取异常，请尝试重启游戏"
  },
  [68159] = {
    ID = 68159,
    CnID = "Sdk错误码@76",
    BaseSortID = 76,
    Code = -3000,
    OSType = "Apple",
    Content = "SdkErrorCode_68159_Content|文件下载异常，请检查设备剩余空间"
  },
  [68252] = {
    ID = 68252,
    CnID = "Sdk错误码@77",
    BaseSortID = 77,
    Code = -3001,
    OSType = "Apple",
    Content = "SdkErrorCode_68252_Content|文件下载异常，请重启游戏或修复客户端"
  },
  [68035] = {
    ID = 68035,
    CnID = "Sdk错误码@78",
    BaseSortID = 78,
    Code = -3002,
    OSType = "Apple",
    Content = "SdkErrorCode_68035_Content|文件读写异常，请尝试重启游戏"
  },
  [68033] = {
    ID = 68033,
    CnID = "Sdk错误码@79",
    BaseSortID = 79,
    Code = -3003,
    OSType = "Apple",
    Content = "SdkErrorCode_68033_Content|文件读写异常，请尝试重启游戏"
  },
  [68120] = {
    ID = 68120,
    CnID = "Sdk错误码@80",
    BaseSortID = 80,
    Code = -3004,
    OSType = "Apple",
    Content = "SdkErrorCode_68120_Content|文件读写异常，请尝试重启游戏"
  },
  [68073] = {
    ID = 68073,
    CnID = "Sdk错误码@81",
    BaseSortID = 81,
    Code = -3005,
    OSType = "Apple",
    Content = "SdkErrorCode_68073_Content|文件读写异常，请尝试重启游戏"
  },
  [68119] = {
    ID = 68119,
    CnID = "Sdk错误码@82",
    BaseSortID = 82,
    Code = -3006,
    OSType = "Apple",
    Content = "SdkErrorCode_68119_Content|文件读写异常，请尝试重启游戏"
  },
  [68261] = {
    ID = 68261,
    CnID = "Sdk错误码@83",
    BaseSortID = 83,
    Code = -3007,
    OSType = "Apple",
    Content = "SdkErrorCode_68261_Content|文件读写异常，请尝试重启游戏"
  },
  [68046] = {
    ID = 68046,
    CnID = "Sdk错误码@84",
    BaseSortID = 84
  },
  [68203] = {
    ID = 68203,
    CnID = "Sdk错误码@85",
    BaseSortID = 85
  },
  [68097] = {
    ID = 68097,
    CnID = "Sdk错误码@86",
    BaseSortID = 86
  },
  [68133] = {
    ID = 68133,
    CnID = "Sdk错误码@87",
    BaseSortID = 87,
    Code = 6,
    OSType = "PC",
    Content = "SdkErrorCode_68133_Content|网络不佳，请检查网络或重启游戏后尝试"
  },
  [68268] = {
    ID = 68268,
    CnID = "Sdk错误码@88",
    BaseSortID = 88,
    Code = 7,
    OSType = "PC",
    Content = "SdkErrorCode_68268_Content|网络不佳，请检查网络或重启游戏后尝试"
  },
  [68269] = {
    ID = 68269,
    CnID = "Sdk错误码@89",
    BaseSortID = 89,
    Code = 28,
    OSType = "PC",
    Content = "SdkErrorCode_68269_Content|网络不佳，请检查网络或重启游戏后尝试"
  },
  [68201] = {
    ID = 68201,
    CnID = "Sdk错误码@90",
    BaseSortID = 90,
    Code = 22,
    OSType = "PC",
    Content = "SdkErrorCode_68201_Content|网络中断，请检查网络"
  },
  [68199] = {
    ID = 68199,
    CnID = "Sdk错误码@91",
    BaseSortID = 91,
    Code = 23,
    OSType = "PC",
    Content = "SdkErrorCode_68199_Content|网络中断，请检查网络"
  },
  [68205] = {
    ID = 68205,
    CnID = "Sdk错误码@92",
    BaseSortID = 92,
    Code = 26,
    OSType = "PC",
    Content = "SdkErrorCode_68205_Content|网络中断，请检查网络"
  },
  [68202] = {
    ID = 68202,
    CnID = "Sdk错误码@93",
    BaseSortID = 93,
    Code = 56,
    OSType = "PC",
    Content = "SdkErrorCode_68202_Content|网络异常，请检查网络"
  },
  [68210] = {
    ID = 68210,
    CnID = "Sdk错误码@94",
    BaseSortID = 94,
    Code = 61,
    OSType = "PC",
    Content = "SdkErrorCode_68210_Content|网络异常，请检查网络"
  },
  [68207] = {
    ID = 68207,
    CnID = "Sdk错误码@95",
    BaseSortID = 95,
    Code = 35,
    OSType = "PC",
    Content = "SdkErrorCode_68207_Content|网络连接中断，请检查网络"
  },
  [68220] = {
    ID = 68220,
    CnID = "Sdk错误码@96",
    BaseSortID = 96
  },
  [68216] = {
    ID = 68216,
    CnID = "Sdk错误码@97",
    BaseSortID = 97
  },
  [68232] = {
    ID = 68232,
    CnID = "Sdk错误码@98",
    BaseSortID = 98,
    Code = 7000001
  },
  [68231] = {
    ID = 68231,
    CnID = "Sdk错误码@99",
    BaseSortID = 99,
    Code = 7000002
  },
  [68103] = {
    ID = 68103,
    CnID = "Sdk错误码@100",
    BaseSortID = 100,
    Code = 7000003
  },
  [68104] = {
    ID = 68104,
    CnID = "Sdk错误码@101",
    BaseSortID = 101,
    Code = 7000004
  },
  [68101] = {
    ID = 68101,
    CnID = "Sdk错误码@102",
    BaseSortID = 102,
    Code = 7000005
  },
  [68102] = {
    ID = 68102,
    CnID = "Sdk错误码@103",
    BaseSortID = 103,
    Code = 7000006
  },
  [68107] = {
    ID = 68107,
    CnID = "Sdk错误码@104",
    BaseSortID = 104,
    Code = 7000007
  },
  [68108] = {
    ID = 68108,
    CnID = "Sdk错误码@105",
    BaseSortID = 105,
    Code = 7000008
  },
  [68105] = {
    ID = 68105,
    CnID = "Sdk错误码@106",
    BaseSortID = 106,
    Code = 7000009
  },
  [68106] = {
    ID = 68106,
    CnID = "Sdk错误码@107",
    BaseSortID = 107,
    Code = 7000010
  },
  [68098] = {
    ID = 68098,
    CnID = "Sdk错误码@108",
    BaseSortID = 108,
    Code = 7000011
  },
  [68099] = {
    ID = 68099,
    CnID = "Sdk错误码@109",
    BaseSortID = 109,
    Code = 7000012
  },
  [68151] = {
    ID = 68151,
    CnID = "Sdk错误码@110",
    BaseSortID = 110,
    Code = 7000013
  },
  [68057] = {
    ID = 68057,
    CnID = "Sdk错误码@111",
    BaseSortID = 111,
    Code = 7000014
  },
  [68179] = {
    ID = 68179,
    CnID = "Sdk错误码@112",
    BaseSortID = 112,
    Code = 7000015
  },
  [68152] = {
    ID = 68152,
    CnID = "Sdk错误码@113",
    BaseSortID = 113,
    Code = 7000016
  },
  [68155] = {
    ID = 68155,
    CnID = "Sdk错误码@114",
    BaseSortID = 114,
    Code = 7000017
  },
  [68070] = {
    ID = 68070,
    CnID = "Sdk错误码@115",
    BaseSortID = 115,
    Code = 7000018
  },
  [68157] = {
    ID = 68157,
    CnID = "Sdk错误码@116",
    BaseSortID = 116,
    Code = 7000019
  },
  [68156] = {
    ID = 68156,
    CnID = "Sdk错误码@117",
    BaseSortID = 117,
    Code = 7000020
  },
  [68147] = {
    ID = 68147,
    CnID = "Sdk错误码@118",
    BaseSortID = 118,
    Code = 7000021
  },
  [68146] = {
    ID = 68146,
    CnID = "Sdk错误码@119",
    BaseSortID = 119,
    Code = 7000022
  },
  [68195] = {
    ID = 68195,
    CnID = "Sdk错误码@120",
    BaseSortID = 120,
    Code = 7000023
  },
  [68001] = {
    ID = 68001,
    CnID = "Sdk错误码@121",
    BaseSortID = 121,
    Code = 7028000
  },
  [68197] = {
    ID = 68197,
    CnID = "Sdk错误码@122",
    BaseSortID = 122,
    Code = 7028001
  },
  [68005] = {
    ID = 68005,
    CnID = "Sdk错误码@123",
    BaseSortID = 123,
    Code = 7000024
  },
  [68191] = {
    ID = 68191,
    CnID = "Sdk错误码@124",
    BaseSortID = 124,
    Code = 7000025
  },
  [68192] = {
    ID = 68192,
    CnID = "Sdk错误码@125",
    BaseSortID = 125,
    Code = 7000026
  },
  [68193] = {
    ID = 68193,
    CnID = "Sdk错误码@126",
    BaseSortID = 126,
    Code = 7000027
  },
  [68194] = {
    ID = 68194,
    CnID = "Sdk错误码@127",
    BaseSortID = 127,
    Code = 7000028
  },
  [68279] = {
    ID = 68279,
    CnID = "Sdk错误码@128",
    BaseSortID = 128,
    Code = 7000029
  },
  [68280] = {
    ID = 68280,
    CnID = "Sdk错误码@129",
    BaseSortID = 129,
    Code = 7000030
  },
  [68226] = {
    ID = 68226,
    CnID = "Sdk错误码@130",
    BaseSortID = 130,
    Code = 7000031
  },
  [68225] = {
    ID = 68225,
    CnID = "Sdk错误码@131",
    BaseSortID = 131,
    Code = 7000032
  },
  [68224] = {
    ID = 68224,
    CnID = "Sdk错误码@132",
    BaseSortID = 132,
    Code = 7000033
  },
  [68223] = {
    ID = 68223,
    CnID = "Sdk错误码@133",
    BaseSortID = 133
  },
  [68230] = {
    ID = 68230,
    CnID = "Sdk错误码@134",
    BaseSortID = 134,
    Code = 7000034
  },
  [68229] = {
    ID = 68229,
    CnID = "Sdk错误码@135",
    BaseSortID = 135,
    Code = 7001001
  },
  [68228] = {
    ID = 68228,
    CnID = "Sdk错误码@136",
    BaseSortID = 136,
    Code = 7001002
  },
  [68227] = {
    ID = 68227,
    CnID = "Sdk错误码@137",
    BaseSortID = 137,
    Code = 7001003
  },
  [68234] = {
    ID = 68234,
    CnID = "Sdk错误码@138",
    BaseSortID = 138,
    Code = 7001004
  },
  [68233] = {
    ID = 68233,
    CnID = "Sdk错误码@139",
    BaseSortID = 139,
    Code = 7001005
  },
  [68266] = {
    ID = 68266,
    CnID = "Sdk错误码@140",
    BaseSortID = 140,
    Code = 7001006
  },
  [68267] = {
    ID = 68267,
    CnID = "Sdk错误码@141",
    BaseSortID = 141,
    Code = 7001007
  },
  [68264] = {
    ID = 68264,
    CnID = "Sdk错误码@142",
    BaseSortID = 142,
    Code = 7002001
  },
  [68265] = {
    ID = 68265,
    CnID = "Sdk错误码@143",
    BaseSortID = 143,
    Code = 7002002
  },
  [68262] = {
    ID = 68262,
    CnID = "Sdk错误码@144",
    BaseSortID = 144,
    Code = 7002003
  },
  [68263] = {
    ID = 68263,
    CnID = "Sdk错误码@145",
    BaseSortID = 145,
    Code = 7002004
  },
  [68260] = {
    ID = 68260,
    CnID = "Sdk错误码@146",
    BaseSortID = 146,
    Code = 7002005
  },
  [68276] = {
    ID = 68276,
    CnID = "Sdk错误码@147",
    BaseSortID = 147,
    Code = 7002006
  },
  [68270] = {
    ID = 68270,
    CnID = "Sdk错误码@148",
    BaseSortID = 148,
    Code = 7002007
  },
  [68271] = {
    ID = 68271,
    CnID = "Sdk错误码@149",
    BaseSortID = 149,
    Code = 7002008
  },
  [67979] = {
    ID = 67979,
    CnID = "Sdk错误码@150",
    BaseSortID = 150,
    Code = 7002009
  },
  [67978] = {
    ID = 67978,
    CnID = "Sdk错误码@151",
    BaseSortID = 151,
    Code = 7002010
  },
  [67981] = {
    ID = 67981,
    CnID = "Sdk错误码@152",
    BaseSortID = 152,
    Code = 7002011
  },
  [67980] = {
    ID = 67980,
    CnID = "Sdk错误码@153",
    BaseSortID = 153,
    Code = 7003001
  },
  [68209] = {
    ID = 68209,
    CnID = "Sdk错误码@154",
    BaseSortID = 154,
    Code = 7003002
  },
  [67974] = {
    ID = 67974,
    CnID = "Sdk错误码@155",
    BaseSortID = 155,
    Code = 7003003
  },
  [67977] = {
    ID = 67977,
    CnID = "Sdk错误码@156",
    BaseSortID = 156,
    Code = 7003004
  },
  [67976] = {
    ID = 67976,
    CnID = "Sdk错误码@157",
    BaseSortID = 157,
    Code = 7003005
  },
  [67984] = {
    ID = 67984,
    CnID = "Sdk错误码@158",
    BaseSortID = 158,
    Code = 7003006
  },
  [67983] = {
    ID = 67983,
    CnID = "Sdk错误码@159",
    BaseSortID = 159,
    Code = 7003007
  },
  [68012] = {
    ID = 68012,
    CnID = "Sdk错误码@160",
    BaseSortID = 160,
    Code = 7003008
  },
  [68013] = {
    ID = 68013,
    CnID = "Sdk错误码@161",
    BaseSortID = 161,
    Code = 7003101
  },
  [68014] = {
    ID = 68014,
    CnID = "Sdk错误码@162",
    BaseSortID = 162,
    Code = 7003102
  },
  [68015] = {
    ID = 68015,
    CnID = "Sdk错误码@163",
    BaseSortID = 163,
    Code = 7003103
  },
  [68016] = {
    ID = 68016,
    CnID = "Sdk错误码@164",
    BaseSortID = 164,
    Code = 7004000
  },
  [68017] = {
    ID = 68017,
    CnID = "Sdk错误码@165",
    BaseSortID = 165,
    Code = 7004001
  },
  [68018] = {
    ID = 68018,
    CnID = "Sdk错误码@166",
    BaseSortID = 166,
    Code = 7004002
  },
  [68019] = {
    ID = 68019,
    CnID = "Sdk错误码@167",
    BaseSortID = 167,
    Code = 7004003
  },
  [68010] = {
    ID = 68010,
    CnID = "Sdk错误码@168",
    BaseSortID = 168,
    Code = 7004004
  },
  [68011] = {
    ID = 68011,
    CnID = "Sdk错误码@169",
    BaseSortID = 169,
    Code = 7004005
  },
  [68056] = {
    ID = 68056,
    CnID = "Sdk错误码@170",
    BaseSortID = 170,
    Code = 7004006
  },
  [68055] = {
    ID = 68055,
    CnID = "Sdk错误码@171",
    BaseSortID = 171,
    Code = 7004007
  },
  [68054] = {
    ID = 68054,
    CnID = "Sdk错误码@172",
    BaseSortID = 172,
    Code = 7004008
  },
  [68053] = {
    ID = 68053,
    CnID = "Sdk错误码@173",
    BaseSortID = 173,
    Code = 7004009
  },
  [68052] = {
    ID = 68052,
    CnID = "Sdk错误码@174",
    BaseSortID = 174,
    Code = 7004010
  },
  [68051] = {
    ID = 68051,
    CnID = "Sdk错误码@175",
    BaseSortID = 175,
    Code = 7004011
  },
  [68050] = {
    ID = 68050,
    CnID = "Sdk错误码@176",
    BaseSortID = 176,
    Code = 7004012
  },
  [68049] = {
    ID = 68049,
    CnID = "Sdk错误码@177",
    BaseSortID = 177,
    Code = 7004014
  },
  [68048] = {
    ID = 68048,
    CnID = "Sdk错误码@178",
    BaseSortID = 178,
    Code = 7004015
  },
  [68047] = {
    ID = 68047,
    CnID = "Sdk错误码@179",
    BaseSortID = 179
  },
  [68089] = {
    ID = 68089,
    CnID = "Sdk错误码@180",
    BaseSortID = 180,
    Code = 421
  },
  [68090] = {
    ID = 68090,
    CnID = "Sdk错误码@181",
    BaseSortID = 181,
    Code = 0
  },
  [68087] = {
    ID = 68087,
    CnID = "Sdk错误码@182",
    BaseSortID = 182
  },
  [68088] = {
    ID = 68088,
    CnID = "Sdk错误码@183",
    BaseSortID = 183
  },
  [68093] = {
    ID = 68093,
    CnID = "Sdk错误码@184",
    BaseSortID = 184,
    Code = 10416,
    OSType = "PC"
  },
  [68094] = {
    ID = 68094,
    CnID = "Sdk错误码@185",
    BaseSortID = 185,
    Code = 10417,
    OSType = "PC"
  },
  [68091] = {
    ID = 68091,
    CnID = "Sdk错误码@186",
    BaseSortID = 186,
    Code = 10418,
    OSType = "PC"
  },
  [68092] = {
    ID = 68092,
    CnID = "Sdk错误码@187",
    BaseSortID = 187,
    Code = 10419,
    OSType = "PC"
  },
  [68095] = {
    ID = 68095,
    CnID = "Sdk错误码@188",
    BaseSortID = 188,
    Code = 10420,
    OSType = "PC"
  },
  [68096] = {
    ID = 68096,
    CnID = "Sdk错误码@189",
    BaseSortID = 189,
    Code = 10000,
    OSType = "PC"
  },
  [67966] = {
    ID = 67966,
    CnID = "Sdk错误码@190",
    BaseSortID = 190,
    Code = -994,
    OSType = "PC"
  },
  [67965] = {
    ID = 67965,
    CnID = "Sdk错误码@191",
    BaseSortID = 191,
    Code = -995,
    OSType = "PC"
  },
  [68163] = {
    ID = 68163,
    CnID = "Sdk错误码@192",
    BaseSortID = 192,
    Code = -999,
    OSType = "PC"
  },
  [68275] = {
    ID = 68275,
    CnID = "Sdk错误码@193",
    BaseSortID = 193,
    Code = -2000,
    OSType = "PC"
  },
  [68139] = {
    ID = 68139,
    CnID = "Sdk错误码@194",
    BaseSortID = 194,
    Code = -2001,
    OSType = "PC"
  },
  [67982] = {
    ID = 67982,
    CnID = "Sdk错误码@195",
    BaseSortID = 195,
    Code = -2002,
    OSType = "PC"
  },
  [68117] = {
    ID = 68117,
    CnID = "Sdk错误码@196",
    BaseSortID = 196,
    Code = -2005,
    OSType = "PC"
  },
  [68140] = {
    ID = 68140,
    CnID = "Sdk错误码@197",
    BaseSortID = 197,
    Code = -2006,
    OSType = "PC"
  },
  [68143] = {
    ID = 68143,
    CnID = "Sdk错误码@198",
    BaseSortID = 198,
    Code = -2007,
    OSType = "PC"
  },
  [68142] = {
    ID = 68142,
    CnID = "Sdk错误码@199",
    BaseSortID = 199,
    Code = -1,
    OSType = "PC"
  },
  [68178] = {
    ID = 68178,
    CnID = "Sdk错误码@200",
    BaseSortID = 200,
    Code = 410012,
    OSType = "PC"
  },
  [68177] = {
    ID = 68177,
    CnID = "Sdk错误码@201",
    BaseSortID = 201,
    Code = 410013,
    OSType = "PC"
  },
  [68180] = {
    ID = 68180,
    CnID = "Sdk错误码@202",
    BaseSortID = 202,
    Code = 410014,
    OSType = "PC"
  },
  [68243] = {
    ID = 68243,
    CnID = "Sdk错误码@203",
    BaseSortID = 203,
    Code = 410015,
    OSType = "PC"
  },
  [68182] = {
    ID = 68182,
    CnID = "Sdk错误码@204",
    BaseSortID = 204,
    Code = 410006,
    OSType = "PC"
  },
  [68181] = {
    ID = 68181,
    CnID = "Sdk错误码@205",
    BaseSortID = 205,
    Code = 510005,
    OSType = "PC"
  },
  [68184] = {
    ID = 68184,
    CnID = "Sdk错误码@206",
    BaseSortID = 206,
    Code = 50006,
    OSType = "PC"
  },
  [68183] = {
    ID = 68183,
    CnID = "Sdk错误码@207",
    BaseSortID = 207
  },
  [68186] = {
    ID = 68186,
    CnID = "Sdk错误码@208",
    BaseSortID = 208
  },
  [68185] = {
    ID = 68185,
    CnID = "Sdk错误码@209",
    BaseSortID = 209,
    Code = 7008001
  },
  [68136] = {
    ID = 68136,
    CnID = "Sdk错误码@210",
    BaseSortID = 210,
    Code = 7008002
  },
  [68137] = {
    ID = 68137,
    CnID = "Sdk错误码@211",
    BaseSortID = 211,
    Code = 7008003
  },
  [68134] = {
    ID = 68134,
    CnID = "Sdk错误码@212",
    BaseSortID = 212,
    Code = 7008004
  },
  [68135] = {
    ID = 68135,
    CnID = "Sdk错误码@213",
    BaseSortID = 213,
    Code = 7008005
  },
  [67987] = {
    ID = 67987,
    CnID = "Sdk错误码@214",
    BaseSortID = 214,
    Code = 7008006
  },
  [68141] = {
    ID = 68141,
    CnID = "Sdk错误码@215",
    BaseSortID = 215,
    Code = 7008007
  },
  [68138] = {
    ID = 68138,
    CnID = "Sdk错误码@216",
    BaseSortID = 216,
    Code = 7008008
  },
  [67985] = {
    ID = 67985,
    CnID = "Sdk错误码@217",
    BaseSortID = 217,
    Code = 7008009
  },
  [68144] = {
    ID = 68144,
    CnID = "Sdk错误码@218",
    BaseSortID = 218,
    Code = 7008010
  },
  [68145] = {
    ID = 68145,
    CnID = "Sdk错误码@219",
    BaseSortID = 219,
    Code = 7008011
  },
  [68200] = {
    ID = 68200,
    CnID = "Sdk错误码@220",
    BaseSortID = 220,
    Code = 7008012
  },
  [68004] = {
    ID = 68004,
    CnID = "Sdk错误码@221",
    BaseSortID = 221,
    Code = 7008013
  },
  [68003] = {
    ID = 68003,
    CnID = "Sdk错误码@222",
    BaseSortID = 222,
    Code = 7008014
  },
  [68002] = {
    ID = 68002,
    CnID = "Sdk错误码@223",
    BaseSortID = 223,
    Code = 7008015
  },
  [68009] = {
    ID = 68009,
    CnID = "Sdk错误码@224",
    BaseSortID = 224,
    Code = 7008016
  },
  [68008] = {
    ID = 68008,
    CnID = "Sdk错误码@225",
    BaseSortID = 225,
    Code = 7008017
  },
  [68007] = {
    ID = 68007,
    CnID = "Sdk错误码@226",
    BaseSortID = 226,
    Code = 7008018
  },
  [68006] = {
    ID = 68006,
    CnID = "Sdk错误码@227",
    BaseSortID = 227,
    Code = 7008019
  },
  [67999] = {
    ID = 67999,
    CnID = "Sdk错误码@228",
    BaseSortID = 228,
    Code = 7008020
  },
  [67998] = {
    ID = 67998,
    CnID = "Sdk错误码@229",
    BaseSortID = 229,
    Code = 7008021
  },
  [68215] = {
    ID = 68215,
    CnID = "Sdk错误码@230",
    BaseSortID = 230,
    Code = 7008022
  },
  [68273] = {
    ID = 68273,
    CnID = "Sdk错误码@231",
    BaseSortID = 231,
    Code = 7008023
  },
  [68217] = {
    ID = 68217,
    CnID = "Sdk错误码@232",
    BaseSortID = 232,
    Code = 7008024
  },
  [68218] = {
    ID = 68218,
    CnID = "Sdk错误码@233",
    BaseSortID = 233
  },
  [68211] = {
    ID = 68211,
    CnID = "Sdk错误码@234",
    BaseSortID = 234,
    Code = 7011001
  },
  [68212] = {
    ID = 68212,
    CnID = "Sdk错误码@235",
    BaseSortID = 235,
    Code = 7011002
  },
  [68213] = {
    ID = 68213,
    CnID = "Sdk错误码@236",
    BaseSortID = 236,
    Code = 7011003
  },
  [68214] = {
    ID = 68214,
    CnID = "Sdk错误码@237",
    BaseSortID = 237,
    Code = 7011004
  },
  [68221] = {
    ID = 68221,
    CnID = "Sdk错误码@238",
    BaseSortID = 238,
    Code = 7011005
  },
  [68222] = {
    ID = 68222,
    CnID = "Sdk错误码@239",
    BaseSortID = 239,
    Code = 7011006
  },
  [68084] = {
    ID = 68084,
    CnID = "Sdk错误码@240",
    BaseSortID = 240,
    Code = 7011007
  },
  [68083] = {
    ID = 68083,
    CnID = "Sdk错误码@241",
    BaseSortID = 241,
    Code = 7011008
  },
  [68086] = {
    ID = 68086,
    CnID = "Sdk错误码@242",
    BaseSortID = 242,
    Code = 7011009
  },
  [68085] = {
    ID = 68085,
    CnID = "Sdk错误码@243",
    BaseSortID = 243,
    Code = 7011010
  },
  [68080] = {
    ID = 68080,
    CnID = "Sdk错误码@244",
    BaseSortID = 244,
    Code = 7011011
  },
  [68079] = {
    ID = 68079,
    CnID = "Sdk错误码@245",
    BaseSortID = 245,
    Code = 7011012
  },
  [68277] = {
    ID = 68277,
    CnID = "Sdk错误码@246",
    BaseSortID = 246,
    Code = 7011013
  },
  [68081] = {
    ID = 68081,
    CnID = "Sdk错误码@247",
    BaseSortID = 247,
    Code = 7011014
  },
  [68204] = {
    ID = 68204,
    CnID = "Sdk错误码@248",
    BaseSortID = 248,
    Code = 7011015
  },
  [68076] = {
    ID = 68076,
    CnID = "Sdk错误码@249",
    BaseSortID = 249,
    Code = 7011016
  },
  [68044] = {
    ID = 68044,
    CnID = "Sdk错误码@250",
    BaseSortID = 250,
    Code = 7011017
  },
  [68045] = {
    ID = 68045,
    CnID = "Sdk错误码@251",
    BaseSortID = 251,
    Code = 7009001
  },
  [68042] = {
    ID = 68042,
    CnID = "Sdk错误码@252",
    BaseSortID = 252,
    Code = 7009002
  },
  [68043] = {
    ID = 68043,
    CnID = "Sdk错误码@253",
    BaseSortID = 253,
    Code = 7009003
  },
  [68040] = {
    ID = 68040,
    CnID = "Sdk错误码@254",
    BaseSortID = 254,
    Code = 7009004
  },
  [68041] = {
    ID = 68041,
    CnID = "Sdk错误码@255",
    BaseSortID = 255,
    Code = 7009005
  },
  [68038] = {
    ID = 68038,
    CnID = "Sdk错误码@256",
    BaseSortID = 256,
    Code = 7009006
  },
  [68039] = {
    ID = 68039,
    CnID = "Sdk错误码@257",
    BaseSortID = 257
  },
  [68036] = {
    ID = 68036,
    CnID = "Sdk错误码@258",
    BaseSortID = 258,
    Code = 400
  },
  [68037] = {
    ID = 68037,
    CnID = "Sdk错误码@259",
    BaseSortID = 259,
    Code = 401,
    Content = "SdkErrorCode_68037_Content|游戏短时间内调用多次acquire接口，一定概率可能拿到其中一个失效的ejoy_token（16个token会互相覆盖），用来登录游戏服就会报401"
  },
  [68169] = {
    ID = 68169,
    CnID = "Sdk错误码@260",
    BaseSortID = 260
  },
  [68168] = {
    ID = 68168,
    CnID = "Sdk错误码@261",
    BaseSortID = 261,
    Code = 402
  },
  [68167] = {
    ID = 68167,
    CnID = "Sdk错误码@262",
    BaseSortID = 262,
    Code = 403
  },
  [68166] = {
    ID = 68166,
    CnID = "Sdk错误码@263",
    BaseSortID = 263,
    Code = 404
  },
  [68165] = {
    ID = 68165,
    CnID = "Sdk错误码@264",
    BaseSortID = 264,
    Code = 405
  },
  [68164] = {
    ID = 68164,
    CnID = "Sdk错误码@265",
    BaseSortID = 265,
    Code = 406
  },
  [68161] = {
    ID = 68161,
    CnID = "Sdk错误码@266",
    BaseSortID = 266,
    Code = 408
  },
  [68162] = {
    ID = 68162,
    CnID = "Sdk错误码@267",
    BaseSortID = 267,
    Code = 409
  },
  [68208] = {
    ID = 68208,
    CnID = "Sdk错误码@268",
    BaseSortID = 268,
    Code = 410
  },
  [68206] = {
    ID = 68206,
    CnID = "Sdk错误码@269",
    BaseSortID = 269,
    Code = 411
  },
  [68123] = {
    ID = 68123,
    CnID = "Sdk错误码@270",
    BaseSortID = 270,
    Code = 412
  },
  [68124] = {
    ID = 68124,
    CnID = "Sdk错误码@271",
    BaseSortID = 271,
    Code = 413
  },
  [68125] = {
    ID = 68125,
    CnID = "Sdk错误码@272",
    BaseSortID = 272,
    Code = 414
  },
  [68126] = {
    ID = 68126,
    CnID = "Sdk错误码@273",
    BaseSortID = 273,
    Code = 415
  },
  [68127] = {
    ID = 68127,
    CnID = "Sdk错误码@274",
    BaseSortID = 274,
    Code = 416
  },
  [68128] = {
    ID = 68128,
    CnID = "Sdk错误码@275",
    BaseSortID = 275,
    Code = 417
  },
  [68129] = {
    ID = 68129,
    CnID = "Sdk错误码@276",
    BaseSortID = 276,
    Code = 418
  },
  [68130] = {
    ID = 68130,
    CnID = "Sdk错误码@277",
    BaseSortID = 277,
    Code = 419
  },
  [68131] = {
    ID = 68131,
    CnID = "Sdk错误码@278",
    BaseSortID = 278,
    Code = 420
  },
  [68132] = {
    ID = 68132,
    CnID = "Sdk错误码@279",
    BaseSortID = 279,
    Code = 421
  },
  [68034] = {
    ID = 68034,
    CnID = "Sdk错误码@280",
    BaseSortID = 280,
    Code = 422
  },
  [68247] = {
    ID = 68247,
    CnID = "Sdk错误码@281",
    BaseSortID = 281,
    Code = 423
  },
  [67986] = {
    ID = 67986,
    CnID = "Sdk错误码@282",
    BaseSortID = 282,
    Code = 424
  },
  [68274] = {
    ID = 68274,
    CnID = "Sdk错误码@283",
    BaseSortID = 283,
    Code = 425
  },
  [68196] = {
    ID = 68196,
    CnID = "Sdk错误码@284",
    BaseSortID = 284,
    Code = 426
  },
  [68251] = {
    ID = 68251,
    CnID = "Sdk错误码@285",
    BaseSortID = 285,
    Code = 427
  },
  [68198] = {
    ID = 68198,
    CnID = "Sdk错误码@286",
    BaseSortID = 286,
    Code = 428
  },
  [68000] = {
    ID = 68000,
    CnID = "Sdk错误码@287",
    BaseSortID = 287,
    Code = 462
  },
  [68188] = {
    ID = 68188,
    CnID = "Sdk错误码@288",
    BaseSortID = 288,
    Code = 500
  },
  [68187] = {
    ID = 68187,
    CnID = "Sdk错误码@289",
    BaseSortID = 289,
    Code = 503
  },
  [68021] = {
    ID = 68021,
    CnID = "Sdk错误码@290",
    BaseSortID = 290,
    Code = 504
  },
  [68272] = {
    ID = 68272,
    CnID = "Sdk错误码@291",
    BaseSortID = 291,
    Code = 505
  },
  [68150] = {
    ID = 68150,
    CnID = "Sdk错误码@292",
    BaseSortID = 292,
    Code = 9990
  },
  [68059] = {
    ID = 68059,
    CnID = "Sdk错误码@293",
    BaseSortID = 293,
    Code = 10410
  },
  [68238] = {
    ID = 68238,
    CnID = "Sdk错误码@294",
    BaseSortID = 294,
    Code = 10411
  },
  [68219] = {
    ID = 68219,
    CnID = "Sdk错误码@295",
    BaseSortID = 295,
    Code = 10412
  },
  [68154] = {
    ID = 68154,
    CnID = "Sdk错误码@296",
    BaseSortID = 296,
    Code = 10413
  },
  [68074] = {
    ID = 68074,
    CnID = "Sdk错误码@297",
    BaseSortID = 297,
    Code = 10414
  },
  [68148] = {
    ID = 68148,
    CnID = "Sdk错误码@298",
    BaseSortID = 298,
    Code = 10415
  },
  [68149] = {
    ID = 68149,
    CnID = "Sdk错误码@299",
    BaseSortID = 299,
    Code = 10416
  },
  [68075] = {
    ID = 68075,
    CnID = "Sdk错误码@300",
    BaseSortID = 300,
    Code = 10417
  },
  [68253] = {
    ID = 68253,
    CnID = "Sdk错误码@301",
    BaseSortID = 301,
    Code = 10418
  },
  [68254] = {
    ID = 68254,
    CnID = "Sdk错误码@302",
    BaseSortID = 302,
    Code = 10419
  },
  [68255] = {
    ID = 68255,
    CnID = "Sdk错误码@303",
    BaseSortID = 303,
    Code = 10420
  },
  [68256] = {
    ID = 68256,
    CnID = "Sdk错误码@304",
    BaseSortID = 304,
    Code = 10421
  },
  [68257] = {
    ID = 68257,
    CnID = "Sdk错误码@305",
    BaseSortID = 305,
    Code = 10422
  },
  [68258] = {
    ID = 68258,
    CnID = "Sdk错误码@306",
    BaseSortID = 306,
    Code = 10423
  },
  [68259] = {
    ID = 68259,
    CnID = "Sdk错误码@307",
    BaseSortID = 307,
    Code = 10500
  },
  [68249] = {
    ID = 68249,
    CnID = "Sdk错误码@308",
    BaseSortID = 308,
    Code = 10501
  },
  [68237] = {
    ID = 68237,
    CnID = "Sdk错误码@309",
    BaseSortID = 309,
    Code = 10502
  },
  [67973] = {
    ID = 67973,
    CnID = "Sdk错误码@310",
    BaseSortID = 310,
    Code = 10503
  },
  [67972] = {
    ID = 67972,
    CnID = "Sdk错误码@311",
    BaseSortID = 311,
    Code = 10504
  },
  [67971] = {
    ID = 67971,
    CnID = "Sdk错误码@312",
    BaseSortID = 312,
    Code = 10505
  },
  [67970] = {
    ID = 67970,
    CnID = "Sdk错误码@313",
    BaseSortID = 313,
    Code = 10506
  },
  [67969] = {
    ID = 67969,
    CnID = "Sdk错误码@314",
    BaseSortID = 314,
    Code = 10507
  },
  [67968] = {
    ID = 67968,
    CnID = "Sdk错误码@315",
    BaseSortID = 315,
    Code = 10508
  },
  [67967] = {
    ID = 67967,
    CnID = "Sdk错误码@316",
    BaseSortID = 316,
    Code = 10509
  },
  [71106] = {
    ID = 71106,
    CnID = "Sdk错误码@317",
    BaseSortID = 317,
    Code = 10510
  },
  [71105] = {
    ID = 71105,
    CnID = "Sdk错误码@318",
    BaseSortID = 318,
    Code = 10511
  },
  [71104] = {
    ID = 71104,
    CnID = "Sdk错误码@319",
    BaseSortID = 319,
    Code = 10512
  },
  [71137] = {
    ID = 71137,
    CnID = "Sdk错误码@320",
    BaseSortID = 320,
    Code = 10513
  },
  [71138] = {
    ID = 71138,
    CnID = "Sdk错误码@321",
    BaseSortID = 321,
    Code = 10514
  },
  [71135] = {
    ID = 71135,
    CnID = "Sdk错误码@322",
    BaseSortID = 322,
    Code = 10515
  },
  [71136] = {
    ID = 71136,
    CnID = "Sdk错误码@323",
    BaseSortID = 323,
    Code = 10516
  },
  [71133] = {
    ID = 71133,
    CnID = "Sdk错误码@324",
    BaseSortID = 324,
    Code = 10517
  },
  [71134] = {
    ID = 71134,
    CnID = "Sdk错误码@325",
    BaseSortID = 325,
    Code = 10518
  },
  [71131] = {
    ID = 71131,
    CnID = "Sdk错误码@326",
    BaseSortID = 326,
    Code = 10519
  },
  [71132] = {
    ID = 71132,
    CnID = "Sdk错误码@327",
    BaseSortID = 327,
    Code = 10520
  },
  [71125] = {
    ID = 71125,
    CnID = "Sdk错误码@328",
    BaseSortID = 328,
    Code = 10521
  },
  [71126] = {
    ID = 71126,
    CnID = "Sdk错误码@329",
    BaseSortID = 329,
    Code = 10522
  },
  [71152] = {
    ID = 71152,
    CnID = "Sdk错误码@330",
    BaseSortID = 330,
    Code = 10523
  },
  [71151] = {
    ID = 71151,
    CnID = "Sdk错误码@331",
    BaseSortID = 331,
    Code = 10524
  },
  [71107] = {
    ID = 71107,
    CnID = "Sdk错误码@332",
    BaseSortID = 332,
    Code = 10525
  },
  [71103] = {
    ID = 71103,
    CnID = "Sdk错误码@333",
    BaseSortID = 333,
    Code = 10526
  },
  [71148] = {
    ID = 71148,
    CnID = "Sdk错误码@334",
    BaseSortID = 334,
    Code = 10527
  },
  [71147] = {
    ID = 71147,
    CnID = "Sdk错误码@335",
    BaseSortID = 335,
    Code = 10528
  },
  [71112] = {
    ID = 71112,
    CnID = "Sdk错误码@336",
    BaseSortID = 336,
    Code = 10529
  },
  [71111] = {
    ID = 71111,
    CnID = "Sdk错误码@337",
    BaseSortID = 337,
    Code = 10530
  },
  [71120] = {
    ID = 71120,
    CnID = "Sdk错误码@338",
    BaseSortID = 338,
    Code = 10531
  },
  [71119] = {
    ID = 71119,
    CnID = "Sdk错误码@339",
    BaseSortID = 339,
    Code = 10532
  },
  [71122] = {
    ID = 71122,
    CnID = "Sdk错误码@340",
    BaseSortID = 340,
    Code = 10533
  },
  [71144] = {
    ID = 71144,
    CnID = "Sdk错误码@341",
    BaseSortID = 341,
    Code = 10534
  },
  [71127] = {
    ID = 71127,
    CnID = "Sdk错误码@342",
    BaseSortID = 342,
    Code = 10541
  },
  [71130] = {
    ID = 71130,
    CnID = "Sdk错误码@343",
    BaseSortID = 343,
    Code = 10542
  },
  [71108] = {
    ID = 71108,
    CnID = "Sdk错误码@344",
    BaseSortID = 344,
    Code = 10543
  },
  [71123] = {
    ID = 71123,
    CnID = "Sdk错误码@345",
    BaseSortID = 345,
    Code = 410000
  },
  [71129] = {
    ID = 71129,
    CnID = "Sdk错误码@346",
    BaseSortID = 346,
    Code = 410001
  },
  [71121] = {
    ID = 71121,
    CnID = "Sdk错误码@347",
    BaseSortID = 347,
    Code = 410002
  },
  [71128] = {
    ID = 71128,
    CnID = "Sdk错误码@348",
    BaseSortID = 348,
    Code = 410003
  },
  [71124] = {
    ID = 71124,
    CnID = "Sdk错误码@349",
    BaseSortID = 349,
    Code = 410004
  },
  [71150] = {
    ID = 71150,
    CnID = "Sdk错误码@350",
    BaseSortID = 350,
    Code = 410005
  },
  [71149] = {
    ID = 71149,
    CnID = "Sdk错误码@351",
    BaseSortID = 351,
    Code = 410006
  },
  [71110] = {
    ID = 71110,
    CnID = "Sdk错误码@352",
    BaseSortID = 352,
    Code = 410007
  },
  [71109] = {
    ID = 71109,
    CnID = "Sdk错误码@353",
    BaseSortID = 353,
    Code = 410008
  },
  [71116] = {
    ID = 71116,
    CnID = "Sdk错误码@354",
    BaseSortID = 354,
    Code = 410009
  },
  [71115] = {
    ID = 71115,
    CnID = "Sdk错误码@355",
    BaseSortID = 355,
    Code = 410010
  },
  [71114] = {
    ID = 71114,
    CnID = "Sdk错误码@356",
    BaseSortID = 356,
    Code = 410011
  },
  [71113] = {
    ID = 71113,
    CnID = "Sdk错误码@357",
    BaseSortID = 357,
    Code = 410012
  },
  [71118] = {
    ID = 71118,
    CnID = "Sdk错误码@358",
    BaseSortID = 358,
    Code = 410013
  },
  [71117] = {
    ID = 71117,
    CnID = "Sdk错误码@359",
    BaseSortID = 359,
    Code = 410014
  },
  [71141] = {
    ID = 71141,
    CnID = "Sdk错误码@360",
    BaseSortID = 360,
    Code = 410015
  },
  [71142] = {
    ID = 71142,
    CnID = "Sdk错误码@361",
    BaseSortID = 361,
    Code = 510001
  },
  [71139] = {
    ID = 71139,
    CnID = "Sdk错误码@362",
    BaseSortID = 362,
    Code = 510002
  },
  [71140] = {
    ID = 71140,
    CnID = "Sdk错误码@363",
    BaseSortID = 363,
    Code = 510003
  },
  [71145] = {
    ID = 71145,
    CnID = "Sdk错误码@364",
    BaseSortID = 364,
    Code = 510004
  },
  [71146] = {
    ID = 71146,
    CnID = "Sdk错误码@365",
    BaseSortID = 365,
    Code = 510005
  },
  [71143] = {
    ID = 71143,
    CnID = "Sdk错误码@366",
    BaseSortID = 366,
    Code = 510006
  }
})
return SdkErrorCode
