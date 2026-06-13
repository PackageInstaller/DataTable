local roleBase = import("character.base.role_base")
local Mina = Util.create_child_mt(roleBase)

function Mina._init(role, npc)
  role.npc = npc
  local misIds = {
    misAtk2 = {10010260203, 10010260204},
    misAtk2Camera = 10010260211,
    misAtk3Hit = {
      10010260302,
      10010260306,
      10010260307,
      10010260308
    },
    misAtk3Area = {
      10010260303,
      10010260304,
      10010260305
    },
    misAtk3Camera = 10010260311,
    misAtk4Camera = 10010260441,
    misHeavy = {10010260503, 10010260504},
    misSkill2_2Collide = {10010262226, 10010262227},
    misSkill2_2CollideQte = {10010262226, 10010264127},
    misSkill2_3Camera = 10010262304,
    misSkill3CameraReset = {10010263317, 10010263417},
    misSkill3Camera = 10010263021,
    misSkill3MaxCamera = 10010263022,
    misSkill3ExCamera = 10010263821,
    misSkill3ExCameraStop = 10010263822,
    misSkill3ExCameraMove = 10010263823,
    misSkill3Pos = {
      10010263001,
      10010263011,
      10010263541
    },
    misSkill3Sword = {
      10010263002,
      10010263012,
      10010263542
    },
    misSkill3SwordMaxEffect = 10010263034,
    misSkill3SwordMaxEffect2 = 10010263014,
    misSkill3SwordMaxEffect3 = 10010263544,
    misSkill2Hit = {10010262105, 10010262212},
    misultCamere = 10010268111
  }
  local magicIds = {
    passiveWeaponArea = {
      102601,
      102602,
      102603,
      102604
    },
    passiveStarArea = {
      102605,
      102606,
      102607,
      102608
    },
    passiveStatus = 102609,
    passiveEnergy = {normal = 102671},
    skill02_cd = 102621,
    skill02_TypeChange = 102622,
    skill02_TypeChangeIsRampage = 102623,
    skill02_skill03LinkTime = 102625,
    skill03LinkTime = 102645,
    skill03SpMaxState = 102644,
    ultCameraMagic = 102685,
    ultShowMagic = 1026100,
    passiveTeachMagic = {102695, 102696},
    wudiMaigc = 102666
  }
  roleBase._init(role, misIds, magicIds)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local destinies = role.destinies
  local traces = role.traces
  role.nowTime = 0
  role.passiveStatus = false
  role.passiveStarAreaList = {
    northwest = {
      state = false,
      magicId = magicIds.passiveStarArea[1]
    },
    northeast = {
      state = false,
      magicId = magicIds.passiveStarArea[2]
    },
    southeast = {
      state = false,
      magicId = magicIds.passiveStarArea[3]
    },
    southwest = {
      state = false,
      magicId = magicIds.passiveStarArea[4]
    }
  }
  role.passiveStarBaseMap = {
    102617,
    102618,
    102619,
    102620
  }
  role.passiveStarAreaOpenName = "southwest"
  role.passiveStarAreaOpenNum = 1
  role.passiveAreaOpenIntervalRange = {
    {3, 3},
    {1, 1},
    {2, 2}
  }
  role.passiveNum = 1
  role.passiveNumResetTime = 0
  role.passiveWeaponArea = {
    northwest = {state = false, magicId = 102601},
    northeast = {false, magicId = 102602},
    southeast = {false, magicId = 102603},
    southwest = {false, magicId = 102604}
  }
  role.passiveAreaType = 1
  role.magicNmaeList = {
    "Fx_H1001026_passive_star1",
    "Fx_H1001026_passive_star2",
    "Fx_H1001026_passive_star3",
    "Fx_H1001026_passive_star4"
  }
  role.areaTypeEffectName = {
    "Fx_H1001026_passive_starField1",
    "Fx_H1001026_passive_starField2",
    "Fx_H1001026_passive_starField3",
    "Fx_H1001026_passive_starField4"
  }
  role.atk2MisInst = {}
  role.akt3TargetList = {}
  role.heavyMisInst = {}
  role.skill02_Type = 1
  role.skill03WudiLoopTime = 0
  role.posTarget = nil
  role.posMyself = nil
  role.ultWaterAtkTime = 0
  role.ultWaterAtkNumb = 0
  role.passiveEnergyLv = nil
  local cosId = get_role_fashion_id(npc)
  local cosWeaponId = get_role_weapon_fashion_id(npc)
  local traces_magic = {}
  local traces = role.traces
  traces[1026281] = 1
  traces[1026282] = 2
  traces[1026283] = 3
  traces[1026284] = 4
  traces[1026285] = 5
  role.tracesMagic = {
    Lv1 = {magicId = 1026286, bornStaty = true},
    Lv2 = {
      SwordNum = 0,
      magicId = 1026287,
      IntervalTime = 0
    },
    Lv4 = {
      SwordNum = 0,
      magicId = 1026289,
      IntervalTime = 0
    }
  }
  local destinies = role.destinies
  destinies[1026181] = 1
  destinies[1026182] = 2
  destinies[1026183] = 3
  destinies[1026184] = 4
  destinies[1026185] = 5
  role.destiniesMagic = {
    Lv1 = {damageUp = 1026201, damageUp2 = 1026207},
    Lv2 = {damageUp = 1026202},
    Lv3 = {damageUp = 1026203, magicId = 1026208},
    Lv4 = {
      damageUp = 1026204,
      distanceLv = 0,
      skill2staty = true
    },
    Lv5 = {crt = 1026205, crit = 1026209}
  }
  local spWeapon = role.spWeapon
  spWeapon.magic = 1026200
  spWeapon.damageUp = 1026210
  set_keyframe_enable(role.npc, 10010262141, false, true)
  set_keyframe_enable(role.npc, 10010262142, false, true)
  set_keyframe_enable(role.npc, 10010262241, false, true)
  set_keyframe_enable(role.npc, 10010262242, false, true)
  set_keyframe_enable(role.npc, 10010262341, false, true)
  set_keyframe_enable(role.npc, 10010262342, false, true)
  set_keyframe_enable(role.npc, 10010263312, false, true)
  set_keyframe_enable(role.npc, 10010263412, false, true)
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function AddMagic(magic, casterNpc, target)
      if role.nowTime >= 1 then
        cast_magic(role.npc, role.npc, role.tracesMagic.Lv1.magicId, 1)
      end
    end
    
    tool.insert(magics.passiveWeaponArea[1], "onBegin", AddMagic)
    tool.insert(magics.passiveWeaponArea[2], "onBegin", AddMagic)
    tool.insert(magics.passiveWeaponArea[3], "onBegin", AddMagic)
    tool.insert(magics.passiveWeaponArea[4], "onBegin", AddMagic)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function getNum(skill)
      if role.nowTime > role.tracesMagic.Lv2.IntervalTime then
        role.tracesMagic.Lv2.IntervalTime = 0
        
        role.tracesMagic.Lv2.SwordNum = 0
      end
      if role.nowTime <= role.tracesMagic.Lv2.IntervalTime or 0 == role.tracesMagic.Lv2.IntervalTime then
        role.tracesMagic.Lv2.SwordNum = role.tracesMagic.Lv2.SwordNum + 1
        role.tracesMagic.Lv2.IntervalTime = role.nowTime + 3
      end
    end
    
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
      local skillMagic = {
        [1026137] = true,
        [1026139] = true,
        [1026141] = true
      }
      if skillMagic[magic_id] and role.tracesMagic.Lv2.SwordNum >= 1 then
        cast_magic(role.npc, role.npc, role.tracesMagic.Lv2.magicId, role.tracesMagic.Lv2.SwordNum)
      end
    end
    
    tool.insert(misLogics.misSkill3Sword[1], "onBegin", getNum)
    tool.insert(misLogics.misSkill3Sword[2], "onBegin", getNum)
    tool.insert(misLogics.misSkill3Sword[3], "onBegin", getNum)
    tool.insert(role, "before_damage_target", damageUp)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function getNum(magic, casterNpc, target)
      if role.nowTime > role.tracesMagic.Lv4.IntervalTime then
        role.tracesMagic.Lv4.SwordNum = 0
        
        role.tracesMagic.Lv4.IntervalTime = 0
      end
      if role.nowTime < role.tracesMagic.Lv4.IntervalTime or 0 == role.tracesMagic.Lv4.IntervalTime then
        role.tracesMagic.Lv4.SwordNum = role.tracesMagic.Lv4.SwordNum + 1
        role.tracesMagic.Lv4.IntervalTime = role.nowTime + 30
      end
    end
    
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
      local skillMagic = {
        [1026161] = true,
        [1026162] = true,
        [1026163] = true
      }
      if skillMagic[magic_id] and role.tracesMagic.Lv4.SwordNum >= 1 then
        cast_magic(role.npc, role.npc, role.tracesMagic.Lv4.magicId, role.tracesMagic.Lv4.SwordNum)
      end
    end
    
    local function reSet(magic, casterNpc, target)
      role.tracesMagic.Lv4.SwordNum = 0
    end
    
    tool.insert(misLogics.misSkill3Sword[1], "onBegin", getNum)
    tool.insert(misLogics.misSkill3Sword[2], "onBegin", getNum)
    tool.insert(misLogics.misSkill3Sword[3], "onBegin", getNum)
    tool.insert(role, "before_damage_target", damageUp)
    tool.insert(skActs.ult, "onEnd", reSet)
    tool.insert(skActs.ultFast, "onEnd", reSet)
    tool.insert(skActs.ult, "onBreak", reSet)
    tool.insert(skActs.ultFast, "onBreak", reSet)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local skillMagic = {
      [1026136] = true,
      [1026137] = true,
      [1026139] = true
    }
    local skillMagic2 = {
      [1026141] = true
    }
    
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
      if skillMagic[magic_id] then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv1.damageUp, 0)
      end
      if skillMagic2[magic_id] then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv1.damageUp2, 0)
      end
    end
    
    tool.insert(role, "before_damage_target", damageUp)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function AddMagic(magic, casterNpc, target)
      cast_magic(role.npc, role.npc, role.destiniesMagic.Lv2.damageUp, 1)
    end
    
    tool.insert(magics.passiveStatus, "onBegin", AddMagic)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function addMagic()
      role.tracesMagic.Lv4.magicId = role.destiniesMagic.Lv3.damageUp
      
      cast_magic(role.npc, role.npc, role.destiniesMagic.Lv3.magicId, 1)
    end
    
    tool.insert(skActs.ult, "onBegin", addMagic)
    tool.insert(skActs.ultFast, "onBegin", addMagic)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function getDistance()
      role.destiniesMagic.Lv4.distanceLv = role.passiveStarAreaOpenNum - role.passiveAreaType
      
      if role.destiniesMagic.Lv4.distanceLv < 0 then
        role.destiniesMagic.Lv4.distanceLv = role.destiniesMagic.Lv4.distanceLv + 3
      end
    end
    
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
      local skillMagic = {
        [1026121] = true,
        [1026122] = true,
        [1026123] = true,
        [1026125] = true,
        [1026126] = true,
        [1026127] = true,
        [1026128] = true,
        [1026129] = true
      }
      if skillMagic[magic_id] then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv4.damageUp, role.destiniesMagic.Lv4.distanceLv)
      end
    end
    
    tool.insert(skActs.skill02_1, "onBegin", getDistance)
    tool.insert(skActs.skill02_2, "onBegin", getDistance)
    tool.insert(skActs.skill02_3, "onBegin", getDistance)
    tool.insert(role, "before_damage_target", damageUp)
    
    local function skill02Change()
      if role.destiniesMagic.Lv4.skill2staty then
        cast_magic(role.npc, role.npc, role.magics.skill02_TypeChange.id, 1)
      end
    end
    
    tool.insert(skActs.born, "onCastTime", skill02Change)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
      local skillMagic = {
        [1026161] = true,
        
        [1026162] = true,
        [1026163] = true
      }
      if skillMagic[magic_id] and not check_magic(role.npc, role.destiniesMagic.Lv5.crt) then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv5.crt, 0)
      end
    end
    
    tool.insert(role, "before_damage_target", damageUp)
    
    local function damageUp2()
      cast_magic(role.npc, role.npc, role.destiniesMagic.Lv5.crit, 0)
    end
    
    tool.insert(skActs.skill02_1, "onBegin", damageUp2)
    tool.insert(skActs.skill02_2, "onBegin", damageUp2)
    tool.insert(skActs.skill02_3, "onBegin", damageUp2)
    tool.insert(skActs.skill03_ExL, "onBegin", damageUp2)
    tool.insert(skActs.skill03_Ult, "onBegin", damageUp2)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function AddMagic(magic, casterNpc, target)
      if role.nowTime >= 1 then
        cast_magic(role.npc, role.npc, spWeapon.damageUp, role.spWeapon.lv)
      end
    end
    
    tool.insert(magics.passiveWeaponArea[1], "onBegin", AddMagic)
    tool.insert(magics.passiveWeaponArea[2], "onBegin", AddMagic)
    tool.insert(magics.passiveWeaponArea[3], "onBegin", AddMagic)
    tool.insert(magics.passiveWeaponArea[4], "onBegin", AddMagic)
  end
  
  local function cameraReset(speed)
    role:change_follow_target(4)
    change_focus_follow_speed(speed)
  end
  
  function Mina.on_start(role, npc)
    role.base.on_start(role, npc)
    for k, v in pairs(role.passiveStarBaseMap) do
      cast_magic(role.npc, role.npc, v, 1)
    end
    role:doAfter(function()
      role.passiveStarAreaList = {
        northwest = {state = false, magicId = 102605},
        northeast = {state = false, magicId = 102606},
        southeast = {state = false, magicId = 102607},
        southwest = {state = false, magicId = 102608}
      }
      role.passiveStarAreaOpenNum = math.random(4, 4)
      local areaName = {
        "northwest",
        "northeast",
        "southeast",
        "southwest"
      }
      role.passiveStarAreaOpenName = areaName[role.passiveStarAreaOpenNum]
      role.passiveStarAreaList[role.passiveStarAreaOpenName].state = true
      for k, v in pairs(role.passiveStarAreaList) do
        if v.state then
          cast_magic(role.npc, role.npc, v.magicId, 1)
        else
          abort_magic_by_id(role.npc, v.magicId, 1)
        end
      end
      role.passiveAreaType = 1
      local areaTypeName = {
        "northwest",
        "northeast",
        "southeast",
        "southwest"
      }
      role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].state = true
      cast_magic(role.npc, role.npc, role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].magicId, 1)
      role.passiveStatus = false
    end, 1, true)
    set_keyframe_enable_by_tag(role.npc, 100102691, 3001026, false, true)
    set_keyframe_enable_by_tag(role.npc, 100102691, 3003026, false, true)
    set_keyframe_enable_by_tag(role.npc, 100102692, 3001026, false, true)
    set_keyframe_enable_by_tag(role.npc, 100102692, 3003026, false, true)
    set_keyframe_enable_by_tag(role.npc, 100102681, 3001026, false, true)
    set_keyframe_enable_by_tag(role.npc, 100102681, 3003026, false, true)
    if 3001026 == cosId or 3002026 == cosId then
      cast_magic(role.npc, role.npc, 102689, 1)
      set_keyframe_enable_by_tag(role.npc, 100102691, 3001026, true, true)
      set_keyframe_enable_by_tag(role.npc, 100102692, 3001026, true, true)
      set_keyframe_enable_by_tag(role.npc, 100102681, 3001026, true, true)
      role.magicNmaeList = {
        "Fx_H1001026_passive_star1",
        "Fx_H1001026_passive_star2",
        "Fx_H1001026_passive_star3",
        "Fx_H1001026_passive_star4"
      }
      role.areaTypeEffectName = {
        "Fx_H1001026_passive_starField1",
        "Fx_H1001026_passive_starField2",
        "Fx_H1001026_passive_starField3",
        "Fx_H1001026_passive_starField4"
      }
    elseif 3003026 == cosId then
      set_keyframe_enable_by_tag(role.npc, 100102691, 3003026, true, true)
      set_keyframe_enable_by_tag(role.npc, 100102692, 3003026, true, true)
      set_keyframe_enable_by_tag(role.npc, 100102681, 3003026, true, true)
      role.magicNmaeList = {
        "Fx_H1002326_passive_star1",
        "Fx_H1002326_passive_star2",
        "Fx_H1002326_passive_star3",
        "Fx_H1002326_passive_star4"
      }
      role.areaTypeEffectName = {
        "Fx_H1002326_passive_starField1",
        "Fx_H1002326_passive_starField2",
        "Fx_H1002326_passive_starField3",
        "Fx_H1002326_passive_starField4"
      }
    end
  end
  
  function Mina.on_born_behavior(role)
    role.base.on_born_behavior(role)
    if get_come_on_hero() == role.npc and role.destinyLv >= 4 and role.destiniesMagic.Lv4.skill2staty then
      cast_magic(role.npc, role.npc, role.magics.skill02_TypeChange.id, 0)
    end
  end
  
  function skActs.atk1.onBegin(atk1)
    atk1.base.onBegin(atk1)
    local targetList = search_npc(role.npc, 4, 8, nil, false, true)
    for k, v in pairs(targetList) do
      if not check_magic(v, 102611) then
        cast_magic(role.npc, v, 102611, 1)
      end
    end
  end
  
  function skActs.atk2.isReady(atk2)
    if not atk2.base.isReady(atk2) then
      return false
    end
    local role = atk2.role
    local roleAct = role.skAct
    if roleAct == atk2.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif roleAct == skActs.qte then
      return true
    else
      return false
    end
  end
  
  function skActs.atk2.onBegin(atk2)
    atk2.base.onBegin(atk2)
  end
  
  do
    local function passiveHit()
      if role.atk2MisInst[1] and role.atk2MisInst[2] then
        local misPos1 = get_missile_pos(role.atk2MisInst[1])
        
        local misPos2 = get_missile_pos(role.atk2MisInst[2])
        local param1 = {
          npc = role.npc,
          target = nil,
          posx = misPos1.x,
          posz = misPos1.z,
          missile_id = 10010269511,
          missile_level = 0,
          lookat_posx = misPos1.x,
          lookat_posz = misPos1.z,
          lookat_posy = 1,
          posy = nil,
          born_posx = (misPos1.x + misPos2.x) / 2,
          born_posz = (misPos1.z + misPos2.z) / 2,
          born_posy = misPos1.y
        }
        cast_missile3(role.npc, nil, misPos1.x, misPos1.z, 10010260206, 0, misPos1.x, misPos1.z, 1, nil, (misPos1.x + misPos2.x) / 2, (misPos1.z + misPos2.z) / 2, misPos1.y)
      end
    end
    
    misLogics.misAtk2[1].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role.atk2MisInst[1] = misInst
      local setPos = get_npc_pos(npc)
      cast_missile3(role.npc, misInst, setPos.x, setPos.z, 10010260209, 0)
    end
    misLogics.misAtk2[1].onEnd = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role.atk2MisInst[1] = misInst
    end
    misLogics.misAtk2[2].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role.atk2MisInst[2] = misInst
      passiveHit()
    end
    
    function misLogics.misAtk2Camera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        10,
        10,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.055
      })
      cast_magic(role.npc, role.npc, 102425, 1)
    end
    
    function misLogics.misAtk2Camera.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if (role.skAct.name == "atk2" or is_cast_skill_time(role.npc)) and role.skAct.name ~= "atk3" then
        cameraReset(2)
      end
    end
    
    function skActs.atk2.onBreak(atk2, breakSkill)
      if breakSkill.name == "wander" or breakSkill.name == "hurt" then
        cameraReset(8)
      end
    end
    
    skActs.atk3.AreaMissile = nil
    skActs.atk3.AreaMissilePos = nil
    skActs.atk3.AreaTopCastTime = nil
    skActs.atk3.AreaHitCastTime = nil
    skActs.atk3.AreaTopHitCastTime1 = nil
    skActs.atk3.AreaTopHitCastTime2 = nil
    
    function skActs.atk3.onBegin(atk3)
      atk3.base.onBegin(atk3)
      role.akt3TargetList = {}
      skActs.atk3.AreaHitCastTime = role.nowTime + 0.4
      skActs.atk3.AreaTopCastTime = role.nowTime + 0.45 + 0.1
      skActs.atk3.AreaTopHitCastTime1 = role.nowTime + 0.7
      skActs.atk3.AreaTopHitCastTime2 = role.nowTime + 0.9
    end
    
    misLogics.misAtk3Area[1].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      skActs.atk3.AreaMissile = misInst
      skActs.atk3.AreaMissilePos = get_missile_pos(misInst)
    end
    misLogics.misAtk3Area[1].onEnd = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      skActs.atk3.AreaMissile = nil
    end
    
    function skills.atk3.tick()
      if skActs.atk3.AreaMissile and skActs.atk3.AreaTopCastTime and role.nowTime >= skActs.atk3.AreaTopCastTime then
        cast_missile3(role.npc, nil, skActs.atk3.AreaMissilePos.x, skActs.atk3.AreaMissilePos.z, misLogics.misAtk3Area[2].id, 0)
        skActs.atk3.AreaTopCastTime = role.nowTime + 999
      end
    end
    
    misLogics.misAtk3Hit[1].onHit = function(misAtk3Hit, misInst, casterNpc, hitTarget, hitType, skill)
      if 2 == get_role_kind(hitTarget) or 2 == get_npc_status(hitTarget) or 10 == get_npc_status(hitTarget) or 11 == get_npc_status(hitTarget) then
        cast_magic(role.npc, hitTarget, 102613, 1)
        cast_magic(role.npc, hitTarget, 102614, 1)
        table.insert(role.akt3TargetList, hitTarget)
      end
    end
    misLogics.misAtk3Hit[2].onHit = function(misAtk3Hit, misInst, casterNpc, hitTarget, hitType, skill)
      for k, v in pairs(role.akt3TargetList) do
        abort_magic_by_id(v, 102613, 1)
      end
      local setPos = get_missile_pos(misInst)
      cast_missile3(role.npc, nil, setPos.x, setPos.z, misLogics.misAtk3Camera.id, 0)
    end
    misLogics.misAtk3Area[2].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      local setPos = get_missile_pos(misInst)
      role:doAfter(function(role)
        cast_missile3(role.npc, nil, setPos.x, setPos.z, misLogics.misAtk3Area[3].id, 0)
      end, 0.25, true)
    end
    
    function misLogics.misAtk3Camera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        10,
        10,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.055
      })
      cast_magic(role.npc, role.npc, 102425, 1)
    end
    
    function misLogics.misAtk3Camera.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if role.skAct == role.skActs.atk3 then
        cameraReset(2)
      end
    end
    
    function skActs.atk3.onBreak(atk3, breakSkill)
      if breakSkill.name == "wander" or breakSkill.name == "hurt" then
        cameraReset(8)
      end
    end
    
    function skills.atk4.tarPos(atk4)
      if role.target and not check_npc_die(role.target) and not check_npc_distance(role.npc, role.target, 5, true) then
        role.skills.atk4.pos = get_position_offset_position(get_npc_pos(role.target), get_npc_pos(role.npc), 0, 2)
      else
        role.skills.atk4.pos = get_npc_offset_position(role.npc, nil, 0, 6)
      end
      return role.skills.atk4.pos
    end
    
    function skActs.atk4.onBegin(atk4)
      atk4.base.onBegin(atk4)
      if role.target and not check_npc_distance(role.npc, role.target, 3, false) then
        set_keyframe_enable(role.npc, 10010260436, true, true)
      else
        set_keyframe_enable(role.npc, 10010260436, false, true)
      end
    end
    
    function misLogics.misAtk4Camera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        10,
        10,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.025,
        0,
        1
      })
      cast_magic(role.npc, role.npc, 102425, 1)
      skActs.atk4.camera = misInst
    end
    
    function misLogics.misAtk4Camera.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if role.skAct == role.skActs.atk4 then
        cameraReset(1)
      end
      skActs.atk4.camera = nil
    end
    
    function skActs.atk4.onBreak(atk4, breakSkill)
      if breakSkill.name == "wander" or breakSkill.name == "hurt" then
        cameraReset(8)
      end
    end
    
    local function heavyHit()
      if role.heavyMisInst[1] and role.heavyMisInst[2] then
        local misPos1 = get_missile_pos(role.heavyMisInst[1])
        local misPos2 = get_missile_pos(role.heavyMisInst[2])
        cast_missile3(role.npc, nil, misPos1.x, misPos1.z, 10010260506, 0, misPos1.x, misPos1.z, 1, nil, (misPos1.x + misPos2.x) / 2, (misPos1.z + misPos2.z) / 2, misPos1.y)
      end
    end
    
    function skActs.heavy.onBegin(heavy)
      heavy.base.onBegin(heavy)
      local targetList = search_npc(role.npc, 4, 8, nil, false, true)
      for k, v in pairs(targetList) do
        if not check_magic(v, 102611) then
          cast_magic(role.npc, v, 102611, 1)
        end
      end
    end
    
    misLogics.misHeavy[1].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role.heavyMisInst[1] = misInst
      play_effect_anim(role.npc, "Fx_H1001023_atk03_3", "Break")
    end
    misLogics.misHeavy[1].onEnd = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role.heavyMisInst[1] = misInst
    end
    misLogics.misHeavy[2].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role.heavyMisInst[2] = misInst
      heavyHit()
      local setPos = get_npc_pos(misInst)
      cast_missile3(role.npc, misInst, setPos.x, setPos.z, 10010260507, 0)
    end
  end
  magics.passiveWeaponArea[1].onBegin = function(magic, casterNpc, target)
    set_localrotation_component(role.npc, "Bip002", 0, 0, 60, 5, false)
  end
  magics.passiveWeaponArea[2].onBegin = function(magic, casterNpc, target)
    set_localrotation_component(role.npc, "Bip002", 0, 0, 180, 5, false)
  end
  magics.passiveWeaponArea[3].onBegin = function(magic, casterNpc, target)
    set_localrotation_component(role.npc, "Bip002", -30, 10, 70, 5, false)
  end
  magics.passiveWeaponArea[4].onBegin = function(magic, casterNpc, target)
    set_localrotation_component(role.npc, "Bip002", 0, -5, 0, 5, false)
  end
  
  function skills.dashOut.onBegin(dashOut)
    dashOut.base.onBegin(dashOut)
    cameraReset(5)
    local list = get_npc_cd_charge(role.npc, 100102623)
  end
  
  function skills.dashIn.onBegin(dashIn)
    dashIn.base.onBegin(dashIn)
    cameraReset(5)
    local list = get_npc_cd_charge(role.npc, 100102622, get_skill_cfg(100102622).CdChargeTimes)
  end
  
  function skills.counter.onBegin(counter)
    counter.base.onBegin(counter)
    remove_missile_by_id(10010261011, role.npc)
  end
  
  misLogics.misSkill2Hit[1].missile = nil
  misLogics.misSkill2Hit[1].isMove = true
  misLogics.misSkill2Hit[1].onHit = function(misSkill2Hit, misInst, casterNpc, hitTarget, hitType, skill)
    if misLogics.misSkill2Hit[1].isMove then
      misLogics.misSkill2Hit[1].isMove = false
      change_missile_move_params(misInst, 0, 0)
      local posBorn = get_missile_pos(misInst)
      cast_missile3(role.npc, nil, posBorn.x, posBorn.z, 10010262152, 0)
      misLogics.misSkill2Hit[1].missile = misInst
    end
  end
  misLogics.misSkill2Hit[1].onEnd = function(misSkill2Hit, misInst, casterNpc, hitTarget, hitType, skill)
    local setPos = get_missile_pos(misInst)
    misLogics.misSkill2Hit[1].isMove = true
  end
  misLogics.misSkill2Hit[2].isHit = false
  misLogics.misSkill2Hit[2].onHit = function(misSkill2Hit, misInst, casterNpc, hitTarget, hitType, skill)
    if misLogics.misSkill2Hit[2].isHit == false then
      misLogics.misSkill2Hit[2].isHit = true
    end
  end
  do
    local atkActs = {
      skActs.skill02_1,
      skActs.skill02_2,
      skActs.skill02_3
    }
    for i, atkAct in ipairs(atkActs) do
      atkAct.reset = {timer = 0, delay = 0.2}
      
      function atkAct.onCastTime(skAct)
        skAct.reset.timer = get_npc_time(skAct.role.npc) + skAct.reset.delay + 2
        skAct.base.onCastTime(skAct)
      end
    end
    for i = 2, #atkActs do
      local atk = atkActs[i]
      atk.preAtk = atkActs[i - 1]
      atk.dashOut = skActs.dashOut
      atk.dashIn = skActs.dashIn
      
      function atk.isReady(atk)
        if not atk.base.isReady(atk) then
          return false
        end
        local role = atk.role
        local roleAct = role.skAct
        if atk.name == "skill02_2" and (role.skAct == role.skActs.skill03_SpL or role.skAct == role.skActs.skill03_ExL) then
          return true
        elseif roleAct == atk.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
          return true
        elseif roleAct == atk.dashOut or roleAct == atk.dashIn then
          local preAct = roleAct.preAct
          return preAct == atk.preAtk
        else
          return false
        end
      end
    end
    
    local function Skill02TransEnableReset(role)
      skActs.skill02_1.trans.enable.skill03_ExL = nil
      skActs.skill02_2.trans.enable.skill03_ExL = nil
      skActs.skill02_3.trans.enable.skill03_ExL = nil
      skActs.skill02_1.trans.enable.skill03_SpL = nil
      skActs.skill02_2.trans.enable.skill03_SpL = nil
      skActs.skill02_3.trans.enable.skill03_SpL = nil
      skActs.skill02_1.trans.enable.skill03_SpR = nil
      skActs.skill02_2.trans.enable.skill03_SpR = nil
      skActs.skill02_3.trans.enable.skill03_SpR = nil
    end
    
    function magics.skill02_skill03LinkTime.onBegin(magic, casterNpc, target)
      skActs.skill02_1.trans.enable.skill03_ExL = "skill03_ExL"
      skActs.skill02_2.trans.enable.skill03_ExL = "skill03_ExL"
      skActs.skill02_3.trans.enable.skill03_ExL = "skill03_ExL"
      skActs.skill02_1.trans.enable.skill03_SpL = "skill03_SpL"
      skActs.skill02_2.trans.enable.skill03_SpL = "skill03_SpL"
      skActs.skill02_3.trans.enable.skill03_SpL = "skill03_SpL"
      skActs.skill02_1.trans.enable.skill03_SpR = "skill03_SpR"
      skActs.skill02_2.trans.enable.skill03_SpR = "skill03_SpR"
      skActs.skill02_3.trans.enable.skill03_SpR = "skill03_SpR"
    end
    
    function magics.skill02_skill03LinkTime.onEnd(magic, casterNpc, target)
      skActs.skill02_1.trans.enable.skill03_ExL = nil
      skActs.skill02_2.trans.enable.skill03_ExL = nil
      skActs.skill02_3.trans.enable.skill03_ExL = nil
      skActs.skill02_1.trans.enable.skill03_SpL = nil
      skActs.skill02_2.trans.enable.skill03_SpL = nil
      skActs.skill02_3.trans.enable.skill03_SpL = nil
      skActs.skill02_1.trans.enable.skill03_SpR = nil
      skActs.skill02_2.trans.enable.skill03_SpR = nil
      skActs.skill02_3.trans.enable.skill03_SpR = nil
    end
    
    function icons.skill02ButtonCd.updateEnhance(skill02ButtonCd)
      if 1 == role.skill02_Type then
        skill02ButtonCd.isEnhance = false
      else
        skill02ButtonCd.isEnhance = true
      end
    end
    
    function magics.skill02_TypeChange.onBegin(magic, casterNpc, target)
      if role:isRampage() then
        if not check_magic(role.npc, role.magics.skill02_TypeChangeIsRampage.id) then
          cast_magic(role.npc, role.npc, role.magics.skill02_TypeChangeIsRampage.id, 1)
        end
        return
      end
      local sk1 = role.btns.sk1
      local skill02
      if role.skAct.name == "heavy" then
        skill02 = role.icons.skill02_2
        role.skill02_Type = 2
      else
        skill02 = role.icons.skill02_3
        role.skill02_Type = 3
      end
      cast_magic(role.npc, role.npc, 102674, 1)
      cast_magic(role.npc, role.npc, 102675, 1)
      if role.destinyLv >= 4 and role.destiniesMagic.Lv4.skill2staty then
        role.destiniesMagic.Lv4.skill2staty = false
        skill02 = role.icons.skill02_3
        role.skill02_Type = 3
      end
      if get_npc_cd_charge(role.npc, 100102628) < get_skill_cfg(100102628).CdChargePerCost and role.btns.sk1.icon.name == "skill02ButtonCd" then
        skill02 = role.icons.skill02ButtonCd
      end
      sk1:setIcon(skill02)
      if role.skAct == role.skActs.skill03_ExL then
        cast_magic(role.npc, role.npc, 102698, 1)
      end
    end
    
    function magics.skill02_TypeChange.onEnd(magic, casterNpc, target)
      if role:isRampage() then
        return
      end
      local sk1 = role.btns.sk1
      local skill02 = role.icons.skill02_1
      sk1:setIcon(skill02)
      role.skill02_Type = 1
      cast_magic(role.npc, role.npc, 102674, 1)
      cast_magic(role.npc, role.npc, 102675, 1)
    end
    
    function magics.skill02_TypeChangeIsRampage.onBegin(magic, casterNpc, target)
      local sk1 = role.btns.sk1
      local skill02 = role.icons.skill02_3
      cast_magic(role.npc, role.npc, 102675, 1)
      role.skill02_Type = 3
      sk1:setIcon(skill02)
    end
    
    function magics.skill02_TypeChangeIsRampage.onEnd(magic, casterNpc, target)
      local sk1 = role.btns.sk1
      local skill02 = role.icons.skill02_1
      sk1:setIcon(skill02)
      role.skill02_Type = 1
    end
    
    role.skills.skill02_1.pos = 0
    
    function skills.skill02_1.tarPos(skill02_1)
      if role.target and not check_npc_die(role.target) and not check_npc_distance(role.npc, role.target, 2, true) then
        role.skills.skill02_1.pos = get_position_offset_position(get_npc_pos(role.target), get_npc_pos(role.npc), 180, 1)
      else
        role.skills.skill02_1.pos = get_npc_offset_position(role.npc, nil, 0, 1)
      end
      return role.skills.skill02_1.pos
    end
    
    function skActs.skill02_1.onBegin(skill02_1)
      skill02_1.base.onBegin(skill02_1)
      Skill02TransEnableReset(role)
      cameraReset(10)
      cast_magic(role.npc, role.npc, 102660, 1)
      cast_magic(role.npc, role.npc, 102697, 1)
      if 1 == role.skill02_Type then
        local sk1 = role.btns.sk1
        local skill02 = role.icons.skill02ButtonCd
        sk1:setIcon(skill02)
      end
    end
    
    function skActs.skill02_1.onBefTime(skill02_1)
      local energyList = {
        nil,
        102692,
        102693
      }
      if energyList[role.skill02_Type] and not role:isRampage() then
        cast_magic(role.npc, role.npc, energyList[role.skill02_Type], 1)
      end
      role:revolveArea()
      if 2 == role.skill02_Type and 0 == get_npc_cd_charge(role.npc, 100102626) then
        abort_magic_by_id(role.npc, role.magics.skill02_TypeChange.id, 1)
      elseif 3 == role.skill02_Type and 0 == get_npc_cd_charge(role.npc, 100102627) then
        abort_magic_by_id(role.npc, role.magics.skill02_TypeChange.id, 1)
      end
    end
    
    role.skills.skill02_2.pos = nil
    set_keyframe_enable_by_tag(role.npc, 100102622, 100102622, false, true)
    
    function skills.skill02_2.tarPos(skill02_2)
      local animName = skill02_2.animName
      if role.target then
        local distance = get_npc_distance(role.npc, 1, role.target, true)
        local distanceMove = distance + 2.5
        local distanceFix = distanceMove / 5
        local distanceFixList = {
          1,
          1,
          1,
          1,
          1,
          1,
          1,
          1,
          1,
          1,
          1,
          1,
          1,
          distanceFix,
          distanceFix,
          distanceFix,
          distanceFix,
          distanceFix,
          distanceFix,
          distanceFix,
          distanceFix,
          distanceFix
        }
        role:set_move_scale(animName, distanceFixList)
        if distance >= 5 then
          set_keyframe_enable_by_tag(role.npc, 100102622, 100102622, true, true)
        else
          set_keyframe_enable_by_tag(role.npc, 100102622, 100102622, false, true)
        end
        role.skills.skill02_2.pos = get_position_offset_position(get_npc_pos(role.target), get_npc_pos(role.npc), 180, 3)
      else
        role.skills.skill02_2.pos = get_npc_offset_position(role.npc, nil, 0, 3)
      end
      return role.skills.skill02_2.pos, true
    end
    
    function skActs.skill02_2.onBegin(skill02_2)
      skill02_2.base.onBegin(skill02_2)
      role.skActs.skill02_1.trans.enable.skill02_2 = nil
      Skill02TransEnableReset(role)
      skActs.skill02_2.missilePos = role.target and get_npc_pos(role.target) or get_npc_pos(role.npc)
      misLogics.misSkill2Hit[2].isHit = false
    end
    
    function skActs.skill02_2.onBefTime(skill02_2)
      local energyList = {
        nil,
        102692,
        102693
      }
      if energyList[role.skill02_Type] and not role:isRampage() then
        cast_magic(role.npc, role.npc, energyList[role.skill02_Type], 1)
      end
      role:revolveArea()
      if 2 == role.skill02_Type then
        abort_magic_by_id(role.npc, role.magics.skill02_TypeChange.id, 1)
      end
    end
    
    misLogics.misSkill2_2Collide[2].onHit = function(misSkill2_2Collide, misInst, casterNpc, hitTarget, hitType, skill)
      local posSet = get_npc_pos(hitTarget)
      cast_missile3(role.npc, hitTarget, posSet.x, posSet.z, 10010262213, 0)
    end
    misLogics.misSkill2_2CollideQte[2].onHit = function(misSkill2_2Collide, misInst, casterNpc, hitTarget, hitType, skill)
      local posSet = get_npc_pos(hitTarget)
      cast_missile3(role.npc, hitTarget, posSet.x, posSet.z, 10010264113, 0)
    end
    
    local function reSetStatus()
      if check_magic(npc, 102654) then
        abort_magic_by_id(role.npc, 102654, 1)
      end
      if check_magic(npc, 102655) then
        abort_magic_by_id(role.npc, 102655, 1)
      end
    end
    
    function skActs.skill02_2.onBreak(skill02_2, breakSkill)
      if breakSkill.name == "wander" or breakSkill.name == "skill03_SpL" or breakSkill.name == "skill03_SpR" or breakSkill.name == "skill03_ExL" then
        cameraReset(30)
      else
        cameraReset(4)
      end
      reSetStatus()
    end
    
    function skActs.skill02_3.onBreak(skill02_3, breakSkill)
      if breakSkill.name == "wander" or breakSkill.name == "skill03_SpL" or breakSkill.name == "skill03_SpR" or breakSkill.name == "skill03_ExL" then
        cameraReset(30)
      else
        cameraReset(4)
      end
      reSetStatus()
    end
    
    role.skActs.skill02_3.missileId = {
      skill2_3Atk1 = 10010262311,
      skill2_3Atk2 = 10010262313,
      skill2_3Atk3 = 10010262315
    }
    
    function skActs.skill02_3.onBegin(skill02_3)
      skill02_3.base.onBegin(skill02_3)
      Skill02TransEnableReset(role)
      skActs.skill02_3.missilePos = role.target and get_npc_pos(role.target) or get_npc_pos(role.npc)
      local pos = get_position_offset_position(skActs.skill02_3.missilePos, get_npc_pos(role.npc), 0, 3.5)
      skActs.skill02_3.flashPosIs, skActs.skill02_3.flashPos = get_nearest_walkable_pos(get_npc_pos(role.npc), pos, 1)
      skActs.skill02_3.flashLookPos = role.target and get_npc_pos(role.target) or get_npc_pos(role.npc)
    end
    
    function skActs.skill02_3.onBefTime(skill02_3)
      local energyList = {
        nil,
        102692,
        102693
      }
      if energyList[role.skill02_Type] and not role:isRampage() then
        cast_magic(role.npc, role.npc, energyList[role.skill02_Type], 1)
      end
      role:revolveArea()
      if 3 == role.skill02_Type then
        abort_magic_by_id(role.npc, role.magics.skill02_TypeChange.id, 1)
      end
    end
    
    function misLogics.misSkill2_3Camera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      local pos = get_missile_pos(misInst)
      if role.skAct == role.skActs.skill02_3 then
        role:change_follow_target(1, misInst, {
          10,
          10,
          {
            x = 0,
            y = 0,
            z = 0
          },
          0,
          0,
          0.055
        })
      end
    end
    
    function misLogics.misSkill2_3Camera.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if (role.skAct.name == "skill02_3" or is_cast_skill_time(role.npc)) and role.skAct.name ~= "skill03_SpL" then
        change_focus_follow_speed(4)
        role:change_follow_target(4)
      end
    end
  end
  role.skills.skill03_ExL.pos = nil
  
  function skills.skill03_ExL.tarPos(atk3)
    if role.target then
      if get_npc_distance(role.npc, 1, role.target, false) >= 5 or get_npc_distance(role.npc, 1, role.target, false) <= 2 then
        set_keyframe_enable(role.npc, 10010263841, false, true)
      else
        set_keyframe_enable(role.npc, 10010263841, true, true)
      end
      role.skills.skill03_ExL.pos = get_position_offset_position(get_npc_pos(role.target), get_npc_pos(role.npc), 0, 1.5)
    else
      role.skills.skill03_ExL.pos = get_npc_offset_position(role.npc, nil, 0, 3)
    end
    return role.skills.skill03_ExL.pos, true
  end
  
  function skActs.skill03_ExL.onBegin(skill03_ExL)
    skill03_ExL.base.onBegin(skill03_ExL)
    cast_magic(role.npc, role.npc, role.magics.passiveEnergy.normal.id, 1)
    role:resetAreaWhenSkill3()
  end
  
  function skActs.skill03_SpL.isReady(skill03_SpL)
    if not skill03_SpL.base.isReady(skill03_SpL) then
      return false
    end
    return true
  end
  
  function skActs.skill03_SpR.isReady(skill03_SpR)
    if not skill03_SpR.base.isReady(skill03_SpR) then
      return false
    end
    return false
  end
  
  skActs.skill03_SpL.MaxNumb = 0
  
  function skActs.skill03_SpL.ultState(skill03_SpL)
    if get_npc_attr(role.npc, 74) or role:isRampage() then
      cast_magic(role.npc, role.npc, magics.skill03SpMaxState.id, 1)
    end
  end
  
  function magics.skill03SpMaxState.onBegin(magic, casterNpc, target)
    local sk2 = role.btns.sk2
    local skill03 = role.icons.skill03_Ult
    sk2:setIcon(skill03)
    set_keyframe_enable(role.npc, 10010263312, true, false)
    set_keyframe_enable(role.npc, 10010263412, true, false)
    skActs.skill03_Ult.angel = {
      math.random(0, 60),
      math.random(-60, 0),
      math.random(0, 60),
      math.random(-60, 0)
    }
    local posTarget = role.target and get_npc_pos(role.target) or get_npc_offset_position(role.npc, nil, 0, 5.5)
    skActs.skill03_Ult.posSet = {
      get_position_offset_position(posTarget, get_npc_pos(role.npc), skActs.skill03_Ult.angel[1], 4),
      get_position_offset_position(posTarget, get_npc_pos(role.npc), skActs.skill03_Ult.angel[2], 4),
      get_position_offset_position(posTarget, get_npc_pos(role.npc), skActs.skill03_Ult.angel[3], 4),
      get_position_offset_position(posTarget, get_npc_pos(role.npc), skActs.skill03_Ult.angel[4], 4)
    }
    skActs.skill03_Ult.posNumb = 1
  end
  
  function magics.skill03SpMaxState.onEnd(magic, casterNpc, target)
    role:resetArea(2, 4)
  end
  
  function skActs.skill03_SpL.onBegin(skill03_SpL)
    skill03_SpL.base.onBegin(skill03_SpL)
    skActs.skill03_Ult.AerialState = true
    if get_npc_attr(role.npc, 74) < 100 and not role:isRampage() then
      role:resetAreaWhenSkill3()
    else
      role.skActs.skill03_SpL.MaxNumb = 4
      skActs.skill03_SpL.ultState()
    end
    cast_magic(role.npc, role.npc, 102666, 1)
    role.skill03WudiLoopTime = role.nowTime + 4
    misLogics.misSkill3MaxCamera.bornPos = {}
    misLogics.misSkill3MaxCamera.bornPosFixList = {
      1,
      0.6,
      0.3,
      0.05
    }
    skActs.skill03_Ult.Rage = skActs.skill03_Ult.RageList[1]
  end
  
  function skActs.skill03_SpL.onCastTime(skill03_SpL)
    skill03_SpL.base.onCastTime(skill03_SpL)
    change_focus_follow_speed(2)
    role:change_follow_target(4)
    if not check_magic(role.npc, 102617) then
    end
  end
  
  function skActs.skill03_SpL.ResetTransEnable(skill03_Ult)
    skActs.skill03_SpL.trans.enable.skill02_2 = nil
    skActs.skill03_SpR.trans.enable.skill02_2 = nil
    skActs.skill03_SpL.trans.enable.skill03_Ult = nil
    skActs.skill03_SpL.trans.enable.skill03_UltR = nil
    skActs.skill03_SpR.trans.enable.skill03_Ult = nil
    skActs.skill03_SpR.trans.enable.skill03_UltR = nil
    skActs.skill03_SpL.trans.disable.dashOut = "dashOut"
    skActs.skill03_SpL.trans.disable.dashIn = "dashIn"
  end
  
  function skActs.skill03_SpL.onEnd(skill03_4)
    change_focus_follow_speed(10)
    role:change_follow_target(4)
    skActs.skill03_SpL.ResetTransEnable()
  end
  
  function skActs.skill03_SpL.onBreak(skill03_SpL, breakSkill)
    if breakSkill.name == "wander" then
      change_focus_follow_speed(10)
      role:change_follow_target(4)
    end
    if breakSkill ~= role.skActs.skill03_Ult and breakSkill ~= role.skActs.skill03_UltR and skActs.skill03_Ult.AerialState then
      cast_magic(role.npc, role.npc, 102646, 1)
      cast_magic(role.npc, role.npc, 102647, 1)
    end
    skActs.skill03_SpL.ResetTransEnable()
    if breakSkill ~= role.skActs.skill03_Ult and breakSkill ~= role.skActs.skill03_UltR then
      abort_magic_by_id(role.npc, role.magics.skill03SpMaxState.id, 1)
    end
    if misLogics.misSkill3Camera.misInst then
      change_missile_move_params(misLogics.misSkill3Camera.misInst, 0, 0)
    end
    role.skill03WudiLoopTime = 0
  end
  
  do
    local function skill03Camera()
      if misLogics.misSkill3Camera.misInst then
        misLogics.misSkill3Camera.isKeepTime = get_npc_time(role.npc)
        
        if misLogics.misSkill3Camera.isKeepTime - misLogics.misSkill3Camera.isBornTime >= 0.4 then
          change_missile_move_params(misLogics.misSkill3Camera.misInst, 0, 0)
          misLogics.misSkill3Camera.misInst = nil
        end
      end
    end
    
    skills.skill03_SpL.tick = skill03Camera
    misLogics.misSkill3CameraReset[1].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.1,
        0,
        1
      })
    end
    misLogics.misSkill3CameraReset[2].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.1,
        0,
        1
      })
    end
    
    function misLogics.misSkill3Camera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        1,
        0,
        1
      })
      misLogics.misSkill3Camera.misInst = misInst
      misLogics.misSkill3Camera.isBornTime = get_npc_time(role.npc)
    end
    
    misLogics.misSkill3MaxCamera.misInst = nil
    misLogics.misSkill3MaxCamera.moveEndPos = nil
    misLogics.misSkill3MaxCamera.startPos = nil
    misLogics.misSkill3MaxCamera.TargetPos = nil
    misLogics.misSkill3MaxCamera.selfPos = nil
    misLogics.misSkill3MaxCamera.bornPosFixList = {
      1,
      0.6,
      0.3,
      0.05
    }
    misLogics.misSkill3MaxCamera.rageList = {
      30,
      -30,
      30,
      -30
    }
    misLogics.misSkill3MaxCamera.bornPos = {
      nil,
      nil,
      nil,
      nil
    }
    
    function misLogics.misSkill3MaxCamera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.05,
        0,
        1
      })
      misLogics.misSkill3MaxCamera.misInst = misInst
    end
    
    function misLogics.misSkill3MaxCamera.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      misLogics.misSkill3MaxCamera.misInst = nil
    end
    
    function misLogics.misSkill3ExCameraStop.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.5
      })
    end
    
    function misLogics.misSkill3ExCameraStop.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if get_come_on_hero() == role.npc and role.skAct.name ~= "skill03_ExL" then
        change_focus_follow_speed(4)
        role:change_follow_target(4)
      end
    end
    
    function misLogics.misSkill3ExCameraMove.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.035,
        0,
        1
      })
    end
    
    function misLogics.misSkill3ExCameraMove.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if get_come_on_hero() == role.npc and role.skAct.name ~= "skill03_ExL" then
        change_focus_follow_speed(4)
        role:change_follow_target(4)
      end
    end
    
    function misLogics.misSkill3ExCamera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.1,
        0,
        1
      })
    end
    
    function misLogics.misSkill3ExCamera.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if get_come_on_hero() == role.npc and role.skAct.name == "skill03_ExL" then
        change_focus_follow_speed(2.5)
        role:change_follow_target(4)
      end
    end
    
    misLogics.misSkill3Pos[1].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      local distanceMisInst = get_npc_missile_distance(role.npc, misInst)
      local distanceFix = 3
      local misInstPos = get_missile_pos(misInst)
      if distanceMisInst < 7 then
        distanceFix = 7 - distanceMisInst + distanceFix
      end
      local posSet = get_npc_offset_position(role.npc, misInstPos, 180, distanceFix)
      cast_missile3(role.npc, misInst, posSet.x, posSet.z, role.misLogics.misSkill3Sword[1].id, 0)
      misLogics.misSkill3MaxCamera.TargetPos = misInstPos
      misLogics.misSkill3MaxCamera.selfPos = get_npc_pos(role.npc)
      misLogics.misSkill3MaxCamera.moveEndPos = get_npc_offset_position(misInst, get_npc_pos(role.npc), 180, 1)
    end
    misLogics.misSkill3Pos[2].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      local distanceMisInst = get_npc_missile_distance(role.npc, misInst)
      local distanceFix = 3
      local misInstPos = get_missile_pos(misInst)
      if distanceMisInst < 7 then
        distanceFix = 7 - distanceMisInst + distanceFix
      end
      local posSet = get_npc_offset_position(role.npc, misInstPos, 180, distanceFix)
      cast_missile3(role.npc, misInst, posSet.x, posSet.z, role.misLogics.misSkill3Sword[2].id, 0)
      misLogics.misSkill3MaxCamera.TargetPos = get_missile_pos(misInst)
      misLogics.misSkill3MaxCamera.selfPos = get_npc_pos(role.npc)
      misLogics.misSkill3MaxCamera.moveEndPos = get_npc_offset_position(misInst, get_npc_pos(role.npc), 180, 1)
    end
    misLogics.misSkill3Pos[3].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      local distanceMisInst = get_npc_missile_distance(role.npc, misInst)
      local distanceFix = 3
      local misInstPos = get_missile_pos(misInst)
      if distanceMisInst < 7 then
        distanceFix = 7 - distanceMisInst + distanceFix
      end
      local posSet = get_npc_offset_position(role.npc, misInstPos, 180, distanceFix)
      cast_missile3(role.npc, misInst, posSet.x, posSet.z, role.misLogics.misSkill3Sword[3].id, 0)
      misLogics.misSkill3MaxCamera.TargetPos = get_missile_pos(misInst)
      misLogics.misSkill3MaxCamera.selfPos = get_npc_pos(role.npc)
      misLogics.misSkill3MaxCamera.moveEndPos = get_npc_offset_position(misInst, get_npc_pos(role.npc), 180, 1)
    end
    misLogics.misSkill3Sword[1].onEnd = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      local posSet = get_missile_pos(misInst)
      local SwordEndId = role:isRampage() and 10010263533 or 10010263033
      cast_missile3(role.npc, nil, posSet.x, posSet.z, SwordEndId, 0)
    end
    misLogics.misSkill3Sword[2].onEnd = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      local posSet = get_missile_pos(misInst)
      local posLookSet = get_npc_offset_position(misInst, nil, 0, 3)
      cast_missile3(role.npc, nil, posSet.x, posSet.z, 10010263013, 0, posLookSet.x, posLookSet.z)
    end
    misLogics.misSkill3Sword[3].onEnd = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      local posSet = get_missile_pos(misInst)
      cast_missile3(role.npc, nil, posSet.x, posSet.z, 10010263543, 0)
    end
    misLogics.misSkill3SwordMaxEffect.loopTime = 0
    
    function misLogics.misSkill3SwordMaxEffect.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      misLogics.misSkill3SwordMaxEffect.loopTime = get_npc_time(role.npc) + 1
      misLogics.misSkill3SwordMaxEffect.misInst = misInst
    end
    
    function misLogics.misSkill3SwordMaxEffect.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      misLogics.misSkill3SwordMaxEffect.misInst = nil
    end
    
    function misLogics.misSkill3SwordMaxEffect2.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      misLogics.misSkill3SwordMaxEffect.loopTime = misLogics.misSkill3SwordMaxEffect.loopTime + 0.45
    end
    
    function misLogics.misSkill3SwordMaxEffect3.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      misLogics.misSkill3SwordMaxEffect.loopTime = misLogics.misSkill3SwordMaxEffect.loopTime + 0.45
    end
    
    function skActs.skill03_Ult.checkAeraState(skill03_Ult)
      if role:isRampage() then
        return
      end
      if role.skActs.skill03_SpL.MaxNumb >= 1 then
        local areaTypeName = {
          "northwest",
          "northeast",
          "southeast",
          "southwest"
        }
        local areaTypeEffectName = role.areaTypeEffectName
        role.passiveStarAreaList[areaTypeName[role.skActs.skill03_SpL.MaxNumb]].state = false
        abort_magic_by_id(role.npc, role.passiveStarAreaList[areaTypeName[role.skActs.skill03_SpL.MaxNumb]].magicId, 1)
        play_effect_anim(role.npc, areaTypeEffectName[role.skActs.skill03_SpL.MaxNumb], "dark")
        role.skActs.skill03_SpL.MaxNumb = role.skActs.skill03_SpL.MaxNumb - 1
      end
      if role.skActs.skill03_SpL.MaxNumb < 1 then
        abort_magic_by_id(role.npc, role.magics.skill03SpMaxState.id, 1)
        remove_missile_by_id(10010263022, role.npc)
      end
    end
    
    function skActs.skill03_Ult.isReady(skill03_Ult)
      if not skill03_Ult.base.isReady(skill03_Ult) or role.skAct.name == "skill03_Ult" then
        return false
      end
      return true
    end
    
    function skActs.skill03_UltR.isReady(skill03_UltR)
      if not skill03_UltR.base.isReady(skill03_UltR) or role.skAct.name == "skill03_UltR" then
        return false
      end
      return true
    end
    
    skActs.skill03_Ult.RageList = {
      [1] = {
        60,
        -60,
        45,
        -45
      },
      [2] = {
        15,
        -70,
        60,
        -60
      },
      [3] = {
        60,
        -30,
        15,
        -15
      },
      [4] = {
        45,
        -40,
        30,
        -30
      }
    }
    skActs.skill03_Ult.Rage = skActs.skill03_Ult.RageList[1]
    skActs.skill03_Ult.flashPos = nil
    skActs.skill03_Ult.flashPosFix = 2.5
    skActs.skill03_Ult.flashLookPos = nil
    skActs.skill03_Ult.posNumb = 1
    skActs.skill03_Ult.AerialState = true
    
    function skActs.skill03_Ult.onBegin(skill03_Ult)
      skill03_Ult.base.onBegin(skill03_Ult)
      skActs.skill03_Ult.AerialState = true
      if get_npc_attr(role.npc, 74) >= 100 or role:isRampage() then
        role.passiveStarAreaList = {
          northwest = {state = true, magicId = 102605},
          northeast = {state = true, magicId = 102606},
          southeast = {state = true, magicId = 102607},
          southwest = {state = true, magicId = 102608}
        }
        for k, v in pairs(role.passiveStarAreaList) do
          if v.state then
            cast_magic(role.npc, role.npc, v.magicId, 1)
          else
            abort_magic_by_id(role.npc, v.magicId, 1)
          end
        end
        abort_magic_by_id(role.npc, role.magics.skill02_TypeChange.id)
      end
      local bornPos = misLogics.misSkill3MaxCamera.TargetPos
      local posFix = get_npc_distance(role.npc, 2, bornPos.x, bornPos.z, false) / 2 * 1
      local posSet
      posSet = get_position_offset_position(bornPos, get_npc_pos(role.npc), 0, 3 * misLogics.misSkill3MaxCamera.bornPosFixList[skActs.skill03_Ult.posNumb])
      table.insert(misLogics.misSkill3MaxCamera.bornPos, skActs.skill03_Ult.posNumb, posSet)
      cast_missile3(role.npc, nil, misLogics.misSkill3MaxCamera.bornPos[skActs.skill03_Ult.posNumb].x, misLogics.misSkill3MaxCamera.bornPos[skActs.skill03_Ult.posNumb].z, misLogics.misSkill3MaxCamera.id, 0)
      skActs.skill03_Ult.checkAeraState()
      if not role:isRampage() then
        cast_magic(role.npc, role.npc, 102673, 1)
      end
    end
    
    function skActs.skill03_Ult.onCastTime(skill03_Ult)
      skill03_Ult.base.onCastTime(skill03_Ult)
    end
    
    function skActs.skill03_Ult.onBreak(skill03_Ult, breakSkill)
      remove_missile_by_id(misLogics.misSkill3MaxCamera.id, role.npc)
      if breakSkill ~= role.skActs.skill03_Ult and breakSkill ~= role.skActs.skill03_UltR then
        abort_magic_by_id(role.npc, role.magics.skill03SpMaxState.id, 1)
      end
      role.skill03WudiLoopTime = 0
      if breakSkill ~= role.skActs.skill03_Ult and breakSkill ~= role.skActs.skill03_UltR and skActs.skill03_Ult.AerialState then
        cast_magic(role.npc, role.npc, 102646, 1)
        cast_magic(role.npc, role.npc, 102647, 1)
      end
    end
    
    function skActs.skill03_Ult.onEnd(skill03_Ult, breakSkill)
      remove_missile_by_id(misLogics.misSkill3MaxCamera.id, role.npc)
    end
    
    function magics.skill03LinkTime.onBegin(magic, casterNpc, target)
      skActs.skill03_SpL.trans.enable.skill03_Ult = "skill03_Ult"
      skActs.skill03_SpL.trans.enable.skill03_UltR = "skill03_UltR"
      skActs.skill03_SpR.trans.enable.skill03_Ult = "skill03_Ult"
      skActs.skill03_SpR.trans.enable.skill03_UltR = "skill03_UltR"
    end
    
    function magics.skill03LinkTime.onEnd(magic, casterNpc, target)
      skActs.skill03_SpL.trans.enable.skill03_Ult = nil
      skActs.skill03_SpL.trans.enable.skill03_UltR = nil
      skActs.skill03_SpR.trans.enable.skill03_Ult = nil
      skActs.skill03_SpR.trans.enable.skill03_UltR = nil
    end
  end
  
  function icons.skill03.updateEnable(skill03)
    skill03.base.updateEnable(skill03)
    skill03.isEnable = false
  end
  
  magics.passiveStarArea[1].onBegin = function(magic, casterNpc, target)
    play_effect_anim(role.npc, role.areaTypeEffectName[1], "light")
    play_effect_anim(role.npc, role.areaTypeEffectName[2], "dark")
    play_effect_anim(role.npc, role.areaTypeEffectName[3], "dark")
    play_effect_anim(role.npc, role.areaTypeEffectName[4], "dark")
  end
  magics.passiveStarArea[2].onBegin = function(magic, casterNpc, target)
    play_effect_anim(role.npc, role.areaTypeEffectName[2], "light")
    play_effect_anim(role.npc, role.areaTypeEffectName[1], "dark")
    play_effect_anim(role.npc, role.areaTypeEffectName[3], "dark")
    play_effect_anim(role.npc, role.areaTypeEffectName[4], "dark")
  end
  magics.passiveStarArea[3].onBegin = function(magic, casterNpc, target)
    play_effect_anim(role.npc, role.areaTypeEffectName[3], "light")
    play_effect_anim(role.npc, role.areaTypeEffectName[1], "dark")
    play_effect_anim(role.npc, role.areaTypeEffectName[2], "dark")
    play_effect_anim(role.npc, role.areaTypeEffectName[4], "dark")
  end
  magics.passiveStarArea[4].onBegin = function(magic, casterNpc, target)
    play_effect_anim(role.npc, role.areaTypeEffectName[4], "light")
    play_effect_anim(role.npc, role.areaTypeEffectName[1], "dark")
    play_effect_anim(role.npc, role.areaTypeEffectName[2], "dark")
    play_effect_anim(role.npc, role.areaTypeEffectName[3], "dark")
  end
  
  function magics.passiveStatus.onBegin(magic, casterNpc, target)
    role.passiveStatus = true
    local sk2 = role.btns.sk2
    local skill03 = get_npc_attr(role.npc, 74) >= 100 and role.icons.skill03_Sp or role.icons.skill03_Ex
    sk2:setIcon(skill03)
    local magicList = {
      102605,
      102606,
      102607,
      102608
    }
    for k, v in pairs(magicList) do
      if check_magic(role.npc, v) then
        play_effect_anim(role.npc, role.magicNmaeList[k], "state2")
      end
    end
    set_keyframe_enable(role.npc, 10010262141, true, true)
    set_keyframe_enable(role.npc, 10010262142, true, true)
    set_keyframe_enable(role.npc, 10010262241, true, true)
    set_keyframe_enable(role.npc, 10010262242, true, true)
    set_keyframe_enable(role.npc, 10010262341, true, true)
    set_keyframe_enable(role.npc, 10010262342, true, true)
  end
  
  function magics.passiveStatus.onEnd(magic, casterNpc, target)
    role.passiveStatus = false
    local sk2 = role.btns.sk2
    local skill03 = role.icons.skill03
    sk2:setIcon(skill03)
    local magicList = {
      102605,
      102606,
      102607,
      102608
    }
    for k, v in pairs(magicList) do
      if check_magic(role.npc, v) then
        play_effect_anim(role.npc, role.magicNmaeList[k], "state1")
      end
    end
    set_keyframe_enable(role.npc, 10010262141, false, true)
    set_keyframe_enable(role.npc, 10010262142, false, true)
    set_keyframe_enable(role.npc, 10010262241, false, true)
    set_keyframe_enable(role.npc, 10010262242, false, true)
    set_keyframe_enable(role.npc, 10010262341, false, true)
    set_keyframe_enable(role.npc, 10010262342, false, true)
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      set_keyframe_enable_by_tag(role.npc, 100102681, 1, false, false)
      set_keyframe_enable_by_tag(role.npc, 100102681, 2, true, false)
      if role.target then
        cast_missile3(role.npc, role.target, nil, nil, role.misLogics.misultCamere.id, 0)
      end
      return 22
    else
      set_keyframe_enable_by_tag(role.npc, 100102681, 1, true, true)
      set_keyframe_enable_by_tag(role.npc, 100102681, 2, false, true)
      return 0
    end
  end
  
  function skills.ult.onBegin(ult)
    ult.base.onBegin(ult)
    cast_magic(role.npc, role.npc, 102047, 1)
    cast_magic(role.npc, role.npc, 102048, 1)
    role.skActs.ult.missileBornPos = role.target and get_npc_pos(role.target) or get_npc_offset_position(role.npc, nil, 35, 3.5)
    role.skActs.ult.missileLookPos = get_pos_to_camera_offset_position(role.skActs.ult.missileBornPos, 2, 0)
    if role.target then
      local posFlash = get_npc_to_camera_offset_position(role.target, 4, 30)
      local lookPos = get_npc_pos(role.target)
      role:doAfter(function()
        flash_to_pos(role.npc, posFlash.x, posFlash.z)
        lookat_position(role.npc, lookPos.x, lookPos.z, 1)
      end, 0.1, true)
    end
  end
  
  function skills.ult.onEnd(ult)
  end
  
  do
    local function onUltBreak(ult, tarAct)
      role:abortMagic(102684)
      
      role:abortMagic(102685)
      return ult.base.onBreak(ult, tarAct)
    end
    
    skActs.ult.onBreak = onUltBreak
    skActs.ultFast.onBreak = onUltBreak
    
    function magics.ultCameraMagic.onBegin(magic, casterNpc, target)
    end
    
    function magics.ultShowMagic.onEnd(magic, casterNpc, target)
      abort_magic_by_id(role.npc, 102690, 1)
    end
    
    function misLogics.misultCamere.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        1,
        0,
        1
      })
    end
    
    function misLogics.misultCamere.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if role.skAct == role.skActs.ult or role.skAct == role.skActs.ultFast then
        change_focus_follow_speed(1.7)
        role:change_follow_target(4)
      end
    end
    
    function skActs.linkQte.revolveArea_Link(linkQte)
      role.passiveWeaponArea = {
        northwest = {state = false, magicId = 102601},
        northeast = {false, magicId = 102602},
        southeast = {false, magicId = 102603},
        southwest = {false, magicId = 102604}
      }
      if role.skAct == role.skActs.linkQte or role.skAct == role.skActs.atk1 then
        role.passiveAreaType = role.passiveStarAreaOpenNum
      end
      local areaTypeName = {
        "northwest",
        "northeast",
        "southeast",
        "southwest"
      }
      role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].state = true
      cast_magic(role.npc, role.npc, role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].magicId, 1)
    end
    
    function skills.linkQte.onBegin(linkQte)
      skActs.skill02_2.missilePos = role.target and get_npc_pos(role.target) or get_npc_pos(role.npc)
      misLogics.misSkill2Hit[2].isHit = false
      cast_magic(role.npc, role.npc, 102672, 1)
      role.skActs.linkQte.revolveArea_Link()
      role:checkPassiveState()
    end
  end
  magics.passiveTeachMagic[1].onBegin = function(magic, casterNpc, target)
    role:resetAreaTeach(2, 2)
  end
  magics.passiveTeachMagic[2].onBegin = function(magic, casterNpc, target)
    cast_magic(role.npc, role.npc, 102672, 1)
    role.passiveWeaponArea = {
      northwest = {state = false, magicId = 102601},
      northeast = {false, magicId = 102602},
      southeast = {false, magicId = 102603},
      southwest = {false, magicId = 102604}
    }
    role.passiveAreaType = role.passiveStarAreaOpenNum
    local areaTypeName = {
      "northwest",
      "northeast",
      "southeast",
      "southwest"
    }
    role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].state = true
    cast_magic(role.npc, role.npc, role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].magicId, 1)
    role:checkPassiveState()
  end
