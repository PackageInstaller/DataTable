local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local beAtked, beSkill

function monster._init(monster, npc)
  monster.npc = npc
  set_npc_ignore_sync_area(monster.npc, false)
  set_can_searched(monster.npc, true)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 4032905, 1)
  cast_magic(npc, npc, 300204801, 1)
  set_npc_status(npc, 4, true)
  create_scene_effect("fx_common_monster_born", get_npc_pos(npc), 0)
  cast_magic(monster.npc, monster.npc, 300205403, 1)
  cast_magic(monster.npc, monster.npc, 3001017001, 1)
  monster.npc:set_enable_rvo(false)
  local actSkills = {
    drinkWater = {
      300205401,
      math.huge
    },
    drinkStun = {300205402},
    dash = {300205403}
  }
  local nodes = {"drink", "dashOut"}
  local actMoves = {
    "escape",
    "moveToWater"
  }
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = states
    _ENV.root(_ENV.escape, _ENV.dashOut, _ENV.drink, _ENV.decisionFailed)
    _ENV.drink(_ENV.moveToWater, _ENV.drinkWater)
    _ENV.dashOut(_ENV.dash)
  end
  monster.level = 1
  monster.value = 3
  monster.alert = false
  beAtked = false
  monster.evade = false
  monster.alertInRange = 2.5
  monster.alertExRange = 5.5
  math.randomseed(os.time())
  monster.drinkCD = get_npc_time(monster.npc) + math.random() * 2 + 2
  monster.states.drink.distance = false
  monster.states.escape.closetMis = nil
  monster.states.escape.closetPos = nil
  monster.states.escape.minDis = 999999999
  monster.nightSwitch = true
  monster.arrive = false
  monster.center = {
    x = 0,
    y = get_npc_pos(get_come_on_hero()).y,
    z = 336.5
  }
  do
    local escape = monster.states.escape
    escape.changeTime = 0
    
    function escape.start(escape)
      if monster.arrive == true then
        math.randomseed(os.time())
        monster.angleElapse = math.random(-30, 30)
        monster.TEMP_POS = get_npc_offset_position(monster.npc, monster.center, monster.angleElapse, 100000)
        monster.arrive = false
      else
        math.randomseed(os.time())
        monster.angleElapse = math.random(0, 60) * math.random(-1, 1)
        monster.TEMP_POS = get_npc_offset_position(monster.npc, nil, monster.angleElapse, 100000)
      end
      lookat_position(monster.npc, monster.TEMP_POS.x, monster.TEMP_POS.z, false)
      move_to_pos(monster.npc, monster.TEMP_POS)
      switch_move_type(monster.npc, 1)
      local rValue = math.random() * 2 + 1
      escape.changeTime = get_npc_time(monster.npc) + rValue
    end
    
    function escape.tick(escape)
      print("玩家攻击1" .. tostring(beAtked))
      print("蚊子在边缘" .. tostring(monster.arrive))
      if monster.inAlert(monster, get_npc_pos(monster.npc), get_npc_pos(get_come_on_hero())) < monster.alertExRange and monster.inAlert(monster, get_npc_pos(monster.npc), get_npc_pos(get_come_on_hero())) > monster.alertInRange then
        monster.alert = true
        if true == beAtked then
          monster.evade = true
          print("可以闪避" .. tostring(monster.evade))
        end
      else
        monster.alert = false
      end
      if monster.inAlert(monster, get_npc_pos(monster.npc), get_npc_pos(get_come_on_hero())) > monster.alertExRange and monster.inAlert(monster, get_npc_pos(monster.npc), get_npc_pos(get_come_on_hero())) < 6 and true == beSkill then
        beSkill = false
        if 1 == monster.level then
          monster.evade = true
          print("可以闪避" .. tostring(monster.evade))
        else
        end
      end
      if monster.level < 2 then
        if escape.monster.tool.blueWaters == nil then
          return
        end
        if nil == _G.next(escape.monster.tool.blueWaters) then
          return
        end
        if get_npc_time(monster.npc) <= monster.drinkCD then
          return
        end
        local selfPos = get_npc_pos(escape.monster.npc)
        if nil == selfPos then
          return
        end
        local closetMis = escape.closetMis
        local closetPos = escape.closetPos
        local minDis = escape.minDis
        for _, waterMis in pairs(escape.monster.tool.blueWaters) do
          local misPos = get_missile_pos(waterMis)
          local distSquare = (selfPos.x - misPos.x) * (selfPos.x - misPos.x) + (selfPos.z - misPos.z) * (selfPos.z - misPos.z)
          if waterMis.drinkNum < waterMis.drinkNum_Max and distSquare < minDis * minDis then
            minDis = distSquare ^ 0.5
            closetMis = waterMis
            closetPos = misPos
          end
        end
        if minDis < 20 and escape.monster.tool.blueWaters[closetMis].drinkNum < escape.monster.tool.blueWaters[closetMis].drinkNum_Max then
          escape.monster.states.drink.distance = true
          escape.monster.states.moveToWater.minDis = minDis
          escape.monster.states.moveToWater.closetPos = closetPos
          print("水的位置" .. tostring(closetPos))
          escape.monster.states.moveToWater.closetMis = closetMis
        else
          escape.monster.states.drink.distance = false
        end
      end
    end
    
    function escape.tickTrans(escape)
      if monster.evade == true then
        print("可以闪避2" .. tostring(monster.evade))
        return monster.states.dashOut
      end
      if true == monster.arrive then
        return monster.states.escape
      end
      if get_npc_time(escape.monster.npc) > escape.changeTime then
        return monster.states.escape
      end
      local states = escape.monster.states
      local drink = escape.monster.states.drink
      if drink.isReady(drink) then
        return monster.states.drink
      end
    end
  end
  do
    local dashOut = monster.states.dashOut
    
    function dashOut.start(dashOut)
      print("可以闪避3")
      monster.evade = false
      math.randomseed(os.time())
      monster.angleElapse = math.random(165, 195)
      monster.TEMP_POS = get_npc_offset_position(monster.npc, get_npc_pos(get_come_on_hero()), monster.angleElapse, 100000)
      lookat_position(monster.npc, monster.TEMP_POS.x, monster.TEMP_POS.z, false)
      cast_magic(monster.npc, monster.npc, 300206001, 1)
      dashOut.base.start(dashOut)
    end
    
    function dashOut.tick(dashOut)
      if monster.arrive == true then
        math.randomseed(os.time())
        monster.angleElapse = math.random(-30, 30)
        monster.TEMP_POS = get_npc_offset_position(monster.npc, monster.center, monster.angleElapse, 100000)
        monster.arrive = false
        lookat_position(monster.npc, monster.TEMP_POS.x, monster.TEMP_POS.z, false)
      end
    end
    
    function dashOut.finTrans(dashOut)
      print("闪避结束")
      abort_magic_by_id(monster.npc, 300206001, 1)
      return dashOut.monster.states.escape
    end
  end
  do
    local drink = monster.states.drink
    local drinkWater = monster.states.drinkWater
    local escape = monster.states.escape
    
    function drink.isReady(drink)
      if 2 == monster.level then
        return false
      end
      if monster.tool.blueWaters == nil then
        return false
      end
      if nil == _G.next(monster.tool.blueWaters) then
        return false
      end
      if drinkWater.base.isReady(drinkWater) == false then
        return false
      end
      if false == drink.distance then
        return false
      end
      return true
    end
    
    function drink.start(drink)
      cast_magic(monster.npc, monster.npc, 300205402, 1)
      set_npc_status(npc, 4, false)
      abort_magic_by_id(monster.npc, 3001017001, 1)
    end
    
    function drink.finish(drink)
      local tool = drink.monster.tool
      local closetMis = drink.monster.states.moveToWater.TarMis
      tool.blueWaters[closetMis].drinkNum = tool.blueWaters[closetMis].drinkNum - 1
      monster.level = 2
      monster.value = 2
    end
    
    function drink.finTrans(drink)
      return drink.monster.states.escape
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
        return moveToWater.monster.states.drinkWater
      end
      if _G.next(monster.tool.blueWaters) == nil then
        return moveToWater.monster.states.escape
      end
    end
    
    function moveToWater.finTrans(moveToWater)
      return moveToWater.monster.states.drinkWater
    end
  end
  states.dead.delay.remove = 0.5
