local roleBase = import("character.base.role_base")
local tool = import("common.tool")
local hefei = Util.create_child_mt(roleBase)
local link_up = false
local link_hit_num = 0
local link_creat_new_area = 0
local same_frame_cast = false
local same_frame_cast_time = 0
local traces4_CD = 0

function hefei.onLinkEffect(role)
  if link_hit_num < 3 then
    link_hit_num = link_hit_num + 1
  end
  link_creat_new_area = link_creat_new_area + 1
  cast_magic(role.npc, role.npc, 10135171, 0)
  cast_magic(role.npc, role.npc, 10135181, 0)
end

function hefei.onRampageStart(role)
  link_up = true
end

function hefei.onRampageEnd(role, stage)
  link_up = false
end

function hefei.onLinkChange(role, newStage, oldStage)
  if 2 ~= newStage then
    return
  end
end

local misIds_1 = {}
local magicIds_1 = {magic_ultPass = 1013502}

function hefei._init(role, npc)
  role.npc = npc
  local misIds = {
    Skill3 = 10010136001,
    Skill3_1 = 10010136004,
    Skill02_1 = 10010132003,
    Skill02_2 = 10010132109
  }
  local magicIds = {
    skill2_power = 1013211,
    skill2_abort_skill3 = 1013310,
    skill22_abort_skill21 = 1013311,
    skill21_abort_skill22 = 1013312,
    fire_power = 1013711,
    shield = 1013715,
    shield_real = 10137151,
    shield1 = 1013713,
    shield1_real = {
      10137131,
      10137132,
      10137133
    }
  }
  role.ultHideList = UtilTable.copy_table(role.ultHideList)
  role.ultHideList.JoystickContent = false
  roleBase._init(role, misIds, magicIds)
  local traces = role.traces
  local traces2 = false
  local traces4 = false
  role.shield = 1013715
  local destinies = role.destinies
  local traces = role.traces
  local destinies = role.destinies
  local spWeapon = role.spWeapon
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  skActs.born = nil
  
  function skActs.skill03_1.onBegin(skill03_1)
    if not traces2 then
      remove_missile_by_id(misIds.Skill3, role.npc, true)
    else
      remove_missile_by_id(misIds.Skill3_1, role.npc, true)
    end
    skill03_1.base.onBegin(skill03_1)
  end
  
  function magics.skill2_abort_skill3.onBegin(skill2_abort_skill3)
    local skill02_1 = skActs.skill02_1
    local skill02_2 = skActs.skill02_2
    skActs.linkQte.trans.enable.skill02_1 = true
    skActs.linkQte.trans.enable.skill02_2 = true
    skill02_1.trans.prio = 4
    skill02_2.trans.prio = 4
  end
  
  function magics.skill2_abort_skill3.onEnd(skill2_abort_skill3)
    local skill02_1 = skActs.skill02_1
    local skill02_2 = skActs.skill02_2
    skActs.linkQte.trans.enable.skill02_1 = nil
    skActs.linkQte.trans.enable.skill02_2 = nil
    skill02_1.trans.prio = 3
    skill02_2.trans.prio = 3
  end
  
  function magics.skill22_abort_skill21.onBegin(skill2_abort_skill3)
    local sk1 = btns.sk1
    local skill02_2 = icons.skill02_2
    sk1:setIcon(skill02_2)
  end
  
  function magics.skill21_abort_skill22.onBegin(skill2_abort_skill3)
    local sk1 = btns.sk1
    local skill02_1 = icons.skill02_1
    sk1:setIcon(skill02_1)
  end
  
  function skills.skill02_1.startFrame()
    if check_magic(role.npc, magicIds.skill21_abort_skill22) or check_magic(role.npc, magicIds.skill2_abort_skill3) then
      set_keyframe_enable_by_tag(role.npc, skills.skill02_1.id, 3, true, true)
      return 5
    else
      return 0
    end
  end
  
  function skills.skill02_2.startFrame()
    if check_magic(role.npc, magicIds.skill22_abort_skill21) or check_magic(role.npc, magicIds.skill2_abort_skill3) then
      set_keyframe_enable_by_tag(role.npc, skills.skill02_2.id, 3, true, true)
      return 5
    else
      return 0
    end
  end
  
  function skActs.skill02_1.onEnd(skill02_1)
    set_keyframe_enable_by_tag(role.npc, skills.skill02_1.id, 3, false, true)
    skill02_1.base.onEnd(skill02_1)
  end
  
  function skActs.skill02_1.onBreak(skill02_1, tarAct)
    set_keyframe_enable_by_tag(role.npc, skills.skill02_1.id, 3, false, true)
    skill02_1.base.onBreak(skill02_1, tarAct)
  end
  
  function skActs.skill02_2.onEnd(skill02_2)
    set_keyframe_enable_by_tag(role.npc, skills.skill02_2.id, 3, false, true)
    skill02_2.base.onEnd(skill02_2)
  end
  
  function skActs.skill02_2.onBreak(skill02_2, tarAct)
    set_keyframe_enable_by_tag(role.npc, skills.skill02_2.id, 3, false, true)
    skill02_2.base.onBreak(skill02_2, tarAct)
  end
  
  function skActs.skill02_1.onBegin(skill02_1)
    role.missile_pos_list = {}
    abort_magic_by_id(role.npc, magicIds.skill2_abort_skill3)
    cast_magic(role.npc, role.npc, 1013518, 0)
    if link_up then
      if 1 == link_hit_num then
        cast_magic(role.npc, role.npc, 10137231, 0)
      elseif 2 == link_hit_num then
        cast_magic(role.npc, role.npc, 10137232, 0)
      elseif 3 == link_hit_num then
        cast_magic(role.npc, role.npc, 10137233, 0)
      end
    end
    skill02_1.base.onBegin(skill02_1)
  end
  
  function skActs.skill02_2.onBegin(skill02_2)
    role.missile_pos_list = {}
    abort_magic_by_id(role.npc, 1013211)
    cast_magic(role.npc, role.npc, 1013517, 0)
    if link_up then
      if 1 == link_hit_num then
        cast_magic(role.npc, role.npc, 10137231, 0)
      elseif 2 == link_hit_num then
        cast_magic(role.npc, role.npc, 10137232, 0)
      elseif 3 == link_hit_num then
        cast_magic(role.npc, role.npc, 10137233, 0)
      end
    end
    skill02_2.base.onBegin(skill02_2)
  end
  
  function skActs.skill02_2.onCastTime(skill02_2)
    local sk1 = btns.sk1
    local skill02_1 = icons.skill02_1
    sk1:setIcon(skill02_1)
    skill02_2.base.onCastTime(skill02_2)
  end
  
  function skills.skill02_1.tarPos(skill02_1)
    local pos = {}
    pos.x, pos.z = get_indicator_pos(19)
    return pos
  end
  
  function skills.skill02_2.tarPos(skill02_2)
    local pos = {}
    pos.x, pos.z = get_indicator_pos(19)
    return pos
  end
  
  do
    local function creat_new_area(Skill02, Skill02Inst, owner, posX, posZ)
      local pos = get_missile_pos(Skill02Inst)
      
      if link_up and 3 == link_creat_new_area then
        link_creat_new_area = 0
        if not traces2 then
          remove_missile_by_id(misIds.Skill3, role.npc, true)
        else
          remove_missile_by_id(misIds.Skill3_1, role.npc, true)
        end
        if role.traceLv < 2 then
          remove_missile_by_id(10010133003, role.npc, true)
          cast_missile3(role.npc, nil, pos.x, pos.z, 10010133003, 1, pos.x, pos.z)
        else
          remove_missile_by_id(10010133002, role.npc, true)
          cast_missile3(role.npc, nil, pos.x, pos.z, 10010133002, 1, pos.x, pos.z)
        end
      end
    end
    
    misLogics.Skill02_1.onBegin = creat_new_area
    misLogics.Skill02_2.onBegin = creat_new_area
    
    local function abort_magic_speedup()
      if not link_up then
        return
      end
      abort_magic_by_id(role.npc, 10137231)
      abort_magic_by_id(role.npc, 10137232)
      abort_magic_by_id(role.npc, 10137233)
    end
    
    tool.insert(skActs.skill02_1, "onEnd", abort_magic_speedup)
    tool.insert(skActs.skill02_1, "onBreak", abort_magic_speedup)
    tool.insert(skActs.skill02_2, "onEnd", abort_magic_speedup)
    tool.insert(skActs.skill02_2, "onBreak", abort_magic_speedup)
  end
  do
    local function core_magic(role, npc, target, magic_id)
      local function delay()
        if magic_id == role.shield then
          local buff_num = get_magic_num(role.npc, role.shield)
          
          if 0 == buff_num then
            tool:abortMagicToTeam(10137151, 1013709, 1013708, 1013701, 10137092)
          end
        end
      end
      
      role:doAfter(delay)
    end
    
    tool.insert(role, "on_magic_end", core_magic)
  end
  do
    local function core_boom(Skill3, Skill3_Inst, mis2, Skill3_Owner, mis2Owner)
      local m2Cfg = mis2.missile_cfg
      
      local m2Id = m2Cfg.Id
      local m1Cfg = Skill3_Inst.missile_cfg
      local m1Id = m1Cfg.Id
      local missile_pos = 0
      local skill_lv = get_skill_lv(role.npc, 100101360) or 0
      if 10010132003 == m2Id then
        missile_pos = get_missile_pos(Skill3_Inst)
        local pos = get_npc_offset_position(role.npc, nil, 0, 1)
        cast_magic(role.npc, role.npc, 1013319, 1)
        if link_up then
          role:onLinkEffect()
        end
        role:case_role_shield(role.npc, 5)
        if not traces2 then
          cast_missile3(role.npc, nil, missile_pos.x, missile_pos.z, 10010136003, skill_lv, pos.x, pos.z)
          role.missile_pos_list = {}
        else
          cast_missile3(role.npc, nil, missile_pos.x, missile_pos.z, 10010136002, skill_lv, pos.x, pos.z)
          role.missile_pos_list = {}
        end
      end
      if 10010132109 == m2Id then
        missile_pos = get_missile_pos(Skill3_Inst)
        local pos = get_npc_offset_position(role.npc, nil, 0, 1)
        cast_magic(role.npc, role.npc, 1013319, 1)
        if link_up then
          role:onLinkEffect()
        end
        role:case_role_shield(role.npc, 5)
        if not traces2 then
          cast_missile3(role.npc, nil, missile_pos.x, missile_pos.z, 10010136003, skill_lv, pos.x, pos.z)
          role.missile_pos_list = {}
        else
          cast_missile3(role.npc, nil, missile_pos.x, missile_pos.z, 10010136002, skill_lv, pos.x, pos.z)
          role.missile_pos_list = {}
        end
      end
    end
    
    misLogics.Skill3.onCollideMis = core_boom
    misLogics.Skill3_1.onCollideMis = core_boom
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      return 6
    else
      return 0
    end
  end
  
  function skActs.linkQte.onBegin(linkQte)
    role:case_role_shield(role.npc, 5)
    linkQte.base.onBegin(linkQte)
  end
  
  skActs.linkQte.tarPos = skActs.linkQte.base.tarPos
  traces[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(role.npc, skills.skill02_1.id, 3, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.skill02_2.id, 3, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.skill03_1.id, 1, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.skill03_1.id, 2, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.linkQte.id, 1, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.linkQte.id, 2, false, true)
    
    local function sheild_realMagic(role, target, magic_id)
      if magic_id == role.shield then
        local num = get_magic_num(role.npc, role.shield)
        if check_magic(role.npc, 10137151) then
          return
        end
        if 2 == num or 3 == num or 5 == num then
          tool:castMagicToTeam(10137151, 0, role.npc)
        end
      end
    end
    
    tool.insert(role, "on_self_magic_begin", sheild_realMagic)
  end
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function atkup(role, target, magic_id)
      if magic_id == role.shield and not check_magic(npc, 1013701) then
        tool:castMagicToTeam(1013701, 1, role.npc, 1)
      end
    end
    
    tool.insert(role, "on_self_magic_begin", atkup)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    traces2 = true
    set_keyframe_enable_by_tag(role.npc, skills.skill03_1.id, 1, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.skill03_1.id, 2, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.linkQte.id, 1, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.linkQte.id, 2, true, true)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function effectUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id)
      if 100101320 == skill_id or 100101321 == skill_id then
        cast_magic(npc, npc, 1013705, 0)
      end
    end
    
    tool.insert(role, "before_damage_target", effectUp)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damagefix(role, target, magic_id)
      if 1013541 == magic_id then
        cast_magic(npc, npc, 1013704, 0)
      end
    end
    
    tool.insert(role, "before_damage_target", damagefix)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function fireup(Pos, PosInst, owner, posX, posZ)
      cast_magic(npc, npc, 1013707, 0)
    end
    
    misLogics.Skill3.onBegin = fireup
    misLogics.Skill3_1.onBegin = fireup
    
    local function firedown(Pos, PosInst, owner, posX, posZ)
      abort_magic_by_id(npc, 1013707)
    end
    
    misLogics.Skill3.onEnd = firedown
    misLogics.Skill3_1.onEnd = firedown
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id)
      if check_magic(target, 1999991) and (100101320 == skill_id or 100101321 == skill_id) then
        cast_magic(role.npc, role.npc, 1013714, 0)
      end
    end
    
    tool.insert(role, "before_damage_target", damageFix)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function essence_up(role, ncp, magic_id)
      if magic_id == role.shield then
        if check_magic(role.npc, 1013708) then
          return
        end
        tool:castMagicToTeam(1013708, 1)
      end
    end
    
    tool.insert(role, "on_self_magic_begin", essence_up)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function penetration_up(role, ncp, magic_id)
      local penetration_magic = 10137092
      
      local element_attr = get_npc_attr(role.npc, 23)
      if element_attr >= 750 then
        penetration_magic = 1013709
      else
        penetration_magic = 10137092
      end
      if magic_id == role.shield then
        if check_magic(role.npc, 1013709) or check_magic(role.npc, 10137092) then
          return
        end
        tool:castMagicToTeam(penetration_magic, spWeapon.lv, role.npc)
      end
    end
    
    tool.insert(role, "on_self_magic_begin", penetration_up)
    
    local function damageFix(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id)
      if 100101330 == skill_id or 100101352 == skill_id then
        cast_magic(role.npc, role.npc, 10137091, spWeapon.lv)
      end
    end
    
    tool.insert(role, "before_damage_target", damageFix)
  end