end

function Mina.on_missile_collide(role, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  roleBase.on_missile_collide(role, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m2_cfg.Id == 10010260203 and m1_cfg.Id == 10010260207 then
    local setPos = get_missile_pos(m2)
    remove_missile_by_id(10010260207, role.npc)
    role:doAfter(function()
      remove_missile_by_id(10010260203, role.npc)
    end, 0.1, true)
  end
  if m2_cfg.Id == 10010260203 and m1_cfg.Id == 10010260209 then
    remove_missile_by_id(10010260209, role.npc)
  end
  if m2_cfg.Id == 10010260503 and m1_cfg.Id == 10010260507 then
    local setPos = get_missile_pos(m2)
    cast_missile3(role.npc, nil, setPos.x, setPos.z, 10010260505, 0)
    remove_missile_by_id(10010260507, role.npc)
    role:doAfter(function()
      remove_missile_by_id(10010260503, role.npc)
    end, 0.1, true)
  end
  if m2_cfg.Id == 10010262226 and m1_cfg.Id == 10010262105 then
    cast_missile3(role.npc, role.target, nil, nil, 10010262131, 0)
    remove_missile_by_id(10010262226, role.npc)
    remove_missile_by_id(10010262227, role.npc)
  end
end

function Mina.on_keyframe_action(role, kfId, npcTag, comnTag)
  if "skill2_1Start" == npcTag then
    local distanceTarget
    local distanceMove = 0
    if role.target and not check_npc_distance(role.npc, role.target, 1.5, false) then
      distanceMove = 1.5037500000000001
    end
    local distance = 0 + distanceMove
    local posSet = get_npc_offset_position(role.npc, nil, 0, distance)
    cast_missile3(role.npc, nil, posSet.x, posSet.z, 10010262130, 0)
  end
  if "skill2_1Combo" == npcTag then
    role.skActs.skill02_1.trans.enable.skill02_2 = "skill02_2"
    role.skActs.skill02_1.reset.timer = get_npc_time(role.npc) + 2
    role.inputor:pop(Const.INPUTOR_POP_TYPE.TRY, true)
  end
  if "skill2_2Atk1" == npcTag then
  end
  if "skill2Camera" == npcTag then
    role:change_follow_target(4)
    change_focus_follow_speed(10)
    cast_magic(role.npc, role.npc, 102660, 1)
  end
  if "skill2_3Atk1" == npcTag or "skill2_3Atk2" == npcTag or "skill2_3Atk3" == npcTag then
    cast_missile3(role.npc, nil, role.skActs.skill02_3.missilePos.x, role.skActs.skill02_3.missilePos.z, role.skActs.skill02_3.missileId[npcTag], 0)
  end
  if "skill2ToSkill3" == npcTag then
    role.skAct.trans.enable.skill03_ExL = "skill03_ExL"
    role.skAct.trans.enable.skill03_SpL = "skill03_SpL"
    role.skAct.trans.enable.skill03_SpR = "skill03_SpR"
    role.inputor:pop(Const.INPUTOR_POP_TYPE.TRY, true)
  end
  if "Skill2_3Flash" == npcTag and role.skActs.skill02_3.flashPosIs and role.target then
    role:tp(role.skActs.skill02_3.flashPos, 7, role.skActs.skill02_3.flashLookPos)
  end
  if "skill03_Ex_Atk" == npcTag then
    local bornPos = get_npc_pos(role.npc)
    if role.target and get_npc_distance(role.npc, 1, role.target, false) <= 3 then
      bornPos = get_npc_pos(role.target)
    else
      bornPos = get_npc_offset_position(role.npc, nil, 0, 3)
    end
    cast_missile3(role.npc, nil, bornPos.x, bornPos.z, 10010263901, 0)
  end
  if "skill03_Ex_Camera" == npcTag then
    local bornPos = get_npc_pos(role.npc)
    if role.target and get_npc_distance(role.npc, 1, role.target, false) <= 5 then
      bornPos = get_npc_pos(role.target)
    else
      bornPos = get_npc_offset_position(role.npc, nil, 0, 3)
    end
    cast_missile3(role.npc, role.npc, bornPos.x, bornPos.z, role.misLogics.misSkill3ExCamera.id, 0)
  end
  if "skill03SpSword" == npcTag then
    local posSet = role.target and get_npc_pos(role.target) or get_npc_offset_position(role.npc, nil, 0, 5.5)
    cast_missile3(role.npc, nil, posSet.x, posSet.z, role.misLogics.misSkill3Pos[1].id, 0)
  end
  if "skill03Camera" == npcTag then
    cast_missile3(role.npc, role.npc, nil, nil, role.misLogics.misSkill3Camera.id, 0)
  end
  if "skill03SpMaxSword" == npcTag then
    local posSet
    if role:isRampage() then
      posSet = role.target and get_npc_pos(role.target) or role.misLogics.misSkill3MaxCamera.TargetPos
      cast_missile3(role.npc, nil, posSet.x, posSet.z, role.misLogics.misSkill3Pos[3].id, 0)
    else
      posSet = role.target and get_npc_pos(role.target) or role.misLogics.misSkill3MaxCamera.TargetPos
      cast_missile3(role.npc, nil, posSet.x, posSet.z, role.misLogics.misSkill3Pos[2].id, 0)
    end
  end
  if "skill03SpMaxAbort" == npcTag then
    abort_magic_by_id(role.npc, role.magics.skill03SpMaxState.id, 1)
    change_focus_follow_speed(2)
    role:change_follow_target(4)
  end
  if "skill03SpMaxflash" == npcTag then
    local skActs = role.skActs
    local distance = role.target and get_npc_missile_distance(role.npc, role.target) or 0
    skActs.skill03_Ult.flashPosFix = distance / 3 * 2
    if skActs.skill03_Ult.flashPosFix <= 2.5 and skActs.skill03_Ult.flashPosFix > 0 then
      skActs.skill03_Ult.flashPosFix = 2.5
    end
    skActs.skill03_Ult.flashLookPos = role.target and get_npc_pos(role.target) or get_npc_offset_position(role.npc, nil, 0, 7)
    skActs.skill03_Ult.flashPos = get_position_offset_position(skActs.skill03_Ult.flashLookPos, get_npc_pos(role.npc), skActs.skill03_Ult.Rage[skActs.skill03_Ult.posNumb], skActs.skill03_Ult.flashPosFix)
    if skActs.skill03_Ult.flashPosFix > 0 then
      role:tp(skActs.skill03_Ult.flashPos, 3, skActs.skill03_Ult.flashLookPos)
    end
    skActs.skill03_Ult.posNumb = skActs.skill03_Ult.posNumb + 1
    if skActs.skill03_Ult.posNumb > 4 then
      skActs.skill03_Ult.posNumb = 1
      local random = math.random(1, 4)
      skActs.skill03_Ult.Rage = skActs.skill03_Ult.RageList[random]
      role.misLogics.misSkill3MaxCamera.bornPosFixList = {
        0.05,
        0.05,
        0.05,
        0.05
      }
    end
  end
  if "skill3SpMaxAerialState" == npcTag then
    local skActs = role.skActs
    skActs.skill03_Ult.AerialState = false
  end
  if "skill3SpAbort" == npcTag then
    role.skActs.skill03_SpL.trans.disable.dashOut = nil
    role.skActs.skill03_SpL.trans.disable.dashIn = nil
    role.skActs.skill03_SpR.trans.disable.dashOut = nil
    role.skActs.skill03_SpR.trans.disable.dashIn = nil
    role.inputor:pop(Const.INPUTOR_POP_TYPE.TRY, true)
  end
  if "skill03ToSkill02" == npcTag then
    role.skActs.skill03_SpL.trans.enable.skill02_2 = "skill02_2"
    role.skActs.skill03_SpR.trans.enable.skill02_2 = "skill02_2"
    role.inputor:pop(Const.INPUTOR_POP_TYPE.TRY, true)
  end
  if "skillUlt" == npcTag then
    cast_missile3(role.npc, nil, role.skActs.ult.missileBornPos.x, role.skActs.ult.missileBornPos.z, 10010268401, 0, role.skActs.ult.missileLookPos.x, role.skActs.ult.missileLookPos.z)
  end
end

function Mina.onRampageStart(role, stage)
end

function Mina.effectArea_visible(role, state)
  if false == state then
    for k, v in pairs(role.passiveStarBaseMap) do
      abort_magic_by_id(role.npc, v, 1)
    end
  elseif true == state then
    for k, v in pairs(role.passiveStarBaseMap) do
      cast_magic(role.npc, role.npc, v, 1)
    end
  end
end

function Mina.checkPassiveState(role)
  if role.passiveStarAreaOpenName and role.passiveWeaponArea[role.passiveStarAreaOpenName].state then
    cast_magic(role.npc, role.npc, role.magics.passiveStatus.id, 0)
  elseif check_magic(role.npc, role.magics.passiveStatus.id) then
    abort_magic_by_id(role.npc, role.magics.passiveStatus.id)
  end
end

function Mina.revolveArea(role)
  role.passiveWeaponArea = {
    northwest = {state = false, magicId = 102601},
    northeast = {false, magicId = 102602},
    southeast = {false, magicId = 102603},
    southwest = {false, magicId = 102604}
  }
  if role.skAct == role.skActs.linkQte or role.skAct == role.skActs.atk1 or role:isRampage() then
    role.passiveAreaType = role.passiveStarAreaOpenNum
  else
    role.passiveAreaType = role.passiveAreaType + 1
    if role.passiveAreaType >= 5 then
      role.passiveAreaType = 1
    end
  end
  local areaTypeName = {
    "northwest",
    "northeast",
    "southeast",
    "southwest"
  }
  role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].state = true
  cast_magic(role.npc, role.npc, role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].magicId, 1)
  role:checkPassiveState()
