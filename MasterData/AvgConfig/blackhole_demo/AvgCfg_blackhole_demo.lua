local AvgCfg_blackhole_demo = {
  [1] = {
    content = 10,
    contentType = 3,
    speakerHeroId = 1001,
    speakerHeroPosId = 2,
    images = {
      {
        imgId = 1,
        imgType = 2,
        alpha = 0,
        imgPath = "cpt04/cpt04_e_bg008",
        fullScreen = true
      },
      {
        imgId = 101,
        imgType = 3,
        alpha = 0,
        imgPath = "persicaria_avg"
      }
    },
    imgTween = {
      {
        imgId = 101,
        delay = 0,
        duration = 0,
        posId = 3,
        alpha = 0
      },
      {
        imgId = 101,
        delay = 1,
        duration = 0.6,
        posId = 3,
        alpha = 1
      }
    },
    audio = {
      bgm = {stop = true}
    }
  }
}
return AvgCfg_blackhole_demo
