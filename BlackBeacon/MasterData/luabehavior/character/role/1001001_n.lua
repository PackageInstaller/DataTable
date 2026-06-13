local roleBase = import("character.base.role_base")
local Zero = Util.create_child_mt(roleBase)

function Zero._init(role, npc)
  role.npc = npc
  local misIds = {
    skill03_2_bridCollide = 10010013304,
    skill03_2_bridPos = {10010013204, 10010013504},
    ultMissile = 10010019203
  }
  local magicIds = {
    atk4AbortChange = 1001121,
    delete_passive_energy = {
      1001321,
      1001322,
      1001934,
      1001325
    },
    skill02_2_derived_time = 1001220,
    skill03_2_extak = 1001311,
    dashAtkLoopTime = 101430,
    atkChange = 1001330
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
  set_keyframe_enable(role.npc, 10010010121, false, true)
  set_keyframe_enable(role.npc, 10010010221, false, true)
  set_keyframe_enable(role.npc, 10010010222, false, true)
  role.passive_staty = 1
  local add_passive_energy = {
    skill02_1 = {1001205, true},
    skill02_2 = {1001206, true}
  }
  role.passive_magic_attack = {1001323}
  local skill02_2_derived = true
  local skill02_2_start_pos
  local skill02_2Hit = true
  local brid_attack_pos
  local skill03Change = false
  magics.skill03Charge = magics.delete_passive_energy[1]
  local traces_magic = {
    Lv1 = 1,
    Lv2 = 1001958,
    Lv4 = 1001960
  }
  local traces = role.traces
  traces[1001951] = 1
  traces[1001952] = 2
  traces[1001953] = 3
  traces[1001954] = 4
  traces[1001955] = 5
  local brid_attack_magic = {
    1001007,
    1001009,
    1001011,
    1001013,
    1001014,
    1001016,
    1001017,
    1001022,
    1001023,
    1001227,
    1001033,
    1001034
  }
  local people_attack_magic = {
    1001006,
    1001008,
    1001010,
    1001012,
    1001014,
    1001015
  }
  local exatk04_attacl_magic = {
    1001015,
    1001016,
    1001017
  }
  local destinies_magic = {
    Lv1 = {1001931},
    Lv2 = {1001932},
    Lv3 = {1001933},
    Lv4 = {1001934, 1001936},
    Lv5 = {1001935}
  }
  local destinies = role.destinies
  destinies[1001922] = 1
  destinies[1001923] = 2
  destinies[1001924] = 3
  destinies[1001925] = 4
  destinies[1001926] = 5
  local destiniesLv4_damage = {
    1001006,
    1001007,
    1001008,
    1001010,
    1001011,
    1001012,
    1001013,
    1001014,
    1001015,
    1001016,
    1001017
  }
  local spWeapon_level = 0
  local weapon_brid_attack_magic = {
    1001007,
    1001009,
    1001011,
    1001013,
    1001014,
    1001016,
    1001017
  }
  local spWeapon_magic = {1001942}
  local spWeapon = role.spWeapon
  spWeapon.magic = 1001941
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    traces_magic.Lv1 = 2
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    traces_magic.Lv1 = 2
  end
  traces[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    traces_magic.Lv1 = 2
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    traces_magic.Lv1 = 2
  end
  traces[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    traces_magic.Lv1 = 2
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.passive_magic_attack = destinies_magic.Lv2
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.passive_magic_attack = destinies_magic.Lv2
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.passive_magic_attack = destinies_magic.Lv2
    magics.skill03Charge = magics[destinies_magic.Lv4[1]]
    icons.skill03_2.charge.magic.id = destinies_magic.Lv4[1]
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.passive_magic_attack = destinies_magic.Lv2
    magics.skill03Charge = magics[destinies_magic.Lv4[1]]
    icons.skill03_2.charge.magic.id = destinies_magic.Lv4[1]
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    spWeapon_level = 1
  end
  
  function skills.atk1.startFrame()
    if role.preAct == role.skActs.dashIn then
      return 2
    elseif role.preAct == role.skActs.dashOut then
      return 2
    else
      return 0
    end
  end
  
  function skills.atk1.onBegin(atk1)
    if role.target then
      local dist = get_npc_distance(role.npc, 1, role.target, true)
      if dist >= 2 and dist <= 5 then
        set_keyframe_enable_by_tag(role.npc, 100100101, 1, true, false)
      else
        set_keyframe_enable_by_tag(role.npc, 100100101, 1, false, true)
      end
    end
  end
  
  function magics.atkChange.onBegin(atkChange, casterNpc, target)
    set_keyframe_enable(role.npc, 10010010121, true, true)
    set_keyframe_enable(role.npc, 10010010221, true, true)
    set_keyframe_enable(role.npc, 10010010222, true, true)
    set_keyframe_enable(role.npc, 10010010101, false, true)
    set_keyframe_enable(role.npc, 10010010201, false, true)
    set_keyframe_enable(role.npc, 10010010202, false, true)
  end
  
  function magics.atkChange.onEnd(atkChange, casterNpc, target)
    set_keyframe_enable(role.npc, 10010010121, false, true)
    set_keyframe_enable(role.npc, 10010010221, false, true)
    set_keyframe_enable(role.npc, 10010010222, false, true)
    set_keyframe_enable(role.npc, 10010010101, true, true)
    set_keyframe_enable(role.npc, 10010010201, true, true)
    set_keyframe_enable(role.npc, 10010010202, true, true)
  end
  
  do
    local atkActs = {
      skActs.exatk1,
      skActs.exatk2,
      skActs.exatk3,
      skActs.exatk4
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
      
      function atk.isReady(skAct)
        if not skAct.base.isReady(skAct) then
          return false
        end
        local role = skAct.role
        local roleAct = role.skAct
        if roleAct == skAct.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
          return true
        else
          return false
        end
      end
    end
    
    function skActs.exatk4.isReady(exatk4)
      if not exatk4.base.isReady(exatk4) then
        return false
      end
      local role = exatk4.role
      local roleAct = role.skAct
      if roleAct == exatk4.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
        return true
      elseif skill03Change then
        return true
      else
        return false
      end
    end
    
    function magics.atk4AbortChange.onBegin(exatk4, casterNpc, target)
      skActs.exatk4.trans.enable.skill02_1 = "skill02_1"
      skActs.exatk4.trans.enable.skill02_2 = "skill02_2"
      skActs.exatk4.trans.enable.skill02_2 = "skill03_1"
      skActs.exatk4.trans.enable.skill02_2 = "skill03_2"
    end
    
    function magics.atk4AbortChange.onEnd(exatk4, casterNpc, target)
      skActs.exatk4.trans.enable.skill02_1 = nil
      skActs.exatk4.trans.enable.skill02_2 = nil
      skActs.exatk4.trans.enable.skill02_2 = nil
      skActs.exatk4.trans.enable.skill02_2 = nil
    end
  end
  
  function skills.skill02_1.onBegin(skill02_1)
    skill02_1.base.onBegin(skill02_1)
    if role.target then
      local dist = get_npc_distance(role.npc, 1, role.target, true)
      if dist >= 2 and dist <= 5 then
        set_keyframe_enable_by_tag(role.npc, 100100121, 1, true, false)
      else
        set_keyframe_enable_by_tag(role.npc, 100100121, 1, false, true)
      end
    end
    add_passive_energy = {
      skill02_1 = {1001205, true},
      skill02_2 = {1001206, true}
    }
    skill02_2_derived = true
  end
  
  do
    local function passive_energy_add(skill02)
      skill02.base.onHit(skill02)
      
      local skill02_combo_name = skill02.name
      if add_passive_energy[skill02_combo_name][2] and 1 == role.passive_staty then
        add_passive_energy[skill02_combo_name][2] = false
        cast_magic(role.npc, role.npc, add_passive_energy[skill02_combo_name][1], traces_magic.Lv1)
      end
    end
    
    function skActs.skill02_1.onHit(skill02_1, casterNpc, hitTarget, hitType, skill, missile)
      if skill02_1.role.skAct.name == "skill02_1" then
        passive_energy_add(skill02_1)
      end
      if skill02_2_derived then
        skill02_2_derived = false
        cast_magic(role.npc, role.npc, magicIds.skill02_2_derived_time, 1)
      end
    end
    
    function magics.skill02_2_derived_time.onBegin(skill02_2_derived_time, casterNpc, target)
      local sk1 = role.btns.sk1
      local skill02_2 = role.icons.skill02_2
      sk1:setIcon(skill02_2)
    end
    
    function magics.skill02_2_derived_time.onEnd(skill02_2_derived_time, casterNpc, target)
      local sk1 = role.btns.sk1
      local skill02_1 = role.icons.skill02_1
      sk1:setIcon(skill02_1)
    end
    
    function skills.skill02_2.onBegin(skill02_2)
      skill02_2.base.onBegin(skill02_2)
      skill02_2Hit = true
      abort_magic_by_id(role.npc, magicIds.skill02_2_derived_time)
      skill02_2_start_pos = get_npc_pos(role.npc)
      add_passive_energy = {
        skill02_1 = {1001205, true},
        skill02_2 = {1001206, true}
      }
    end
    
    function skActs.skill02_2.onHit(skill02_2, casterNpc, hitTarget, hitType, skill, missile)
      if skill02_2Hit then
        skill02_2Hit = false
        passive_energy_add(skill02_2)
        abort_skill(role.npc)
        cast_magic(role.npc, role.npc, 1001223, 1)
        skActs.skill02_2.curSk:derive(skills.skill02_2_end)
        local pos = get_npc_offset_position(hitTarget, get_npc_pos(role.npc), 180, 3)
        local is_pos, pos2 = get_nearest_walkable_pos(get_npc_pos(role.npc), pos, 1)
        role:doAfter(function()
          if is_pos and role.skAct == skill02_2 and role.skAct.curSk.name == "skill02_2_end" then
            role:tp(pos2, 7, pos)
          end
        end, 0.3)
      end
    end
    
    function skills.skill02_2.onEnd(skill02_2)
      if not check_magic(role.npc, 1001222) then
        cast_magic(role.npc, role.npc, 1001222, 1)
      end
      lookat_position(role.npc, skill02_2_start_pos.x, skill02_2_start_pos.z, true)
    end
  end
  role.skill03_expression_logic = role.skill03_expression_logic_normal
  
  function icons.skill03_1.updateEnhance(skill03_1)
    skill03_1.isEnhance = skill03_1.isEnable
  end
  
  do
    local function atk_type_expression_logic(atk_type)
      local atk_B = role.btns.atk
      
      local akt_Icon = {
        role.icons.atk,
        role.icons.exatk
      }
      atk_B:setIcon(akt_Icon[atk_type])
    end
    
    local function delete_passive_energy(delete_passive_energy, casterNpc, target)
      role:skill03_expression_logic(false)
      atk_type_expression_logic(1)
      cast_magic(role.npc, role.npc, magicIds.delete_passive_energy[2], 0)
    end
    
    local function start_passive_energy(delete_passive_energy, casterNpc, target)
      atk_type_expression_logic(2)
    end
    
    magics.delete_passive_energy[1].onBegin = start_passive_energy
    magics.delete_passive_energy[1].onEnd = delete_passive_energy
    magics.delete_passive_energy[3].onBegin = start_passive_energy
    magics.delete_passive_energy[3].onEnd = delete_passive_energy
    magics.delete_passive_energy[4].onBegin = start_passive_energy
    magics.delete_passive_energy[4].onEnd = delete_passive_energy
    
    function skills.skill03_1.onBegin(skill03_1)
      role:skill03_expression_logic(true)
    end
    
    function skills.skill03_2.onBegin(skill03_2)
      role:skill03_expression_logic(false, true)
      atk_type_expression_logic(1)
      local team = {
        get_scene_hero_by_poskey(21),
        get_scene_hero_by_poskey(22),
        get_come_on_hero()
      }
      for k, v in pairs(team) do
        abort_magic_by_id(v, role.passive_magic_attack[1])
      end
      if role.traceLv >= 4 then
        role.tool:castMagicToTeam(traces_magic.Lv4)
      end
      role.tool:castMagicToTeam(role.passive_magic_attack[1])
    end
    
    function skills.linkQte.onBegin(linkQte)
      local team = {
        get_scene_hero_by_poskey(21),
        get_scene_hero_by_poskey(22),
        get_come_on_hero()
      }
      for k, v in pairs(team) do
        abort_magic_by_id(v, role.passive_magic_attack[1])
      end
      if role.traceLv >= 4 then
        role.tool:castMagicToTeam(traces_magic.Lv4)
      end
      role.tool:castMagicToTeam(role.passive_magic_attack[1])
    end
    
    skills.skill03_2.brid_attack_pos = nil
    misLogics.skill03_2_bridPos[1].onBegin = function(misPassiveHitId, misInst, casterNpc, hitTarget, hitType, skill)
      skills.skill03_2.brid_attack_pos = get_missile_pos(misInst)
    end
    misLogics.skill03_2_bridPos[2].onBegin = function(misPassiveHitId, misInst, casterNpc, hitTarget, hitType, skill)
      skills.skill03_2.brid_attack_pos = get_missile_pos(misInst)
    end
    
    function misLogics.skill03_2_bridCollide.onHit(skill03_2_bridCollide, misInst, casterNpc, hitTarget, hitType, skill)
      local pos = get_npc_pos(hitTarget)
      local role = skill03_2_bridCollide.unit
      local skAct = role.skAct
      role:doAfter(function()
        cast_missile(role.npc, hitTarget, pos.x, pos.z, 10010013311, 0, nil, nil)
        cast_missile(role.npc, hitTarget, pos.x, pos.z, 10010013312, 0, nil, nil)
      end, 0.025)
    end
    
    function magics.skill03_2_extak.onBegin(skill03_2_extak, casterNpc, target)
      atk_type_expression_logic(2)
      skill03Change = true
    end
    
    function magics.skill03_2_extak.onEnd(skill03_2_extak, casterNpc, target)
      atk_type_expression_logic(1)
      skill03Change = false
    end
  end
  
  function skills.ult.onBegin(ult)
    if role.traceLv >= 2 then
      if role.skAct.name == "ultFast" then
        role.tool:castMagicToTeam(traces_magic.Lv2)
      else
        role:doAfter(function()
          role.tool:castMagicToTeam(traces_magic.Lv2)
        end, 0.65)
      end
    end
  end
  
  function misLogics.ultMissile.onHit(ultMissile, misInst, casterNpc, hitTarget, hitType, skill)
    if role.skAct.name == "ultFast" then
      cast_magic(role.npc, hitTarget, 1001046, 0)
      cast_magic(role.npc, hitTarget, 100104602, 0)
    end
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      return 20
    else
      return 0
    end
  end
  
  function skills.finish.onBegin(finish)
    cast_magic(role.npc, role.npc, 1001305, 0)
  end
  
  function Zero.before_damage_target(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
    if spWeapon_level >= 1 then
      for k, v in pairs(weapon_brid_attack_magic) do
        if magic_id == v then
          local weapon_advance_lv = get_weapon_advance_lv(role.npc)
          cast_magic(role.npc, target, spWeapon_magic[1], weapon_advance_lv)
        end
      end
    end
    if role.destinyLv >= 1 then
      for k, v in pairs(brid_attack_magic) do
        if magic_id == v then
          cast_magic(role.npc, role.npc, destinies_magic.Lv1[1], 0)
        end
      end
    end
    if role.destinyLv >= 3 then
      for k, v in pairs(people_attack_magic) do
        if magic_id == v then
          cast_magic(role.npc, role.npc, destinies_magic.Lv3[1], 0)
        end
      end
    end
    if role.destinyLv >= 4 then
      for k, v in pairs(destiniesLv4_damage) do
        if magic_id == v then
          cast_magic(role.npc, role.npc, destinies_magic.Lv4[2], 0)
        end
      end
    end
    if role.destinyLv >= 5 then
      for k, v in pairs(exatk04_attacl_magic) do
        if magic_id == v then
          cast_magic(npc, npc, destinies_magic.Lv5[1], 0)
        end
      end
    end
  end
end

function Zero.skill03_expression_logic_normal(role, is_open, is_cast_skill)
  local sk2 = role.btns.sk2
  local skill03_1 = role.icons.skill03_1
  local skill03_2 = role.icons.skill03_2
  local magics = role.magics
  if is_open then
    role.passive_staty = 2
    if get_cur_room_id() ~= 3101101 then
      cast_magic(role.npc, role.npc, magics.skill03Charge.id, 1)
    else
      cast_magic(role.npc, role.npc, 1001325, 1)
    end
    sk2:setIcon(skill03_2)
  elseif false == is_open and 4 ~= role:getLinkStage() then
    if is_cast_skill then
      sk2:setIcon(skill03_1)
    end
    if 2 == role.passive_staty then
      abort_magic_by_id(role.npc, magics.skill03Charge.id)
      cast_magic(role.npc, role.npc, magics.delete_passive_energy[2].id, 0)
    end
    role.passive_staty = 1
    cast_magic(role.npc, role.npc, 1001305, 0)
  end
end

function Zero.skill03_expression_logic_rampage(role, is_open, is_cast_skill)
  local sk2 = role.btns.sk2
  local skill03_2 = role.icons.skill03_2
  local magics = role.magics
  if is_open then
    role.passive_staty = 2
    if get_cur_room_id() ~= 3101101 then
      cast_magic(role.npc, role.npc, magics.skill03Charge.id, 1)
    else
      cast_magic(role.npc, role.npc, 1001325, 1)
    end
    sk2:setIcon(skill03_2)
  end
end

function Zero.on_keyframe_action(role, kfId, npcTag, comnTag)
  if "skill3_birdAtk" == npcTag then
    cast_missile(role.npc, role.target, role.skills.skill03_2.brid_attack_pos.x, role.skills.skill03_2.brid_attack_pos.z, 10010013304, 0, nil, nil)
  end
end

function Zero.on_born_behavior(role)
  role.base.on_born_behavior(role)
  local room_id = get_cur_room_id()
  if 20531 == room_id or 20532 == room_id or 20533 == room_id or 20534 == room_id then
    switch_behavior_file("character.role.1001001_S", role.npc)
    set_npc_controller(role.npc, 1)
    set_npc_speed_correct_param(role.npc, 1, 2, 8, 7)
    replace_hero_skill(3, 100100155)
    set_ui_object_visible("fight", "TeamHeads", false)
  end
end

function Zero.on_timeline_end(role, timeline_name)
  if "TIMELINE3_BOSS_0" == timeline_name then
    switch_behavior_file("character.role.1001001_S", role.npc)
    set_npc_controller(role.npc, 1)
    set_npc_speed_correct_param(role.npc, 1, 2, 8, 7)
    replace_hero_skill(3, 100100155)
    set_ui_object_visible("fight", "TeamHeads", false)
  end
end

function Zero.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if npc == role.npc then
    if is_showup then
      if 2 == role.passive_staty then
        cast_magic(role.npc, role.npc, 1001301, 1)
      end
    else
      abort_magic_by_id(role.npc, 1001301)
    end
  end
end

function Zero.onRampageStart(role, stage)
  role.passive_staty = 2
  role.skill03_expression_logic = role.skill03_expression_logic_rampage
  local sk1 = role.btns.sk1
  local sk2 = role.btns.sk2
  local skill02 = role.icons.skill02_2
  local skill03 = role.icons.skill03_2
  sk1:setIcon(skill02)
  sk2:setIcon(skill03)
end

function Zero.onRampageEnd(role, stage)
  local skActs = role.skActs
  role.skill03_expression_logic = role.skill03_expression_logic_normal
  role.passive_staty = 1
  cast_magic(role.npc, role.npc, 1001305, 0)
  local sk1 = role.btns.sk1
  local sk2 = role.btns.sk2
  local skill02 = role.icons.skill02_1
  local skill03 = role.icons.skill03_1
  sk1:setIcon(skill02)
  sk2:setIcon(skill03)
end

function Zero.on_before_skill_link_end(role, npc)
  role.base.on_before_skill_link_end(role, npc)
  abort_magic_by_id(role.npc, 1001907)
end

return Zero
