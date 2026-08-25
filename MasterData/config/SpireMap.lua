local System = require("System.System")
local readonly = System.readonly
local SpireMap = readonly({
  [116377] = {
    ID = 116377,
    CnID = "尖塔地图@1层",
    BaseSortID = 1,
    data_list = readonly({
      readonly({
        BaseSortID = 1,
        MapTitle = "SpireMap_116377_MapTitle_1|第一阶段 塔底",
        Sort = 1,
        EnterMapCmd = 116390,
        ClearMapCmd = 116379,
        Size = {6, 16},
        Type = 1,
        StartLine = 1,
        EndLine = 15,
        Quantity = {2},
        NodeType = {116365}
      }),
      readonly({
        Type = 2,
        StartLine = 1,
        EndLine = 15,
        Quantity = {0.5, 1},
        NodeType = {116365}
      }),
      readonly({
        Type = 1,
        StartLine = 16,
        EndLine = 16,
        Quantity = {1},
        NodeType = {
          116364,
          116369,
          116370
        }
      }),
      readonly({
        Type = 3,
        StartLine = 1,
        EndLine = 14,
        Quantity = {
          1,
          1,
          1
        }
      }),
      readonly({
        Type = 4,
        StartLine = 2,
        EndLine = 14,
        Quantity = {
          1,
          0,
          1
        }
      }),
      readonly({
        Type = 4,
        StartLine = 16,
        EndLine = 16,
        Quantity = {
          6,
          1,
          1
        }
      }),
      readonly({
        Type = 5,
        StartLine = 9,
        EndLine = 9,
        Quantity = {1},
        NodeType = {116365, 116367}
      }),
      readonly({
        Type = 5,
        StartLine = 15,
        EndLine = 15,
        Quantity = {1},
        NodeType = {116365, 116363}
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.05},
        NodeType = {116365, 100547},
        AdjacentExclusion = 1,
        RowExclusion = {1},
        FirstBonus = 3,
        AggregationBonus = 3,
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.13},
        NodeType = {116365, 116366},
        AdjacentExclusion = 1,
        RowExclusion = {
          1,
          2,
          3
        },
        ColumnLimit = 2,
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.1},
        NodeType = {116365, 116362},
        AdjacentExclusion = 1,
        RowExclusion = {
          1,
          2,
          3
        },
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.2},
        NodeType = {116365, 116363},
        RowExclusion = {1},
        SupplementaryBonus = 3
      }),
      readonly({
        Condition = "FinaleMod==1",
        Type = 6,
        StartLine = 1,
        EndLine = 14,
        Quantity = {1},
        NodeType = {116366, 116368}
      })
    })
  },
  [116378] = {
    ID = 116378,
    CnID = "尖塔地图@2层",
    BaseSortID = 2,
    data_list = readonly({
      readonly({
        BaseSortID = 2,
        MapTitle = "SpireMap_116378_MapTitle_1|第二阶段 塔中",
        Sort = 2,
        ClearMapCmd = 116381,
        Size = {6, 16},
        Type = 1,
        StartLine = 1,
        EndLine = 15,
        Quantity = {2},
        NodeType = {116365}
      }),
      readonly({
        Type = 2,
        StartLine = 1,
        EndLine = 15,
        Quantity = {0.5, 1},
        NodeType = {116365}
      }),
      readonly({
        Type = 1,
        StartLine = 16,
        EndLine = 16,
        Quantity = {1},
        NodeType = {
          116364,
          116369,
          116370
        }
      }),
      readonly({
        Type = 3,
        StartLine = 1,
        EndLine = 14,
        Quantity = {
          1,
          1,
          1
        }
      }),
      readonly({
        Type = 4,
        StartLine = 2,
        EndLine = 14,
        Quantity = {
          1,
          0,
          1
        }
      }),
      readonly({
        Type = 4,
        StartLine = 16,
        EndLine = 16,
        Quantity = {
          6,
          1,
          1
        }
      }),
      readonly({
        Type = 5,
        StartLine = 9,
        EndLine = 9,
        Quantity = {1},
        NodeType = {116365, 116367}
      }),
      readonly({
        Type = 5,
        StartLine = 15,
        EndLine = 15,
        Quantity = {1},
        NodeType = {116365, 116363}
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.05},
        NodeType = {116365, 100547},
        AdjacentExclusion = 1,
        RowExclusion = {1},
        FirstBonus = 3,
        AggregationBonus = 3,
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.13},
        NodeType = {116365, 116366},
        AdjacentExclusion = 1,
        RowExclusion = {
          1,
          2,
          3
        },
        ColumnLimit = 2,
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.1},
        NodeType = {116365, 116362},
        AdjacentExclusion = 1,
        RowExclusion = {
          1,
          2,
          3
        },
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.2},
        NodeType = {116365, 116363},
        RowExclusion = {1},
        SupplementaryBonus = 3
      }),
      readonly({
        Condition = "FinaleMod==1",
        Type = 6,
        StartLine = 1,
        EndLine = 14,
        Quantity = {1},
        NodeType = {116366, 116368}
      })
    })
  },
  [116376] = {
    ID = 116376,
    CnID = "尖塔地图@3层",
    BaseSortID = 3,
    data_list = readonly({
      readonly({
        BaseSortID = 3,
        MapTitle = "SpireMap_116376_MapTitle_1|第三阶段 塔顶",
        Sort = 3,
        ClearMapCmd = 116380,
        Size = {6, 16},
        Type = 1,
        StartLine = 1,
        EndLine = 15,
        Quantity = {2},
        NodeType = {116365}
      }),
      readonly({
        Type = 2,
        StartLine = 1,
        EndLine = 15,
        Quantity = {0.5, 1},
        NodeType = {116365}
      }),
      readonly({
        Type = 1,
        StartLine = 16,
        EndLine = 16,
        Quantity = {1},
        NodeType = {
          116364,
          116369,
          116370
        }
      }),
      readonly({
        Type = 3,
        StartLine = 1,
        EndLine = 14,
        Quantity = {
          1,
          1,
          1
        }
      }),
      readonly({
        Type = 4,
        StartLine = 2,
        EndLine = 14,
        Quantity = {
          1,
          0,
          1
        }
      }),
      readonly({
        Type = 4,
        StartLine = 16,
        EndLine = 16,
        Quantity = {
          6,
          1,
          1
        }
      }),
      readonly({
        Type = 5,
        StartLine = 9,
        EndLine = 9,
        Quantity = {1},
        NodeType = {116365, 116367}
      }),
      readonly({
        Type = 5,
        StartLine = 15,
        EndLine = 15,
        Quantity = {1},
        NodeType = {116365, 116363}
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.05},
        NodeType = {116365, 100547},
        AdjacentExclusion = 1,
        RowExclusion = {1},
        FirstBonus = 3,
        AggregationBonus = 3,
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.13},
        NodeType = {116365, 116366},
        AdjacentExclusion = 1,
        RowExclusion = {
          1,
          2,
          3
        },
        ColumnLimit = 2,
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.1},
        NodeType = {116365, 116362},
        AdjacentExclusion = 1,
        RowExclusion = {
          1,
          2,
          3
        },
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.2},
        NodeType = {116365, 116363},
        RowExclusion = {1},
        SupplementaryBonus = 3
      }),
      readonly({
        Condition = "FinaleMod==1",
        Type = 6,
        StartLine = 1,
        EndLine = 14,
        Quantity = {1},
        NodeType = {116366, 116368}
      })
    })
  },
  [116375] = {
    ID = 116375,
    CnID = "尖塔地图@4层",
    BaseSortID = 4,
    data_list = readonly({
      readonly({
        BaseSortID = 4,
        MapTitle = "SpireMap_116375_MapTitle_1|第四阶段 终幕",
        Sort = 4,
        Size = {6, 16},
        Type = 1,
        StartLine = 1,
        EndLine = 15,
        Quantity = {2},
        NodeType = {116365}
      }),
      readonly({
        Type = 2,
        StartLine = 1,
        EndLine = 15,
        Quantity = {0.5, 1},
        NodeType = {116365}
      }),
      readonly({
        Type = 1,
        StartLine = 16,
        EndLine = 16,
        Quantity = {1},
        NodeType = {
          116364,
          116369,
          116370
        }
      }),
      readonly({
        Type = 3,
        StartLine = 1,
        EndLine = 14,
        Quantity = {
          1,
          1,
          1
        }
      }),
      readonly({
        Type = 4,
        StartLine = 2,
        EndLine = 14,
        Quantity = {
          1,
          0,
          1
        }
      }),
      readonly({
        Type = 4,
        StartLine = 16,
        EndLine = 16,
        Quantity = {
          6,
          1,
          1
        }
      }),
      readonly({
        Type = 5,
        StartLine = 9,
        EndLine = 9,
        Quantity = {1},
        NodeType = {116365, 116367}
      }),
      readonly({
        Type = 5,
        StartLine = 15,
        EndLine = 15,
        Quantity = {1},
        NodeType = {116365, 116363}
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.05},
        NodeType = {116365, 100547},
        AdjacentExclusion = 1,
        RowExclusion = {1},
        FirstBonus = 3,
        AggregationBonus = 3,
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.13},
        NodeType = {116365, 116366},
        AdjacentExclusion = 1,
        RowExclusion = {
          1,
          2,
          3
        },
        ColumnLimit = 2,
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.1},
        NodeType = {116365, 116362},
        AdjacentExclusion = 1,
        RowExclusion = {
          1,
          2,
          3
        },
        SupplementaryBonus = 3
      }),
      readonly({
        Type = 5,
        StartLine = 1,
        EndLine = 14,
        Quantity = {0.2},
        NodeType = {116365, 116363},
        RowExclusion = {1},
        SupplementaryBonus = 3
      }),
      readonly({
        Condition = "FinaleMod==1",
        Type = 6,
        StartLine = 1,
        EndLine = 14,
        Quantity = {1},
        NodeType = {116366, 116368}
      })
    })
  }
})
return SpireMap
