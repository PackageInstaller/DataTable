local roleBase = import("character.base.role_base")
local LiChi = Util.create_child_mt(roleBase)
local link_up = false
local fury_num = 0
local link_fury = false
local controller_status = 0
local BuffLevel = 0
local magicIds_1 = {
  magic_furyWeapon2Fx = 1022061,
  magic_furyCamFx = 1022060,
  magic_ultPass = 10220500
}

function LiChi._init(role, npc)
  local role = role
  role.npc = npc
  local misIds = {
    atk03Mis = 10010220301,
    atkmissile = 10010220404,
    atkmissileFx = 10010220405,
    atk04Focus = 10010220406,
    countermissile = 10010221204,
    countermissileFx = 10010221205,
    counterFocus = 10010221206,
    atk04_pos = {10010221201, 10010220401},
    furyBackMis = 10010224003,
    furyBackHitMis = 10010224005,
    furyCheckMis1 = 10010224214,
    furyCheckMis2 = 10010224215,
    link_furyCheckMis1 = 10010224226,
    link_furyCheckMis2 = 10010224227,
    flyMis1 = 10010222011,
    flyMis2 = 10010222012,
    butterFlyMis = 10010222010,
    butterFlyCam = 10010222013,
    butterFlyHit = 10010222001,
    butterFly2Hit = 10010224601,
    ultEffect = {
      10010226016,
      10010226017,
      10010226018,
      10010226006,
      10010226020,
      10010226032,
      10010226053,
      10010226055
    },
    ultFocus = {10010226038, 10010226039},
    magic_traces4Mis = {10010225001, 10010225002}
  }
  local magicIds = {
    magic_thunderDao2check = 1022040,
    magic_thunderDao2_effect = 1022043,
    magic_thunderDao3check = 1022041,
    magic_atk04MultiHit = {1022034, 10220341},
    magic_furyFlash = 10220724,
    magic_furybackcheck = 1022076,
    magic_furyatkcheck = 1022072,
    magic_furyatkFail = 10220721,
    magic_furyatkCam = {
      1022067,
      1022068,
      1022069
    },
    magic_butterflypos = 10220722,
    magic_ultmis = {
      10220991,
      10220993,
      10220994,
      10220995,
      10220996,
      10220997
    },
    magic_butterflycheck = 1022053,
    magic_butterflyHit = 10220295,
    magic_butterfly2_check = 1022054,
    magic_butterfly2_turn = 10220541,
    magic_destinies1_atkUp = 10220307,
    magic_destinies1_furyUp1 = 10220305,
    magic_destinies1_furyUp2 = 10220306,
    magic_destinies5 = {
      WuDi = 10220311,
      damgUp = 10220312,
      FurydamgUp = 10220316,
      BaoShang = 10220313,
      coolDown = 10220314,
      healing = 10220315
    },
    magic_spweapon = 10220401,
    magic_drawblood = 1022070,
    magic_skill2Timing = 10220701
  }
  local spBar = {
    false,
    false,
    false,
    false,
    false
  }
  roleBase._init(role, misIds, magicIds, spBar)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  role.BFhit_target = nil
  role.BF2hit_limit = 0
  role.BFcheck_target = nil
  role.fury_status = 0
  role.fury_pursue = 0
  role.ultpos = 0
  role.ultpos2 = 0
  role.energy_attr = 0
  role.furyAtk_pos = 0
  role.furyCamCount = 0
  role.furyCheckMis_1 = 0
  role.furyCheckMis_2 = 0
  role.furyCheckMis_limit = 1
  role.furyFirstAtk = 0
  role.furybackPos = 0
  role.autoAtkSearch = skActs.furyStart1.search
  role.autoAtkSearch.directional.custom = role.auto_atk_custom_weight
  role.autoAtkSearch.noInput.custom = role.auto_atk_custom_weight
  role.autoAtkSearch.directional.viscous.enable = true
  role.autoAtkSearch.noInput.viscous.enable = true
  local destinies3 = false
  local destinies4 = false
  local destinies5 = false
  local traces = role.traces
  traces[10220200] = 1
  traces[10220201] = 2
  traces[10220202] = 3
  traces[10220203] = 4
  traces[10220204] = 5
  local destinies = role.destinies
  destinies[10220300] = 1
  destinies[10220301] = 2
  destinies[10220302] = 3
  destinies[10220303] = 4
  destinies[10220304] = 5
  local spWeapon = role.spWeapon
  spWeapon.magic = 10220400
  
  function magics.magic_butterflycheck.onEnd(magic_butterflycheck, npc, target)
    local role = magic_butterflycheck.unit
    role.BFcheck_target = nil
    abort_magic_by_id(npc, 10220403)
  end
  
  function magics.magic_butterflycheck.onBegin(magic_butterflycheck, npc, target)
    local role = magic_butterflycheck.unit
    role.BFcheck_target = target
    if 1 == role.fury_status and spWeapon.lv > 0 then
      cast_magic(npc, npc, 10220403, spWeapon.lv)
    end
  end
  
  function misLogics.atk03Mis.onHit(atk03Mis, atk03MisInst, casterNpc, hitTarget, hitType, skill)
    change_missile_move_params(atk03MisInst, 2, 0)
  end
  
  function skills.atk3.onEnd()
    abort_magic_by_id(role.npc, 1022032)
    abort_magic_by_id(role.npc, 10220521)
    abort_magic_by_id(role.npc, 1022051)
  end
  
  function skills.atk3.onBreak()
    abort_magic_by_id(role.npc, 1022032)
    abort_magic_by_id(role.npc, 10220521)
    abort_magic_by_id(role.npc, 1022051)
  end
  
  do
    local atk04Pos
    
    local function get_pos(Pos, PosInst, owner, posX, posZ)
      if role.target and not check_npc_die(role.target) then
        atk04Pos = get_npc_offset_position(role.target, nil, 0, 0)
      else
        atk04Pos = get_npc_offset_position(role.npc, nil, 0, 5)
      end
    end
    
    misLogics.atk04_pos[1].onBegin = get_pos
    misLogics.atk04_pos[2].onBegin = get_pos
    magics.magic_atk04MultiHit[1].onBegin = function()
      cast_missile3(role.npc, nil, atk04Pos.x, atk04Pos.z, misIds.atkmissile, 0)
      cast_missile3(role.npc, nil, atk04Pos.x, atk04Pos.z, misIds.atkmissileFx, 0)
    end
    magics.magic_atk04MultiHit[2].onBegin = function()
      cast_missile3(role.npc, nil, atk04Pos.x, atk04Pos.z, misIds.countermissile, 0)
      cast_missile3(role.npc, nil, atk04Pos.x, atk04Pos.z, misIds.countermissileFx, 0)
    end
    
    local function focusCamBegin(Focus, FocusInst, owner, posX, posZ)
      role:change_follow_target(1, FocusInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        2,
        1
      })
    end
    
    local function focusCamEnd(Focus, FocusInst, owner, posX, posZ)
      change_focus_follow_speed(3)
      role:change_follow_target(4)
      
      local function resetFollow()
        change_focus_follow_speed(4)
      end
      
      local role = Focus.unit
      role:doAfter(resetFollow, 1.5)
    end
    
    misLogics.atk04Focus.onBegin = focusCamBegin
    misLogics.atk04Focus.onEnd = focusCamEnd
    misLogics.counterFocus.onBegin = focusCamBegin
    misLogics.counterFocus.onEnd = focusCamEnd
  end
  do
    local pos = 0
    
    function skActs.butterFly1.onBegin(butterFly1)
      pos = get_npc_pos(role.npc)
      butterFly1.base.onBegin(butterFly1)
    end
    
    function skills.butterFly1.onEnd()
      abort_magic_by_id(role.npc, 1022052)
      abort_magic_by_id(role.npc, 1022056)
    end
    
    function skills.butterFly1.onBreak()
      abort_magic_by_id(role.npc, 1022052)
      abort_magic_by_id(role.npc, 1022056)
    end
    
    function misLogics.butterFlyCam.onBegin(Focus, FocusInst, owner, posX, posZ)
      role:change_follow_target(1, FocusInst, {
        9999,
        0,
        {
          x = 0,
          y = -0.5,
          z = 50
        },
        2,
        1
      })
    end
    
    function misLogics.butterFlyCam.onEnd(Focus, FocusInst, owner, posX, posZ)
      change_focus_follow_speed(2.5)
      role:change_follow_target(4)
      
      local function resetFollow()
        change_focus_follow_speed(4)
      end
      
      local role = Focus.unit
      role:doAfter(resetFollow, 1.5)
    end
    
    function misLogics.butterFlyHit.onHit(butterFlyHit, butterFlyHitInst, casterNpc, hitTarget, hitType, skill)
      role.BFhit_target = hitTarget
    end
    
    function misLogics.butterFlyMis.onEnd(butterFlyMis, butterFlyMisInst, casterNpc, hitTarget, hitType, skill)
      local choose_one = math.random()
      if role.BFhit_target == nil then
        return
      elseif role.BFhit_target ~= nil and choose_one >= 0.5 then
        cast_missile3(role.npc, role.BFhit_target, pos.x, pos.z, misIds.flyMis1, 0)
      elseif role.BFhit_target ~= nil and choose_one < 0.5 then
        cast_missile3(role.npc, role.BFhit_target, pos.x, pos.z, misIds.flyMis2, 0)
      end
    end
    
    function misLogics.flyMis1.onHit(flyMis1, flyMis1Inst, casterNpc, hitTarget, hitType, skill)
      if role.BFcheck_target ~= hitTarget and role.BFcheck_target ~= nil then
        abort_magic_by_id(role.BFcheck_target, magicIds.magic_butterflycheck)
      end
      if hitTarget == role.BFhit_target then
        cast_magic(casterNpc, hitTarget, magicIds.magic_butterflycheck, 0)
        remove_missile(flyMis1Inst)
        role.BFhit_target = nil
      end
    end
    
    function misLogics.flyMis2.onHit(flyMis2, flyMis2Inst, casterNpc, hitTarget, hitType, skill)
      if role.BFcheck_target ~= hitTarget and role.BFcheck_target ~= nil then
        abort_magic_by_id(role.BFcheck_target, magicIds.magic_butterflycheck)
      end
      if hitTarget == role.BFhit_target then
        cast_magic(casterNpc, hitTarget, magicIds.magic_butterflycheck, 0)
        remove_missile(flyMis2Inst)
        role.BFhit_target = nil
      end
    end
    
    function misLogics.butterFly2Hit.onHit(butterFly2Hit, butterFly2HitInst, casterNpc, hitTarget, hitType, skill)
      if 1 == role.BF2hit_limit then
        return
      end
      if role.BFcheck_target ~= hitTarget and role.BFcheck_target ~= nil then
        abort_magic_by_id(role.BFcheck_target, magicIds.magic_butterflycheck)
      end
      cast_magic(casterNpc, hitTarget, magicIds.magic_butterflycheck, 0)
      role.BF2hit_limit = 1
    end
    
    function misLogics.butterFly2Hit.onEnd(butterFly2Hit, butterFly2HitInst, casterNpc, hitTarget, hitType, skill)
      role.BF2hit_limit = 0
    end
  end
  do
    local pos
    
    function skActs.furyStart1.tarPos(furyStart1)
      if role.target then
        pos = get_position_offset_position(get_npc_pos(role.target), role.npc:get_pos_vec3(), 0, 3.5)
        return furyStart1.role.target:get_pos_vec3()
      else
        pos = get_npc_offset_position(role.npc, nil, 0, 3.5)
        return
      end
    end
    
    function magics.magic_furyFlash.onBegin()
      flash_to_pos(npc, pos.x, pos.z)
    end
    
    function skActs.furyStart1.onEnd(furyStart1)
      furyStart1.isOver = true
      local nextAct = furyStart1.role:choose_auto_atk()
      if nextAct then
        nextAct:try()
      else
        furyStart1.base.start(furyStart1)
      end
    end
    
    function skActs.furyAtk.tarPos(furyAtk)
      return furyAtk.role.target:get_pos_vec3()
    end
    
    skActs.furyAtk.snap = 10010224212
    
    function skActs.furyAtk.start(furyAtk, event)
      if check_npc_distance(role.npc, role.target, 3, true) then
        set_keyframe_enable(role.npc, furyAtk.snap, 1, false, false)
      else
        set_keyframe_enable(role.npc, furyAtk.snap, 1, true, false)
      end
      furyAtk.base.start(furyAtk, event)
    end
    
    skActs.furyAtk.iconAtk = icons.furyAtk
    
    function skActs.furyAtk.onBegin(furyAtk)
      if 0 == role.furyFirstAtk then
        cast_magic(role.npc, role.npc, magicIds.magic_butterflypos, 0)
        role.furyFirstAtk = 1
      end
      furyAtk.iconAtk.isButtonMash = false
      furyAtk.base.onBegin(furyAtk)
    end
    
    skActs.furyAtk.furySprint = skActs.furySprint
    
    function skActs.furyAtk.onEnd(furyAtk)
      furyAtk.isOver = true
      set_keyframe_enable(role.npc, 10010224210, true, true)
      local nextAct = furyAtk.role:choose_auto_atk()
      if nextAct == furyAtk then
        furyAtk.furySprint:try()
      elseif nextAct then
        nextAct:try()
      else
        furyAtk.base.onEnd(furyAtk)
      end
    end
    
    function magics.magic_furyatkcheck.onBegin()
      function icons.furyAtk.updateEnhance(furyAtk)
        furyAtk.isEnhance = furyAtk.isEnable
      end
    end
    
    function magics.magic_furyatkcheck.onEnd()
      function icons.furyAtk.updateEnhance(furyAtk)
        furyAtk.isEnhance = false
      end
    end
    
    function misLogics.furyCheckMis1.onBegin(furyCheckMis1, furyCheckMis1Inst, casterNpc, hitTarget, hitType, skill)
      role.furyCheckMis_1 = furyCheckMis1Inst
    end
    
    function misLogics.link_furyCheckMis1.onBegin(link_furyCheckMis1, link_furyCheckMis1Inst, casterNpc, hitTarget, hitType, skill)
      role.furyCheckMis_1 = link_furyCheckMis1Inst
    end
    
    function misLogics.furyCheckMis2.onBegin(furyCheckMis2, furyCheckMis2Inst, casterNpc, hitTarget, hitType, skill)
      role.furyCheckMis_2 = furyCheckMis2Inst
    end
    
    function misLogics.link_furyCheckMis2.onBegin(link_furyCheckMis2, link_furyCheckMis2Inst, casterNpc, hitTarget, hitType, skill)
      role.furyCheckMis_2 = link_furyCheckMis2Inst
    end
    
    function misLogics.furyCheckMis1.onEnd(furyCheckMis1, furyCheckMis1Inst, casterNpc, hitTarget, hitType, skill)
      role.furyCheckMis_1 = 0
    end
    
    function misLogics.link_furyCheckMis1.onEnd(link_furyCheckMis1, link_furyCheckMis1Inst, casterNpc, hitTarget, hitType, skill)
      role.furyCheckMis_1 = 0
    end
    
    function misLogics.furyCheckMis2.onEnd(furyCheckMis2, furyCheckMis2Inst, casterNpc, hitTarget, hitType, skill)
      role.furyCheckMis_2 = 0
    end
    
    function misLogics.link_furyCheckMis2.onEnd(link_furyCheckMis2, link_furyCheckMis2Inst, casterNpc, hitTarget, hitType, skill)
      role.furyCheckMis_2 = 0
    end
    
    local function extraHit(icon)
      local role = icon.role
      if not check_magic(role.npc, icon.magic_furyatkcheck.id) then
        icon.isButtonMash = true
        return
      end
      local furyFly = icon.furyFly
      if furyFly:isReady() then
        if 0 == role.furyCamCount then
          cast_magic(role.npc, role.npc, magicIds.magic_furyatkCam[1], 0)
          role.furyCamCount = 1
        elseif 1 == role.furyCamCount then
          cast_magic(role.npc, role.npc, magicIds.magic_furyatkCam[2], 0)
          role.furyCamCount = 2
        elseif 2 == role.furyCamCount then
          cast_magic(role.npc, role.npc, magicIds.magic_furyatkCam[3], 0)
          role.furyCamCount = 0
        end
        abort_magic_by_id(role.npc, 1022072)
        cast_magic(role.npc, role.npc, 10220694, 0)
        furyFly:start()
      end
    end
    
    icons.furyAtk.magic_furyatkcheck = role.magics.magic_furyatkcheck
    icons.furyAtk.furyFly = skActs.furyFly
    icons.furyAtk.hit:addUiAct(extraHit)
    
    function skActs.furyFly.tarPos(furyFly)
      local target = furyFly.role.target
      return target and target:get_pos_vec3()
    end
    
    function skActs.furyFly.start(furyFly, event)
      local role = furyFly.role
      local searchRange = role.autoAtkSearch
      searchRange.directional.viscous.weight = 10
      searchRange.noInput.viscous.weight = 10
      role:searchTarget(searchRange)
      local target = furyFly.role.target
      local misPos, flashPos
      if target then
        flashPos = get_position_offset_position(get_npc_pos(target), role.npc:get_pos_vec3(), 180, 5.5)
        misPos = target:get_pos_vec3()
      else
        flashPos = get_npc_offset_position(role.npc, nil, 0, 1.5)
        misPos = role.npc:get_pos_vec3()
      end
      set_keyframe_enable(role.npc, 10010224210, false, false)
      flash_to_pos(role.npc, flashPos.x, flashPos.z)
      cast_missile3(role.npc, target, misPos.x, misPos.z, 10010224220, 0)
      cast_missile3(role.npc, target, misPos.x, misPos.z, 10010224219, 0)
      furyFly.base.start(furyFly, event)
    end
    
    function skActs.furySprint.tarPos(furySprint)
      return furySprint.role.target:get_pos_vec3()
    end
    
    function skills.furySprint.tarPos()
    end
    
    function skills.furySprint.target()
    end
    
    function skActs.furySprint.onBegin(furySprint)
      abort_magic_by_id(role.npc, 1022072)
      furySprint.base.onBegin(furySprint)
    end
    
    function misLogics.furyCheckMis1.onHit(furyCheckMis1, furyCheckMis1Inst, casterNpc, hitTarget, hitType, skill)
      remove_missile(furyCheckMis1Inst)
    end
    
    function misLogics.furyCheckMis2.onHit(furyCheckMis2, furyCheckMis2Inst, casterNpc, hitTarget, hitType, skill)
      remove_missile(furyCheckMis2Inst)
    end
    
    function misLogics.link_furyCheckMis1.onHit(link_furyCheckMis1, link_furyCheckMis1Inst, casterNpc, hitTarget, hitType, skill)
      remove_missile(link_furyCheckMis1Inst)
    end
    
    function misLogics.link_furyCheckMis2.onHit(link_furyCheckMis2, link_furyCheckMis2Inst, casterNpc, hitTarget, hitType, skill)
      remove_missile(link_furyCheckMis2Inst)
    end
    
    function skActs.furySprint.onEnd(furySprint)
      furySprint.isOver = true
      local nextAct = furySprint.role:choose_auto_atk(-10)
      if nextAct then
        nextAct:try()
      else
        furySprint.base.onEnd(furySprint)
      end
    end
    
    function magics.magic_butterflypos.onBegin()
      if role.target == nil then
        return
      end
      if 1 == role.furyCheckMis_limit then
        if 0 ~= role.furyCheckMis_1 then
          local misPos = get_missile_pos(role.furyCheckMis_1)
          cast_missile3(role.npc, nil, misPos.x, misPos.z, 10010224225, 1, misPos.x, misPos.z, misPos.y, misPos.y, misPos.x, misPos.z)
          remove_missile(role.furyCheckMis_1)
        end
        if 0 ~= role.furyCheckMis_2 then
          local misPos = get_missile_pos(role.furyCheckMis_2)
          cast_missile3(role.npc, nil, misPos.x, misPos.z, 10010224225, 1, misPos.x, misPos.z, misPos.y, misPos.y, misPos.x, misPos.z)
          remove_missile(role.furyCheckMis_2)
        end
      end
      if role.target ~= nil then
        local butterflypos
        if link_up then
          butterflypos = get_npc_offset_position(role.npc, nil, 0, 6.5)
        else
          butterflypos = get_npc_offset_position(role.npc, nil, 0, 5)
        end
        local random = math.random(0, 1)
        if 0 == random then
          if link_up then
            cast_missile3(role.npc, role.npc, butterflypos.x, butterflypos.z, misIds.link_furyCheckMis1, 0)
          else
            cast_missile3(role.npc, role.npc, butterflypos.x, butterflypos.z, misIds.furyCheckMis1, 0)
          end
        elseif 1 == random then
          if link_up then
            cast_missile3(role.npc, role.npc, butterflypos.x, butterflypos.z, misIds.link_furyCheckMis2, 0)
          else
            cast_missile3(role.npc, role.npc, butterflypos.x, butterflypos.z, misIds.furyCheckMis2, 0)
          end
        end
      end
    end
  end
  icons.furyDash.cdMagic = magics.dashCd
  
  function icons.furyDash.updateEnable(furyDash)
    furyDash.isEnable = not check_magic(furyDash.role.npc, furyDash.cdMagic.id)
  end
  
  function magics.magic_thunderDao2check.onBegin()
    if 0 == role.fury_status then
      local btns = role.btns
      local icons = role.icons
      btns.sk2:setIcon(icons.thunderDaoComb2)
    end
  end
  
  function role.thunderDao2Set(role)
    if 0 == role.fury_status then
      local btns = role.btns
      local icons = role.icons
      btns.sk2:setIcon(icons.thunderDao2)
    end
  end
  
  function magics.magic_thunderDao2check.onEnd(magic_thunderDao2check, caster, target)
    magic_thunderDao2check.unit:thunderDao2Set()
    magic_thunderDao2check.base.onEnd(magic_thunderDao2check, caster, target)
  end
  
  function skActs.thunderDao1.onEnd(thunderDao1)
    abort_magic_by_id(role.npc, magicIds.magic_thunderDao2check)
    thunderDao1.base.onEnd(thunderDao1)
  end
  
  function skActs.thunderDao1.onBreak(thunderDao1, tarAct)
    abort_magic_by_id(role.npc, magicIds.magic_thunderDao2check)
    thunderDao1.base.onBreak(thunderDao1, tarAct)
  end
  
  function magics.magic_thunderDao3check.onBegin()
    if 0 == role.fury_status then
      local btns = role.btns
      local icons = role.icons
      btns.sk2:setIcon(icons.thunderDaoComb3)
    end
  end
  
  function role.thunderDao3Set(role)
    if 0 == role.fury_status then
      local btns = role.btns
      local icons = role.icons
      btns.sk2:setIcon(icons.thunderDao3)
    end
  end
  
  function skActs.thunderDao2.onEnd(thunderDao2)
    abort_magic_by_id(role.npc, magicIds.magic_thunderDao3check)
    thunderDao2.base.onEnd(thunderDao2)
  end
  
  function skActs.thunderDao2.onBreak(thunderDao2, tarAct)
    abort_magic_by_id(role.npc, magicIds.magic_thunderDao3check)
    thunderDao2.base.onBreak(thunderDao2, tarAct)
  end
  
  function magics.magic_thunderDao3check.onEnd(magic_thunderDao3check, caster, target)
    magic_thunderDao3check.unit:thunderDao3Set()
    magic_thunderDao3check.base.onEnd(magic_thunderDao3check, caster, target)
  end
  
  do
    local function resetCombCheck(act)
      abort_magic_by_id(role.npc, magicIds.magic_thunderDao3check)
      
      if 0 == role.fury_status then
        local btns = role.btns
        local icons = role.icons
        btns.sk2:setIcon(icons.thunderDao1)
      end
      act.base.onBefTime(act)
    end
    
    skActs.thunderDao3.onBefTime = resetCombCheck
    skActs.thunderDaoComb3.onBefTime = resetCombCheck
    
    local function drawBlood(act)
      if role.traceLv > 1 then
        cast_magic(npc, npc, 10220206, 0)
      else
        cast_magic(npc, npc, 1022079, 0)
      end
      act.base.onBegin(act)
      local hp_cur = get_npc_attr(npc, 1)
      local hp_max = get_npc_attr(npc, 4)
      local hp_per = math.floor(hp_cur / hp_max * 10)
      if hp_per < 5.5 then
        return
      else
        cast_magic(npc, npc, magicIds.magic_drawblood, 0)
      end
    end
    
    magics.magic_skill2Timing.onBegin = drawBlood
    role.base_wander_tick = role.baseActs.wander.tick
    role.baseActs.wander.furyStart1 = skActs.furyStart1
    role.baseActs.wander.furyAtk = skActs.furyAtk
    role.searchFrame_fury = 0
    
    function skActs.switchFury.onBegin(switchFury)
      switchFury.base.onBegin(switchFury)
      local btns = role.btns
      local icons = role.icons
      btns.sk2:setIcon(icons.switchBack)
      
      function icons.switchBack.updateEnable(switchBack)
        icons.switchBack.isEnable = false
      end
      
      set_ui_object_visible("fight", "Main", false)
    end
    
    function skActs.switchFury.onEnd(switchFury)
      if role.BFcheck_target ~= nil and spWeapon.lv > 0 then
        cast_magic(npc, npc, 10220403, spWeapon.lv)
      end
      switchFury.role:changeFuryController()
      switchFury.base.onEnd(switchFury)
      set_ui_object_visible("fight", "Main", true)
    end
    
    function skActs.switchFury.onBreak(switchFury, tarAct)
      if role.BFcheck_target ~= nil and spWeapon.lv > 0 then
        cast_magic(npc, npc, 10220403, spWeapon.lv)
      end
      switchFury.role:changeFuryController()
      set_ui_object_visible("fight", "Main", true)
      switchFury.base.onBreak(switchFury, tarAct)
    end
    
    function skActs.linkQte.onBegin(linkQte)
      cast_magic(role.npc, role.npc, 10220821, 0)
      linkQte.base.onBegin(linkQte)
      local btns = role.btns
      local icons = role.icons
      btns.sk2:setIcon(icons.switchBack)
      
      function icons.switchBack.updateEnable(switchBack)
        icons.switchBack.isEnable = false
      end
      
      set_ui_object_visible("fight", "Main", false)
    end
    
    function skActs.linkQte.onEnd(linkQte)
      if role.BFcheck_target ~= nil and spWeapon.lv > 0 then
        cast_magic(npc, npc, 10220403, spWeapon.lv)
      end
      linkQte.role:changeFuryController()
      linkQte.base.onEnd(linkQte)
      set_ui_object_visible("fight", "Main", true)
    end
    
    function skActs.linkQte.onBreak(linkQte, tarAct)
      if role.BFcheck_target ~= nil and spWeapon.lv > 0 then
        cast_magic(npc, npc, 10220403, spWeapon.lv)
      end
      linkQte.role:changeFuryController()
      linkQte.base.onBreak(linkQte, tarAct)
      set_ui_object_visible("fight", "Main", true)
    end
    
    local furyBackMissile = 0
    local furyBackHitMissile = 0
    
    function misLogics.furyBackMis.onBegin(furyBackMis, furyBackMisInst, casterNpc, hitTarget, hitType, skill)
      furyBackMissile = furyBackMisInst
    end
    
    function misLogics.furyBackHitMis.onBegin(furyBackHitMis, furyBackHitMisInst, casterNpc, hitTarget, hitType, skill)
      furyBackHitMissile = furyBackHitMisInst
    end
    
    function magics.magic_furybackcheck.onBegin()
      change_missile_move_params(furyBackMissile, -16, -5)
      change_missile_move_params(furyBackHitMissile, -16, -5)
    end
    
    function misLogics.furyBackHitMis.onHit(furyBackHitMis, furyBackHitMisInst, casterNpc, hitTarget, hitType, skill)
      remove_missile(furyBackHitMisInst)
      remove_missile(furyBackMissile)
    end
    
    function skActs.switchBack.onBegin(switchBack)
      local btns = role.btns
      local icons = role.icons
      btns.sk1:setIcon(icons.butterFly1)
      btns.sk2:setIcon(icons.thunderDao1)
      btns.atk:setIcon(icons.atk)
      btns.dash:setIcon(icons.dash)
      role.furyFirstAtk = 0
      abort_magic_by_id(role.npc, 1022061)
      abort_magic_by_id(role.npc, 10220309)
      abort_magic_by_id(role.npc, 1022066)
      abort_magic_by_id(role.npc, 10220692)
      abort_magic_by_id(role.npc, 10220693)
      if 0 ~= role.furyCheckMis_1 then
        local misPos = get_missile_pos(role.furyCheckMis_1)
        cast_missile3(role.npc, nil, misPos.x, misPos.z, 10010224225, 1, misPos.x, misPos.z, misPos.y, misPos.y, misPos.x, misPos.z)
        remove_missile(role.furyCheckMis_1)
      elseif 0 ~= role.furyCheckMis_2 then
        local misPos = get_missile_pos(role.furyCheckMis_2)
        cast_missile3(role.npc, nil, misPos.x, misPos.z, 10010224225, 1, misPos.x, misPos.z, misPos.y, misPos.y, misPos.x, misPos.z)
        remove_missile(role.furyCheckMis_2)
      end
      switchBack.base.onBegin(switchBack)
    end
    
    function skActs.switchBack.onEnd(switchBack)
      switchBack.role:changeBackController()
      switchBack.base.onEnd(switchBack)
    end
    
    function skActs.switchBack.onBreak(switchBack, tarAct)
      switchBack.role:changeBackController()
      switchBack.base.onBreak(switchBack, tarAct)
    end
  end
  role.is_ult_started = false
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      return 18
    else
      return 0
    end
  end
  
  function skills.ult.start(ult, act)
    ult.role:changeBackController()
    ult.base.start(ult, act)
    abort_magic_by_id(role.npc, 1022061)
    abort_magic_by_id(role.npc, 10220309)
    abort_magic_by_id(role.npc, 1022066)
    if role.skAct.name == "ultFast" then
      set_keyframe_enable(role.npc, 10010226039, true, true)
      set_keyframe_enable(role.npc, 10010226054, true, true)
      set_keyframe_enable(role.npc, 10010226005, false, true)
    elseif role.skAct.name == "ult" then
      set_keyframe_enable(role.npc, 10010226039, false, true)
      set_keyframe_enable(role.npc, 10010226054, false, true)
      set_keyframe_enable(role.npc, 10010226005, true, true)
    end
  end
  
  magics.magic_ultmis[1].onBegin = function()
    role.ultpos = get_npc_pos(role.npc)
    role.ultpos2 = get_npc_offset_position(role.npc, nil, 0, 5.5)
    cast_missile3(role.npc, nil, role.ultpos.x, role.ultpos.z, misIds.ultEffect[1], 0)
  end
  magics.magic_ultmis[2].onBegin = function()
    cast_missile3(role.npc, nil, role.ultpos.x, role.ultpos.z, misIds.ultEffect[2], 0)
  end
  magics.magic_ultmis[3].onBegin = function()
    cast_missile3(role.npc, nil, role.ultpos.x, role.ultpos.z, misIds.ultEffect[3], 0)
  end
  magics.magic_ultmis[4].onBegin = function()
    if role.skAct.name == "ult" then
      cast_missile3(role.npc, nil, role.ultpos2.x, role.ultpos2.z, misIds.ultEffect[4], 0)
    elseif role.skAct.name == "ultFast" then
      cast_missile3(role.npc, nil, role.ultpos2.x, role.ultpos2.z, misIds.ultEffect[8], 0)
    end
  end
  magics.magic_ultmis[5].onBegin = function()
    cast_missile3(role.npc, nil, role.ultpos2.x, role.ultpos2.z, misIds.ultEffect[5], 0)
  end
  magics.magic_ultmis[6].onBegin = function()
    if role.skAct.name == "ult" then
      cast_missile3(role.npc, nil, role.ultpos.x, role.ultpos.z, misIds.ultEffect[6], 0)
    elseif role.skAct.name == "ultFast" then
      cast_missile3(role.npc, nil, role.ultpos.x, role.ultpos.z, misIds.ultEffect[7], 0)
    end
  end
  do
    local function focusCamBegin(Focus, FocusInst, owner, posX, posZ)
      Focus.unit:change_follow_target_new(1, FocusInst, {
        9999,
        
        0,
        {
          x = 0,
          y = 0,
          z = 1.5
        },
        2,
        1,
        0.01,
        0,
        0
      })
    end
    
    local function focusCamEnd(Focus, FocusInst, owner, posX, posZ)
      local role = Focus.unit
      change_focus_follow_speed(1)
      role:change_follow_target(4)
      
      local function resetFollow(role)
        change_focus_follow_speed(4)
      end
      
      role:doAfter(resetFollow, 0.75)
    end
    
    misLogics.ultFocus[1].onBegin = focusCamBegin
    misLogics.ultFocus[1].onEnd = focusCamEnd
    
    local function focusCamBegin(Focus, FocusInst, owner, posX, posZ)
      change_follow_target_new(1, FocusInst, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 1.5
        },
        2,
        1,
        0.01,
        0,
        0
      })
    end
    
    local function focusCamEnd(Focus, FocusInst, owner, posX, posZ)
      change_focus_follow_speed(1.25)
      role:change_follow_target(4)
      
      local function resetFollow()
        change_focus_follow_speed(4)
      end
      
      local role = Focus.unit
      role:doAfter(resetFollow, 1.25)
    end
    
    misLogics.ultFocus[2].onBegin = focusCamBegin
    misLogics.ultFocus[2].onEnd = focusCamEnd
    
    function skills.finish.onBegin(finish)
      finish.role:changeBackController()
      abort_magic_by_id(role.npc, 1022061)
      abort_magic_by_id(role.npc, 1022066)
    end
  end
  traces[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(role.npc, skills.atk4.id, 1, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.counter.id, 1, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.atk4.id, 2, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.counter.id, 2, false, true)
  end
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local buff_level = math.floor(get_npc_attr(npc, 4) / 1000)
    cast_magic(npc, npc, 10220211, buff_level)
    
    local function traces1_atkbuff(role)
      local hp_cur = get_npc_attr(npc, 1)
      local hp_max = get_npc_attr(npc, 4)
      local buff_count = math.floor((hp_max - hp_cur) / hp_max * 6.66)
      if BuffLevel == buff_count or buff_count < 1 then
        return
      end
      abort_magic_by_id(npc, 10220212)
      cast_magic(npc, npc, 10220212, buff_count)
      if destinies4 then
        abort_magic_by_id(npc, 10220310)
        cast_magic(npc, npc, 10220310, buff_count)
      end
      BuffLevel = buff_count
    end
    
    role:insertFun("on_frame", traces1_atkbuff)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    set_keyframe_enable_by_tag(role.npc, skills.atk4.id, 1, false, true)
    set_keyframe_enable_by_tag(role.npc, skills.counter.id, 1, false, true)
    misIds.atkmissile = 10010220412
    misIds.countermissile = 10010221212
    set_keyframe_enable_by_tag(role.npc, skills.atk4.id, 2, true, true)
    set_keyframe_enable_by_tag(role.npc, skills.counter.id, 2, true, true)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function healup(role, target, magic_id)
      local hp_cur = get_npc_attr(npc, 1)
      
      local hp_max = get_npc_attr(npc, 4)
      local hp_per = math.floor(hp_cur / hp_max * 10)
      if 10220261 == magic_id and hp_per < 5.5 then
        cast_magic(npc, npc, 10220213, 0)
      elseif 1022028 == magic_id and hp_per < 5.5 then
        cast_magic(npc, npc, 10220214, 0)
      end
    end
    
    tool.insert(role, "before_damage_target", healup)
  end
  destinies[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function energy_add1(role, target, magic_id)
      if 1 == role.fury_status and check_magic(target, magicIds.magic_butterflycheck) then
        cast_magic(role.npc, role.npc, 10220305, 0)
      end
    end
    
    local function energy_add2(role, npc)
      if 1 == role.fury_status and check_magic(npc, magicIds.magic_butterflycheck) then
        cast_magic(role.npc, role.npc, 10220306, 0)
      end
    end
    
    tool.insert(role, "before_damage_target", energy_add1)
    tool.insert(role, "on_npc_hp_zero", energy_add2)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function atkup(role, target, magic_id)
      if 1022027 == magic_id or 1022028 == magic_id then
        cast_magic(npc, npc, 10220308, 0)
      end
    end
    
    tool.insert(role, "before_damage_target", atkup)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function energy_check(role)
      local energy_before = role.energy_attr
      
      role.energy_attr = get_npc_attr(role.npc, 74)
      if energy_before < role.energy_attr then
        cast_magic(npc, npc, magicIds.magic_spweapon, 0)
      end
    end
    
    local function energy_add(role)
      cast_magic(npc, npc, magicIds.magic_spweapon, 0)
    end
    
    tool.insert(role, "on_frame", energy_check)
    tool.insert(magics.magic_destinies1_furyUp1, "onBegin", energy_add)
    tool.insert(magics.magic_destinies1_furyUp2, "onBegin", energy_add)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    destinies4 = true
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    destinies5 = true
    role:add_reborn_chance(magicIds.magic_destinies5.healing)
    
    local function not_die(role, npc, magic_id, heal_val)
      if magic_id == magicIds.magic_destinies5.healing then
        cast_magic(role.npc, role.npc, magicIds.magic_destinies5.WuDi, 0)
        cast_magic(role.npc, role.npc, magicIds.magic_destinies5.coolDown, 0)
      end
    end
    
    tool.insert(role, "after_heal_self", not_die)
    
    local function cd()
      if not check_npc_die(role.npc) then
        role:add_reborn_chance(magicIds.magic_destinies5.healing)
      end
    end
    
    tool.insert(magics.magic_destinies5.coolDown, "onEnd", cd)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local lv = spWeapon.lv
    local add_butterfly = false
    
    local function explosion(role, npc)
      if npc == role.npc then
        return
      end
      if check_magic(npc, magicIds.magic_butterflycheck) then
        local pos = get_npc_pos(npc)
        cast_missile3(role.npc, npc, pos.x, pos.z, misIds.magic_traces4Mis[2], lv)
        cast_missile3(role.npc, npc, pos.x, pos.z, misIds.magic_traces4Mis[1], lv)
        add_butterfly = true
      end
    end
    
    local function butterfly(role, target, magic_id)
      if magic_id == magicIds.magic_butterflyHit and add_butterfly then
        if role.BFcheck_target ~= target and role.BFcheck_target ~= nil then
          abort_magic_by_id(role.BFcheck_target, magicIds.magic_butterflycheck)
        end
        cast_magic(npc, target, magicIds.magic_butterflycheck, 0)
        add_butterfly = false
      end
    end
    
    tool.insert(role, "on_npc_hp_zero", explosion)
    tool.insert(role, "before_damage_target", butterfly)
  end
  
  function skActs.born.start(born, event)
    if spWeapon.lv <= 0 then
      set_keyframe_enable(role.npc, 10010225003, true, true)
      set_keyframe_enable(role.npc, 10010225004, true, true)
      set_keyframe_enable(role.npc, 10010225007, false, true)
      set_keyframe_enable(role.npc, 10010225008, false, true)
    elseif spWeapon.lv > 0 then
      set_keyframe_enable(role.npc, 10010225003, false, true)
      set_keyframe_enable(role.npc, 10010225004, false, true)
      set_keyframe_enable(role.npc, 10010225007, true, true)
      set_keyframe_enable(role.npc, 10010225008, true, true)
    end
    born.base.start(born, event)
  end
end

function LiChi.onRampageStart(role, stage)
  link_up = true
  fury_num = math.ceil(get_npc_attr(role.npc, 74))
  cast_magic(role.npc, role.npc, 10220821, 0)
end

function LiChi.onRampageEnd(role, stage)
  if 0 == role.fury_status then
    cast_magic(role.npc, role.npc, 10220822, fury_num)
    local energy = get_npc_attr(role.npc, 74)
    local btns = role.btns
    local icons = role.icons
    if energy < 100 and btns.sk2.icon == icons.switchFury then
      btns.sk2:setIcon(icons.thunderDao1)
    end
  end
  link_up = false
  link_fury = false
end

function LiChi.before_damage_target(role, target, magic_id)
  if check_magic(target, 1022053) then
    cast_magic(role.npc, role.npc, 102205001, 0)
  end
end

function LiChi.changeFuryController(role)
  set_npc_controller(role.npc, 1)
  abort_magic_by_id(role.npc, 10220601)
  abort_magic_by_id(role.npc, 1022031)
  cast_magic(role.npc, role.npc, 1022061, 0)
  cast_magic(role.npc, role.npc, 1022030, 0)
  if role.spWeapon.lv > 0 then
    cast_magic(role.npc, role.npc, 10220402, role.spWeapon.lv)
  end
  if role.destinyLv >= 1 then
    cast_magic(role.npc, role.npc, 10220307, 0)
  end
  if link_up then
    link_fury = true
  end
  role.fury_status = 1
  local btns = role.btns
  local icons = role.icons
  btns.sk2:setIcon(icons.switchBack)
  btns.sk1:setIcon(icons.butterFly2)
  btns.atk:setIcon(icons.furyAtk)
  btns.dash:setIcon(icons.furyDash)
  role.baseActs.wander.tick = role.fury_wander_tick
end

function LiChi.changeBackController(role)
  if 0 == role.fury_status then
    return
  end
  set_npc_controller(role.npc, 0)
  if role.destinyLv >= 1 then
    abort_magic_by_id(role.npc, 10220307)
  end
  if link_fury then
    if link_up then
      cast_magic(role.npc, role.npc, 10220821, 0)
    else
      cast_magic(role.npc, role.npc, 10220822, fury_num)
    end
  end
  cast_magic(role.npc, role.npc, 1022031, 0)
  cast_magic(role.npc, role.npc, 1022074, 0)
  cast_magic(role.npc, role.npc, 1022075, 0)
  abort_magic_by_id(role.npc, 1022030)
  abort_magic_by_id(role.npc, 10220402)
  abort_magic_by_id(role.npc, 10220403)
  abort_magic_by_id(role.npc, 10220603)
  abort_magic_by_id(role.npc, 1022066)
  local btns = role.btns
  local icons = role.icons
  role.fury_status = 0
  btns.sk1:setIcon(icons.butterFly1)
  btns.sk2:setIcon(icons.thunderDao1)
  btns.atk:setIcon(icons.atk)
  btns.dash:setIcon(icons.dash)
  role.baseActs.wander.tick = role.base_wander_tick
  if 0 ~= role.furyCheckMis_1 then
    local misPos = get_missile_pos(role.furyCheckMis_1)
    cast_missile3(role.npc, nil, misPos.x, misPos.z, 10010224225, 1, misPos.x, misPos.z, misPos.y, misPos.y, misPos.x, misPos.z)
    remove_missile(role.furyCheckMis_1)
  elseif 0 ~= role.furyCheckMis_2 then
    local misPos = get_missile_pos(role.furyCheckMis_2)
    cast_missile3(role.npc, nil, misPos.x, misPos.z, 10010224225, 1, misPos.x, misPos.z, misPos.y, misPos.y, misPos.x, misPos.z)
    remove_missile(role.furyCheckMis_2)
  end
end

function LiChi.fury_wander_tick(furyWander)
  local role = furyWander.role
  local curFrame = Global.frame_id
  if curFrame < role.searchFrame_fury then
    return
  end
  role.searchFrame_fury = curFrame + role.searchInterval
  local autoAct = role:choose_auto_atk()
  if autoAct then
    autoAct:try()
    return
  end
  if not role.indiMgr:isActive() then
    role:setTarget()
  end
end

function LiChi.furyStatusChange(role)
  local energy = get_npc_attr(role.npc, 74)
  if 1 == role.fury_status then
    if not link_up then
      cast_magic(role.npc, role.npc, 1022083, 0)
    else
      cast_magic(role.npc, role.npc, 10220831, 0)
    end
    if is_cast_skill_time(role.npc, 100102248, 1) then
      return
    end
    if 0 == energy and not is_cast_skill_time(role.npc, 100102240, 1) then
      role.skActs.switchBack:try()
    end
    if check_magic(role.npc, 1022084) or check_magic(role.npc, 1022085) then
      abort_magic_by_id(role.npc, 1022084)
      if role:isInStay() then
        role.baseActs.wander.tick = role.base_wander_tick
        role:toBack()
        return
      end
    end
  elseif 0 == role.fury_status then
    local btns = role.btns
    local icons = role.icons
    if energy >= 100 and btns.sk2.icon ~= icons.switchFury and btns.sk2.icon ~= icons.switchBack then
      local btns = role.btns
      local icons = role.icons
      btns.sk2:setIcon(icons.switchFury)
    end
    if check_magic(role.npc, 1022084) or check_magic(role.npc, 1022085) then
      abort_magic_by_id(role.npc, 1022084)
      if role:isInStay() then
        role.baseActs.wander.tick = role.base_wander_tick
        role:toBack()
        return
      end
    end
  end
end

function LiChi.on_hero_enter_ground_state(role, npc)
  role.base.on_hero_enter_ground_state(role, npc)
  if 0 == role.fury_status then
    return
  end
  if npc == role.npc then
    if 0 ~= role.furyCheckMis_1 then
      local misPos = get_missile_pos(role.furyCheckMis_1)
      cast_missile3(role.npc, nil, misPos.x, misPos.z, 10010224225, 1, misPos.x, misPos.z, misPos.y, misPos.y, misPos.x, misPos.z)
      remove_missile(role.furyCheckMis_1)
    elseif 0 ~= role.furyCheckMis_2 then
      local misPos = get_missile_pos(role.furyCheckMis_2)
      cast_missile3(role.npc, nil, misPos.x, misPos.z, 10010224225, 1, misPos.x, misPos.z, misPos.y, misPos.y, misPos.x, misPos.z)
      remove_missile(role.furyCheckMis_2)
    end
    cast_magic(role.npc, role.npc, 1022082, 0)
  end
end

function LiChi.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if npc == role.npc and not is_showup then
    role:changeBackController()
    abort_magic_by_id(role.npc, 1022066)
  end
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
end

function LiChi.on_frame_ground(role)
  role.furyStatusChange(role)
  role.base.on_frame_ground(role)
end

function LiChi.on_frame_background(role)
  role.base.on_frame_background(role)
  role.furyStatusChange(role)
end

function LiChi.on_frame(role)
  role.base.on_frame(role)
  role.furyStatusChange(role)
end

function LiChi.on_controller_change(npc, extra_controller_path)
  if npc.id == 1001022 then
    if "H1001022.overrideController" == extra_controller_path then
      controller_status = 0
    elseif "H1001022_S.overrideController" == extra_controller_path then
      controller_status = 1
    end
  end
end

function LiChi.choose_auto_atk(role, viscous)
  viscous = viscous or 10
  local searchRange = role.autoAtkSearch
  searchRange.directional.viscous.weight = viscous
  searchRange.noInput.viscous.weight = viscous
  local target = role:searchNpc(searchRange)
  if 0 == controller_status then
    return
  elseif not target then
    return
  elseif 5 == get_role_kind(target) or 6 == get_role_kind(target) then
    return
  end
  role:setTarget(target)
  local dist = get_npc_distance(role.npc, 1, target, true)
  local skActs = role.skActs
  local atk = skActs.furyAtk
  local start1 = skActs.furyStart1
  if dist < atk.search.maxDis then
    return atk
  else
    return start1
  end
end

function LiChi.auto_atk_custom_weight(role, npc)
  if check_magic(npc, 1022053) then
    return 40
  else
    return 0
  end
end

return LiChi
