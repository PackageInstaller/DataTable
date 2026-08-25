local System = require("System.System")
local readonly = System.readonly
local MapTileMaterial = readonly({
  [18695] = {
    ID = 18695,
    CnID = "材质@测试1",
    BaseSortID = 1,
    data_list = readonly({
      readonly({
        BaseSortID = 1,
        [11] = "地图用",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/MUnit_Grid_M0001/MUnit_Grid_M0001.prefab"
      })
    })
  },
  [18693] = {
    ID = 18693,
    CnID = "材质@测试2",
    BaseSortID = 2,
    data_list = readonly({
      readonly({
        BaseSortID = 2,
        [11] = "测试2随机2",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/MUnit_Grid_M0002/MUnit_Grid_M0002.prefab"
      })
    })
  },
  [18694] = {
    ID = 18694,
    CnID = "材质@测试3",
    BaseSortID = 3,
    data_list = readonly({
      readonly({
        BaseSortID = 3,
        [11] = "测试3随机1",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/MUnit_Grid_M0001/MUnit_Grid_M0001.prefab"
      }),
      readonly({
        [11] = "测试3随机2",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/MUnit_Grid_M0002/MUnit_Grid_M0002.prefab"
      })
    })
  },
  [18699] = {
    ID = 18699,
    CnID = "材质@脆弱通路",
    BaseSortID = 4,
    data_list = readonly({
      readonly({
        BaseSortID = 4,
        [11] = "脆弱通路专用",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/MUnit_Grid_M0005/MUnit_Grid_M0005.prefab"
      })
    })
  },
  [18692] = {
    ID = 18692,
    CnID = "材质@毒气通路",
    BaseSortID = 5,
    data_list = readonly({
      readonly({
        BaseSortID = 5,
        [11] = "毒气通路专用",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0008.prefab",
        Effect = "Effects/CommonPrefab/E_Co_PoisoningFloor.prefab",
        Trigger = 2
      })
    })
  },
  [49057] = {
    ID = 49057,
    CnID = "材质@血池",
    BaseSortID = 6,
    data_list = readonly({
      readonly({
        BaseSortID = 6,
        [11] = "血池专用",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0008a.prefab"
      })
    })
  },
  [18697] = {
    ID = 18697,
    CnID = "材质@测试4",
    BaseSortID = 7,
    data_list = readonly({
      readonly({
        BaseSortID = 7,
        [11] = "测试4随机1",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0003.prefab"
      }),
      readonly({
        [11] = "测试4随机2",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0004.prefab"
      })
    })
  },
  [18698] = {
    ID = 18698,
    CnID = "材质@测试5",
    BaseSortID = 8,
    data_list = readonly({
      readonly({
        BaseSortID = 8,
        [11] = "测试5随机1",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0006.prefab"
      }),
      readonly({
        [11] = "测试5随机2",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0007.prefab"
      })
    })
  },
  [18696] = {
    ID = 18696,
    CnID = "材质@测试6",
    BaseSortID = 9,
    data_list = readonly({
      readonly({
        BaseSortID = 9,
        [11] = "测试6随机1",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0007.prefab"
      }),
      readonly({
        [11] = "测试6随机2",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0009.prefab"
      })
    })
  },
  [19966] = {
    ID = 19966,
    CnID = "材质@3_1",
    BaseSortID = 10,
    data_list = readonly({
      readonly({
        BaseSortID = 10,
        [11] = "关卡3_1随机1",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/MUnit_Grid_M0002/MUnit_Grid_M0002.prefab"
      }),
      readonly({
        [11] = "关卡3_1随机2",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0007.prefab"
      })
    })
  },
  [20232] = {
    ID = 20232,
    CnID = "材质@3_2",
    BaseSortID = 11,
    data_list = readonly({
      readonly({
        BaseSortID = 11,
        [11] = "关卡3_2随机1",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0004.prefab"
      }),
      readonly({
        [11] = "关卡3_2随机2",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0006.prefab"
      })
    })
  },
  [21810] = {
    ID = 21810,
    CnID = "材质@5_1",
    BaseSortID = 12,
    data_list = readonly({
      readonly({
        BaseSortID = 12,
        [11] = "关卡5_1随机1",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M00010.prefab"
      })
    })
  },
  [23645] = {
    ID = 23645,
    CnID = "材质@大型支线莉莉1",
    BaseSortID = 13,
    data_list = readonly({
      readonly({
        BaseSortID = 13,
        [11] = "大型支线莉莉1",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0003.prefab"
      })
    })
  },
  [35652] = {
    ID = 35652,
    CnID = "材质@大型支线莉莉剧本迷思1",
    BaseSortID = 14,
    data_list = readonly({
      readonly({
        BaseSortID = 14,
        [11] = "材质@大型支线莉莉剧本迷思1",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/MUnit_Grid_M0001/MUnit_Grid_M0001.prefab"
      }),
      readonly({
        [11] = "材质@大型支线莉莉剧本迷思1",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/MUnit_Grid_M0002/MUnit_Grid_M0002.prefab"
      })
    })
  },
  [35651] = {
    ID = 35651,
    CnID = "材质@大型支线莉莉剧本迷思2",
    BaseSortID = 15,
    data_list = readonly({
      readonly({
        BaseSortID = 15,
        [11] = "材质@大型支线莉莉剧本迷思2",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0004.prefab"
      }),
      readonly({
        [11] = "材质@大型支线莉莉剧本迷思2",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0006.prefab"
      })
    })
  },
  [35650] = {
    ID = 35650,
    CnID = "材质@大型支线莉莉剧本迷思3",
    BaseSortID = 16,
    data_list = readonly({
      readonly({
        BaseSortID = 16,
        [11] = "材质@大型支线莉莉剧本迷思3",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0007.prefab"
      }),
      readonly({
        [11] = "材质@大型支线莉莉剧本迷思3",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0009.prefab"
      })
    })
  },
  [35661] = {
    ID = 35661,
    CnID = "材质@大型支线莉莉剧本迷思通用",
    BaseSortID = 17,
    data_list = readonly({
      readonly({
        BaseSortID = 17,
        [11] = "材质@大型支线莉莉剧本迷思通用",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0006.prefab"
      })
    })
  },
  [36888] = {
    ID = 36888,
    CnID = "材质@新版地块材质测试11_16",
    BaseSortID = 18,
    data_list = readonly({
      readonly({
        BaseSortID = 18,
        [11] = "材质@新版地块材质测试11_16",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0011.prefab"
      }),
      readonly({
        [11] = "材质@新版地块材质测试11_16",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0012.prefab"
      }),
      readonly({
        [11] = "材质@新版地块材质测试11_16",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0013.prefab"
      }),
      readonly({
        [11] = "材质@新版地块材质测试11_16",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0014.prefab"
      }),
      readonly({
        [11] = "材质@新版地块材质测试11_16",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0014a.prefab"
      }),
      readonly({
        [11] = "材质@新版地块材质测试11_16",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0015.prefab"
      }),
      readonly({
        [11] = "材质@新版地块材质测试11_16",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0016.prefab"
      })
    })
  },
  [49849] = {
    ID = 49849,
    CnID = "材质@第七章通用",
    BaseSortID = 19,
    data_list = readonly({
      readonly({
        BaseSortID = 19,
        [11] = "材质@第七章通用",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0014.prefab"
      }),
      readonly({
        [11] = "材质@第七章通用",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0014a.prefab"
      })
    })
  },
  [49848] = {
    ID = 49848,
    CnID = "材质@第七章678",
    BaseSortID = 20,
    data_list = readonly({
      readonly({
        BaseSortID = 20,
        [11] = "材质@第七章678",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0012.prefab"
      }),
      readonly({
        [11] = "材质@第七章678",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0013.prefab"
      })
    })
  },
  [59162] = {
    ID = 59162,
    CnID = "材质@第八章第九章通用",
    BaseSortID = 21,
    data_list = readonly({
      readonly({
        BaseSortID = 21,
        [11] = "材质@第八章第九章",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0015.prefab"
      })
    })
  },
  [59163] = {
    ID = 59163,
    CnID = "材质@第八章第九章通用_监视",
    BaseSortID = 22,
    data_list = readonly({
      readonly({
        BaseSortID = 22,
        [11] = "材质@第八章第九章通用_监视",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0015.prefab"
      })
    })
  },
  [60840] = {
    ID = 60840,
    CnID = "材质@第八章音乐教室",
    BaseSortID = 23,
    data_list = readonly({
      readonly({
        BaseSortID = 23,
        [11] = "材质@第八章第九章",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0016.prefab"
      })
    })
  },
  [60841] = {
    ID = 60841,
    CnID = "材质@8_5",
    BaseSortID = 24,
    data_list = readonly({
      readonly({
        BaseSortID = 24,
        [11] = "关卡5_1随机1",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/MUnit_Grid_M0001/MUnit_Grid_M0001.prefab"
      })
    })
  },
  [62301] = {
    ID = 62301,
    CnID = "材质@大型支线本源希洛",
    BaseSortID = 25,
    data_list = readonly({
      readonly({
        BaseSortID = 25,
        [11] = "大型支线本源希洛",
        Weight = 100,
        Path = "MUnit/MUnit_02/Grid/Common/Prefab/MUnit_Grid_M0009.prefab"
      })
    })
  }
})
return MapTileMaterial
