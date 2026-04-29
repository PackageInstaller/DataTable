_class("UISeasonAutoFightHelper", Object)
UISeasonAutoFightHelper = UISeasonAutoFightHelper

function UISeasonAutoFightHelper.GetSeasonStyleByID(seasonID)
  if seasonID == UISeasonID.S1 or seasonID == UISeasonID.S2 then
    return {
      bg_di01 = {
        rawImageName = "exp_s1_map_di42"
      },
      bg_di04 = {
        rawImageName = "fight_saodang_di04"
      },
      bg_di05 = {
        rawImageName = "exp_s1_map_di43"
      },
      line01 = {
        atlasName = "UIAutoFightSweep.spriteatlas",
        spriteName = "fight_saodang_line01"
      },
      line03 = {
        atlasName = "UIAutoFightSweep.spriteatlas",
        spriteName = "fight_saodang_line03"
      },
      kuang01 = {
        atlasName = "UIAutoFightSweep.spriteatlas",
        spriteName = "fight_saodang_kuang02"
      },
      kuang03 = {
        atlasName = "UIAutoFightSweep.spriteatlas",
        spriteName = "fight_saodang_kuang03"
      },
      di08 = {active = false},
      titleColor = {color = "#2A2A2C"},
      optionTitleColorOff = {color = "#68421F"},
      optionTitleColorOn = {color = "#6F5F3E"},
      optionColor = {color = "#2E2E2E"},
      optionColor2 = {color = "#3E3D3D"},
      optionTabBtnOff1 = {active = false},
      optionTabBtnOn1 = {
        atlasName = "UIS1Main.spriteatlas",
        spriteName = "exp_s1_map_di39"
      },
      optionTabBtnOff2 = {active = false},
      optionTabBtnOn2 = {
        atlasName = "UIS1Main.spriteatlas",
        spriteName = "exp_s1_map_di40"
      },
      optionFightBtnBg = {
        atlasName = "UIS1Main.spriteatlas",
        spriteName = "exp_s1_map_btn02"
      },
      optionFightBtnImg = {
        active = true,
        atlasName = "UIS1Main.spriteatlas",
        spriteName = "exp_s1_map_icon21"
      }
    }
  elseif seasonID == UISeasonID.S3 then
    return {
      bg_di01 = {
        rawImageName = "exp_s1_map_di42"
      },
      bg_di04 = {
        rawImageName = "fight_saodang_di04"
      },
      bg_di05 = {
        rawImageName = "exp_s1_map_di43"
      },
      line01 = {
        atlasName = "UIAutoFightSweep.spriteatlas",
        spriteName = "fight_saodang_line01"
      },
      line03 = {
        atlasName = "UIAutoFightSweep.spriteatlas",
        spriteName = "fight_saodang_line03"
      },
      kuang01 = {
        atlasName = "UIAutoFightSweep.spriteatlas",
        spriteName = "fight_saodang_kuang02"
      },
      kuang03 = {
        atlasName = "UIAutoFightSweep.spriteatlas",
        spriteName = "fight_saodang_kuang03"
      },
      di08 = {active = false},
      titleColor = {color = "#2A2A2C"},
      optionTitleColorOff = {color = "#68421F"},
      optionTitleColorOn = {color = "#6F5F3E"},
      optionColor = {color = "#2E2E2E"},
      optionColor2 = {color = "#3E3D3D"},
      optionTabBtnOff1 = {active = false},
      optionTabBtnOn1 = {
        atlasName = "UIS1Main.spriteatlas",
        spriteName = "exp_s1_map_di39"
      },
      optionTabBtnOff2 = {active = false},
      optionTabBtnOn2 = {
        atlasName = "UIS1Main.spriteatlas",
        spriteName = "exp_s1_map_di40"
      },
      optionFightBtnBg = {
        atlasName = "UIS1Main.spriteatlas",
        spriteName = "exp_s1_map_btn02"
      },
      optionFightBtnImg = {
        active = true,
        atlasName = "UIS1Main.spriteatlas",
        spriteName = "exp_s1_map_icon21"
      }
    }
  end
end
