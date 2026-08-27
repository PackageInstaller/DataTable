local AvgCfg_cpt_kuro_01_03 = {
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
      },
      {
        imgId = 2,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt06/cpt06_e_bg003",
        fullScreen = true
      },
      {
        imgId = 66,
        imgType = 3,
        alpha = 0,
        imgPath = "meryl_avg"
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
        cue = "Mus_Story_General",
        sheet = "Mus_Story_General",
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
    nextId = 16
  },
  [16] = {
    content = 160,
    contentType = 1,
    scrambleTypeWriter = true,
    nextId = 18,
    audio = {
      bgm = {stop = true}
    }
  },
  [18] = {
    content = 180,
    contentType = 3,
    speakerHeroId = 66,
    speakerHeroPosId = 2,
    imgTween = {
      {
        imgId = 1,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 2,
        delay = 1,
        duration = 1,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 66,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 66,
        delay = 2,
        duration = 0.6,
        posId = 3,
        alpha = 1,
        isDark = true
      }
    }
  },
  [19] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 2,
        delay = 0,
        duration = 1,
        alpha = 0
      },
      {
        imgId = 66,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 0,
        isDark = true
      }
    }
  }
}
return AvgCfg_cpt_kuro_01_03