end

function Mina.resetAreaTeach(role, min, max)
  if role.skAct == role.skActs.skill03_SpL or role.skAct == role.skActs.skill03_SpR or role.skAct == role.skActs.skill03_ExL then
    role:resetAreaWhenSkill3()
    return
  end
  local sk2 = role.btns.sk2
  local skill03 = role.icons.skill03
  sk2:setIcon(skill03)
  role.passiveNum = 1
  role.passiveStarAreaList = {
    northwest = {state = false, magicId = 102605},
    northeast = {state = false, magicId = 102606},
    southeast = {state = false, magicId = 102607},
    southwest = {state = false, magicId = 102608}
  }
  role.passiveStarAreaOpenNum = math.random(min, max)
  local areaName = {
    "northwest",
    "northeast",
    "southeast",
    "southwest"
  }
  role.passiveStarAreaOpenName = areaName[role.passiveStarAreaOpenNum]
  role.passiveStarAreaList[role.passiveStarAreaOpenName].state = true
  for k, v in pairs(role.passiveStarAreaList) do
    if v.state then
      cast_magic(role.npc, role.npc, v.magicId, 1)
    else
      abort_magic_by_id(role.npc, v.magicId, 1)
    end
  end
  for k, v in pairs(role.passiveWeaponArea) do
    v.state = false
  end
  local areaTypeName = {
    "northwest",
    "northeast",
    "southeast",
    "southwest"
  }
  role.passiveAreaType = role.passiveStarAreaOpenNum - 1
  if role.passiveAreaType > 4 then
    role.passiveAreaType = 1
  end
  role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].state = true
  cast_magic(role.npc, role.npc, role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].magicId, 1)
  role.passiveStatus = false
  role:checkPassiveState()
