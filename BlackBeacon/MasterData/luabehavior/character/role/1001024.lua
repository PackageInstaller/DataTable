local roleBase = import("character.base.role_base")
local Yuli = Util.create_child_mt(roleBase)
Yuli.Xu = import("character.role.1001024_1")

function Yuli._init(role, npc)
  role.npc = npc
  local misIds = {
    misAtk4Hit = 10010240401,
    misAtk2Camera = 10010240221,
    misAtk3Camera = 10010240321,
    misAtk4Camera = {10010240420, 10010240421},
    misSkill2Camera = 10010242808,
    misSkill3Camera = 10010242818,
    misSkill3Camera2 = 10010242819,
    misSkill2Area = 10010242801,
    misSkill3Area = 10010242811,
    misSkill3Line = 10010243101,
    misSkillUltArea = 100102418101,
    misSkill3_1 = {100102413107, 100102413108},
    misSkill3_2 = {10010243201, 10010243501},
    misPassiveCage = 10010244103,
    misPassiveMesh = 10010244104,
    misPassiveCamera = {10010244121, 10010244521},
    misUltCamera = 10010248121
  }
  local magicIds = {
    xuNpc = 102410,
    xuDisappear = 102412,
    xuDisappearEx = 102446,
    xuappear = 102413,
    effectAtk3 = 102420,
    lineAtk3 = 102421,
    Pursuit = {102401, 102402},
    skillPassiveTime = {
      102405,
      102406,
      102470
    },
    skill02Link = 102429,
    ultSkill = 1024100,
    ult2Camera = 102487,
    skill3_2Effect = 102431,
    xuSkill03Csat = 102440,
    PassiveCageEffect = 102479,
    skillPassiveHand = {102475, 102476},
    ultSkillEnd = 102490,
    ultSkillArea = 102492,
    passiveCageTime = 102477,
    resetCamera = 102499,
    YuliMark = 102403,
    XuMark = 102404,
    PassiveButton = 102400
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
  set_keyframe_enable(role.npc, 10010242721, false, true)
  set_keyframe_enable(role.npc, 10010242401, false, true)
  set_keyframe_enable(role.npc, 10010242402, false, true)
  set_keyframe_enable(role.npc, 10010242403, false, true)
  set_keyframe_enable(role.npc, 10010242501, false, true)
  set_keyframe_enable(role.npc, 10010242502, false, true)
  set_keyframe_enable(role.npc, 10010242601, false, true)
  set_keyframe_enable(role.npc, 10010242602, false, true)
  set_keyframe_enable(role.npc, 10010242701, false, true)
  set_keyframe_enable(role.npc, 10010242702, false, true)
  set_keyframe_enable(role.npc, 10010240911, false, true)
  role.nowTime = 0
  role.xuNpc = nil
  role.xuNPcVisible = false
  role.passiveMark = {
    [1] = false,
    [2] = false,
    [3] = false
  }
  role.passiveMarkButton = {
    [1] = false,
    [2] = false,
    [3] = false
  }
  role.akt3Pos = nil
  role.heavyPos = nil
  role.heavyPosXu = nil
  role.skill02Pos = {
    skill02_2_1 = nil,
    skill02_2_2 = nil,
    skill02_2_3 = nil,
    skill02_2_4 = nil
  }
  role.skill02Pos_xu = nil
  role.skill03LinkTarget = nil
  role.skill03LinkStata = false
  role.passiveState = false
  role.passiveTarget = nil
  role.PassiveStrPos_xu = nil
  role.PassiveAktPos = {
    [1] = {},
    posYuli = {},
    posXu = {}
  }
  role.PassiveCageList = {}
  role.passiveCageTime = 0
  role.passiveCageKeepTime = 5
  role.passiveCageState = false
  role.PassiveCageEffectPos = nil
  role.passiveCageTimeFix = 0
  role.PassiveMagicList = {
    [1024141] = {},
    [1024142] = {},
    [1024143] = {},
    [1024144] = {},
    [1024145] = {},
    [1024146] = {},
    [1024147] = {},
    [1024148] = {},
    [1024149] = {},
    [1024150] = {},
    [1024151] = {},
    [1024152] = {}
  }
  role.ultPos = nil
  role.ultPosLook = nil
  local ultFast = true
  local traces_magic = {}
  local traces = role.traces
  traces[1024281] = 1
  traces[1024282] = 2
  traces[1024283] = 3
  traces[1024284] = 4
  traces[1024285] = 5
  role.tracesMagic = {
    Lv1 = {},
    Lv2 = {magicId = 1024287},
    Lv4 = {
      magicId = 1024289,
      magicId2 = 1024292,
      magicId3 = 1024293
    }
  }
  local destinies = role.destinies
  destinies[1024181] = 1
  destinies[1024182] = 2
  destinies[1024183] = 3
  destinies[1024184] = 4
  destinies[1024185] = 5
  role.destiniesMagic = {
    Lv1 = {magicTime = 0},
    Lv2 = {
      magicId = 1024202,
      magic2Id = 1024208,
      magic3Id = 1024209
    },
    Lv3 = {magicId = 1024203, addTime = 0},
    Lv4 = {magicId = 1024204},
    Lv5 = {magicId = 1024205, passiveCageTimeFix = 3}
  }
  local spWeapon = role.spWeapon
  spWeapon.magic = 1024200
  local spWeaponMagic = {
    num = 0,
    keepTime = 0,
    magic = 1024206,
    magic2 = 1024207
  }
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function atkEnd(misRunesId, misInst, casterNpc, hitTarget, hitType, skill)
      cast_missile3(role.npc, nil, role.PassiveCageEffectPos.x, role.PassiveCageEffectPos.z, 10010244511, 0)
      
      cast_missile3(role.npc, nil, role.PassiveCageEffectPos.x, role.PassiveCageEffectPos.z, 10010244512, 0)
    end
    
    tool.insert(magics.PassiveCageEffect, "onBegin", atkEnd)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function addMagic(misRunesId, misInst, casterNpc, hitTarget, hitType, skill)
      cast_magic(role.npc, hitTarget, role.tracesMagic.Lv2.magicId, 1)
    end
    
    tool.insert(misLogics.misPassiveCage, "onHit", addMagic)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    cast_magic(role.npc, role.npc, role.tracesMagic.Lv4.magicId, 1)
    local Value = 0
    for k, v in pairs(role.tool.team.role) do
      if v.npc ~= role.npc then
        Value = Value + get_npc_attr(v.npc, 23)
      end
    end
    Value = math.floor(Value / 100) + 1
    role.tool:castMagicToTeam(role.tracesMagic.Lv4.magicId2, Value, role.npc, 1)
    role.tool:castMagicToTeam(role.tracesMagic.Lv4.magicId3, 1, role.npc, 1)
    
    local function addMagic(role, npc, is_showup, by_ult_change)
      if npc == role.npc and is_showup then
        cast_magic(role.npc, role.npc, role.tracesMagic.Lv4.magicId, 1)
        local Value = 0
        for k, v in pairs(role.tool.team.role) do
          if v.npc ~= role.npc then
            Value = Value + get_npc_attr(v.npc, 23)
          end
        end
        Value = math.floor(Value / 100) + 1
        tool:castMagicToTeam(role.tracesMagic.Lv4.magicId2, Value, role.npc, 1)
        tool:castMagicToTeam(role.tracesMagic.Lv4.magicId3, 1, role.npc, 1)
      end
    end
    
    tool.insert(role, "on_hero_showup_or_back", addMagic)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function addMagic(act)
      if act == role.skActs.skillPassiveStr or act == role.skActs.ult then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv2.magicId, 1)
        
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv2.magic2Id, 1)
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv2.magic3Id, 1)
      end
    end
    
    tool.insert(skActs.skillPassiveStr, "onBegin", addMagic)
    tool.insert(skActs.ult, "onBegin", addMagic)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function addMagic(misRunesId, misInst, casterNpc, hitTarget, hitType, skill, part_npc)
      if part_npc then
        cast_magic(role.npc, part_npc, role.destiniesMagic.Lv3.magicId, 1)
      else
        cast_magic(role.npc, hitTarget, role.destiniesMagic.Lv3.magicId, 1)
      end
    end
    
    tool.insert(misLogics.misPassiveCage, "onHit", addMagic)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local magicList = {
      [1024121] = {},
      [1024122] = {},
      [1024123] = {},
      [1024124] = {},
      [1024125] = {},
      [1024131] = {},
      [1024132] = {},
      [1024133] = {},
      [1024134] = {},
      [1024135] = {},
      [1024136] = {},
      [1024137] = {},
      [1024138] = {},
      [1024139] = {}
    }
    
    local function damageUp1(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if magicList[magic_id] then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv4.magicId, 1)
      end
    end
    
    tool.insert(role, "before_damage_target", damageUp1)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local magicList = {
      [1024141] = {},
      [1024142] = {},
      [1024143] = {},
      [1024144] = {},
      [1024145] = {},
      [1024146] = {},
      [1024147] = {},
      [1024148] = {},
      [1024149] = {},
      [1024150] = {},
      [1024151] = {},
      [1024152] = {}
    }
    
    local function damageUp1(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if magicList[magic_id] then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv5.magicId, 1)
      end
    end
    
    role.passiveCageTimeFix = role.destiniesMagic.Lv5.passiveCageTimeFix
    tool.insert(role, "before_damage_target", damageUp1)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local Xu = import("character.role.1001024_1")
    local magicList = {
      [1024141] = {},
      [1024142] = {},
      [1024143] = {},
      [1024144] = {},
      [1024145] = {},
      [1024146] = {},
      [1024147] = {},
      [1024148] = {},
      [1024149] = {},
      [1024150] = {},
      [1024151] = {},
      [1024152] = {}
    }
    
    local function damageUp1(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if magicList[magic_id] then
        cast_magic(role.npc, role.npc, spWeaponMagic.magic, role.spWeapon.lv, 1)
      end
    end
    
    local function addMagic(skill)
      cast_magic(role.npc, role.npc, spWeaponMagic.magic2, role.spWeapon.lv, 1)
    end
    
    local function abortMagic(skill)
      abort_magic_by_id(role.npc, spWeaponMagic.magic2, 1)
    end
    
    tool.insert(skActs.skillPassiveStr, "onBegin", addMagic)
    tool.insert(skills.skillPassiveStrGround, "onBegin", addMagic)
    tool.insert(skActs.skillPassiveAtk1, "onBegin", addMagic)
    tool.insert(skActs.skillPassiveAtk2, "onBegin", addMagic)
    tool.insert(skActs.skillPassiveAtk3, "onBegin", addMagic)
    tool.insert(skActs.skillPassiveStr, "onEnd", abortMagic)
    tool.insert(skills.skillPassiveStrGround, "onBegin", abortMagic)
    tool.insert(skActs.skillPassiveAtk1, "onEnd", abortMagic)
    tool.insert(skActs.skillPassiveAtk2, "onEnd", abortMagic)
    tool.insert(skActs.skillPassiveAtk3, "onEnd", abortMagic)
    tool.insert(skActs.skillPassiveStr, "onBreak", abortMagic)
    tool.insert(skills.skillPassiveStrGround, "onBreak", abortMagic)
    tool.insert(skActs.skillPassiveAtk1, "onBreak", abortMagic)
    tool.insert(skActs.skillPassiveAtk2, "onBreak", abortMagic)
    tool.insert(skActs.skillPassiveAtk3, "onBreak", abortMagic)
    tool.insert(role, "before_damage_target", damageUp1)
  end
  
  local function set_npc_visible(state)
    cast_magic(role.xuNpc, role.xuNpc, 102412, 1)
  end
  
  local function cameraReset(speed)
    role:change_follow_target(4)
    change_focus_follow_speed(speed)
  end
  
  function magics.xuNpc.onBegin(skill02_2LoopTime, casterNpc, target)
    role.xuNpc = casterNpc
    local posSet = get_npc_offset_position(role.npc, nil, 180, 1)
    local posLook = get_npc_offset_position(role.npc, nil, 180, 2)
    set_npc_visible(false)
    role.Xu.Yuli = role.npc
  end
  
  function magics.xuappear.onBegin(skill02_2LoopTime, casterNpc, target)
    enable_shadow(role.xuNpc, true)
  end
  
  function magics.xuDisappear.onEnd(skill02_2LoopTime, casterNpc, target)
    if not is_cast_skill_time(role.xuNpc) then
      set_npc_pretend_visible(role.xuNpc, false)
      role.xuNPcVisible = false
      enable_shadow(role.xuNpc, false)
    end
  end
  
  function magics.xuDisappearEx.onEnd(skill02_2LoopTime, casterNpc, target)
    abort_skill(role.xuNpc, true)
    set_npc_pretend_visible(role.xuNpc, false)
    role.xuNPcVisible = false
    enable_shadow(role.xuNpc, false)
  end
  
  function skActs.atk1.onBegin(atk1)
    atk1.base.onBegin(atk1)
  end
  
  function skActs.atk2.onBegin(atk2)
    atk2.base.onBegin(atk2)
  end
  
  function misLogics.misAtk2Camera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
    if role.target then
      role:change_follow_target(1, role.target, {
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
    else
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
    cast_magic(role.npc, role.npc, 102425, 1)
    cast_magic(role.npc, role.xuNpc, 102446, 1)
    cast_magic(role.npc, role.xuNpc, 102417, 1)
  end
  
  function misLogics.misAtk2Camera.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
    if not is_cast_skill_time(role.npc) then
      cameraReset(2)
    end
  end
  
  function magics.effectAtk3.onBegin(skill02_2LoopTime, casterNpc, target)
    cast_missile3(role.npc, nil, role.akt3Pos.x, role.akt3Pos.z, 10010240317, 0, nil, nil)
  end
  
  function magics.lineAtk3.onBegin(skill02_2LoopTime, casterNpc, target)
    cast_missile3(role.npc, role.xuNpc, nil, nil, 10010240315, 0, nil, nil)
  end
  
  function misLogics.misAtk3Camera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
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
  
  function misLogics.misAtk3Camera.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
    role:change_follow_target(4)
    change_focus_follow_speed(5)
  end
  
  skActs.atk3.reset.delay = 0.25
  
  function skActs.atk3.castSkill()
    abort_skill(role.xuNpc, 1)
    local pos1 = get_npc_offset_position(role.npc, nil, 180, 2.08)
    local is_pos, posSet = get_nearest_walkable_pos(get_npc_pos(role.npc), pos1, 0.5)
    set_npc_pretend_visible(role.xuNpc, true, posSet.x, posSet.y, posSet.z)
    role.xuNPcVisible = true
    local posMove = get_npc_offset_position(role.npc, nil, 0, 4)
    lookat_position(role.xuNpc, posMove.x, posMove.z, 1)
    cast_skill_to_position(role.xuNpc, 1001024101, posMove.x, posMove.z)
  end
  
  function skActs.atk3.onBegin(atk3)
    atk3.base.onBegin(atk3)
    role.akt3Pos = get_npc_offset_position(role.npc, nil, 0, 1.5)
    skActs.atk3.castSkill()
  end
  
  function skActs.atk4.look()
    if role.target then
      lookat_npc(role.npc, role.target, 1)
    end
  end
  
  function skActs.atk4.castSkill()
    abort_skill(role.xuNpc, 1)
    set_keyframe_enable(role.xuNpc, 100102410211, true, true)
    cast_skill_to_position(role.xuNpc, 1001024102, skActs.atk4.posTarget.x, skActs.atk4.posTarget.z)
  end
  
  function skActs.atk4.onBegin(atk4)
    atk4.base.onBegin(atk4)
    role:doAfter(skActs.atk4.look, 0.2, true)
    skActs.atk4.posTarget = role.target and get_npc_pos(role.target) or get_npc_offset_position(role.npc, nil, 180, 4)
    role:doAfter(skActs.atk4.castSkill, 0.2, true)
  end
  
  misLogics.misAtk4Camera[1].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
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
      0.01
    })
  end
  misLogics.misAtk4Camera[2].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
    if role.target then
      role:change_follow_target(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 80
        },
        0,
        0,
        0.055
      })
      misInst.misAtk4Camera = true
    else
      cameraReset(3)
    end
  end
  misLogics.misAtk4Camera[2].onEnd = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
    if misInst.misAtk4Camera then
      cameraReset(1.8)
      misInst.misAtk4Camera = false
    else
      cameraReset(5)
    end
  end
  
  function skActs.atk4.onBreak(atk4)
    cameraReset(10)
  end
  
  skActs.heavy.pre = {
    [role.skActs.atk1] = 1,
    [role.skActs.atk2] = 1,
    [role.skActs.atk3] = 2,
    [role.skActs.atk4] = 3
  }
  skActs.heavyAir.pre = skActs.heavy.pre
  skActs.heavyGround.pre = skActs.heavy.pre
  skActs.heavyLast.pre = skActs.heavy.pre
  
  function skActs.heavy.isReady(heavy)
    if not heavy.base.isReady(heavy) then
      return false
    end
    if skActs.heavy.pre[role.skAct] == nil then
      return true
    elseif 1 ~= skActs.heavy.pre[role.skAct] then
      if check_magic(role.npc, 102461) then
        return true
      end
      return false
    end
    return true
  end
  
  function skActs.heavyAir.isReady(heavyAir)
    if not heavyAir.base.isReady(heavyAir) then
      return false
    end
    cameraReset(1.8)
    if 2 ~= heavyAir.pre[role.skAct] then
      return false
    end
    if check_magic(role.npc, 102416) then
      return false
    end
    return true
  end
  
  function skActs.heavyGround.isReady(heavyGround)
    if not heavyGround.base.isReady(heavyGround) then
      return false
    end
    cameraReset(1.8)
    if 3 ~= heavyGround.pre[role.skAct] then
      return false
    end
    if not check_magic(role.npc, 102416) then
      return false
    end
    return true
  end
  
  function skActs.heavyLast.Begin(heavyLast)
    heavyLast.base.Begin(heavyLast)
  end
  
  function skills.heavy.tarPos(skill02)
    if role.target then
      role.heavyPos = get_npc_pos(role.target)
    else
      local pos1 = get_npc_offset_position(role.npc, nil, 0, 5)
      local is_pos, posSet = get_nearest_walkable_pos(get_npc_pos(role.npc), pos1, 0.5)
      role.heavyPos = posSet
    end
    role.heavyPosXu = role.heavyPos
    return role.heavyPos
  end
  
  function skActs.heavy.castSkill(role, posSet)
    if role.skAct.name == "heavy" or role.skAct.name == "counter" then
      abort_skill(role.xuNpc, 1)
      set_npc_pretend_visible(role.xuNpc, true, role.skActs.heavy.posSet.x, role.skActs.heavy.posSet.y, role.skActs.heavy.posSet.z)
      role.xuNPcVisible = true
      lookat_position(role.xuNpc, role.heavyPosXu.x, role.heavyPosXu.z, 1)
      cast_skill(role.xuNpc, nil, 1001024105, 1)
      cameraReset(5)
    end
  end
  
  function skActs.heavy.onBegin(heavy)
    heavy.base.onBegin(heavy)
    cast_magic(role.npc, role.xuNpc, 102446, 1)
    enable_shadow(role.xuNpc, false)
    local pos1 = get_position_offset_position(role.heavyPos, get_npc_pos(role.npc), 90, 7)
    local is_pos, posSet = get_nearest_walkable_pos(get_npc_pos(role.npc), pos1, 0.5)
    skActs.heavy.posSet = posSet
    role:doAfter(skActs.heavy.castSkill, 0.26666666666666666, true)
    if role.preAct == role.skActs.atk2 or role.preAct == role.skActs.atk3 then
      set_keyframe_enable(role.npc, 10010240911, true, false)
    end
  end
  
  function skills.heavy.tick()
    if role.heavyPos and check_npc_distance_to_pos(role.npc, role.heavyPos.x, role.heavyPos.z, 3.5, false) and is_cast_skill_time(role.npc, 100102405) and is_cast_skill_time(role.xuNpc, 1001024105) then
      role.skActs.heavy.curSk:derive(role.skills.heavy_end)
      role.heavyPos = nil
      play_effect_anim(role.npc, "Fx_H1001024_exskill_5_chongci", "End1")
    end
  end
  
  function skills.heavy.onBreak(heavy)
    heavy.base.onBreak(heavy)
    play_effect_anim(role.npc, "Fx_H1001024_exskill_5_chongci", "End1")
    
    local function abortSkill()
      if not is_cast_skill_time(role.npc, 100102409) then
        cast_magic(role.xuNpc, role.xuNpc, 102446, 1)
      end
    end
    
    role:doAfter(abortSkill, 0, true)
  end
  
  function skills.heavy_end.onBegin(heavy_end)
    heavy_end.base.onBegin(heavy_end)
  end
  
  function skills.dashOut.onBegin(dashOut)
    dashOut.base.onBegin(dashOut)
    cameraReset(5)
  end
  
  function skills.dashIn.onBegin(dashIn)
    dashIn.base.onBegin(dashIn)
    cameraReset(5)
  end
  
  function skills.counter.tarPos(counter)
    if role.target then
      role.heavyPos = get_npc_pos(role.target)
    else
      local pos1 = get_npc_offset_position(role.npc, nil, 0, 5)
      local is_pos, posSet = get_nearest_walkable_pos(get_npc_pos(role.npc), pos1, 0.5)
      role.heavyPos = posSet
    end
    role.heavyPosXu = role.heavyPos
    return role.heavyPos
  end
  
  skActs.counter.heavy = skActs.heavy
  
  function skActs.counter.onBegin(counter)
    counter.base.onBegin(counter)
    cast_magic(role.npc, role.xuNpc, 102446, 1)
    enable_shadow(role.xuNpc, false)
    local pos1 = get_position_offset_position(role.heavyPos, get_npc_pos(role.npc), 90, 7)
    local is_pos, posSet = get_nearest_walkable_pos(get_npc_pos(role.npc), pos1, 0.5)
    local heavy = counter.heavy
    heavy.posSet = posSet
    role:doAfter(heavy.castSkill, 0.2, true)
  end
  
  function skills.counter.tick()
    if role.heavyPos and check_npc_distance_to_pos(role.npc, role.heavyPos.x, role.heavyPos.z, 3.5, false) and is_cast_skill_time(role.npc, 100102410) and is_cast_skill_time(role.xuNpc, 1001024105) then
      role.skActs.counter.curSk:derive(role.skills.counter_end)
      role.heavyPos = nil
      play_effect_anim(role.npc, "Fx_H1001024_exskill_5_chongci", "End1")
    end
  end
  
  function skills.counter.onBreak(counter)
    counter.base.onBreak(counter)
    play_effect_anim(role.npc, "Fx_H1001024_exskill_5_chongci", "End1")
    
    local function abortSkill()
      if not is_cast_skill_time(role.npc, 100102413) then
        cast_magic(role.xuNpc, role.xuNpc, 102446, 1)
      end
    end
    
    role:doAfter(abortSkill, 0, true)
  end
  
  do
    local function skill02SetKeyframe(num)
      set_keyframe_enable(role.npc, 10010242400 + num, true, false)
      
      set_keyframe_enable(role.npc, 10010242500 + num, true, false)
      set_keyframe_enable(role.npc, 10010242600 + num, true, false)
      set_keyframe_enable(role.npc, 10010242700 + num, true, false)
    end
    
    local function skill02GetPos()
      local posTarget = role.target and get_npc_pos(role.target) or get_npc_offset_position(role.npc, nil, 0, 3)
      local distance = get_npc_distance(role.npc, 2, posTarget.x, posTarget.z, true)
      local distanceFix
      local dirNum = role.preAct == role.skActs.heavy and 2 or 1
      local dir = {
        {
          260,
          100,
          230,
          180
        },
        {
          105,
          255,
          105,
          180
        },
        {
          60,
          -60,
          45,
          0
        }
      }
      if distance <= 4 then
        local flashDisMax = 2.5
        distanceFix = 6 - distance
        if flashDisMax <= distanceFix then
          distanceFix = flashDisMax
        end
        skill02SetKeyframe(dirNum)
        role.skill02Pos.skill02_2_1 = get_npc_offset_position(role.npc, nil, dir[dirNum][1], distanceFix / 4 * 2.5)
        role.skill02Pos.skill02_2_2 = get_npc_offset_position(role.npc, nil, dir[dirNum][2], distanceFix / 4 * 2.25)
        role.skill02Pos.skill02_2_3 = get_npc_offset_position(role.npc, nil, dir[dirNum][3], distanceFix / 4 * 2.75)
        role.skill02Pos.skill02_2_4 = get_npc_offset_position(role.npc, nil, dir[dirNum][4], distanceFix / 4 * 2.75)
      else
        dirNum = 3
        set_keyframe_enable(role.npc, 10010242403, true, false)
        local flashDisMax = 5
        distanceFix = distance - 2
        if flashDisMax <= distanceFix then
          distanceFix = flashDisMax
        end
        role.skill02Pos.skill02_2_1 = get_npc_offset_position(role.npc, nil, dir[dirNum][1], distanceFix / 4 * 4)
        role.skill02Pos.skill02_2_2 = get_npc_offset_position(role.npc, nil, dir[dirNum][2], distanceFix / 4 * 2.75)
        role.skill02Pos.skill02_2_3 = get_npc_offset_position(role.npc, nil, dir[dirNum][3], distanceFix / 4 * 3)
        role.skill02Pos.skill02_2_4 = get_npc_offset_position(role.npc, nil, dir[dirNum][4], distanceFix / 4 * 3)
      end
    end
    
    function icons.skill02_2_0.updateEnhance(skill02_2_0)
      skill02_2_0.base.updateEnable(skill02_2_0)
      if role:isRampage() then
        skill02_2_0.isEnhance = role:isRampage()
      end
    end
    
    function icons.skill03_1.updateEnhance(skill03_1)
      skill03_1.base.updateEnable(skill03_1)
      if role:isRampage() then
        skill03_1.isEnhance = role:isRampage()
      end
    end
    
    function skActs.skill02_2_0.onBegin(skill02_2_0)
      skill02_2_0.base.onBegin(skill02_2_0)
      set_keyframe_enable(role.npc, 10010242721, false, false)
      role.passiveTarget = role.target
      skill02GetPos()
    end
    
    function skills.skill02_2_1.onBegin(skill02_2_1)
      skill02_2_1.base.onBegin(skill02_2_1)
      role.passiveTarget = role.target
      if role.target then
        lookat_npc(role.npc, role.target, 1)
      end
      skill02GetPos()
      flash_to_pos(role.npc, role.skill02Pos.skill02_2_1.x, role.skill02Pos.skill02_2_1.z)
      cast_missile(role.npc, role.npc, nil, nil, misLogics.misSkill2Camera.id, 0)
    end
    
    function skills.skill02_2_2.onBegin(skill02_2_2)
      flash_to_pos(role.npc, role.skill02Pos.skill02_2_2.x, role.skill02Pos.skill02_2_2.z)
    end
    
    function skills.skill02_2_3.onBegin(skill02_2_3)
      flash_to_pos(role.npc, role.skill02Pos.skill02_2_3.x, role.skill02Pos.skill02_2_3.z)
    end
    
    function skills.skill02_2_4.onBegin(skill02_2_4)
      flash_to_pos(role.npc, role.skill02Pos.skill02_2_4.x, role.skill02Pos.skill02_2_4.z)
    end
    
    magics.Pursuit[2].onBegin = function(magic, casterNpc, target)
      if role:isRampage() then
        abort_skill(role.xuNpc, 1)
        local pos1 = get_npc_offset_position(role.npc, nil, 135, 2)
        if role.target and not check_npc_die(role.target) then
          pos1 = get_npc_offset_position(role.target, get_npc_pos(role.npc), 50, 4)
          local is_pos, posSet = get_nearest_walkable_pos(get_npc_pos(role.npc), pos1, 0.5)
          set_npc_pretend_visible(role.xuNpc, true, posSet.x, posSet.y, posSet.z)
          role.xuNPcVisible = true
        end
        if role.target then
          role.skill02Pos_xu = get_npc_pos(role.target)
          lookat_position(role.xuNpc, role.skill02Pos_xu.x, role.skill02Pos_xu.z, 1)
          cast_skill_to_position(role.xuNpc, 1001024122, role.skill02Pos_xu.x, role.skill02Pos_xu.z)
        end
        set_keyframe_enable(role.npc, 10010242721, true, false)
        return
      end
      if role.passiveMark[3] then
        abort_skill(role.xuNpc, 1)
        if role.target then
          role.skill02Pos_xu = get_npc_pos(role.target)
        else
          role.skill02Pos_xu = get_npc_offset_position(role.npc, nil, 0, 5)
        end
        lookat_position(role.xuNpc, role.skill02Pos_xu.x, role.skill02Pos_xu.z, 1)
        cast_skill_to_position(role.xuNpc, 1001024122, role.skill02Pos_xu.x, role.skill02Pos_xu.z)
        set_keyframe_enable(role.npc, 10010242721, true, false)
      end
    end
    
    function misLogics.misSkill2Camera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(1, misInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 80
        },
        0,
        0,
        0.055
      })
    end
    
    function misLogics.misSkill2Camera.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      change_focus_follow_speed(3)
      role:change_follow_target(4)
    end
  end
  
  function skActs.skill03_1.isReady(skill03_1)
    if not skill03_1.base.isReady(skill03_1) or role.skAct.name == "skill02_2_0" or role.skAct.name == "heavyAir" or role.skAct.name == "heavyGround" or role.skAct.name == "heavyLast" then
      return false
    end
    return true
  end
  
  function skActs.skill03_1.castSkill()
    abort_skill(role.xuNpc, 1)
    local posFix = 0
    if role.target then
      posFix = 2 - get_npc_distance(role.npc, 1, role.target, true)
      if posFix <= 0 then
        posFix = 0
      end
    end
    local pos1 = get_npc_offset_position(role.npc, nil, 135, 2 + posFix / 2)
    local is_pos, posSet = get_nearest_walkable_pos(get_npc_pos(role.npc), pos1, 0.5)
    set_npc_pretend_visible(role.xuNpc, true, posSet.x, posSet.y, posSet.z)
    role.xuNPcVisible = true
    local poslook, posMove
    if role.target and not check_npc_die(role.target) then
      poslook = get_npc_pos(role.target)
      posMove = get_npc_offset_position(role.target, get_npc_pos(role.npc), 145, 4 - posFix)
    else
      poslook = get_npc_offset_position(role.npc, nil, 0, 5)
      posMove = get_npc_offset_position(role.npc, nil, 0, 5)
    end
    lookat_position(role.xuNpc, poslook.x, poslook.z, 1)
    cast_skill_to_position(role.xuNpc, 1001024131, posMove.x, posMove.z)
  end
  
  function skActs.skill03_1.castLink()
    if role.passiveMark[3] or role:isRampage() then
      role.skill03LinkStata = true
    else
      role.skill03LinkStata = false
    end
  end
  
  function skActs.skill03_1.onBegin(skill03_1)
    skill03_1.base.onBegin(skill03_1)
    role:doAfter(function()
      cast_magic(role.xuNpc, role.xuNpc, 102417, 1)
    end, 0.2, true)
    role:doAfter(skActs.skill03_1.castSkill, 0.3333333333333333, true)
    skActs.skill03_1.castLink()
  end
  
  function skActs.skill03_1Fast.onBegin(skill03_1Fast)
    skill03_1Fast.base.onBegin(skill03_1Fast)
    role:doAfter(function()
      cast_magic(role.xuNpc, role.xuNpc, 102417, 1)
    end, 0 / 30, true)
    role:doAfter(skActs.skill03_1.castSkill, 0.06666666666666667, true)
    skActs.skill03_1.castLink()
  end
  
  function magics.xuSkill03Csat.onBegin(magic, casterNpc, target)
    abort_skill(role.xuNpc, false)
    cast_skill(role.xuNpc, nil, 1001024132, nil, nil)
  end
  
  function skActs.skill03_1.onEnd(skill03_1)
    skill03_1.base.onBegin(skill03_1)
  end
  
  magics.Pursuit[1].onBegin = function(magic, casterNpc, target)
    if role.skill03LinkStata and role.target and role.skAct.name == "skill03_1" then
      role.skActs.skill03_1.curSk:derive(role.skills.skill03_2)
    elseif role.skill03LinkStata and role.target and role.skAct.name == "skill03_1Fast" then
      role.skActs.skill03_1Fast.curSk:derive(role.skills.skill03_2)
    end
    role.skill03LinkStata = false
  end
  misLogics.misSkill3_2[1].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
    role.skill03LinkTarget = role.target
    remove_missile_by_id(misIds.misSkill3Line, role.npc, false)
    role.passiveTarget = role.target
    local pos, distance
    if role.target and not check_npc_die(role.target) then
      distance = get_npc_distance(role.npc, 1, role.target, false)
      pos = get_npc_offset_position(role.target, get_npc_pos(role.npc), 0, distance / 2)
    else
      pos = get_npc_offset_position(role.npc, nil, 0, 3)
    end
    cast_missile(role.npc, nil, pos.x, pos.z, misIds.misSkill3Camera, 0, nil, nil)
  end
  misLogics.misSkill3_2[1].onHit = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
    cast_magic(role.npc, role.skill03LinkTarget, 102432, 1)
  end
  
  function magics.skill3_2Effect.onBegin(magic, casterNpc, target)
    if role.skill03LinkTarget and not check_npc_die(role.skill03LinkTarget) then
      local pos = get_npc_pos(role.skill03LinkTarget)
      cast_missile(role.npc, nil, pos.x, pos.z, 10010242811, 0, nil, nil)
      cast_missile3(role.npc, nil, pos.x, pos.z, 10010243222, 0)
    elseif role:isRampage() and role.target and not check_npc_die(role.target) then
      local pos = get_npc_pos(role.target)
      cast_missile(role.npc, nil, pos.x, pos.z, 10010242811, 0, nil, nil)
      cast_missile3(role.npc, nil, pos.x, pos.z, 10010243522, 0)
    end
    local pos
    if role.target and not check_npc_die(role.target) then
      pos = get_npc_pos(role.target)
      cast_missile(role.npc, nil, pos.x, pos.z, misIds.misSkill3Camera2, 0, nil, nil)
    else
      pos = get_npc_offset_position(role.npc, nil, 0, 5)
    end
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
      0.02,
      0,
      1
    })
  end
  
  function misLogics.misSkill3Camera.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
    if not is_cast_skill_time(role.npc, 100102441) then
      change_focus_follow_speed(3)
      role:change_follow_target(4)
    end
  end
  
  function misLogics.misSkill3Camera2.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
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
      0.01,
      0,
      1
    })
  end
  
  function misLogics.misSkill3Camera2.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
    if not is_cast_skill_time(role.npc, 100102441) then
      role:change_follow_target(4)
      change_focus_follow_speed(2.5)
    end
  end
  
  function skActs.linkQte.onBegin(linkQte)
    linkQte.base.onBegin(linkQte)
    abort_skill(role.xuNpc, 1)
    local pos1 = get_npc_offset_position(role.npc, nil, 135, 2)
    if role.target and not check_npc_die(role.target) then
      pos1 = get_npc_offset_position(role.target, get_npc_pos(role.npc), 30, 2)
    else
      pos1 = get_npc_offset_position(role.npc, nil, 45, 2)
    end
    local is_pos, posSet = get_nearest_walkable_pos(get_npc_pos(role.npc), pos1, 0.5)
    set_npc_pretend_visible(role.xuNpc, true, posSet.x, posSet.y, posSet.z)
    role.xuNPcVisible = true
    lookat_position(role.xuNpc, posSet.x, posSet.z, 1)
    role.passiveTarget = role.target
    cast_skill(role.xuNpc, nil, 1001024132, nil, nil)
  end
  
  function magics.PassiveButton.onBegin(skill02_2LoopTime, casterNpc, target)
    abort_magic_by_id(role.npc, magics.XuMark.id, 1)
    abort_magic_by_id(role.npc, magics.YuliMark.id, 1)
    role.passiveMarkButton[1] = true
    role.passiveMarkButton[2] = true
    update_point_fight_ui(2, role.passiveMarkButton)
  end
  
  function magics.PassiveButton.onEnd(skill02_2LoopTime, casterNpc, target)
    if role.passiveMark[1] or role.passiveMark[2] then
      return
    end
    role.passiveMarkButton[1] = false
    role.passiveMarkButton[2] = false
    update_point_fight_ui(2, role.passiveMarkButton)
  end
  
  function magics.YuliMark.onBegin(skill02_2LoopTime, casterNpc, target)
    if check_magic(role.npc, magics.XuMark.id) then
      role.passiveMark[3] = true
      cast_magic(role.npc, role.npc, magics.PassiveButton.id, 0)
    end
    role.passiveMark[1] = true
    update_point_fight_ui(2, role.passiveMark)
  end
  
  function magics.XuMark.onBegin(skill02_2LoopTime, casterNpc, target)
    if check_magic(role.npc, magics.YuliMark.id) then
      role.passiveMark[3] = true
      cast_magic(role.npc, role.npc, magics.PassiveButton.id, 0)
    end
    role.passiveMark[2] = true
    update_point_fight_ui(2, role.passiveMark)
  end
  
  function magics.YuliMark.onEnd(skill02_2LoopTime, casterNpc, target)
    role.passiveMark[1] = false
    role.passiveMark[3] = false
    update_point_fight_ui(2, role.passiveMark)
  end
  
  function magics.XuMark.onEnd(skill02_2LoopTime, casterNpc, target)
    role.passiveMark[2] = false
    role.passiveMark[3] = false
    update_point_fight_ui(2, role.passiveMark)
  end
  
  magics.skillPassiveTime[1].onBegin = function(skill02_2LoopTime, casterNpc, target)
    role.passiveState = true
    if not role.target then
      abort_magic_by_id(role.npc, magics.skillPassiveTime[1].id)
      return
    end
    local atk = role.btns.atk
    local passive = role.icons.skillPassiveStr
    atk:setIcon(passive)
    abort_magic_by_id(role.npc, magics.YuliMark.id, 1)
    abort_magic_by_id(role.npc, magics.XuMark.id, 1)
    role.passiveMark[1] = false
    role.passiveMark[2] = false
    role.passiveMark[3] = false
  end
  magics.skillPassiveTime[1].onEnd = function(skill02_2LoopTime, casterNpc, target)
    role.passiveState = false
    local atk = role.btns.atk
    local passive = role.icons.atk
    atk:setIcon(passive)
    abort_magic_by_id(role.npc, role.magics.PassiveButton.id)
  end
  magics.skillPassiveTime[2].onBegin = function(skill02_2LoopTime, casterNpc, target)
    local atk = role.btns.atk
    local passive = role.icons.skillPassiveAtk1
    atk:setIcon(passive)
  end
  magics.skillPassiveTime[2].onEnd = function(skill02_2LoopTime, casterNpc, target)
    local atk = role.btns.atk
    local passive = role.icons.atk
    atk:setIcon(passive)
    role.passiveCageTime = role.nowTime + 0.5
    if role.skAct == role.skActs.skillPassiveAtk3 then
      role.passiveCageTime = role.nowTime + 1.5
    end
    role.skActs.skillPassiveStr.trans.enable.skillPassiveAtk1 = nil
  end
  do
    local atkActs = {
      skActs.skillPassiveAtk1,
      skActs.skillPassiveAtk2,
      skActs.skillPassiveAtk3
    }
    for i, atkAct in ipairs(atkActs) do
      atkAct.reset = {timer = 0, delay = 0.5}
      
      function atkAct.onCastTime(skAct)
        skAct.reset.timer = get_npc_time(skAct.role.npc) + skAct.reset.delay
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
        if roleAct == atk.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
          return true
        elseif roleAct == atk.dashOut or roleAct == atk.dashIn then
          local preAct = roleAct.preAct
          return preAct == atk.preAtk
        else
          return false
        end
      end
    end
    
    function skActs.skillPassiveStr.isReady(skillPassiveStr)
      if not (skillPassiveStr.base.isReady(skillPassiveStr) and role.target) or check_npc_die(role.target) then
        return false
      end
      return true
    end
    
    function skActs.skillPassiveStr.canStay(skillPassiveStr)
      return false
    end
    
    function skActs.skillPassiveStr.tarPos(skillPassiveStr)
      posTarget = role.target and get_npc_pos(role.target) or get_npc_offset_position(role.npc, nil, 180, 5)
      if not posTarget then
        return
      end
      poslook = get_position_offset_position(get_npc_pos(role.npc), posTarget, -30, 2)
      role.PassiveStrPos_xu = get_position_offset_position(get_npc_pos(role.npc), posTarget, -145, 4)
      return poslook
    end
    
    function skills.skillPassiveStr.tarPos(skillPassiveStr)
      if role.passiveTarget and check_npc_die(role.passiveTarget) then
        skillPassiveStr.role:setTarget(role.passiveTarget)
        return
      end
      role.passiveTarget = role.target
    end
    
    function skActs.skillPassiveStr.onBegin(skillPassiveStr)
      skillPassiveStr.base.onBegin(skillPassiveStr)
      role.PassiveCageList = {}
      table.insert(role.PassiveCageList, role.passiveTarget)
      role.PassiveCageEffectPos = get_npc_pos(role.passiveTarget)
      remove_missile_by_id(misIds.misSkill3Camera2)
      role:change_follow_target(4)
      change_focus_follow_speed(5)
      abort_skill(role.xuNpc, 1)
      if role.xuNPcVisible == false then
        local pos1 = get_npc_offset_position(role.npc, nil, 135, 2)
        if role.target and get_npc_pos(role.target) then
          pos1 = get_position_offset_position(get_npc_pos(role.target), get_npc_pos(role.npc), -30, 2)
        else
          pos1 = get_npc_offset_position(role.npc, nil, 45, 2)
        end
        local is_pos, posSet = get_nearest_walkable_pos(get_npc_pos(role.npc), pos1, 0.5)
        set_npc_pretend_visible(role.xuNpc, true, posSet.x, posSet.y, posSet.z)
        role.xuNPcVisible = true
      end
      lookat_position(role.xuNpc, role.PassiveStrPos_xu.x, role.PassiveStrPos_xu.z, 1)
      cast_skill_to_position(role.xuNpc, 1001024141, role.PassiveStrPos_xu.x, role.PassiveStrPos_xu.z)
      if role.passiveTarget and not check_npc_die(role.passiveTarget) then
        cast_missile3(role.xuNpc, role.passiveTarget, nil, nil, 100102414101, 0)
      end
      if role:isRampage() then
        cast_magic(role.npc, role.npc, 102465, 1)
        cast_magic(role.xuNpc, role.xuNpc, 102465, 1)
      end
    end
    
    function role.passiveCageAbort(role)
      remove_missile_by_id(10010244102)
      remove_missile_by_id(100102414101)
      abort_magic_by_id(role.xuNpc, 102468, 1)
    end
    
    function skActs.skillPassiveStr.onCastTime(skillPassiveAtk1, retainCache, ignoreIcon)
      skillPassiveAtk1.role:passiveCageAbort()
      return skillPassiveAtk1.base.onCastTime(skillPassiveAtk1, retainCache, ignoreIcon)
    end
    
    function skActs.skillPassiveStr.onBreak(skillPassiveAtk1, tarAct)
      abort_magic_by_id(role.npc, magics.skillPassiveTime[1].id)
      abort_magic_by_id(role.npc, 102473, 1)
      abort_magic_by_id(role.xuNpc, 102473, 1)
      skillPassiveAtk1.role:passiveCageAbort()
      if tarAct ~= role.skActs.skillPassiveAtk1 then
        cast_magic(role.xuNpc, role.xuNpc, role.magics.xuDisappearEx.id, 1)
      end
      return skillPassiveAtk1.base.onBreak(skillPassiveAtk1, tarAct)
    end
    
    function skActs.skillPassiveStr.onEnd(skillPassiveAtk1)
      abort_magic_by_id(role.npc, 102473, 1)
      abort_magic_by_id(role.xuNpc, 102473, 1)
      skillPassiveAtk1.role:passiveCageAbort()
      return skillPassiveAtk1.base.onEnd(skillPassiveAtk1)
    end
    
    magics.skillPassiveHand[1].onBegin = function(magic, casterNpc, target)
    end
    
    function misLogics.misPassiveMesh.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      play_effect_anim(role.npc, "Fx_H10010241_skill2_1", "End2")
      play_effect_anim(role.npc, "Fx_H10010241_skill2_1_1", "End2")
      play_effect_anim(role.npc, "Fx_H10010241_skill2_1_2", "End2")
      play_effect_anim(role.npc, "Fx_H10010241_skill2_1_3", "End2")
      remove_missile_by_id(10010242802)
      play_effect_anim(role.npc, "Fx_H10010241_skill2_4", "End")
    end
    
    misLogics.misPassiveCage.missile = nil
    
    function misLogics.misPassiveCage.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      misLogics.misPassiveCage.missile = misInst
      role.PassiveAktPos[1] = get_missile_pos(role.misLogics.misPassiveCage.missile)
      role.PassiveCageEffectPos = get_missile_pos(role.misLogics.misPassiveCage.missile)
      remove_missile_by_id(10010243221)
      remove_missile_by_id(10010243222)
      remove_missile_by_id(10010242811)
    end
    
    function misLogics.misPassiveCage.onHit(missile, misInst, casterNpc, hitTarget, hitType, skill)
      local kind = get_role_kind(hitTarget)
      if hitTarget ~= role.passiveTarget and (2 == kind or 3 == kind) and not check_npc_die(hitTarget) then
        table.insert(role.PassiveCageList, hitTarget)
      end
      for k, v in ipairs(role.PassiveCageList) do
        if 1 == k and v == hitTarget then
          cast_magic(role.npc, role.PassiveCageList[k], 102477, 1)
        elseif role.traceLv >= 1 and k >= 2 and v == hitTarget then
          local pos = get_npc_pos(role.PassiveCageList[k])
          cast_magic(role.npc, role.PassiveCageList[k], 102478, 1)
          cast_missile3(role.PassiveCageList[1], role.PassiveCageList[k], pos.x, pos.z, 10010244001, 0)
        end
      end
      cast_magic(role.xuNpc, role.xuNpc, 102473, 1)
    end
    
    function magics.passiveCageTime.onBegin(magic, casterNpc, target)
      role.passiveCageState = true
      role.passiveCageTime = role.nowTime + role.passiveCageKeepTime + role.passiveCageTimeFix
    end
    
    function magics.passiveCageTime.onEnd(magic, casterNpc, target)
      remove_missile_by_id(10010244001)
    end
    
    misLogics.misPassiveCamera[1].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if role.passiveTarget then
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
      else
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
    end
    misLogics.misPassiveCamera[1].onEnd = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:change_follow_target(4)
      change_focus_follow_speed(10)
      abort_magic_by_id(role.npc, 102471)
    end
    
    function magics.resetCamera.onBegin(magic, casterNpc, target)
      remove_missile_by_id(misLogics.misPassiveCamera[1].id)
    end
    
    magics.skillPassiveTime[3].onBegin = function(skill02_2LoopTime, casterNpc, target)
      local function abortSkill()
        abort_skill(role.xuNpc, 1)
        
        if role.PassiveAktPos[1].x then
          lookat_position(role.xuNpc, role.PassiveAktPos[1].x, role.PassiveAktPos[1].z, 1)
        end
      end
      
      if role.skAct.name == "skillPassiveAtk1" then
        abortSkill()
        cast_skill_to_position(role.xuNpc, 1001024143, role.PassiveAktPos.posXu.x, role.PassiveAktPos.posXu.z)
      elseif role.skAct.name == "skillPassiveAtk2" then
        abortSkill()
        if role.PassiveAktPos[1].x then
          lookat_position(role.xuNpc, role.PassiveAktPos[1].x, role.PassiveAktPos[1].z, 1)
        end
        cast_skill(role.xuNpc, role.passiveTarget, 1001024144)
      elseif role.skAct.name == "skillPassiveAtk3" then
        abortSkill()
        if role.PassiveAktPos[1].x then
          lookat_position(role.xuNpc, role.PassiveAktPos[1].x, role.PassiveAktPos[1].z, 1)
        end
        cast_skill(role.xuNpc, role.passiveTarget, 1001024145)
      end
    end
    
    function skActs.skillPassiveAtk1.tarPos(skillPassiveAtk1)
      return skillPassiveAtk1.role.PassiveAktPos[1]
    end
    
    function skills.skillPassiveAtk1.tarPos(skillPassiveAtk1)
      role.PassiveAktPos.posYuli = get_position_offset_position(role.PassiveAktPos[1], get_npc_pos(role.npc), 0, 1.35)
      role.PassiveAktPos.posXu = get_position_offset_position(role.PassiveAktPos[1], get_npc_pos(role.xuNpc), 0, 1.35)
      return role.PassiveAktPos.posYuli, true
    end
    
    function skActs.skillPassiveAtk1.onBegin(skillPassiveAtk1)
      skillPassiveAtk1.base.onBegin(skillPassiveAtk1)
    end
    
    function skActs.skillPassiveAtk2.onBegin(skillPassiveAtk2)
      skillPassiveAtk2.base.onBegin(skillPassiveAtk2)
      if role.PassiveAktPos[1].x then
        lookat_position(role.npc, role.PassiveAktPos[1].x, role.PassiveAktPos[1].z, 1)
      end
    end
    
    function skills.skillPassiveAtk3.onBegin(skillPassiveAtk3)
      skillPassiveAtk3.base.onBegin(skillPassiveAtk3)
      if role.PassiveAktPos[1].x then
        lookat_position(role.npc, role.PassiveAktPos[1].x, role.PassiveAktPos[1].z, 1)
      end
      abort_magic_by_id(role.npc, magics.skillPassiveTime[2].id)
    end
    
    function skActs.skillPassiveAtk1.onBreak(skillPassiveAtk1, tarAct)
      if tarAct ~= role.skActs.skillPassiveAtk2 then
        cast_magic(role.xuNpc, role.xuNpc, role.magics.xuDisappearEx.id, 1)
      end
      return skillPassiveAtk1.base.onBreak(skillPassiveAtk1, tarAct)
    end
    
    function skActs.skillPassiveAtk2.onBreak(skillPassiveAtk2, tarAct)
      if tarAct ~= role.skActs.skillPassiveAtk3 then
        cast_magic(role.xuNpc, role.xuNpc, role.magics.xuDisappearEx.id, 1)
      end
      return skillPassiveAtk2.base.onBreak(skillPassiveAtk2, tarAct)
    end
    
    function skActs.skillPassiveAtk3.onBreak(skillPassiveAtk3, tarAct)
      return skillPassiveAtk3.base.onBreak(skillPassiveAtk3, tarAct)
    end
    
    function magics.PassiveCageEffect.onBegin(magic, casterNpc, target)
      role.passiveCageTime = role.nowTime + 0.1 + role.passiveCageTimeFix
      remove_missile_by_id(10010244102)
      remove_missile_by_id(100102414101)
      if role:isRampage() then
        cast_magic(role.npc, role.npc, magics.skillPassiveTime[1].id, 1)
      end
    end
    
    misLogics.misPassiveCamera[2].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if role.passiveTarget then
        role:change_follow_target(1, role.passiveTarget, {
          9999,
          0,
          {
            x = 0,
            y = 0,
            z = 80
          },
          0,
          0,
          0.055
        })
      end
    end
    misLogics.misPassiveCamera[2].onEnd = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if role.skAct == role.skActs.skillPassiveAtk3 then
        role:change_follow_target(4)
        change_focus_follow_speed(1.5)
      end
    end
    
    local function skillPassiveAtk3CameraReset(speed)
      role:change_follow_target(4)
      local cameraSpeed = get_focus_follow_speed()
      if cameraSpeed and speed > cameraSpeed then
        change_focus_follow_speed(speed)
      end
    end
    
    function skills.skillPassiveAtk3.onEnd(skillPassiveAtk3)
      skillPassiveAtk3CameraReset(5)
    end
    
    function skills.skillPassiveAtk3.onBreak(skillPassiveAtk3)
      skillPassiveAtk3CameraReset(5)
    end
  end
  
  function role.PassiveCageLogic(role)
    role.nowTime = get_npc_time(role.npc)
    if role.passiveCageState and role.nowTime >= role.passiveCageTime then
      for k, v in pairs(role.PassiveCageList) do
        abort_magic_by_id(v, 102477)
        abort_magic_by_id(v, 102478)
      end
      role.passiveCageState = false
    end
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      ultFast = true
      set_keyframe_enable(role.npc, 10010248101, false, true)
      set_keyframe_enable(role.npc, 10010248102, false, true)
      set_keyframe_enable(role.xuNpc, 100102418115, false, true)
      return 0
    else
      set_keyframe_enable(role.npc, 10010248102, true, true)
      ultFast = false
      return 0
    end
  end
  
  function skills.ult.onBegin(ult)
    ult.base.onBegin(ult)
    if not ultFast then
      set_keyframe_enable(role.npc, 10010248101, true, true)
      set_keyframe_enable(role.xuNpc, 100102418115, true, true)
    end
    role:keep_focus_pos_by_clear_target()
  end
  
  function skills.ult.onBreak(ult)
    ult.base.onBreak(ult)
    abort_magic_by_id(role.npc, 102485)
    abort_magic_by_id(role.xuNpc, 102485)
  end
  
  function misLogics.misUltCamera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
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
      0.5,
      0,
      1
    })
  end
  
  function magics.ultSkillArea.onBegin(magic, casterNpc, target)
    local posTarget = role.target and get_npc_pos(role.target) or get_npc_offset_position(role.npc, nil, 0, 0.5)
    local is_pos, posSet = get_nearest_walkable_pos(get_npc_pos(role.npc), posTarget, 0.5)
    local posRotation = get_pos_to_camera_offset_position(posSet, 2, 0)
    cast_missile3(role.npc, nil, posSet.x, posSet.z, 10010248131, 0, posRotation.x, posRotation.z + 1)
    cast_missile3(role.npc, nil, posSet.x, posSet.z, 10010248132, 0)
    local pos = get_pos_to_camera_offset_position(posSet, 1, 0)
    local is_pos, pos2 = get_nearest_walkable_pos(get_npc_pos(role.npc), pos, 1)
    role.ultPos = pos2
    role.ultPosLook = posSet
    abort_skill(role.xuNpc, 1)
    cast_magic(role.npc, role.xuNpc, 102485, 1)
    set_npc_pretend_visible(role.xuNpc, true, role.ultPos.x, get_npc_pos(role.npc).y, role.ultPos.z)
    role.xuNPcVisible = true
    lookat_position(role.xuNpc, role.ultPosLook.x, role.ultPosLook.z, 1)
    cast_skill(role.xuNpc, nil, 1001024181, 1)
  end
  
  function magics.ultSkillArea.onEnd(magic, casterNpc, target)
    if role.target then
      cast_magic(role.npc, role.target, 102493, 1)
      cast_missile3(role.npc, role.target, nil, nil, 10010248133, 0)
    end
  end
  
  function magics.ultSkill.onEnd(magic, casterNpc, target)
    abort_magic_by_id(role.xuNpc, 1024088)
  end
  
  function misLogics.misSkillUltArea.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
    local targetList = {}
    if role.target then
      targetList = search_npc(role.target, 2, 4, nil, true, true)
    end
    for k, v in pairs(targetList) do
      if v ~= role.target then
        cast_magic(role.npc, v, 102491, 1)
      end
    end
  end
  
  function skills.ult2.tarPos(ult2)
    flash_to_pos(role.npc, role.ultPos.x, role.ultPos.z)
    lookat_position(role.npc, role.ultPosLook.x, role.ultPosLook.z, 1)
  end
  
  function magics.ult2Camera.onBegin(magic, casterNpc, target)
  end
  
  function magics.ultSkillEnd.onBegin(magic, casterNpc, target)
    remove_missile_by_id(100102418101, nil, true)
    remove_missile_by_id(10010248131, nil, true)
    if role.target then
      abort_magic_by_id(role.target, 102493)
      abort_magic_by_id(role.target, 102496)
    end
    local targetList = search_npc(role.npc, 4, 10, nil, true, true)
    for k, v in pairs(targetList) do
      abort_magic_by_id(v, 102491)
      abort_magic_by_id(v, 102496)
    end
    role:change_follow_target(4)
    change_focus_follow_speed(0.001)
  end
  
  function skills.born.onBegin(born)
    born.base.onBegin(born)
    cast_magic(role.npc, role.npc, 1024089, 1)
  end
  
  function skills.finish.onBegin(finish)
    finish.base.onBegin(finish)
    cast_magic(role.npc, role.npc, 1024090, 1)
    cast_magic(role.npc, role.xuNpc, 1024090, 1)
  end
