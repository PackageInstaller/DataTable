local monstBase = import("character.base.monster_base")
local Me = Util.create_child_mt(monstBase)
local vec3 = require("base.vec3")
Me.rampMgr = import("character.base.base_rampageManager")
Me._tpPos = vec3:New()
Me.followDist = 100.0
Me.MELT_OUT = 10191021
Me.MELT_OUT_BACK = 10191022
Me.fire_Effect = 10191070
Me.fire_Effect_Close = 101910701
Me.SHOW_UP_FX1 = 10191061
Me.SHOW_UP_FX2 = 10191062
Me.ATK1MARK = 1019031
Me.ATK2MARK = 1019032
Me.ATK3MARK = 1019033
Me.IGNORE_COLLISION_1 = 10191072
Me.IGNORE_COLLISION_2 = 10191073
Me.HEAVY_TP = 10191033
Me.ULT_TP = 10191050
Me.RAMPAGE_SPEED = Const.RAMPAGE_CONFIG.RAMPAGE_SPEED
Me.ULT_MIS = 100101914007
Me.shield_energy_level = 1
Me.startState = nil
Me.isStartHide = false
Me.attrTable = {
  [20] = 10000,
  [23] = 10000,
  [26] = 10000,
  [34] = 10000,
  [40] = 10000,
  [76] = 10000,
  [78] = 10000,
  [115] = 10000,
  [122] = 10000,
  [123] = 10000,
  [124] = 10000,
  [125] = 10000,
  [126] = 10000,
  [127] = 10000,
  [128] = 10000,
  [129] = 10000,
  [130] = 10000,
  [131] = 10000,
  [132] = 10000,
  [152] = 10000
}
Me.atkActs = {
  atk1 = true,
  atk2 = true,
  atk3 = true,
  atk4 = true,
  heavy = true,
  qte = true,
  linkQte = true,
  counter = true,
  crush = true,
  shield = true,
  ult = true,
  ultFast = true
}
Me.rampSkills = {
  "atk1",
  "atk2",
  "atk3",
  "crush"
}

function Me.enable_rampage_keyframes(monster)
  local list = monster.rampSkills
  local skills = monster.skills
  local npc = monster.npc
  local id
  for _, skillName in ipairs(list) do
    id = skills[skillName].id
    set_keyframe_enable_by_tag(npc, id, 4, true, true)
    set_keyframe_enable_by_tag(npc, id, 3, false, true)
  end
end

function Me.disable_rampage_keyframes(monster)
  local list = monster.rampSkills
  local skills = monster.skills
  local npc = monster.npc
  local id
  for _, skillName in ipairs(list) do
    id = skills[skillName].id
    set_keyframe_enable_by_tag(npc, id, 4, false, true)
    set_keyframe_enable_by_tag(npc, id, 3, true, true)
  end
end

function Me.onRampageStart(Me)
  if not Me:checkInst() then
    return
  end
  local monster = Me.inst
  local npc = monster.npc
  cast_magic(npc, npc, monster.RAMPAGE_SPEED)
  monster:enable_rampage_keyframes()
end

function Me.onRampageEnd(Me, state)
  if not Me:checkInst() then
    return
  end
  local monster = Me.inst
  local npc = monster.npc
  abort_magic_by_id(npc, monster.RAMPAGE_SPEED)
  monster:disable_rampage_keyframes()
end

function Me.ninsar(monster)
  local Ninsar = monster.Ninsar
  return Ninsar and Ninsar.inst
end