end

function Mina.resetArea(role, min, max)
  if role.skAct == role.skActs.skill03_SpL or role.skAct == role.skActs.skill03_SpR then
    role:resetAreaWhenSkill3()
    return
  end
  local sk2 = role.btns.sk2
  local skill03 = role.icons.skill03
  sk2:setIcon(skill03)
  role.passiveNum = 1
  role.passiveStarAreaList = {
    northwest = {state = false, magicId = 102605},
    northeast = {state = false, magicId = 102606},
    southeast = {state = false, magicId = 102607},
    southwest = {state = false, magicId = 102608}
  }
  role.passiveStarAreaOpenNum = math.random(min, max)
  local areaName = {
    "northwest",
    "northeast",
    "southeast",
    "southwest"
  }
  role.passiveStarAreaOpenName = areaName[role.passiveStarAreaOpenNum]
  role.passiveStarAreaList[role.passiveStarAreaOpenName].state = true
  for k, v in pairs(role.passiveStarAreaList) do
    if v.state then
      cast_magic(role.npc, role.npc, v.magicId, 1)
    else
      abort_magic_by_id(role.npc, v.magicId, 1)
    end
  end
  for k, v in pairs(role.passiveWeaponArea) do
    v.state = false
  end
  local areaTypeName = {
    "northwest",
    "northeast",
    "southeast",
    "southwest"
  }
  role.passiveAreaType = role.passiveStarAreaOpenNum + 1
  if role.passiveAreaType > 4 then
    role.passiveAreaType = 1
  end
  role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].state = true
  cast_magic(role.npc, role.npc, role.passiveWeaponArea[areaTypeName[role.passiveAreaType]].magicId, 1)
  role.passiveStatus = false
  role:checkPassiveState()
