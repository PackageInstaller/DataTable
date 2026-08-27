local AvgCfg_cpt00_tutorial_01 = {
  [1] = {
    images = {
      {
        imgId = 102,
        imgType = 3,
        alpha = 0,
        imgPath = "anna_avg"
      },
      {
        imgId = 152,
        imgType = 3,
        alpha = 0,
        imgPath = "hatsuchiri_avg"
      }
    },
    imgTween = {
      {
        imgId = 152,
        alpha = 0,
        posId = 1
      },
      {
        imgId = 152,
        duration = 0.6,
        posId = 2,
        alpha = 1
      }
    },
    content = 10,
    contentType = 3,
    speakerHeroId = 1052,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 152, faceId = 4}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1052,
    speakerHeroPosId = 1
  },
  [3] = {
    imgTween = {
      {
        imgId = 102,
        alpha = 0,
        posId = 5
      },
      {
        imgId = 102,
        duration = 0.6,
        posId = 4,
        alpha = 1
      },
      {
        imgId = 152,
        duration = 0.2,
        isDark = true
      }
    },
    content = 30,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 102, faceId = 5}
    }
  },
  [4] = {
    imgTween = {
      {
        imgId = 102,
        duration = 0.2,
        isDark = true
      },
      {
        imgId = 152,
        duration = 0.2,
        isDark = false
      }
    },
    content = 40,
    contentType = 3,
    speakerHeroId = 1052,
    speakerHeroPosId = 1,
    heroFace = {
      {imgId = 152, faceId = 0}
    }
  },
  [5] = {
    imgTween = {
      {
        imgId = 152,
        duration = 0.2,
        isDark = true
      },
      {
        imgId = 102,
        duration = 0.2,
        isDark = false
      }
    },
    content = 50,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    contentShake = true,
    heroFace = {
      {imgId = 102, faceId = 6}
    }
  }
}
return AvgCfg_cpt00_tutorial_01