function Me._init(monster, npc)
  monster.npc = npc
  monster.Me = Me
  monster:addInst()
  local actSkills = {
    follow = {},
    kneel = {},
    crush = {},
    shield = {
      "shieldStart"
    },
    atk1 = {},
    atk2 = {},
    atk3 = {},
    ult = {},
    heavyFar = {},
    heavyClose = {
      "heavyCloseStart"
    },
    qte = {},
    counter = {},
    linkQte = {
      "linkQteStart"
    }
  }
  local actMoves = {
    "standPeace",
    "standBattle",
    "standHide",
    "standBack"
  }
  local nodes = {
    "front",
    "background",
    "idleBattle",
    "idlePeace",
    "skill",
    "wait",
    "heavy",
    "hide"
  }
  local magicIds = {
    meltOutBack = monster.MELT_OUT_BACK,
    heavyTp = monster.HEAVY_TP,
    ultTp = monster.ULT_TP
  }
  monstBase._init(monster, actSkills, actMoves, nodes, magicIds)
  if monster.Me.damageInc then
    local npc = monster.npc
    cast_magic(npc, npc, monster.damageInc)
  end
  if monster.rampMgr:isOn() then
    monster:onRampageStart()
  else
    monster:disable_rampage_keyframes()
  end
  do
    local _ENV = monster.states
    _ENV.root(_ENV.debugIdle, _ENV.front, _ENV.hide, _ENV.background, _ENV.decisionFailed)
    _ENV.front(_ENV.skill, _ENV.wait)
    _ENV.wait(_ENV.idleBattle, _ENV.idlePeace)
    _ENV.idleBattle(_ENV.standBattle, _ENV.follow)
    _ENV.idlePeace(_ENV.standPeace, _ENV.kneel)
    _ENV.hide(_ENV.standHide)
    _ENV.background(_ENV.standBack)
    _ENV.skill(_ENV.atk1, _ENV.atk2, _ENV.atk3, _ENV.heavy(_ENV.heavyClose, _ENV.heavyFar), _ENV.qte, _ENV.counter, _ENV.crush, _ENV.shield, _ENV.ult, _ENV.linkQte)
  end
  local states = monster.states
  local skills = monster.skills
  local magics = monster.magics
  
  function magics.meltOutBack.onEnd(meltOutBack, caster, target)
    if meltOutBack.monster:isInAtk() then
      return
    end
    abort_skill(caster, true)
    meltOutBack.unit:hideInst()
  end
  
  function states.idlePeace.isReady(idlePeace)
    return not idlePeace.monster:isInBattle()
  end
  
  states.standPeace.elapse = 3
  
  function states.standPeace.start(standPeace)
    local monster = standPeace.monster
    stop_move(monster.npc)
    standPeace.timer = monster:now() + standPeace.elapse
  end
  
  states.standPeace.kneel = states.kneel
  states.standPeace.standBattle = states.standBattle
  states.standPeace.idleBattle = states.idleBattle
  
  function states.standPeace.tickTrans(standPeace)
    if standPeace.idleBattle:isReady() then
      return standPeace.standBattle
    end
    if standPeace.monster:isInMelt() then
      return
    end
    if monster:now() > standPeace.timer then
      return standPeace.kneel
    end
    if monster:isTooFar(8) then
      return standPeace.kneel
    end
  end
  
  states.standPeace.onNinsarBack = monster.onNinsarBack
  
  function skills.kneel.startFrame()
    return 34
  end
  
  function skills.kneel.target()
  end
  
  function states.kneel.start(kneel)
    local monster = kneel.monster
    kneel.isTp = false
    if monster:isTooFar(5) then
      kneel.isTp = true
      local tpPos, lookPos = monster:ninsar():atk1_role_pos()
      monster:tp(tpPos, lookPos)
    end
    kneel.tickTrans = nil
    kneel.base.start(kneel)
  end
  
  states.kneel.follow = states.follow
  
  function states.kneel.tickTransWithFollow(kneel)
    if kneel.monster:isTooFar(10) then
      return kneel.follow
    end
  end
  
  states.kneel.background = states.background
  
  function states.kneel.finTrans(kneel)
    return kneel.background
  end
  
  states.kneel.trans.prio = 0
  states.kneel.idlePeace = states.idlePeace
  
  function states.kneel.onCastTime(kneel)
    kneel.base.onCastTime(kneel)
    if kneel.idlePeace:isReady() then
      kneel.monster:meltBack()
    else
      kneel.tickTrans = kneel.tickTransWithFollow
    end
  end
  
  function states.idleBattle.isReady(idleBattle)
    return monster:isInBattle()
  end
  
  function states.standBattle.start(standBattle)
    local monster = standBattle.monster
    stop_move(monster.npc)
  end
  
  states.standBattle.standPeace = states.standPeace
  states.standBattle.idlePeace = states.idlePeace
  states.standBattle.follow = states.follow
  
  function states.standBattle.tickTrans(standBattle)
    if standBattle.idlePeace:isReady() then
      return standBattle.standPeace
    end
    if standBattle.monster:isInMelt() then
      return
    end
    if standBattle.monster:isTooFar(10) then
      return standBattle.follow
    end
  end
  
  states.standBattle.onNinsarBack = monster.onNinsarBack
  
  function skills.follow.target()
  end
  
  function states.follow.start(follow)
    local monster = follow.monster
    abort_skill(monster.npc, true)
    local tpPos, lookPos = monster:ninsar():atk1_role_pos()
    monster:tp(tpPos, lookPos)
    follow.base.start(follow)
  end
  
  states.follow.trans.prio = 0
  states.follow.standBattle = states.standBattle
  states.follow.idleBattle = states.idleBattle
  states.follow.kneel = states.kneel
  
  function states.follow.finTrans(follow)
    if follow.idleBattle:isReady() then
      return follow.standBattle
    else
      return follow.kneel
    end
  end
  
  states.follow.onNinsarBack = monster.onNinsarBack
  
  function states.hide.start(hide)
    local monster = hide.monster
    monster.isHiding = true
    local npc = monster.npc
    enable_shadow(npc, false)
    set_npc_pretend_visible(npc, false)
  end
  
  function states.hide.finish(hide)
    local monster = hide.monster
    enable_shadow(monster.npc, true)
  end
  
  function states.standHide.start(standHide)
    abort_skill(standHide.monster.npc)
  end
  
  function states.standBack.start(standBack)
    abort_skill(standBack.monster.npc)
  end
  
  function states.skill.isReady()
    return false
  end
  
  states.skill.wait = states.wait
  
  function states.skill.finTrans(skill)
    return skill.wait
  end
  
  function states.skill.tickTrans(skill)
    local monster = skill.monster
    if monster:isInMelt() then
      return
    end
    if not is_cast_skill_time(monster.npc) and skill.monster:isTooFar(10) then
      return skill.wait
    end
  end
  
  states.atk1.trans.prio = 1
  states.atk1.isReady = monster.isSkillReady
  states.atk1.roleAct = "atk1"
  
  function states.atk1.start(atk1)
    local monster = atk1.monster
    monster:quitMelt()
    monster:copyAttr(atk1)
    local monsterNpc = monster.npc
    local role = monster:ninsar()
    local roleNpc = role.npc
    abort_magic_by_id(roleNpc, monster.ATK1MARK)
    local target = monster.target
    if target then
      if monster:isTooFar(4 + target.radius, target:get_pos_vec3()) then
        local tpPos, lookPos = role:atk1_tar_pos()
        monster:tp(tpPos, lookPos)
      else
        lookat_npc(monsterNpc, target)
      end
    elseif monster:isTooFar(6) then
      local tpPos, lookPos = role:atk1_role_pos()
      monster:tp(tpPos, lookPos)
    else
      local lookPos = role:forward_pos(5)
      lookat_position(monsterNpc, lookPos.x, lookPos.z, false)
    end
    atk1.base.start(atk1)
  end
  
  function skills.atk1.moveScale(atk1)
    local monster = atk1.monster
    local target = monster.target
    if not target then
      return 1
    end
    local dist = math.max(get_npc_distance(monster.npc, 1, target, true), 0)
    local offset = atk1:animMotion()
    local k = dist / offset
    return math.min(k, 1)
  end
  
  states.atk1.meltDelay = 0.5
  states.atk1.onCastTime = monster.onSkillCastTime
  states.atk1.tick = monster.skillTick
  states.atk1.shieldEnergy = 1019021
  states.atk1.ultEnergy = 1019091
  states.atk1.onHit = monster.skillHit
  states.atk2.trans.prio = 1
  states.atk2.isReady = monster.isSkillReady
  states.atk2.roleAct = "atk3"
  
  function states.atk2.start(atk2)
    local monster = atk2.monster
    monster:quitMelt()
    monster:copyAttr(atk2)
    local monsterNpc = monster.npc
    local role = monster:ninsar()
    local roleNpc = role.npc
    abort_magic_by_id(roleNpc, monster.ATK2MARK)
    local target = monster.target
    if target then
      if not check_npc_distance(monsterNpc, target, 4, true) then
        local tpPos, lookPos = role:atk2_tar_pos()
        monster:tp(tpPos, lookPos)
      else
        lookat_npc(monsterNpc, target)
      end
    elseif monster:isTooFar(6) then
      local tpPos, lookPos = role:atk2_role_pos()
      monster:tp(tpPos, lookPos)
    else
      local lookPos = role:forward_pos(5)
      lookat_position(monsterNpc, lookPos.x, lookPos.z, false)
    end
    atk2.base.start(atk2)
  end
  
  function skills.atk2.moveScale(atk2)
    local monster = atk2.monster
    local target = monster.target
    if not target then
      return 1
    end
    local dist = math.max(get_npc_distance(monster.npc, 1, target, true), 0)
    local offset = atk2:animMotion()
    local k = dist / offset
    return math.min(k, 1)
  end
  
  states.atk2.meltDelay = 0
  states.atk2.onCastTime = monster.onSkillCastTime
  states.atk2.tick = monster.skillTick
  states.atk2.shieldEnergy = 1019022
  states.atk2.ultEnergy = 1019092
  states.atk2.onHit = monster.skillHit
  states.atk3.trans.prio = 1
  states.atk3.trans.disable.heavy = states.heavy
  states.atk3.isReady = monster.isSkillReady
  states.atk3.noTpActs = {
    [states.crush] = true
  }
  states.atk3.roleAct = "atk4"
  
  function states.atk3.start(atk3)
    local monster = atk3.monster
    monster:quitMelt()
    monster:copyAttr(atk3)
    local monsterNpc = monster.npc
    local role = monster:ninsar()
    local roleNpc = role.npc
    abort_magic_by_id(roleNpc, monster.ATK3MARK)
    local target = monster.target
    if target then
      local tpPos, lookPos = role:atk3_tar_pos()
      monster:tp(tpPos, lookPos)
    else
      local tpPos, lookPos = role:atk3_role_pos()
      monster:tp(tpPos, lookPos)
    end
    if not monster:isAlign() then
      monster:openCollision()
    end
    atk3.base.start(atk3)
  end
  
  function states.atk3.onCastTime(atk3)
    atk3.monster:closeCollision()
    atk3.monster.onSkillCastTime(atk3)
  end
  
  function states.atk3.finish(atk3)
    if not atk3.isCastOver then
      atk3.monster:closeCollision()
    end
    atk3.base.finish(atk3)
  end
  
  function skills.atk3.moveScale(atk3)
    local monster = atk3.monster
    local target = monster.target
    if not target then
      return 1
    end
    local dist = math.max(get_npc_distance(monster.npc, 1, target, true), 0)
    local offset = atk3:animMotion()
    local k = dist / offset
    return math.min(k, 1)
  end
  
  states.atk3.meltDelay = 0.5
  states.atk3.tick = monster.skillTick
  states.atk3.shieldEnergy = 1019023
  states.atk3.ultEnergy = 1019093
  states.atk3.onHit = monster.skillHit
  states.heavy.trans = {
    prio = 2,
    enable = {
      states.atk3
    },
    disable = {}
  }
  states.heavy.isReady = monster.isSkillReady
  states.heavy.heavyClose = states.heavyClose
  states.heavy.heavyFar = states.heavyFar
  states.heavyClose.roleAct = "heavy"
  states.heavyFar.roleAct = "heavy"
  
  function states.heavy.start(heavy)
    local monster = heavy.monster
    monster:quitMelt()
    monster:copyAttr(heavy.heavyClose)
    monster:copyAttr(heavy.heavyFar)
    local tarPos = heavy.tarPos
    lookat_position(monster.npc, tarPos.x, tarPos.z, true)
    heavy.base.start(heavy)
  end
  
  states.heavyClose.trans.prio = 2
  states.heavyClose.heavy = states.heavy
  states.heavyClose.isHeavy = true
  
  function states.heavyClose.isReady(heavyClose)
    return monster:isInSectorRing(heavyClose.heavy.tarPos, 1.5, 4)
  end
  
  skills.heavyCloseEnd.offsetZ = {}
  skills.heavyCloseEnd.moveStartFrame = 11
  skills.heavyCloseEnd.moveStopFrame = 15
  skills.heavyCloseEnd.heavy = states.heavy
  
  function skills.heavyCloseEnd.moveScale(heavyCloseEnd)
    local monster = heavyCloseEnd.monster
    local tarPos = heavyCloseEnd.heavy.tarPos
    local moveStartFrame = heavyCloseEnd.moveStartFrame
    local moveStopFrame = heavyCloseEnd.moveStopFrame
    local dist = (monster.npc:get_pos_vec3() - tarPos):Magnitude() - 2
    local sprintOffset = heavyCloseEnd:animMotion(moveStartFrame, moveStopFrame)
    local totalOffset = heavyCloseEnd:animMotion(1, moveStopFrame)
    local k1 = dist / totalOffset
    if k1 < 1 then
      return math.max(0, k1)
    end
    local k2 = dist / sprintOffset
    if k2 < 0 then
      k2 = 0
    end
    local offsetZ = heavyCloseEnd.offsetZ
    for i = moveStartFrame, moveStopFrame do
      offsetZ[i] = k2
    end
    return offsetZ
  end
  
  states.heavyClose.meltDelay = 0.2
  states.heavyClose.onCastTime = monster.onSkillCastTime
  states.heavyClose.tick = monster.skillTick
  states.heavyClose.shieldEnergy = 1019024
  states.heavyClose.ultEnergy = 1019094
  states.heavyClose.onHit = monster.skillHit
  states.heavyFar.trans.prio = 2
  states.heavyFar.isHeavy = true
  
  function states.heavyFar.isReady()
    return true
  end
  
  states.heavyFar.meltDelay = 0.2
  states.heavyFar.onCastTime = monster.onSkillCastTime
  states.heavyFar.tick = monster.skillTick
  magics.heavyTp.heavy = states.heavy
  
  function magics.heavyTp.onBegin(heavyTp, caster, target)
    local monster = heavyTp.unit
    local state = monster.state
    if not state.isHeavy then
      return
    end
    local heavy = heavyTp.heavy
    monster:tp(heavy.tpPos, heavy.tarPos)
  end
  
  states.heavyFar.shieldEnergy = 1019024
  states.heavyFar.ultEnergy = 1019094
  states.heavyFar.onHit = monster.skillHit
  states.qte.trans.prio = 2
  states.qte.isReady = monster.isSkillReady
  states.qte.roleAct = "qte"
  
  function states.qte.start(qte)
    local monster = qte.monster
    monster:copyAttr(qte)
    monster:quitMelt()
    local target = monster:ninsar().skActs.qte.target
    local tarPos = target:get_pos_vec3()
    lookat_position(monster.npc, tarPos.x, tarPos.z, true)
    qte.base.start(qte)
  end
  
  function skills.qte.startFrame(skill, state)
    return 12
  end
  
  states.qte.meltDelay = 0.5
  states.qte.onCastTime = monster.onSkillCastTime
  states.qte.tick = monster.skillTick
  states.qte.shieldEnergy = 1019025
  states.qte.ultEnergy = 1019096
  states.qte.onHit = monster.skillHit
  states.counter.trans.prio = 4
  states.counter.trans.enable.counter = states.counter
  states.counter.trans.enable.shield = states.shield
  states.counter.trans.enable.crush = states.crush
  states.counter.isReady = monster.isSkillReady
  states.counter.roleAct = "counter"
  
  function states.counter.start(counter)
    local monster = counter.monster
    monster:copyAttr(counter)
    monster:quitMelt()
    counter.base.start(counter)
  end
  
  function skills.counter.startFrame(skill, state)
    return 13
  end
  
  states.counter.meltDelay = 0.5
  states.counter.onCastTime = monster.onSkillCastTime
  states.counter.tick = monster.skillTick
  states.counter.shieldEnergy = 1019026
  states.counter.ultEnergy = 1019095
  states.counter.onHit = monster.skillHit
  states.crush.isCrush = true
  states.crush.trans.prio = 3
  states.crush.trans.enable.shield = states.shield
  states.crush.trans.enable.atk3 = states.atk3
  states.crush.isReady = monster.isSkillReady
  states.crush.roleAct = "crush"
  
  function states.crush.start(crush)
    local monster = crush.monster
    monster:copyAttr(crush)
    monster:quitMelt(true)
    crush.base.start(crush)
  end
  
  states.crush.meltDelay = 0.5
  states.crush.onCastTime = monster.onSkillCastTime
  states.crush.tick = monster.skillTick
  states.crush.shieldEnergy = 1019027
  states.crush.ultEnergy = 1019097
  states.crush.onHit = monster.skillHit
  states.shield.trans.prio = 3
  states.shield.isReady = monster.isSkillReady
  states.shield.roleAct = "shield"
  
  function states.shield.start(shield)
    shield.monster:copyAttr(shield)
    shield.monster:quitMelt()
    shield.base.start(shield)
  end
  
  states.shield.meltDelay = 0.5
  states.shield.onCastTime = monster.onSkillCastTime
  states.shield.tick = monster.skillTick
  
  function skills.shieldFall.start(shieldFall, shield)
    local monster = shieldFall.monster
    local lookTar = monster.target or monster:ninsar().npc
    monster:tp(shield.tpPos, lookTar:get_pos_vec3())
    shieldFall.base.start(shieldFall, shield)
  end
  
  states.shield.ultEnergy = 1019098
  states.shield.onHit = monster.skillHit
  states.ult.trans.prio = 6
  states.ult.trans.enable.shield = states.shield
  states.ult.isReady = monster.isSkillReady
  states.ult.misId = monster.ULT_MIS
  states.ult.roleAct = "ult"
  
  function states.ult.disableShadow(monster)
    enable_shadow(monster.npc, false)
  end
  
  function states.ult.start(ult)
    local monster = ult.monster
    local npc = monster.npc
    monster:copyAttr(ult)
    set_weapon_attach_point(npc, "fx_fire", false)
    set_weapon_attach_point(npc, "H1001019_1_Weapon", false)
    monster:doAfter(ult.disableShadow, -1)
    local misPos = ult.misPos
    local misFacePos = ult.misFacePos
    cast_missile3(npc, monster.target, misPos.x, misPos.z, ult.misId, nil, misFacePos.x, misFacePos.z, misFacePos.y, misPos.y, misPos.x, misPos.z, misPos.y)
    lookat_position(npc, misPos.x, misPos.z, true)
    ult.base.start(ult)
  end
  
  function states.ult.enableShadow(monster)
    enable_shadow(monster.npc, true)
  end
  
  function states.ult.onCastTime(ult)
    ult.base.onCastTime(ult)
    local monster = ult.monster
    if not monster:ninsar():isInBattle() then
      monster:hideInst()
    else
      monster:doAfter(ult.enableShadow, -0.7)
    end
  end
  
  magics.ultTp.ult = states.ult
  magics.ultTp.tpOffset = skills.ult:animMotion(1, 14)
  
  function magics.ultTp.onBegin(magic, caster, target)
    local monster = magic.unit
    local ult = magic.ult
    local tpPos, facePos = ult.tpPos, ult.meFacePos
    tpPos = get_position_offset_position(tpPos, facePos, 0, magic.tpOffset)
    monster:tp(tpPos, facePos, true)
  end
  
  states.linkQte.trans.prio = 5
  states.linkQte.trans.enable.shield = true
  states.linkQte.isReady = monster.isSkillReady
  states.linkQte.roleAct = "linkQte"
  
  function states.linkQte.start(linkQte)
    linkQte.monster:copyAttr(linkQte)
    linkQte.monster:quitMelt()
    linkQte.base.start(linkQte)
  end
  
  states.linkQte.meltDelay = 0.5
  states.linkQte.onCastTime = monster.onSkillCastTime
  states.linkQte.tick = monster.skillTick
  
  function skills.linkQteFall.start(linkQteFall, linkQte)
    local monster = linkQteFall.monster
    local lookTar = monster.target or monster:ninsar().npc
    monster:tp(linkQte.tpPos, lookTar:get_pos_vec3())
    linkQteFall.base.start(linkQteFall, linkQte)
  end
  
  states.linkQte.ultEnergy = 1019098
  states.linkQte.onHit = monster.skillHit
