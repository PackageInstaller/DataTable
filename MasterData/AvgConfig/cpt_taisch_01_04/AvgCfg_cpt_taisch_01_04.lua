local AvgCfg_cpt_taisch_01_04 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg066",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt001/cpt00_e_bg066_2",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef001",
        fullScreen = true
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef002",
        fullScreen = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef003",
        fullScreen = true
      },
      {
        imgId = 178,
        imgType = 3,
        alpha = 0,
        imgPath = "taisch_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0.25
      },
      {
        imgId = 1,
        delay = 1.5,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_Water_Drip",
        sheet = "AVG_gf"
      }
    }
  },
  [2] = {content = 20, contentType = 2},
  [3] = {content = 30, contentType = 1},
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1078,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 2,
        alpha = 1
      },
      {
        imgId = 178,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 178,
        delay = 2,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 3,
        delay = 0,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 3,
        delay = 0.1,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 4,
        delay = 0.2,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 4,
        delay = 0.3,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 5,
        delay = 0.4,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 0.5,
        duration = 0.1,
        alpha = 0
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    effect = {
      effect1 = {
        prefabName = "avg/FXP_Scene"
      }
    },
    heroFace = {
      {imgId = 178, faceId = 6}
    },
    nextId = 101
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 5}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 0}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 2}
    }
  },
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 3,
    speakerHeroId = 1078,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 4}
    }
  },
  [10] = {
    content = 100,
    contentType = 3,
    speakerHeroId = 1078
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 5}
    }
  },
  [12] = {
    content = 120,
    contentType = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 1078,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 0}
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 1078
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 4}
    }
  },
  [16] = {
    content = 160,
    contentType = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [17] = {
    content = 170,
    contentType = 3,
    speakerHeroId = 1078,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 6}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 5}
    }
  },
  [19] = {
    content = 190,
    contentType = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 1078,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 4}
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 0}
    }
  },
  [22] = {
    content = 220,
    contentType = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 1078,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [24] = {
    content = 240,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 3}
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 1}
    }
  },
  [26] = {
    content = 260,
    contentType = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 1078,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 0}
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 1078
  },
  [29] = {
    content = 290,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 3}
    }
  },
  [30] = {
    content = 300,
    contentType = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [31] = {content = 310, contentType = 2},
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 1078,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 4}
    }
  },
  [33] = {
    content = 330,
    contentType = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 1078,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 178, faceId = 7}
    }
  },
  [35] = {
    content = 350,
    contentType = 3,
    speakerHeroId = 1078
  },
  [36] = {
    content = 360,
    contentType = 3,
    speakerHeroId = 1078
  },
  [37] = {
    content = 370,
    contentType = 2,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 1078,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 5}
    }
  },
  [40] = {
    content = 400,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 6}
    }
  },
  [41] = {
    content = 410,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 178,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.05,
        alpha = 0.75
      },
      {
        imgId = 2,
        delay = 0.15,
        duration = 0.05,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0.2,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_ElecSpace",
        sheet = "AVG_gf"
      }
    },
    effect = {
      stopList = {"effect1"}
    },
    heroFace = {
      {imgId = 178, faceId = 6}
    }
  },
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    isEnd = true
  },
  [101] = {
    content = 41,
    contentType = 3,
    speakerHeroId = 1078,
    heroFace = {
      {imgId = 178, faceId = 5}
    },
    nextId = 5
  }
}
return AvgCfg_cpt_taisch_01_04
