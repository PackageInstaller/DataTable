_class("CutSceneConfig", Object)
CutSceneConfig = CutSceneConfig

function CutSceneConfig:Constructor(...)
  self.config = {
    [UIStateType.UIMain] = {
      ResName = "UIMainLobbyEnterAnim.prefab",
      AnimationIn = "ui_main_uichange_in_test",
      CallBackDelayIn = 100,
      AnimationOut = "ui_main_uichange_in2_test",
      DestoryDelayOut = 0,
      IsAsyn = true
    },
    CommonBlack = {
      ResName = "UIHomeStoryEnterAnim.prefab",
      AnimationIn = "ui_home_story_in_300",
      CallBackDelayIn = 300,
      AnimationOut = "ui_home_story_out_300",
      DestoryDelayOut = 300
    },
    [UIStateType.UIActivityN5] = {
      ResName = "UIN5Switch.prefab",
      AnimationIn = "uieff_N5_Switch_Finish_Close",
      CallBackDelayIn = 200,
      AnimationOut = "uieff_N5_Switch_Finish_Open",
      DestoryDelayOut = 655
    },
    [UIStateType.UIActivityN5BattleField] = {
      ResName = "UIN5Switch.prefab",
      AnimationIn = "uieff_N5_Switch_Start_Close",
      CallBackDelayIn = 200,
      AnimationOut = "uieff_N5_Switch_Start_Open",
      DestoryDelayOut = 655
    },
    [UIStateType.UIActivityN5SimpleLevel] = {
      ResName = "UIN5Switch.prefab",
      AnimationIn = "uieff_N5_Switch_Start_Close",
      CallBackDelayIn = 200,
      AnimationOut = "uieff_N5_Switch_Start_Open",
      DestoryDelayOut = 655
    },
    [UIStateType.UIN5ProgressController] = {
      ResName = "UIN5Switch.prefab",
      AnimationIn = "uieff_N5_Switch_Start_Close",
      CallBackDelayIn = 200,
      AnimationOut = "uieff_N5_Switch_Start_Open",
      DestoryDelayOut = 655
    },
    [UIStateType.UIActivityN7MainController] = {
      ResName = "UIN7Switch.prefab",
      AnimationIn = "uieff_N7_Switch",
      CallBackDelayIn = 333,
      AnimationOut = "uieff_N7_Switch2",
      DestoryDelayOut = 1000
    },
    [UIStateType.UIActivityN16MainController] = {
      ResName = "UIN16Switch.prefab",
      AnimationIn = "uieffanim_N16_main_show_Switch",
      CallBackDelayIn = 333,
      AnimationOut = "",
      DestoryDelayOut = 655
    },
    [UIStateType.UIHomeStoryController] = {
      ResName = "UIHomeStoryEnterAnim.prefab",
      AnimationIn = "ui_home_story_in_test",
      CallBackDelayIn = 500,
      AnimationOut = "ui_home_story_in2_test",
      DestoryDelayOut = 500
    },
    [UIStateType.UIHomeStoryController .. "DirectIn"] = {
      ResName = "UIHomeStoryEnterAnim.prefab",
      AnimationIn = "ui_home_story_in_direct",
      CallBackDelayIn = 100,
      AnimationOut = "ui_home_story_in2_test",
      DestoryDelayOut = 500
    },
    [UIStateType.UIHomeMovieStoryController] = {
      ResName = "UIHomeStoryEnterAnim.prefab",
      AnimationIn = "ui_home_story_in_test",
      CallBackDelayIn = 500,
      AnimationOut = "ui_home_story_in2_test",
      DestoryDelayOut = 500
    },
    [UIStateType.UIHomeMovieStoryController .. "DirectIn"] = {
      ResName = "UIHomeStoryEnterAnim.prefab",
      AnimationIn = "ui_home_story_in_direct",
      CallBackDelayIn = 100,
      AnimationOut = "ui_home_story_in2_test",
      DestoryDelayOut = 500
    },
    [UIStateType.UIN19P5DrawCard .. "Open"] = {
      ResName = "UIN19P5Switch.prefab",
      AnimationIn = "uieff_N19_p5_award_open_in",
      CallBackDelayIn = 300,
      AnimationOut = "uieff_N19_p5_award_open_out",
      DestoryDelayOut = 267
    },
    [UIStateType.UIN19P5DrawCard .. "Close"] = {
      ResName = "UIN19P5Switch.prefab",
      AnimationIn = "uieff_N19_p5_award_open_in",
      CallBackDelayIn = 300,
      AnimationOut = "uieff_N19_p5_award_open_out",
      DestoryDelayOut = 267
    },
    [UIStateType.UIN19P5DrawCard .. "Left"] = {
      ResName = "UIN19P5AwardSwitch.prefab",
      AnimationIn = "uieff_N19_p5_award_switch_left_in",
      CallBackDelayIn = 367,
      AnimationOut = "uieff_N19_p5_award_switch_left_out",
      DestoryDelayOut = 333
    },
    [UIStateType.UIN19P5DrawCard .. "Right"] = {
      ResName = "UIN19P5AwardSwitch.prefab",
      AnimationIn = "uieff_N19_p5_award_switch_right_in",
      CallBackDelayIn = 367,
      AnimationOut = "uieff_N19_p5_award_switch_right_out",
      DestoryDelayOut = 333
    },
    UIN25Idol_Common_Switch = {
      ResName = "UIN25Idol_Common_Switch.prefab",
      AnimationIn = "uieff_N25_idol_open_in",
      CallBackDelayIn = 267,
      AnimationOut = "uieff_N25_idol_open_out",
      DestoryDelayOut = 833
    },
    [UIStateType.UIActivityN26MainController] = {
      ResName = "UIActivityN38Switch.prefab",
      AnimationIn = "uieff_N38_Switch_in",
      CallBackDelayIn = 1000,
      AnimationOut = "uieff_N38_Switch_out",
      DestoryDelayOut = 1267
    },
    UIN29Detective_Common_Switch = {
      ResName = "UIN29Detective_Common_Switch.prefab",
      AnimationIn = "uieff_N25_idol_open_in",
      CallBackDelayIn = 267,
      AnimationOut = "uieff_N25_idol_open_out",
      DestoryDelayOut = 833
    }
  }
end
