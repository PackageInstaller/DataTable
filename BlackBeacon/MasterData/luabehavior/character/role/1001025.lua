local roleBase = import("character.base.role_base")
local Sevika = Util.create_child_mt(roleBase)
local qte_lance_num = 0
local qte_lance_num_max = 3
local qte_lance_num_now = 0
local qte_lance_num_now_max = 3
local qte_lance_timer
local exQte_active = false
local qte_first_delay = true
local shiftGear_exHit_Damg = 10257101
local shiftGear_exHit_DamgFix1 = 102500621
local shiftGear_exHit_DamgFix2 = 102500622
local shiftGear_exHit_DamgFixTrace1 = 102507012
local link_up = false

function Sevika._init(role, npc)
  role.npc = npc
  local misIds = {
    qte_lance_hitMis = 10010254208,
    qte_lance_effectMis = 10010254209,
    kneeStrikeMis = 10010252101,
    spiralPrickMis = 10010252204,
    skill3Focus = 10010253314,
    linkQte_focus = 10010254314,
    skill3_1Focus = 10010253118,
    ult_1Focus = 10010256119,
    ult_2Focus = 10010256120
  }
  local magicIds = {
    shiftGears1_effect = 1025001,
    shiftGears1_CamEffect = 10250011,
    shiftGears2_effect = 1025002,
    shiftGears2_CamEffect = 10250021,
    shiftGears3_effect1 = 1025003,
    shiftGears3_effect2 = 1025005,
    shiftGears3_CamEffect = 10250031,
    shiftGears_magic = 1025006,
    shiftGears_reset = 1025004,
    shiftGears4_magic = 10250051,
    kneeStrike_Derive = 10250063,
    kneeStrike_TransEnable = 102500631,
    penetrating_Derive = 10250061,
    spiralPrick_TransEnable = 102500611,
    shiftGear_exHitCd = 10250062,
    shiftGear_exHit_DamgFix1 = 102500621,
    shiftGear_exHit_DamgFix2 = 102500622,
    shiftGear_exHitCd_trace1 = 102507011,
    shiftGear_exHit_DamgFixTrace1 = 102507012,
    shiftGear_lanceDown_damg = 10257102,
    shiftGear_lanceDown_damg_destiny2 = 10257103,
    atk04_05Ready = 10250064,
    heavy_atk3 = 102500642,
    smashDown_Fast = 1025031,
    smashDown_Flash = 1025032,
    weapon_display = 10250046
  }
  roleBase._init(role, misIds, magicIds)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local traces = role.traces
  traces[10250701] = 1
  traces[10250702] = 2
  traces[10250703] = 3
  traces[10250704] = 4
  traces[10250705] = 5
  local destinies = role.destinies
  destinies[10250801] = 1
  destinies[10250802] = 2
  destinies[10250803] = 3
  destinies[10250804] = 4
  destinies[10250805] = 5
  local spWeapon = role.spWeapon
  role.shiftGear_Stage = 0
  role.skill2_firstHit = false
  role.kneeStrikeHit = false
  role.spiralPrickHit = false
  role.destiny1AtkUp = false
  role.destiny1AtkUp_limit = false
  role.exQteActive = false
  role.exSkill_note = {}
  role.linkUp_num = 0
  role.linkup_exskill = false
  role:tag_switch()
  qte_lance_timer = get_npc_time(npc)
  
  function skActs.atk4.onEnd(atk4)
    cast_magic(npc, npc, 1025009)
    atk4.base.onEnd(atk4)
  end
  
  function skActs.atk4.onBreak(atk4, tarAct)
    cast_magic(npc, npc, 1025009)
    atk4.base.onBreak(atk4, tarAct)
  end
  
  function skActs.atk5.isReady(atk5)
    if not atk5.base.isReady(atk5) then
      return false
    end
    local role = atk5.role
    local roleAct = role.skAct
    if check_magic(npc, magicIds.atk04_05Ready) then
      return true
    else
      return false
    end
  end
  
  skActs.atk2.heavy = skActs.heavy
  
  function skActs.atk2.isReady(atk2)
    if not atk2.base.isReady(atk2) then
      return false
    end
    local role = atk2.role
    local roleAct = role.skAct
    if roleAct == atk2.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif roleAct == atk2.heavy and is_cast_skill_time(npc, 100102506) then
      return true
    else
      return false
    end
  end
  
  function magics.heavy_atk3.onBegin()
    local atk = role.icons.atk
    if atk:getState() == "masked" or atk:getState() == "hitting" or atk:getState() == "holding" then
      role.skActs.atk3:try()
    end
  end
  
  skActs.atk3.heavy = skActs.heavy
  skActs.atk3.counter = skActs.counter
  
  function skActs.atk3.isReady(atk3)
    if not atk3.base.isReady(atk3) then
      return false
    end
    local role = atk3.role
    local roleAct = role.skAct
    local atk = role.icons.atk
    if roleAct == atk3.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif roleAct == atk3.counter then
      return true
    elseif roleAct == atk3.heavy and check_magic(npc, magicIds.heavy_atk3) and atk:getState() == "holding" then
      return true
    else
      return false
    end
  end
  
  do
    local function tag_close()
      role:tag_switch()
    end
    
    magics.shiftGear_exHitCd.onBegin = tag_close
    magics.shiftGear_exHitCd_trace1.onBegin = tag_close
    magics.shiftGears4_magic.onBegin = tag_close
    
    function Sevika.on_skill_begin(role, npc, skill_id, skill_type)
      role.base.on_skill_begin(role, npc, skill_id, skill_type)
      if npc ~= role.npc then
        return
      end
      local kickAssId = 100102532
      local atk5 = 100102505
      if skill_id ~= kickAssId and skill_id ~= atk5 then
        cast_magic(role.npc, role.npc, magicIds.weapon_display, 0)
      end
      if 4 == role.shiftGear_Stage or 0 == role.shiftGear_Stage then
        return
      end
      if skill_id ~= skills.dashIn.id or skill_id ~= skills.dashOut.id then
        if 0 == role.traceLv and not check_magic(npc, magicIds.shiftGear_exHitCd) then
          set_keyframe_enable_by_tag(npc, skill_id, 2, true, true)
        elseif role.traceLv >= 1 and not check_magic(npc, magicIds.shiftGear_exHitCd_trace1) then
          set_keyframe_enable_by_tag(npc, skill_id, 3, true, true)
        end
      end
    end
  end
  
  function magics.shiftGears_magic.onBegin()
    if role.shiftGear_Stage < 3 then
      role.shiftGear_Stage = role.shiftGear_Stage + 1
      if 1 == role.shiftGear_Stage then
        role.spBarStatus(true, 1)
        cast_magic(npc, npc, magicIds.shiftGears1_effect, 0)
        cast_magic(npc, npc, magicIds.shiftGears1_CamEffect, 0)
        if role.traceLv >= 2 then
          cast_magic(npc, npc, 102507021, 0)
        end
      elseif 2 == role.shiftGear_Stage then
        role.spBarStatus(true, 1)
        cast_magic(npc, npc, magicIds.shiftGears2_effect, 0)
        cast_magic(npc, npc, magicIds.shiftGears2_CamEffect, 0)
        if role.traceLv >= 2 then
          cast_magic(npc, npc, 102507022, 0)
        end
      elseif 3 == role.shiftGear_Stage then
        role.spBarStatus(true, 1)
        cast_magic(npc, npc, magicIds.shiftGears3_effect1, 0)
        cast_magic(npc, npc, magicIds.shiftGears3_CamEffect, 0)
        if role.traceLv >= 2 then
          cast_magic(npc, npc, 102507023, 0)
        end
        local atkBtn = role.btns.atk
        local smashDown = role.icons.smashDown
        atkBtn:setIcon(smashDown)
      end
    end
  end
  
  function magics.shiftGears_reset.onBegin()
    role.spBarStatus(false, 3)
    role.shiftGear_Stage = 0
    cast_magic(npc, npc, magicIds.shiftGears4_magic)
    if role.traceLv >= 2 then
      cast_magic(npc, npc, 102507024, 0)
    end
  end
  
  function magics.shiftGears4_magic.onEnd()
    role.destiny1AtkUp_limit = false
    abort_magic_by_id(npc, 102507024)
  end
  
  function Sevika.spBarStatus(Status, num)
    if false == Status then
      qte_lance_num = qte_lance_num_max
      qte_first_delay = true
      role.spBar:decrease(num)
      return
    end
    if true == Status then
      role.spBar:increase(num)
    end
  end
  
  function skActs.exQte.isReady(exQte)
    if not exQte.base.isReady(exQte) then
      return false
    end
    local role = exQte.role
    local roleAct = role.skAct
    if role.exQteActive then
      return true
    else
      return false
    end
  end
  
  skActs.exQte.tarPos = skActs.exQte.base.tarPos
  
  function skActs.exQte.onBegin(exQte)
    abort_magic_by_id(npc, magicIds.shiftGears4_magic)
    set_qte_effect_active(role.npc, "Fx_UI_H1001025_Qte", false, 1)
    role.exQteActive = false
    qte_lance_num_now = 0
    if role.traceLv >= 4 then
      cast_magic(npc, npc, 102507041, 0)
    end
    exQte.base.onBegin(exQte)
  end
  
  function skActs.exQte.onBreak(exQte, tarAct)
    exQte.base.onBreak(exQte, tarAct)
  end
  
  function skActs.exQte.onEnd(exQte)
    exQte.base.onEnd(exQte)
  end
  
  function misLogics.kneeStrikeMis.onHit(kneeStrikeMis, misInst, casterNpc, hitTarget, hitType, skill)
    if not role.skill2_firstHit then
      role.skill2_firstHit = true
      role.kneeStrikeHit = true
    end
    if role.kneeStrikeHit then
      role.linkup_exskill = false
      local sk1Btn = role.btns.sk1
      local spiralPrick = role.icons.spiralPrick
      sk1Btn:setIcon(spiralPrick)
    end
  end
  
  function skActs.kneeStrike.onBreak(kneeStrike, tarAct)
    role.skill2_firstHit = false
    role.kneeStrikeHit = false
    kneeStrike.base.onBreak(kneeStrike, tarAct)
  end
  
  function skActs.kneeStrike.onEnd(kneeStrike)
    role.skill2_firstHit = false
    role.kneeStrikeHit = false
    kneeStrike.base.onEnd(kneeStrike)
  end
  
  function magics.kneeStrike_TransEnable.onBegin()
    skActs.kneeStrike.trans.enable.spiralPrick = "spiralPrick"
  end
  
  function magics.kneeStrike_TransEnable.onEnd()
    skActs.kneeStrike.trans.enable.spiralPrick = nil
  end
  
  function magics.kneeStrike_Derive.onBegin()
    local sk1Btn = role.btns.sk1
    local kneeStrike = role.icons.kneeStrike
    sk1Btn:setIcon(kneeStrike)
  end
  
  function skActs.spiralPrick.onBegin(spiralPrick)
    local sk1Btn = role.btns.sk1
    local kneeStrike = role.icons.kneeStrike
    sk1Btn:setIcon(kneeStrike)
    if link_up then
      role.exSkill_note[1] = "spiralPrick"
    end
    spiralPrick.base.onBegin(spiralPrick)
  end
  
  do
    local function focusCamBegin(Focus, FocusInst, owner, posX, posZ)
      Focus.unit:change_follow_target_new(1, FocusInst, {
        9999,
        
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        1,
        0,
        0.05,
        0,
        0
      })
    end
    
    local function focusCamEnd(Focus, FocusInst, owner, posX, posZ)
      local role = Focus.unit
      change_focus_follow_speed(2)
      role:change_follow_target(4)
      
      local function resetFollow(role)
        change_focus_follow_speed(4)
      end
      
      role:doAfter(resetFollow, 0.5)
    end
    
    misLogics.skill3_1Focus.onBegin = focusCamBegin
    misLogics.skill3_1Focus.onEnd = focusCamEnd
    
    function misLogics.spiralPrickMis.onHit(spiralPrickMis, misInst, casterNpc, hitTarget, hitType, skill)
      role.spiralPrickHit = true
    end
    
    function skActs.spiralPrick.onBreak(spiralPrick, tarAct)
      role.spiralPrickHit = false
      spiralPrick.base.onBreak(spiralPrick, tarAct)
    end
    
    function skActs.spiralPrick.onEnd(spiralPrick)
      role.spiralPrickHit = false
      spiralPrick.base.onEnd(spiralPrick)
    end
    
    function magics.spiralPrick_TransEnable.onBegin()
      skActs.spiralPrick.trans.enable.kickAss = "kickAss"
      role.linkup_exskill = false
      local sk2Btn = role.btns.sk2
      local kickAss = role.icons.kickAss
      sk2Btn:setIcon(kickAss)
    end
    
    function magics.spiralPrick_TransEnable.onEnd()
      skActs.spiralPrick.trans.enable.kickAss = nil
    end
    
    function magics.penetrating_Derive.onBegin()
      local sk2Btn = role.btns.sk2
      local penetrating = role.icons.penetrating
      sk2Btn:setIcon(penetrating)
    end
    
    function skActs.kickAss.onBegin(kickAss)
      local sk2Btn = role.btns.sk2
      local penetrating = role.icons.penetrating
      sk2Btn:setIcon(penetrating)
      if link_up then
        role.exSkill_note[1] = "kickAss"
      end
      kickAss.base.onBegin(kickAss)
    end
  end
  
  function magics.smashDown_Fast.onBegin()
    if 3 == role.shiftGear_Stage then
      local atkBtn = role.btns.atk
      local smashDown = role.icons.smashDown
      atkBtn:setIcon(smashDown)
    end
  end
  
  do
    local function coreSkill_flash()
      local target = role.target
      
      if target then
        local lookPos = get_npc_to_camera_offset_position(npc, -100, 60)
        local pos = get_npc_to_camera_offset_position(npc, -100, 0)
        local flashPos = get_position_offset_position(get_npc_pos(target), pos, 240, 5)
        lookat_position(role.npc, lookPos.x, lookPos.z, true)
        flash_to_pos(role.npc, flashPos.x, flashPos.z)
      else
        local lookPos = get_npc_to_camera_offset_position(npc, -100, 60)
        local pos = get_npc_to_camera_offset_position(npc, -100, 0)
        local pos1 = get_position_offset_position(get_npc_pos(role.npc), pos, 0, 2)
        local flashPos = get_position_offset_position(get_npc_pos(role.npc), pos1, 240, 5)
        lookat_position(role.npc, lookPos.x, lookPos.z, true)
        flash_to_pos(role.npc, flashPos.x, flashPos.z)
      end
    end
    
    magics.smashDown_Flash.onBegin = coreSkill_flash
    
    function skActs.smashDown.start(smashDown, event)
      smashDown.base.start(smashDown, event)
      abort_magic_by_id(npc, magicIds.shiftGears3_CamEffect)
      local smashDown = role.btns.atk
      local atk = role.icons.atk
      smashDown:setIcon(atk)
      role.spBarStatus(false, 3)
      role.shiftGear_Stage = 0
    end
    
    local function focusCamBegin(Focus, FocusInst, owner, posX, posZ)
      Focus.unit:change_follow_target_new(1, FocusInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        1,
        0,
        0.1,
        0,
        0
      })
    end
    
    local function focusCamEnd(Focus, FocusInst, owner, posX, posZ)
      local role = Focus.unit
      change_focus_follow_speed(3)
      role:change_follow_target(4)
      
      local function resetFollow(role)
        change_focus_follow_speed(4)
      end
      
      role:doAfter(resetFollow, 0.5)
    end
    
    misLogics.skill3Focus.onBegin = focusCamBegin
    misLogics.skill3Focus.onEnd = focusCamEnd
    misLogics.linkQte_focus.onBegin = focusCamBegin
    misLogics.linkQte_focus.onEnd = focusCamEnd
  end
  do
    local function focusCamBegin(Focus, FocusInst, owner, posX, posZ)
      Focus.unit:change_follow_target_new(1, FocusInst, {
        9999,
        
        0,
        {
          x = 0,
          y = 1.8,
          z = 0
        },
        1,
        0,
        0.1,
        0,
        0
      })
    end
    
    local function focusCamEnd(Focus, FocusInst, owner, posX, posZ)
      local role = Focus.unit
      change_focus_follow_speed(2.5)
      role:change_follow_target(4)
      
      local function resetFollow(role)
        change_focus_follow_speed(4)
      end
      
      role:doAfter(resetFollow, 0.5)
    end
    
    misLogics.ult_1Focus.onBegin = focusCamBegin
    misLogics.ult_1Focus.onEnd = focusCamEnd
    
    local function focusCamBegin(Focus, FocusInst, owner, posX, posZ)
      Focus.unit:change_follow_target_new(1, FocusInst, {
        9999,
        0,
        {
          x = 0,
          y = 3,
          z = 0
        },
        1,
        0,
        0.1,
        0,
        0
      })
    end
    
    local function focusCamEnd(Focus, FocusInst, owner, posX, posZ)
      local role = Focus.unit
      change_focus_follow_speed(3)
      role:change_follow_target(4)
      
      local function resetFollow(role)
        change_focus_follow_speed(4)
      end
      
      role:doAfter(resetFollow, 0.5)
    end
    
    misLogics.ult_2Focus.onBegin = focusCamBegin
    
    function skills.ult.startFrame(ult)
      local skAct = ult.skAct
      if skAct:isUltFast() then
        return 1
      else
        return 0
      end
    end
    
    function skActs.ult.onBegin(ult)
      if role.destinyLv >= 3 then
        if not check_magic(role.npc, magicIds.shiftGears4_magic) then
          cast_magic(npc, npc, 102508031, 0)
        else
          cast_magic(npc, npc, 102508032, 0)
        end
      end
      ult.base.onBegin(ult)
    end
    
    function skActs.ult.onCastTime(ult)
      if role.destinyLv >= 3 then
        cast_magic(npc, npc, 1025006, 0)
        cast_magic(npc, npc, 1025006, 0)
        cast_magic(npc, npc, 1025006, 0)
      end
      ult.base.onCastTime(ult)
    end
  end
  traces[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    qte_lance_num_now_max = 3
    qte_lance_num_max = 6
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 10257102 == magic_id or 10257103 == magic_id then
        cast_magic(role.npc, role.npc, 102508061, role.spWeapon.lv)
      end
    end
    
    tool.insert(role, "before_damage_target", damageUp)
  end
end

function Sevika.onRampageStart(role, stage)
  role.linkup_exskill = false
  local atkBtn = role.btns.atk
  local spiralPrick = role.icons.spiralPrick
  atkBtn:setIcon(spiralPrick)
  link_up = true
end

function Sevika.onRampageEnd(role, stage)
  link_up = false
  role.linkUp_num = 0
  cast_magic(role.npc, role.npc, 1025006, 0)
  cast_magic(role.npc, role.npc, 1025006, 0)
  cast_magic(role.npc, role.npc, 1025006, 0)
end

function Sevika.before_damage_target(role, target, magic_id)
  if magic_id == shiftGear_exHit_Damg then
    if 2 == role.shiftGear_Stage then
      if role.traceLv >= 1 then
        cast_magic(role.npc, role.npc, shiftGear_exHit_DamgFix1, 0)
        cast_magic(role.npc, role.npc, shiftGear_exHit_DamgFixTrace1, 0)
      else
        cast_magic(role.npc, role.npc, shiftGear_exHit_DamgFix1, 0)
      end
    elseif 3 == role.shiftGear_Stage then
      if role.traceLv >= 1 then
        cast_magic(role.npc, role.npc, shiftGear_exHit_DamgFix2, 0)
        cast_magic(role.npc, role.npc, shiftGear_exHit_DamgFixTrace1, 0)
      else
        cast_magic(role.npc, role.npc, shiftGear_exHit_DamgFix2, 0)
      end
    end
    if role.traceLv >= 1 then
      cast_magic(role.npc, role.npc, 102507011, 0)
    else
      cast_magic(role.npc, role.npc, 10250062, 0)
    end
  end
  if link_up and (10256111 == magic_id or 10255112 == magic_id) and not role.linkup_exskill then
    role:qteLance()
  end
  if 10257102 == magic_id and link_up then
    if 3 == role.linkUp_num then
      local atkBtn = role.btns.atk
      local smashDown = role.icons.smashDown
      atkBtn:setIcon(smashDown)
      return
    end
    if role.exSkill_note[1] == "kickAss" then
      role.linkup_exskill = true
      local sk1Btn = role.btns.sk1
      local spiralPrick = role.icons.spiralPrick
      sk1Btn:setIcon(spiralPrick)
    elseif role.exSkill_note[1] == "spiralPrick" then
      role.linkup_exskill = true
      local sk2Btn = role.btns.sk2
      local kickAss = role.icons.kickAss
      sk2Btn:setIcon(kickAss)
    end
  end
  if role.destinyLv >= 4 and (10257102 == magic_id or 10257103 == magic_id) then
    cast_magic(role.npc, target, 102508041, 0)
  end
end

function Sevika.tag_switch(role)
  local npc = role.npc
  local skills = role.skills
  set_keyframe_enable_by_tag(npc, 0, 2, false, true)
  set_keyframe_enable_by_tag(npc, 0, 3, false, true)
end

local link_up_qte_lance_timer = 0

function Sevika.qteLance(role)
  local qte_lance_pos
  local qte_lance_cd = 2
  if role.destinyLv >= 4 then
    qte_lance_cd = 1.5
  end
  local qte_lance_firstCd = 0.75
  if qte_lance_num >= qte_lance_num_max and qte_first_delay then
    qte_lance_timer = get_npc_time(role.npc) + qte_lance_firstCd
    qte_first_delay = false
  end
  if link_up and link_up_qte_lance_timer < get_npc_time(role.npc) then
    if role.target and not check_npc_die(role.target) then
      qte_lance_pos = get_npc_offset_position(role.target, nil, 0, 0)
    else
      qte_lance_pos = get_npc_offset_position(role.npc, nil, 0, 5)
    end
    qte_lance_pos = qte_lance_pos or get_npc_offset_position(role.npc, nil, 0, 5)
    if role.destinyLv >= 2 then
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254211, 0)
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254212, 0)
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254213, 0)
    else
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254208, 0)
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254209, 0)
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254210, 0)
    end
    role.linkUp_num = role.linkUp_num + 1
    link_up_qte_lance_timer = get_npc_time(role.npc) + qte_lance_cd
  end
  if qte_lance_timer < get_npc_time(role.npc) and not link_up then
    if role.target and not check_npc_die(role.target) then
      qte_lance_pos = get_npc_offset_position(role.target, nil, 0, 0)
    else
      qte_lance_pos = get_npc_offset_position(role.npc, nil, 0, 5)
    end
    qte_lance_pos = qte_lance_pos or get_npc_offset_position(role.npc, nil, 0, 5)
    if role.destinyLv >= 2 then
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254211, 0)
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254212, 0)
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254213, 0)
    else
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254208, 0)
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254209, 0)
      cast_missile3(role.npc, nil, qte_lance_pos.x, qte_lance_pos.z, 10010254210, 0)
    end
    qte_lance_timer = get_npc_time(role.npc) + qte_lance_cd
    if 0 ~= qte_lance_num then
      qte_lance_num = qte_lance_num - 1
      qte_lance_num_now = qte_lance_num_now + 1
      if qte_lance_num_now == qte_lance_num_now_max then
        role.exQteActive = true
        set_qte_effect_active(role.npc, "Fx_UI_H1001025_Qte", true, 1)
      end
    end
  end
end

function Sevika.on_hero_enter_ground_state(role, npc)
  role.base.on_hero_enter_ground_state(role, npc)
  if npc == role.npc and check_magic(role.npc, role.magics.shiftGears4_magic.id) then
    role.destiny1AtkUp = true
    role.destiny1AtkUp_limit = false
  end
end

function Sevika.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if not is_showup and role.destinyLv >= 1 and check_magic(role.npc, role.magics.shiftGears4_magic.id) and not role.destiny1AtkUp_limit then
    local function Addendum()
      local teamMate_showup = get_come_on_hero()
      
      role.destiny1AtkUp_limit = true
      cast_magic(npc, teamMate_showup, 102508011, 0)
    end
    
    role:doAfter(Addendum, 0.1, true)
  end
end

function Sevika.on_frame_background(role)
  role.base.on_frame_background(role)
  if 0 == qte_lance_num then
    return
  else
    role:qteLance()
  end
end

return Sevika