end

function monster.on_self_enter_area(monster, areaName)
  local akey = areaName.Key
  if string.sub(akey, 1, 4) == "back" then
    monster.arrive = true
  end
end

function monster.inAlert(monster, selfLocation, playerLocation)
  local distance = ((selfLocation.x - playerLocation.x) ^ 2 + (selfLocation.z - playerLocation.z) ^ 2) ^ 0.5
  return distance
end

function monster:on_input(input_id)
  print("玩家按下id" .. input_id)
  if 15 == input_id then
    beAtked = true
    print("玩家攻击2" .. tostring(beAtked))
  end
end

function monster:on_touch_up(output_id, iscancel)
  if 15 == output_id then
    beAtked = false
    print("玩家攻击2" .. tostring(beAtked))
  end
  if 19 == output_id or 20 == output_id then
    beSkill = true
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if attacker == get_come_on_hero() and missile_cfg.Id ~= 30020570101 then
    if get_cur_room_id() == 800301 or get_cur_room_id() == 800302 or get_cur_room_id() == 800303 or get_cur_room_id() == 800304 then
      if 3 == monster.value then
        cast_magic(monster.npc, monster.npc, 300800503, 1)
      else
        cast_magic(monster.npc, monster.npc, 300800502, 1)
      end
    else
      cast_magic(monster.npc, monster.npc, 300206909, 1)
    end
    cast_magic(monster.npc, monster.npc, 300205302, 1)
  end
  print("get_missile_uuid:" .. tostring(get_missile_uuid(missile)))
