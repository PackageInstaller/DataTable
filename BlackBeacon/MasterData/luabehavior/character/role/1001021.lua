local roleBase = import("character.base.role_base")
local gauge = import("character.role.1001021_1")
local Azi = Util.create_child_mt(roleBase)
local link_up = false
local skill3_misCamInst = 0
local skill2_limit = 0
local onFire_count = 0
gauge.Azi = Azi
Azi.magicIds = {
  skill2_markFx = 1021067,
  skill2_1_elapse = {normal = 1021001, trace2 = 10210011}
}

function Azi.onRampageStart(role, stage)
  link_up = true
end

function Azi.onRampageEnd(role, stage)
  link_up = false
  if role.destinyLv < 3 then
    set_keyframe_enable_by_tag(role.npc, 100102151, 1, true, true)
    set_keyframe_enable_by_tag(role.npc, 100102151, 2, false, true)
    set_keyframe_enable_by_tag(role.npc, 100102151, 3, false, true)
    set_keyframe_enable_by_tag(role.npc, 100102151, 4, false, true)
  else
    set_keyframe_enable_by_tag(role.npc, 100102151, 1, false, true)
    set_keyframe_enable_by_tag(role.npc, 100102151, 2, true, true)
    set_keyframe_enable_by_tag(role.npc, 100102151, 3, false, true)
    set_keyframe_enable_by_tag(role.npc, 100102151, 4, false, true)
  end
end

function Azi.onLinkChange(role, newStage, oldStage)
  if 2 ~= newStage then
    return
  end
  local skActs = role.skActs
end

local magicIds_1 = {}