end

function Me.openCollision(monster)
  local npc = monster.npc
  abort_magic_by_id(npc, monster.IGNORE_COLLISION_1)
  abort_magic_by_id(npc, monster.IGNORE_COLLISION_2)
end

function Me.closeCollision(monster)
  local npc = monster.npc
  cast_magic(npc, npc, monster.IGNORE_COLLISION_1)
  cast_magic(npc, npc, monster.IGNORE_COLLISION_2)
end

function Me.meltBack(monster)
  local npc = monster.npc
  cast_magic(npc, npc, monster.MELT_OUT_BACK)
end

function Me.copyAttr(monster, state)
  copy_attr_to_npc(monster:ninsar().npc, monster.npc, monster.attrTable)
  if not state then
    return
  end
  local role = monster:ninsar()
  local roleAct = role.skActs[state.roleAct]
  if not roleAct then
    return
  end
  local info = roleAct.info
  local stateInfo = {}
  for key, value in pairs(info) do
    stateInfo[key] = value
  end
  state.skInfo = stateInfo
end

function Me.missile_skill_action_info(monster, missileId)
  local skId = math.floor(missileId / 100)
  local skill = monster.skills[skId]
  local state = skill and skill.state
  return state and state.skInfo
end

function Me.onSkillCastTime(state)
  state.meltTimer = get_time() + state.meltDelay
  state.base.onCastTime(state)
