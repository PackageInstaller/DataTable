local key = {
  ID = 1,
  ChapterID = 2,
  ChapterIdx = 3,
  ChapterName = 4,
  AwardStar = 5,
  AwardStarDropGroupList = 6,
  AwardItemIDList = 7,
  previewAward = 8
}
local common = {
  "str_chapter_idx_1",
  "str_chapter_1",
  {
    15,
    30,
    42
  },
  {
    8,
    16,
    21
  },
  {
    13111,
    13112,
    13113
  },
  {
    [1] = {
      StarCount = 15,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 2000}
      }
    },
    [2] = {
      StarCount = 30,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 3000}
      }
    },
    [3] = {
      StarCount = 42,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 5000},
        [3] = {ItemID = 3621003, Count = 1}
      }
    }
  },
  {
    [1] = {
      StarCount = 15,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 2000}
      }
    },
    [2] = {
      StarCount = 30,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 3000}
      }
    },
    [3] = {
      StarCount = 42,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 5000},
        [3] = {ItemID = 3621007, Count = 1}
      }
    }
  },
  {
    [1] = {
      StarCount = 8,
      AwardItemList = {
        [1] = {ItemID = 3000003, Count = 50},
        [2] = {ItemID = 3000002, Count = 2000}
      }
    },
    [2] = {
      StarCount = 16,
      AwardItemList = {
        [1] = {ItemID = 3000003, Count = 100},
        [2] = {ItemID = 3000002, Count = 3000}
      }
    },
    [3] = {
      StarCount = 21,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 5000},
        [3] = {ItemID = 3641102, Count = 1}
      }
    }
  },
  {
    [1] = {
      StarCount = 15,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 2000}
      }
    },
    [2] = {
      StarCount = 30,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 3000}
      }
    },
    [3] = {
      StarCount = 42,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 5000},
        [3] = {ItemID = 3641302, Count = 1}
      }
    }
  },
  {
    [1] = {
      StarCount = 15,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 2000}
      }
    },
    [2] = {
      StarCount = 30,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 3000}
      }
    },
    [3] = {
      StarCount = 42,
      AwardItemList = {
        [1] = {ItemID = 3000100, Count = 1},
        [2] = {ItemID = 3000002, Count = 5000},
        [3] = {ItemID = 3641402, Count = 1}
      }
    }
  }
}
local config = {
  {
    1,
    1,
    common[1],
    common[2],
    {
      27,
      36,
      48
    },
    {
      13011,
      13012,
      13013
    },
    {
      [1] = {
        StarCount = 27,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 36,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 48,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000}
        }
      }
    }
  },
  {
    2,
    2,
    common[1],
    common[2],
    common[3],
    {
      13021,
      13022,
      13023
    },
    {
      [1] = {
        StarCount = 15,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 30,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 42,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000}
        }
      }
    }
  },
  {
    3,
    3,
    common[1],
    common[2],
    common[3],
    {
      13031,
      13032,
      13033
    },
    common[6]
  },
  {
    4,
    4,
    common[1],
    common[2],
    common[3],
    {
      13041,
      13042,
      13043
    },
    {
      [1] = {
        StarCount = 15,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 30,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 42,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000},
          [3] = {ItemID = 3623003, Count = 1}
        }
      }
    }
  },
  {
    5,
    5,
    common[1],
    common[2],
    common[3],
    {
      13051,
      13052,
      13053
    },
    {
      [1] = {
        StarCount = 15,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 30,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 42,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000},
          [3] = {ItemID = 3621006, Count = 1}
        }
      }
    }
  },
  {
    6,
    6,
    common[1],
    common[2],
    common[3],
    {
      13061,
      13062,
      13063
    },
    common[7]
  },
  {
    7,
    7,
    common[1],
    common[2],
    common[3],
    {
      13071,
      13072,
      13073
    },
    {
      [1] = {
        StarCount = 15,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 30,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 42,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000},
          [3] = {ItemID = 3623001, Count = 1}
        }
      }
    }
  },
  {
    8,
    8,
    common[1],
    common[2],
    common[3],
    {
      13081,
      13082,
      13083
    },
    {
      [1] = {
        StarCount = 15,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 30,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 42,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000},
          [3] = {ItemID = 3621004, Count = 1}
        }
      }
    }
  },
  {
    9,
    9,
    common[1],
    common[2],
    common[3],
    {
      13091,
      13092,
      13093
    },
    common[7]
  },
  {
    10,
    10,
    common[1],
    common[2],
    common[3],
    {
      13101,
      13102,
      13103
    },
    common[6]
  },
  {
    11,
    11,
    common[1],
    common[2],
    common[4],
    common[5],
    common[8]
  },
  {
    12,
    12,
    common[1],
    common[2],
    common[3],
    {
      13121,
      13122,
      13123
    },
    {
      [1] = {
        StarCount = 15,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 30,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 42,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000},
          [3] = {ItemID = 3641202, Count = 1}
        }
      }
    }
  },
  {
    13,
    13,
    common[1],
    common[2],
    common[3],
    {
      13131,
      13132,
      13133
    },
    common[9]
  },
  {
    14,
    14,
    common[1],
    common[2],
    common[3],
    {
      13141,
      13142,
      13143
    },
    common[10]
  },
  {
    15,
    15,
    common[1],
    common[2],
    common[3],
    {
      13151,
      13152,
      13153
    },
    {
      [1] = {
        StarCount = 15,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 30,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 42,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000},
          [3] = {ItemID = 3641502, Count = 1}
        }
      }
    }
  },
  {
    16,
    16,
    common[1],
    common[2],
    common[3],
    {
      13161,
      13162,
      13163
    },
    {
      [1] = {
        StarCount = 15,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 30,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 42,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000},
          [3] = {ItemID = 3661207, Count = 1}
        }
      }
    }
  },
  {
    17,
    17,
    common[1],
    common[2],
    common[3],
    {
      13171,
      13172,
      13173
    },
    {
      [1] = {
        StarCount = 15,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 30,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 42,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000},
          [3] = {ItemID = 3661208, Count = 1}
        }
      }
    }
  },
  {
    18,
    18,
    common[1],
    common[2],
    common[3],
    {
      13181,
      13182,
      13183
    },
    {
      [1] = {
        StarCount = 15,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 30,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 42,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000},
          [3] = {ItemID = 3641102, Count = 1}
        }
      }
    }
  },
  {
    19,
    19,
    common[1],
    common[2],
    common[3],
    {
      13191,
      13192,
      13193
    },
    common[9]
  },
  {
    20,
    20,
    common[1],
    common[2],
    common[3],
    {
      13201,
      13202,
      13203
    },
    common[10]
  },
  {
    21,
    21,
    common[1],
    common[2],
    common[3],
    {
      13211,
      13212,
      13213
    },
    common[9]
  },
  {
    22,
    22,
    common[1],
    common[2],
    common[4],
    common[5],
    common[8]
  },
  {
    23,
    23,
    common[1],
    common[2],
    {
      12,
      24,
      33
    },
    common[5],
    {
      [1] = {
        StarCount = 12,
        AwardItemList = {
          [1] = {ItemID = 3000003, Count = 50},
          [2] = {ItemID = 3000002, Count = 2000}
        }
      },
      [2] = {
        StarCount = 24,
        AwardItemList = {
          [1] = {ItemID = 3000003, Count = 100},
          [2] = {ItemID = 3000002, Count = 3000}
        }
      },
      [3] = {
        StarCount = 33,
        AwardItemList = {
          [1] = {ItemID = 3000100, Count = 1},
          [2] = {ItemID = 3000002, Count = 5000},
          [3] = {ItemID = 3641102, Count = 1}
        }
      }
    }
  }
}
return config, "ID", key