function Azi._init(role, npc)
  gauge.azi = npc
  role.npc = npc
  local misIds = {
    Skill2_2M1 = 10010212102,
    Skill2_2M2 = 10010212103,
    Skill2_2M3 = 10010212107,
    Skill2_2M4 = 10010212112,
    Skill2_2M11 = 10010212114,
    Skill2_2M22 = 10010212115,
    Skill2_2M33 = 10010212116,
    Skill2_2M44 = 10010212113,
    Skill2_2M44_destinies4 = 10010212117,
    Skill2_2M4_destinies4 = 10010212118,
    Skill2_boom1 = 10010212119,
    Skill_qte = 10010218111,
    Skill3_misCam = 10010215120,
    Skill3_mis1 = 10010215102,
    Skill3_mis2 = 10010215105,
    Skill3_mis3 = 10010215107,
    Skill3_mis4 = 10010215108
  }
  local magicIds = {
    atk_weapDissolve = 10210911,
    Skill2_2State = 1021001,
    Skill2_2State1 = 10210011,
    camera1 = 1021002,
    electricity = 1021070,
    power_up = 1021078,
    Skill3_3State = 1021086,
    Skill3_2State = 1021087,
    detonate = 1021088,
    detonate2 = 1021089,
    conceal_weapon = 1021093,
    conceal_weapon1 = 1021095,
    conceal_weapon3 = 1021101,
    start2_2 = 1021010,
    aZi_onFire = 1021072,
    linkQte_magic = 10210091
  }
  roleBase._init(role, misIds, magicIds)
  local traces = role.traces
  traces[1021048] = 1
  traces[1021049] = 2
  traces[1021050] = 3
  traces[1021051] = 4
  traces[1021052] = 5
  local destinies = role.destinies
  destinies[1021053] = 1
  destinies[1021054] = 2
  destinies[1021055] = 3
  destinies[1021056] = 4
  destinies[1021057] = 5
  local spWeapon = role.spWeapon
  spWeapon.magic = 1021058
  gauge.traceLv = role.traceLv
  gauge.destinyLv = role.destinyLv
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local skill2_x, skill2_z
  role.Skill2_2State = 1021001
  role.Skill2_2M1 = misIds.Skill2_2M1
  role.Skill2_2M2 = misIds.Skill2_2M2
  role.Skill2_2M3 = misIds.Skill2_2M3
  role.Skill2_2M4 = misIds.Skill2_2M4
  
  function role.baseActs.wander.start(wander)
    local roleAct = wander.role.skAct
    if not roleAct.isOver then
      roleAct:onBreak(wander)
    end
    cast_magic(npc, npc, 1021013, 0)
    wander.role:updateAct(wander)
  end
  
  function magics.linkQte_magic.onBegin(linkQte_magic)
    if role.target then
      local pos = get_npc_pos(role.target)
      cast_missile3(npc, nil, pos.x, pos.z, 10010212307, 0)
    else
      local pos = get_npc_offset_position(npc, nil, 0, 3)
      cast_missile3(npc, nil, pos.x, pos.z, 10010212307, 0)
    end
  end
  
  skActs.linkQte.tarPos = skActs.linkQte.base.tarPos
  
  function skActs.heavy.tarPos(heavy, event)
    local pos = heavy.base.tarPos(heavy, event)
    pos = get_npc_offset_position(npc, pos, 0, 10)
    return pos
  end
  
  function skActs.heavy.onBegin(heavy)
    abort_magic_by_id(npc, 1021091, 1)
    if not link_up then
      return
    end
    if role.destinyLv < 3 then
      set_keyframe_enable_by_tag(role.npc, 100102151, 1, false, true)
      set_keyframe_enable_by_tag(role.npc, 100102151, 2, false, true)
      set_keyframe_enable_by_tag(role.npc, 100102151, 3, true, true)
    elseif role.destinyLv >= 3 then
      set_keyframe_enable_by_tag(role.npc, 100102151, 1, false, true)
      set_keyframe_enable_by_tag(role.npc, 100102151, 2, false, true)
      set_keyframe_enable_by_tag(role.npc, 100102151, 3, false, true)
      set_keyframe_enable_by_tag(role.npc, 100102151, 4, true, true)
    end
    heavy.base.onBegin(heavy)
  end
  
  do
    local function skill3_camera_change(Skill3_Cam, Skill3_CamInst, posX, posZ)
      skill3_misCamInst = Skill3_CamInst
      
      if get_come_on_hero() == role.npc then
        role:change_follow_target(1, Skill3_CamInst, {
          9999,
          0,
          {
            x = 0,
            y = 0,
            z = 50
          },
          0,
          0,
          0.1
        })
        role:doAfter(function()
          change_focus_follow_speed(1.75)
          role:change_follow_target(4)
        end, 1.25, true)
      end
    end
    
    misLogics.Skill3_misCam.onBegin = skill3_camera_change
    
    local function skill3_camera_focus(skill3_camera_focus, skill3_camera_focusInst, posX, posZ)
      change_missile_move_params(skill3_misCamInst, 0, 0)
      skill3_misCamInst = 0
    end
    
    misLogics.Skill3_mis1.onHit = skill3_camera_focus
    misLogics.Skill3_mis2.onHit = skill3_camera_focus
    misLogics.Skill3_mis3.onHit = skill3_camera_focus
    misLogics.Skill3_mis4.onHit = skill3_camera_focus
    
    function skActs.heavy.onHit(heavy, casterNpc, hitTarget)
      if check_magic(hitTarget, role.magicIds.skill2_markFx) then
        cast_magic(role.npc, role.npc, 1021123, 0)
      end
      heavy.base.onHit(heavy)
    end
  end
  
  function misLogics.Skill_qte.onBegin(Skill_qte, ultInst, owner, posX, posZ)
    role:change_follow_target(1, ultInst, {
      9999,
      0,
      {
        x = 0,
        y = 0,
        z = 150
      },
      2,
      1,
      0.05
    })
    role:doAfter(function()
      change_focus_follow_speed(1.5)
      role:change_follow_target(0)
    end, 2, true)
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      return 6
    else
      return 0
    end
  end
  
  function misLogics.Skill2_boom1.onHit(Skill2_boom1, Skill2_boom1Inst, casterNpc, hitTarget, hitType, skill)
    if check_magic(hitTarget, 1021111) and 0 == skill2_limit and is_cast_skill_time(npc, 100102122) then
      local pos = get_missile_pos(Skill2_boom1Inst)
      cast_missile3(npc, nil, pos.x, pos.z, 10010212121, 0)
      skill2_limit = 1
    end
  end
  
  function skills.skill02_1.onBegin(skill02_1)
    skill2_limit = 0
    local tarPos = skill02_1.skAct.v_tarPos
    if tarPos then
      local rolePos = skill02_1.role.npc:get_pos_vec3()
      if (rolePos - tarPos):sqrMagnitude() >= 81 then
        tarPos = get_npc_offset_position(role.npc, nil, 0, 4)
      end
      skill2_x, skill2_z = tarPos.x, tarPos.z
    else
      local pos = get_npc_offset_position(role.npc, nil, 0, 4)
      skill2_x = pos.x
      skill2_z = pos.z
    end
    return skill02_1.base.onBegin(skill02_1)
  end
  
  function magics.start2_2.onBegin(start2_2)
    local sk1 = btns.sk1
    local skill02_2 = icons.skill02_2
    sk1:setIcon(skill02_2)
    cast_missile3(npc, nil, skill2_x, skill2_z, role.Skill2_2M3, 0)
    cast_missile3(npc, nil, skill2_x, skill2_z, role.Skill2_2M1, 0)
    if role.destinyLv >= 4 and role.traceLv >= 2 then
      cast_missile3(npc, nil, skill2_x, skill2_z, misIds.Skill2_2M44_destinies4, 0)
    elseif role.destinyLv >= 4 and role.traceLv < 2 then
      cast_missile3(npc, nil, skill2_x, skill2_z, misIds.Skill2_2M4_destinies4, 0)
    end
    role:doAfter(function()
      local hero = get_come_on_hero()
      cast_missile3(npc, nil, skill2_x, skill2_z, role.Skill2_2M2, 0)
    end, 0.05, true)
    role:doAfter(function()
      local hero = get_come_on_hero()
      cast_missile3(npc, nil, skill2_x, skill2_z, role.Skill2_2M4, 0)
    end, 0.1, true)
  end
  
  function magics.detonate.onBegin(detonate)
    remove_missile_by_id(role.Skill2_2M1, npc, true)
    remove_missile_by_id(role.Skill2_2M3, npc, true)
    remove_missile_by_id(role.Skill2_2M4, npc, true)
    if role.destinyLv >= 4 and role.traceLv >= 2 then
      remove_missile_by_id(misIds.Skill2_2M44_destinies4, npc, true)
    elseif role.destinyLv >= 4 and role.traceLv < 2 then
      remove_missile_by_id(misIds.Skill2_2M4_destinies4, npc, true)
    end
  end
  
  function magics.detonate2.onBegin(detonate2)
    remove_missile_by_id(role.Skill2_2M2, npc, true)
    abort_magic_by_id(npc, 1021002)
  end
  
  function skActs.skill02_2.start(skill02_2)
    skill02_2.base.start(skill02_2)
    local role = skill02_2.role
    local sk1 = btns.sk1
    local skill02_1 = icons.skill02_1
    local camera1 = role.magics.camera1
    abort_magic_by_id(npc, camera1.id)
    abort_magic_by_id(npc, role.Skill2_2State)
    remove_missile_by_id(misIds.Skill2_2M4, npc, true)
  end
  
  function magics.Skill2_2State.onEnd(Skill2_2State)
    local sk1 = btns.sk1
    local skill02_1 = icons.skill02_1
    sk1:setIcon(skill02_1)
  end
  
  magics.Skill2_2State1.onEnd = magics.Skill2_2State.onEnd
  
  function skActs.skill02_2.onEnd(skill02_2)
    local role = skill02_2.role
    local camera1 = role.magics.camera1
    abort_magic_by_id(npc, camera1.id)
  end
  
  icons.skill02_2.skill02_1 = icons.skill02_1
  traces[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(npc, 100102181, 2, false, true)
    set_keyframe_enable_by_tag(npc, 100102181, 1, true, true)
    set_keyframe_enable_by_tag(npc, 100102151, 1, true, true)
    set_keyframe_enable_by_tag(npc, 100102151, 2, false, true)
    set_keyframe_enable_by_tag(npc, 100102121, 1, true, true)
    set_keyframe_enable_by_tag(npc, 100102121, 2, false, true)
    set_keyframe_enable_by_tag(npc, 100102151, 3, false, true)
    set_keyframe_enable_by_tag(npc, 100102151, 4, false, true)
  end
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(npc, 100102181, 1, false, true)
    set_keyframe_enable_by_tag(npc, 100102181, 2, true, true)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.Skill2_2State = magicIds.Skill2_2State1
    icons.skill02_2.charge.magic.id = role.Skill2_2State
    set_keyframe_enable_by_tag(npc, 100102121, 2, true, true)
    set_keyframe_enable_by_tag(npc, 100102121, 1, false, true)
    role.Skill2_2M1 = misIds.Skill2_2M11
    role.Skill2_2M2 = misIds.Skill2_2M22
    role.Skill2_2M3 = misIds.Skill2_2M33
    role.Skill2_2M4 = misIds.Skill2_2M44
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function Skill2_2M3defenceDown(Skill2_2M3, Skill2_2M3Inst, casterNpc, hitTagrget)
      cast_magic(npc, hitTagrget, 1021060)
    end
    
    tool.insert(misLogics.Skill2_2M4, "onHit", Skill2_2M3defenceDown)
    tool.insert(misLogics.Skill2_2M44, "onHit", Skill2_2M3defenceDown)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function Skill2_2M3speedDown(Skill2_2M3, Skill2_2M3Inst, casterNpc, hitTagrget)
      cast_magic(npc, hitTagrget, 1021061)
    end
    
    tool.insert(misLogics.Skill2_2M4, "onHit", Skill2_2M3speedDown)
    tool.insert(misLogics.Skill2_2M44, "onHit", Skill2_2M3speedDown)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(npc, 100102151, 1, false, true)
    set_keyframe_enable_by_tag(npc, 100102151, 2, true, true)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
end

function Azi.before_damage(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  role.base.before_damage(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
  if npc ~= role.npc then
    return
  end
  local npc = role.npc
  if 10210261 == magic_id and check_magic(target, 1021111) and is_cast_skill_time(npc, 100102122) then
    cast_magic(npc, npc, 10210673, 0)
  end
  if (10210771 == magic_id or 10210772 == magic_id) and check_magic(target, role.magicIds.skill2_markFx) then
    cast_magic(npc, npc, 10210672, 0)
  end
  if 5 ~= get_role_kind(target) and 6 ~= get_role_kind(target) and target and not check_magic(target, 1021047) then
    cast_magic(npc, target, 1021066, 1)
    cast_magic(npc, target, 1021069, 1)
    cast_magic(npc, target, 1021047, 1)
  end
end

function Azi.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  local icons = role.icons
  local btns = role.btns
  if npc ~= npc then
    return
  end
  if not is_showup then
    abort_magic_by_id(npc, 1021012, 1)
    abort_magic_by_id(npc, 1021091, 1)
  else
    abort_magic_by_id(npc, 1021091, 1)
  end
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
end

function Azi.on_keyframe_action(role, kfId)
  local magics = role.magicIds.skill2_1_elapse
  if 10010212125 == kfId then
    return role:addMagic(magics.normal)
  elseif 10010212124 == kfId then
    return role:addMagic(magics.trace2)
  end
end

function Azi.start_onFire()
  onFire_count = onFire_count + 1
end

function Azi.remove_onFire(azi, npc)
  onFire_count = onFire_count - 1
  if onFire_count < 0 then
    onFire_count = 0
  end
  if 0 == onFire_count then
    if npc then
      abort_magic_by_id(npc, 10211121)
    end
    azi.tool:abortMagicToTeam(10211122)
  end
end

return Azi
