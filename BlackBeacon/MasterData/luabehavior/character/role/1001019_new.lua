local roleBase = import("character.base.role_base")
local Ninsar = Util.create_child_mt(roleBase)
local tool = import("common.tool")
local Me = import("character.role.1001019_Me")
Ninsar.Me = Me
Me.Ninsar = Ninsar
Ninsar.isListened = false

function Ninsar.me(role)
  local Me = role.Me
  local inst = Me.inst
  if not inst then
    return
  end
  if inst.isHiding then
    return
  end
  return inst
end

local misIds = {}
local magicIds = {
  shield_energy_magics = {
    base = {
      atk4NingSha = 1019020,
      atk4NingShaRamp = 10190213,
      atk1Me = 1019021,
      atk2Me = 1019022,
      atk3Me = 1019023,
      crushMe = 1019027
    },
    trace1 = {
      atk4NingSha = 1019028,
      atk4NingShaRamp = 1019028,
      atk3Me = 1019029
    },
    link = {
      atk1Me = 10190214,
      atk2Me = 10190215,
      atk3Me = 10190216,
      crushMe = 10190217
    }
  },
  trace2_atk_magic = 1019127,
  trace2_atkMax_magic = 10191271,
  destiny2_atkMax_magic = 10191272,
  trace4_shield_buff_magic = 1019126,
  destiny1_shield_buff_on_hit = 1019128,
  destiny3_shield_buff_magic = 1019137,
  destiny4_damageInc = 1019135,
  destiny5_shield_heal_magic = 1019125,
  spWeapon_shield_redu_on_hit = 1019139
}