end

function Me.skillTick(state)
  state.base.tick(state)
  if not state.isCastOver then
    return
  end
  local monster = state.monster
  if monster:isInMelt() then
    return
  end
  if get_time() > state.meltTimer and not monster:isInBattle() then
    monster:meltBack()
  end
end

function Me.skillHit(state, casterNpc, hitTarget, hitType, skill, missile)
  if state.isHit then
    return
  end
  local monster = state.monster
  local role = monster:ninsar()
  local npc = role.npc
  local ultEnergyGet = state.ultEnergy
  local shieldEnergyGet = state.shieldEnergy
  if ultEnergyGet then
    cast_magic(npc, npc, ultEnergyGet)
  end
  if shieldEnergyGet then
    cast_magic(npc, npc, shieldEnergyGet, monster.shield_energy_level)
  end
  state.isHit = true
end

function Me.quitMelt(monster, ignoreStay)
  if not monster:isInMelt() then
    return
  end
  local npc = monster.npc
  if ignoreStay then
    abort_magic_by_id(npc, monster.MELT_OUT)
  end
  abort_magic_by_id(npc, monster.MELT_OUT_BACK)
  monster:showUpFx()
end

function Me.isInScreen(monster)
  return Util.is_obj_in_screen(monster.npc)
end

function Me.isInMelt(monster)
  local npc = monster.npc
  if check_magic(npc, monster.MELT_OUT) then
    return true
  end
  if check_magic(npc, monster.MELT_OUT_BACK) then
    return true
  end
  return false
