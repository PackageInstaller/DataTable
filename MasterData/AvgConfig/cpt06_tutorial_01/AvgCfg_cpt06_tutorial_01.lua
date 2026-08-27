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
        imgId = 103,
        imgType = 3,
        alpha = 0,
        imgPath = "sol_avg"
      }
    },
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
      }
    },
    content = 10,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 102, faceId = 6}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 103,
        alpha = 0,
        posId = 1
      },
      {
        imgId = 103,
        duration = 0.6,
        posId = 2,
        alpha = 1
      },
      {
        imgId = 102,
        duration = 0.2,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 103, faceId = 4}
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 1002,
    speakerHeroPosId = 3,
    imgTween = {
      {
        imgId = 102,
        duration = 0.2,
        isDark = false
      },
      {
        imgId = 103,
        duration = 0.2,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 102, faceId = 0}
    }
  },
  [4] = {
    content = 40,
    contentType = 3,
    speakerHeroId = 1003,
    speakerHeroPosId = 1,
    contentShake = true,
    imgTween = {
      {
        imgId = 103,
        duration = 0.2,
        isDark = false
      },
      {
        imgId = 102,
        duration = 0.2,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 103, faceId = 0}
    }
  }
}
return AvgCfg_cpt00_tutorial_01