end

function Mina.resetAreaWhenSkill3(role)
  role.passiveStarAreaList = {
    northwest = {state = false, magicId = 102605},
    northeast = {state = false, magicId = 102606},
    southeast = {state = false, magicId = 102607},
    southwest = {state = false, magicId = 102608}
  }
  if role.passiveNum < 3 then
    role.passiveNum = role.passiveNum + 1
    role.passiveNumResetTime = role.nowTime + 20
  else
    role.passiveNum = 1
    role.passiveNumResetTime = 0
  end
  local randomNum = math.random(role.passiveAreaOpenIntervalRange[role.passiveNum][1], role.passiveAreaOpenIntervalRange[role.passiveNum][2])
  for i = randomNum, 1, -1 do
    role.passiveStarAreaOpenNum = role.passiveStarAreaOpenNum + 1
    if role.passiveStarAreaOpenNum >= 5 then
      role.passiveStarAreaOpenNum = 1
    end
  end
  local areaName = {
    "northwest",
    "northeast",
    "southeast",
    "southwest"
  }
  role.passiveStarAreaOpenName = areaName[role.passiveStarAreaOpenNum]
  role.passiveStarAreaList[role.passiveStarAreaOpenName].state = true
  for k, v in pairs(role.passiveStarAreaList) do
    if v.state then
      cast_magic(role.npc, role.npc, v.magicId, 1)
    else
      abort_magic_by_id(role.npc, v.magicId, 1)
    end
  end
  role:checkPassiveState()