end

function Me.isInAtk(monster)
  return monster.Me.v_is_in_attack
end

function Me.isInBattle(monster)
  if monster:isInAtk() then
    return true
  end
  if monster:ninsar():isInBattle() then
    return true
  end
  return false
end

function Me.isSkillReady(act)
  return act.monster:transCheck(act)
end

function Me.isTooFar(monster, dist, pos)
  local mePos = monster.npc:get_pos_vec3()
  if pos then
    return mePos:SquareDistance(pos) > dist ^ 2
  else
    local ninsar = monster:ninsar()
    if not ninsar:isInControl() then
      return false
    else
      return mePos:SquareDistance(ninsar.npc:get_pos_vec3()) > dist ^ 2
    end
  end
end

function Me.transCheck(monster, tarState)
  local curState = monster.state
  local trans = curState.trans
  local tarName = tarState.name
  if curState.isCastOver or curState.isOver then
    return true
  end
  if trans.disable[tarName] then
    return false
  end
  if trans.enable[tarName] then
    return true
  end
  return tarState.trans.prio > trans.prio
end

function Me.isAlign(monster)
  local role = monster:ninsar()
  local monsterDir = monster.npc:get_dir_vec()
  local roleDir = role.npc:get_dir_vec()
  return roleDir:Dot(monsterDir) > 0
