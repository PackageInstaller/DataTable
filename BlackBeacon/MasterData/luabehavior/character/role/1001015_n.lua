local roleBase = import("character.base.role_base")
local Shamash = Util.create_child_mt(roleBase)

function Shamash._init(role, npc)
  role.npc = npc
  local misIds = {
    misSkill02Lock = 10010152101,
    misSkill02LockS = 10010152122,
    misSkill02LockLoop = 10010152401,
    misSkill02LockLoopL = 10010152411,
    misSkill02LockLoopR = 10010152412,
    misSkill02Move = 10010152403,
    misSkill02Strike = 10010152601,
    misSkill02_2Hit = 10010152201,
    misSkill03_2Hit = 10010153201,
    misPursuitAtk = 10010157501,
    misAktProCamera = 10010150921,
    misBlockHitSpCamera = 10010151921,
    misUltCamera = 10010158121,
    misBlockHit = 10010151324
  }
  local magicIds = {
    skill02_2LoopTime = 101551,
    skillPassiveTime = 1015312,
    ultPassiveEnergy = 1015118,
    skill03_2LoopTime = 101552,
    BlockHitSpLoopTime = 101554
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
  role.now_time = 0
  cast_magic(role.npc, role.npc, 1015310, 1)
  
  function skills.BlockHit.isReady(BlockHit)
    return check_magic(role.npc, 19991851)
  end
  
  local heavyChange = false
  local pursuitChange = false
  local heavyIsCast = true
  role.skill02_1Target = nil
  set_keyframe_enable_by_tag(role.npc, 100101501, 3, false, true)
  set_keyframe_enable_by_tag(role.npc, 100101502, 3, false, true)
  set_keyframe_enable_by_tag(role.npc, 100101513, 1, false, true)
  set_keyframe_enable_by_tag(role.npc, 100101532, 3, false, true)
  set_keyframe_enable_by_tag(role.npc, 100101532, 1, false, true)
  set_keyframe_enable(role.npc, 10010154131, false, true)
  set_keyframe_enable(role.npc, 10010152121, false, true)
  set_keyframe_enable(role.npc, 10010152122, false, true)
  set_keyframe_enable(role.npc, 10010150521, false, true)
  set_keyframe_enable(role.npc, 10010150621, false, true)
  set_keyframe_enable(role.npc, 10010150721, false, true)
  set_keyframe_enable(role.npc, 10010150821, false, true)
  local passiveEnergyAdd = {
    atk4 = {1015110, true},
    skill02_1 = {1015111, true},
    skill02_2 = {1015111, true},
    BlockHit = {1015113, true},
    skill03_2 = {1015112, true}
  }
  local EnergyAddLv = 1
  local heavyMagic = true
  role.passiveStatus = false
  role.passiveEnergyDelete = {1015115, 1015116}
  role.EnergyDleLv = 1
  role.passiveSkillChange = true
  role.passiveStatusLink = true
  role.skill02_hit_target = nil
  local skill02_hit_type = 0
  role.ultHit = true
  role.ultPassiveEnergyLv = false
  local traces_magic = {}
  local traces = role.traces
  traces[1015281] = 1
  traces[1015282] = 2
  traces[1015283] = 3
  traces[1015284] = 4
  traces[1015285] = 5
  role.tracesMagic = {
    Lv4 = {1015117, 1015120}
  }
  local destinies = role.destinies
  destinies[1015181] = 1
  destinies[1015182] = 2
  destinies[1015183] = 3
  destinies[1015184] = 4
  destinies[1015185] = 5
  role.destiniesMagic = {
    Lv1 = {101579, true},
    Lv2 = {id = 1015202, time = -1},
    Lv3 = 1015287,
    Lv4 = 1015221,
    Lv5 = 1015222
  }
  local spWeapon = role.spWeapon
  spWeapon.magic = 1015200
  local spWeaponDamageUp = 1015217
  local spWeaponNumb = 0
  
  local function cameraReset(skill)
    local role = skill.role
    change_focus_follow_speed(4)
    role:change_follow_target(4)
  end
  
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    passiveEnergyAdd = {
      atk4 = {1015211, true},
      skill02_1 = {1015212, true},
      skill02_2 = {1015212, true},
      BlockHit = {1015113, true},
      skill03_2 = {1015213, true}
    }
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(role.npc, 100101513, 1, true, true)
  end
  traces[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function UltLogic(act)
      if role:isRampage() then
        local passive_energy = get_npc_attr(role.npc, 74)
        
        if passive_energy >= 80 then
          role.ultPassiveEnergyLv = 5
        elseif passive_energy >= 60 then
          role.ultPassiveEnergyLv = 4
        elseif passive_energy >= 40 then
          role.ultPassiveEnergyLv = 3
        elseif passive_energy >= 20 then
          role.ultPassiveEnergyLv = 2
        else
          role.ultPassiveEnergyLv = false
        end
      end
    end
    
    skActs.ult:insertFun("onBegin", UltLogic)
    skActs.ultFast:insertFun("onBegin", UltLogic)
  end
  traces[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.destiniesMagic.Lv1[1] = 1015201
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp(skillPassive)
      cast_magic(role.npc, role.npc, role.destiniesMagic.Lv2.id, 0)
      
      role.destiniesMagic.Lv2.time = role.now_time + 30
    end
    
    tool.insert(magics.skillPassiveTime, "onBegin", damageUp)
    tool.insert(magics.ultPassiveEnergy, "onBegin", damageUp)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp(ult)
      cast_magic(role.npc, role.npc, role.destiniesMagic.Lv3, 0)
    end
    
    local function damageDle(ult)
      abort_magic_by_id(role.npc, role.destiniesMagic.Lv3)
    end
    
    tool.insert(skActs.ult, "onBegin", damageUp)
    tool.insert(skActs.ult, "onEnd", damageDle)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1015127 == magic_id then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv4, 0)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1015144 == magic_id or 1015145 == magic_id then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv5, 0)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp()
      cast_magic(role.npc, role.npc, spWeaponDamageUp, role.spWeapon.lv)
    end
    
    tool.insert(skActs.exatk1, "onBegin", damageUp)
    tool.insert(skActs.exatk2, "onBegin", damageUp)
    tool.insert(skActs.exatk3, "onBegin", damageUp)
    tool.insert(skActs.exatk4, "onBegin", damageUp)
    tool.insert(skActs.exatk5, "onBegin", damageUp)
    tool.insert(skActs.PursuitAtk, "onBegin", damageUp)
  end
  
  local function passive_energy_add(skill)
    skill.base.onHit(skill)
    local skill_name = skill.name
    if passiveEnergyAdd[skill_name][2] then
      passiveEnergyAdd[skill_name][2] = false
      cast_magic(role.npc, role.npc, passiveEnergyAdd[skill_name][1], EnergyAddLv)
    end
    role:doAfter(function()
      passiveEnergyAdd[skill_name][2] = true
    end, 0.3)
  end
  
  function role.passiveEnergy_logic(role)
    role.now_time = get_npc_time(role.npc)
    local energy = get_npc_attr(role.npc, 74)
    if role.passiveStatus and role.passiveStatusLink then
      cast_magic(role.npc, role.npc, role.passiveEnergyDelete[role.EnergyDleLv], 0)
    end
    if role.destinyLv >= 2 and role.destiniesMagic.Lv2.time > 0 and role.destiniesMagic.Lv2.time <= role.now_time and check_magic(role.npc, role.destiniesMagic.Lv2.id) then
      abort_magic_by_id(role.npc, role.destiniesMagic.Lv2.id)
      role.destiniesMagic.Lv2.time = -1
    end
    if energy >= 100 and role.passiveSkillChange then
      role.passiveSkillChange = false
      local sk1 = role.btns.sk1
      local sk2 = role.btns.sk2
      local skill02 = role.icons.skillPassive
      local skill03 = role.icons.skillPassive
      sk1:setIcon(skill02)
      sk2:setIcon(skill03)
    elseif role.passiveStatus then
      if energy <= 0.1 and not role.passiveSkillChange then
        if is_cast_skill_time(role.npc, 100101505, 1) or is_cast_skill_time(role.npc, 100101506, 1) or is_cast_skill_time(role.npc, 100101507, 1) or is_cast_skill_time(role.npc, 100101508, 1) or is_cast_skill_time(role.npc, 100101574, 1) and heavyIsCast or is_cast_skill_time(role.npc, 100101575, 1) or is_cast_skill_time(role.npc, 100101581, 1) then
          heavyIsCast = false
          return
        end
        role.passiveStatus = false
        role.passiveSkillChange = true
        local atk_B = role.btns.atk
        local akt_Icon = {
          role.icons.atk,
          role.icons.exatk
        }
        local sk1 = role.btns.sk1
        local sk2 = role.btns.sk2
        local skill02 = role.icons.skill02_1
        local skill03 = role.icons.Block
        atk_B:setIcon(akt_Icon[1])
        sk1:setIcon(skill02)
        sk2:setIcon(skill03)
        abort_magic_by_id(role.npc, 101546)
        abort_magic_by_id(role.npc, 1015461)
        abort_magic_by_id(role.npc, 101547)
        if check_magic(role.npc, 1015311) and not is_cast_skill_time(role.npc, 100101581, 1) then
          cast_magic(role.npc, role.npc, 1015314, 0)
        end
        if role.ultPassiveEnergyLv then
          cast_magic(role.npc, role.npc, role.tracesMagic.Lv4[2], role.ultPassiveEnergyLv)
          role.ultPassiveEnergyLv = false
        end
        set_keyframe_enable(role.npc, 10010150521, false, true)
        set_keyframe_enable(role.npc, 10010150621, false, true)
        set_keyframe_enable(role.npc, 10010150721, false, true)
        set_keyframe_enable(role.npc, 10010150821, false, true)
        role.destiniesMagic.Lv2.time = role.now_time + 1
      end
    elseif not role.passiveStatus and energy < 100 and not role.passiveSkillChange then
      role.passiveSkillChange = true
      role.passiveStatusLink = true
      local sk1 = role.btns.sk1
      local sk2 = role.btns.sk2
      local skill02 = role.icons.skill02_1
      local skill03 = role.icons.Block
      sk1:setIcon(skill02)
      sk2:setIcon(skill03)
      role.destiniesMagic.Lv2.time = role.now_time + 1
    end
  end
  
  function icons.skillPassive.updateEnhance(skillPassive)
    skillPassive.isEnhance = skillPassive.isEnable
  end
  
  function icons.skillPassive.updateEnable(skillPassive)
    skillPassive.base.updateEnable(skillPassive)
    if skillPassive.isEnable then
      skillPassive.isEnable = not skillPassive.role.passiveStatus
    end
  end
  
  function skills.linkQte.onBegin(skillPassive)
    local passive_energy = get_npc_attr(role.npc, 74)
    if passive_energy >= 80 then
      role.ultPassiveEnergyLv = 5
    elseif passive_energy >= 60 then
      role.ultPassiveEnergyLv = 4
    elseif passive_energy >= 40 then
      role.ultPassiveEnergyLv = 3
    elseif passive_energy >= 20 then
      role.ultPassiveEnergyLv = 2
    else
      role.ultPassiveEnergyLv = false
    end
    cast_magic(role.npc, role.npc, role.tracesMagic.Lv4[1], 0)
  end
  
  function magics.skillPassiveTime.onBegin(skill02_2LoopTime, casterNpc, target)
    role.passiveStatus = true
    heavyIsCast = true
    local atk_B = role.btns.atk
    local akt_Icon = {
      role.icons.atk,
      role.icons.exatk
    }
    atk_B:setIcon(akt_Icon[2])
    cast_magic(role.npc, role.npc, 101546, 0)
    cast_magic(role.npc, role.npc, 1015461, 0)
    if get_come_on_hero() == role.npc then
      cast_magic(role.npc, role.npc, 101547, 0)
    end
    abort_magic_by_id(role.npc, magicIds.skill03_2LoopTime)
    abort_magic_by_id(role.npc, magicIds.skill02_2LoopTime)
    if role:isRampage() then
      set_keyframe_enable(role.npc, 10010150521, true, true)
      set_keyframe_enable(role.npc, 10010150621, true, true)
      set_keyframe_enable(role.npc, 10010150721, true, true)
      set_keyframe_enable(role.npc, 10010150821, true, true)
    end
  end
  
  function skills.heavy.onCastTime(heavy)
    heavyChange = true
    role:doAfter(function()
      heavyChange = false
    end, 0.35)
    heavy.base.onCastTime(heavy)
  end
  
  function skActs.atk2.isReady(atk2)
    if not atk2.base.isReady(atk2) then
      return false
    end
    local role = atk2.role
    local roleAct = role.skAct
    if roleAct == atk2.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif heavyChange then
      heavyChange = false
      return true
    else
      return false
    end
  end
  
  function skActs.atk4.onHit(atk4, casterNpc, hitTarget, hitType, skill, missile)
    passive_energy_add(atk4)
  end
  
  function skActs.dashOut.tarPos(dashOut, event)
    local role = dashOut.role
    local roleAct = role.skAct
    if roleAct:isDash() then
      dashOut.preAct = roleAct.preAct
    else
      dashOut.preAct = roleAct
    end
    return dashOut.base.tarPos(dashOut, event)
  end
  
  function skActs.dashIn.tarPos(dashIn, event)
    local role = dashIn.role
    local roleAct = role.skAct
    if roleAct:isDash() then
      dashIn.preAct = roleAct.preAct
    else
      dashIn.preAct = roleAct
    end
    return dashIn.base.tarPos(dashIn, event)
  end
  
  do
    local atkActs = {
      skActs.exatk1,
      skActs.exatk2,
      skActs.exatk3,
      skActs.exatk4,
      skActs.exatk5
    }
    for i, atkAct in ipairs(atkActs) do
      atkAct.reset = {timer = 0, delay = 0.2}
      
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
        elseif atk.preAtk == atkActs[2] and pursuitChange then
          pursuitChange = false
          return true
        elseif roleAct == atk.dashOut or roleAct == atk.dashIn then
          local preAct = roleAct.preAct
          return preAct == atk.preAtk
        else
          return false
        end
      end
    end
    
    function misLogics.misAktProCamera.onBegin(missile_cfg, missile, owner, pos_x, pos_z)
      local tar_armor_level = role.target and get_armor_def_level(role.target)
      if tar_armor_level and tar_armor_level >= 3 then
        role:change_follow_target(1, role.target, {
          9999,
          0,
          {
            x = 0,
            y = 0,
            z = 60
          },
          1,
          10,
          0.135
        })
      else
        role:change_follow_target(1, missile, {
          9999,
          0,
          {
            x = 0,
            y = 0,
            z = 25
          },
          1,
          10,
          0.135
        })
      end
    end
    
    function misLogics.misAktProCamera.onEnd(missile_cfg, missile, owner, pos_x, pos_z)
      change_focus_follow_speed(1.75)
      role:change_follow_target(4)
      role:doAfter(function()
        if not is_cast_skill_time(role.npc) then
          change_focus_follow_speed(4)
          role:change_follow_target(4)
        end
      end, 1.1)
    end
    
    function misLogics.misBlockHitSpCamera.onBegin(missile_cfg, missile, owner, pos_x, pos_z)
      role:change_follow_target(1, missile, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 25
        },
        1,
        10,
        0.135
      })
    end
    
    function misLogics.misBlockHitSpCamera.onEnd(missile_cfg, missile, owner, pos_x, pos_z)
      change_focus_follow_speed(1.75)
      role:change_follow_target(4)
      role:doAfter(function()
        if not is_cast_skill_time(role.npc) then
          change_focus_follow_speed(4)
          role:change_follow_target(4)
        end
      end, 1.1)
    end
    
    function skills.PursuitStart.onBegin(PursuitStart)
      abort_magic_by_id(role.npc, 101546)
      abort_magic_by_id(role.npc, 1015461)
      role.destiniesMagic.Lv1[2] = true
    end
    
    function misLogics.misPursuitAtk.onHit(missile_cfg, missile, owner, pos_x, pos_z)
      if role.destiniesMagic.Lv1[2] then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv1[1], 0)
      end
    end
    
    function skills.PursuitStart.onEnd(PursuitStart)
      PursuitStart.base.onEnd(PursuitStart)
      local joystick_target = search_joystick_npc(role.npc, 4, 6, 90)
      local joystick_target_pos
      if joystick_target then
        joystick_target_pos = get_npc_pos(joystick_target)
      end
    end
    
    skills.atk1.onBegin = cameraReset
    skills.exatk1.onBegin = cameraReset
    skills.heavy.onBegin = cameraReset
    
    function skills.PursuitAtk.onBegin(PursuitStart)
      if role.passiveStatus then
        cast_magic(role.npc, role.npc, 101546, 1)
        cast_magic(role.npc, role.npc, 1015461, 1)
      end
      change_focus_follow_speed(15)
      role:change_follow_target(4)
    end
    
    skills.qte.onBegin = cameraReset
    
    local function dashCameraReset(speed)
      role:change_follow_target(4)
      change_focus_follow_speed(10)
    end
    
    skills.dashIn.onBegin = dashCameraReset
    skills.dashOut.onBegin = dashCameraReset
  end
  
  function skills.skill02_1.onBegin(skill02_2)
    skill02_hit_type = 0
  end
  
  function misLogics.misSkill02LockS.onHit(misSkill02Lock, misInst, casterNpc, hitTarget, hitType, skill)
    cast_missile(role.npc, hitTarget, nil, nil, misLogics.misSkill02LockLoop.id, 0)
    cast_magic(role.npc, hitTarget, 101528, 0)
    role.skill02_hit_target = hitTarget
    abort_magic_by_id(role.npc, 101539)
  end
  
  function misLogics.misSkill02Lock.onHit(misSkill02Lock, misInst, casterNpc, hitTarget, hitType, skill, part_npc)
    if 5 ~= get_role_kind(hitTarget) then
      passive_energy_add(skill)
    end
    if part_npc then
      cast_missile(role.npc, part_npc, nil, nil, misLogics.misSkill02LockLoop.id, 0)
      cast_magic(role.npc, part_npc, 101528, 0)
      role.skill02_hit_target = role.target
    else
      cast_missile(role.npc, hitTarget, nil, nil, misLogics.misSkill02LockLoop.id, 0)
      cast_magic(role.npc, hitTarget, 101528, 0)
      role.skill02_hit_target = hitTarget
    end
    abort_magic_by_id(role.npc, 101529)
    role:doAfter(function(role)
      if role.skAct ~= role.skActs.skill02_1 then
        return
      end
      if part_npc then
        cast_missile(role.npc, part_npc, nil, nil, misLogics.misSkill02Move.id, 0)
      else
        cast_missile(role.npc, hitTarget, nil, nil, misLogics.misSkill02Move.id, 0)
      end
    end, -0.3)
  end
  
  do
    local function RemoveLock()
      if check_magic(role.skill02_hit_target, 101528) then
        abort_magic_by_id(role.skill02_hit_target, 101528)
        
        role.skill02_hit_target = nil
      end
    end
    
    misLogics.misSkill02LockLoop.onEnd = RemoveLock
    misLogics.misSkill02LockLoopR.onEnd = RemoveLock
    misLogics.misSkill02LockLoopL.onEnd = RemoveLock
    
    function misLogics.misSkill02Move.onHit(misSkill02Move, misInst, casterNpc, hitTarget, hitType, skill)
      local role = misSkill02Move.unit
      if role.skAct ~= role.skActs.skill02_1 then
        return
      end
      if 0 == skill02_hit_type then
        local boss_id
        if role.target then
          boss_id = get_npc_id(role.target)
        end
        if 201160 == boss_id or 201161 == boss_id then
          role.skill02_1Target = role.target
        else
          role.skill02_1Target = hitTarget
        end
        if get_armor_def_level(hitTarget) > 15 and 5 ~= get_role_kind(hitTarget) then
          skill02_hit_type = 2
          abort_skill(role.npc)
          if role.skill02_1Target and check_npc_distance(role.npc, role.skill02_1Target, 4, true) then
            skill02_hit_type = 1
            set_keyframe_enable_by_tag(role.npc, 100101521, 2, true, false)
            abort_skill(role.npc)
            skActs.skill02_1.curSk:derive(skills.skill02_1_strike)
          else
            skActs.skill02_1.curSk:derive(skills.skill02_1_forward)
          end
        elseif not check_magic(role.npc, 10019000) and 5 ~= get_role_kind(hitTarget) then
          skill02_hit_type = 1
          set_keyframe_enable_by_tag(role.npc, 100101521, 2, true, false)
          abort_skill(role.npc)
          skActs.skill02_1.curSk:derive(skills.skill02_1_strike)
        end
      end
    end
    
    function misLogics.misSkill02Strike.onHit(misSkill02Strike, misInst, casterNpc, hitTarget, hitType, skill)
      cast_magic(role.npc, role.npc, magicIds.skill02_2LoopTime, 0)
      role:doAfter(function()
        cast_magic(role.npc, role.npc, 101549, 0)
      end, 0.1)
    end
    
    function misLogics.misSkill02_2Hit.onHit(misSkill02Lock, misInst, casterNpc, hitTarget, hitType, skill)
      passive_energy_add(skill)
    end
    
    function skills.skill02_1_forward.onBegin(skill02_1_forward)
      cast_magic(role.npc, role.npc, magicIds.skill02_2LoopTime, 0)
      if role.skill02_1Target then
        skill02_1_forward.role.target = role.skill02_1Target
        lookat_npc(role.npc, role.skill02_1Target, 1)
      end
    end
    
    function skills.skill02_1_strike.onBegin(skill02_1_strike)
      if role.skill02_1Target then
        skill02_1_strike.role.target = role.skill02_1Target
        lookat_npc(role.npc, role.skill02_1Target, 1)
      end
    end
    
    function magics.skill02_2LoopTime.onBegin(skill02_2LoopTime, casterNpc, target)
      local sk1 = role.btns.sk1
      local skill02 = role.icons.skill02_2
      sk1:setIcon(skill02)
    end
    
    function magics.skill02_2LoopTime.onEnd(skill02_2LoopTime, casterNpc, target)
      local sk1 = role.btns.sk1
      local skill02
      local energy = get_npc_attr(role.npc, 74)
      if energy >= 100 or role.passiveStatus then
        skill02 = role.icons.skillPassive
      else
        skill02 = role.icons.skill02_1
      end
      sk1:setIcon(skill02)
    end
    
    function skills.skill02_2.onBegin(skill02_2)
      abort_magic_by_id(role.npc, magicIds.skill02_2LoopTime)
    end
  end
  skActs.block.fxFrameMagic = magics.blockFxFrame
  
  function skActs.block.start(block, event)
    block.fxFrameMagic.tick = nil
    return block.base.start(block, event)
  end
  
  function skills.Block.onBegin(BlockHitSp)
    set_keyframe_enable_by_tag(role.npc, 100101532, 1, false, true)
  end
  
  function misLogics.misBlockHit.onHit(misBlockHit, misInst, casterNpc, hitTarget, hitType, skill)
    cast_magic(role.npc, role.npc, magicIds.skill03_2LoopTime, 0)
  end
  
  function skills.BlockHit.onBegin(BlockHit)
    cameraReset(BlockHit)
    passive_energy_add(BlockHit)
    local energy = get_npc_attr(role.npc, 74)
    if energy >= 100 then
      cast_magic(role.npc, role.npc, magicIds.BlockHitSpLoopTime, 1)
    end
    role:doAfter(function()
      cast_magic(role.npc, role.npc, magicIds.skill03_2LoopTime, 0)
    end, 0.1)
  end
  
  function magics.skill03_2LoopTime.onBegin(skill03_2LoopTime, casterNpc, target)
    local sk2 = role.btns.sk2
    local skill03 = role.icons.skill03_2
    sk2:setIcon(skill03)
  end
  
  function magics.skill03_2LoopTime.onEnd(skill03_2LoopTime, casterNpc, target)
    local sk2 = role.btns.sk2
    local skill03
    local energy = get_npc_attr(role.npc, 74)
    if energy >= 100 or role.passiveStatus then
      skill03 = role.icons.skillPassive
    else
      skill03 = role.icons.Block
    end
    sk2:setIcon(skill03)
  end
  
  function magics.BlockHitSpLoopTime.onBegin(BlockHitSpLoopTime, casterNpc, target)
    local atk_B = role.btns.atk
    local skillPassive = role.icons.skillPassive3
    atk_B:setIcon(skillPassive)
  end
  
  function magics.BlockHitSpLoopTime.onEnd(BlockHitSpLoopTime, casterNpc, target)
    local atk_B = role.btns.atk
    local aktSp = role.icons.atk
    if not role.passiveStatus or is_cast_skill_time(role.npc, 100101543, 1) then
      atk_B:setIcon(aktSp)
    end
  end
  
  function skills.skillPassive3.onBegin(skillPassive3)
    abort_magic_by_id(role.npc, magicIds.BlockHitSpLoopTime)
  end
  
  function skills.skill03_2.onBegin(skill03_2)
    abort_magic_by_id(role.npc, magicIds.skill03_2LoopTime)
  end
  
  function skills.skill03_2.onHit(skill, casterNpc, hitTarget, hitType, missile)
    skill.base.onHit(casterNpc, hitTarget, hitType, missile)
    passive_energy_add(skill)
  end
  
  function skills.skill03_2.onBreak(skill)
    skill.base.onBreak(skill)
    cast_magic(role.npc, role.npc, 101582, 1)
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      return 2
    else
      return 0
    end
  end
  
  function magics.ultPassiveEnergy.onBegin(ultPassiveEnergy, casterNpc, target)
  end
  
  function misLogics.misUltCamera.onBegin(missile_cfg, missile, owner, pos_x, pos_z)
    role:change_follow_target(1, missile, {
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
    role:doAfter(function(role)
      if not role:isInControl() then
        return
      end
      change_focus_follow_speed(1.8)
      role:change_follow_target(4)
    end, 2.5)
  end
  
  function skills.ult.onEnd(ult)
    if not role.passiveStatus then
      cast_magic(role.npc, role.npc, 1015314, 1)
    end
    ult.base.onEnd(ult)
  end
  
  function skills.ult.onBreak(ult)
    if not role.passiveStatus then
      cast_magic(role.npc, role.npc, 1015314, 1)
    end
    ult.base.onBreak(ult)
  end
  
  function skills.born.onBegin(born)
    born.base.onBegin(born)
    abort_magic_by_id(role.npc, 1015310)
  end
  
  function skills.born.onEnd(born)
    born.base.onEnd(born)
    cast_magic(role.npc, role.npc, 1015310, 1)
  end
  
  function skills.finish.onBegin(finish)
    cast_magic(role.npc, role.npc, 1015314, 1)
    abort_magic_by_id(role.npc, 101546)
    abort_magic_by_id(role.npc, 1015461)
    abort_magic_by_id(role.npc, 101547)
  end
end

function Shamash.on_enter_area(role, npc, area)
  if area.Key == "right" then
    set_keyframe_enable(role.npc, 10010152121, true, true)
    set_keyframe_enable(role.npc, 10010152122, true, true)
    set_keyframe_enable(role.npc, 10010152104, false, true)
  end
end

function Shamash.on_leave_area(role, pc, area)
  if area.Key == "right" then
    set_keyframe_enable(role.npc, 10010152121, false, true)
    set_keyframe_enable(role.npc, 10010152122, false, true)
    set_keyframe_enable(role.npc, 10010152104, true, true)
  end
end

function Shamash.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if npc == role.npc then
    if not is_showup then
      if role.passiveStatus and not role:isRampage() then
        cast_magic(role.npc, role.npc, 1015114, 1)
      end
      abort_magic_by_id(role.npc, 101547)
    else
      role.passiveStatusLink = true
      if role.passiveStatus then
        cast_magic(role.npc, role.npc, 101547, 0)
      end
    end
  end
end

function Shamash.on_timeline_end(role, timeline_name)
  if role.passiveStatus then
    cast_magic(role.npc, role.npc, 1015114, 1)
  end
end

function Shamash.before_damage_target(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if 1015139 == magic_id then
    role.skill02_1Target = target
  end
end

function Shamash.onRampageEffect(role, stage)
  if role.npc ~= get_come_on_hero() then
    local passive_energy = get_npc_attr(role.npc, 74)
    if passive_energy >= 80 then
      role.ultPassiveEnergyLv = 5
    elseif passive_energy >= 60 then
      role.ultPassiveEnergyLv = 4
    elseif passive_energy >= 40 then
      role.ultPassiveEnergyLv = 3
    elseif passive_energy >= 20 then
      role.ultPassiveEnergyLv = 2
    else
      role.ultPassiveEnergyLv = false
    end
    cast_magic(role.npc, role.npc, 1015311, 1)
    cast_magic(role.npc, role.npc, 1015312, 1)
    cast_magic(role.npc, role.npc, 1015117, 1)
    role.passiveStatusLink = false
  end
end

function Shamash.onRampageEnd(role, stage)
  if not role.passiveStatusLink then
    cast_magic(role.npc, role.npc, 1015114, 1)
    role.passiveStatusLink = true
  end
end

function Shamash.on_npc_hp_zero(role, npc)
  role.base.on_npc_hp_zero(role, npc)
  if role.passiveStatus and npc == role.npc then
    cast_magic(role.npc, role.npc, 1015114, 1)
  end
  if npc == role.skill02_1Target and is_cast_skill_time(role.npc, 100101521) then
    cast_magic(role.npc, role.npc, role.magics.skill02_2LoopTime.id, 0)
  end
end

function Shamash.on_frame_background(role)
  role.base.on_frame_background(role)
  role.passiveEnergy_logic(role)
end

function Shamash.on_frame(role)
  role.base.on_frame(role)
  role.passiveEnergy_logic(role)
end

return Shamash
