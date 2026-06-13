local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local warnning = 0.6
local skip = false
local window = 0.3
local startUp = false
local red_skill_count = 0
local red_skill_counter_count = 0
Log.Errorf("红技弹反测试重置，当前配置为 跳过前摇：%q，  缩圈时长：%.1f， 窗口时长：%.2f", skip, warnning, window)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 3
  local t = monster.create_skill_node_cfg
  local skills = {
    Stab = t(2090550107, 0, math.random(3), 0, 5, -60, 60)
  }
  monster.red_skill_count = 0
  monster.red_skill_counter_count = 0
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.Stab)
  end
  local states = monster.states
  
  function states.Stab.start(Stab)
    red_skill_count = red_skill_count + 1
    Log.Errorf("红技释放总次数为%d, 弹反成功次数为%d, 弹反成功率为%.4f%%", red_skill_count, red_skill_counter_count, red_skill_counter_count / red_skill_count * 100)
    Stab.base.start(Stab)
  end
  
  function states.Stab.finish(Stab)
    Stab.base.finish(Stab)
    Stab.timer = Stab.timer + math.random() * 3
  end
  
  states.attack.interval = 0
end

function monster.on_red_skill_countered_fx(monster, attackerNpc, missile)
  monster.base.on_red_skill_countered_fx(monster, attackerNpc, missile)
  cast_magic(attackerNpc, attackerNpc, 1999351)
  monster.states.Stab.timer = monster.states.Stab.timer + 3
  red_skill_counter_count = red_skill_counter_count + 1
  Log.Errorf("红技释放总次数为%d, 弹反成功次数为%d, 弹反成功率为%.4f%%", red_skill_count, red_skill_counter_count, red_skill_counter_count / red_skill_count * 100)
end

return monster
