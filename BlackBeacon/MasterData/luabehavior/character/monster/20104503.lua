local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 1.5,
    type = "walk"
  }
  local actSkills = {
    normalAtk = {
      nil,
      3,
      2,
      0,
      4,
      -60,
      60
    },
    drink_water = {
      nil,
      0,
      10 + 10 * math.random(),
      0,
      99999
    },
    drink_stun = {
      nil,
      0,
      0,
      0,
      20
    },
    dashOut = {
      nil,
      15,
      0,
      0,
      4
    },
    dashIn = {
      nil,
      8,
      1 + 3 * math.random(),
      3,
      15,
      -60,
      60
    }
  }
  local nodes = {"drink"}
  local actMoves = {
    "moveToWater",
    "moveToPos"
  }
  monstBase._init(monster, actSkills, actMoves, nodes)
  monster.crystal = true
  monster.states.drink.distance = false
  monster.states.active.closetMis = nil
  monster.states.active.closetPos = nil
  monster.states.active.minDis = 999999999
  monster.nightSwitch = true
  monster.BornPos = get_npc_pos(monster.npc)
  monster.POS1 = get_npc_offset_position(monster.npc, nil, 0, 3)
  monster.POS2 = get_npc_offset_position(monster.npc, nil, 180, 3)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.drink, _ENV.dashIn)
    _ENV.meleeAtk(_ENV.normalAtk)
    _ENV.drink(_ENV.moveToWater, _ENV.drink_water)
    _ENV.noTarget(_ENV.moveToPos, _ENV.idle)
  end
  do
    local active = monster.states.active
    
    function active.tick(active)
      if not check_magic(active.monster.npc, 201045010153) then
        if active.monster.tool.blueWaters == nil then
          return
        end
        if nil == _G.next(active.monster.tool.blueWaters) then
          return
        end
        local selfPos = get_npc_pos(active.monster.npc)
        if nil == selfPos then
          return
        end
        local closetMis = active.closetMis
        local closetPos = active.closetPos
        local minDis = active.minDis
        for _, waterMis in pairs(active.monster.tool.blueWaters) do
          local misPos = get_missile_pos(waterMis)
          local distSquare = (selfPos.x - misPos.x) * (selfPos.x - misPos.x) + (selfPos.z - misPos.z) * (selfPos.z - misPos.z)
          if waterMis.drinkNum < waterMis.drinkNum_Max and minDis > distSquare then
            minDis = distSquare
            closetMis = waterMis
            closetPos = misPos
          end
        end
        if minDis < 180 and active.monster.tool.blueWaters[closetMis].drinkNum < active.monster.tool.blueWaters[closetMis].drinkNum_Max then
          active.monster.states.drink.distance = true
          active.monster.states.moveToWater.minDis = minDis
          active.monster.states.moveToWater.closetPos = closetPos
          active.monster.states.moveToWater.closetMis = closetMis
        else
          active.monster.states.drink.distance = false
        end
      end
    end
    
    local gotTarget = monster.states.gotTarget
    
    function gotTarget.start(gotTarget)
      gotTarget.base.start(gotTarget)
      monster.idleSwitch = false
      set_can_searched(monster.npc, true)
      set_npc_hp_visible(gotTarget.monster.npc, true)
      gotTarget.monster.search.minDis = 8
      gotTarget.monster.search.maxDis = 30
      gotTarget.monster.nightSwitch = false
      if get_cur_room_id() == 104401 or get_cur_room_id() == 104501 then
        gotTarget.monster.search.minDis = 8
        gotTarget.monster.search.maxDis = 99
        gotTarget.monster.nightSwitch = false
      end
      if get_sync_var("qian_night") == true or true == get_sync_var("qian_dark") then
        cast_missile3(monster.npc, monster.npc, nil, nil, 30010220102, 1)
      end
    end
  end
  do
    local wander = monster.states.wander
    local idle = monster.states.idle
    
    function wander.tickTrans(wander)
      local states = wander.monster.states
      local drink = wander.monster.states.drink
      local skill = monster.tree:chooseChildAction(states.attack)
      if not monster.target then
        return states.noTarget
      end
      if skill then
        return skill
      end
      if drink.isReady(drink) then
        return wander.monster.states.drink
      end
    end
  end
  do
    local drink = monster.states.drink
    local drink_water = monster.states.drink_water
    
    function drink.isReady(drink)
      local magic = check_magic(drink.monster.npc, 201045010153)
      if magic then
        return false
      end
      if monster.tool.blueWaters == nil then
        return false
      end
      if nil == _G.next(monster.tool.blueWaters) then
        return false
      end
      if drink_water.base.isReady(drink_water) == false then
        return false
      end
      if false == drink.distance then
        return false
      end
      return true
    end
    
    function drink.finish(drink)
      local tool = drink.monster.tool
      local closetMis = drink.monster.states.moveToWater.TarMis
      tool.blueWaters[closetMis].drinkNum = tool.blueWaters[closetMis].drinkNum - 1
    end
    
    function drink.finTrans(drink)
      return drink.monster.states.active
    end
    
    function drink_water.finish(drink)
      cast_magic(self, self, 201045010153, 1)
      local missile = drink.monster.states.moveToWater.TarMis
      local MisId = missile.missile_id
      if 201046010801 == MisId or 201046010802 == MisId or 201046010803 == MisId then
        stop_missile(missile)
      end
    end
  end
  do
    local moveToWater = monster.states.moveToWater
    
    function moveToWater.start(moveToWater)
      cast_magic(monster.npc, monster.npc, 2020470103, 1)
      moveToWater.TarMis = moveToWater.closetMis
      moveToWater.TarPos = moveToWater.closetPos
      moveToWater.randomPos = get_position_offset_position(moveToWater.TarPos, moveToWater.TarPos, math.random(0, 360), 3 * math.random())
      move_to_pos(moveToWater.monster.npc, moveToWater.randomPos)
      switch_move_type(moveToWater.monster.npc, 0)
      local tool = moveToWater.monster.tool
      local closetMis = monster.states.moveToWater.closetMis
      tool.blueWaters[closetMis].drinkNum = tool.blueWaters[closetMis].drinkNum + 1
    end
    
    function moveToWater.tickTrans(moveToWater)
      local pos = moveToWater.randomPos
      local closetMis = monster.states.moveToWater.closetMis
      local Dis = moveToWater.monster.tool.blueWaters[closetMis].drinkDis
      if check_npc_distance_to_pos(moveToWater.monster.npc, pos.x, pos.z, Dis, true) then
        return moveToWater.monster.states.drink_water
      end
      if _G.next(monster.tool.blueWaters) == nil then
        return moveToWater.monster.states.active
      end
      
      function moveToWater.finTrans(moveToWater)
        return moveToWater.monster.states.wander
      end
    end
  end
  do
    local moveToPos = monster.states.moveToPos
    local POS = monster.POS1
    local idle = monster.states.idle
    
    function moveToPos.isReady()
      return true
    end
    
    function moveToPos.start()
      lookat_position(monster.npc, POS.x, POS.z, false)
      move_to_pos(monster.npc, POS)
    end
    
    function moveToPos.tickTrans()
      if check_npc_distance_to_pos(monster.npc, POS.x, POS.z, 1, false) then
        return idle
      end
    end
    
    idle.cd = 2
    
    function idle.start()
      idle.timer = get_npc_time(monster.npc) + idle.cd
      if POS == monster.POS1 then
        POS = monster.POS2
      else
        POS = monster.POS1
      end
      stop_move(monster.npc)
    end
    
    function idle.tickTrans()
      local drink = idle.monster.states.drink
      if drink.isReady(drink) then
        return idle.monster.states.drink
      end
      if idle.monster.target then
        return monster.states.gotTarget
      end
      if get_npc_time(monster.npc) > idle.timer then
        return moveToPos
      end
    end
  end
end

function monster.on_missile_end_pos(monster, owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201046010801 or missile_cfg.Id == 201046010802 or missile_cfg.Id == 201046010803 then
    monster.tool.blueWaters[missile] = nil
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if get_npc_group_id(monster.npc) == 10410221 then
    monster.search.minDis = 2
    monster.search.maxDis = 5
  end
  if get_sync_var("qian_night") == true then
    monster.search.minDis = 2
    monster.search.maxDis = 2
  end
  if true == get_sync_var("qian_dark") then
    monster.search.minDis = 4
    monster.search.maxDis = 4
  end
  if true == get_sync_var("nightSwitch") and true == monster.nightSwitch then
    set_npc_hp_visible(monster.npc, false)
  end
  if true == get_sync_var("darkSwitch") and true == monster.nightSwitch then
    set_npc_hp_visible(monster.npc, false)
  end
end

function monster.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  if 40104404 == magic_id then
    monster.search.minDis = 8
    monster.search.maxDis = 30
  end
end

return monster