function Ninsar._init(role, npc)
  role.Ninsar = Ninsar
  Ninsar.inst = role
  role.npc = npc
  local misIds_1 = {
    shield = 100101913201,
    area = 100101913205,
    ult = 100101914001,
    linkQte = 100101918301
  }
  local magicIds_1 = {
    crushTP = 1019044,
    transAtk4 = 1019047,
    crushMeltMe = 1019048,
    atk1Me = 1019031,
    atk2Me = 1019032,
    atk3Me = 1019033,
    heavyMe = 1019035,
    qteMe = 1019036,
    counterMe = 1019037,
    shield = 1019060,
    changeCrushDist = 30502
  }
  roleBase._init(role, misIds_1, magicIds_1)
  local magics = role.magics
  local misLogics = role.misLogics
  local skActs = role.skActs
  local skills = role.skills
  local icons = role.icons
  local Me = role.Me
  skActs.atk1.reset.delay = 0.45
  skActs.atk2.reset.delay = 0.5
  skActs.atk3.reset.delay = 0.5
  skActs.atk3.preActs = {
    [skActs.atk2] = true,
    [skActs.qte] = true
  }
  
  function skActs.atk3.isReady(atk3)
    if not atk3.base.isReady(atk3) then
      return false
    end
    local role = atk3.role
    local roleAct = role.skAct
    if atk3.preActs[roleAct] and role:now() < roleAct.reset.timer then
      return true
    else
      return false
    end
  end
  
  skActs.qte.reset = {timer = 0, delay = 0.2}
  
  function skActs.qte.onCastTime(qte)
    qte.reset.timer = qte.role:now() + qte.reset.delay
    qte.base.onCastTime(qte)
  end
  
  function magics.transAtk4.onBegin(transAtk4, caster, target)
    local role = transAtk4.unit
    local roleAct = role.skAct
    if not roleAct.reset then
      return
    end
    roleAct.reset.timer = role:now() + roleAct.reset.delay
  end
  
  skActs.atk4.preActs = {
    [skActs.heavy] = true,
    [skActs.crush] = true,
    [skActs.atk3] = true,
    [skActs.counter] = true
  }
  skActs.crush.reset = {timer = 0, delay = 1}
  skActs.heavy.reset = {timer = 0, delay = 1}
  skActs.counter.reset = {timer = 0, delay = 1}
  
  function skActs.atk4.isReady(atk4)
    if not atk4.base.isReady(atk4) then
      return false
    end
    local role = atk4.role
    local roleAct = role.skAct
    if atk4.preActs[roleAct] and role:now() < roleAct.reset.timer then
      return true
    else
      return false
    end
  end
  
  magics.heavyMe.heavySkill = skills.heavy
  magics.heavyMe.keyFrame = {
    10010190710,
    10010190711,
    10010190702,
    meArea = 10010190712
  }
  
  function magics.heavyMe.onBegin(heavyMe, casterNpc, target)
    local role = heavyMe.unit
    local me = role:me()
    local heavyStateMe, actMe
    local tpPos, tarPos = role:heavy_close_pos()
    if not me then
      me = Me:getInst(tpPos, tarPos)
      heavyStateMe = me.states.heavy
      heavyStateMe.tpPos = tpPos
      heavyStateMe.tarPos = tarPos
      actMe = me:tryState(heavyStateMe)
    elseif me.states.heavy:isReady() then
      heavyStateMe = me.states.heavy
      heavyStateMe.tpPos = tpPos
      heavyStateMe.tarPos = tarPos
      actMe = me:transState(heavyStateMe, true)
    end
    local keyFrame = heavyMe.keyFrame
    local isCoop = actMe and true or false
    for _, frameId in ipairs(keyFrame) do
      set_keyframe_enable(role.npc, frameId, not isCoop, false)
    end
    set_keyframe_enable(role.npc, keyFrame.meArea, isCoop, false)
    heavyMe.base.onBegin(casterNpc, target)
  end
  
  function skills.qteCoop.isReady(qteCoop)
    if not qteCoop.base.isReady(qteCoop) then
      return false
    end
    local me = role:me()
    if me and not me.states.qte:isReady() then
      return false
    end
    return true
  end
  
  function magics.qteMe.onBegin(qteMe, casterNpc, target)
    local role = qteMe.unit
    local me = role:me()
    local tpPos, tarPos = role:qte_pos()
    if not me then
      me = Me:getInst(tpPos, tarPos)
      me:tryState(me.states.qte)
    elseif me.states.qte:isReady() then
      me:tp(tpPos, tarPos)
      me:transState(me.states.qte, true)
    end
    qteMe.base.onBegin(casterNpc, target)
  end
  
  function magics.counterMe.onBegin(magic, caster, targetNpc)
    local role = magic.unit
    local target = role.target
    local tarPos
    if target then
      tarPos = target:get_pos_vec3()
    else
      tarPos = role:forward_pos(7.5)
    end
    do
      local minOffset = target and target.radius + 1.5
      role:tp(tarPos, 3, tarPos, minOffset)
    end
    do
      local me = role:me()
      local tpPos = role:counter_pos(me)
      if not me then
        me = Me:getInst(tpPos, tarPos)
        me:tryState(me.states.counter)
      elseif me.states.counter:isReady() then
        me:tp(tpPos, tarPos)
        me:transState(me.states.counter, true)
      end
    end
    magic.base.onBegin(magic, caster, targetNpc)
  end
  
  magics.atk1Me.Me = role.Me
  magics.atk1Me.roleAct = role.skActs.atk1
  
  function magics.atk1Me.onBegin(atk1Me, caster, target)
    local role = atk1Me.unit
    local me = role:me()
    if not me then
      local mePos, centerPos
      if role.target then
        mePos, centerPos = role:atk1_tar_pos()
      else
        mePos, centerPos = role:atk1_role_pos()
      end
      me = atk1Me.Me:getInst(mePos, centerPos)
    end
    me:tryState(me.states.atk1)
  end
  
  function magics.atk1Me.tick(atk1Me, caster, target)
    local me = atk1Me.unit:me()
    if not me then
      return
    end
    me:tryState(me.states.atk1)
  end
  
  magics.atk2Me.Me = role.Me
  magics.atk2Me.roleAct = role.skActs.atk2
  do
    local function tryMeAtk2(atk2Me, caster, target)
      local me = atk2Me.unit:me()
      
      if me then
        return me:tryState(me.states.atk2)
      else
        return atk2Me.unit:debugOutput("me lost in atk2")
      end
    end
    
    magics.atk2Me.onBegin = tryMeAtk2
    magics.atk2Me.tick = tryMeAtk2
  end
  magics.atk3Me.Me = role.Me
  magics.atk3Me.roleAct = role.skActs.atk3
  do
    local function tryMeAtk3(atk3Me, caster, target)
      local me = atk3Me.unit:me()
      
      if me then
        return me:tryState(me.states.atk3)
      else
        return atk3Me.unit:debugOutput("me lost in atk3")
      end
    end
    
    magics.atk3Me.onBegin = tryMeAtk3
    magics.atk3Me.tick = tryMeAtk3
  end
  skActs.crush.isCrush = true
  do
    local crush_move_scale_z = {
      [9] = 0,
      [10] = 0,
      [11] = 0,
      [12] = 0,
      [13] = 0
    }
    role:set_move_scale(skills.crush.animName, crush_move_scale_z)
    magics.crushTP.act = skActs.crush
    
    function magics.crushTP.onBegin(crushTP, caster, target)
      local role = crushTP.unit
      local pos = crushTP.act.v_tarPos or get_npc_offset_position(role.npc, nil, 0, 3)
      role:tp(role:tpPos(pos, -2))
    end
    
    magics.crushMeltMe.Me = role.Me
    magics.crushMeltMe.elapse = 0.4
    
    function magics.crushMeltMe.onBegin(crushMelt, caster, target)
      local monster = crushMelt.Me.inst
      crushMelt.timer = get_npc_time(caster) + crushMelt.elapse
      if not monster or monster:isInMelt() then
        return
      end
      local monsterNpc = monster.npc
      cast_magic(monsterNpc, monsterNpc, monster.MELT_OUT)
    end
    
    magics.crushMeltMe.roleAct = skActs.crush
    
    function magics.crushMeltMe.onEnd(crushMeltMe, caster, target)
      local now = get_npc_time(caster)
      if now < crushMeltMe.timer then
        return
      end
      local role = crushMeltMe.unit
      local me = role:me()
      local tpPos, lookPos = role:crush_pos()
      if not me then
        me = Me:getInst(tpPos, lookPos)
        me:tryState(me.states.crush)
      elseif me.states.crush:isReady() then
        me:tp(tpPos, lookPos)
        me:transState(me.states.crush, true)
      end
    end
    
    local crushIndi = icons.crush.indi
    crushIndi.coarse.sizexOptions = {
      crushIndi.coarse.sizex,
      18
    }
    magics.changeCrushDist.crushIndi = crushIndi
    
    function magics.changeCrushDist.onBegin(changeCrushDist, casterNpc, target)
      local coarse = changeCrushDist.crushIndi.coarse
      coarse.sizex = coarse.sizexOptions[2]
    end
    
    function magics.changeCrushDist.onEnd(changeCrushDist, casterNpc, target)
      local role = changeCrushDist.unit
      if check_magic(role.npc, changeCrushDist.id) then
        return
      end
      local coarse = changeCrushDist.crushIndi.coarse
      coarse.sizex = coarse.sizexOptions[1]
    end
  end
  do
    local areaMgr = {}
    role.areaMgr = areaMgr
    areaMgr.role = role
    areaMgr.mis = nil
    areaMgr.npcList = {num = 0}
    areaMgr.shield_magic = magics.shield.id
    areaMgr.shield_timer = 0
    areaMgr.period = 2
    
    function areaMgr.addMis(mgr, mis)
      local oldMis = mgr.mis
      if oldMis then
        remove_missile(oldMis)
      end
      mgr.mis = mis
      mgr.timer = 0
    end
    
    function areaMgr.removeMis(mgr, mis)
      if mgr.mis == mis then
        mgr.mis = nil
      end
    end
    
    function areaMgr.addNpc(mgr, npc)
      local list = mgr.npcList
      if not list[npc] then
        list.num = list.num + 1
        list[npc] = true
      end
      areaMgr:tryShield()
    end
    
    function areaMgr.removeNpc(mgr, npc)
      local list = mgr.npcList
      local isValid = false
      if list[npc] then
        list.num = math.max(list.num - 1, 0)
        list[npc] = false
        isValid = true
      end
      if not mgr:hasRole() then
        mgr.role:doAfter(mgr.clearShield_doAfter, mgr.period, true)
      end
      return isValid
    end
    
    function areaMgr.isInArea(mgr, npc)
      return mgr.npcList[npc]
    end
    
    function areaMgr.hasRole(mgr)
      return mgr.npcList.num > 0
    end
    
    function areaMgr.isShieldOn(mgr)
      return check_magic(mgr.role.npc, mgr.shield_magic)
    end
    
    function areaMgr.tryShield(mgr)
      if not mgr.mis then
        return
      end
      local now = get_time()
      if now < mgr.shield_timer then
        return
      end
      if not mgr:hasRole() then
        return
      end
      local magic = mgr.shield_magic
      local ninsar = mgr.role
      local ninsarNpc = ninsar.npc
      mgr.shield_timer = now + mgr.period
      cast_magic(ninsarNpc, ninsarNpc, magic)
      ninsar:doAfter(mgr.tryShield_doAfter, mgr.period, true)
    end
    
    function areaMgr.tryShield_doAfter(role)
      role.areaMgr:tryShield()
    end
    
    function areaMgr.clearShield_doAfter(role)
      local mgr = role.areaMgr
      if mgr:hasRole() then
        return
      end
      if not mgr:isShieldOn() then
        return
      end
      role:abortMagic(mgr.shield_magic)
    end
    
    magics.shield.mgr = areaMgr
    
    function magics.shield.onEnd(magic, caster, target)
      magic.unit:doAfter(magic.mgr.tryShield_doAfter)
      magic.base.onEnd(magic, caster, target)
    end
  end
  
  function icons.shield.updateEnhance(shield)
    shield.isEnhance = shield.isEnable
  end
  
  function skActs.shield.onBegin(shield)
    local role = shield.role
    local me = role:me()
    local shieldMe
    if not me then
      local tpPos, lookPos = role:atk1_role_pos()
      me = Me:getInst(tpPos, lookPos)
      shieldMe = me.states.shield
      me:tryState(shieldMe)
    elseif me.states.shield:isReady() then
      shieldMe = me.states.shield
      me:transState(shieldMe, true)
    end
    shieldMe.tpPos = role:shield_pos()
    shield.base.onBegin(shield)
  end
  
  misLogics.shield.areaMis = misLogics.area.id
  misLogics.shield.magic = magics.shield.id
  misLogics.shield.skill = skills.shield
  
  function misLogics.shield.onBegin(misLogic, misInst, owner, posX, posZ)
    local role = misLogic.unit
    local npc = role.npc
    local areaFacePos = role:forward_pos(20)
    cast_missile3(npc, nil, posX, posZ, misLogic.areaMis, nil, areaFacePos.x, areaFacePos.z, nil, nil, nil, nil, nil, misLogic.skill:skInfo())
    cast_magic(npc, npc, misLogic.magic)
    misLogic.base.onBegin(misLogic, misInst, owner, posX, posZ)
  end
  
  misLogics.area.areaMgr = role.areaMgr
  
  function misLogics.area.onBegin(misLogic, misInst, owner, posX, posZ)
    misLogic.areaMgr:addMis(misInst)
    misLogic.base.onBegin(misLogic, misInst, owner, posX, posZ)
  end
  
  function misLogics.area.onEnd(misLogic, misInst, owner, posX, posZ)
    misLogic.areaMgr:removeMis(misInst)
    misLogic.base.onEnd(misLogic, misInst, owner, posX, posZ)
  end
  
  function misLogics.area.onEnter(misLogic, misInst, caster, npc)
    local areaMgr = misLogic.areaMgr
    if npc:is_hero() then
      areaMgr:addNpc(npc)
    end
  end
  
  function misLogics.area.onLeave(misLogic, misInst, caster, npc)
    local areaMgr = misLogic.areaMgr
    if npc:is_hero() then
      areaMgr:removeNpc(npc)
    end
  end
  
  skActs.ult.kfTp = 100101914012
  skActs.ult.kfHide = 100101914002
  skActs.ult.kfShow = 100101914012
  
  function skActs.ult.onBegin(ult)
    local role = ult.role
    local me = role:me()
    local needTpMe
    local tpPos, meFacePos, misPos, misFacePos = role:ult_pos()
    if not me or me:isTooFar(8) then
      needTpMe = false
      me = Me:getInst(tpPos, meFacePos)
      local ultMe = me.states.ult
      ultMe.tpPos, ultMe.meFacePos, ultMe.misPos, ultMe.misFacePos = tpPos, meFacePos, misPos, misFacePos
      me:tryState(ultMe)
    elseif me.states.ult:isReady() then
      needTpMe = true
      local ultMe = me.states.ult
      ultMe.tpPos, ultMe.meFacePos, ultMe.misPos, ultMe.misFacePos = tpPos, meFacePos, misPos, misFacePos
      me:transState(ultMe, true)
    end
    set_keyframe_enable(me.npc, ult.kfTp, needTpMe, false)
    set_keyframe_enable(me.npc, ult.kfHide, needTpMe, false)
    set_keyframe_enable(me.npc, ult.kfShow, needTpMe, false)
    ult.base.onBegin(ult)
  end
  
  misLogics.ult.areaMis = misLogics.area.id
  misLogics.ult.skill = skills.ult
  skActs.ultFast.tpKeyframe = 100101914012
  skActs.ultFast.closeUpFrame = 10010194001
  
  function skActs.ultFast.onBegin(ultFast)
    local role = ultFast.role
    local me = role:me()
    local tpPos, meFacePos, misPos, misFacePos = role:ult_pos()
    me = me or Me:getInst(tpPos, meFacePos)
    local ultMe = me.states.ult
    ultMe.tpPos, ultMe.meFacePos, ultMe.misPos, ultMe.misFacePos = tpPos, meFacePos, misPos, misFacePos
    me:tryState(ultMe)
    set_keyframe_enable(me.npc, ultFast.tpKeyframe, false, false)
    set_keyframe_enable(role.npc, ultFast.closeUpFrame, false, false)
    ultFast.base.onBegin(ultFast)
  end
  
  function skActs.linkQte.onBegin(linkQte)
    local role = linkQte.role
    local Me = role.Me
    local me = role:me()
    local linkQteMe
    if not me then
      local tpPos, lookPos = role:atk1_role_pos()
      me = Me:getInst(tpPos, lookPos)
      linkQteMe = me.states.linkQte
      me:tryState(linkQteMe)
    elseif me.states.linkQte:isReady() then
      linkQteMe = me.states.linkQte
      me:transState(linkQteMe, true)
    end
    linkQteMe.tpPos = role:linkQte_pos()
    linkQte.base.onBegin(linkQte)
  end
  
  misLogics.linkQte.areaMis = misLogics.area.id
  misLogics.linkQte.magic = magics.shield.id
  misLogics.linkQte.skill = skills.linkQte
  misLogics.linkQte.onBegin = misLogics.shield.onBegin
  
  function skActs.born.onBegin(born)
    born.base.onBegin(born)
    local role = born.role
    local me = role:me()
    if me then
      me:hideInst()
    end
    set_cursor_enable(role.npc, false)
    char_visible(true)
  end
  
  function skActs.born.onCastTime(born)
    born.base.onCastTime(born)
    local role = born.role
    set_cursor_enable(role.npc, true)
    char_visible(false)
    role:summonMe()
  end
  
  function skills.finish.onBegin(finish)
    finish.base.onBegin(finish)
    local role = finish.role
    set_cursor_enable(role.npc, false)
    char_visible(true)
    role:removeMe()
  end
  
  role.shield_energy_magics = magicIds.shield_energy_magics
  do
    local traces = role.traces
    traces[0] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
      local shield_energy_magics = role.shield_energy_magics
      local trace1 = shield_energy_magics.trace1
      local base = shield_energy_magics.base
      for magicName, subMagicId in pairs(trace1) do
        remove_sub_magic(base[magicName], subMagicId)
      end
    end
    traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
      local shield_energy_magics = role.shield_energy_magics
      local base = shield_energy_magics.base
      local trace1 = shield_energy_magics.trace1
      for magicName, subMagic in pairs(trace1) do
        add_sub_magic(base[magicName], subMagic, -1)
      end
    end
    traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
      local areaMgr = role.areaMgr
      areaMgr.addNpcBase = areaMgr.addNpc
      areaMgr.atk_magic = magicIds.trace2_atk_magic
      areaMgr.atk_level = 1
      
      function areaMgr.isAtkOn(areaMgr, npc)
        if check_magic(npc, magicIds.trace2_atkMax_magic) then
          return true
        elseif check_magic(npc, magicIds.destiny2_atkMax_magic) then
          return true
        elseif check_magic(npc, magicIds.trace2_atk_magic) then
          return true
        end
      end
      
      function areaMgr.tryAtk(areaMgr, npc)
        if areaMgr:isAtkOn(npc) then
          return
        end
        if not areaMgr:isInArea(npc) then
          return
        end
        local role = areaMgr.role
        local caster = role.npc
        local atk_magic = areaMgr.atk_magic
        local hp = get_npc_attr(role.npc, 4)
        if hp >= 25000 then
          if role.destinyLv >= 2 then
            areaMgr.atk_magic = magicIds.destiny2_atkMax_magic
            tool:castMagicToTeam(areaMgr.atk_magic, 0, caster)
          else
            areaMgr.atk_magic = magicIds.trace2_atkMax_magic
            tool:castMagicToTeam(areaMgr.atk_magic, 0, caster)
          end
        else
          areaMgr.atk_magic = magicIds.trace2_atk_magic
          tool:castMagicToTeam(areaMgr.atk_magic, areaMgr.atk_level, caster)
        end
      end
      
      function areaMgr.addNpc(areaMgr, npc)
        areaMgr:addNpcBase(npc)
        areaMgr:tryAtk(npc)
      end
      
      function areaMgr.finishAtk_doAfter(role)
        local areaMgr = role.ninsar_areaMgr
        local npc = role.npc
        if areaMgr:isInArea(npc) then
          return
        end
        tool:abortMagicToTeam(areaMgr.atk_magic)
      end
      
      areaMgr.removeNpcBase = areaMgr.removeNpc
      
      function areaMgr.removeNpc(areaMgr, npc)
        local isValid = areaMgr:removeNpcBase(npc)
        if not isValid then
          return
        end
        local role = npc:get_behavior()
        if not role then
          return
        end
        role.ninsar_areaMgr = areaMgr
        role:doAfter(areaMgr.finishAtk_doAfter, -5, true)
      end
    end
    traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
      skActs.shield.buff_magic = magicIds.trace4_shield_buff_magic
      
      local function shieldBuff(shield)
        local npc = shield.role.npc
        cast_magic(npc, npc, shield.buff_magic)
      end
      
      skActs.shield:insertFun("onBegin", shieldBuff)
    end
  end
  do
    local destinies = role.destinies
    destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
      local Me = role.Me
      Me.shield_buff_on_hit = magicIds.destiny1_shield_buff_on_hit
      
      local function shieldBuff(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
        if 0 == hit_type then
          return
        end
        local role = monster:ninsar()
        local roleNpc = role.npc
        cast_magic(roleNpc, roleNpc, monster.shield_buff_on_hit)
      end
      
      tool.insert(Me, "on_self_skill_hit", shieldBuff)
    end
    destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
      skActs.shield.areaMis = misLogics.area.id
      
      local function changeMisLife(shield)
        change_missile_config(shield.areaMis, "LiveTime", 20, 0)
      end
      
      skActs.shield:insertFun("onBegin", changeMisLife)
      role.areaMgr.atk_level = 2
    end
    destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
      magics.shield.buff_magic = magicIds.destiny3_shield_buff_magic
      
      local function defenceBuffOn(magic, caster, target)
        magic.tool:castMagicToTeam(magic.buff_magic, nil, caster)
      end
      
      magics.shield:insertFun("onBegin", defenceBuffOn)
      
      local function defenceBuffOff(magic, caster, target)
        if check_magic(caster, magic.id) then
          return
        end
        magic.tool:abortMagicToTeam(magic.buff_magic)
      end
      
      magics.shield:insertFun("onEnd", defenceBuffOff)
    end
    destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
      local Me = role.Me
      local damageInc = magicIds.destiny4_damageInc
      Me.damageInc = damageInc
      local me = Me.inst
      if not me then
        return
      end
      local npc = me.npc
      cast_magic(npc, npc, damageInc)
    end
    destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
      magics.shield.heal_magic = magicIds.destiny5_shield_heal_magic
      
      local function heal(magic, caster, target)
        if check_magic(caster, magic.id) then
          return
        end
        local hero = get_come_on_hero()
        cast_magic(caster, hero, magic.heal_magic)
      end
      
      magics.shield:insertFun("onEnd", heal)
    end
  end
  
  function role.spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local Me = role.Me
    Me.shield_redu_on_hit = magicIds.spWeapon_shield_redu_on_hit
    Me.shield_redu_level = role.spWeapon.lv
    
    local function shieldRedu(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
      if 0 == hit_type then
        return
      end
      cast_magic(monster.npc, hit_target, monster.shield_redu_on_hit, monster.shield_redu_level)
    end
    
    tool.insert(Me, "on_self_skill_hit", shieldRedu)
  end
  
  role:disable_rampage_keyframes()
end

function Ninsar.onLinkChange(role, newStage, oldState)
  if 2 ~= newStage then
    return
  end
  local misLogics = role.misLogics
  
  function misLogics.ult.onBegin(misLogic, misInst, owner, posX, posZ)
    local role = misLogic.unit
    local me = role:me()
    local areaFacePos = me.states.ult.misFacePos
    cast_missile3(role.npc, nil, posX, posZ, misLogic.areaMis, nil, areaFacePos.x, areaFacePos.z, nil, nil, nil, nil, nil, misLogic.skill:skInfo())
    misLogic.base.onBegin(misLogic, misInst, owner, posX, posZ)
  end
end

Ninsar.rampSkills = {
  "atk1",
  "atk2",
  "atk3",
  "atk4",
  "crush"
}

function Ninsar.enable_rampage_keyframes(role)
  local list = role.rampSkills
  local skills = role.skills
  local npc = role.npc
  local id
  for _, skillName in ipairs(list) do
    id = skills[skillName].id
    set_keyframe_enable_by_tag(npc, id, 4, true, true)
    set_keyframe_enable_by_tag(npc, id, 3, false, true)
  end
end

function Ninsar.disable_rampage_keyframes(role)
  local list = role.rampSkills
  local skills = role.skills
  local npc = role.npc
  local id
  for _, skillName in ipairs(list) do
    id = skills[skillName].id
    set_keyframe_enable_by_tag(npc, id, 4, false, true)
    set_keyframe_enable_by_tag(npc, id, 3, true, true)
  end
end

function Ninsar.onRampageEffect(role, stage, act)
  local Me = role.Me
  Me:onRampageStart()
end

function Ninsar.onRampageStart(role, stage)
  role:enable_rampage_keyframes()
  local shield_energy_magics = role.shield_energy_magics
  local base = shield_energy_magics.base
  local link = shield_energy_magics.link
  for magicName, subMagic in pairs(link) do
    add_sub_magic(base[magicName], subMagic, -1)
  end
end

function Ninsar.onRampageEnd(role, stage)
  role:disable_rampage_keyframes()
  local shield_energy_magics = role.shield_energy_magics
  local link = shield_energy_magics.link
  local base = shield_energy_magics.base
  for magicName, subMagicId in pairs(link) do
    remove_sub_magic(base[magicName], subMagicId)
  end
  local Me = role.Me
  Me:onRampageEnd(stage)
end

function Ninsar.on_born_behavior(role)
  local me = role:me()
  if me then
    me:syncTarget()
  end
  if role.bFinishBorn then
    return
  end
  local hasAnim = role.base.on_born_behavior(role)
  if not hasAnim then
    local cb
    if role:isInControl() then
      cb = role.summonMe
    else
      cb = role.prepareMe
    end
    role:doAfter(cb)
  end
end

function Ninsar.toMelt(role, inputId)
  local me = role:me()
  if me then
    me:onNinsarMelt()
  end
  role.base.toMelt(role, inputId)
end

function Ninsar.on_hero_reborn(role, npc)
  role.base.on_hero_reborn(role, npc)
  if role.npc ~= npc then
    return
  end
  if role:isInControl() then
    return role:summonMe()
  else
    return role:prepareMe()
  end
end

function Ninsar.on_tp_room_finish(role)
  role.base.on_tp_room_finish(role)
  role:prepareMe()
end

function Ninsar.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  if not is_showup then
    role.areaMgr:removeNpc(npc)
  end
end

function Ninsar.summonMe(role)
  local Me = role.Me
  Me:summon()
  if role.Ninsar.isListened then
    return
  end
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, role.npc, Me.on_ninsar_act_begin, Me)
  role.Ninsar.isListened = true
end

function Ninsar.prepareMe(role)
  local Me = role.Me
  Me:prepare()
  if role.Ninsar.isListened then
    return
  end
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, role.npc, Me.on_ninsar_act_begin, Me)
  role.Ninsar.isListened = true
