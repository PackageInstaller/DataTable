local AvgCfg_cpt_kuro_03_03 = {
  [1] = {
    bgColor = 2,
    content = 10,
    contentType = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_miemie",
        fullScreen = true
      }
    },
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 1
      }
    },
    audio = {
      bgm = {
        stop = false,
        cue = "Mus_Story_Relax",
        sheet = "Mus_Story_Relax",
        fadeIn = 3,
        fadeOut = 3
      }
    }
  },
  [2] = {
    content = 20,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 6
  },
  [6] = {
    content = 60,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 10
  },
  [10] = {
    content = 100,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 14
  },
  [14] = {
    content = 140,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 18
  },
  [18] = {
    content = 180,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 21
  },
  [21] = {
    content = 210,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 26
  },
  [26] = {
    content = 260,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 30
  },
  [30] = {
    content = 300,
    contentType = 1,
    scrambleTypeWriter = true,
    audio = {
      bgm = {stop = true},
      sfx = {
        cue = "AVG_tele_disconnect",
        sheet = "AVG_gf"
      }
    }
  },
  [31] = {
    content = 310,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 35
  },
  [35] = {
    content = 350,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 39
  },
  [39] = {
    content = 390,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 43
  },
  [43] = {
    content = 430,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 47
  },
  [47] = {
    content = 470,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 49
  },
  [49] = {
    content = 490,
    contentType = 1,
    scrambleTypeWriter = true,
    audio = {
      sfx = {
        cue = "AVG_tele_disconnect",
        sheet = "AVG_gf"
      }
    },
    nextId = 51
  },
  [51] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      }
    }
  }
}
return AvgCfg_cpt_kuro_03_03
