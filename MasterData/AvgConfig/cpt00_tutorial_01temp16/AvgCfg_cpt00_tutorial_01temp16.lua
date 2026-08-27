local AvgCfg_cpt00_tutorial_01 = {
  [1] = {
    images = {
      {
        imgId = 1,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg"
      },
      {
        imgId = 2,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg"
      }
    },
    imgTween = {
      {
        imgId = 2,
        alpha = 0,
        posId = 1
      },
      {
        imgId = 2,
        duration = 0.6,
        alpha = 2,
        posId = 2,
        isDark = false
      },
      {
        imgId = 1,
        alpha = 0,
        posId = 5
      },
      {
        imgId = 1,
        duration = 0.6,
        alpha = 1,
        posId = 4,
        isDark = true
      }
    },
    content = 10,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1,
    contentShake = true,
    heroFace = {
      {imgId = 2, faceId = 4}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 2,
        duration = 0.2,
        alpha = 1,
        posId = 2,
        isDark = true
      },
      {
        imgId = 1,
        duration = 0.2,
        alpha = 1,
        posId = 4,
        isDark = false
      }
    },
    heroFace = {
      {imgId = 1, faceId = 3}
    }
  }
}
return AvgCfg_cpt00_tutorial_01