end

function Yuli.on_skill_hit(role, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if role.destinyLv >= 1 and role.passiveCageState and hit_target == role.PassiveCageList[1] and missile_cfg.Id ~= 10010242831 and role.nowTime >= role.destiniesMagic.Lv1.magicTime then
    role.destiniesMagic.Lv1.magicTime = role.nowTime + 0.1
    for k, v in pairs(role.PassiveCageList) do
      if 1 == k and not check_npc_die(v) then
        cast_missile(role.npc, v, nil, nil, 10010242831, 0, nil, nil)
      end
      if k > 1 and not check_npc_die(v) then
        cast_missile(role.npc, v, nil, nil, 10010242831, 0, nil, nil)
      end
    end
  end
end

function Yuli.before_damage_target(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if role:isRampage() and role.PassiveMagicList[magic_id] then
    cast_magic(role.npc, role.npc, 102420001, 1)
  end
end

function Yuli.on_missile_collide(role, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  roleBase.on_missile_collide(role, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function Yuli.on_start(role, npc)
  role.base.on_start(role, npc)
  
  local function on_skill_hit_Xu(role, skill_id, hit_target, hit_type, missile_cfg, missile)
    local yuliRole = Yuli.Xu.Yuli:get_behavior()
    local missileList = {
      [100102410101] = 1024105,
      [100102410103] = 1024106,
      [100102410201] = 1024108,
      [100102413107] = 1024132,
      [100102413108] = 1024133,
      [100102413214] = 1024134,
      [100102413215] = 1024135,
      [100102413216] = 1024136,
      [100102413217] = 1024137,
      [100102414301] = 1024143,
      [100102414401] = 1024145,
      [100102414501] = 1024149,
      [100102414502] = 1024150,
      [100102418102] = 1024163,
      [100102418104] = 1024164,
      [100102418106] = 1024165,
      [100102418110] = 1024166,
      [100102418112] = 1024167
    }
    if is_cast_skill_time(role.Xu.Yuli, 100102435) then
      missileList[100102413214] = 1024173
      missileList[100102413215] = 1024174
      missileList[100102413216] = 1024175
      missileList[100102413217] = 1024176
    end
    if missileList[missile_cfg.Id] then
      cast_magic(role.Xu.Yuli, hit_target, missileList[missile_cfg.Id], 0)
    end
  end
  
  role.tool.insert(Yuli.Xu, "on_self_skill_hit", on_skill_hit_Xu)
end

function Yuli.on_born_behavior(role)
  role.base.on_born_behavior(role)
  role:doAfter(role.prepareXu, 0, true)
  cast_magic(role.npc, role.npc, 1024294, 0)
end

function Yuli.on_tp_room_finish(role)
  role.base.on_tp_room_finish(role)
  role:prepareXu()
end

function Yuli.on_keyframe_action(role, kfId, npcTag, comnTag)
  if "passive2_1Combo" == npcTag and role:isRampage() then
    role.skAct.trans.enable.skillPassiveAtk1 = "skillPassiveAtk1"
    role.inputor:pop(Const.INPUTOR_POP_TYPE.TRY, true)
  end
  if "passive2_1Combo" == npcTag and not role:isRampage() then
    role.skAct.trans.enable.skillPassiveAtk1 = "skillPassiveAtk1"
    role.inputor:pop(Const.INPUTOR_POP_TYPE.TRY, true)
  end
  if "skillPassiveCancel" == npcTag then
    abort_magic_by_id(role.npc, 102406)
  end
  if "Passive_Combo1ToCombo2" == npcTag or "Passive_Combo2ToCombo3" == npcTag then
    role.skAct.reset.timer = get_npc_time(role.npc) + 2
    role.skAct:tryPop()
  end
  if "ultDestinies" == npcTag and role.destinyLv >= 4 then
    cast_magic(role.npc, role.npc, role.magics.skillPassiveTime[1].id, 1)
  end
end

function Yuli.onRampageEffect(role, stage)
  cast_magic(role.npc, role.xuNpc, Const.RAMPAGE_CONFIG.RAMPAGE_SPEED, 1)
end

function Yuli.onRampageEnd(role, stage)
  abort_magic_by_id(role.xuNpc, Const.RAMPAGE_CONFIG.RAMPAGE_SPEED, 1)
  local skill02_2_0 = role.icons.skill02_2_0
  local skill03_1 = role.icons.skill03_1
  skill02_2_0.isEnhance = false
  skill03_1.isEnhance = false
end

function Yuli.prepareXu(role)
  if not role.Xu.inst then
    local posSet = get_npc_offset_position(role.npc, nil, 180, 10)
    role.xuNpc = add_npc2(1, 10010241, posSet.x, posSet.z, 0, 0, 2, 1, 1)
  end
end

function Yuli.on_npc_hp_zero(role, npc)
  role.base.on_npc_hp_zero(role, npc)
  if check_magic(npc, 102477) or check_magic(npc, 102478) then
    abort_magic_by_id(npc, 102477)
    abort_magic_by_id(npc, 102478)
  end
  if role.passiveTarget == npc then
    role.passiveCageTime = role.nowTime + 0.1
    role.passiveTarget = nil
  end
end

function Yuli.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if npc == role.npc and is_showup then
    if role.passiveMark[1] or role.passiveMark[2] then
      update_point_fight_ui(2, role.passiveMark)
    else
      update_point_fight_ui(2, role.passiveMarkButton)
    end
    if check_magic(role.npc, 102406) then
      abort_magic_by_id(role.npc, 102406)
    end
    cast_magic(role.npc, role.npc, 1024294, 0)
  end
  if npc == role.npc and not is_showup then
    cast_magic(role.xuNpc, role.xuNpc, role.magics.xuDisappearEx.id, 1)
  end
end

function Yuli.on_hero_enter_ground_state(role, npc)
  role.base.on_hero_enter_ground_state(role, npc)
  if npc ~= role.npc or is_cast_skill_time(role.npc, 100102441) then
  end
  if npc == role.npc and role.skAct == role.skActs.skillPassiveStr then
    abort_magic_by_id(role.npc, 102406, 1)
  end
end

function Yuli.on_frame_background(role)
  role.base.on_frame_background(role)
  role.PassiveCageLogic(role)
end

function Yuli.on_frame(role)
  role.base.on_frame(role)
  role.PassiveCageLogic(role)
  if role.skill02Pos_xu and check_npc_distance_to_pos(role.xuNpc, role.skill02Pos_xu.x, role.skill02Pos_xu.z, 3.5, false) and is_cast_skill_time(role.xuNpc, 1001024122) then
    local pos1 = get_npc_pos(role.npc)
    abort_skill(role.xuNpc, false)
    cast_skill(role.xuNpc, nil, 1001024121, nil, nil)
    cast_missile(role.npc, nil, role.skill02Pos_xu.x, role.skill02Pos_xu.z, 10010242806, 0)
    cast_missile(role.npc, nil, role.skill02Pos_xu.x, role.skill02Pos_xu.z, 10010242801, 0)
    cast_missile(role.npc, nil, role.skill02Pos_xu.x, role.skill02Pos_xu.z, 10010242802, 0)
    cast_missile(role.npc, nil, role.skill02Pos_xu.x, role.skill02Pos_xu.z, 10010242803, 0)
    local targetList = {}
    if role.target then
      search_npc(role.target, 2, 4, nil, true, true)
    end
    for k, v in pairs(targetList) do
      if not check_npc_distance(role.target, v, 2, true) then
        local missile = {10010242804, 10010242805}
        local posTarget = get_npc_pos(v)
        num = math.random(1, 2)
        cast_missile(role.npc, v, posTarget.x, posTarget.z, missile[num], 0)
      end
    end
    role.skill02Pos_xu = nil
  end
end

return Yuli