end

function Me.on_ninsar_act_begin(Me, npc, act)
  if act.role ~= Me:ninsar() then
    return
  end
  local name = act.name
  if Me.atkActs[name] then
    Me:on_ninsar_atk_begin(Me)
  else
    Me:on_ninsar_atk_end(Me)
  end
  if act.onBeginMe then
    act:onBeginMe(Me)
  end
end

function Me.on_ninsar_act_castTime(Me, act)
  local name = act.name
  if Me.atkActs[name] then
    Me:on_ninsar_atk_end(Me)
  end
end

function Me.on_ninsar_atk_begin(Me)
  Me.v_is_in_attack = true
end

function Me.on_ninsar_atk_end(Me)
  Me.v_is_in_attack = false
end

function Me.on_magic_begin(monster, npc, target, magic_id)
  if magic_id == monster.MELT_OUT or magic_id == monster.MELT_OUT_BACK then
    cast_magic(npc, npc, monster.fire_Effect_Close)
  end
  local magic = monster.magics[magic_id]
  if not magic then
    return
  end
  magic:onBegin(npc, target)
end

function Me.on_magic_end(monster, npc, target, magic_id, magic_kind, magic_type, isBreak)
  local magic = monster.magics[magic_id]
  if not magic then
    return
  end
  magic:onQuit()
  if isBreak then
    return magic:onBreak(npc, target)
  else
    return magic:onEnd(npc, target)
  end