end

function Ninsar.on_skill_cast_time(role, skill_id)
  role.base.on_skill_cast_time(role, skill_id)
  local skAct = role.skAct
  if skAct and skAct.isCastOver then
    role.Me:on_ninsar_act_castTime(skAct)
  end
end

function Ninsar.on_npc_hp_zero(role, npc, attacker, magic_id, missile_id, missile)
  if not role.base.on_npc_hp_zero(role, npc, attacker, magic_id, missile_id, missile) then
    return
  end
  if npc == role.npc then
    role:removeMe()
  end
end

function Ninsar.removeMe(role)
  if role:me() then
    role:me():removeInst()
  end
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, role.npc, role.Me)
  role.Ninsar.isListened = false
end

function Ninsar.on_remove(role)
  role.base.on_remove(role)
  local Ninsar = role.Ninsar
  if Ninsar.inst == role then
    Ninsar.inst = nil
  end
  role:removeMe()
end

function Ninsar.tpPos(role, pos, dist)
  local rolePos = role.npc:get_pos_vec3()
  local dir = pos - rolePos
  dir.y = 0
  dir:SetNormalize()
  local resPos = dir:Mul(dist):Add(pos)
  return role:fixPos(resPos, nil, 1)
end

function Ninsar.setTarget(role, newTarget)
  local me = role.Me.inst
  if me then
    me:setTarget(newTarget)
  end
  role.base.setTarget(role, newTarget)
