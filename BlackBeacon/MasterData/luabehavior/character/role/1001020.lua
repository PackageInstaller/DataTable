local roleBase = import("character.base.role_base")
local WuShi = Util.create_child_mt(roleBase)

function WuShi._init(role, npc)
  role.npc = npc
  local misIds = {
    misAtkCameraId = 10010207411,
    misPassiveId_1 = 10010202101,
    misPassiveId_2 = 10010202201,
    misPassiveId_3 = 10010202301,
    misSkill02_2CamId = 10010202221,
    misPassiveHitId = 10010200901,
    misPassiveCamId = 10010200904,
    misPassiveDiscernId = 10010200905,
    misSki3FlashId = 10010203305,
    misSki3Shadow = {
      10010203306,
      10010203307,
      10010203308
    },
    misSki3CamId = {
      10010203411,
      10010203412,
      10010203413
    },
    misPassivePhaseII = {
      10010200942,
      10010200932,
      10010200922
    }
  }
  local magicIds = {
    spAtkOpenTime = 102037,
    spAtkEnd = 102036,
    skill02_2Time = 102042,
    skill02_3FacePos = 102082,
    passiveMagic = {
      102062,
      102063,
      102064,
      102061
    },
    skill03_1FlashTime = 102044
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
  offsetAtk2 = false
  role.sk2 = role.btns.sk2
  role.skill03_2 = role.icons.skill03_2_start
  role.skill03_3 = role.icons.skill03_2_atk
  role.skill03_1 = role.icons.skill03_1
  set_keyframe_enable(role.npc, 10010209203, false, true)
  set_keyframe_enable(role.npc, 10010201109, false, true)
  set_keyframe_enable(role.npc, 10010201209, false, true)
  set_hud_config("1001020_bar", {
    Prefab = "UI_Hud3",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 74, 75)
  local skill03AllowHit = true
  set_keyframe_enable_by_tag(role.npc, 100102033, 9, false, true)
  local skill03Target
  local skill03_2ShadowLv = 0
  local skill03_2Shadow = false
  role.skill03Homestay = false
  role.skill03HomestayTarget = nil
  role.misPassive = {nil, nil}
  local misPassivePos = {
    {nil, nil},
    {nil, nil}
  }
  local effectPos = {nil, nil}
  local misPassiveHitNum = 0
  local misPassiveHitTargetList = {}
  local lookAtPos
  role.passiveTarget = nil
  role.passiveTargetList = {}
  local isHitTarget = false
  local passive2Numbs = 0
  role.spAtkTarget = nil
  role.spAtkPos = nil
  role.missPassive = nil
  role.spAtkEndPos = nil
  local ultFast = true
  local ultLinkTargetList = {}
  local ultLinkGetTarget = true
  
  local function cameraReset()
    change_focus_follow_speed(5)
    role:change_follow_target(4)
  end
  
  local traces_magic = {}
  local traces = role.traces
  traces[1020281] = 1
  traces[1020282] = 2
  traces[1020283] = 3
  traces[1020284] = 4
  traces[1020285] = 5
  role.tracesMagic = {
    Lv1 = {1020286, 1},
    Lv2 = 1020287,
    Lv4 = 1020289
  }
  local destinies = role.destinies
  destinies[1020181] = 1
  destinies[1020182] = 2
  destinies[1020183] = 3
  destinies[1020184] = 4
  destinies[1020185] = 5
  role.destiniesMagic = {
    Lv1 = 1020201,
    Lv2 = 1020202,
    Lv3 = 1020203,
    Lv4 = 1020204,
    Lv5 = 1020205
  }
  local spWeapon = role.spWeapon
  spWeapon.magic = 1020200
  spWeapon.magicAdd = true
  local spWeaponDamageUp = {1020206}
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(role.npc, 100102033, 9, true, true)
    
    local function damageUp(skill03_2_atk)
      if skill03_2ShadowLv >= 1 and skill03_2Shadow then
        cast_magic(role.npc, role.npc, role.tracesMagic.Lv1[1], skill03_2ShadowLv)
        skill03_2Shadow = false
        skill03_2ShadowLv = 0
      end
    end
    
    local function shadowLv()
      skill03_2ShadowLv = skill03_2ShadowLv + 1
    end
    
    tool.insert(misLogics.misSki3Shadow[1], "onBegin", shadowLv)
    tool.insert(misLogics.misSki3Shadow[2], "onBegin", shadowLv)
    tool.insert(misLogics.misSki3Shadow[3], "onBegin", shadowLv)
    tool.insert(skills.skill03_2_start, "onBreak", damageUp)
    tool.insert(skills.skill03_2_start, "onEnd", damageUp)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function defDle(magic, casterNpc, target)
      local magic_list = {
        102064,
        
        102063,
        102062
      }
      for k, v in pairs(magic_list) do
        if v == magic.id then
          cast_magic(role.npc, target, role.tracesMagic.Lv2, k)
        end
      end
    end
    
    local function remove(magic, casterNpc, target)
      role:doAfter(function(role)
        abort_magic_by_id(target, role.tracesMagic.Lv2)
      end, 2.1)
    end
    
    tool.insert(magics.passiveMagic[1], "onBegin", defDle)
    tool.insert(magics.passiveMagic[2], "onBegin", defDle)
    tool.insert(magics.passiveMagic[3], "onBegin", defDle)
    tool.insert(magics.passiveMagic[1], "onEnd", remove)
    tool.insert(magics.passiveMagic[2], "onEnd", remove)
    tool.insert(magics.passiveMagic[3], "onEnd", remove)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
      if 1020113 == magic_id and misPassiveHitNum >= 1 then
        cast_magic(role.npc, role.npc, role.tracesMagic.Lv4, misPassiveHitNum)
      end
    end
    
    local function damageRever(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
      misPassiveHitNum = 0
    end
    
    local function HitNum(misRunesId, misInst, casterNpc, hitTarget, hitType, skill)
      misPassiveHitNum = misPassiveHitNum + 1
    end
    
    tool.insert(misLogics.misPassiveDiscernId, "onHit", HitNum)
    tool.insert(misLogics.misPassiveDiscernId, "onEnd", damageRever)
    tool.insert(role, "before_damage_target", damageUp)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function CritUp(PursuitAtk)
      cast_magic(role.npc, role.npc, role.destiniesMagic.Lv1, 1)
    end
    
    tool.insert(misLogics.misPassiveId_1, "onBegin", CritUp)
    tool.insert(misLogics.misPassiveId_2, "onBegin", CritUp)
    tool.insert(misLogics.misPassiveId_3, "onBegin", CritUp)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1020113 == magic_id or 1020136 == magic_id or 1020137 == magic_id or 1020138 == magic_id or 1020141 == magic_id then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv2, 0)
      end
    end
    
    tool.insert(role, "before_damage", damageUp)
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
      if 1020136 == magic_id or 1020137 == magic_id or 1020138 == magic_id then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv4, 0)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function critBuff(role, npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
      if role.npc ~= npc then
        return
      end
      if is_crit and target ~= role.npc then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv5, 0)
      end
    end
    
    tool.insert(role, "after_damage", critBuff)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable(role.npc, 10010209203, true, true)
    set_keyframe_enable(role.npc, 10010209202, false, true)
    
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1020112 == magic_id and spWeapon.magicAdd then
        cast_magic(role.npc, role.npc, spWeaponDamageUp[1], spWeapon.lv)
        spWeapon.magicAdd = false
      end
    end
    
    local function MagicLogic(PursuitAtk)
      spWeapon.magicAdd = true
    end
    
    local function elementLogic(role, npc, element, skill_id, attacker)
      if 6 == element and role.spWeapon.lv >= 1 and get_come_on_hero() == role.npc then
        cast_magic(role.npc, role.npc, spWeaponDamageUp[1], spWeapon.lv)
      end
    end
    
    tool.insert(skActs.spatk, "onBegin", MagicLogic)
    tool.insert(role, "before_damage", damageFix)
    tool.insert(role, "on_element_aborn_start", elementLogic)
  end
  
  function skills.atk1.startFrame()
    if role.preAct == role.skActs.dashIn then
      return 2
    else
      return 0
    end
  end
  
  function skills.heavy.onCastTime(heavy)
    offsetAtk2 = true
    role:doAfter(function()
      offsetAtk2 = false
    end, 0.35)
    heavy.base.onCastTime(heavy)
  end
  
  function skills.qte.onCastTime(qte)
    offsetAtk2 = true
    role:doAfter(function()
      offsetAtk2 = false
    end, 0.35)
    qte.base.onCastTime(qte)
  end
  
  function skills.counter.onCastTime(counter)
    offsetAtk2 = true
    role:doAfter(function()
      offsetAtk2 = false
    end, 0.35)
    counter.base.onCastTime(counter)
  end
  
  function skActs.atk2.isReady(atk2)
    if not atk2.base.isReady(atk2) then
      return false
    end
    local role = atk2.role
    local roleAct = role.skAct
    if roleAct == atk2.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif offsetAtk2 then
      offsetAtk2 = false
      return true
    else
      return false
    end
  end
  
  skActs.atk3.reset.delay = 0.5
  skills.atk1.onBegin = cameraReset
  skills.heavy.onBegin = cameraReset
  skills.qte.onBegin = cameraReset
  skills.skill02_1.onBegin = cameraReset
  
  function misLogics.misAtkCameraId.onBegin(missile_cfg, missile, owner, pos_x, pos_z)
    role:change_follow_target(1, missile, {
      9999,
      0,
      {
        x = 10,
        y = 0,
        z = 100
      },
      0,
      0,
      0.03
    })
  end
  
  function misLogics.misAtkCameraId.onEnd(missile_cfg, missile, owner, pos_x, pos_z)
    if get_come_on_hero() == role.npc and role.skAct.name == "atk4" then
      change_focus_follow_speed(1.8)
      role:change_follow_target(4)
    end
  end
  
  function skActs.atk4.onBreak(ult)
    role:change_follow_target(4)
    change_focus_follow_speed(6)
  end
  
  function magics.spAtkOpenTime.onBegin(spAtkOpenTime, casterNpc, target)
    if not role.missPassive then
      return
    end
    local atk = role.btns.atk
    local spatk = role.icons.spatk
    atk:setIcon(spatk)
    local targetList = search_npc(role.npc, 4, 20, nil, false, true)
    local targetKind = false
    for k, v in pairs(targetList) do
      if 5 ~= get_role_kind(v) then
        targetKind = true
      end
    end
    if not is_cast_skill_time(role.npc, 100102021) and not targetKind then
      abort_magic_by_id(role.npc, role.magics.spAtkOpenTime.id)
    end
  end
  
  function magics.spAtkOpenTime.onEnd(spAtkOpenTime, casterNpc, target)
    local atk = role.btns.atk
    local atklogic = role.icons.atk
    atk:setIcon(atklogic)
  end
  
  do
    local function customWeight(role, npc)
      if npc == role.spAtkTarget then
        return 8
      else
        return 0
      end
    end
    
    skActs.spatk.search.directional.custom = customWeight
    skActs.spatk.search.noInput.custom = customWeight
    
    function skills.spatk_start.tarPos(spatk_start)
      local role = spatk_start.role
      if role.target and not check_npc_die(role.target) then
        role.spAtkPos = get_npc_offset_position(role.target, get_npc_pos(role.npc), 180, 1.5)
      else
        role.spAtkPos = get_npc_offset_position(role.npc, nil, 0, 5.5)
      end
      return role.spAtkPos
    end
    
    local function check_move_scale(skill)
      local animName = skill.animName
      local dist = 0
      local k = 0
      if role.spAtkTarget then
        dist = get_npc_distance(role.npc, 1, role.spAtkTarget, false)
      elseif role.target then
        dist = get_npc_distance(role.npc, 1, role.target, false)
      end
      k = dist / 6
      if k > 0 and k < 1.2 then
        role:set_move_scale(animName, k)
      end
      if role.spAtkTarget and check_npc_distance(role.npc, role.spAtkTarget, 10, true) then
        lookat_npc(role.npc, role.spAtkTarget, 1)
        role.spAtkTarget = nil
      end
    end
    
    function skills.spatk_start.onBegin(spatk_start)
      abort_magic_by_id(role.npc, role.magics.spAtkOpenTime.id)
      check_move_scale(spatk_start)
    end
    
    function skills.linkQte.onBegin(linkQte)
      check_move_scale(linkQte)
      remove_missile_by_id(10010202101, role.npc)
      cast_missile3(role.npc, nil, nil, nil, 10010202101, 0, nil, nil)
    end
    
    function skills.spatk_end.tarPos(spatk_end)
      local disMoveMin = 1
      local disMoveFix = 0
      local angel = get_target_angel(role.npc, role.target, true)
      if angel >= 0 then
        disMoveFix = get_npc_distance(role.npc, 1, role.target, false)
      end
      if role.missPassive then
        if not (not role.target or npc_is_destroy(role.target)) or role.spAtkTarget and not npc_is_destroy(role.spAtkTarget) then
          role.spAtkEndPos = get_position_offset_position(get_npc_pos(role.target), get_npc_pos(role.missPassive), 180, disMoveMin + disMoveFix)
        else
          role.spAtkEndPos = get_npc_offset_position(role.npc, nil, 0, disMoveMin + disMoveFix)
        end
        lookat_position(role.npc, role.spAtkEndPos.x, role.spAtkEndPos.z, false)
      else
        role.spAtkEndPos = get_npc_offset_position(role.npc, nil, 0, disMoveMin + disMoveFix)
        lookat_position(role.npc, role.spAtkEndPos.x, role.spAtkEndPos.z, false)
      end
      return role.spAtkEndPos, true
    end
    
    function skills.spatk_end.onEnd(spatk)
      role.spAtkPos = nil
    end
    
    function magics.spAtkEnd.onBegin(spAtkEnd, casterNpc, target)
      abort_magic_by_id(role.npc, 102038)
      skActs.spatk.trans.enable.skill02_2 = "skill02_2"
      skActs.spatk.trans.enable.dashOut = "dashOut"
      skActs.spatk.trans.enable.dashIn = "dashIn"
    end
    
    function magics.spAtkEnd.onEnd(spAtkEnd, casterNpc, target)
      skActs.spatk.trans.enable.skill02_2 = nil
      skActs.spatk.trans.enable.dashOut = nil
      skActs.spatk.trans.enable.dashIn = nil
    end
  end
  do
    local function dashCameraReset(speed)
      role:change_follow_target(4)
      
      local cameraSpeed = get_focus_follow_speed()
      if cameraSpeed and speed > cameraSpeed then
        change_focus_follow_speed(speed)
      end
    end
    
    function skills.dashIn.onBegin(dashIn)
      dashIn.base.onBegin(dashIn)
      dashCameraReset(10)
    end
    
    function skills.dashOut.onBegin(dashOut)
      dashOut.base.onBegin(dashOut)
      dashCameraReset(10)
      role.spAtkPos = nil
      role.spAtkTarget = dashOut.role.target
      role:doAfter(function()
        if not is_cast_skill_time(role.npc, 100102021) then
          role.spAtkTarget = nil
        end
      end, 1)
    end
  end
  
  function skills.skill02_1.onBegin(skill02_1)
    cameraReset()
    role.spAtkTarget = skill02_1.role.target
    role:doAfter(function()
      role.spAtkTarget = nil
    end, 2)
  end
  
  function misLogics.misPassiveId_1.onBegin(missile_cfg, missile, owner, pos_x, pos_z)
    local sk1 = role.btns.sk1
    local skill02_2 = role.icons.skill02_3
    role.misPassive[1] = missile
    sk1:setIcon(skill02_2)
    role.missPassive = missile
    set_keyframe_enable(role.npc, 10010201109, true, true)
    set_keyframe_enable(role.npc, 10010201209, true, true)
  end
  
  function misLogics.misPassiveId_1.onEnd(missile_cfg, missile, owner, pos_x, pos_z)
    local sk1 = role.btns.sk1
    local skill02_1 = role.icons.skill02_1
    role.misPassive[1] = nil
    role.missPassive = nil
    sk1:setIcon(skill02_1)
    set_keyframe_enable(role.npc, 10010201109, false, true)
    set_keyframe_enable(role.npc, 10010201209, false, true)
  end
  
  function magics.skill02_2Time.onBegin(skill02_2Time, casterNpc, target)
    local sk1 = role.btns.sk1
    local skill02_2
    if role.misPassive[1] then
      skill02_2 = role.icons.skill02_2
      sk1:setIcon(skill02_2)
    end
  end
  
  function magics.skill02_2Time.onEnd(skill02_2Time, casterNpc, target)
    local sk1 = role.btns.sk1
    local skill02_2
    if role.misPassive[1] then
      skill02_2 = role.icons.skill02_3
    else
      skill02_2 = role.icons.skill02_1
    end
    sk1:setIcon(skill02_2)
  end
  
  function skActs.skill02_2.tarPos()
  end
  
  skills.skill02_2.Camera = nil
  skills.skill02_2.CameraMoveMax = nil
  skills.skill02_2.CameraMoveStaty = false
  do
    local function skill02_2Camera()
      if skills.skill02_2.Camera then
        misLogics.misSkill02_2CamId.isKeepTime = get_npc_time(role.npc)
        
        if misLogics.misSkill02_2CamId.isKeepTime - misLogics.misSkill02_2CamId.isBornTime >= 0.6 then
          change_missile_move_params(skills.skill02_2.Camera, 0, 0)
        end
      end
    end
    
    skills.skill02_2.tick = skill02_2Camera
    skills.skill02_3.tick = skill02_2Camera
    
    function skills.skill02_2.onBegin(skill02_2)
      role:change_follow_target(4)
      change_focus_follow_speed(10)
      
      local function camera_stop(role)
        if role.target then
          role:keep_focus_pos_by_clear_target()
        end
      end
      
      local function camera_move(role)
        role:change_follow_target(4)
      end
      
      role:doAfter(camera_stop, 0.1)
    end
    
    function skills.skill02_3.onBegin(skill02_2)
      if not role.target then
        lookat_npc(role.npc, role.misPassive[1], 1)
      end
      skills.skill02_3.startPos = get_npc_pos(role.npc)
    end
    
    local function passiveHit(role)
      if role.misPassive[1] and role.misPassive[2] then
        local misPos1 = get_missile_pos(role.misPassive[1])
        local misPos2 = get_missile_pos(role.misPassive[2])
        local param0 = {
          npc = role.npc,
          target = nil,
          posx = misPos1.x,
          posz = misPos1.z,
          missile_id = 10010200905,
          missile_level = 1,
          lookat_posx = misPos1.x,
          lookat_posz = misPos1.z,
          lookat_posy = 1,
          posy = nil,
          born_posx = (misPos1.x + misPos2.x) / 2,
          born_posz = (misPos1.z + misPos2.z) / 2,
          born_posy = misPos1.y
        }
        local param1 = {
          npc = role.npc,
          target = nil,
          posx = misPos1.x,
          posz = misPos1.z,
          missile_id = 10010200901,
          missile_level = get_skill_lv(role.npc, 100102009) or 0,
          lookat_posx = misPos1.x,
          lookat_posz = misPos1.z,
          lookat_posy = 1,
          posy = nil,
          born_posx = (misPos1.x + misPos2.x) / 2,
          born_posz = (misPos1.z + misPos2.z) / 2,
          born_posy = misPos1.y
        }
        local param2 = {
          npc = role.npc,
          target = nil,
          posx = misPos1.x,
          posz = misPos1.z,
          missile_id = 10010200902,
          missile_level = 1,
          lookat_posx = misPos1.x,
          lookat_posz = misPos1.z,
          lookat_posy = 1,
          posy = nil,
          born_posx = (misPos1.x + misPos2.x) / 2,
          born_posz = (misPos1.z + misPos2.z) / 2,
          born_posy = misPos1.y
        }
        cast_missile2(param0)
        cast_missile2(param1)
        cast_missile2(param2)
      end
    end
    
    local function passiveHit2(role)
      if role.misPassive[1] and role.misPassive[2] then
        local misPos1 = get_missile_pos(role.misPassive[1])
        local misPos2 = get_missile_pos(role.misPassive[2])
        local param3 = {
          npc = role.npc,
          target = nil,
          posx = misPos1.x,
          posz = misPos1.z,
          missile_id = 10010200906,
          missile_level = 1,
          lookat_posx = misPos1.x,
          lookat_posz = misPos1.z,
          lookat_posy = 1,
          posy = nil,
          born_posx = (misPos1.x + misPos2.x) / 2,
          born_posz = (misPos1.z + misPos2.z) / 2,
          born_posy = misPos1.y
        }
        cast_missile2(param3)
      end
    end
    
    misLogics.misPassiveCamId.isBorn = false
    
    function misLogics.misPassiveCamId.onBegin(missile_cfg, missile, owner, pos_x, pos_z)
      misLogics.misPassiveCamId.isBorn = true
      role:change_follow_target(1, missile, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.04,
        0,
        1
      })
    end
    
    function misLogics.misPassiveCamId.onEnd(missile_cfg, missile, owner, pos_x, pos_z)
      misLogics.misPassiveCamId.isBorn = false
      if role.skAct.name == "skill02_2" or role.skAct.name == "skill02_3" then
        change_focus_follow_speed(1.8)
        role:change_follow_target(4)
      end
    end
    
    misLogics.misSkill02_2CamId.isBornTime = 0
    misLogics.misSkill02_2CamId.isKeepTime = 0
    
    function misLogics.misSkill02_2CamId.onBegin(missile_cfg, missile, owner, pos_x, pos_z)
      skills.skill02_2.Camera = missile
      misLogics.misSkill02_2CamId.isBornTime = get_npc_time(role.npc)
      skills.skill02_2.CameraMoveMax = get_npc_distance(role.npc, 1, role.target, false)
      if skills.skill02_2.CameraMoveMax then
        skills.skill02_2.CameraMoveStaty = 1
        role:change_follow_target(1, missile, {
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
    
    function misLogics.misSkill02_2CamId.onEnd(missile_cfg, missile, owner, pos_x, pos_z)
      skills.skill02_2.Camera = nil
      if "skill02_2" == role.skAct.name and not misLogics.misPassiveCamId.isBorn then
        change_focus_follow_speed(1.8)
        role:change_follow_target(4)
      end
    end
    
    local function skill02_2CameraReset()
      role:change_follow_target(4)
      change_focus_follow_speed(6)
    end
    
    skills.skill02_2.onEnd = skill02_2CameraReset
    skills.skill02_2.onBreak = skill02_2CameraReset
    skills.skill02_3.onEnd = skill02_2CameraReset
    skills.skill02_3.onBreak = skill02_2CameraReset
    
    function magics.skill02_3FacePos.onBegin(magic, casterNpc, target)
      local pos = get_npc_offset_position(role.npc, nil, 180, 1)
      abort_skill(role.npc, 1)
      lookat_position(role.npc, pos.x, pos.z, true)
    end
    
    local function misPassiveId_2OnBegin(missile_cfg, missile, owner, pos_x, pos_z)
      role.misPassive[2] = missile
      role:doAfter(passiveHit, 0.32)
      role:doAfter(passiveHit2, 0.1)
      role:doAfter(function()
        cast_magic(role.npc, role.npc, 102030, 1)
        if role.target then
          cast_missile(role.npc, role.target, nil, nil, 10010200904, 0)
          cast_magic(role.npc, role.npc, 102028, 1)
        end
      end, 0.38)
      role:doAfter(function()
        if role.misPassive[1] then
          remove_missile(role.misPassive[1])
        end
        remove_missile(role.misPassive[2])
      end, 0.5)
    end
    
    misLogics.misPassiveId_2.onBegin = misPassiveId_2OnBegin
    misLogics.misPassiveId_3.onBegin = misPassiveId_2OnBegin
    
    function misLogics.misPassiveDiscernId.onBegin(misPassiveDiscernId, misInst, owner, posX, posZ)
      for k, v in pairs(role.passiveTargetList) do
        abort_magic_by_id(v, magicIds.passiveMagic[1])
        abort_magic_by_id(v, magicIds.passiveMagic[2])
        abort_magic_by_id(v, magicIds.passiveMagic[3])
      end
      role.passiveTargetList = {}
    end
    
    function misLogics.misPassiveDiscernId.onHit(misPassiveDiscernId, misInst, casterNpc, hitTarget, hitType, skill)
      table.insert(role.passiveTargetList, hitTarget)
      if hitTarget == role.passiveTarget then
        isHitTarget = true
      end
    end
    
    function misLogics.misPassiveDiscernId.onEnd(misPassiveDiscernId, misInst, owner, posX, posZ)
      if role.passiveTargetList[1] and role.passiveTarget then
        role.passiveTargetList[1] = role.passiveTarget
        cast_magic(role.npc, role.passiveTarget, magicIds.passiveMagic[1], 1)
        isHitTarget = false
      elseif role.passiveTargetList[1] then
        for k, v in ipairs(role.passiveTargetList) do
          if k >= 4 then
            table.remove(role.passiveTargetList, k)
          else
            passive2Numbs = k
          end
        end
        if 1 == passive2Numbs then
          cast_magic(role.npc, role.passiveTargetList[1], magicIds.passiveMagic[1], 1)
        elseif 2 == passive2Numbs then
          cast_magic(role.npc, role.passiveTargetList[1], magicIds.passiveMagic[2], 1)
          cast_magic(role.npc, role.passiveTargetList[2], magicIds.passiveMagic[3], 1)
        elseif 3 == passive2Numbs then
          cast_magic(role.npc, role.passiveTargetList[1], magicIds.passiveMagic[3], 1)
          cast_magic(role.npc, role.passiveTargetList[2], magicIds.passiveMagic[3], 1)
          cast_magic(role.npc, role.passiveTargetList[3], magicIds.passiveMagic[3], 1)
        end
      end
    end
    
    function misLogics.misPassiveHitId.onHit(misPassiveHitId, misInst, casterNpc, hitTarget, hitType, skill)
      if check_magic(hitTarget, 102072) then
        abort_magic_by_id(hitTarget, 102072)
      end
    end
    
    local function passiveMagicEndLogic(passiveMagic, casterNpc, target, magicId)
      role.temp_target = nil
      role:doAfter(function()
        if is_cast_skill_time(role.npc, 100102034, 1) then
          if passiveMagic.id == magicIds.passiveMagic[1] then
            cast_missile(role.npc, target, nil, nil, 10010200921, 0, nil, nil)
          elseif passiveMagic.id == magicIds.passiveMagic[2] then
            cast_missile(role.npc, target, nil, nil, 10010200931, 0, nil, nil)
          elseif passiveMagic.id == magicIds.passiveMagic[3] then
            cast_missile(role.npc, target, nil, nil, 10010200941, 0, nil, nil)
          end
        end
      end, 0.1)
    end
    
    magics.passiveMagic[1].onEnd = passiveMagicEndLogic
    magics.passiveMagic[2].onEnd = passiveMagicEndLogic
    magics.passiveMagic[3].onEnd = passiveMagicEndLogic
    
    local function ultLinkTarget(misPassiveDiscernId, misInst, casterNpc, hitTarget, hitType, skill)
      table.insert(ultLinkTargetList, hitTarget)
      ultLinkGetTarget = true
    end
    
    misLogics.misPassivePhaseII[1].onHit = ultLinkTarget
    misLogics.misPassivePhaseII[2].onHit = ultLinkTarget
    misLogics.misPassivePhaseII[3].onHit = ultLinkTarget
    
    local function ultLinkAddMagic(misPassiveDiscernId, misInst, owner, posX, posZ)
      if ultLinkGetTarget and role:isRampage() then
        for k, v in pairs(ultLinkTargetList) do
          if nil == ultLinkTargetList[k + 1] then
            cast_magic(role.npc, v, magicIds.passiveMagic[1], 1)
            ultLinkGetTarget = false
            break
          elseif math.random(0, 1) >= 0.7 then
            cast_magic(role.npc, v, magicIds.passiveMagic[1], 1)
            ultLinkGetTarget = false
            break
          end
        end
      end
    end
    
    misLogics.misPassivePhaseII[1].onEnd = ultLinkAddMagic
    misLogics.misPassivePhaseII[2].onEnd = ultLinkAddMagic
    misLogics.misPassivePhaseII[3].onEnd = ultLinkAddMagic
  end
  
  function skills.skill03_1_start.onBegin(skill03_1_start)
    skill03AllowHit = true
    isHitTarget = false
    skill03_1_start.lockTarget = role.target
  end
  
  function magics.skill03_1FlashTime.onBegin(passivemagic, casterNpc, target)
    local pos_button = {x = nil, z = nil}
    pos_button.x, pos_button.z = get_indicator_pos(20)
    flash_to_pos(role.npc, pos_button.x, pos_button.z)
    cameraReset()
  end
  
  function skills.skill03_1_atk.onBegin(skill03_1_atk)
    skill03_1_atk.base.onBegin(skill03_1_atk)
    if not role.target then
      role:searchTarget(skActs.skill03_1.search)
    end
    local pos
    if role.target and check_npc_distance(role.npc, role.target, 2.5, true) and not check_npc_die(role.target) then
      if role.missPassive then
        pos = get_position_offset_position(get_npc_pos(role.target), get_npc_pos(role.missPassive), 180, 0.5)
      else
        pos = get_npc_offset_position(role.target, get_npc_pos(role.npc), 0, 0.5)
      end
      flash_to_pos(role.npc, pos.x, pos.z)
      lookat_npc(role.npc, role.target, 1)
    end
  end
  
  function skills.skill03_1_atk.onHit(skill03_1_atk, casterNpc, hitTarget, hitType, skill, missile)
    if skill03AllowHit and 5 ~= get_role_kind(hitTarget) then
      skill03AllowHit = false
      if hitTarget == role.passiveTarget then
        return
      end
      if role.passiveTarget then
        abort_magic_by_id(role.passiveTarget, magicIds.passiveMagic[4])
      end
      cast_magic(role.npc, hitTarget, magicIds.passiveMagic[4], 1)
    end
  end
  
  magics.passiveMagic[4].onBegin = function(passivemagic, casterNpc, target)
    role.passiveTarget = target
  end
  magics.passiveMagic[4].onEnd = function(passivemagic, casterNpc, target)
    role.passiveTarget = nil
  end
  do
    local function skill03LogicPassive(skill03_2_atk)
      for k, v in pairs(role.passiveTargetList) do
        abort_magic_by_id(v, 102051)
        
        abort_magic_by_id(v, 102052)
        abort_magic_by_id(v, magicIds.passiveMagic[1])
        abort_magic_by_id(v, magicIds.passiveMagic[2])
        abort_magic_by_id(v, magicIds.passiveMagic[3])
        cast_magic(role.npc, v, 102056, 0)
        cast_magic(role.npc, v, 1020134, 0)
      end
      role.passiveTargetList = {}
      active_hud(role.npc, "1001020_bar", "attachpoint", false)
    end
    
    function skills.skill03_2_start.onBegin(skill03_2_start)
      skill03_2ShadowLv = 0
      if role.passiveTargetList[1] and check_npc_distance(role.passiveTargetList[1], role.npc, 10, true) then
        skill03_2_start.role.target = role.passiveTargetList[1]
      end
      local pos
      role.skill03HomestayTarget = search_npc(role.npc, 4, 10, magicIds.passiveMagic[1], false)
      if role.skill03HomestayTarget then
        pos = get_npc_offset_position(role.skill03HomestayTarget, get_npc_pos(role.npc), 0, 0)
      elseif role.target and not check_npc_die(role.target) then
        pos = get_npc_offset_position(role.target, get_npc_pos(role.npc), 0, 0)
      else
        pos = get_position_offset_position(get_npc_pos(role.npc), get_npc_pos(role.npc), 0, 5)
      end
      role:doAfter(function()
        if role.skAct.name == "skill03_2_start" then
          cameraReset()
          role.skill03Homestay = true
          flash_to_pos(role.npc, pos.x, pos.z)
          active_hud(role.npc, "1001020_bar", "attachpoint", true, "影随")
          cast_magic(role.npc, role.npc, 102054, 1)
        end
      end, 0.2)
      if role:isRampage() then
        cast_magic(role.npc, role.npc, 1020096, 1)
        cast_magic(role.npc, role.npc, 1020095, 1)
      end
    end
    
    function skActs.skill03_2_start.onBreak(skill03_2_start, tarAct)
      skill03_2_start.base.onBreak(skill03_2_start, tarAct)
      role.skill03Homestay = false
      abort_magic_by_id(role.npc, 102046)
      abort_magic_by_id(role.npc, Const.LOCK_MASK)
      skill03LogicPassive()
    end
    
    function misLogics.misSki3FlashId.onHit(misSki3FlashId, misInst, casterNpc, hitTarget, hitType, skill)
      if role.target then
        cast_magic(role.npc, role.target, 102051, 0)
        cast_magic(role.npc, role.target, 102052, 0)
      end
      if role.passiveTarget then
        if hitTarget == role.passiveTarget then
          skill03_2Shadow = true
        end
      else
        for k, v in pairs(role.passiveTargetList) do
          if hitTarget == v then
            skill03_2Shadow = true
            break
          end
        end
      end
    end
    
    function skills.skill03_2_atk.onBegin(skill03_2_atk)
      local role = skill03_2_atk.role
      role.skill03Homestay = false
      abort_magic_by_id(role.npc, Const.LOCK_MASK)
      cameraReset()
      skill03LogicPassive()
      for k, v in pairs(ultLinkTargetList) do
        if check_magic(v, magicIds.passiveMagic[1]) then
          abort_magic_by_id(v, 102051)
          abort_magic_by_id(v, 102052)
          abort_magic_by_id(v, magicIds.passiveMagic[1])
          cast_magic(role.npc, v, 102056, 0)
          cast_magic(role.npc, v, 1020134, 0)
        end
      end
      ultLinkTargetList = {}
      local pos_button = {x = nil, z = nil}
      local posFlash
      local posSelf = get_npc_pos(role.npc)
      
      local function posTarget()
        if role.target then
          return get_npc_pos(role.target)
        else
          return posSelf
        end
      end
      
      pos_button.x, pos_button.z = get_indicator_pos(20)
      if pos_button.x and pos_button.z then
        lookat_position(role.npc, pos_button.x, pos_button.z, 1)
        posFlash = get_npc_offset_position(role.npc, nil, 180, 3)
      else
        posFlash = get_npc_offset_position(role.npc, nil, 180, 3)
        if role.target then
          lookat_npc(role.npc, role.target, 1)
        end
      end
      role:doAfter(function()
        abort_magic_by_id(role.npc, 102046)
      end, 0.05)
      flash_to_pos(role.npc, posFlash.x, posFlash.z)
      if role.target then
        lookat_npc(role.npc, role.target, 1)
      end
      effectPos[1] = get_npc_pos(role.npc)
      role:doAfter(function()
        effectPos[2] = get_npc_pos(role.npc)
        local param0 = {
          npc = role.npc,
          target = nil,
          posx = effectPos[2].x,
          posz = effectPos[2].z,
          missile_id = 10010200951,
          missile_level = 1,
          lookat_posx = effectPos[2].x,
          lookat_posz = effectPos[2].z,
          lookat_posy = 1,
          posy = nil,
          born_posx = (effectPos[2].x + effectPos[1].x) / 2,
          born_posz = (effectPos[2].z + effectPos[1].z) / 2,
          born_posy = effectPos[2].y
        }
        cast_missile2(param0)
      end, 0.5)
    end
    
    misLogics.misSki3CamId[1].onBegin = function(misSki3CamId, missile, owner, pos_x, pos_z)
      role:change_follow_target(1, missile, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.07,
        0,
        1
      })
    end
    misLogics.misSki3CamId[2].onBegin = function(misSki3CamId, missile, owner, pos_x, pos_z)
      if role.target then
        role:change_follow_target(1, role.target, {
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
    misLogics.misSki3CamId[3].onBegin = function(misSki3CamId, missile, owner, pos_x, pos_z)
      role:change_follow_target(1, missile, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        0.07,
        0,
        1
      })
      role:doAfter(function()
        if not is_cast_skill_time(role.npc) and get_come_on_hero() == role.npc then
          change_focus_follow_speed(1.2)
          role:change_follow_target(4)
        end
      end, 0.6)
    end
    misLogics.misSki3CamId[3].onEnd = function(misSki3CamId, missile, owner, pos_x, pos_z)
      if get_come_on_hero() == role.npc then
        change_focus_follow_speed(4)
        role:change_follow_target(4)
      end
    end
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      ultFast = true
      set_keyframe_enable(role.npc, 10010208134, false, true)
      set_keyframe_enable(role.npc, 10010208135, false, true)
      return 0
    else
      set_keyframe_enable(role.npc, 10010208135, true, true)
      ultFast = false
      return 0
    end
  end
  
  function skills.ult.onBegin(ult)
    if not ultFast then
      set_keyframe_enable(role.npc, 10010208134, true, true)
    end
    if role.target and check_npc_distance(role.npc, role.target, 8, true) then
      local pos = get_npc_pos(role.target)
      flash_to_pos(role.npc, pos.x, pos.z)
      cast_magic(role.npc, role.target, 102051, 1)
    end
    local pos_my = get_npc_to_camera_offset_position(role.npc, 95, 1)
    lookat_position(role.npc, pos_my.x, pos_my.z, true)
  end
end

function WuShi.on_element_aborn_start(npc, element, skill_id, attacker)
  if 6 == element and source.spWeapon.lv >= 1 and get_come_on_hero() == source.npc then
    cast_magic(source.npc, source.npc, 1020200, spWeapon.lv)
  end
end

function WuShi.on_keyframe_action(role, kfId, npcTag, comnTag)
  if "skill2_2Camera" == npcTag and role.target then
    local posSet = role.misPassive[1] and get_missile_pos(role.misPassive[1])
    cast_missile3(role.npc, role.misPassive[1], posSet.x, posSet.z, role.misLogics.misSkill02_2CamId.id, 0)
  end
end

function WuShi.onRampageStart(role, stage)
end

function WuShi.onRampageEnd(role, stage)
  role.skills.spatk_start:restoreCost()
end

function WuShi.on_npc_hp_zero(role, npc)
  role.base.on_npc_hp_zero(role, npc)
  if check_magic(npc, 102062) then
    set_search_npc_limit(2)
    set_search_npc_limit(3)
    set_search_npc_limit(4)
    local targetList = search_npc(npc, 2, 20, nil, true, true)
    local targetHpList = {}
    local nextTarget
    if targetList[1] then
      for k, v in pairs(targetList) do
        local list = {
          v,
          get_npc_attr(v, 1)
        }
        table.insert(targetHpList, list)
      end
      table.sort(targetHpList, function(a, b)
        return a[2] > b[2]
      end)
      if targetHpList[1][1] then
        nextTarget = targetHpList[1][1]
        cast_magic(role.npc, nextTarget, 102062, 1)
      end
    end
  end
end

local buttonName_skill3_1 = "skill03_1"
local buttonName_skill03_2_start = "skill03_2_start"
local buttonName_skill03_2_atk = "skill03_2_atk"

function WuShi.on_frame(role)
  role.base.on_frame(role)
  if role.skill03HomestayTarget and role.skill03Homestay then
    local pos = get_npc_offset_position(role.skill03HomestayTarget, get_npc_pos(role.npc), 0, 0)
    if pos then
      flash_to_pos(role.npc, pos.x, pos.z)
    end
    cast_magic(role.npc, role.npc, 102053, 1)
  end
  local button = role.btns.sk2
  if npc_is_destroy(role.temp_target) or not check_magic(role.temp_target, 102062) and not check_magic(role.temp_target, 102063) and not check_magic(role.temp_target, 102064) then
    set_search_npc_limit(nil, nil, 102062)
    set_search_npc_limit(nil, nil, 102063)
    set_search_npc_limit(nil, nil, 102064)
    role.temp_target = search_npc(role.npc, 4, 20, nil, true, false)
  end
  if not npc_is_destroy(role.temp_target) then
    if role.skill03Homestay then
      if button.icon.name ~= buttonName_skill03_2_atk then
        role.btns.sk2:setIcon(role.skill03_3)
      end
    elseif button.icon.name ~= buttonName_skill03_2_start then
      role.btns.sk2:setIcon(role.skill03_2)
    end
  elseif button.icon.name ~= buttonName_skill3_1 and not role.skill03Homestay then
    role.btns.sk2:setIcon(role.skill03_1)
  end
end

return WuShi
