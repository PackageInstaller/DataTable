local AvgCfg_cpt00_tutorial_03x = {
  [1] = {
    images = {
      {
        imgId = 3,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg"
      },
      {
        imgId = 1,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg"
      }
    },
    imgTween = {
      {imgId = 3, posId = 5},
      {
        imgId = 3,
        duration = 0.2,
        posId = 4
      },
      {
        imgId = 3,
        duration = 0.7,
        delay = 0.2,
        shake = true
      }
    },
    content = 10,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 3, faceId = 4}
    }
  },
  [2] = {
    imgTween = {
      {imgId = 1, posId = 1},
      {
        imgId = 1,
        duration = 0.2,
        posId = 2
      },
      {imgId = 3, isDark = true}
    },
    content = 20,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 1, faceId = 4}
    }
  },
  [3] = {
    imgTween = {
      {
        imgId = 3,
        duration = 0.7,
        alpha = 0
      }
    },
    content = 30,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1
  }
}
return AvgCfg_cpt00_tutorial_03x
