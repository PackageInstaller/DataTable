local M = {}
local SOURCE_TYPE = Config.SOURCE_TYPE
local SETTING = Config.SETTING
local QualityCfg = require("manager.render.quality_cfg")
local QUALITY = QualityCfg.QUALITY
local INPUT_CODE = Config.INPUT_CODE
M.PageTag = {
  Voice = 1,
  Quality = 2,
  Other = 3,
  Download = 4,
  Notification = 5,
  Account = 6,
  PCTouch = 7
}
M.SubToggleList = {
  [M.PageTag.Voice] = "ModeVoice",
  [M.PageTag.Quality] = "ModeQuality",
  [M.PageTag.Other] = "ModeOther",
  [M.PageTag.Download] = "ModeDownLoad",
  [M.PageTag.Notification] = "ModeNotification",
  [M.PageTag.Account] = "ModeAccount",
  [M.PageTag.PCTouch] = "ModePCTouch"
}
M.SubToggleName = {
  [M.PageTag.Voice] = "PageVoice",
  [M.PageTag.Quality] = "PageQuality",
  [M.PageTag.Other] = "PageOther",
  [M.PageTag.Download] = "PageDownLoad",
  [M.PageTag.Notification] = "PageNotification",
  [M.PageTag.Account] = "PageAccount",
  [M.PageTag.PCTouch] = "PagePCTouch"
}
M.ComponentType = {Slider = 1, Toggle = 2}
M.VoiceType = {
  Main = 1,
  BG = 2,
  SE = 3,
  CV = 4
}
M.SingleToggleType = {
  AntiAliasing = 3,
  Hdr = 4,
  AllNotification = 5,
  GameNotificatoin = 6,
  NoticeNotification = 7,
  NightNotification = 8,
  GPGButtonShow = 9
}
M.VoiceToggleList = {
  [M.VoiceType.Main] = "ToggleMain",
  [M.VoiceType.BG] = "ToggleBG",
  [M.VoiceType.SE] = "ToggleSE",
  [M.VoiceType.CV] = "ToggleCV"
}
M.SingleToggleList = {
  [M.SingleToggleType.AntiAliasing] = "ToggleAntiAliasing",
  [M.SingleToggleType.Hdr] = "ToggleHDR",
  [M.SingleToggleType.AllNotification] = "ToggleAllNotification",
  [M.SingleToggleType.GameNotificatoin] = "ToggleGameNotification",
  [M.SingleToggleType.NoticeNotification] = "ToggleNoticeNotification",
  [M.SingleToggleType.NightNotification] = "ToggleNightNotification",
  [M.SingleToggleType.GPGButtonShow] = "GPGButtonShow"
}
M.VoiceTypeContainList = {
  [M.VoiceType.Main] = {
    SOURCE_TYPE.BGM,
    SOURCE_TYPE.EFFECT,
    SOURCE_TYPE.SPECIAL,
    SOURCE_TYPE.VOICE,
    SOURCE_TYPE.EFFECT_LOOP,
    SOURCE_TYPE.CLICK
  },
  [M.VoiceType.BG] = {
    SOURCE_TYPE.BGM
  },
  [M.VoiceType.SE] = {
    SOURCE_TYPE.EFFECT,
    SOURCE_TYPE.SPECIAL,
    SOURCE_TYPE.EFFECT_LOOP,
    SOURCE_TYPE.CLICK
  },
  [M.VoiceType.CV] = {
    SOURCE_TYPE.VOICE
  }
}
M.NOTIFICATION_TYPE = {
  ALL = "all_notification",
  GAME = "game_notification",
  NOTICE = "notice_notification",
  NIGHT = "night_notification"
}
M.NOTIFICATION_TYPE_NAME = {
  [M.NOTIFICATION_TYPE.ALL] = "所有通知",
  [M.NOTIFICATION_TYPE.GAME] = "游戏通知",
  [M.NOTIFICATION_TYPE.NOTICE] = "公告通知",
  [M.NOTIFICATION_TYPE.NIGHT] = "夜间通知"
}
M.MOUSE_KEYCODE = {
  [323] = "UICommon2/Com/Set_btn_sbl",
  [324] = "UICommon2/Com/Set_btn_sbr",
  [325] = "UICommon2/Com/Set_btn_sbm"
}
M.KEYCODE_TO_STRING_MAP = {
  [48] = "0",
  [49] = "1",
  [50] = "2",
  [51] = "3",
  [52] = "4",
  [53] = "5",
  [54] = "6",
  [55] = "7",
  [56] = "8",
  [57] = "9",
  [256] = "小键盘0",
  [257] = "小键盘1",
  [258] = "小键盘2",
  [259] = "小键盘3",
  [260] = "小键盘4",
  [261] = "小键盘5",
  [262] = "小键盘6",
  [263] = "小键盘7",
  [264] = "小键盘8",
  [265] = "小键盘9",
  [45] = "-",
  [61] = "=",
  [91] = "[",
  [93] = "]",
  [92] = "\\",
  [59] = ";",
  [39] = "'",
  [13] = "Enter",
  [44] = ",",
  [46] = ".",
  [47] = "/"
}
M.BTNNAME_INFO = {
  ButtonForward = {
    key = "button_forward",
    desc = "向上移动",
    input_code = INPUT_CODE.FORWARD
  },
  ButtonLeft = {
    key = "button_left",
    desc = "向左移动",
    input_code = INPUT_CODE.LEFT
  },
  ButtonBackward = {
    key = "button_backward",
    desc = "向下移动",
    input_code = INPUT_CODE.BACKWARD
  },
  ButtonRight = {
    key = "button_right",
    desc = "向右移动",
    input_code = INPUT_CODE.RIGHT
  },
  ButtonDodge = {
    key = "button_dodge",
    desc = "闪避",
    input_code = INPUT_CODE.INPUT_SKILL1
  },
  ButtonInteract = {
    key = "button_interact",
    desc = "交互",
    input_code = INPUT_CODE.INPUT_INTERACT
  },
  ButtonComboBurst = {
    key = "button_combo_burst",
    desc = "连携爆发",
    input_code = INPUT_CODE.INPUT_SPECAIL_SKILL
  },
  ButtonBasicAttack = {
    key = "button_basic_attack",
    desc = "普攻",
    input_code = INPUT_CODE.INPUT_COMMON
  },
  ButtonSkill1 = {
    key = "button_skill1",
    desc = "技能1",
    input_code = INPUT_CODE.INPUT_SKILL2
  },
  ButtonSkill2 = {
    key = "button_skill2",
    desc = "技能2",
    input_code = INPUT_CODE.INPUT_SKILL3
  },
  ButtonUltSkill = {
    key = "button_ult_skill",
    desc = "终结技",
    input_code = INPUT_CODE.TPS_ATK_SKILL
  },
  ButtonStageSkill = {
    key = "button_stage_skill",
    desc = "关卡技能",
    input_code = INPUT_CODE.TOWER_SKILL
  },
  ButtonSwitchChar1 = {
    key = "button_switch_char1",
    desc = "切换角色1",
    input_code = INPUT_CODE.QTE1
  },
  ButtonSwitchChar2 = {
    key = "button_switch_char2",
    desc = "切换角色2",
    input_code = INPUT_CODE.QTE2
  },
  ButtonSwitchC1Ult = {
    key = "button_switch_c1_ult",
    desc = "切换角色1并释放终结技",
    input_code = INPUT_CODE.QTE_UltSkill_1
  },
  ButtonSwitchC2Ult = {
    key = "button_switch_c2_ult",
    desc = "切换角色2并释放终结技",
    input_code = INPUT_CODE.QTE_UltSkill_2
  },
  ButtonMap = {
    key = "button_map",
    desc = "激活地图引导",
    input_code = INPUT_CODE.INPUT_NAVIGATION
  }
}
M.UI_CFG = {
  search_target_type = {
    type = "multi_toggle",
    fun = "set_search_target_type",
    ui_list = {
      {
        ui_name = "Distance",
        value = SETTING.SEARCH_TARGET_TYPE.DISTANCE
      },
      {
        ui_name = "HpPercent",
        value = SETTING.SEARCH_TARGET_TYPE.HP_PERCENT
      }
    },
    page_tag = M.PageTag.Other
  },
  lock_enemy_btn_visible = {
    type = "single_toggle",
    fun = "set_lock_enemy_btn_visible",
    ui_list = {
      {ui_name = "Manual"}
    },
    page_tag = M.PageTag.Other,
    desc_obj = "ManualDesc"
  },
  joy_move_type = {
    type = "multi_toggle",
    fun = "set_joy_move_type",
    ui_list = {
      {
        ui_name = "JoyFixed",
        value = SETTING.JOYSTICK_MOVE_TYPE.STATIC
      },
      {
        ui_name = "JoyDefault",
        value = SETTING.JOYSTICK_MOVE_TYPE.DYNAMIC
      }
    },
    page_tag = M.PageTag.Other
  },
  skill_cancel_type = {
    type = "multi_toggle",
    fun = "set_skill_cancel_type",
    ui_list = {
      {
        ui_name = "SkillCancelButton",
        value = SETTING.CANCEL_SKILL_TYPE.BUTTON
      },
      {
        ui_name = "SkillDefaultDistance",
        value = SETTING.CANCEL_SKILL_TYPE.DISTANCE
      }
    },
    page_tag = M.PageTag.Other
  },
  skill_sensitivity = {
    type = "slider_btn",
    fun = "set_skill_sensitivity",
    show_obj = "SkillSensitivityData",
    ui_list = {
      {
        ui_name = "SkillSensitivitySlider"
      }
    },
    reduce_btn = "SkillSensitivityBtnReduce",
    add_btn = "SkillSensitivityBtnAdd",
    min_num = 1,
    max_num = 50,
    page_tag = M.PageTag.Other
  },
  camera_view_type = {
    type = "multi_toggle",
    fun = "set_camera_view_type",
    ui_list = {
      {
        ui_name = "CameraViewType_Depression",
        value = SETTING.CAMERA_VIEW_TYPE.DEPRESSION
      },
      {
        ui_name = "CameraViewType_Shoulder",
        value = SETTING.CAMERA_VIEW_TYPE.SHOULDER
      }
    },
    page_tag = M.PageTag.Other
  },
  depression_mode_rotate = {
    type = "multi_toggle",
    fun = "enable_depression_mode_rotate",
    ui_list = {
      {
        ui_name = "DepressionModeOn",
        value = SETTING.CAMERA_DEPRESSION_MODE_ROTATE.ON
      },
      {
        ui_name = "DepressionModeOff",
        value = SETTING.CAMERA_DEPRESSION_MODE_ROTATE.OFF
      }
    },
    page_tag = M.PageTag.Other
  },
  login_camera_movement_setting = {
    type = "multi_toggle",
    fun = "set_login_camera_movement_setting",
    ui_list = {
      {
        ui_name = "CameraSetting_DAILYLOGIN",
        value = SETTING.LOGIN_CAMERA_MOVEMENT_SETTING.DAILYLOGIN
      },
      {
        ui_name = "CameraSetting_EVERYLOGIN",
        value = SETTING.LOGIN_CAMERA_MOVEMENT_SETTING.EVERYLOGIN
      },
      {
        ui_name = "CameraSetting_OFF",
        value = SETTING.LOGIN_CAMERA_MOVEMENT_SETTING.OFF
      }
    },
    page_tag = M.PageTag.Other
  },
  indicator_attach_target_enable = {
    type = "multi_toggle",
    fun = "set_indicator_attach_target_enable",
    ui_list = {
      {
        ui_name = "IndicatorAttachTargetOn",
        value = SETTING.INDICATOR_ATTACH_TARGET.ON
      },
      {
        ui_name = "IndicatorAttachTargetOff",
        value = SETTING.INDICATOR_ATTACH_TARGET.OFF
      }
    },
    page_tag = M.PageTag.Other,
    enable_value = SETTING.INDICATOR_ATTACH_TARGET.ON,
    desc_obj = "IndicatorStartRatio"
  },
  auto_trigger_qte_on_role_out = {
    type = "multi_toggle",
    fun = "set_auto_trigger_qte_on_role_out",
    ui_list = {
      {
        ui_name = "AutoTriggerQteOnRoleOutOn",
        value = SETTING.AUTO_TRIGGER_QTE_ON_ROLE_OUT.ON
      },
      {
        ui_name = "AutoTriggerQteOnRoleOutOnlyLink",
        value = SETTING.AUTO_TRIGGER_QTE_ON_ROLE_OUT.ONLY_LINK
      },
      {
        ui_name = "AutoTriggerQteOnRoleOutOff",
        value = SETTING.AUTO_TRIGGER_QTE_ON_ROLE_OUT.OFF
      }
    },
    page_tag = M.PageTag.Other,
    enable_value = SETTING.AUTO_TRIGGER_QTE_ON_ROLE_OUT.ON
  },
  camera_pinch_type = {
    type = "multi_toggle",
    fun = "set_camera_pinch_type",
    ui_list = {
      {
        ui_name = "DoubleFingerOn",
        value = SETTING.CAMERA_PINCH_TYPE.OPEN
      },
      {
        ui_name = "DoubleFingerOff",
        value = SETTING.CAMERA_PINCH_TYPE.CLOSE
      }
    },
    page_tag = M.PageTag.Other
  },
  camera_sensitivity = {
    type = "slider_btn",
    fun = "set_camera_sensitivity",
    show_obj = "CameraSensitivityData",
    ui_list = {
      {
        ui_name = "CameraSensitivitySlider"
      }
    },
    reduce_btn = "SlipCameraBtnReduce",
    add_btn = "SlipCameraBtnAdd",
    min_num = 1,
    max_num = 15,
    page_tag = M.PageTag.Other
  },
  start_drag_ratio = {
    type = "slider_btn",
    fun = "set_start_drag_ratio",
    show_obj = "IndicatorStartRatioData",
    ui_list = {
      {
        ui_name = "IndicatorStartRatioSlider"
      }
    },
    reduce_btn = "IndicatorStartRatioBtnReduce",
    add_btn = "IndicatorStartRatioBtnAdd",
    min_num = 0,
    max_num = 10,
    costom_num = true,
    page_tag = M.PageTag.Other
  },
  damage_font_size = {
    type = "multi_toggle",
    fun = "set_damage_font_size",
    ui_list = {
      {
        ui_name = "DamageFontHide",
        value = SETTING.DAMAGE_FONT_SIZE_TYPE.HIDE
      },
      {
        ui_name = "DamageFontLow",
        value = SETTING.DAMAGE_FONT_SIZE_TYPE.LOW
      },
      {
        ui_name = "DamageFontMiddle",
        value = SETTING.DAMAGE_FONT_SIZE_TYPE.MIDDLE
      },
      {
        ui_name = "DamageFontHigh",
        value = SETTING.DAMAGE_FONT_SIZE_TYPE.HIGH
      }
    },
    page_tag = M.PageTag.Other
  },
  auto_lock_type = {
    type = "single_toggle",
    fun = "set_auto_lock_type",
    ui_list = {
      {ui_name = "AutoLock"}
    },
    page_tag = M.PageTag.Other,
    desc_obj = "AutoLockDesc"
  },
  voice_main = {
    type = "slider_toggle",
    fun = "set_game_voice",
    ui_list = {
      {slider_name = "SliderMain", toggle_name = "ToggleMain"}
    },
    voice_type = M.VoiceType.Main,
    page_tag = M.PageTag.Voice
  },
  voice_bg = {
    type = "slider_toggle",
    fun = "set_game_voice",
    ui_list = {
      {slider_name = "SliderBG", toggle_name = "ToggleBG"}
    },
    voice_type = M.VoiceType.BG,
    page_tag = M.PageTag.Voice
  },
  voice_se = {
    type = "slider_toggle",
    fun = "set_game_voice",
    ui_list = {
      {slider_name = "SliderSE", toggle_name = "ToggleSE"}
    },
    voice_type = M.VoiceType.SE,
    page_tag = M.PageTag.Voice
  },
  voice_cv = {
    type = "slider_toggle",
    fun = "set_game_voice",
    ui_list = {
      {slider_name = "SliderCV", toggle_name = "ToggleCV"}
    },
    voice_type = M.VoiceType.CV,
    page_tag = M.PageTag.Voice
  },
  unity_quality = {
    type = "multi_toggle",
    fun = "set_unity_quality_setting",
    ui_list = {
      {
        ui_name = "RenderLow",
        value = SETTING.UNITY_QUALITY_SETTING_TYPE.LOW
      },
      {
        ui_name = "RenderMid",
        value = SETTING.UNITY_QUALITY_SETTING_TYPE.MIDDLE
      },
      {
        ui_name = "RenderHigh",
        value = SETTING.UNITY_QUALITY_SETTING_TYPE.HIGH
      },
      {
        ui_name = "RenderVeryHigh",
        value = SETTING.UNITY_QUALITY_SETTING_TYPE.VERY_HIGH
      }
    },
    page_tag = M.PageTag.Quality
  },
  render_frame = {
    type = "multi_toggle",
    fun = "set_render_frame",
    ui_list = {
      {
        ui_name = "FrameLow",
        value = SETTING.RENDER_FRAME_TYPE.LOW
      },
      {
        ui_name = "FrameNormal",
        value = SETTING.RENDER_FRAME_TYPE.NORMAL
      }
    },
    page_tag = M.PageTag.Quality
  },
  effect_quality = {
    type = "multi_toggle",
    fun = "set_effect_quality",
    ui_list = {
      {
        ui_name = "SpecialEffectLow",
        value = SETTING.EFFECT_QUALITY_TYPE.LOW
      },
      {
        ui_name = "SpecialEffectMid",
        value = SETTING.EFFECT_QUALITY_TYPE.MIDDLE
      },
      {
        ui_name = "SpecialEffectHigh",
        value = SETTING.EFFECT_QUALITY_TYPE.HIGH
      },
      {
        ui_name = "SpecialEffectVeryHigh",
        value = SETTING.EFFECT_QUALITY_TYPE.VERY_HIGH
      }
    },
    page_tag = M.PageTag.Quality
  },
  resolution = {
    type = "multi_toggle",
    fun = "set_resolution",
    ui_list = {
      {
        ui_name = "ResolutionLow",
        value = SETTING.RESOLUTION.LOW
      },
      {
        ui_name = "ResolutionMid",
        value = SETTING.RESOLUTION.MIDDLE
      },
      {
        ui_name = "ResolutionHigh",
        value = SETTING.RESOLUTION.HIGH
      },
      {
        ui_name = "ResolutionVeryHigh",
        value = SETTING.RESOLUTION.VERY_HIGH
      }
    },
    page_tag = M.PageTag.Quality
  },
  shadow = {
    type = "multi_toggle",
    fun = "set_shadow_quality",
    ui_list = {
      {
        ui_name = "ShadowClose",
        value = SETTING.SHADOW_TYPE.CLOSE
      },
      {
        ui_name = "ShadowLow",
        value = SETTING.SHADOW_TYPE.LOW
      },
      {
        ui_name = "ShadowMid",
        value = SETTING.SHADOW_TYPE.MIDDLE
      },
      {
        ui_name = "ShadowHigh",
        value = SETTING.SHADOW_TYPE.HIGH
      }
    },
    page_tag = M.PageTag.Quality
  },
  anti_aliasing = {
    type = "single_toggle",
    fun = "set_anti_aliasing",
    ui_list = {
      {
        ui_name = "ToggleAntiAliasing"
      }
    },
    single_toggle_type = M.SingleToggleType.AntiAliasing,
    page_tag = M.PageTag.Quality
  },
  HDR = {
    type = "single_toggle",
    fun = "set_hdr",
    ui_list = {
      {ui_name = "ToggleHDR"}
    },
    single_toggle_type = M.SingleToggleType.Hdr,
    page_tag = M.PageTag.Quality
  },
  safe_area = {
    type = "slider",
    fun = "set_safe_area",
    ui_list = {
      {
        ui_name = "ScreenSafeArea"
      }
    },
    page_tag = M.PageTag.Other
  },
  [M.NOTIFICATION_TYPE.ALL] = {
    type = "single_toggle",
    fun = "set_all_notification",
    ui_list = {
      {
        ui_name = "ToggleAllNotification"
      }
    },
    single_toggle_type = M.SingleToggleType.AllNotification,
    page_tag = M.PageTag.Notification
  },
  [M.NOTIFICATION_TYPE.GAME] = {
    type = "single_toggle",
    fun = "set_game_notification",
    ui_list = {
      {
        ui_name = "ToggleGameNotification"
      }
    },
    single_toggle_type = M.SingleToggleType.GameNotificatoin,
    page_tag = M.PageTag.Notification
  },
  [M.NOTIFICATION_TYPE.NOTICE] = {
    type = "single_toggle",
    fun = "set_notice_notification",
    ui_list = {
      {
        ui_name = "ToggleNoticeNotification"
      }
    },
    single_toggle_type = M.SingleToggleType.NoticeNotification,
    page_tag = M.PageTag.Notification
  },
  [M.NOTIFICATION_TYPE.NIGHT] = {
    type = "single_toggle",
    fun = "set_night_notification",
    ui_list = {
      {
        ui_name = "ToggleNightNotification"
      }
    },
    single_toggle_type = M.SingleToggleType.NightNotification,
    page_tag = M.PageTag.Notification
  },
  gpg_button_show = {
    type = "single_toggle",
    fun = "set_gpg_button_show",
    ui_list = {
      {
        ui_name = "GPGButtonShow"
      }
    },
    single_toggle_type = M.SingleToggleType.GPGButtonShow,
    page_tag = M.PageTag.PCTouch
  },
  button_forward = {
    page_tag = M.PageTag.PCTouch,
    ui_list = {}
  },
  button_left = {
    page_tag = M.PageTag.PCTouch
  },
  button_backward = {
    page_tag = M.PageTag.PCTouch
  },
  button_right = {
    page_tag = M.PageTag.PCTouch
  },
  button_dodge = {
    page_tag = M.PageTag.PCTouch
  },
  button_interact = {
    page_tag = M.PageTag.PCTouch
  },
  button_combo_burst = {
    page_tag = M.PageTag.PCTouch
  },
  button_basic_attack = {
    page_tag = M.PageTag.PCTouch
  },
  button_skill1 = {
    page_tag = M.PageTag.PCTouch
  },
  button_skill2 = {
    page_tag = M.PageTag.PCTouch
  },
  button_ult_skill = {
    page_tag = M.PageTag.PCTouch
  },
  button_stage_skill = {
    page_tag = M.PageTag.PCTouch
  },
  button_switch_char1 = {
    page_tag = M.PageTag.PCTouch
  },
  button_switch_char2 = {
    page_tag = M.PageTag.PCTouch
  },
  button_switch_c1_ult = {
    page_tag = M.PageTag.PCTouch
  },
  button_switch_c2_ult = {
    page_tag = M.PageTag.PCTouch
  },
  button_map = {
    page_tag = M.PageTag.PCTouch
  }
}
return M
