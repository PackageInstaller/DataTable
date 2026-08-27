local AvgCfg_23sg_as02_2 = {
  [1] = {
    bgColor = 2,
    contentStyle = 1,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_bg002",
        fullScreen = true
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "sg/sg_e_bg001",
        fullScreen = true
      },
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        imgPath = "anna_avg"
      },
      {
        imgId = 202,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_avg"
      },
      {
        imgId = 601,
        imgType = 3,
        alpha = 0,
        imgPath = "itaru_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_SteinsGate_img12_Crossroads",
        sheet = "Mus_SteinsGate_img12_Crossroads",
        fadeIn = 3,
        fadeOut = 1
      },
      sfx = {
        cue = "AVG_whitenoise",
        sheet = "AVG_gf"
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 4,
    speakerName = 12
  },
  [3] = {
    content = 30,
    contentType = 4,
    speakerName = 13
  },
  [4] = {
    content = 40,
    contentType = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 0.6,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 0.6,
        duration = 0.6,
        alpha = 1
      }
    },
    audio = {
      sfx = {cue = "AVG_Alarm", sheet = "AVG_gf"}
    }
  },
  [5] = {
    content = 50,
    contentType = 2,
    audio = {
      sfx = {cue = "AVG_volt", sheet = "AVG"}
    }
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 601,
    contentShake = true,
    imgTween = {
      {
        imgId = 601,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 601,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 601, faceId = 3}
    }
  },
  [7] = {
    content = 70,
    contentType = 3,
    speakerHeroId = 1002,
    contentShake = true,
    imgTween = {
      {
        imgId = 601,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        shake = true,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 102, faceId = 10}
    }
  },
  [8] = {
    content = 80,
    contentType = 2,
    imgTween = {
      {
        imgId = 102,
        delay = 0,
        duration = 0.2,
        alpha = 0,
        isDark = false
      }
    },
    audio = {
      bgm = {stop = true}
    }
  },
  [9] = {
    content = 90,
    contentType = 4,
    speakerName = 11
  }
}
return AvgCfg_23sg_as02_2
