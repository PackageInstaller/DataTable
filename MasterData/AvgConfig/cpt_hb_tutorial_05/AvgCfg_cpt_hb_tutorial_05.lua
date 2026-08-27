local AvgCfg_cpt_hb_tutorial_05 = {
  [1] = {
    content = 10,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 2,
    images = {
      {
        imgId = 153,
        imgType = 3,
        alpha = 0,
        imgPath = "sueyoi_avg"
      }
    },
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 153,
        delay = 0,
        duration = 0.2,
        posId = 3,
        alpha = 1,
        isDark = false,
        shake = true
      }
    },
    heroFace = {
      {imgId = 153, faceId = 44}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1053,
    speakerHeroPosId = 2
  },
  [3] = {
    autoContinue = true,
    isEnd = true,
    imgTween = {
      {
        imgId = 153,
        delay = 0,
        duration = 0.6,
        posId = 3,
        alpha = 0,
        isDark = false
      }
    }
  }
}
return AvgCfg_cpt_hb_tutorial_05
