local key = {
  ID = 1,
  type = 2,
  PS = 3,
  typeParam = 4
}
local common = {
  "匹皮印记",
  "储备弹药",
  "泰莎印记",
  "勇虎值",
  "浊茧",
  "侠心印记",
  "忍力",
  "闪电机蜂",
  "补给点数",
  "蜃影之击",
  "理智系统",
  "无时印记",
  "终结值",
  "孤勇值",
  "纤丝值",
  "煜魂值",
  "菲亚点数",
  "起源之牌",
  "铳御值",
  "快闪阵",
  "立方能",
  "治疗球",
  "洞悉点",
  "涟漪波",
  "四脚铁蜥",
  "影赋",
  "投资战略",
  "待降方块",
  "AP",
  "战术系统",
  "威能"
}
local config = {
  [10000] = {
    10000,
    1,
    "流血",
    {buffId = 20031}
  },
  [10001] = {
    10001,
    1,
    "中毒",
    {buffId = 20021}
  },
  [10002] = {
    10002,
    1,
    "灼烧",
    {buffId = 20011}
  },
  [10003] = {
    10003,
    1,
    "恐惧",
    {buffId = 10021}
  },
  [10004] = {
    10004,
    1,
    "麻痹",
    {buffId = 30061}
  },
  [10005] = {
    10005,
    1,
    "致盲",
    {buffId = 30081}
  },
  [10006] = {
    10006,
    1,
    "减速",
    {buffId = 10041}
  },
  [20001] = {
    20001,
    2,
    "强化格子",
    {trapId = 14}
  },
  [30001] = {
    30001,
    3,
    "棱镜格子",
    {
      name = "str_skill_href_desc_name_30001",
      icon = "icon_grid_lengjing",
      desc = "str_skill_href_desc_desc_30001"
    }
  },
  [30002] = {
    30002,
    3,
    common[1],
    {
      name = "str_skill_href_desc_name_30002",
      desc = "str_skill_href_desc_desc_30002"
    }
  },
  [30003] = {
    30003,
    3,
    common[1],
    {
      name = "str_skill_href_desc_name_30003",
      desc = "str_skill_href_desc_desc_30003"
    }
  },
  [30004] = {
    30004,
    3,
    "圣钉流血层数",
    {
      name = "str_skill_href_desc_name_30004",
      desc = "str_skill_href_desc_desc_30004"
    }
  },
  [30005] = {
    30005,
    3,
    "见证印记",
    {
      name = "str_skill_href_desc_name_30005",
      desc = "str_skill_href_desc_desc_30005"
    }
  },
  [30006] = {
    30006,
    3,
    "协奏印记",
    {
      name = "str_skill_href_desc_name_30006",
      desc = "str_skill_href_desc_desc_30006"
    }
  },
  [30007] = {
    30007,
    3,
    "恢复效果",
    {
      name = "str_skill_href_desc_name_30007",
      desc = "str_skill_href_desc_desc_30007"
    }
  },
  [30008] = {
    30008,
    3,
    common[2],
    {
      name = "str_skill_href_desc_name_30008",
      desc = "str_skill_href_desc_desc_30008"
    }
  },
  [30009] = {
    30009,
    3,
    common[2],
    {
      name = "str_skill_href_desc_name_30009",
      desc = "str_skill_href_desc_desc_30009"
    }
  },
  [30010] = {
    30010,
    3,
    "极光时刻",
    {
      name = "str_skill_href_desc_name_30010",
      desc = "str_skill_href_desc_desc_30010"
    }
  },
  [30011] = {
    30011,
    3,
    common[3],
    {
      name = "str_skill_href_desc_name_30011",
      desc = "str_skill_href_desc_desc_30011"
    }
  },
  [30012] = {
    30012,
    3,
    common[3],
    {
      name = "str_skill_href_desc_name_30012",
      desc = "str_skill_href_desc_desc_30012"
    }
  },
  [30013] = {
    30013,
    3,
    "沙利叶印记",
    {
      name = "str_skill_href_desc_name_30013",
      desc = "str_skill_href_desc_desc_30013"
    }
  },
  [30014] = {
    30014,
    3,
    "崩裂状态",
    {
      name = "str_skill_href_desc_name_30014",
      desc = "str_skill_href_desc_desc_30014"
    }
  },
  [30015] = {
    30015,
    3,
    "溅射",
    {
      name = "str_skill_href_desc_name_30015",
      desc = "str_skill_href_desc_desc_30015"
    }
  },
  [30016] = {
    30016,
    3,
    common[4],
    {
      name = "str_skill_href_desc_name_30016",
      desc = "str_skill_href_desc_desc_30016"
    }
  },
  [30017] = {
    30017,
    3,
    common[4],
    {
      name = "str_skill_href_desc_name_30017",
      desc = "str_skill_href_desc_desc_30017"
    }
  },
  [30018] = {
    30018,
    3,
    "无畏值",
    {
      name = "str_skill_href_desc_name_30018",
      desc = "str_skill_href_desc_desc_30018"
    }
  },
  [30019] = {
    30019,
    3,
    "祝福",
    {
      name = "str_skill_href_desc_name_30019",
      desc = "str_skill_href_desc_desc_30019"
    }
  },
  [30020] = {
    30020,
    3,
    "净化",
    {
      name = "str_skill_href_desc_name_30020",
      desc = "str_skill_href_desc_desc_30020"
    }
  },
  [30021] = {
    30021,
    3,
    common[5],
    {
      name = "str_skill_href_desc_name_30021",
      desc = "str_skill_href_desc_desc_30021"
    }
  },
  [30022] = {
    30022,
    3,
    common[5],
    {
      name = "str_skill_href_desc_name_30022",
      desc = "str_skill_href_desc_desc_30022"
    }
  },
  [30023] = {
    30023,
    3,
    common[5],
    {
      name = "str_skill_href_desc_name_30023",
      desc = "str_skill_href_desc_desc_30023"
    }
  },
  [30024] = {
    30024,
    3,
    "弗兰克",
    {
      name = "str_skill_href_desc_name_30024",
      desc = "str_skill_href_desc_desc_30024"
    }
  },
  [30025] = {
    30025,
    3,
    "蛛丝印记",
    {
      name = "str_skill_href_desc_name_30025",
      desc = "str_skill_href_desc_desc_30025"
    }
  },
  [30026] = {
    30026,
    3,
    common[6],
    {
      name = "str_skill_href_desc_name_30026",
      desc = "str_skill_href_desc_desc_30026"
    }
  },
  [30027] = {
    30027,
    3,
    common[6],
    {
      name = "str_skill_href_desc_name_30027",
      desc = "str_skill_href_desc_desc_30027"
    }
  },
  [30028] = {
    30028,
    3,
    common[7],
    {
      name = "str_skill_href_desc_name_30028",
      desc = "str_skill_href_desc_desc_30028"
    }
  },
  [30029] = {
    30029,
    3,
    common[7],
    {
      name = "str_skill_href_desc_name_30029",
      desc = "str_skill_href_desc_desc_30029"
    }
  },
  [30030] = {
    30030,
    3,
    "「特别蟹家料理」",
    {
      name = "str_skill_href_desc_name_30030",
      desc = "str_skill_href_desc_desc_30030"
    }
  },
  [30031] = {
    30031,
    3,
    common[8],
    {
      name = "str_skill_href_desc_name_30031",
      desc = "str_skill_href_desc_desc_30031"
    }
  },
  [30032] = {
    30032,
    3,
    common[8],
    {
      name = "str_skill_href_desc_name_30032",
      desc = "str_skill_href_desc_desc_30032"
    }
  },
  [30033] = {
    30033,
    3,
    common[9],
    {
      name = "str_skill_href_desc_name_30033",
      desc = "str_skill_href_desc_desc_30033"
    }
  },
  [30034] = {
    30034,
    3,
    common[9],
    {
      name = "str_skill_href_desc_name_30034",
      desc = "str_skill_href_desc_desc_30034"
    }
  },
  [30035] = {
    30035,
    3,
    "蜃影",
    {
      name = "str_skill_href_desc_name_30035",
      desc = "str_skill_href_desc_desc_30035"
    }
  },
  [30036] = {
    30036,
    3,
    common[10],
    {
      name = "str_skill_href_desc_name_30036",
      desc = "str_skill_href_desc_desc_30036"
    }
  },
  [30037] = {
    30037,
    3,
    common[10],
    {
      name = "str_skill_href_desc_name_30037",
      desc = "str_skill_href_desc_desc_30037"
    }
  },
  [30038] = {
    30038,
    3,
    "蜃影变幻",
    {
      name = "str_skill_href_desc_name_30038",
      desc = "str_skill_href_desc_desc_30038"
    }
  },
  [30039] = {
    30039,
    3,
    common[11],
    {
      name = "str_skill_href_desc_name_30039",
      desc = "str_skill_href_desc_desc_30039"
    }
  },
  [30040] = {
    30040,
    3,
    common[11],
    {
      name = "str_skill_href_desc_name_30040",
      desc = "str_skill_href_desc_desc_30040"
    }
  },
  [30041] = {
    30041,
    3,
    common[12],
    {
      name = "str_skill_href_desc_name_30041",
      desc = "str_skill_href_desc_desc_30041"
    }
  },
  [30042] = {
    30042,
    3,
    common[12],
    {
      name = "str_skill_href_desc_name_30042",
      desc = "str_skill_href_desc_desc_30042"
    }
  },
  [30043] = {
    30043,
    3,
    common[13],
    {
      name = "str_skill_href_desc_name_30043",
      desc = "str_skill_href_desc_desc_30043"
    }
  },
  [30044] = {
    30044,
    3,
    common[13],
    {
      name = "str_skill_href_desc_name_30044",
      desc = "str_skill_href_desc_desc_30044"
    }
  },
  [300441] = {
    300441,
    3,
    common[13],
    {
      name = "str_skill_href_desc_name_300441",
      desc = "str_skill_href_desc_desc_300441"
    }
  },
  [300442] = {
    300442,
    3,
    common[13],
    {
      name = "str_skill_href_desc_name_300442",
      desc = "str_skill_href_desc_desc_300442"
    }
  },
  [300443] = {
    300443,
    3,
    common[13],
    {
      name = "str_skill_href_desc_name_300443",
      desc = "str_skill_href_desc_desc_300443"
    }
  },
  [30045] = {
    30045,
    3,
    common[14],
    {
      name = "str_skill_href_desc_name_30045",
      desc = "str_skill_href_desc_desc_30045"
    }
  },
  [30046] = {
    30046,
    3,
    common[14],
    {
      name = "str_skill_href_desc_name_30046",
      desc = "str_skill_href_desc_desc_30046"
    }
  },
  [30047] = {
    30047,
    3,
    common[14],
    {
      name = "str_skill_href_desc_name_30047",
      desc = "str_skill_href_desc_desc_30047"
    }
  },
  [30048] = {
    30048,
    3,
    common[15],
    {
      name = "str_skill_href_desc_name_30048",
      desc = "str_skill_href_desc_desc_30048"
    }
  },
  [30049] = {
    30049,
    3,
    common[15],
    {
      name = "str_skill_href_desc_name_30049",
      desc = "str_skill_href_desc_desc_30049"
    }
  },
  [30050] = {
    30050,
    3,
    common[15],
    {
      name = "str_skill_href_desc_name_30050",
      desc = "str_skill_href_desc_desc_30050"
    }
  },
  [30051] = {
    30051,
    3,
    "特别技",
    {
      name = "str_skill_href_desc_name_30051",
      desc = "str_skill_href_desc_desc_30051"
    }
  },
  [30052] = {
    30052,
    3,
    nil,
    {
      name = "str_skill_href_desc_name_30052",
      desc = "str_skill_href_desc_desc_30052"
    }
  },
  [30053] = {
    30053,
    3,
    common[16],
    {
      name = "str_skill_href_desc_name_30053",
      desc = "str_skill_href_desc_desc_30053"
    }
  },
  [30054] = {
    30054,
    3,
    common[16],
    {
      name = "str_skill_href_desc_name_30054",
      desc = "str_skill_href_desc_desc_30054"
    }
  },
  [30055] = {
    30055,
    3,
    common[17],
    {
      name = "str_skill_href_desc_name_30055",
      desc = "str_skill_href_desc_desc_30055"
    }
  },
  [30056] = {
    30056,
    3,
    common[17],
    {
      name = "str_skill_href_desc_name_30056",
      desc = "str_skill_href_desc_desc_30056"
    }
  },
  [30057] = {
    30057,
    3,
    "菲亚转向",
    {
      name = "str_skill_href_desc_name_30057",
      desc = "str_skill_href_desc_desc_30057"
    }
  },
  [30058] = {
    30058,
    3,
    common[18],
    {
      name = "str_skill_href_desc_name_30058",
      desc = "str_skill_href_desc_desc_30058"
    }
  },
  [30059] = {
    30059,
    3,
    common[18],
    {
      name = "str_skill_href_desc_name_30059",
      desc = "str_skill_href_desc_desc_30059"
    }
  },
  [30060] = {
    30060,
    3,
    common[18],
    {
      name = "str_skill_href_desc_name_30060",
      desc = "str_skill_href_desc_desc_30060"
    }
  },
  [30061] = {
    30061,
    3,
    "花洒印记",
    {
      name = "str_skill_href_desc_name_30061",
      desc = "str_skill_href_desc_desc_30061"
    }
  },
  [30062] = {
    30062,
    3,
    "律法之像",
    {
      name = "str_skill_href_desc_name_30062",
      desc = "str_skill_href_desc_desc_30062"
    }
  },
  [30063] = {
    30063,
    3,
    common[19],
    {
      name = "str_skill_href_desc_name_30063",
      desc = "str_skill_href_desc_desc_30063"
    }
  },
  [30064] = {
    30064,
    3,
    common[19],
    {
      name = "str_skill_href_desc_name_30064",
      desc = "str_skill_href_desc_desc_30064"
    }
  },
  [30065] = {
    30065,
    3,
    "吸收",
    {
      name = "str_skill_href_desc_name_30065",
      desc = "str_skill_href_desc_desc_30065"
    }
  },
  [30066] = {
    30066,
    3,
    common[20],
    {
      name = "str_skill_href_desc_name_30066",
      desc = "str_skill_href_desc_desc_30066"
    }
  },
  [30067] = {
    30067,
    3,
    common[20],
    {
      name = "str_skill_href_desc_name_30067",
      desc = "str_skill_href_desc_desc_30067"
    }
  },
  [30068] = {
    30068,
    3,
    common[20],
    {
      name = "str_skill_href_desc_name_30068",
      desc = "str_skill_href_desc_desc_30068"
    }
  },
  [30069] = {
    30069,
    3,
    common[21],
    {
      name = "str_skill_href_desc_name_30069",
      desc = "str_skill_href_desc_desc_30069"
    }
  },
  [30070] = {
    30070,
    3,
    common[21],
    {
      name = "str_skill_href_desc_name_30070",
      desc = "str_skill_href_desc_desc_30070"
    }
  },
  [30071] = {
    30071,
    3,
    "侦控模块",
    {
      name = "str_skill_href_desc_name_30071",
      desc = "str_skill_href_desc_desc_30071"
    }
  },
  [30072] = {
    30072,
    3,
    common[22],
    {
      name = "str_skill_href_desc_name_30072",
      desc = "str_skill_href_desc_desc_30072"
    }
  },
  [30073] = {
    30073,
    3,
    common[22],
    {
      name = "str_skill_href_desc_name_30073",
      desc = "str_skill_href_desc_desc_30073"
    }
  },
  [30074] = {
    30074,
    3,
    "净龙辉",
    {
      name = "str_skill_href_desc_name_30074",
      icon = "N26_junei_di01",
      desc = "str_skill_href_desc_desc_30074"
    }
  },
  [30075] = {
    30075,
    3,
    common[23],
    {
      name = "str_skill_href_desc_name_30075",
      desc = "str_skill_href_desc_desc_30075"
    }
  },
  [30076] = {
    30076,
    3,
    common[23],
    {
      name = "str_skill_href_desc_name_30076",
      desc = "str_skill_href_desc_desc_30076"
    }
  },
  [30077] = {
    30077,
    3,
    common[23],
    {
      name = "str_skill_href_desc_name_30077",
      desc = "str_skill_href_desc_desc_30077"
    }
  },
  [30078] = {
    30078,
    3,
    "热值",
    {
      name = "str_skill_href_desc_name_30078",
      desc = "str_skill_href_desc_desc_30078"
    }
  },
  [30079] = {
    30079,
    3,
    common[2],
    {
      name = "str_skill_href_desc_name_30079",
      desc = "str_skill_href_desc_desc_30079"
    }
  },
  [30080] = {
    30080,
    3,
    "十字棱镜",
    {
      name = "str_skill_href_desc_name_30080",
      icon = "icon_grid_szlengjing",
      desc = "str_skill_href_desc_desc_30080"
    }
  },
  [30081] = {
    30081,
    3,
    "靠拢",
    {
      name = "str_skill_href_desc_name_30081",
      desc = "str_skill_href_desc_desc_30081"
    }
  },
  [30082] = {
    30082,
    3,
    "聚集",
    {
      name = "str_skill_href_desc_name_30082",
      desc = "str_skill_href_desc_desc_30082"
    }
  },
  [30083] = {
    30083,
    3,
    "诅咒",
    {
      name = "str_skill_href_desc_name_30083",
      desc = "str_skill_href_desc_desc_30083"
    }
  },
  [30084] = {
    30084,
    3,
    "聚拢",
    {
      name = "str_skill_href_desc_name_30084",
      desc = "str_skill_href_desc_desc_30084"
    }
  },
  [30085] = {
    30085,
    3,
    common[24],
    {
      name = "str_skill_href_desc_name_30085",
      desc = "str_skill_href_desc_desc_30085"
    }
  },
  [30086] = {
    30086,
    3,
    common[24],
    {
      name = "str_skill_href_desc_name_30086",
      desc = "str_skill_href_desc_desc_30086"
    }
  },
  [30087] = {
    30087,
    3,
    common[25],
    {
      name = "str_skill_href_desc_name_30087",
      desc = "str_skill_href_desc_desc_30087"
    }
  },
  [30088] = {
    30088,
    3,
    common[25],
    {
      name = "str_skill_href_desc_name_30088",
      desc = "str_skill_href_desc_desc_30088"
    }
  },
  [30089] = {
    30089,
    3,
    "牵鸣",
    {
      name = "str_skill_href_desc_name_30089",
      desc = "str_skill_href_desc_desc_30089"
    }
  },
  [30090] = {
    30090,
    3,
    "洪引",
    {
      name = "str_skill_href_desc_name_30090",
      desc = "str_skill_href_desc_desc_30090"
    }
  },
  [30091] = {
    30091,
    3,
    "触碰",
    {
      name = "str_skill_href_desc_name_30091",
      desc = "str_skill_href_desc_desc_30091"
    }
  },
  [30092] = {
    30092,
    3,
    "位移",
    {
      name = "str_skill_href_desc_name_30092",
      desc = "str_skill_href_desc_desc_30092"
    }
  },
  [30093] = {
    30093,
    3,
    "深色格子",
    {
      name = "str_skill_href_desc_name_30093",
      icon = "icon_grid_shense",
      desc = "str_skill_href_desc_desc_30093"
    }
  },
  [30094] = {
    30094,
    3,
    "浸体",
    {
      name = "str_skill_href_desc_name_30094",
      desc = "str_skill_href_desc_desc_30094"
    }
  },
  [30095] = {
    30095,
    3,
    "工备",
    {
      name = "str_skill_href_desc_name_30095",
      desc = "str_skill_href_desc_desc_30095"
    }
  },
  [30096] = {
    30096,
    3,
    common[26],
    {
      name = "str_skill_href_desc_name_30096",
      desc = "str_skill_href_desc_desc_30096"
    }
  },
  [30097] = {
    30097,
    3,
    common[26],
    {
      name = "str_skill_href_desc_name_30097",
      desc = "str_skill_href_desc_desc_30097"
    }
  },
  [30098] = {
    30098,
    3,
    common[26],
    {
      name = "str_skill_href_desc_name_30098",
      desc = "str_skill_href_desc_desc_30098"
    }
  },
  [30099] = {
    30099,
    3,
    common[26],
    {
      name = "str_skill_href_desc_name_30099",
      desc = "str_skill_href_desc_desc_30099"
    }
  },
  [510218] = {
    510218,
    3,
    common[27],
    {
      name = "str_skill_href_desc_name_510218",
      desc = "str_skill_href_desc_desc_510218"
    }
  },
  [513218] = {
    513218,
    3,
    common[27],
    {
      name = "str_skill_href_desc_name_513218",
      desc = "str_skill_href_desc_desc_513218"
    }
  },
  [516218] = {
    516218,
    3,
    common[27],
    {
      name = "str_skill_href_desc_name_516218",
      desc = "str_skill_href_desc_desc_516218"
    }
  },
  [530218] = {
    530218,
    3,
    common[27],
    {
      name = "str_skill_href_desc_name_530218",
      desc = "str_skill_href_desc_desc_530218"
    }
  },
  [533218] = {
    533218,
    3,
    common[27],
    {
      name = "str_skill_href_desc_name_533218",
      desc = "str_skill_href_desc_desc_533218"
    }
  },
  [536218] = {
    536218,
    3,
    common[27],
    {
      name = "str_skill_href_desc_name_536218",
      desc = "str_skill_href_desc_desc_536218"
    }
  },
  [30100] = {
    30100,
    3,
    common[26],
    {
      name = "str_skill_href_desc_name_30100",
      desc = "str_skill_href_desc_desc_30100"
    }
  },
  [30110] = {
    30110,
    3,
    common[28],
    {
      name = "str_skill_href_desc_name_30110",
      desc = "str_skill_href_desc_desc_30110"
    }
  },
  [30111] = {
    30111,
    3,
    common[28],
    {
      name = "str_skill_href_desc_name_30111",
      desc = "str_skill_href_desc_desc_30111"
    }
  },
  [30112] = {
    30112,
    3,
    common[28],
    {
      name = "str_skill_href_desc_name_30112",
      desc = "str_skill_href_desc_desc_30112"
    }
  },
  [30113] = {
    30113,
    3,
    common[28],
    {
      name = "str_skill_href_desc_name_30113",
      desc = "str_skill_href_desc_desc_30113"
    }
  },
  [30114] = {
    30114,
    3,
    common[28],
    {
      name = "str_skill_href_desc_name_30114",
      desc = "str_skill_href_desc_desc_30114"
    }
  },
  [30115] = {
    30115,
    3,
    common[28],
    {
      name = "str_skill_href_desc_name_30115",
      desc = "str_skill_href_desc_desc_30115"
    }
  },
  [30116] = {
    30116,
    3,
    common[28],
    {
      name = "str_skill_href_desc_name_30116",
      desc = "str_skill_href_desc_desc_30116"
    }
  },
  [30117] = {
    30117,
    3,
    "镇魂印记",
    {
      name = "str_skill_href_desc_name_30117",
      desc = "str_skill_href_desc_desc_30117"
    }
  },
  [30118] = {
    30118,
    3,
    "真主契约",
    {
      name = "str_skill_href_desc_name_30118",
      desc = "str_skill_href_desc_desc_30118"
    }
  },
  [30119] = {
    30119,
    3,
    common[29],
    {
      name = "str_skill_href_desc_name_30119",
      desc = "str_skill_href_desc_desc_30119"
    }
  },
  [30120] = {
    30120,
    3,
    common[29],
    {
      name = "str_skill_href_desc_name_30120",
      desc = "str_skill_href_desc_desc_30120"
    }
  },
  [30121] = {
    30121,
    3,
    common[29],
    {
      name = "str_skill_href_desc_name_30121",
      desc = "str_skill_href_desc_desc_30121"
    }
  },
  [30122] = {
    30122,
    3,
    common[30],
    {
      name = "str_skill_href_desc_name_30122",
      desc = "str_skill_href_desc_desc_30122"
    }
  },
  [30123] = {
    30123,
    3,
    common[30],
    {
      name = "str_skill_href_desc_name_30123",
      desc = "str_skill_href_desc_desc_30123"
    }
  },
  [30124] = {
    30124,
    3,
    "莱莎吸收",
    {
      name = "str_skill_href_desc_name_30124",
      desc = "str_skill_href_desc_desc_30124"
    }
  },
  [30125] = {
    30125,
    3,
    common[31],
    {
      name = "str_skill_href_desc_name_30125",
      desc = "str_skill_href_desc_desc_30125"
    }
  },
  [30126] = {
    30126,
    3,
    common[31],
    {
      name = "str_skill_href_desc_name_30126",
      desc = "str_skill_href_desc_desc_30126"
    }
  },
  [30127] = {
    30127,
    3,
    "连线操作",
    {
      name = "str_skill_href_desc_name_30127",
      desc = "str_skill_href_desc_desc_30127"
    }
  },
  [30128] = {
    30128,
    3,
    "离队状态",
    {
      name = "str_skill_href_desc_name_30128",
      desc = "str_skill_href_desc_desc_30128"
    }
  },
  [30129] = {
    30129,
    3,
    "残影",
    {
      name = "str_skill_href_desc_name_30129",
      desc = "str_skill_href_desc_desc_30129"
    }
  }
}
return config, "ID", key
