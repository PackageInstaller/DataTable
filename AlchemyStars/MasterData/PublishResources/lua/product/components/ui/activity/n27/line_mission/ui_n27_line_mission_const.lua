_class("UIN27LineMissionConst", UIController)
UIN27LineMissionConst = UIN27LineMissionConst

function UIN27LineMissionConst.SLevel()
  return 999
end

function UIN27LineMissionConst.Passed()
  return 888
end

function UIN27LineMissionConst.NodeCfg()
  return {
    [DiscoveryStageType.FightNormal] = {
      [1] = {
        normal = "n27_xxg_btn1",
        press = "",
        lock = "",
        textColor = Color(0.0392156862745098, 0.043137254901960784, 0.047058823529411764),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255),
        normalStar = "",
        passStar = "n27_xxg_star"
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(0.9764705882352941, 1.0, 0.3803921568627451),
        textShadow = Color(0.7490196078431373, 0.20392156862745098, 0.09803921568627451),
        normalStar = "",
        passStar = ""
      }
    },
    [DiscoveryStageType.FightBoss] = {
      [1] = {
        normal = "n27_xxg_btn3",
        press = "",
        lock = "",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(1.0, 1.0, 1.0),
        normalStar = "",
        passStar = "n27_xxg_star"
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.9333333333333333, 0 / 255, 0.13333333333333333),
        normalStar = "",
        passStar = ""
      }
    },
    [DiscoveryStageType.Plot] = {
      [1] = {
        normal = "n27_xxg_btn2",
        press = "",
        lock = "",
        textColor = Color(0.0392156862745098, 0.043137254901960784, 0.047058823529411764),
        textShadow = Color(0 / 255, 0 / 255, 0 / 255)
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(0.9764705882352941, 1.0, 0.3803921568627451),
        textShadow = Color(0.7490196078431373, 0.20392156862745098, 0.09803921568627451)
      }
    },
    [UIN27LineMissionConst.SLevel()] = {
      [1] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "",
        passStar = ""
      },
      [2] = {
        normal = "",
        press = "",
        lock = "",
        textColor = Color(1.0, 1.0, 1.0),
        textShadow = Color(0.08627450980392157, 0.16470588235294117, 0.23921568627450981),
        normalStar = "",
        passStar = ""
      }
    }
  }
end