end

function Mina.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if npc == role.npc and is_showup then
    for k, v in pairs(role.magics.passiveStarArea) do
      if check_magic(role.npc, v.id) then
        play_effect_anim(role.npc, role.areaTypeEffectName[k], "light")
        if role.passiveStatus then
          play_effect_anim(role.npc, role.magicNmaeList[k], "state2")
        end
      end
    end
    if role.destinyLv >= 4 and role.destiniesMagic.Lv4.skill2staty then
      cast_magic(role.npc, role.npc, role.magics.skill02_TypeChange.id, 0)
    end
  end
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
end

function Mina.onPdashSlomo(role)
  role.base.onPdashSlomo(role)
end

function Mina.on_npc_born(role, npc)
  role.base.on_npc_born(role, npc)
end

function Mina.buttonTimeEffectSkill2(role, is_showup)
  if not is_showup then
    role.icons.skill02_3.icon.charge.isOn = false
    role.icons.skill02_3.icon.updateCharge = Const.NIL_FUN
    role.icons.skill02_2.icon.charge.isOn = false
    role.icons.skill02_2.icon.updateCharge = Const.NIL_FUN
  elseif is_showup then
    role.icons.skill02_3.icon.charge.isOn = true
    role.icons.skill02_3.icon.updateCharge = role.icons.skill02_3.icon.updateChargeByMagic
    role.icons.skill02_2.icon.charge.isOn = true
    role.icons.skill02_2.icon.updateCharge = role.icons.skill02_3.icon.updateChargeByMagic
  end