end

function Me.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile.missile_id == monster.ULT_MIS then
    local role = monster:ninsar()
    change_focus_follow_speed(5)
    role:change_follow_target(1, missile, {
      9999,
      0,
      vec3.zero:Clone(),
      1,
      10,
      0.135
    })
    role:doAfter(function()
      change_focus_follow_speed(4)
      role:change_follow_target(4)
    end, 2.5, true)
  end
end

function Me.onNinsarBack(state)
  state.monster:meltBack()
end

function Me.on_hero_showup_or_back(monster, npc, is_showup, by_ult_change)
  if npc ~= monster:ninsar().npc then
    return
  end
  if not is_showup then
    local state = monster.state
    monster.Me.v_is_in_attack = false
    if state and state.onNinsarBack then
      state:onNinsarBack()
    end
  end
end

function Me.onNinsarMelt(monster)
  local state = monster.state
  monster.Me.v_is_in_attack = false
  if state and state.onNinsarBack then
    state:onNinsarBack()
  end
end

function Me.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  local skill = monster.skills[skill_id]
  local state = skill and skill.state
  if not state or not state.onHit then
    return
  end
  local casterNpc = monster.npc
  state:onHit(casterNpc, hit_target, hit_type, skill, missile)
end

function Me.showUpFx(monster)
  local npc = monster.npc
  cast_magic(npc, npc, monster.SHOW_UP_FX1)
  cast_magic(npc, npc, monster.SHOW_UP_FX2)
  cast_magic(npc, npc, monster.fire_Effect)
