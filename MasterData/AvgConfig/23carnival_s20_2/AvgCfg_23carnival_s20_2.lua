local AvgCfg_23carnival_s20_2 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_bg003",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt08/cpt08_e_cg003",
        fullScreen = true
      },
      {
        imgId = 3,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt08/cpt08_e_cg003_2",
        fullScreen = true
      },
      {
        imgId = 5,
        imgType = 2,
        alpha = 0,
        order = 8,
        imgPath = "cpt05/cpt05_e_bg005",
        fullScreen = true
      },
      {
        imgId = 11,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef001",
        fullScreen = true
      },
      {
        imgId = 12,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef002",
        fullScreen = true
      },
      {
        imgId = 13,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_ef003",
        fullScreen = true
      },
      {
        imgId = 503,
        imgType = 3,
        alpha = 0,
        imgPath = "alcyone_avg"
      },
      {
        imgId = 502,
        imgType = 3,
        alpha = 0,
        imgPath = "ira_b_avg"
      }
    },
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0.75
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.2,
        isDark = true
      },
      {
        imgId = 5,
        delay = 0.3,
        duration = 0.2,
        isDark = false
      }
    }
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 11,
        delay = 0,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 11,
        delay = 0.1,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 12,
        delay = 0.2,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 12,
        delay = 0.3,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 13,
        delay = 0.4,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 13,
        delay = 0.5,
        duration = 0.1,
        alpha = 0
      }
    }
  },
  [4] = {
    content = 40,
    contentType = 4,
    speakerName = 12
  },
  [5] = {
    content = 50,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.2,
        isDark = true
      },
      {
        imgId = 5,
        delay = 0.3,
        duration = 0.2,
        alpha = 0.5,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.25
      }
    }
  },
  [7] = {
    content = 70,
    contentType = 4,
    speakerName = 12
  },
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 14
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 12,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [10] = {
    autoContinue = true,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 0.6,
        duration = 0.6,
        alpha = 0.2
      },
      {
        imgId = 1,
        delay = 1.3,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 1.5,
        duration = 0.6,
        alpha = 0.5
      },
      {
        imgId = 1,
        delay = 2.4,
        duration = 1,
        alpha = 1
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 3,
    speakerHeroId = 502,
    imgTween = {
      {
        imgId = 502,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 502,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      },
      {
        imgId = 502,
        delay = 0.5,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_SinNPunish",
        sheet = "Mus_Story_SinNPunish",
        fadeIn = 3,
        fadeOut = 1
      }
    },
    heroFace = {
      {imgId = 502, faceId = 1}
    }
  },
  [12] = {
    content = 120,
    contentType = 3,
    speakerHeroId = 502,
    imgTween = {
      {
        imgId = 502,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [13] = {
    content = 130,
    contentType = 3,
    speakerHeroId = 503,
    imgTween = {
      {
        imgId = 502,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 503,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 503,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 503, faceId = 9}
    }
  },
  [14] = {
    content = 140,
    contentType = 3,
    speakerHeroId = 503
  },
  [15] = {
    content = 150,
    contentType = 3,
    speakerHeroId = 502,
    imgTween = {
      {
        imgId = 503,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 502,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    }
  },
  [16] = {
    content = 160,
    contentType = 3,
    speakerHeroId = 503,
    imgTween = {
      {
        imgId = 502,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 503,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 503, faceId = 2}
    }
  },
  [17] = {
    content = 170,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 503,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.45
      },
      {
        imgId = 5,
        delay = 0.8,
        duration = 0.6,
        alpha = 0.6
      }
    }
  },
  [18] = {
    content = 180,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true
  },
  [19] = {
    content = 190,
    contentType = 3,
    speakerHeroId = 503,
    imgTween = {
      {
        imgId = 503,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 503, faceId = 9}
    }
  },
  [20] = {
    content = 200,
    contentType = 3,
    speakerHeroId = 502,
    imgTween = {
      {
        imgId = 503,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 502,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      }
    }
  },
  [21] = {
    content = 210,
    contentType = 3,
    speakerHeroId = 503,
    imgTween = {
      {
        imgId = 503,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 502,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 503, faceId = 2}
    }
  },
  [22] = {
    content = 220,
    contentType = 2,
    imgTween = {
      {
        imgId = 503,
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
    speakerHeroId = 503,
    imgTween = {
      {
        imgId = 503,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    audio = {
      sfx = {
        cue = "AVG_keyboardtype_sci",
        sheet = "AVG_gf"
      }
    },
    heroFace = {
      {imgId = 503, faceId = 11}
    }
  },
  [24] = {
    bgColor = 3,
    content = 240,
    contentType = 2,
    imgTween = {
      {
        imgId = 503,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_paticle_dissipation",
        sheet = "AVG"
      },
      bgm = {stop = true}
    }
  },
  [25] = {
    content = 250,
    contentType = 4,
    speakerName = 16,
    contentShake = true
  },
  [26] = {content = 260, contentType = 2},
  [27] = {content = 270, contentType = 2},
  [28] = {
    content = 280,
    contentType = 4,
    speakerName = 12
  },
  [29] = {
    content = 290,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_EV22Summer_Story_Fall",
        sheet = "Mus_EV22Summer_Story_Fall",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 4,
    speakerName = 12,
    bgColor = 2
  },
  [31] = {
    content = 310,
    contentType = 4,
    speakerName = 14
  },
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 14
  },
  [33] = {
    content = 330,
    contentType = 4,
    speakerName = 12
  },
  [34] = {
    content = 340,
    contentType = 4,
    speakerName = 14
  },
  [35] = {
    content = 350,
    contentType = 4,
    speakerName = 12
  },
  [36] = {content = 360, contentType = 2},
  [37] = {
    content = 370,
    contentType = 4,
    speakerName = 14
  },
  [38] = {
    content = 380,
    contentType = 4,
    speakerName = 12
  },
  [39] = {
    content = 390,
    contentType = 4,
    speakerName = 14
  },
  [40] = {
    content = 400,
    contentType = 4,
    speakerName = 12
  },
  [41] = {
    content = 410,
    contentType = 4,
    speakerName = 14
  },
  [42] = {
    content = 420,
    contentType = 4,
    speakerName = 12
  },
  [43] = {
    content = 430,
    contentType = 4,
    speakerName = 14
  },
  [44] = {
    content = 440,
    contentType = 4,
    speakerName = 12
  },
  [45] = {
    content = 450,
    contentType = 4,
    speakerName = 14
  },
  [46] = {
    content = 460,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 1,
        alpha = 1
      },
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0.5
      },
      {
        imgId = 11,
        delay = 0,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 11,
        delay = 0.1,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 12,
        delay = 0.2,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 12,
        delay = 0.3,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 13,
        delay = 0.4,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 13,
        delay = 0.5,
        duration = 0.1,
        alpha = 0
      }
    },
    audio = {
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [47] = {
    content = 470,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 0.75
      }
    }
  },
  [48] = {content = 480, contentType = 2},
  [49] = {
    content = 490,
    contentType = 4,
    speakerName = 15,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0,
        alpha = 0
      }
    }
  },
  [50] = {
    content = 500,
    contentType = 4,
    speakerName = 13
  },
  [51] = {
    content = 510,
    contentType = 4,
    speakerName = 15
  },
  [52] = {
    content = 520,
    contentType = 4,
    speakerName = 13
  },
  [53] = {
    content = 530,
    contentType = 4,
    speakerName = 15
  },
  [54] = {
    content = 540,
    contentType = 4,
    speakerName = 13
  },
  [55] = {
    content = 550,
    contentType = 2,
    imgTween = {
      {
        imgId = 3,
        delay = 0,
        duration = 2,
        alpha = 0
      },
      {
        imgId = 5,
        delay = 0,
        duration = 2,
        alpha = 0.85
      }
    },
    nextId = 64
  },
  [56] = {
    content = 560,
    contentType = 4,
    speakerName = 15
  },
  [57] = {
    content = 570,
    contentType = 2,
    contentShake = true,
    audio = {
      sfx = {
        cue = "Skill_Gabrie_01_End",
        sheet = "Mon_Gabrie"
      }
    }
  },
  [58] = {
    content = 580,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_impact_gore",
        sheet = "AVG"
      },
      bgm = {stop = true}
    }
  },
  [59] = {
    content = 590,
    contentType = 4,
    speakerName = 13
  },
  [60] = {content = 600, contentType = 2},
  [61] = {
    content = 610,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 11,
        delay = 0,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 11,
        delay = 0.1,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 12,
        delay = 0.2,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 12,
        delay = 0.3,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 13,
        delay = 0.4,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 13,
        delay = 0.5,
        duration = 0.1,
        alpha = 0
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "EV_23Carnivalr_Main",
        sheet = "EV_23Carnivalr_Main",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [62] = {
    content = 620,
    contentType = 4,
    speakerName = 11,
    scrambleTypeWriter = true,
    imgTween = {
      {
        imgId = 11,
        delay = 0,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 11,
        delay = 0.1,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 12,
        delay = 0.2,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 12,
        delay = 0.3,
        duration = 0.1,
        alpha = 0
      },
      {
        imgId = 13,
        delay = 0.4,
        duration = 0.1,
        alpha = 1
      },
      {
        imgId = 13,
        delay = 0.5,
        duration = 0.1,
        alpha = 0
      }
    },
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 0.6,
        alpha = 0.9
      }
    }
  },
  [63] = {
    content = 630,
    contentType = 4,
    speakerName = 13
  },
  [64] = {
    content = 640,
    contentType = 4,
    speakerName = 13,
    nextId = 66
  },
  [65] = {
    content = 650,
    contentType = 2,
    imgTween = {
      {
        imgId = 5,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    }
  },
  [66] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 5,
        delay = 2,
        duration = 1,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_impact_gore",
        sheet = "AVG"
      }
    }
  }
}
return AvgCfg_23carnival_s20_2