end

function monster.on_self_npc_hp_zero(monster, attacker, magic_id, missile_id, missile)
  if get_cur_room_id() == 800301 then
    add_task_progress(8003011, monster.value)
    add_task_progress(8003012, monster.value)
    add_task_progress(8003013, monster.value)
  end
  if get_cur_room_id() == 800302 then
    add_task_progress(8003021, monster.value)
    add_task_progress(8003022, monster.value)
    add_task_progress(8003023, monster.value)
  end
  if get_cur_room_id() == 800303 then
    add_task_progress(8003031, monster.value)
    add_task_progress(8003032, monster.value)
    add_task_progress(8003033, monster.value)
  end
  if get_cur_room_id() == 800304 then
    add_task_progress(8003041, monster.value)
    add_task_progress(8003042, monster.value)
    add_task_progress(8003043, monster.value)
  end
  if get_cur_room_id() == 800601 then
    add_task_progress(8006011, monster.value)
    add_task_progress(8006012, monster.value)
    add_task_progress(8006013, monster.value)
  end
  if get_cur_room_id() == 800602 then
    add_task_progress(8006021, monster.value)
    add_task_progress(8006022, monster.value)
    add_task_progress(8006023, monster.value)
  end
  if get_cur_room_id() == 800603 then
    add_task_progress(8006031, monster.value)
    add_task_progress(8006032, monster.value)
    add_task_progress(8006033, monster.value)
  end
  if get_cur_room_id() == 800604 then
    add_task_progress(8006041, monster.value)
    add_task_progress(8006042, monster.value)
    add_task_progress(8006043, monster.value)
  end
  monster.base.on_self_npc_hp_zero(monster)
end

return monster
