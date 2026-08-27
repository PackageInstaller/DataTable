local AvgCfg_cpt05_e_04_01 = {
  [1] = {
    SkipScenario = 13,
    bgColor = 2,
    content = 10,
    contentType = 2,
    storyAvgId = 5104,
    images = {
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt05/cpt05_e_bg001",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt05/cpt05_e_bg005",
        fullScreen = true
      },
      {
        imgId = 35,
        imgType = 3,
        alpha = 0,
        imgPath = "wisdom_w_avg"
      },
      {
        imgId = 51,
        imgType = 3,
        alpha = 0,
        imgPath = "refactor_avg"
      },
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg005_2",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Creepy",
        sheet = "Mus_Story_Creepy",
        fadeIn = 3,
        fadeOut = 3
      },
      sfx = {
        cue = "Skill_Croque_01",
        sheet = "Chara_Croque"
      }
    }
  },
  [2] = {content = 20, contentType = 2},
  [3] = {content = 30, contentType = 2},
  [4] = {
    branch = {
      disableSelected = true,
      finalAct = 13,
      {content = 41, jumpAct = 5},
      {content = 42, jumpAct = 9}
    }
  },
  [5] = {content = 50, contentType = 2},
  [6] = {content = 60, contentType = 2},
  [7] = {content = 70, contentType = 2},
  [8] = {
    content = 80,
    contentType = 2,
    nextId = 4
  },
  [9] = {content = 90, contentType = 2},
  [10] = {content = 100, contentType = 2},
  [11] = {content = 110, contentType = 2},
  [12] = {
    content = 120,
    contentType = 2,
    nextId = 4
  },
  [13] = {
    branch = {
      disableSelected = true,
      finalAct = 21,
      {content = 131, jumpAct = 14},
      {content = 132, jumpAct = 18}
    }
  },
  [14] = {content = 140, contentType = 2},
  [15] = {content = 150, contentType = 2},
  [16] = {content = 160, contentType = 2},
  [17] = {
    content = 170,
    contentType = 2,
    nextId = 13
  },
  [18] = {
    content = 180,
    contentType = 2,
    nextId = 300
  },
  [19] = {content = 190, contentType = 2},
  [20] = {
    content = 200,
    contentType = 2,
    nextId = 13
  },
  [21] = {
    branch = {
      {content = 211, jumpAct = 22}
    }
  },
  [22] = {content = 220, contentType = 2},
  [23] = {
    content = 230,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
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
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [25] = {
    content = 250,
    contentType = 3,
    speakerHeroId = 51,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 51,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 51,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Refactorer_01_Start",
        sheet = "Mon_Refactorer"
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 51,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 33}
    }
  },
  [27] = {
    content = 270,
    contentType = 3,
    speakerHeroId = 51,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 51,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 51,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [28] = {
    content = 280,
    contentType = 3,
    speakerHeroId = 51,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true
  },
  [29] = {
    content = 290,
    contentType = 2,
    imgTween = {
      {
        imgId = 51,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Croque_01",
        sheet = "Chara_Croque"
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true
  },
  [31] = {
    branch = {
      {content = 311, jumpAct = 32},
      {content = 312, jumpAct = 39}
    }
  },
  [32] = {
    content = 320,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 0}
    }
  },
  [33] = {
    content = 330,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [34] = {
    content = 340,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 33}
    }
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [36] = {content = 360, contentType = 2},
  [37] = {
    content = 370,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 0}
    }
  },
  [38] = {
    content = 380,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 35, faceId = 33}
    },
    nextId = 45
  },
  [39] = {
    content = 390,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 0}
    }
  },
  [40] = {
    content = 400,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [41] = {content = 410, contentType = 2},
  [42] = {
    content = 420,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [43] = {
    content = 430,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 35, faceId = 22}
    }
  },
  [44] = {
    content = 440,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [45] = {
    content = 450,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [46] = {
    content = 460,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 22}
    }
  },
  [47] = {
    content = 470,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_weapon_reload",
        sheet = "AVG_gf"
      }
    }
  },
  [48] = {
    content = 480,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true
  },
  [49] = {content = 490, contentType = 2},
  [50] = {
    content = 500,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    },
    heroFace = {
      {imgId = 35, faceId = 0}
    }
  },
  [51] = {
    content = 510,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true,
    heroFace = {
      {imgId = 35, faceId = 33}
    }
  },
  [52] = {
    content = 520,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [53] = {content = 530, contentType = 2},
  [54] = {
    content = 540,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Serious",
        sheet = "Mus_Story_Serious",
        fadeIn = 3,
        fadeOut = 3
      }
    },
    heroFace = {
      {imgId = 35, faceId = 0}
    }
  },
  [55] = {
    content = 550,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [56] = {
    branch = {
      {content = 561, jumpAct = 57},
      {content = 562, jumpAct = 58}
    }
  },
  [57] = {
    content = 570,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 33}
    },
    nextId = 59
  },
  [58] = {
    content = 580,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 33}
    }
  },
  [59] = {
    content = 590,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [60] = {content = 600, contentType = 2},
  [61] = {content = 610, contentType = 2},
  [62] = {
    content = 620,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [63] = {
    content = 630,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 35, faceId = 3}
    }
  },
  [64] = {
    content = 640,
    contentType = 4,
    speakerName = 11,
    audio = {
      bgm = {stop = true}
    }
  },
  [65] = {content = 650, contentType = 2},
  [66] = {
    content = 660,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Funny",
        sheet = "Mus_Story_Funny",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [67] = {
    content = 670,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [68] = {
    content = 680,
    contentType = 3,
    speakerHeroId = 51,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 51,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 51,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [69] = {
    content = 690,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 51,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [70] = {
    content = 700,
    contentType = 3,
    speakerHeroId = 51,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 51,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 51,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Refactorer_01_Start",
        sheet = "Mon_Refactorer"
      }
    }
  },
  [71] = {
    content = 710,
    contentType = 2,
    imgTween = {
      {
        imgId = 51,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Serious",
        sheet = "Mus_Story_Serious",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [72] = {content = 720, contentType = 2},
  [73] = {content = 730, contentType = 2},
  [74] = {content = 740, contentType = 2},
  [75] = {
    content = 750,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 2}
    }
  },
  [76] = {
    content = 760,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 35, faceId = 3}
    }
  },
  [77] = {
    content = 770,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [78] = {
    content = 780,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 999}
    }
  },
  [79] = {
    content = 790,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [80] = {
    content = 800,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 35, faceId = 2}
    }
  },
  [81] = {
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    },
    branch = {
      {content = 811, jumpAct = 82},
      {content = 812, jumpAct = 84}
    }
  },
  [82] = {
    content = 820,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 3}
    }
  },
  [83] = {
    content = 830,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    nextId = 86
  },
  [84] = {
    content = 840,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 3}
    }
  },
  [85] = {
    content = 850,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [86] = {
    content = 860,
    contentType = 3,
    speakerHeroId = 51,
    speakerHeroPosId = 2,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 51,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 51,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "Skill_Refactorer_01_Start",
        sheet = "Mon_Refactorer"
      }
    }
  },
  [87] = {
    content = 870,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true,
    imgTween = {
      {
        imgId = 51,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 3}
    }
  },
  [88] = {
    content = 880,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [89] = {
    content = 890,
    contentType = 4,
    speakerName = 11
  },
  [90] = {
    content = 900,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 1}
    }
  },
  [91] = {
    content = 910,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [92] = {content = 920, contentType = 2},
  [93] = {
    content = 930,
    contentType = 3,
    speakerHeroId = 35,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [94] = {
    content = 940,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [95] = {
    content = 950,
    contentType = 4,
    speakerName = 11
  },
  [96] = {
    content = 960,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 999}
    }
  },
  [97] = {
    content = 970,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [98] = {
    content = 980,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 35, faceId = 3}
    }
  },
  [99] = {
    content = 990,
    contentType = 4,
    speakerName = 11,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [100] = {
    content = 1000,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 2}
    }
  },
  [101] = {
    content = 1010,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    heroFace = {
      {imgId = 35, faceId = 999}
    }
  },
  [102] = {
    content = 1020,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [103] = {content = 1030, contentType = 2},
  [104] = {content = 1040, contentType = 2},
  [105] = {content = 1050, contentType = 2},
  [106] = {content = 1060, contentType = 2},
  [107] = {
    content = 1070,
    contentType = 4,
    speakerName = 11
  },
  [108] = {
    content = 1080,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 4}
    }
  },
  [109] = {
    content = 1090,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [110] = {content = 1100, contentType = 2},
  [111] = {content = 1110, contentType = 2},
  [112] = {
    content = 1120,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 999}
    }
  },
  [113] = {
    content = 1130,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [114] = {
    content = 1140,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [115] = {
    content = 1150,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [116] = {
    content = 1160,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2
  },
  [117] = {
    content = 1170,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {cue = "AVG_Alarm", sheet = "AVG_gf"}
    }
  },
  [118] = {
    content = 1180,
    contentType = 4,
    speakerName = 12,
    scrambleTypeWriter = true,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Boss_Purifier_General",
        sheet = "Mus_Boss_Purifier_General",
        fadeIn = 3,
        fadeOut = 3
      },
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [119] = {content = 1190, contentType = 2},
  [120] = {
    content = 1200,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 35, faceId = 3}
    }
  },
  [121] = {
    content = 1210,
    contentType = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [122] = {
    content = 1220,
    contentType = 4,
    speakerName = 11
  },
  [123] = {
    content = 1230,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 35,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [124] = {
    content = 1240,
    contentType = 3,
    speakerHeroId = 35,
    speakerHeroPosId = 2,
    contentShake = true,
    heroFace = {
      {imgId = 35, faceId = 33}
    }
  },
  [125] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 35,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  },
  [300] = {
    content = 181,
    contentType = 2,
    nextId = 19
  }
}
return AvgCfg_cpt05_e_04_01
