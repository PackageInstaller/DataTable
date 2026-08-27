local AvgCfg_23sg_as004ri_1 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 1,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt00/cpt00_e_bg010_1",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_sp_avg"
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [2] = {content = 20, contentType = 1},
  [3] = {
    content = 30,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0.5,
        isDark = true
      },
      {
        imgId = 1,
        delay = 1,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 1,
        delay = 1.8,
        duration = 1,
        alpha = 1,
        isDark = false
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Quiet",
        sheet = "Mus_Story_Quiet",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "SteinsGate_SGSE171_RingCall",
        sheet = "SG",
        audioId = 1
      }
    }
  },
  [4] = {
    content = 40,
    contentType = 4,
    speakerName = 11
  },
  [5] = {
    content = 50,
    contentType = 2,
    ppv = {
      rRgbSTween = {
        isShow = true,
        duration = 0.6,
        blurRadius = 0.3
      }
    }
  },
  [6] = {
    content = 60,
    contentType = 4,
    speakerName = 11
  },
  [7] = {content = 70, contentType = 2},
  [8] = {
    content = 80,
    contentType = 2,
    ppv = {
      rRgbSTween = {
        isShow = false,
        duration = 0.6,
        blurRadius = 0.3
      }
    }
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 11
  },
  [10] = {
    content = 100,
    contentType = 2,
    audio = {
      sfx = {
        cue = "AVG_tele_connect",
        sheet = "AVG_gf"
      },
      stopAudioId = {1}
    }
  },
  [11] = {
    content = 110,
    contentType = 1,
    audio = {
      bgm = {stop = true}
    }
  },
  [12] = {
    content = 120,
    contentType = 2,
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Passion",
        sheet = "Mus_Story_Passion",
        fadeIn = 3,
        fadeOut = 1
      }
    }
  }
}
return AvgCfg_23sg_as004ri_1
