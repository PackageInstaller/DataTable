local config = {}
local ELEMENT_TYPE = Config.FightDefine.ELEMENT_TYPE
config.ELEMENT_COLOR_LIGHT1 = {
  [ELEMENT_TYPE.WATER] = {
    r = 0.372549,
    g = 0.7254902,
    b = 1,
    a = 1
  },
  [ELEMENT_TYPE.FIRE] = {
    r = 1,
    g = 0.5019608,
    b = 0.3529412,
    a = 1
  },
  [ELEMENT_TYPE.THUNDER] = {
    r = 0.372549,
    g = 0.8980392,
    b = 1,
    a = 1
  },
  [ELEMENT_TYPE.LIGHT] = {
    r = 1,
    g = 0.8941177,
    b = 0.6196079,
    a = 0.6
  },
  [ELEMENT_TYPE.DARK] = {
    r = 0.4196078,
    g = 0.372549,
    b = 1,
    a = 1
  }
}
config.ELEMENT_COLOR_LIGHT2 = {
  [ELEMENT_TYPE.WATER] = {
    g = 0.611764,
    r = 0.392156,
    b = 1.0,
    a = 1
  },
  [ELEMENT_TYPE.FIRE] = {
    g = 0.564705,
    r = 1.0,
    b = 0.411764,
    a = 1
  },
  [ELEMENT_TYPE.THUNDER] = {
    g = 0.952941,
    r = 0.317647,
    b = 0.952941,
    a = 1
  },
  [ELEMENT_TYPE.LIGHT] = {
    g = 0.960784,
    r = 1.0,
    b = 0.698039,
    a = 1
  },
  [ELEMENT_TYPE.DARK] = {
    g = 0.505882,
    r = 0.619607,
    b = 1.0,
    a = 1
  }
}
config.ELEMENT_COLOR_LIGHT3 = {
  [ELEMENT_TYPE.WATER] = {
    g = 0.517647,
    b = 1.0,
    r = 0.117647,
    a = 1
  },
  [ELEMENT_TYPE.FIRE] = {
    g = 0.407843,
    b = 0.270588,
    r = 1.0,
    a = 1
  },
  [ELEMENT_TYPE.THUNDER] = {
    g = 0.839215,
    b = 0.803921,
    r = 0.305882,
    a = 0.6
  },
  [ELEMENT_TYPE.LIGHT] = {
    g = 0.933333,
    b = 0.6,
    r = 1.0,
    a = 0.7
  },
  [ELEMENT_TYPE.DARK] = {
    g = 0.278431,
    b = 1.0,
    r = 0.529411,
    a = 1
  }
}
config.FIGHT_UI_EFFECT = {
  Fx_UI_Damage = "Fx_UI_Damage",
  Fx_Btn_skill2_Loop = "Fx_Btn_skill2_Loop",
  Fx_Pointer_1 = "Fx_Pointer_1",
  Fx_Pointer_2 = "Fx_Pointer_2",
  Fx_Btn_skill2_Break = "Fx_Btn_skill2_Break",
  Fx_UI_Hp_back = "Fx_UI_Hp_back",
  Fx_Conmon_not_switch_hero = "Fx_Conmon_not_switch_hero",
  Fx_Skill_Guid = "Fx_Skill_Guid",
  FX_ultimate_obtain_flash = "FX_ultimate_obtain_flash",
  Fx_UI_Lianxie_Qte = "Fx_UI_Lianxie_Qte",
  FX_UI_Energy_Break = "FX_UI_Energy_Break",
  FX_UI_Energy_Lock = "FX_UI_Energy_Lock",
  Fx_Weakness_ImmuneAdd = "Fx_Weakness_ImmuneAdd",
  Fx_Skill_Glow1 = "Fx_Skill_Glow1",
  Fx_InjuriesUp_Bg = "Fx_InjuriesUp_Bg",
  FX_Flash_short_Star = "FX_Flash_short_Star",
  Fx_UiFightSkill01 = "Fx_UiFightSkill01",
  Fx_UI_FightSkill02 = "Fx_UI_FightSkill02",
  Fx_UI_FightSkill02_Loop = "Fx_UI_FightSkill02_Loop"
}
config.SKL_BTN_7_ELEMENT_EFFECT = {
  [ELEMENT_TYPE.WATER] = "Fx_Loading_Water_Low",
  [ELEMENT_TYPE.FIRE] = "Fx_Loading_Fire_Low",
  [ELEMENT_TYPE.THUNDER] = "Fx_Loading_Thunder_Low",
  [ELEMENT_TYPE.LIGHT] = "Fx_Loading_Light_Low",
  [ELEMENT_TYPE.DARK] = "Fx_Loading_Dark_low"
}
config.SKL_BTN_7_ELEMENT_EFFECT2 = {
  [ELEMENT_TYPE.WATER] = "Fx_Loading_Water",
  [ELEMENT_TYPE.FIRE] = "Fx_Loading_Fire",
  [ELEMENT_TYPE.THUNDER] = "Fx_Loading_Thunder",
  [ELEMENT_TYPE.LIGHT] = "Fx_Loading_light",
  [ELEMENT_TYPE.DARK] = "Fx_Loading_Dark"
}
config.SKL_BTN_7_CHARGE_DONE_EFFECT = {
  [ELEMENT_TYPE.WATER] = "Fx_UI_strengthen_ult_water",
  [ELEMENT_TYPE.FIRE] = "Fx_UI_strengthen_ult_fire",
  [ELEMENT_TYPE.LIGHT] = "Fx_UI_strengthen_ult_light",
  [ELEMENT_TYPE.THUNDER] = "Fx_UI_strengthen_ult_thunder",
  [ELEMENT_TYPE.DARK] = "Fx_UI_strengthen_ult_dark"
}
config.ELEMENT_ICON_EFFECT_LOW = {
  [ELEMENT_TYPE.WATER] = "FX_UI_Water_Low",
  [ELEMENT_TYPE.FIRE] = "FX_UI_Fire_Low",
  [ELEMENT_TYPE.THUNDER] = "FX_UI_Thunder_Low",
  [ELEMENT_TYPE.LIGHT] = "FX_UI_Light_Low",
  [ELEMENT_TYPE.DARK] = "FX_UI_Dark_Low"
}
config.ELEMENT_ICON_EFFECT = {
  [ELEMENT_TYPE.WATER] = "FX_UI_Water",
  [ELEMENT_TYPE.FIRE] = "FX_UI_Fire",
  [ELEMENT_TYPE.THUNDER] = "FX_UI_Thunder",
  [ELEMENT_TYPE.LIGHT] = "FX_UI_Light",
  [ELEMENT_TYPE.DARK] = "FX_UI_Dark"
}
config.WEAK_ELEMENT_COLOR = {
  [ELEMENT_TYPE.WATER] = "679ff3",
  [ELEMENT_TYPE.FIRE] = "ffb3b3",
  [ELEMENT_TYPE.THUNDER] = "99d5d4",
  [ELEMENT_TYPE.LIGHT] = "e18b3e",
  [ELEMENT_TYPE.DARK] = "b999d5"
}
config.WEAK_FRAME_ELEMENT_COLOR = {
  [ELEMENT_TYPE.WATER] = "d0f4ff",
  [ELEMENT_TYPE.FIRE] = "ffecec",
  [ELEMENT_TYPE.THUNDER] = "d3ffff",
  [ELEMENT_TYPE.LIGHT] = "fff7dc",
  [ELEMENT_TYPE.DARK] = "f8dcff"
}
config.SKILL_LINK_STAGE = {ONE = 1, TOW = 2}
config.SKILL_LINK_TIMER_SET_TYPE = {
  PAUSE = 1,
  PLAY = 2,
  RESTART = 3,
  CLEAR = 4,
  SHOW = 5,
  HIDE = 6
}
config.SKILL_LINK_CHARGE_STAGE = {
  CHARGING = 1,
  FULL = 2,
  BURST = 3
}
config.VALUE_TYPE = {
  CURRENT_VALUE_RATIO = 1,
  MAX_VALUE_RATIO = 2,
  FIXED_VALUE = 3
}
config.BOUNDARY_COLLISION_TYPE = {
  RIGHT_X = 1,
  TOP_Z = 2,
  LEFT_X = 3,
  BOTTOM_Z = 4
}
return config
