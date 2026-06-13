local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local skillDictionary = {
  pisarNum = 2010710101,
  lanzaNum = 2010710102,
  comboNum = 2010710103,
  diveNum = 2010710104,
  diveEndNum = 2010710115,
  poleNum = 2010710105,
  vaultingNum = 2010710106,
  kickNum = 2010710107,
  bombarNum = 2010710108,
  plumaNum = 2010710109,
  mr2leftNum = 2010710110,
  mr2rightNum = 2010710111,
  somersaultNum = 2010710112,
  pinchaNum = 2010710113,
  pinchaEndNum = 2010710116,
  atrasNum = 2010710114
}

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 5,
    maxDis = 8,
    minTime = 1.5,
    maxTime = 1.5,
    type = "run"
  }
  monster.search = {minDis = 100, maxDis = 100}
  local t = monster.create_skill_node_cfg
  local actSkills = {
    pisar = t(2010710101, 5, 5, 0, 4),
    lanza = t(2010710102, 7, 0, 0, 4),
    atras = t(2010710113, 10, 25, 0, 3)
  }
  local nodes = {
    "poleVaultingKick",
    "shemale"
  }
  monstBase._init(monster, actSkills, nil, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.wander)
    _ENV.evade()
    _ENV.freeAtk(_ENV.pisar, _ENV.lanza)
  end
  do
    local dead = monster.states.dead
    dead.delay = {fx = 0.5, remove = 1.5}
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 1 == get_role_kind(hit_target) then
    if skill_id == skillDictionary.comboNum and missile_cfg.id == "第三击" then
      monster.combo3rd = true
    end
    if skill_id == skillDictionary.comboNum then
      monster.heavyKick = true
    end
  end
end

return monster
