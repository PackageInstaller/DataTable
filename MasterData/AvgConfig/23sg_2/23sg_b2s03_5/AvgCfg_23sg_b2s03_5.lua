local AvgCfg_23sg_b2s03_5 = {
  [1] = {
    bgColor = 2,
    contentStyle = 1,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 1,
        alpha = 0,
        imgPath = "sg/sg_e_bg004_4",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 1,
        alpha = 0,
        imgPath = "sg/sg_e_bg007_2",
        fullScreen = true
      },
      {
        imgId = 201,
        imgType = 3,
        alpha = 0,
        imgPath = "okabe_avg"
      },
      {
        imgId = 13,
        imgType = 3,
        alpha = 0,
        imgPath = "riko_b2_avg"
      },
      {
        imgId = 4,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "cpt00/cpt00_e_bg004",
        fullScreen = true
      },
      {
        imgId = 10,
        imgType = 2,
        alpha = 0,
        order = 5,
        imgPath = "summer/summer_e_bg010",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 2,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img23_Chaos mind",
        sheet = "Mus_SteinsGate_img23_Chaos mind",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_Door_Open_Close",
        sheet = "AVG_gf"
      }
    }
  },
  [2] = {content = 20, contentType = 2},
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [4] = {
    content = 40,
    contentType = 2,
    images = {
      {
        imgId = 40,
        imgType = 5,
        alpha = 0,
        imgPath = "avg/lightning",
        order = 10,
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 40,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      sfx = {
        cue = "SteinsGate_SGSE067_Dmail",
        sheet = "SG",
        audioId = 2
      }
    },
    sgMobile = {
      sendMsg = {receiver = 51, contentMsg = 52}
    }
  },
  [5] = {
    content = 50,
    contentType = 2,
    audio = {
      sfx = {
        cue = "SteinsGate_SGSE175_type",
        sheet = "SG",
        audioId = 9
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 2,
    sgMobile = {hideImmediate = true},
    audio = {
      stopAudioId = {2, 9}
    },
    images = {
      {
        imgId = 40,
        imgType = 5,
        alpha = 0,
        imgPath = "avg/lightning",
        order = 10,
        fullScreen = true,
        delete = true
      }
    }
  },
  [7] = {content = 70, contentType = 2},
  [8] = {
    content = 80,
    contentType = 4,
    speakerName = 11
  },
  [9] = {content = 90, contentType = 2},
  [10] = {
    content = 100,
    contentType = 2,
    sgMobile = {
      sendMsg = {receiver = 101}
    },
    audio = {
      sfx = {
        cue = "SteinsGate_SGSE175_type",
        sheet = "SG",
        audioId = 8
      }
    }
  },
  [11] = {
    content = 110,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        isDark = true
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        isDark = false
      },
      {
        imgId = 2,
        delay = 1.2,
        duration = 0.6,
        isDark = true
      },
      {
        imgId = 2,
        delay = 1.8,
        duration = 0.6,
        isDark = false
      }
    }
  },
  [12] = {
    content = 120,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_footsteps_cave",
        sheet = "AVG_gf"
      },
      stopAudioId = {8},
      bgm = {stop = true}
    },
    sgMobile = {showSgMobile = false}
  },
  [13] = {content = 130, contentType = 2},
  [14] = {
    content = 140,
    contentType = 4,
    speakerName = 11
  },
  [15] = {
    content = 150,
    contentType = 2,
    imgTween = {
      {
        imgId = 201,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    }
  },
  [16] = {content = 160, contentType = 2},
  [17] = {content = 170, contentType = 2},
  [18] = {content = 180, contentType = 2},
  [19] = {
    content = 190,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_Heartbeat",
        sheet = "AVG_gf"
      }
    }
  },
  [20] = {content = 200, contentType = 2},
  [21] = {content = 210, contentType = 2},
  [22] = {content = 220, contentType = 2},
  [23] = {
    content = 230,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        pos = {
          350,
          -20,
          0
        },
        scale = {
          1.4,
          1.4,
          1.4
        }
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img12_Crossroads",
        sheet = "Mus_SteinsGate_img12_Crossroads",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [24] = {content = 240, contentType = 2},
  [25] = {
    content = 250,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        pos = {
          0,
          0,
          0
        },
        scale = {
          1,
          1,
          1
        }
      },
      {
        imgId = 2,
        delay = 1,
        duration = 0.6,
        alpha = 0,
        shake = true,
        shakeIntensity = 6
      }
    },
    audio = {
      sfx = {
        cue = "AVG_Door_Hit",
        sheet = "AVG_gf"
      }
    }
  },
  [26] = {
    content = 260,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [27] = {
    content = 270,
    contentType = 2,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1
      },
      {
        imgId = 4,
        delay = 0.6,
        duration = 0.6,
        alpha = 0.25
      }
    }
  },
  [28] = {content = 280, contentType = 2},
  [29] = {
    content = 290,
    contentType = 2,
    imgTween = {
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    }
  },
  [30] = {
    content = 300,
    contentType = 2,
    images = {
      {
        imgId = 40,
        imgType = 5,
        alpha = 0,
        imgPath = "avg/lightning",
        order = 10,
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 40,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      sfx = {
        cue = "SteinsGate_SGSE067_Dmail",
        sheet = "SG",
        audioId = 2
      }
    },
    sgMobile = {
      sendMsg = {receiver = 101, contentMsg = 102}
    }
  },
  [31] = {content = 310, contentType = 2},
  [32] = {
    content = 320,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [33] = {
    content = 330,
    contentType = 2,
    imgTween = {
      {
        imgId = 13,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 13,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    }
  },
  [34] = {content = 340, contentType = 2},
  [35] = {content = 350, contentType = 2},
  [36] = {
    content = 360,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [37] = {
    content = 370,
    contentType = 2,
    imgTween = {
      {
        imgId = 13,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 4,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 1,
        isDark = true
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [38] = {
    content = 380,
    contentType = 4,
    speakerName = 11,
    contentShake = true,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img20_Select of sorrow",
        sheet = "Mus_SteinsGate_img20_Select of sorrow",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  },
  [39] = {
    content = 390,
    contentType = 2,
    imgTween = {
      {
        imgId = 13,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    }
  },
  [40] = {
    content = 400,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0.5
      }
    }
  },
  [41] = {content = 410, contentType = 2},
  [42] = {content = 420, contentType = 2},
  [43] = {
    content = 430,
    contentType = 1,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0.65
      }
    }
  },
  [44] = {content = 440, contentType = 2},
  [45] = {
    content = 450,
    contentType = 4,
    speakerName = 11,
    contentShake = true
  },
  [46] = {
    content = 460,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 1
      }
    }
  },
  [47] = {
    content = 470,
    contentType = 2,
    sgMobile = {sendMsgConfirm = true},
    audio = {
      sfx = {
        cue = "SteinsGate_SGSE164_SendMail",
        sheet = "SG",
        audioId = 4
      }
    }
  },
  [48] = {
    autoContinue = true,
    sgMobile = {showSgMobile = false},
    audio = {
      sfx = {
        cue = "SteinsGate_Dmail_Warp",
        sheet = "SG"
      },
      stopAudioId = {4}
    }
  },
  [49] = {
    bgColor = 3,
    content = 480,
    contentType = 2,
    imgTween = {
      {
        imgId = 10,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0,
        duration = 0.6,
        alpha = 0
      }
    },
    audio = {
      bgm = {stop = true},
      stopAudioId = {2}
    },
    images = {
      {
        imgId = 40,
        imgType = 5,
        alpha = 0,
        imgPath = "avg/lightning",
        fullScreen = true,
        delete = true
      }
    }
  }
}
return AvgCfg_23sg_b2s03_5