end

function Ninsar.atk1_tar_pos(role)
  local lookPos, tpPos
  lookPos = role.target:get_pos_vec3()
  tpPos = role:tpPos(lookPos, 4)
  return tpPos, lookPos
end

function Ninsar.atk1_role_pos(role)
  local tpPos, lookPos
  local npc = role.npc
  tpPos = get_npc_offset_position(npc, nil, 135, 2)
  lookPos = role:forward_pos(3)
  return tpPos, lookPos
end

Ninsar.atk2_tar_pos = Ninsar.atk1_tar_pos
Ninsar.atk2_role_pos = Ninsar.atk1_role_pos

function Ninsar.atk3_tar_pos(role)
  local target = role.target
  local tpPos, tarPos
  tarPos = get_npc_pos(target)
  if not tarPos then
    return role:atk3_role_pos()
  end
  local me = role:me()
  local reDir = tarPos - role.npc:get_pos_vec3()
  if check_npc_status(target, 10) then
    local minRadius = 2
    local preAct = role.preAct
    if preAct and preAct.isCrush or preAct:isHeavy() then
      minRadius = 0
    end
    local hitFlyDir = -target:get_dir_vec()
    if not me:isInSectorRing(tarPos, minRadius, 4, hitFlyDir, 0.866) then
      tpPos = role:tpPos(tarPos, 4)
    end
  elseif not me:isInSectorRing(tarPos, 0, 2.5, reDir, 0.5) then
    tpPos = role:tpPos(tarPos, 2)
  end
  return tpPos, tarPos