end

function Mina.onRampageEffect(role, stage)
  if 50 == get_npc_attr(role.npc, 74) then
    role.passiveEnergyLv = 1
  elseif 100 == get_npc_attr(role.npc, 74) then
    role.passiveEnergyLv = 2
  else
    role.passiveEnergyLv = 0
  end
  abort_magic_by_id(role.npc, role.magics.skill02_TypeChange.id, 1)
  cast_magic(role.npc, role.npc, role.magics.skill02_TypeChangeIsRampage.id, 1)
  role:buttonTimeEffectSkill2(false)
end

function Mina.onRampageEnd(role, stage)
  abort_magic_by_id(role.npc, role.magics.passiveStatus.id, 1)
  role:resetArea(2, 4)
  role.skActs.skill03_SpL.MaxNumb = 0
  abort_magic_by_id(role.npc, role.magics.skill02_TypeChangeIsRampage.id, 1)
  role:buttonTimeEffectSkill2(true)
  cast_magic(role.npc, role.npc, 102673, 1)
  if role.passiveEnergyLv > 0 then
    for i = role.passiveEnergyLv, 1, -1 do
      cast_magic(role.npc, role.npc, 102671, 1)
      role.passiveEnergyLv = role.passiveEnergyLv - 1
    end
  end
end

