local roleBase = import("character.base.role_base")
local Ereshan = Util.create_child_mt(roleBase)
local misIds = {}
local magicIds = {ult_camera_magic = 1008992}

function Ereshan._init(role, npc)
  role.npc = npc
  local misIds_1 = {
    sickle = 10010080913,
    sickleAir = 10010081506,
    punish = {
      10010080602,
      10010080702,
      10010080802
    },
    exPunish = {
      10010081117,
      10010081113,
      10010081119
    },
    exPunish4 = {
      10010083303,
      10010083308,
      10010083315
    },
    ultFinChain = 10010081121,
    ultFinPull = 10010081114,
    ultDashDamage = 10010081129,
    sicklePre = 10010081101,
    punish4LastHit = 10010083302,
    area = 10010081001,
    linkQte = 10010083501
  }
  local magicIds_1 = {
    air = 1008016,
    ground = 1008017,
    punishCancel = 1008079,
    punish1Damage = 1008507,
    punish2Damage = 1008508,
    punish3Damage = 1008509,
    punish4Damage1 = 1008535,
    punish4Damage2 = 1008536,
    punishDamageFix = 1008413,
    punishDamageFix2 = 1008439,
    exSlashDamage = {
      1008524,
      1008525,
      1008526
    },
    exSlashDamageFix = 1008416,
    getSP = 1008803,
    resetSP = 1008804,
    getMultSP = 1008809,
    getExSP = 1008423,
    getExSP2 = 1008417,
    punishMultCamOffset = 1008065,
    punishMultRange = 1008307,
    arashiCameraPull = 1008064,
    arashiDamage = 1008510,
    arashiDamageFix = 1008415,
    areaDamage = 1008511,
    areaVictimTag = 1008426,
    areaVictimTimer = 1008424,
    linkQteDamage = 1008539,
    ultDamage = 1008534,
    ultFixEnemy = 1008073,
    ultFinHit = 1008997,
    ultFinDamage = 1008527,
    ultFinDamageBuff = 1008422,
    damageFixVictim = 1008425,
    damageFixVictimSpWeapon = {
      1008433,
      1008434,
      1008435,
      1008436,
      1008437
    },
    changeSickleTime = 41021006,
    flash_fade = 1008035,
    trace2_defense = 1008438,
    sickle_cancle_energy = 1008810
  }
  for k, v in pairs(misIds_1.exPunish4) do
    set_keyframe_enable(role.npc, v, false, true)
  end
  roleBase._init(role, misIds_1, magicIds_1)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local traces = role.traces
  traces[1008401] = 1
  traces[1008402] = 2
  traces[1008403] = 3
  traces[1008404] = 4
  traces[1008405] = 5
  local destinies = role.destinies
  destinies[1008406] = 1
  destinies[1008407] = 2
  destinies[1008408] = 3
  destinies[1008409] = 4
  destinies[1008410] = 5
  local spWeapon = role.spWeapon
  skActs.atk3.tarPos = Const.NIL_FUN
  skActs.counter.reset = {timer = 0, delay = 0.2}
  
  function skActs.counter.onCastTime(counter)
    counter.reset.timer = get_npc_time(counter.role.npc) + counter.reset.delay
    counter.base.onCastTime(counter)
  end
  
  skActs.atk2.counter = skActs.counter
  
  function skActs.atk2.isReady(atk2)
    if not atk2.base.isReady(atk2) then
      return false
    end
    local role = atk2.role
    local roleAct = role.skAct
    if (roleAct == atk2.preAtk or roleAct == atk2.counter) and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    else
      return false
    end
  end
  
  local tagMgr = {}
  role.tagMgr = tagMgr
  tagMgr.role = role
  tagMgr.debuffMagic = magicIds_1.areaVictimTag
  tagMgr.timerMagic = magicIds_1.areaVictimTimer
  tagMgr.targets = {}
  
  function tagMgr.clearTargets(mgr)
    return UtilTable.clear_map(mgr.targets)
  end
  
  function tagMgr.add(mgr, target)
    return table.insert(mgr.targets, target)
  end
  
  function tagMgr.remove(mgr, target)
    if target == mgr.victim then
      mgr.victim = nil
    end
    return UtilTable.list_delete_by_value(mgr.targets, target)
  end
  
  function tagMgr.abort(mgr)
    local victim = mgr.victim
    if victim then
      abort_magic_by_id(victim, mgr.debuffMagic)
    end
    mgr.victim = nil
    mgr.role:abortMagic(mgr.timerMagic)
  end
  
  function tagMgr.clear(mgr)
    mgr:clearTargets()
    mgr:abort()
  end
  
  function tagMgr.init(mgr)
    mgr:abort()
    local victim = mgr:chooseVictim()
    if victim then
      role:addMagic(mgr.timerMagic)
    end
    return mgr:cast(victim)
  end
  
  function tagMgr.chooseVictim(mgr)
    local maxHp = 0
    local victim, hp
    for _, npc in pairs(mgr.targets) do
      if npc_is_destroy(npc) then
      else
        hp = get_npc_attr(npc, 1)
        if maxHp < hp then
          maxHp = hp
          victim = npc
        end
      end
    end
    return victim
  end
  
  function tagMgr.cast(mgr, victim, noCam)
    if not victim then
      return
    end
    local role = mgr.role
    cast_magic(role.npc, victim, mgr.debuffMagic)
    mgr.victim = victim
    if noCam then
      return
    end
    local dis = get_npc_distance(role.npc, 1, victim, true)
    role:change_follow_target(1, victim, {
      9999,
      0,
      {
        x = 0,
        y = dis * 12.5,
        z = 0
      },
      1,
      10,
      0.135
    })
    role:doAfter(mgr.resetCam, 0.8, true)
  end
  
  function tagMgr.isVictim(tagMgr, npc)
    return npc == tagMgr.victim
  end
  
  function tagMgr.resetCam(role)
    change_focus_follow_speed(6)
    return role:change_follow_target(4)
  end
  
  magics.areaVictimTimer.tagMgr = tagMgr
  
  function magics.areaVictimTimer.onEnd(areaVictimTimer, casterNpc, target)
    return areaVictimTimer.tagMgr:abort()
  end
  
  do
    local function damagefix(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      local tag = role.magics.areaVictimTag
      
      local lv = role.spWeapon.lv
      if check_magic(target, tag.id) then
        if lv > 0 then
          cast_magic(npc, npc, role.magics.damageFixVictimSpWeapon[lv].id)
        else
          cast_magic(npc, npc, role.magics.damageFixVictim.id)
        end
      end
    end
    
    role:insertFun("before_damage", damagefix)
    
    function tagMgr.searchWeight100(role, npc)
      if role.tagMgr:isVictim(npc) then
        return 100
      end
    end
    
    skActs.punishMult.search:setCustom(tagMgr.searchWeight100)
    icons.punish4.indi.search:setCustom(tagMgr.searchWeight100)
    
    function tagMgr.searchWeight10(role, npc)
      if role.tagMgr:isVictim(npc) then
        return 10
      end
    end
    
    skActs.punish.search:setCustom(tagMgr.searchWeight10)
    icons.arashi.indi.search:setCustom(tagMgr.searchWeight10)
    
    function tagMgr.searchWeight100Ult(role, npc)
      if not role.tagMgr:isVictim(npc) then
        return 0
      end
      if UtilTable.table_find(role.ultTargets, npc) then
        return
      end
      return 100
    end
    
    skActs.ult.search:setCustom(tagMgr.searchWeight100Ult)
    skActs.ultFast.search:setCustom(tagMgr.searchWeight100Ult)
  end
  
  function magics.air.onBegin(air, casterNpc, target, magicId)
    local role = air.unit
    role.isInAir = true
  end
  
  function magics.ground.onBegin(ground, casterNpc, target, magicId)
    local role = ground.unit
    role.isInAir = false
  end
  
  function skills.arashiAir.isReady(arashiAir)
    if not arashiAir.base.isReady(arashiAir) then
      return false
    end
    if not arashiAir.role.isInAir then
      return false
    end
    return true
  end
  
  role.sickleLiveTimeOptions = {0.6, 0.9}
  role.sickleLiveTime = role.sickleLiveTimeOptions[1]
  
  function magics.changeSickleTime.onBegin(changeSickleTime, casterNpc, target)
    local role = changeSickleTime.unit
    role.sickleLiveTime = role.sickleLiveTimeOptions[2]
  end
  
  function magics.changeSickleTime.onEnd(changeSickleTime, casterNpc, target)
    local role = changeSickleTime.unit
    role.sickleLiveTime = role.sickleLiveTimeOptions[1]
  end
  
  do
    local function stopSickle(role)
      local sickleInst = role.misInsts.sickle
      
      if not sickleInst then
        return
      end
      change_missile_move_params(sickleInst, 0, 0)
    end
    
    local function sickleOnBegin(sickle, sickleInst, owner, pos_x, pos_z)
      local role = sickle.unit
      local sk1 = role.btns.sk1
      local punish = role.icons.punish
      sk1:setIcon(punish)
      role.misInsts.sickle = sickleInst
      role:doAfter(stopSickle, role.sickleLiveTime, true)
    end
    
    misLogics.sickle.onBegin = sickleOnBegin
    misLogics.sickleAir.onBegin = sickleOnBegin
    
    local function sickleOnCollide(sickle, sickleInst, owner, obsType)
      change_missile_move_params(sickleInst, 0, 0)
    end
    
    misLogics.sickle.onCollideObs = sickleOnCollide
    misLogics.sickleAir.onCollideObs = sickleOnCollide
    
    function skActs.arashi.onHit(arashi, casterNpc, hitTarget, hitType, skill, missile)
      local role = arashi.role
      if missile.missile_id == misIds_1.sickle or missile.missile_id == misIds_1.sickleAir then
        if not missile.d_firstHitEnd then
          missile.d_firstHitEnd = true
          change_missile_move_params(missile, 7.5, 0)
        else
          change_missile_move_params(missile, 0, 0)
        end
      end
    end
    
    local function sickleOnEnd(sickle, sickleInst, owner, pos_x, pos_z)
      local role = sickle.unit
      local arashi = role.icons.arashi
      local sk1 = role.btns.sk1
      local skAct = role.skAct
      if sk1.icon.name == "punish" then
        sk1:setIcon(arashi, 0.5)
      end
      if skAct ~= role.skActs.punish then
        cast_magic(role.npc, role.npc, magics.sickle_cancle_energy.id, 0)
      else
        skAct.sickle = nil
        skAct.sickleEndPos = get_missile_pos(sickleInst)
      end
      local cameraPull = role.magics.arashiCameraPull
      abort_magic_by_id(role.npc, cameraPull.id)
      role.misInsts.sickle = nil
    end
    
    misLogics.sickle.onEnd = sickleOnEnd
    misLogics.sickleAir.onEnd = sickleOnEnd
  end
  
  function skills.punishStart.isReady(punishStart, skAct)
    if not punishStart.base.isReady(punishStart, skAct) then
      return false
    end
    if punishStart.role.isInAir then
      return false
    end
    return true
  end
  
  role.punishNum = 0
  do
    local function punishOnBegin(punish)
      punish.base.onBegin(punish)
      
      local role = punish.role
      role.punishNum = role.punishNum + 1
    end
    
    skills.punish1.onBegin = punishOnBegin
    skills.punish2.onBegin = punishOnBegin
    skills.punish3.onBegin = punishOnBegin
    
    function skills.punish1.isReady(punish1, skAct)
      if not punish1.base.isReady(punish1, skAct) then
        return false
      end
      local role = punish1.role
      if 0 ~= role.punishNum % 3 then
        return false
      end
      return true
    end
    
    function skills.punish2.isReady(punish2, skAct)
      if not punish2.base.isReady(punish2, skAct) then
        return false
      end
      local role = punish2.role
      if 1 ~= role.punishNum % 3 then
        return false
      end
      return true
    end
  end
  
  function skills.punish_stop.isReady(punish_stop, skAct)
    if not punish_stop.base.isReady(punish_stop, skAct) then
      return false
    end
    if skAct and not skAct.bSinglePunish then
      return false
    end
    if skAct.atkTarget then
      return false
    end
    return true
  end
  
  do
    local function punishStartFunc(skill, skAct)
      local tpPos, turnPos = skAct:getTpPos()
      
      local role = skill.role
      role:tp(tpPos, nil, turnPos)
      local sickle = skAct.sickle
      if sickle then
        remove_missile(sickle, true)
      end
      role:abortMagic(role.magics.flash_fade.id)
      return skill.base.start(skill, skAct)
    end
    
    skills.punish1.start = punishStartFunc
    skills.punish2.start = punishStartFunc
    skills.punish3.start = punishStartFunc
    skills.punish_stop.start = punishStartFunc
  end
  magics.punishCancel.list = {
    punish = skActs.punish,
    punishMult = skActs.punishMult,
    arashi = skActs.arashi,
    arashiAir = skActs.arashiAir
  }
  
  function magics.punishCancel.onBegin(punishCancel, casterNpc, target)
    local curSkAct = punishCancel.unit.skAct
    if not punishCancel.list[curSkAct.name] then
      return
    end
    curSkAct.onCastTime(curSkAct)
  end
  
  skActs.punish.bSinglePunish = true
  
  function skActs.punish.tarPos(punish, event)
    local role = punish.role
    local sickle = role.misInsts.sickle
    local sicklePos = sickle and get_missile_pos(sickle)
    punish.base.tarPos(punish, event, sicklePos)
    punish.sickle = sickle
    return sicklePos
  end
  
  function skActs.punish.getSicklePos(punish)
    if punish.sickle then
      return get_missile_pos(punish.sickle)
    else
      return punish.sickleEndPos
    end
  end
  
  function skills.punishStart.onBefEnd(punishStart)
    local act = punishStart.skAct
    if act.bSinglePunish then
      punishStart:updateAtkTar(nil, act:getSicklePos())
    end
    return punishStart.base.onBefEnd(punishStart)
  end
  
  function skActs.punish.getTpPos(punish)
    local tpPos, turnPos
    local target = punish.atkTarget
    local role = punish.role
    local sicklePos = punish:getSicklePos()
    if target then
      local tarPos = target:get_pos_vec3()
      tpPos = role:approachPos(tarPos, nil, 2, sicklePos)
      turnPos = tarPos
    else
      if not sicklePos then
        role:debugOutput("punish is called without a valid sickle pos")
      end
      tpPos = sicklePos
    end
    return tpPos, turnPos
  end
  
  function skills.punish_stop.onBegin(punish_stop)
    punish_stop.role:addMagic(magics.sickle_cancle_energy.id, 0)
    return punish_stop.base.onBegin(punish_stop)
  end
  
  skActs.punish.getSP = magics.getSP
  
  function skActs.punish.onHit(punish, casterNpc, hitTarget, hitType, skill, missile)
    local role = punish.role
    local hitcount = missile.d_hitcount
    hitcount = hitcount and hitcount + 1 or 1
    missile.d_hitcount = hitcount
    if 1 == hitcount then
      cast_magic(role.npc, role.npc, punish.getSP.id)
    end
  end
  
  function skActs.punishMult.getTpPos(punishMult)
    local role = punishMult.role
    local target = punishMult.atkTarget
    if target then
      return get_npc_offset_position(target, nil, math.random(60, 240), 2), target:get_pos_vec3()
    else
      local tpPos = role.npc:get_pos_vec3()
      local inputDir = role:inputDir()
      local turnPos = inputDir and tpPos + inputDir * 10
      return nil, turnPos
    end
  end
  
  function skActs.punishMult.onBefTime(punishMult)
    local role = punishMult.role
    if not role:isRampage() then
      role.spBar:decrease(1)
    end
    return punishMult.base.onBefTime(punishMult)
  end
  
  function skActs.punishMult.onCastTime(punishMult, retainCache, ignoreIcon)
    if not role:isRampage() and 0 == role.spBar:getNum() then
      local sk1 = role.btns.sk1
      local sk2 = role.btns.sk2
      local arashi = role.icons.arashi
      local punish = role.icons.punish
      local punish4 = role.icons.punish4
      local area = role.icons.area
      if role.misInsts.sickle then
        sk1:setIcon(punish)
      else
        sk1:setIcon(arashi)
      end
      if not punish4.isEnhance then
        cast_magic(role.npc, role.npc, magics.resetSP.id)
        sk2:setIcon(area)
        UtilTable.clear_map(punishMult.victims)
      end
      local magics = role.magics
      abort_magic_by_id(role.npc, magics.punishMultCamOffset.id)
      abort_magic_by_id(role.npc, magics.punishMultRange.id)
      role:hideSpBar()
    end
    return punishMult.base.onCastTime(punishMult, retainCache, ignoreIcon)
  end
  
  skActs.punishMult.getSP = magics.getMultSP
  skActs.punishMult.sk2 = btns.sk2
  skActs.punishMult.punish4 = icons.punish4
  
  function skActs.punishMult.onHit(punishMult, casterNpc, hitTarget, hitType, skill, missile)
    local hitcount = missile.d_hitcount
    hitcount = hitcount and hitcount + 1 or 1
    missile.d_hitcount = hitcount
    punishMult.lastHitTar = hitTarget
    if 1 == hitcount and punishMult.sk2.icon == punishMult.punish4 then
      cast_magic(role.npc, role.npc, punishMult.getSP.id)
    end
  end
  
  function icons.punish4.updateEnhance(punish4)
    punish4.isEnhance = punish4.isEnable
  end
  
  skActs.punish4.flashPos = vec3.New()
  
  function skActs.punish4.tarPos(punish4, event)
    local tarPos = punish4.base.tarPos(punish4, event)
    punish4.flashPos:SetA(tarPos)
    return tarPos
  end
  
  function skActs.punish4.onBegin(punish4)
    local role = punish4.role
    role:tp(punish4.flashPos, 15)
    role:abortMagic(magics.flash_fade.id)
    abort_magic_by_id(role.npc, magics.flash_fade.id)
    local target = role.target
    role:change_follow_target(1, target, {
      9999,
      0,
      {
        x = 0,
        y = 12.5,
        z = 0
      },
      1,
      10,
      0.135
    })
    role:doAfter(function(role)
      change_focus_follow_speed(6)
      role:change_follow_target_new(4)
    end, -1.4, true)
    return punish4.base.onBegin(punish4)
  end
  
  skActs.punish4.punishMult = skActs.punishMult
  
  function skActs.punish4.onCastTime(punish4, retainCache, ignoreIcon)
    local sk2 = role.btns.sk2
    local area = role.icons.area
    if 0 == role.spBar:getNum() then
      cast_magic(role.npc, role.npc, magics.resetSP.id)
      sk2:setIcon(area)
      local punishMult = punish4.punishMult
      UtilTable.clear_map(punishMult.victims)
    end
    return punish4.base.onCastTime(punish4, retainCache, ignoreIcon)
  end
  
  function icons.area.updateEnhance(area)
    area.isEnhance = area.isEnable
  end
  
  skActs.area.tagMgr = tagMgr
  skActs.area.punishMultAct = skActs.punishMult
  
  function skActs.area.onBegin(area)
    area.tagMgr:clearTargets()
    area.punishMultAct.search:clearTarRecord()
    return area.base.onBegin(area)
  end
  
  icons.punishMult.durationCount = role.npc.character_cfg.SpBarPointNum
  skActs.area.punishMult = icons.punishMult
  skActs.area.punish4 = icons.punish4
  skActs.area.sk1 = btns.sk1
  skActs.area.sk2 = btns.sk2
  
  function skActs.area.onCastTime(area)
    area.sk1:setIcon(area.punishMult)
    area.sk2:setIcon(area.punish4)
    area.base.onCastTime(area)
    role.spBar:increase(icons.punishMult.durationCount)
    role:showSpBar()
    cast_magic(role.npc, role.npc, magics.punishMultCamOffset.id)
    cast_magic(role.npc, role.npc, magics.punishMultRange.id)
  end
  
  function skActs.area.onBreak(area, tarAct)
    local role = area.role
    if area.isBefOver and not area.isCastOver then
      area.sk1:setIcon(area.punishMult)
      area.sk2:setIcon(area.punish4)
      role.spBar:increase(icons.punishMult.durationCount)
      role:showSpBar()
      cast_magic(role.npc, role.npc, magics.punishMultCamOffset.id)
      cast_magic(role.npc, role.npc, magics.punishMultRange.id)
    end
    area.base.onBreak(area, tarAct)
  end
  
  misLogics.area.tagMgr = tagMgr
  
  function misLogics.area.onHit(area, misInst, casterNpc, hitTarget, hitType, skill, partNpc)
    return area.tagMgr:add(hitTarget)
  end
  
  function misLogics.area.onEnd(area, misInst, caster, posX, posZ)
    return area.tagMgr:init()
  end
  
  misLogics.linkQte.tagMgr = tagMgr
  misLogics.linkQte.onHit = misLogics.area.onHit
  misLogics.linkQte.onEnd = misLogics.area.onEnd
  role.ultTargets = {}
  skActs.ult.targets = role.ultTargets
  skActs.ult.count = 0
  skActs.ult.maxNum = 5
  skActs.ultFast.targets = role.ultTargets
  skActs.ultFast.count = 0
  skActs.ultFast.maxNum = 5
  
  function skActs.ult.start(ult, event)
    UtilTable.clear_map(ult.targets)
    ult.startPos = get_npc_pos(ult.role.npc)
    ult.count = 0
    ult.search:clearTarRecord()
    return ult.base.start(ult, event)
  end
  
  skActs.ultFast.start = skActs.ult.start
  
  function skills.ultStart.onBegin(ultStart)
    local ult = ultStart.skAct
    if ult:isUltFast() then
      set_keyframe_enable_by_tag(role.npc, 100100819, 1, false, true)
      skills.ultDash.ult = skActs.ultFast
    else
      set_keyframe_enable_by_tag(role.npc, 100100819, 1, true, true)
      skills.ultDash.ult = skActs.ult
    end
  end
  
  function skills.ultDash.isReady(ultDash, skAct)
    if not ultDash.base.isReady(ultDash) then
      return false
    end
    local ult = skAct
    if ult.count >= ult.maxNum then
      return false
    end
    local target = ultDash:searchTar()
    if not target then
      return false
    end
    ultDash.dashTarget = target
    table.insert(ult.targets, target)
    return true
  end
  
  function skills.ultDash.getTpPos(ultDash)
    local target = ultDash.dashTarget
    if not target then
      return ultDash
    end
    return get_npc_offset_position(target, nil, math.random(150, 210), 6), target:get_pos_vec3()
  end
  
  skills.ultDash.damageMis = misLogics.ultDashDamage
  
  function skills.ultDash.start(ultDash, ultSkAct)
    ultSkAct.count = ultSkAct.count + 1
    local role = ultDash.role
    local target = ultDash.dashTarget
    local tarPos = get_npc_pos(target)
    change_focus_follow_speed(1)
    cast_missile(role.npc, target, tarPos.x, tarPos.z, ultDash.damageMis.id, 0, nil, nil, nil, tarPos.y, tarPos.x, tarPos.z, nil, ultDash:skInfo())
    local tpPos, turnPos = ultDash:getTpPos()
    role:tp(tpPos, nil, turnPos)
    ultDash.base.start(ultDash, ultSkAct)
    target.d_hitCount = (target.d_hitCount or 0) + 1
  end
  
  skills.ultDash.fixEnemy = magics.ultFixEnemy
  
  function skills.ultDash.onEnd(ultDash)
    local ult = ultDash.skAct
    skills.ultDash.fixEnemy = magics.ultFixEnemy
    local target = ult.dashTarget
    local role = ultDash.role
    if target and not check_npc_die(target) then
      cast_magic(role.npc, target, ultDash.fixEnemy.id, 0)
    end
    ultDash.base.onEnd(ultDash)
  end
  
  skills.ultFin.facePos = {x = 0, z = 0}
  skills.ultFin.chain = misLogics.ultFinChain
  
  function skills.ultFin.start(ultFin, ultSkAct)
    change_focus_follow_speed(2)
    if ultSkAct.targets and #ultSkAct.targets >= 1 then
      local tpPos = ultSkAct.startPos
      local role = ultFin.role
      flash_to_pos(role.npc, tpPos.x, tpPos.z)
      local facePos = ultFin.facePos
      facePos.x = 0
      facePos.z = 0
      local targets = ultSkAct.targets
      local num = #targets
      for _, target in pairs(targets) do
        if target and not check_npc_die(target) then
          local tarPos = get_npc_pos(target)
          facePos.x = facePos.x + tarPos.x
          facePos.z = facePos.z + tarPos.z
          cast_missile(role.npc, target, tarPos.x, tarPos.z, ultFin.chain.id, 0, nil, nil, nil, nil, nil, nil, nil, ultFin:skInfo())
          target.d_isHitByEreshanUltDash = false
        end
      end
      facePos.x = facePos.x / num
      facePos.z = facePos.z / num
      local role = ultFin.role
      lookat_position(role.npc, facePos.x, facePos.z, true)
    end
    ultFin.base.start(ultFin, ultSkAct)
  end
  
  magics.ultFinHit.fixEnemy = magics.ultFixEnemy
  magics.ultFinHit.pullMissile = misLogics.ultFinPull
  
  function magics.ultFinHit.onBegin(ultFinHit, casterNpc, target, magicId)
    local role = ultFinHit.unit
    local targets = role.skAct.targets
    local ultFin = skills.ultFin
    local skLv = get_skill_lv(role.npc, ultFin.id) or 0
    for _, target in pairs(targets) do
      if target and not check_npc_die(target) then
        abort_magic_by_id(target, ultFinHit.fixEnemy.id)
        local pos = get_npc_pos(target)
        cast_missile(role.npc, target, pos.x, pos.z, ultFinHit.pullMissile.id, skLv, nil, nil, nil, pos.y, nil, nil, nil, ultFin:skInfo())
      end
    end
    cast_magic(role.npc, role.npc, magicIds.ult_camera_magic, 0)
  end
  
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    skActs.punish.getExSP = magics.getExSP
    skActs.punishMult.getMultSP = magics.getMultSP
    
    local function exSP(punish, casterNpc, hitTarget, hitType, skill, missile)
      local role = punish.role
      local hitcount = missile.d_hitcount
      if 1 == hitcount then
        cast_magic(role.npc, role.npc, punish.getExSP.id)
      end
    end
    
    tool.insert(skActs.punish, "onHit", exSP)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function defenseUp(role, npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if target == role.npc then
        local skAct_list = {
          punish = skActs.punish,
          
          punishMult = skActs.punishMult,
          punish4 = skActs.punish4
        }
        local curSkAct = role.skAct.name
        if skAct_list[curSkAct] then
          cast_magic(role.npc, role.npc, magics.trace2_defense.id)
        end
      end
    end
    
    role:insertFun("before_damage", defenseUp)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    magics.ultDamage.damageBuff = magics.ultFinDamageBuff
    magics.ultFinDamage.damageBuff = magics.ultFinDamageBuff
    
    local function damageFix(ultFinDamage, casterNpc, target, damageSign, damageType, targetCamp, changeLv, magicLv)
      local targetType = get_role_kind(target)
      if 3 ~= targetType and 4 ~= targetType then
        return
      end
      cast_magic(casterNpc, casterNpc, ultFinDamage.damageBuff.id, 0)
    end
    
    tool.insert(magics.ultDamage, "befDamage", damageFix)
    tool.insert(magics.ultFinDamage, "befDamage", damageFix)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageFix(punishDamage, casterNpc, target, damageSing, damageType, targetCamp, changeLv, magicLv)
      local role = punishDamage.unit
      
      cast_magic(casterNpc, casterNpc, role.magics.punishDamageFix.id)
    end
    
    tool.insert(magics.punish1Damage, "befDamage", damageFix)
    tool.insert(magics.punish2Damage, "befDamage", damageFix)
    tool.insert(magics.punish3Damage, "befDamage", damageFix)
    tool.insert(magics.punish4Damage1, "befDamage", damageFix)
    tool.insert(magics.punish4Damage2, "befDamage", damageFix)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local num = 2
    icons.punishMult.durationCount = icons.punishMult.durationCount + num
    role.spBar:expand(num)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    skills.punish1.extraMis = misLogics.exPunish[1]
    skills.punish2.extraMis = misLogics.exPunish[2]
    skills.punish3.extraMis = misLogics.exPunish[3]
    for k, v in pairs(misIds_1.exPunish4) do
      set_keyframe_enable(role.npc, v, true, true)
    end
    
    local function exSlash(punish, casterNpc, hitTarget, hitType, skill, missile)
      local hitcount = missile.d_hitcount
      local role = punish.role
      if 1 == hitcount then
        local pos = get_npc_offset_position(role.npc, nil, 0, 1)
        local extraMis = skill.extraMis
        if extraMis then
          cast_missile(role.npc, nil, pos.x, pos.z, extraMis.id, 0, nil, nil, nil, nil, nil, nil, nil, skill:skInfo())
        end
      end
    end
    
    tool.insert(skActs.punish, "onHit", exSlash)
    tool.insert(skActs.punishMult, "onHit", exSlash)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    magics.arashiDamage.buff = magics.arashiDamageFix
    
    local function arashiDamageFix(arashiDamage, casterNpc, target, damageSign, damageType, targetCamp, changeLv, magicLv)
      cast_magic(casterNpc, casterNpc, arashiDamage.buff.id)
    end
    
    tool.insert(magics.arashiDamage, "befDamage", arashiDamageFix)
    
    local function exSlashDamageFix(exSlashDamage, casterNpc, target, damageSign, damageType, targetCamp, changeLv, magicLv)
      local buff = exSlashDamage.unit.magics.exSlashDamageFix
      cast_magic(casterNpc, casterNpc, buff.id)
    end
    
    tool.insert(magics.exSlashDamage[1], "befDamage", exSlashDamageFix)
    tool.insert(magics.exSlashDamage[2], "befDamage", exSlashDamageFix)
    tool.insert(magics.exSlashDamage[3], "befDamage", exSlashDamageFix)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    skActs.punish.getExSP2 = magics.getExSP2
    skActs.punishMult.getExSP2 = magics.getExSP2
    
    local function exSP(punish, casterNpc, hitTarget, hitType, skill, missile)
      local role = punish.role
      local hitcount = missile.d_hitcount
      if 1 == hitcount then
        cast_magic(role.npc, role.npc, punish.getExSP2.id)
      end
    end
    
    skActs.punishMult.sk2 = btns.sk2
    skActs.punishMult.punish4 = icons.punish4
    
    local function MultexSP(punishMult, casterNpc, hitTarget, hitType, skill, missile)
      local role = punishMult.role
      local hitcount = missile.d_hitcount
      if 1 == hitcount and punishMult.sk2.icon == punishMult.punish4 then
        cast_magic(role.npc, role.npc, punishMult.getExSP2.id)
      end
    end
    
    tool.insert(skActs.punish, "onHit", exSP)
    tool.insert(skActs.punishMult, "onHit", MultexSP)
    
    local function damageFix(punishDamage, casterNpc, target, damageSing, damageType, targetCamp, changeLv, magicLv)
      local role = punishDamage.unit
      cast_magic(casterNpc, casterNpc, role.magics.punishDamageFix2.id)
    end
    
    tool.insert(magics.punish4Damage1, "befDamage", damageFix)
    tool.insert(magics.punish4Damage2, "befDamage", damageFix)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function victimMask(role, npc)
      if npc == role.tagMgr.victim then
        return -100
      else
        return 0
      end
    end
    
    role.skActs.area.search:setCustom(victimMask)
    
    local function buffPass(role, npc)
      local tagMgr = role.tagMgr
      if not tagMgr:isVictim(npc) then
        return
      end
      local target = role.skActs.area:searchTar()
      tagMgr:cast(target, true)
    end
    
    role:insertFun("on_npc_hp_zero", buffPass)
  end
end

function Ereshan.on_born_behavior(role)
  role.base.on_born_behavior(role)
  role:hideSpBar()
end

function Ereshan.onRampageStart(role, stage)
  local icons = role.icons
  local btns = role.btns
  btns.sk1:setIcon(icons.punishMult)
  btns.sk2:setIcon(icons.punish4)
  role.spBar:increase(icons.punishMult.durationCount)
  role:showSpBar()
end

function Ereshan.onRampageEnd(role, stage)
  local sk1 = role.btns.sk1
  local sk2 = role.btns.sk2
  local arashi = role.icons.arashi
  local punish = role.icons.punish
  local punish4 = role.icons.punish4
  local area = role.icons.area
  local magics = role.magics
  if role.misInsts.sickle then
    sk1:setIcon(punish)
  else
    sk1:setIcon(arashi)
  end
  if not punish4.isEnhance then
    cast_magic(role.npc, role.npc, magics.resetSP.id)
    sk2:setIcon(area)
  end
  local magics = role.magics
  abort_magic_by_id(role.npc, magics.punishMultCamOffset.id)
  abort_magic_by_id(role.npc, magics.punishMultRange.id)
  role:hideSpBar(true)
end

function Ereshan.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if npc ~= role.npc then
    return
  end
  local sickle = role.misInsts.sickle
  if sickle then
    remove_missile(sickle, true)
  end
  local magics = role.magics
  if is_showup and role.btns.sk1.icon.name == "punishMult" then
    cast_magic(role.npc, role.npc, magics.punishMultCamOffset.id)
    cast_magic(role.npc, role.npc, magics.punishMultRange.id)
  else
    abort_magic_by_id(role.npc, magics.punishMultCamOffset.id)
    abort_magic_by_id(role.npc, magics.punishMultRange.id)
  end
end

return Ereshan