end

function Me.tp(monster, pos, lookPos, noFx)
  local role = monster:ninsar()
  pos = pos and role:fixPos(pos)
  if monster.isHiding then
    set_npc_pretend_visible(monster.npc, true, pos.x, pos.y, pos.z)
    monster.isHiding = false
    lookat_position(monster.npc, lookPos.x, lookPos.z, true)
  else
    monster.base.tp(monster, pos, nil, lookPos, nil, role.npc:get_pos_vec3())
  end
  if pos and not noFx then
    monster:showUpFx()
  end
end

function Me.checkInst(Me)
  local inst = Me.inst
  return inst and not inst.npc:is_destroy()
end

function Me.getInst(Me, pos, lookPos)
  local inst = Me.inst
  if not Me:checkInst() then
    Util.debug_output("me.getInst is called but inst is lost")
    return
  end
  inst:tp(pos, lookPos)
  return inst
end

function Me.summon(Me)
  local inst = Me.inst
  if not Me:checkInst() then
    Me.isStartHide = false
    Me:createInst()
  else
    inst:tryState(inst.states.follow)
  end
end

function Me.prepare(Me)
  local inst = Me.inst
  if not Me:checkInst() then
    Me.isStartHide = true
    Me:createInst()
  else
    inst:tryState(inst.states.hide)
  end
end

function Me.createInst(Me)
  local role = Me:ninsar()
  local pos, lookPos = role:atk1_role_pos()
  pos = role:fixPos(pos)
  add_npc(1, 10010191, pos, lookPos, 2, 4)
end

function Me.addInst(monster)
  local Me = monster.Me
  local oldInst = Me.inst
  Me.inst = monster
  if oldInst and oldInst.npc ~= monster.npc and oldInst.npc then
    oldInst:removeInst()
    return
  end
end

function Me.removeInst(monster)
  local Me = monster.Me
  if Me.inst == monster then
    Me.inst = nil
  end
  remove_npc(monster.npc)
end

function Me.hideInst(monster)
  local state = monster.state
  if not state or not state.isHide then
    monster:transState(monster.states.hide, true)
  end
end

function Me.on_remove(monster)
  local Me = monster.Me
  if Me.inst == monster then
    Me.inst = nil
  end
  monster.base.on_remove(monster)
end

function Me.on_start(monster)
  monster:syncTarget()
  if monster.is_started then
    return
  end
  local ninsar = monster:ninsar()
  if ninsar then
    local startState = monster.Me.isStartHide and monster.states.hide
    monster.tree:start(startState)
    monster.is_started = true
  end
  monster:showUpFx()
end

function Me.syncTarget(monster)
  local ninsar = monster:ninsar()
  if not ninsar then
    return
  end
  monster.target = ninsar.target
  return ninsar.target
end

function Me.on_skill_begin(monster, npc, skill_id)
end

function Me.on_skill_end(monster, npc, skill_id)
  if npc ~= monster.npc or check_magic(npc, monster.MELT_OUT) or check_magic(npc, monster.MELT_OUT_BACK) then
    return
  end
  if not check_magic(npc, monster.fire_Effect) then
    cast_magic(npc, npc, monster.fire_Effect)
  end
end

function Me.on_hero_enter_ground_state(monster, npc)
end

function Me.on_born_behavior(monster)
end

function Me.before_damage_self(monster, caster, magic_id, damage_sign, damage_type, camp, change_grading, magic_level, skill_id, missile)
end

function Me.on_toughness_change(monster, npc, camp, change_level)
end

function Me.on_self_npc_hp_zero(monster)
end

function Me.on_target_self_magic_begin(monster, caster, magic_id)
end

function Me.on_target_self_magic_end(monster, caster, magic_id)
end

return Me