end

function hefei.after_damage(role, npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if not role.tool:isInTeam(target) then
    return
  end
  local damage = -damage_val
  local hp_max = get_npc_attr(target, 4)
  local hp_per = math.floor(damage / hp_max * 100)
  if check_magic(role.npc, role.shield) and hp_per >= 1 then
    tool:abortMagicToTeamA(role.shield, 1)
  end
end

function hefei.on_element_aborn_start(role, npc, element, skill_id, attacker)
  if 3 == element and role.traceLv >= 4 and get_npc_time(role.npc) > traces4_CD then
    local hero = get_come_on_hero()
    cast_magic(role.npc, hero, 1013702, 0)
    traces4_CD = get_npc_time(role.npc) + 10
  end
end

function hefei.case_role_shield(role, npc, num)
  local now_num = get_magic_num(npc, role.shield)
  if 5 == now_num and same_frame_cast_time < get_npc_time(npc) then
    role.tool.castMagicToTeam(tool, role.shield, 0, npc, 1)
    same_frame_cast_time = get_npc_time(npc)
  elseif now_num < 5 then
    if num >= 5 - now_num then
      role.tool.castMagicToTeam(tool, role.shield, 0, npc, 5 - now_num)
      same_frame_cast_time = get_npc_time(npc)
    elseif num < 5 - now_num and num > 0 then
      role.tool.castMagicToTeam(tool, role.shield, 0, npc, num)
    end
  end
end

return hefei
