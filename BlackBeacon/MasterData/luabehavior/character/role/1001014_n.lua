local roleBase = import("character.base.role_base")
local Logos = Util.create_child_mt(roleBase)
local passive_state = false

function Logos._init(role, npc)
  role.npc = npc
  local misIds = {
    misSkill04Camera = 10010145242,
    misPassvieRunes = {10010145257, 10010147402},
    misCounterAtk = 10010141301,
    misEnergyAdd = {
      10010140401,
      10010140701,
      10010143101,
      10010143201,
      10010146501,
      10010146502,
      10010146503,
      10010146504,
      10010146505,
      10010146506,
      10010143301,
      10010148401
    },
    misRunesId_1 = 10010145211,
    misRunesId_2 = 10010145212,
    misRunesId_3 = 10010145213,
    misUltEffect = 10010145281
  }
  local magicIds = {
    passiveStateMagic = 101436,
    Runes = 1014129,
    passiveSkillLoopTime = 101437,
    dashAtkLoopTime = 101430,
    counterStates = 1999126,
    skill03ProDerive = 101407,
    skill04_2End = {101465, 101464}
  }
  local spBarIsAdd = {
    [10010140401] = true,
    [10010140701] = true,
    [10010143101] = true,
    [10010143201] = true,
    [10010143301] = true,
    [10010148401] = true,
    [10010146501] = true,
    [10010146502] = true,
    [10010146503] = true,
    [10010146504] = true,
    [10010146505] = true,
    [10010146506] = true
  }
  local spBarUp = 1
  roleBase._init(role, misIds, magicIds)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local destinies = role.destinies
  local traces = role.traces
  role.team_hero_list = {
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22),
    get_come_on_hero()
  }
  set_hud_config("1001014_bar", {
    Prefab = "UI_Hud3",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 74, 75)
  role.passiveRunes = false
  role.passiveRunesTime = 0
  role.passiveRunesTime_fix = 10
  role.passiveRunesAtkTime = 0
  role.passiveRunesAtkNumb = 1
  role.now_time = 0
  role.passiveRunesMissile = {
    10010145211,
    10010145212,
    10010145213
  }
  role.passiveRunesHit = true
  role.passiveRunesMagic = {1014222, 1014223}
  role.passiveRunesMagicLv = {1, 1}
  local skill02_2_derived = true
  local skill02_2_start_pos
  local skill02Change = false
  local skill02ChangeTime = 0
  local skill03_loop_time = 0
  local skill03_missile_id = {
    [1] = {
      10010146501,
      10010146502,
      10010146503
    },
    [2] = {
      10010146504,
      10010146505,
      10010146506
    },
    [3] = {
      10010146511,
      10010146512,
      10010146513
    }
  }
  local skill03Pro = false
  role.isCastTimeSkill03 = false
  role.skill04_missile_id = {
    posMissile = {10010145241, 10010145242},
    atkMissile = {
      10010145251,
      10010145252,
      10010145253,
      10010145254,
      10010145255,
      10010145256,
      10010145257,
      10010145261,
      10010145262
    }
  }
  role.skill04Qte_missile_id = {
    posMissile = {10010145241, 10010145242},
    atkMissile = {
      10010144751,
      10010144752,
      10010144753,
      10010144754,
      10010144755,
      10010144756,
      10010144757,
      10010144761,
      10010144762
    }
  }
  local traces = role.traces
  traces[1014281] = 1
  traces[1014282] = 2
  traces[1014283] = 3
  traces[1014284] = 4
  traces[1014285] = 5
  tracesMagic = {Lv2 = 1014222, Lv4 = 15}
  local destinies = role.destinies
  destinies[1014181] = 1
  destinies[1014182] = 2
  destinies[1014183] = 3
  destinies[1014184] = 4
  destinies[1014185] = 5
  role.destiniesMagic = {
    Lv1 = 1014287,
    Lv2 = 1014201,
    Lv3 = 2,
    Lv4 = 2,
    Lv5 = {true, 1014205}
  }
  local spWeapon = role.spWeapon
  spWeapon.magic = 1014200
  spWeapon.magicId = {1014231, 1014232}
  spWeapon.isMagic = true
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    spBarUp = 2
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function HpAdd(misRunesId, misInst, casterNpc, hitTarget, hitType, skill)
      if role.passiveRunesHit then
        role.passiveRunesHit = false
        
        cast_magic(role.npc, get_come_on_hero(), role.passiveRunesMagic[1], role.passiveRunesMagicLv[1])
      end
    end
    
    tool.insert(misLogics.misRunesId_1, "onHit", HpAdd)
    tool.insert(misLogics.misRunesId_2, "onHit", HpAdd)
    tool.insert(misLogics.misRunesId_3, "onHit", HpAdd)
  end
  traces[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.passiveRunesTime_fix = tracesMagic.Lv4
  end
  traces[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1014109 == magic_id or 1014112 == magic_id or 1014113 == magic_id then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv1, 0)
      end
    end
    
    tool.insert(role, "before_damage", damageFix)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp(misRunesId, misInst, casterNpc, hitTarget, hitType, skill)
      cast_magic(role.npc, hitTarget, role.destiniesMagic.Lv2, 0)
    end
    
    tool.insert(misLogics.misRunesId_1, "onHit", damageUp)
    tool.insert(misLogics.misRunesId_2, "onHit", damageUp)
    tool.insert(misLogics.misRunesId_3, "onHit", damageUp)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.passiveRunesMagicLv[2] = role.destiniesMagic.Lv3
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.passiveRunesMagicLv[1] = role.destiniesMagic.Lv4
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role:add_shared_reborn_chance(role.destiniesMagic.Lv5[2])
  end
  
  function role.spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function isMagicChange(misRunesId, misInst, casterNpc, hitTarget, hitType, skill)
      spWeapon.isMagic = true
    end
    
    local function HpAdd(misRunesId, misInst, casterNpc, hitTarget, hitType, skill)
      if spWeapon.isMagic then
        spWeapon.isMagic = false
        role.tool:castMagicToTeam(spWeapon.magicId[1], 1, role.npc)
      end
      cast_missile3(casterNpc, hitTarget, nil, nil, 10010145221, 0)
    end
    
    tool.insert(misLogics.misRunesId_1, "onBegin", isMagicChange)
    tool.insert(misLogics.misRunesId_2, "onBegin", isMagicChange)
    tool.insert(misLogics.misRunesId_3, "onBegin", isMagicChange)
    tool.insert(misLogics.misRunesId_1, "onHit", HpAdd)
    tool.insert(misLogics.misRunesId_2, "onHit", HpAdd)
    tool.insert(misLogics.misRunesId_3, "onHit", HpAdd)
  end
  
  function skActs.atk3.isReady(atk3)
    if not atk3.base.isReady(atk3) then
      return false
    end
    local role = atk3.role
    local roleAct = role.skAct
    if roleAct == atk3.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif skill02Change then
      return true
    else
      return false
    end
  end
  
  role.skills.atk4.pos = nil
  
  function skills.atk4.tarPos(atk3)
    if role.target then
      role.skills.atk4.pos = get_position_offset_position(get_npc_pos(role.target), get_npc_pos(role.npc), 180, 2)
    else
      role.skills.atk4.pos = get_npc_offset_position(role.npc, nil, 0, 3)
    end
    return role.skills.atk4.pos, true
  end
  
  misLogics.misEnergyAdd[1].onHit = function(misEnergyAdd, misInst, casterNpc, hitTarget, hitType, skill)
    passiveStatus(true)
    spBarStatus(true, misEnergyAdd)
  end
  
  function misLogics.misCounterAtk.onHit(misCounterAtk, misInst, casterNpc, hitTarget, hitType, skill)
    passiveStatus(true)
  end
  
  function magics.dashAtkLoopTime.onBegin(dashAtkLoopTime, casterNpc, target)
    local atk = role.btns.atk
    local dashAtk = role.icons.dashAtk
    atk:setIcon(dashAtk)
  end
  
  function magics.dashAtkLoopTime.onEnd(dashAtkLoopTime, casterNpc, target)
    local atk = role.btns.atk
    local dashAtk = role.icons.atk
    atk:setIcon(dashAtk)
  end
  
  function magics.counterStates.onBegin(dashAtkLoopTime, casterNpc, target)
    if check_magic(role.npc, 101437) then
      return
    end
    local atk = role.btns.atk
    local dashAtk = role.icons.atk
    atk:setIcon(dashAtk)
  end
  
  local function dashCameraReset(speed)
    role:change_follow_target(4)
    local cameraSpeed = get_focus_follow_speed()
    if cameraSpeed and speed > cameraSpeed then
      change_focus_follow_speed(speed)
    end
  end
  
  function skills.dashIn.onBegin(dashIn)
    dashCameraReset(10)
    dashIn.base.onBegin(dashIn)
    skActs.dashIn.trans.enable.dashAtk = nil
    if check_magic(role.npc, 1999126) or check_magic(role.npc, 101437) then
      return
    end
    cast_magic(role.npc, role.npc, 101430, 1)
    role:doAfter(function()
      skActs.dashIn.trans.enable.dashAtk = "dashAtk"
      dashIn.role.inputor:pop(Const.INPUTOR_POP_TYPE.TRY)
    end, 0.3)
  end
  
  function skills.dashOut.onBegin(dashOut)
    dashCameraReset(10)
    dashOut.base.onBegin(dashOut)
    skActs.dashOut.trans.enable.dashAtk = nil
    if check_magic(role.npc, 1999126) or check_magic(role.npc, 101437) then
      return
    end
    cast_magic(role.npc, role.npc, 101430, 1)
    role:doAfter(function()
      skActs.dashOut.trans.enable.dashAtk = "dashAtk"
      dashOut.role.inputor:pop(Const.INPUTOR_POP_TYPE.TRY)
    end, 0.4)
  end
  
  function passive_logic(state)
    passive_state = state
    if passive_state then
      local sk1 = role.btns.sk1
      local sk2 = role.btns.sk2
      local skill02 = role.icons.skill02Pro
      local skill03 = role.icons.skill03Pro
      if not role:isRampage() then
        sk1:setIcon(skill02)
      end
      sk2:setIcon(skill03)
    elseif not passive_state then
      local sk1 = role.btns.sk1
      local sk2 = role.btns.sk2
      local skill02 = role.icons.skill02
      local skill03 = role.icons.skill03
      if not role:isRampage() then
        sk1:setIcon(skill02)
      end
      sk2:setIcon(skill03)
    end
  end
  
  function magics.passiveStateMagic.onBegin(passiveStateMagic, casterNpc, target)
    passive_logic(true)
  end
  
  function magics.passiveStateMagic.onEnd(passiveStateMagic, casterNpc, target)
    passive_logic(false)
  end
  
  function passiveStatus(Status)
    if Status then
      cast_magic(role.npc, role.npc, magicIds.passiveStateMagic, 0)
    else
      abort_magic_by_id(role.npc, magicIds.passiveStateMagic)
    end
  end
  
  function spBarStatus(Status, missile, num)
    num = num or 1
    if false == Status then
      role.spBar:decrease(10)
      return
    end
    if spBarIsAdd[missile.id] then
      role.spBar:increase(num)
      spBarIsAdd[missile.id] = false
      
      local function EneryRever()
        spBarIsAdd[missile.id] = true
      end
      
      role:doAfter(EneryRever, 0.15)
    end
    if role.spBar.num >= 5 then
      role.spBar:decrease(10)
      cast_magic(role.npc, role.npc, magicIds.passiveSkillLoopTime, 0)
    end
  end
  
  function magics.passiveSkillLoopTime.onBegin(passiveSkillLoopTime, casterNpc, target)
    local atk = role.btns.atk
    local atkn = role.icons.atk
    local atkPro = role.icons.skill04_1
    atk:setIcon(atkPro)
  end
  
  function magics.passiveSkillLoopTime.onEnd(passiveSkillLoopTime, casterNpc, target)
    local atk = role.btns.atk
    local atkn = role.icons.atk
    local atkPro = role.icons.skill04_1
    atk:setIcon(atkn)
  end
  
  function skills.skill02.tarPos(skill02)
    local role = skill02.role
    local pos
    if role.target and not check_npc_die(role.target) then
      pos = get_npc_offset_position(role.target, get_npc_pos(role.npc), 180, 3)
    else
      pos = get_npc_offset_position(role.npc, nil, 0, 5)
    end
    return pos
  end
  
  function skills.skill02.onCastTime(skill02)
    skill02Change = true
    role:doAfter(function()
      skill02Change = false
    end, 0.5)
    skill02.base.onCastTime(skill02)
  end
  
  misLogics.misEnergyAdd[3].onHit = function(misEnergyAdd, misInst, casterNpc, hitTarget, hitType, skill)
    passiveStatus(true)
    spBarStatus(true, misEnergyAdd)
  end
  misLogics.misEnergyAdd[4].onHit = function(misEnergyAdd, misInst, casterNpc, hitTarget, hitType, skill)
    spBarStatus(true, misEnergyAdd)
  end
  
  function skills.skill02Pro.onBegin(skill02, casterNpc, hitTarget, hitType, skill, missile)
    passiveStatus(false)
  end
  
  function skills.skill02Pro.onCastTime(skill02Pro)
    if role.now_time >= skill02ChangeTime then
      skill02ChangeTime = role.now_time + 2
      skill02Change = true
      role:doAfter(function()
        skill02Change = false
      end, 0.5)
    end
    skill02Pro.base.onCastTime(skill02Pro)
  end
  
  function skills.skill02Pros.startFrame()
    if role.preAct == role.skActs.skill02Pros or role.preAct == role.skActs.linkQte then
      return 4
    else
      return 0
    end
  end
  
  function skActs.skill03.isReady(skill03)
    if not skill03.base.isReady(skill03) then
      return false
    end
    if not skill03.role:isInControl() then
      return false
    end
    return true
  end
  
  function skActs.skill03Pro.isReady(skill03Pro)
    if not skill03Pro.base.isReady(skill03Pro) then
      return false
    end
    if not skill03Pro.role:isInControl() then
      return false
    end
    return true
  end
  
  function skActs.skill03.onBegin(skill03)
    skill03_loop_time = get_npc_time(role.npc) + 0.8
    role.isCastTimeSkill03 = true
    active_hud(role.npc, "1001014_bar", "hud_gd", true, "蓄力")
    cast_magic(role.npc, role.npc, 999974, 1)
    skill03.base.onBegin(skill03)
  end
  
  function skActs.skill03.onBreak(skill03, tarAct)
    role.isCastTimeSkill03 = false
    active_hud(role.npc, "1001014_bar", "hud_gd", false)
    skill03.base.onBreak(skill03, tarAct)
  end
  
  function skills.skill03.onEnd(skill03Pro, casterNpc, hitTarget, hitType, skill, missile)
    on_up_skill_btn(20, true)
    active_hud(role.npc, "1001014_bar", "hud_gd", false)
    role.isCastTimeSkill03 = false
  end
  
  function skills.skill03Pro.onBegin(skill03Pro, casterNpc, hitTarget, hitType, skill, missile)
    skill03Pro = true
  end
  
  misLogics.misEnergyAdd[5].onHit = function(misEnergyAdd, misInst, casterNpc, hitTarget, hitType, skill)
    passiveStatus(true)
    spBarStatus(true, misEnergyAdd, spBarUp)
  end
  misLogics.misEnergyAdd[6].onHit = function(misEnergyAdd, misInst, casterNpc, hitTarget, hitType, skill)
  end
  misLogics.misEnergyAdd[7].onHit = function(misEnergyAdd, misInst, casterNpc, hitTarget, hitType, skill)
    spBarStatus(true, misEnergyAdd, spBarUp)
  end
  misLogics.misEnergyAdd[8].onHit = function(misEnergyAdd, misInst, casterNpc, hitTarget, hitType, skill)
    spBarStatus(true, misEnergyAdd, spBarUp)
  end
  misLogics.misEnergyAdd[9].onHit = function(misEnergyAdd, misInst, casterNpc, hitTarget, hitType, skill)
  end
  misLogics.misEnergyAdd[10].onHit = function(misEnergyAdd, misInst, casterNpc, hitTarget, hitType, skill)
    spBarStatus(true, misEnergyAdd, spBarUp)
  end
  skActs.skill03Atk.preAct = skActs.skill03
  
  function skActs.skill03Atk.tarPos(skill03Atk, event)
    local roleAct = skill03Atk.role.skAct
    if roleAct ~= skill03Atk.preAct then
      skill03_loop_time = get_npc_time(role.npc) + 999
    end
    return skill03Atk.base.tarPos(skill03Atk, event)
  end
  
  function skills.skill03Atk.onBegin(skill03Atk, casterNpc, hitTarget, hitType, skill, missile)
    local now_time = get_npc_time(role.npc)
    if passive_state or skill03Pro then
      cast_missile(role.npc, nil, nil, nil, skill03_missile_id[2][1], 0, nil, nil)
      cast_missile(role.npc, nil, nil, nil, skill03_missile_id[2][2], 0, nil, nil)
      cast_missile(role.npc, nil, nil, nil, skill03_missile_id[2][3], 0, nil, nil)
      cast_missile(role.npc, nil, nil, nil, skill03_missile_id[3][3], 0, nil, nil)
      passiveStatus(false)
      skill03Pro = false
    elseif not passive_state then
      if now_time >= skill03_loop_time then
        cast_missile(role.npc, nil, nil, nil, skill03_missile_id[1][1], 0, nil, nil)
        cast_missile(role.npc, nil, nil, nil, skill03_missile_id[1][2], 0, nil, nil)
        cast_missile(role.npc, nil, nil, nil, skill03_missile_id[1][3], 0, nil, nil)
        cast_missile(role.npc, nil, nil, nil, skill03_missile_id[3][3], 0, nil, nil)
      elseif now_time < skill03_loop_time and now_time >= skill03_loop_time - 0.3 then
        cast_missile(role.npc, nil, nil, nil, skill03_missile_id[1][1], 0, nil, nil)
        cast_missile(role.npc, nil, nil, nil, skill03_missile_id[1][2], 0, nil, nil)
        cast_missile(role.npc, nil, nil, nil, skill03_missile_id[3][2], 0, nil, nil)
      elseif now_time < skill03_loop_time - 0.3 then
        cast_missile(role.npc, nil, nil, nil, skill03_missile_id[1][1], 0, nil, nil)
        cast_missile(role.npc, nil, nil, nil, skill03_missile_id[3][1], 0, nil, nil)
      end
    end
  end
  
  do
    local function cancelSk2(skill03)
      local role = skill03.role
      
      if role.skAct.name == "skill03" then
        abort_skill(role.npc, true)
        role.baseActs.wander:try()
      end
    end
    
    icons.skill03.cancelUp:addUiAct(cancelSk2)
    magics.skill03ProDerive.act = skActs.skill03Pro
    
    function magics.skill03ProDerive.onBegin(skill03ProDerive, casterNpc, target)
      local act = skill03ProDerive.act
      act.curSk:deriveAuto()
    end
  end
  
  function skills.skill04_1.onBegin(skill04_1)
    local pos
    if role.target then
      pos = get_npc_pos(role.target)
    else
      pos = get_npc_offset_position(role.npc, nil, 0, 5)
    end
    cast_missile(role.npc, nil, pos.x, pos.z, role.skill04_missile_id.posMissile[2], 0, nil, nil)
    abort_magic_by_id(role.npc, magicIds.passiveSkillLoopTime)
  end
  
  function skills.skill04_2.onBegin(skill02)
    lookat_npc(role.npc, role.misLogics.misSkill04Camera.misInst, 1)
    local pos = get_missile_pos(role.misLogics.misSkill04Camera.misInst)
    local pos_my = get_npc_offset_position(role.misLogics.misSkill04Camera.misInst, get_npc_pos(role.npc), 0, 1)
    flash_to_pos(role.npc, pos.x, pos.z)
    role:doAfter(function()
      if get_come_on_hero() == role.npc and is_cast_skill_time(role.npc, 100101445) then
        role:change_follow_target(1, role.misLogics.misSkill04Camera.misInst, {
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
    end, 0.15, true)
    role:doAfter(function()
      if is_cast_skill_time(role.npc, 100101445) then
        flash_to_pos(role.npc, pos_my.x, pos_my.z)
      end
      set_cursor_enable(role.npc, true)
    end, 0.95)
    for k, v in ipairs(role.skill04_missile_id.atkMissile) do
      if 7 ~= k and 9 ~= k then
        cast_missile(role.npc, nil, pos.x, pos.z, v, 0, nil, nil)
      end
    end
    local atk = role.btns.atk
    local atkPro = role.icons.atk
    atk:setIcon(atkPro)
    set_keyframe_enable(role.npc, 10010144512, true, true)
    set_cursor_enable(role.npc, false)
  end
  
  magics.skill04_2End[1].onBegin = function(passiveSkillLoopTime, casterNpc, target)
    if get_come_on_hero() == role.npc then
      magics.skill04_2End.isAtk = true
    end
  end
  magics.skill04_2End[2].onBegin = function(passiveSkillLoopTime, casterNpc, target)
    local pos = get_missile_pos(role.misLogics.misSkill04Camera.misInst)
    if magics.skill04_2End.isAtk then
      cast_missile(role.npc, nil, pos.x, pos.z, role.skill04_missile_id.atkMissile[7], 0, nil, nil)
      cast_missile(role.npc, nil, pos.x, pos.z, role.skill04_missile_id.atkMissile[9], 0, nil, nil)
    end
    magics.skill04_2End.isAtk = false
  end
  
  function skills.linkQte.onBegin(linkQte)
    local pos
    if role.target then
      pos = get_npc_pos(role.target)
    else
      pos = get_npc_offset_position(role.npc, nil, 0, 5)
    end
    cast_missile(role.npc, nil, pos.x, pos.z, role.skill04Qte_missile_id.posMissile[2], 0, nil, nil)
    abort_magic_by_id(role.npc, magicIds.passiveSkillLoopTime)
  end
  
  function skills.linkQte_end.onBegin(linkQte_end)
    lookat_npc(role.npc, role.misLogics.misSkill04Camera.misInst, 1)
    local pos = get_missile_pos(role.misLogics.misSkill04Camera.misInst)
    local pos_my = get_npc_offset_position(role.misLogics.misSkill04Camera.misInst, get_npc_pos(role.npc), 0, 1)
    flash_to_pos(role.npc, pos.x, pos.z)
    role:doAfter(function()
      if get_come_on_hero() == role.npc and is_cast_skill_time(role.npc, 100101447) then
        role:change_follow_target(1, role.misLogics.misSkill04Camera.misInst, {
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
    end, 0.15, true)
    role:doAfter(function()
      if is_cast_skill_time(role.npc, 100101447) then
        flash_to_pos(role.npc, pos_my.x, pos_my.z)
      end
      set_cursor_enable(role.npc, true)
    end, 0.95)
    for k, v in ipairs(role.skill04Qte_missile_id.atkMissile) do
      if 7 ~= k and 9 ~= k then
        cast_missile3(role.npc, nil, pos.x, pos.z, v, 0, nil, nil)
      end
    end
    local atk = role.btns.atk
    local atkPro = role.icons.atk
    atk:setIcon(atkPro)
    set_keyframe_enable(role.npc, 10010144712, true, true)
    set_cursor_enable(role.npc, false)
  end
  
  function misLogics.misSkill04Camera.onBegin(misSkill04Camera, misInst, casterNpc, hitTarget, hitType, skill)
    role.misLogics.misSkill04Camera.misInst = misInst
  end
  
  function misLogics.misSkill04Camera.onEnd(misSkill04Camera, misInst, casterNpc, hitTarget, hitType, skill)
    if get_come_on_hero() == role.npc and (role.skAct.name == "skill04_1" and role.skAct.curSk == role.skills.skill04_2 or role.skAct.name == "linkQte" and role.skAct.curSk == role.skills.linkQte_end) then
      role:change_follow_target(4)
      change_focus_follow_speed(2)
    end
    if role.skAct.curSk ~= skills.skill04_1 and role.skAct.curSk ~= skills.linkQte then
      role.misLogics.misSkill04Camera.misInst = nil
    end
  end
  
  do
    local function skill04CameraReset()
      role:change_follow_target(4)
      
      change_focus_follow_speed(6)
    end
    
    skills.skill04_2.onEnd = skill04CameraReset
    skills.skill04_2.onBreak = skill04CameraReset
    skills.linkQte_end.onEnd = skill04CameraReset
    skills.linkQte_end.onBreak = skill04CameraReset
  end
  misLogics.misPassvieRunes[1].onEnd = function(missile_cfg, missile, owner, pos_x, pos_z)
    role.passiveRunes = true
    role.passiveRunesTime = get_npc_time(role.npc) + role.passiveRunesTime_fix
    cast_magic(role.npc, role.npc, 1014221, 0)
  end
  
  function role.runes_logic(role)
    role.now_time = get_npc_time(role.npc)
    if role.passiveRunes and role.now_time >= role.passiveRunesTime then
      role.passiveRunes = false
      role.passiveRunesAtkNumb = 1
      local npc1 = get_come_on_hero()
      local npc2 = get_scene_hero_by_poskey(21)
      local npc3 = get_scene_hero_by_poskey(22)
      abort_magic_by_id(role.npc, 1014221, 1)
    end
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      return 2
    else
      return 0
    end
  end
  
  function skills.ult.onBegin(ult)
    local pos
    if role.target and check_npc_distance(role.npc, role.target, 4.5, true) and not check_npc_die(role.target) then
      lookat_npc(role.npc, role.target)
      pos = get_npc_offset_position(role.target, get_npc_pos(role.npc), 180, 2)
    else
      pos = get_npc_offset_position(role.npc, nil, 0, 4.5)
    end
    cast_missile(role.npc, nil, pos.x, pos.z, 10010145281, 0)
    if role.passiveRunes then
      cast_magic(role.npc, role.npc, role.passiveRunesMagic[2], role.passiveRunesMagicLv[2])
    end
  end
  
  function misLogics.misUltEffect.onBegin(missile_cfg, missile, owner, pos_x, pos_z)
    role:change_follow_target(1, missile, {
      9999,
      0,
      {
        x = 0,
        y = 0,
        z = 200
      },
      0,
      0,
      0.055
    })
    role:doAfter(function()
      if get_come_on_hero() == role.npc and role.skAct.name == "ult" then
        role:change_follow_target(4)
        change_focus_follow_speed(2.5)
      end
    end, 1.7)
  end
  
  function skills.ult4.onBreak(ult)
    role:change_follow_target(4)
    change_focus_follow_speed(6)
  end
  
  misLogics.misEnergyAdd[11].onHit = function(misEnergyAdd, misInst, casterNpc, hitTarget, hitType, skill)
    spBarStatus(true, misEnergyAdd, 2)
  end
  misLogics.misEnergyAdd[12].onHit = function(misEnergyAdd, misInst, casterNpc, hitTarget, hitType, skill)
    spBarStatus(true, misEnergyAdd, 5)
  end
end

function Logos.on_skill_hit(role, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if role.passiveRunes and npc == get_come_on_hero() and not npc_is_destroy(npc) and role.now_time >= role.passiveRunesAtkTime then
    local pos
    if 1 == missile_cfg.MissileTypeTag then
      pos = get_npc_pos(npc)
    else
      pos = get_npc_pos(hit_target)
    end
    cast_missile(role.npc, nil, pos.x, pos.z, role.passiveRunesMissile[role.passiveRunesAtkNumb], 0, nil, nil)
    role.passiveRunesAtkNumb = role.passiveRunesAtkNumb + 1
    if role.passiveRunesAtkNumb > 3 then
      role.passiveRunesAtkNumb = 1
    end
    role.passiveRunesAtkTime = role.now_time + 0.5
    role.passiveRunesHit = true
  end
end

function Logos.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if npc == role.npc and not is_showup then
    cast_magic(role.npc, role.npc, 101429, 1)
    change_focus_follow_speed(20)
    role:change_follow_target(4)
    set_keyframe_enable(role.npc, 10010144512, false, true)
    set_keyframe_enable(role.npc, 10010144712, false, true)
  end
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
end

function Logos.on_room_change(role, npc)
  if not check_npc_die(role.npc) and role.destinyLv >= 5 then
    role:add_shared_reborn_chance(role.destiniesMagic.Lv5[2])
  end
end

function Logos.on_hero_enter_ground_state(role, npc)
  role.base.on_hero_enter_ground_state(role, npc)
  if npc == role.npc and (is_cast_skill_time(role.npc, 100101460) or is_cast_skill_time(role.npc, 100101461)) then
    abort_skill(role.npc, 1)
    role.skActs.skill03Atk:start()
  end
  if npc == role.npc then
    cast_magic(role.npc, role.npc, 101429, 1)
    change_focus_follow_speed(20)
    role:change_follow_target(4)
    set_keyframe_enable(role.npc, 10010144512, false, true)
    set_keyframe_enable(role.npc, 10010144712, false, true)
  end
end

function Logos.on_npc_hp_zero(role, npc)
  role.base.on_npc_hp_zero(role, npc)
end

function Logos.on_frame_background(role, npc)
  role.base.on_frame_background(role, npc)
  role.runes_logic(role)
end

function Logos.on_frame(role)
  role.base.on_frame(role)
  role.runes_logic(role)
  if role.isCastTimeSkill03 then
    cast_magic(role.npc, role.npc, 999973, 1)
  end
end

function Logos.onRampageStart(role, stage)
  local sk1 = role.btns.sk1
  local skill02 = role.icons.skill02Pros
  sk1:setIcon(skill02)
end

function Logos.onRampageEnd(role, stage)
  local sk1 = role.btns.sk1
  local skill02 = role.icons.skill02
  sk1:setIcon(skill02)
end

return Logos
