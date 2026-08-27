local AvgCfg_cpt00_tutorial_09 = {
  [1] = {
    images = {
      {
        imgId = 3,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg"
      }
    },
    imgTween = {
      {
        imgId = 3,
        alpha = 0,
        posId = 5
      },
      {
        imgId = 3,
        alpha = 1,
        duration = 0.6,
        posId = 4
      }
    },
    content = 10,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 3, faceId = 10}
    }
  },
  [2] = {
    images = {
      {
        imgId = 1,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg"
      }
    },
    imgTween = {
      {
        imgId = 1,
        alpha = 0,
        posId = 1
      },
      {
        imgId = 1,
        alpha = 1,
        duration = 0.6,
        posId = 2
      },
      {
        imgId = 3,
        duration = 0.2,
        isDark = true
      }
    },
    content = 20,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 1, faceId = 0}
    }
  },
  [3] = {
    imgTween = {
      {
        imgId = 1,
        duration = 0.2,
        isDark = true
      },
      {
        imgId = 3,
        duration = 0.2,
        isDark = false
      }
    },
    content = 30,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 3, faceId = 0}
    }
  },
  [4] = {
    imgTween = {
      {
        imgId = 3,
        duration = 0.2,
        isDark = true
      },
      {
        imgId = 1,
        duration = 0.2,
        isDark = false
      }
    },
    content = 40,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 1, faceId = 4}
    }
  },
  [5] = {
    content = 50,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 1, faceId = 5}
    }
  },
  [6] = {
    imgTween = {
      {imgId = 1, isDark = true},
      {imgId = 3, isDark = false}
    },
    content = 60,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 3, faceId = 16}
    }
  }
}
return AvgCfg_cpt00_tutorial_09