end

function Ninsar.atk3_role_pos(role)
  local me = role:me()
  local tpPos, lookPos
  lookPos = role:forward_pos(1)
  local dir, faceDir = role:inputDir()
  dir = dir or faceDir
  if not me:isInSectorRing(lookPos, 0, 2.5, dir, 0.5) then
    tpPos = role:forward_pos(6)
  end
  return tpPos, lookPos
end

function Ninsar.heavy_pos(role)
  return role:forward_pos(2)
end

function Ninsar.heavy_close_pos(role)
  return role:forward_pos(5), role:heavy_pos()
end

function Ninsar.qte_pos(role)
  local tpPos, tarPos
  local target = role.skActs.qte.target
  tarPos = get_npc_pos(target)
  tpPos = get_position_offset_position(tarPos, role.npc:get_pos_vec3(), -60, 2.5)
  return tpPos, tarPos
end

function Ninsar.counter_pos(role)
  local tpPos, tarPos
  local target = role.target
  tarPos = target and get_npc_pos(target) or role:forward_pos(2)
  tpPos = get_position_offset_position(tarPos, role.npc:get_pos_vec3(), -60, 2.5)
  return tpPos, tarPos
end

function Ninsar.forward_pos(role, dist)
  dist = dist or 5
  return get_npc_offset_position(role.npc, nil, 0, dist)
