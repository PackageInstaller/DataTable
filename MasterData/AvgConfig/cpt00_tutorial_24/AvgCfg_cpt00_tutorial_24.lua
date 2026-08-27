local AvgCfg_cpt00_tutorial_24 = {
  [1] = {
    images = {
      {
        imgId = 1,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg"
      },
      {
        imgId = 3,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg"
      }
    },
    imgTween = {
      {imgId = 3, posId = 5},
      {
        imgId = 3,
        duration = 0.2,
        posId = 4
      }
    },
    content = 10,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [2] = {
    heroFace = {
      {imgId = 1, faceId = 5}
    },
    imgTween = {
      {imgId = 1, posId = 1},
      {
        imgId = 1,
        posId = 2,
        isDark = false,
        duration = 0.2
      },
      {imgId = 3, isDark = true}
    },
    content = 20,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [3] = {
    imgTween = {
      {imgId = 3, isDark = false},
      {
        imgId = 3,
        shake = true,
        duration = 0.2
      },
      {imgId = 1, isDark = true}
    },
    content = 30,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [4] = {
    heroFace = {
      {imgId = 1, faceId = 0}
    },
    imgTween = {
      {imgId = 1, isDark = false},
      {imgId = 3, isDark = true}
    },
    content = 40,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [5] = {
    imgTween = {
      {imgId = 3, isDark = false},
      {imgId = 1, isDark = true}
    },
    content = 50,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  },
  [6] = {
    content = 60,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3
  }
}
return AvgCfg_cpt00_tutorial_24
