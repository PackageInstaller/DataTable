local FlappyBirdMapConfig = {}
FlappyBirdMapConfig.eTubeType = {
  bottom = 0,
  top = 1,
  mid = 2
}
FlappyBirdMapConfig.eItemType = {accItem = 1, scoreItem = 2}
FlappyBirdMapConfig.birdSize = {
  left = -9500,
  bottom = -20000,
  right = 35000,
  top = 20000
}
FlappyBirdMapConfig.originBackGroundMoveSpeed = -250
FlappyBirdMapConfig.midBgViewSpeed = 0.001
FlappyBirdMapConfig.longBgViewSpeed = 2.0E-4
FlappyBirdMapConfig.originDistance = 1000000
FlappyBirdMapConfig.jumpForce = 1000
FlappyBirdMapConfig.gravityScale = 300
FlappyBirdMapConfig.invinciableRemainFrame = 50
FlappyBirdMapConfig.minVerticalVelocity = -60000
FlappyBirdMapConfig.sceneItemData = {
  [1] = {
    scale = {halfWidth = 65000, halfHeight = 55000},
    itemType = FlappyBirdMapConfig.eItemType.accItem
  },
  [2] = {
    scale = {halfWidth = 65000, halfHeight = 55000},
    itemType = FlappyBirdMapConfig.eItemType.scoreItem
  }
}
FlappyBirdMapConfig.sceneTubeData = {
  [1] = {
    scale = {halfWidth = 75000, halfHeight = 300000},
    tubeOffset = {x = 0, y = 600000},
    tubeType = FlappyBirdMapConfig.eTubeType.top
  },
  [2] = {
    scale = {halfWidth = 75000, halfHeight = 300000},
    tubeOffset = {x = 0, y = -600000},
    tubeType = FlappyBirdMapConfig.eTubeType.bottom
  },
  [3] = {
    scale = {halfWidth = 75000, halfHeight = 150000},
    tubeOffset = {x = 0, y = 150000},
    tubeType = FlappyBirdMapConfig.eTubeType.mid
  },
  [4] = {
    scale = {halfWidth = 75000, halfHeight = 150000},
    tubeOffset = {x = 0, y = 0},
    tubeType = FlappyBirdMapConfig.eTubeType.mid
  },
  [5] = {
    scale = {halfWidth = 75000, halfHeight = 300000},
    tubeOffset = {x = 0, y = -650000},
    tubeType = FlappyBirdMapConfig.eTubeType.bottom
  },
  [6] = {
    scale = {halfWidth = 75000, halfHeight = 300000},
    tubeOffset = {x = 0, y = 500000},
    tubeType = FlappyBirdMapConfig.eTubeType.top
  },
  [7] = {
    scale = {halfWidth = 75000, halfHeight = 300000},
    tubeOffset = {x = 0, y = -500000},
    tubeType = FlappyBirdMapConfig.eTubeType.bottom
  },
  [8] = {
    scale = {halfWidth = 75000, halfHeight = 150000},
    tubeOffset = {x = 0, y = -150000},
    tubeType = FlappyBirdMapConfig.eTubeType.mid
  },
  [9] = {
    scale = {halfWidth = 75000, halfHeight = 300000},
    tubeOffset = {x = 0, y = 650000},
    tubeType = FlappyBirdMapConfig.eTubeType.top
  },
  [10] = {
    scale = {halfWidth = 75000, halfHeight = 300000},
    tubeOffset = {x = 0, y = 450000},
    tubeType = FlappyBirdMapConfig.eTubeType.top
  },
  [11] = {
    scale = {halfWidth = 75000, halfHeight = 300000},
    tubeOffset = {x = 0, y = -450000},
    tubeType = FlappyBirdMapConfig.eTubeType.bottom
  }
}
FlappyBirdMapConfig.sceneGroupData = {
  [1] = {
    foreGDistance = 100000,
    backGDistance = 300000,
    groupOffset = {x = 0, y = 0},
    verticalOffsetRange = {0, 0},
    score = 1,
    bornScore = 0,
    dieScore = 5,
    randomWeight = 10,
    groupType = 1,
    tubeChildren = {
      FlappyBirdMapConfig.sceneTubeData[1],
      FlappyBirdMapConfig.sceneTubeData[2]
    },
    itemChildren = {
      [1] = {
        itemWeight = 10,
        itemData = FlappyBirdMapConfig.sceneItemData[2],
        itemOffset = {x = 0, y = 0}
      }
    }
  },
  [2] = {
    foreGDistance = 100000,
    backGDistance = 300000,
    groupOffset = {x = 0, y = 0},
    verticalOffsetRange = {-100000, 100000},
    score = 1,
    bornScore = 0,
    dieScore = 15,
    randomWeight = 10,
    groupType = 2,
    tubeChildren = {
      FlappyBirdMapConfig.sceneTubeData[4]
    },
    itemChildren = {
      [1] = {
        itemWeight = 20,
        itemData = FlappyBirdMapConfig.sceneItemData[2],
        itemOffset = {x = 175000, y = 0}
      }
    }
  },
  [3] = {
    foreGDistance = 100000,
    backGDistance = 300000,
    groupOffset = {x = 0, y = 0},
    verticalOffsetRange = {-100000, 0},
    score = 1,
    bornScore = 5,
    randomWeight = 60,
    groupType = 3,
    tubeChildren = {
      FlappyBirdMapConfig.sceneTubeData[3],
      FlappyBirdMapConfig.sceneTubeData[5]
    },
    itemChildren = {
      [1] = {
        itemWeight = 30,
        itemData = FlappyBirdMapConfig.sceneItemData[2],
        itemOffset = {x = 0, y = 400000}
      }
    }
  },
  [4] = {
    foreGDistance = 100000,
    backGDistance = 300000,
    groupOffset = {x = 0, y = 0},
    verticalOffsetRange = {-100000, 100000},
    score = 1,
    bornScore = 5,
    randomWeight = 60,
    groupType = 4,
    tubeChildren = {
      FlappyBirdMapConfig.sceneTubeData[6],
      FlappyBirdMapConfig.sceneTubeData[7]
    },
    itemChildren = {
      [1] = {
        itemWeight = 30,
        itemData = FlappyBirdMapConfig.sceneItemData[2],
        itemOffset = {x = 0, y = 0}
      }
    }
  },
  [5] = {
    foreGDistance = 100000,
    backGDistance = 300000,
    groupOffset = {x = 0, y = 0},
    verticalOffsetRange = {0, 100000},
    score = 1,
    bornScore = 5,
    randomWeight = 30,
    groupType = 5,
    tubeChildren = {
      FlappyBirdMapConfig.sceneTubeData[8],
      FlappyBirdMapConfig.sceneTubeData[9]
    },
    itemChildren = {
      [1] = {
        itemWeight = 30,
        itemData = FlappyBirdMapConfig.sceneItemData[2],
        itemOffset = {x = 0, y = -400000}
      }
    }
  },
  [6] = {
    foreGDistance = 100000,
    backGDistance = 300000,
    groupOffset = {x = 0, y = 0},
    verticalOffsetRange = {0, 100000},
    score = 1,
    bornScore = 5,
    randomWeight = 30,
    groupType = 6,
    tubeChildren = {
      FlappyBirdMapConfig.sceneTubeData[8],
      FlappyBirdMapConfig.sceneTubeData[9]
    },
    itemChildren = {
      [1] = {
        itemWeight = 10,
        itemData = FlappyBirdMapConfig.sceneItemData[1],
        itemOffset = {x = 0, y = -400000}
      }
    }
  },
  [7] = {
    foreGDistance = 100000,
    backGDistance = 300000,
    groupOffset = {x = 0, y = 0},
    verticalOffsetRange = {-150000, 150000},
    score = 1,
    bornScore = 20,
    randomWeight = 200,
    groupType = 7,
    tubeChildren = {
      FlappyBirdMapConfig.sceneTubeData[10],
      FlappyBirdMapConfig.sceneTubeData[11]
    },
    itemChildren = {
      [1] = {
        itemWeight = 30,
        itemData = FlappyBirdMapConfig.sceneItemData[2],
        itemOffset = {x = 0, y = 0}
      }
    }
  },
  [8] = {
    foreGDistance = 100000,
    backGDistance = 300000,
    groupOffset = {x = 0, y = 0},
    verticalOffsetRange = {-150000, 150000},
    score = 1,
    bornScore = 20,
    randomWeight = 100,
    groupType = 8,
    tubeChildren = {
      FlappyBirdMapConfig.sceneTubeData[10],
      FlappyBirdMapConfig.sceneTubeData[11]
    },
    itemChildren = {
      [1] = {
        itemWeight = 10,
        itemData = FlappyBirdMapConfig.sceneItemData[1],
        itemOffset = {x = 0, y = 0}
      }
    }
  }
}
return FlappyBirdMapConfig