function Mina.Skill3SwordMaxEffectTime(role)
  role.nowTime = get_npc_time(role.npc)
  if role.misLogics.misSkill3SwordMaxEffect.misInst and role.nowTime >= role.misLogics.misSkill3SwordMaxEffect.loopTime then
    remove_missile_by_id(role.misLogics.misSkill3SwordMaxEffect.id, role.npc)
  end
end

function Mina.on_frame_background(role)
  role.base.on_frame_background(role)
  role:Skill3SwordMaxEffectTime(role)
end

function Mina.on_frame(role)
  role.base.on_frame(role)
  role:Skill3SwordMaxEffectTime(role)
  if role.misLogics.misSkill3MaxCamera.moveEndPos and role.misLogics.misSkill3MaxCamera.misInst then
    local misInst = role.misLogics.misSkill3MaxCamera.misInst
    local pos = role.misLogics.misSkill3MaxCamera.moveEndPos
    if get_npc_distance(misInst, 2, pos.x, pos.z) < 0.5 then
      role.misLogics.misSkill3MaxCamera.moveEndPos = nil
      change_missile_move_params(misInst, 0, 0)
    end
  end
  if role.btns.sk1.icon.name == "skill02ButtonCd" and get_npc_cd_charge(role.npc, 100102628) >= get_skill_cfg(100102628).CdChargePerCost then
    local sk1 = role.btns.sk1
    local skill02
    if 2 == role.skill02_Type then
      skill02 = role.icons.skill02_2
    elseif 3 == role.skill02_Type then
      skill02 = role.icons.skill02_3
    elseif 1 == role.skill02_Type then
      skill02 = role.icons.skill02_1
    end
    sk1:setIcon(skill02)
  end
  if role.skill03WudiLoopTime > 0 and role.nowTime >= role.skill03WudiLoopTime then
    abort_magic_by_id(role.npc, 102666)
  end
end

return Mina
