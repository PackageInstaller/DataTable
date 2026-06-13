local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2010100306
  monster.list1 = {}
  local skills = {
    WaterPool = {
      2010100303,
      10,
      2 + 2 * math.random(),
      0,
      8,
      -60,
      60
    },
    Straight_wave = {
      2010100302,
      2 + 3 * math.random(),
      4,
      1,
      8,
      -60,
      60
    },
    Needling = {
      2010100308,
      2 + 2 * math.random(),
      3,
      0,
      3,
      -60,
      60
    }
  }
  monstBase._init(monster, skills)
  monster.Watermissile = {}
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.Arc_wave, _ENV.Needling)
    _ENV.freeAtk(_ENV.WaterPool)
  end
  if monster.tool.WaterPool_switch == nil then
    monster.tool.WaterPool_switch = true
  end
  monster.list1 = search_npc(monster.npc, 3, 8, 10440402, false, true)
  do
    local WaterPool = monster.states.WaterPool
    
    function WaterPool.isReady(WaterPool)
      if not WaterPool.base.isReady(WaterPool) then
        return false
      end
      if WaterPool.monster.tool.WaterPool_switch == false then
        return false
      end
      return true
    end
    
    function WaterPool.start(WaterPool)
      local self = WaterPool.monster
      WaterPool.isCastOver = false
      local skill = WaterPool.skill
      WaterPool.curSk = skill
      skill.state = WaterPool
      abort_skill(self.npc, true)
      WaterPool.timer = get_npc_time(WaterPool.monster.npc) + WaterPool.cd
      skill.isCastOver = false
      skill.castTimer = get_npc_time(self.npc) + skill.befTime + skill.castTime
      local now_enemy_pos = get_npc_pos(self.target)
      cast_skill(self.npc, nil, 2010100303, now_enemy_pos.x, now_enemy_pos.z)
      WaterPool.monster.tool.WaterPool_switch = false
    end
  end
end

function monster:updateWaterPoolTimer()
  self.skills.WaterPool.timer = get_npc_time(self.npc) + 1 + 2 * math.random()
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile, is_break)
  if missile_cfg.Id == 201010010301 then
    local list1 = monster.list1
    monster.tool.WaterPool_switch = true
    if _G.next(list1) ~= nil then
      for _, value in pairs(list1) do
        if get_npc_attr(value, 1) > 0 then
          cast_magic(value, value, 1999221)
          value:get_behavior().updateWaterPoolTimer(monster)
        end
      end
    end
  end
end

return monster