end

function Ninsar.ult_pos(role)
  local tpPos, meFacePos, misPos, misFacePos
  misPos = role:forward_pos(4)
  local rolePos = role.npc:get_pos_vec3()
  local misPos = role:forward_pos(4)
  tpPos = get_position_offset_position(misPos, rolePos, -40, 4.8)
  meFacePos = get_position_offset_position(misPos, rolePos, 90, 0.5)
  misFacePos = get_position_offset_position(misPos, rolePos, 120, 10)
  return tpPos, meFacePos, misPos, misFacePos
end

function Ninsar.crush_pos(role)
  local tpPos, lookPos
  local indiPos = role.skActs.crush.v_tarPos
  if indiPos then
    lookPos = indiPos
  else
    lookPos = role:forward_pos(3)
  end
  tpPos = role:tpPos(lookPos, 4)
  return tpPos, lookPos
end

function Ninsar.shield_pos(role)
  local tpPos
  local indiPos = role.skActs.shield.v_tarPos
  if indiPos then
    tpPos = role:tpPos(indiPos, 0.1)
  else
    tpPos = role:forward_pos(5)
  end
  return tpPos
end

function Ninsar.linkQte_pos(role)
  local tpPos
  local tarPos = role.skActs.linkQte.v_tarPos
  if tarPos then
    tpPos = role:tpPos(tarPos, 0.1)
  else
    tpPos = role:forward_pos(5)
  end
  return tpPos
end

return Ninsar
