local AvgCfg_23sg_as003_b02 = {
  [1] = {
    content = 10,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 3,
    images = {
      {
        imgId = 202,
        imgType = 3,
        alpha = 0,
        imgPath = "kurisu_avg"
      },
      {
        imgId = 999,
        imgType = 3,
        alpha = 0,
        imgPath = "prof_f_avg",
        imgPathBoy = "prof_m_avg"
      }
    },
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0,
        posId = 4,
        alpha = 0,
        isDark = false
      },
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0,
        posId = 2,
        alpha = 0,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      }
    },
    heroFace = {
      {imgId = 202, faceId = 5}
    }
  },
  [2] = {
    content = 20,
    contentType = 3,
    speakerHeroId = 2002,
    speakerHeroPosId = 3,
    heroFace = {
      {imgId = 202, faceId = 0}
    }
  },
  [3] = {
    content = 30,
    contentType = 3,
    speakerHeroId = 2,
    speakerHeroPosId = 1,
    imgTween = {
      {
        imgId = 202,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = true
      },
      {
        imgId = 999,
        delay = 0,
        duration = 0.2,
        alpha = 1,
        isDark = false
      }
    }
  }
}
return AvgCfg_23sg_as003_b02
