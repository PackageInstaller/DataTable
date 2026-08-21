local key = {
  ID = 1,
  CG = 2,
  Spine = 3,
  Icon = 4,
  PetID = 5,
  Order = 6,
  SpineAnim = 7,
  NeedItem = 8,
  SkinID = 9
}
local common = {
  "Story_norm",
  "Story_smile",
  "Story_happy",
  "1500424_assistant_spine_cg",
  "badunqingnian1_s7_spine_idle",
  "1500424_assistant"
}
local config = {
  [10001] = {
    10001,
    "1601054_assistant_spine_cg",
    "yifupifu_guofun2_spine_idle",
    "1601054_assistant",
    1601051,
    1,
    common[1],
    nil,
    91054
  },
  [10005] = {
    10005,
    "1600273_assistant_spine_cg",
    "mijialebaiqing_n27_spine_idle",
    "1600273_assistant",
    1600271,
    1,
    common[1],
    nil,
    90273
  },
  [10006] = {
    10006,
    "1600023_assistant_spine_cg",
    "feixinbing_spine_idle",
    "1600023_assistant",
    1600021,
    1,
    common[1],
    nil,
    90023
  },
  [10007] = {
    10007,
    "1600253_assistant_spine_cg",
    "karong_n7_spine_idle",
    "1600253_assistant",
    1600251,
    1,
    common[1],
    nil,
    90253
  },
  [10008] = {
    10008,
    "1500993_assistant_spine_cg",
    "aileiyalifu_n9_spine_idle",
    "1500993_assistant",
    1500991,
    1,
    common[1],
    nil,
    90993
  },
  [10009] = {
    10009,
    "1600963_assistant_spine_cg",
    "shaliyejiaoshi_n11_spine_idle",
    "1600963_assistant",
    1600961,
    1,
    common[1],
    nil,
    90963
  },
  [10010] = {
    10010,
    "1600303_assistant_spine_cg",
    "xingshanlangren_n13_spine_idle",
    "1600303_assistant",
    1600301,
    1,
    common[1],
    nil,
    90303
  },
  [10011] = {
    10011,
    "1600233_assistant_spine_cg",
    "kenalisaiche_n16_spine_idle",
    "1600233_assistant",
    1600231,
    1,
    common[1],
    nil,
    90233
  },
  [10012] = {
    10012,
    "1500713_assistant_spine_cg",
    "longsaiche_n15_spine_idle",
    "1500713_assistant",
    1500711,
    1,
    common[1],
    nil,
    90713
  },
  [10013] = {
    10013,
    "1601881_assistant_spine_cg",
    "dantang_guofu_spine_idle",
    "1601881_assistant",
    1601881,
    10,
    common[1]
  },
  [10014] = {
    10014,
    "1501871_assistant_spine_cg",
    "litianxian_guofu_spine_idle",
    "1501871_assistant",
    1501871,
    10,
    common[1]
  },
  [10015] = {
    10015,
    "1500331_assistant_spine_cg",
    "weisi_spine_idle",
    "1500331_assistant",
    1500331,
    10,
    common[1]
  },
  [10016] = {
    10016,
    "1600021_assistant_spine_cg",
    "ying_spine_idle",
    "1600021_assistant",
    1600021,
    10,
    common[1]
  },
  [10017] = {
    10017,
    "1600301_assistant_spine_cg",
    "xingshanjuqing_spine_idle",
    "1600301_assistant",
    1600301,
    10,
    common[1]
  },
  [10018] = {
    10018,
    "1400401_assistant_spine_cg",
    "baozhakuang_spine_idle",
    "1400401_assistant",
    1400401,
    10,
    common[1]
  },
  [10019] = {
    10019,
    "1600111_assistant_spine_cg",
    "longnv_spine_idle",
    "1600111_assistant",
    1600111,
    10,
    common[1]
  },
  [10020] = {
    10020,
    "1400571_assistant_spine_cg",
    "feilisi_spine_idle",
    "1400571_assistant",
    1400571,
    10,
    common[1]
  },
  [10021] = {
    10021,
    "1400441_assistant_spine_cg",
    "vivian_spine_idle",
    "1400441_assistant",
    1400441,
    10,
    common[1]
  },
  [10022] = {
    10022,
    "1601051_assistant_spine_cg",
    "yifu_spine_idle",
    "1601051_assistant",
    1601051,
    10,
    common[1]
  },
  [10023] = {
    10023,
    "1600381_assistant_spine_cg",
    "gonglu_spine_idle",
    "1600381_assistant",
    1600381,
    10,
    common[1]
  },
  [10024] = {
    10024,
    "1500761_assistant_spine_cg",
    "qizhashi_spine_idle",
    "1500761_assistant",
    1500761,
    10,
    common[1]
  },
  [10025] = {
    10025,
    "1500841_assistant_spine_cg",
    "yixienaqi_spine_idle",
    "1500841_assistant",
    1500841,
    10,
    common[1]
  },
  [10026] = {
    10026,
    "1500131_assistant_spine_cg",
    "nuoer_spine_idle",
    "1500131_assistant",
    1500131,
    10,
    common[1]
  },
  [10027] = {
    10027,
    "1500421_assistant_spine_cg",
    "badun_spine_idle",
    "1500421_assistant",
    1500421,
    10,
    common[1]
  },
  [10028] = {
    10028,
    "1500881_assistant_spine_cg",
    "xiyishaonv_spine_idle",
    "1500881_assistant",
    1500881,
    10,
    "Story_kanban"
  },
  [10029] = {
    10029,
    "1500921_assistant_spine_cg",
    "qifa_spine_idle",
    "1500921_assistant",
    1500921,
    10,
    common[1]
  },
  [10030] = {
    10030,
    "1500901_assistant_spine_cg",
    "hongyoutianxin_spine_idle",
    "1500901_assistant",
    1500901,
    10,
    common[1]
  },
  [10031] = {
    10031,
    "1500211_assistant_spine_cg",
    "yuanding_spine_idle",
    "1500211_assistant",
    1500211,
    10,
    common[1]
  },
  [10032] = {
    10032,
    "1600231_assistant_spine_cg",
    "kenali_spine_idle",
    "1600231_assistant",
    1600231,
    10,
    common[1]
  },
  [10033] = {
    10033,
    "1600641_assistant_spine_cg",
    "leiting_spine_idle",
    "1600641_assistant",
    1600641,
    10,
    common[1]
  },
  [10034] = {
    10034,
    "1600191_assistant_spine_cg",
    "xixueguishenfu_spine_idle",
    "1600191_assistant",
    1600191,
    10,
    common[1]
  },
  [10035] = {
    10035,
    "1300821_assistant_spine_cg",
    "lvjingjujiao_spine_idle",
    "1300821_assistant",
    1300821,
    10,
    common[1]
  },
  [10036] = {
    10036,
    "1500361_assistant_spine_cg",
    "yingfashi_spine_idle",
    "1500361_assistant",
    1500361,
    10,
    common[1]
  },
  [10038] = {
    10038,
    "1500711_assistant_spine_cg",
    "long_spine_idle",
    "1500711_assistant",
    1500711,
    10,
    common[1]
  },
  [10039] = {
    10039,
    "1500971_assistant_spine_cg",
    "du_spine_idle",
    "1500971_assistant",
    1500971,
    10,
    common[1]
  },
  [10040] = {
    10040,
    "1600961_assistant_spine_cg",
    "yuetianshi_spine_idle",
    "1600961_assistant",
    1600961,
    10,
    common[1]
  },
  [10041] = {
    10041,
    "1401021_assistant_spine_cg",
    "taisha_spine_idle",
    "1401021_assistant",
    1401021,
    10,
    common[1]
  },
  [10042] = {
    10042,
    "1500871_assistant_spine_cg",
    "beifuli_spine_idle",
    "1500871_assistant",
    1500871,
    10,
    common[1]
  },
  [10043] = {
    10043,
    "1501041_assistant_spine_cg",
    "duoen_spine_idle",
    "1501041_assistant",
    1501041,
    10,
    common[1]
  },
  [10044] = {
    10044,
    "1601033_assistant_spine_cg",
    "aixiswimsuit_spine_idle",
    "1601033_assistant",
    1601031,
    1,
    common[1],
    nil,
    91033
  },
  [10045] = {
    10045,
    "1600063_assistant_spine_cg",
    "kalianswimsuit_spine_idle",
    "1600063_assistant",
    1600061,
    1,
    common[1],
    nil,
    90063
  },
  [10046] = {
    10046,
    "1500333_assistant_spine_cg",
    "weisimizugi_spine_idle",
    "1500333_assistant",
    1500331,
    1,
    common[1],
    nil,
    90333
  },
  [10047] = {
    10047,
    "1400863_assistant_spine_cg",
    "xiunvswimsuit_spine_idle",
    "1400863_assistant",
    1400861,
    1,
    common[1],
    nil,
    90863
  },
  [10048] = {
    10048,
    "1601113_assistant_spine_cg",
    "bailieswimsuit_spine_idle",
    "1601113_assistant",
    1601111,
    1,
    common[1],
    nil,
    91113
  },
  [10049] = {
    10049,
    "1601163_assistant_spine_cg",
    "fulaoerchushi_n17_spine_idle",
    "1601163_assistant",
    1601161,
    1,
    common[1],
    nil,
    91163
  },
  [10050] = {
    10050,
    "1600384_assistant_spine_cg",
    "gongluyongzhuang_n21_spine_idle",
    "1600384_assistant",
    1600381,
    1,
    common[1],
    nil,
    90384
  },
  [10051] = {
    10051,
    "1500873_assistant_spine_cg",
    "beifuliyongzhuang_n21_spine_idle",
    "1500873_assistant",
    1500871,
    1,
    common[1],
    nil,
    90873
  },
  [10052] = {
    10052,
    "1601161_assistant_spine_cg",
    "fulaoer_spine_idle",
    "1601161_assistant",
    1601161,
    10,
    common[1]
  },
  [10053] = {
    10053,
    "1501131_assistant_spine_cg",
    "bonase_spine_idle",
    "1501131_assistant",
    1501131,
    10,
    common[1]
  },
  [10054] = {
    10054,
    "1601111_assistant_spine_cg",
    "bailie_spine_idle",
    "1601111_assistant",
    1601111,
    10,
    common[1]
  },
  [10055] = {
    10055,
    "1501141_assistant_spine_cg",
    "qinjiu_spine_idle",
    "1501141_assistant",
    1501141,
    10,
    common[1]
  },
  [10056] = {
    10056,
    "1601121_assistant_spine_cg",
    "simoqi_spine_idle",
    "1601121_assistant",
    1601121,
    10,
    common[1]
  },
  [10057] = {
    10057,
    "1500763_assistant_spine_cg",
    "qizhashiwimsuit_spine_idle",
    "1500763_assistant",
    1500761,
    1,
    common[1],
    nil,
    90763
  },
  [10058] = {
    10058,
    "1601123_assistant_spine_cg",
    "simoqiguaidao_n19_spine_idle",
    "1601123_assistant",
    1601121,
    1,
    common[1],
    nil,
    91123
  },
  [10059] = {
    10059,
    "1601211_assistant_spine_cg",
    "pulvma_spine_idle",
    "1601211_assistant",
    1601211,
    10,
    common[1]
  },
  [10060] = {
    10060,
    "1601151_assistant_spine_cg",
    "nanusaier_spine_idle",
    "1601151_assistant",
    1601151,
    10,
    common[1]
  },
  [10061] = {
    10061,
    "1601213_assistant_spine_cg",
    "pulvmalaoda_n24_spine_idle",
    "1601213_assistant",
    1601211,
    1,
    common[2],
    nil,
    91213
  },
  [10062] = {
    10062,
    "1600293_assistant_spine_cg",
    "jiabailiemonv_n30_spine_idle",
    "1600293_assistant",
    1600291,
    1,
    common[3],
    nil,
    90293
  },
  [10063] = {
    10063,
    "1500983_assistant_spine_cg",
    "kusikutazhentan_n29_spine_idle",
    "1500983_assistant",
    1500981,
    1,
    common[1],
    nil,
    90983
  },
  [10064] = {
    10064,
    "1500334_assistant_spine_cg",
    "weisiyuyi_spine_idle",
    "1500334_assistant",
    1500331,
    1,
    common[1],
    nil,
    90334
  },
  [10065] = {
    10065,
    "1400853_assistant_spine_cg",
    "jianmeiying_spine_idle",
    "1400853_assistant",
    1400851,
    1,
    common[1],
    nil,
    90853
  },
  [10066] = {
    10066,
    "1600064_assistant_spine_cg",
    "kalianshuiyi_n13_spine_idle",
    "1600064_assistant",
    1600061,
    1,
    common[3],
    nil,
    90064
  },
  [10067] = {
    10067,
    "1300651_assistant_spine_cg",
    "tataputong_spine_idle",
    "1300651_assistant",
    1300651,
    1,
    common[1]
  },
  [10068] = {
    10068,
    "1600894_assistant_spine_cg",
    "yiluntingpifu_S2_spine_idle",
    "1600894_assistant",
    1600891,
    1,
    common[1],
    nil,
    90894
  },
  [50001] = {
    50001,
    "1602121_assistant_spine_cg",
    "andun_n35_spine_idle",
    "1602121_assistant",
    1602121,
    10,
    common[1]
  },
  [50002] = {
    50002,
    "1602111_assistant_spine_cg",
    "chaliya_n35_spine_idle",
    "1602111_assistant",
    1602111,
    10,
    common[1]
  },
  [50003] = {
    50003,
    "1502131_assistant_spine_cg",
    "33hao_n35_spine_idle",
    "1502131_assistant",
    1502131,
    10,
    common[1]
  },
  [50004] = {
    50004,
    "1602113_assistant_spine_cg",
    "chaliyayongzhuang_n35_spine_idle",
    "1602113_assistant",
    1602111,
    1,
    common[1],
    nil,
    92113
  },
  [50005] = {
    50005,
    "1600113_assistant_spine_cg",
    "xiluonajiazu_spine_idle",
    "1600113_assistant",
    1600111,
    1,
    common[1],
    nil,
    90113
  },
  [50006] = {
    50006,
    "1500423_assistant_spine_cg",
    "badunhaijun_spine_idle",
    "1500423_assistant",
    1500421,
    1,
    common[1],
    nil,
    90423
  },
  [50007] = {
    50007,
    "1601541_assistant_spine_cg",
    "weisiyige_n17_spine_idle",
    "1601541_assistant",
    1601541,
    10,
    common[1]
  },
  [50008] = {
    50008,
    "1500923_assistant_spine_cg",
    "qifa_n7_spine_idle",
    "1500923_assistant",
    1500921,
    1,
    common[1],
    nil,
    90923
  },
  [50009] = {
    50009,
    "1600193_assistant_spine_cg",
    "weiduoliyalifu_n9_spine_idle",
    "1600193_assistant",
    1600191,
    1,
    common[1],
    nil,
    90193
  },
  [50010] = {
    50010,
    "1600933_assistant_spine_cg",
    "mijiade_spine_idle",
    "1600933_assistant",
    1600931,
    1,
    common[1],
    nil,
    90933
  },
  [50011] = {
    50011,
    "1401023_assistant_spine_cg",
    "taisha_n7_spine_idle",
    "1401023_assistant",
    1401021,
    1,
    common[1],
    nil,
    91023
  },
  [50012] = {
    50012,
    "1400573_assistant_spine_cg",
    "feilishi_spine_idle",
    "1400573_assistant",
    1400571,
    1,
    common[1],
    nil,
    90573
  },
  [50013] = {
    50013,
    "1600254_assistant_spine_cg",
    "karongdianying_n25_spine_idle",
    "1600254_assistant",
    1600251,
    1,
    common[1],
    nil,
    90254
  },
  [50014] = {
    50014,
    "1600234_assistant_spine_cg",
    "kenalinvwang_S3_spine_idle",
    "1600234_assistant",
    1600231,
    1,
    common[1],
    nil,
    90234
  },
  [50015] = {
    50015,
    "1602112_assistant_spine_cg",
    "chaliyayuanse_n35_spine_idle",
    "1602112_assistant",
    1602111,
    11,
    common[1]
  },
  [50016] = {
    50016,
    "1601194_assistant_spine_cg",
    "leiwendunzhuoguidao_n35_spine_idle",
    "1601194_assistant",
    1601191,
    1,
    common[1],
    nil,
    91194
  },
  [50017] = {
    50017,
    "1601173_assistant_spine_cg",
    "kepifu_n37_spine_idle",
    "1601173_assistant",
    1601171,
    1,
    common[1],
    nil,
    91173
  },
  [50018] = {
    50018,
    "1602161_assistant_spine_cg",
    "xuanjidasan_n38_spine_idle",
    "1602161_assistant",
    1602161,
    11,
    common[1]
  },
  [50019] = {
    50019,
    "1501831_assistant_spine_cg",
    "liqing_n26_spine_idle",
    "1501831_assistant",
    1501831,
    11,
    common[1]
  },
  [50020] = {
    50020,
    "1601811_assistant_spine_cg",
    "zhongxu_n26_spine_idle",
    "1601811_assistant",
    1601811,
    11,
    common[1]
  },
  [50021] = {
    50021,
    "1501873_assistant_spine_cg",
    "litianxianlonggong_n38_spine_idle",
    "1501873_assistant",
    1501871,
    1,
    common[1],
    nil,
    91873
  },
  [50022] = {
    50022,
    "1601883_assistant_spine_cg",
    "dantangguofeng_n38_spine_idle",
    "1601883_assistant",
    1601881,
    1,
    common[1],
    nil,
    91883
  },
  [50023] = {
    50023,
    "1400453_assistant_spine_cg",
    "shengdingchefu_n9_spine_idle",
    "1400453_assistant",
    1400451,
    1,
    common[1],
    nil,
    90453
  },
  [50024] = {
    50024,
    "1600103_assistant_spine_cg",
    "luyisinvpu_n17_spine_idle",
    "1600103_assistant",
    1600101,
    1,
    "Story_shocked2",
    nil,
    90103
  },
  [50025] = {
    50025,
    "1400544_assistant_spine_cg",
    "nadingguofeng_n38_spine_idle",
    "1400544_assistant",
    1400541,
    1,
    common[1],
    nil,
    90544
  },
  [50026] = {
    50026,
    "1600964_assistant_spine_cg",
    "shaliyeshengdan_n38_spine_idle",
    "1600964_assistant",
    1600961,
    1,
    common[1],
    nil,
    90964
  },
  [50039] = {
    50039,
    "1600024_assistant_spine_cg",
    "feipifu_n41_spine_idle",
    "1600024_assistant",
    1600021,
    1,
    common[1],
    nil,
    90024
  },
  [50043] = {
    50043,
    "1602231_assistant_spine_cg",
    "chenni_n41_spine_idle",
    "1602231_assistant",
    1602231,
    10,
    common[1]
  },
  [50045] = {
    50045,
    "1601821_assistant_spine_cg",
    "yuebai_n26_spine_idle",
    "1601821_assistant",
    1601821,
    10,
    common[1]
  },
  [50046] = {
    50046,
    "1701073_assistant_spine_cg",
    "jieweizuopifu_S5_spine_idle",
    "1701073_assistant",
    1701071,
    1,
    common[1],
    nil,
    91073
  },
  [50047] = {
    50047,
    "1601191_assistant_spine_cg",
    "leiwendun_spine_idle",
    "1601191_assistant",
    1601191,
    10,
    common[1]
  },
  [50048] = {
    50048,
    "1601171_assistant_spine_cg",
    "ke_spine_idle",
    "1601171_assistant",
    1601171,
    10,
    common[1]
  },
  [50049] = {
    50049,
    "1602163_assistant_spine_cg",
    "xuanjipifu_n41_spine_idle",
    "1602163_assistant",
    1602161,
    10,
    common[1],
    nil,
    92163
  },
  [50050] = {
    50050,
    "1502241_assistant_spine_cg",
    "luosong_n41_spine_idle",
    "1502241_assistant",
    1502241,
    1,
    common[1]
  },
  [50053] = {
    50053,
    "1601164_assistant_spine_cg",
    "fulaoeryongzhuang_CN13_spine_idle",
    "1601164_assistant",
    1601161,
    1,
    common[1],
    nil,
    91164
  },
  [50066] = {
    50066,
    "1602291_assistant_spine_cg",
    "batiya_n46_spine_idle",
    "1602291_assistant",
    1602291,
    11,
    common[1]
  },
  [50067] = {
    50067,
    "1601991_assistant_spine_cg",
    "yingge_n24_spine_idle",
    "1601991_assistant",
    1601991,
    11,
    common[1]
  },
  [50068] = {
    50068,
    "1501761_assistant_spine_cg",
    "beierta_n17_spine_idle",
    "1501761_assistant",
    1501761,
    11,
    common[1]
  },
  [50069] = {
    50069,
    "1601993_assistant_spine_cg",
    "yinggepifu_n46_spine_idle",
    "1601993_assistant",
    1601991,
    1,
    common[1],
    nil,
    91993
  },
  [50076] = {
    50076,
    "1601751_assistant_spine_cg",
    "akexiya_n24_spine_idle",
    "1601751_assistant",
    1601751,
    11,
    common[1]
  },
  [50077] = {
    50077,
    common[4],
    common[5],
    common[6],
    1500421,
    1,
    common[1],
    nil,
    90424
  },
  [50078] = {
    50078,
    common[4],
    common[5],
    common[6],
    1601551,
    1,
    common[1],
    nil,
    91553
  },
  [600001] = {
    600001,
    "1601563_assistant_spine_cg",
    "ninabalei_n35_spine_idle",
    "1601563_assistant",
    1601561,
    1,
    common[1],
    nil,
    91563
  },
  [600002] = {
    600002,
    "1601203_assistant_spine_cg",
    "haidizhianguan_n23_spine_idle",
    "1601203_assistant",
    1601201,
    1,
    common[1],
    nil,
    91203
  },
  [600003] = {
    600003,
    "1500843_assistant_spine_cg",
    "yisitawanxiuxian_n15_spine_idle",
    "1500843_assistant",
    1500841,
    1,
    common[1],
    nil,
    90843
  },
  [600004] = {
    600004,
    "1601484_assistant_spine_cg",
    "qingtongshiwusuo_n29_spine_idle",
    "1601484_assistant",
    1601481,
    1,
    "Story_norm2",
    nil,
    91484
  },
  [600005] = {
    600005,
    "1400163_assistant_spine_cg",
    "kafukapifu_n37_spine_idle",
    "1400163_assistant",
    1400161,
    1,
    common[1],
    nil,
    90163
  },
  [600006] = {
    600006,
    "1501653_assistant_spine_cg",
    "qierpifu_n37_spine_idle",
    "1501653_assistant",
    1501651,
    1,
    common[1],
    nil,
    91653
  },
  [600007] = {
    600007,
    "1500123_assistant_spine_cg",
    "naimixisiouxiang_n25_spine_idle",
    "1500123_assistant",
    1500121,
    1,
    common[1],
    nil,
    90123
  },
  [600008] = {
    600008,
    "1601313_assistant_spine_cg",
    "nuoweiyaouxiang_n25_spine_idle",
    "1601313_assistant",
    1601311,
    1,
    common[1],
    nil,
    91313
  },
  [600009] = {
    600009,
    "1600283_assistant_spine_cg",
    "lafeiernvpu_n18_spine_idle",
    "1600283_assistant",
    1600281,
    1,
    common[1],
    nil,
    90283
  },
  [600010] = {
    600010,
    "1600013_assistant_spine_cg",
    "naxilisilifu_n9_spine_idle",
    "1600013_assistant",
    1600011,
    1,
    common[1],
    nil,
    90013
  },
  [600011] = {
    600011,
    "1600603_assistant_spine_cg",
    "yuenacaipan_n15_spine_idle",
    "1600603_assistant",
    1600601,
    1,
    common[1],
    nil,
    90603
  },
  [600013] = {
    600013,
    "1601053_assistant_spine_cg",
    "yifuticao_n11_spine_idle",
    "1601053_assistant",
    1601051,
    1,
    common[1],
    nil,
    91053
  },
  [600014] = {
    600014,
    "1600643_assistant_spine_cg",
    "leitingqipao_n13_spine_idle",
    "1600643_assistant",
    1600641,
    1,
    common[1],
    nil,
    90643
  },
  [600015] = {
    600015,
    "1602141_assistant_spine_cg",
    "libeika_n37_spine_idle",
    "1602141_assistant",
    1602141,
    10,
    common[1]
  },
  [600016] = {
    600016,
    "1502151_assistant_spine_cg",
    "yisha_n37_spine_idle",
    "1502151_assistant",
    1502151,
    10,
    common[1]
  },
  [600017] = {
    600017,
    "1601663_assistant_spine_cg",
    "feiyazhentan_n29_spine_idle",
    "1601663_assistant",
    1601661,
    1,
    common[1],
    nil,
    91663
  },
  [600018] = {
    600018,
    "1400483_assistant_spine_cg",
    "liequezhentan_n29_spine_idle",
    "1400483_assistant",
    1400481,
    1,
    common[1],
    nil,
    90483
  },
  [600019] = {
    600019,
    "1602181_assistant_spine_cg",
    "she_spine_idle",
    "1602181_assistant",
    1602181,
    11,
    common[1]
  },
  [600020] = {
    600020,
    "1602191_assistant_spine_cg",
    "yisitawansp_n39_spine_idle",
    "1602191_assistant",
    1602191,
    11,
    common[1]
  },
  [600021] = {
    600021,
    "1400733_assistant_spine_cg",
    "padipaxi_guofu_spine_idle",
    "1400733_assistant",
    1400731,
    1,
    common[1],
    nil,
    90733
  },
  [600023] = {
    600023,
    "1600773_assistant_spine_cg",
    "bolihenggeshou_n25_spine_idle",
    "1600773_assistant",
    1600771,
    1,
    common[1],
    nil,
    90773
  },
  [600024] = {
    600024,
    "1601034_assistant_spine_cg",
    "aixizhentan_n29_spine_idle",
    "1601034_assistant",
    1601031,
    1,
    common[1],
    nil,
    91034
  },
  [600025] = {
    600025,
    "1600383_assistant_spine_cg",
    "gonglushengdan_n9_spine_idle",
    "1600383_assistant",
    1600381,
    1,
    common[1],
    nil,
    90383
  },
  [600026] = {
    600026,
    "1500703_assistant_spine_cg",
    "liaonayongzhuang_n20_spine_idle",
    "1500703_assistant",
    1500701,
    1,
    common[1],
    nil,
    90703
  },
  [600027] = {
    600027,
    "1601293_assistant_spine_cg",
    "lukeyongzhuang_n21_spine_idle",
    "1601293_assistant",
    1601291,
    1,
    common[1],
    nil,
    91293
  },
  [600028] = {
    600028,
    "1601483_assistant_spine_cg",
    "qingtongyongzhuang_n22_spine_idle",
    "1601483_assistant",
    1601481,
    1,
    common[1],
    nil,
    91483
  },
  [600029] = {
    600029,
    "1601403_assistant_spine_cg",
    "fuluolinyongzhuang_n31_spine_idle",
    "1601403_assistant",
    1601401,
    1,
    common[1],
    nil,
    91403
  },
  [600030] = {
    600030,
    "1601153_assistant_spine_cg",
    "nanusaieryongzhuang_n33_spine_idle",
    "1601153_assistant",
    1601151,
    1,
    common[1],
    nil,
    91153
  },
  [600031] = {
    600031,
    "1601311_assistant_spine_cg",
    "nuoweiya_n9_spine_idle",
    "1601311_assistant",
    1601311,
    11,
    common[2]
  },
  [600032] = {
    600032,
    "1601723_assistant_spine_cg",
    "lilikashengdan_n39_spine_idle",
    "1601723_assistant",
    1601721,
    1,
    common[1],
    nil,
    91723
  },
  [600033] = {
    600033,
    "1601291_assistant_spine_cg",
    "xitelu_n7_spine_idle",
    "1601291_assistant",
    1601291,
    11,
    common[1]
  },
  [600034] = {
    600034,
    "1601261_assistant_spine_cg",
    "beifeier_n7_spine_idle",
    "1601261_assistant",
    1601261,
    11,
    common[1]
  },
  [600035] = {
    600035,
    "1601263_assistant_spine_cg",
    "beifeierzhentan_n17_spine_idle",
    "1601263_assistant",
    1601261,
    1,
    common[1],
    nil,
    91263
  },
  [600036] = {
    600036,
    "1500551_assistant_spine_cg",
    "weien_spine_idle",
    "1500551_assistant",
    1500551,
    11,
    common[1]
  },
  [600037] = {
    600037,
    "1500553_assistant_spine_cg",
    "biyatamanbaiqing_n27_spine_idle",
    "1500553_assistant",
    1500551,
    1,
    common[1],
    nil,
    90553
  },
  [600038] = {
    600038,
    "1601703_assistant_spine_cg",
    "polakexiunv_n38_spine_idle",
    "1601703_assistant",
    1601701,
    1,
    common[1],
    nil,
    91703
  },
  [600040] = {
    600040,
    "1600263_assistant_spine_cg",
    "wulieerwenxue_n11_spine_idle",
    "1600263_assistant",
    1600261,
    1,
    common[1],
    nil,
    90263
  },
  [600041] = {
    600041,
    "1500994_assistant_spine_cg",
    "aileiyapifu_S4_spine_idle",
    "1500994_assistant",
    1500991,
    1,
    common[1],
    nil,
    90994
  },
  [600043] = {
    600043,
    "1400913_assistant_spine_cg",
    "keluoyibaiqing_n27_spine_idle",
    "1400913_assistant",
    1400911,
    1,
    common[1],
    nil,
    90913
  },
  [600044] = {
    600044,
    "1602211_assistant_spine_cg",
    "aergeer_n24_spine_idle",
    "1602211_assistant",
    1602211,
    11,
    common[1]
  },
  [600045] = {
    600045,
    "1401273_assistant_spine_cg",
    "pasuoluopifu_n41_spine_idle",
    "1401273_assistant",
    1401271,
    1,
    common[1],
    nil,
    91273
  },
  [600046] = {
    600046,
    "1500093_assistant_spine_cg",
    "fushidepifu_n41_spine_idle",
    "1500093_assistant",
    1500091,
    1,
    common[1],
    nil,
    90093
  },
  [600047] = {
    600047,
    "1600774_assistant_spine_cg",
    "bolihengyongzhuang_n34_spine_idle",
    "1600774_assistant",
    1600771,
    1,
    common[1],
    nil,
    90774
  },
  [600048] = {
    600048,
    "1601783_assistant_spine_cg",
    "weikeyongzhuang_n34_spine_idle",
    "1601783_assistant",
    1601781,
    1,
    common[1],
    nil,
    91783
  },
  [600049] = {
    600049,
    "1600893_assistant_spine_cg",
    "yiluntinghefu_n13_spine_idle",
    "1600893_assistant",
    1600891,
    1,
    common[1],
    nil,
    90893
  },
  [600050] = {
    600050,
    "1601861_assistant_spine_cg",
    "dina_n27_spine_idle",
    "1601861_assistant",
    1601861,
    11,
    common[1]
  },
  [600051] = {
    600051,
    "1601891_assistant_spine_cg",
    "lingen_n28_spine_idle",
    "1601891_assistant",
    1601891,
    11,
    common[1]
  },
  [600052] = {
    600052,
    "1601381_assistant_spine_cg",
    "xinuopu_n11_spine_idle",
    "1601381_assistant",
    1601381,
    11,
    common[1]
  },
  [600053] = {
    600053,
    "1601383_assistant_spine_cg",
    "xinuopuouxiang_n26_spine_idle",
    "1601383_assistant",
    1601381,
    1,
    common[1],
    nil,
    91383
  },
  [600054] = {
    600054,
    "1601673_assistant_spine_cg",
    "jienuobaiqing_n27_spine_idle",
    "1601673_assistant",
    1601671,
    1,
    common[1],
    nil,
    91673
  },
  [600055] = {
    600055,
    "1601433_assistant_spine_cg",
    "linyinmonv_n32_spine_idle",
    "1601433_assistant",
    1601431,
    1,
    common[1],
    nil,
    91433
  },
  [600056] = {
    600056,
    "1501901_assistant_spine_cg",
    "matai_n20_spine_idle",
    "1501901_assistant",
    1501901,
    11,
    common[1]
  },
  [600057] = {
    600057,
    "1600264_assistant_spine_cg",
    "wulieernvwu_S5_spine_idle",
    "1600264_assistant",
    1600261,
    1,
    common[1],
    nil,
    90264
  },
  [600058] = {
    600058,
    "1601753_assistant_spine_cg",
    "akexiyabinghao_n42_spine_idle",
    "1601753_assistant",
    1601751,
    1,
    common[1],
    nil,
    91753
  },
  [600059] = {
    600059,
    "1601401_assistant_spine_cg",
    "fuluolin_n11_spine_idle",
    "1601401_assistant",
    1601401,
    11,
    common[1]
  },
  [600060] = {
    600060,
    "1602251_assistant_spine_cg",
    "tiyala_n17_spine_idle",
    "1602251_assistant",
    1602251,
    11,
    common[1]
  },
  [600061] = {
    600061,
    "1602071_assistant_spine_cg",
    "xinan_n31_spine_idle",
    "1602071_assistant",
    1602071,
    11,
    common[1]
  },
  [600062] = {
    600062,
    "1600114_assistant_spine_cg",
    "xiluonahunsha_n43_spine_idle",
    "1600114_assistant",
    1600111,
    1,
    common[1],
    nil,
    90114
  },
  [600063] = {
    600063,
    "1401013_assistant_spine_cg",
    "anxiyapifu_N43_spine_idle",
    "1401013_assistant",
    1401011,
    1,
    common[1],
    nil,
    91013
  },
  [600064] = {
    600064,
    "1500783_assistant_spine_cg",
    "zhigengpifu_n43_spine_idle",
    "1500783_assistant",
    1500781,
    1,
    common[1],
    nil,
    90783
  },
  [600065] = {
    600065,
    "1501491_assistant_spine_cg",
    "luoyi_n15_spine_idle",
    "1501491_assistant",
    1501491,
    11,
    common[1]
  },
  [600066] = {
    600066,
    "1601771_assistant_spine_cg",
    "geerdi_n23_spine_idle",
    "1601771_assistant",
    1601771,
    11,
    common[1]
  },
  [600067] = {
    600067,
    "1601781_assistant_spine_cg",
    "weike_n19_spine_idle",
    "1601781_assistant",
    1601781,
    11,
    common[1]
  },
  [600068] = {
    600068,
    "1602041_assistant_spine_cg",
    "yueshuya_n31_spine_idle",
    "1602041_assistant",
    1602041,
    11,
    common[1]
  },
  [600070] = {
    600070,
    "1601773_assistant_spine_cg",
    "geerdipifu_n44_spine_idle",
    "1601773_assistant",
    1601771,
    1,
    common[1],
    nil,
    91773
  },
  [600071] = {
    600071,
    "1602091_assistant_spine_cg",
    "leitingsp_n34_spine_idle",
    "1602091_assistant",
    1602091,
    11,
    common[1]
  },
  [600072] = {
    600072,
    "1602271_assistant_spine_cg",
    "leiqieer_n45_spine_idle",
    "1602271_assistant",
    1602271,
    11,
    common[1]
  },
  [600073] = {
    600073,
    "1601841_assistant_spine_cg",
    "yeliya_n27_spine_idle",
    "1601841_assistant",
    1601841,
    11,
    common[1]
  },
  [600074] = {
    600074,
    "1601823_assistant_spine_cg",
    "muyuebaipifu_n45_spine_idle",
    "1601823_assistant",
    1601821,
    1,
    common[1],
    nil,
    91823
  },
  [600075] = {
    600075,
    "1602233_assistant_spine_cg",
    "chennipifu_N45_spine_idle",
    "1602233_assistant",
    1602231,
    1,
    common[1],
    nil,
    92233
  },
  [600076] = {
    600076,
    "1400403_assistant_spine_cg",
    "bibibiyueenpifu_n45_spine_idle",
    "1400403_assistant",
    1400401,
    1,
    common[1],
    nil,
    90403
  },
  [600077] = {
    600077,
    "1500363_assistant_spine_cg",
    "xiuladepifu_n45_spine_idle",
    "1500363_assistant",
    1500361,
    1,
    common[1],
    nil,
    90363
  },
  [600078] = {
    600078,
    "1500924_assistant_spine_cg",
    "qifapifu_S6_spine_idle",
    "1500924_assistant",
    1500921,
    2,
    common[1],
    nil,
    90924
  },
  [600079] = {
    600079,
    "1601531_assistant_spine_cg",
    "qiguanglaoda_spine_idle",
    "1601531_assistant",
    1601531,
    11,
    common[1]
  },
  [600080] = {
    600080,
    "1601551_assistant_spine_cg",
    "badunyige_n17_spine_idle",
    "1601551_assistant",
    1601551,
    11,
    common[1]
  },
  [600082] = {
    600082,
    "1601843_assistant_spine_cg",
    "yeliyayongzhuang_n47_spine_idle",
    "1601843_assistant",
    1601841,
    1,
    common[1],
    nil,
    91843
  },
  [600083] = {
    600083,
    "1601533_assistant_spine_cg",
    "laiyinhatelifu_n47_spine_idle",
    "1601533_assistant",
    1601531,
    1,
    common[1],
    nil,
    91533
  },
  [600085] = {
    600085,
    "1500903_assistant_spine_cg",
    "babalayongzhuang_n47_spine_idle",
    "1500903_assistant",
    1500901,
    1,
    common[1],
    nil,
    90903
  },
  [600086] = {
    600086,
    "1400173_assistant_spine_cg",
    "labiyongzhuang_n47_spine_idle",
    "1400173_assistant",
    1400171,
    1,
    common[1],
    nil,
    90173
  },
  [600087] = {
    600087,
    "1602301_assistant_spine_cg",
    "weiduoliyamuge_n48_spine_idle",
    "1602301_assistant",
    1602301,
    11,
    common[1]
  },
  [600088] = {
    600088,
    "1602011_assistant_spine_cg",
    "miyasp1_n31_spine_idle",
    "1602011_assistant",
    1602011,
    11,
    common[1]
  },
  [600089] = {
    600089,
    "1602311_assistant_spine_cg",
    "weilian_n48_spine_idle",
    "1602311_assistant",
    1602311,
    11,
    common[1]
  },
  [600090] = {
    600090,
    "1601863_assistant_spine_cg",
    "dinapifu_n43_spine_idle",
    "1601863_assistant",
    1601861,
    1,
    common[1],
    nil,
    91863
  },
  [600091] = {
    600091,
    "1602314_assistant_spine_cg",
    "pulvmayongzhuang_n33_spine_idle",
    "1602314_assistant",
    1601211,
    1,
    common[1],
    nil,
    91214
  },
  [600093] = {
    600093,
    "1602331_assistant_spine_cg",
    "laisha_n49_spine_idle",
    "1602331_assistant",
    1602331,
    11,
    common[1]
  },
  [600094] = {
    600094,
    "1602341_assistant_spine_cg",
    "keluodiya_n49_spine_idle",
    "1602341_assistant",
    1602341,
    11,
    common[1]
  },
  [600095] = {
    600095,
    "1502351_assistant_spine_cg",
    "patelixia_n49_spine_idle",
    "1502351_assistant",
    1502351,
    11,
    common[1]
  },
  [600096] = {
    600096,
    "1602333_assistant_spine_cg",
    "laishayongzhuang_n49_spine_idle",
    "1602333_assistant",
    1602331,
    1,
    common[1],
    nil,
    92333
  },
  [600097] = {
    600097,
    "1501903_assistant_spine_cg",
    "mataiyongzhuang_n49_spine_idle",
    "1501903_assistant",
    1501901,
    1,
    common[1],
    nil,
    91903
  },
  [600098] = {
    600098,
    "1501003_assistant_spine_cg",
    "xikaleiyongzhuang_n49_spine_idle",
    "1501003_assistant",
    1501001,
    1,
    common[1],
    nil,
    91004
  },
  [600099] = {
    600099,
    "1500213_assistant_spine_cg",
    "youlayongzhuang_n49_spine_idle",
    "1500213_assistant",
    1500211,
    1,
    common[1],
    nil,
    90213
  },
  [600100] = {
    600100,
    "1602273_assistant_spine_cg",
    "leiqieeryongzhuang_n50_spine_idle",
    "1602273_assistant",
    1602271,
    1,
    common[1],
    nil,
    92273
  },
  [600101] = {
    600101,
    "1602371_assistant_spine_cg",
    "moye_n50_spine_idle",
    "1602371_assistant",
    1602371,
    11,
    common[1]
  },
  [600200] = {
    600200,
    "1600014_assistant_spine_cg",
    "naxilisisaiji_s8_spine_idle",
    "1600014_assistant",
    1600011,
    1,
    common[1],
    nil,
    90014
  },
  [800001] = {
    800001,
    "1500973_assistant_spine_cg",
    "dupifu_n51_spine_idle",
    "1500973_assistant",
    1500971,
    1,
    common[1],
    nil,
    90973
  },
  [800002] = {
    800002,
    "1400953_assistant_spine_cg",
    "laisite_n51_spine_idle",
    "1400953_assistant",
    1400951,
    1,
    common[1],
    nil,
    90953
  },
  [800003] = {
    800003,
    "1601733_assistant_spine_cg",
    "miluosipifu_n51_spine_idle",
    "1601733_assistant",
    1601731,
    1,
    common[1],
    nil,
    91733
  },
  [800004] = {
    800004,
    "1602183_assistant_spine_cg",
    "she_n51_spine_idle",
    "1602183_assistant",
    1602181,
    1,
    common[1],
    nil,
    92183
  },
  [800005] = {
    800005,
    "1602381_assistant_spine_cg",
    "mitela_n51_spine_idle",
    "1602381_assistant",
    1602381,
    11,
    common[1]
  }
}
return config, "ID", key
