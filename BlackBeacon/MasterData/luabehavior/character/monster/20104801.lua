local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
monster.difficulty_init = {
  [Const.DIFFICULTY_TAG.HARD] = function(monster)
    local states = monster.states
    local skills = monster.skills
    states.FlyHitFromEarthend2.cd = 40
    states.Defend.cd = 0
    states.Defend.maxDis = 999
    do
      local _ENV = states
      _ENV.freeAtk()
      _ENV.gotTarget(_ENV.attack, _ENV.wander)
      _ENV.attack(_ENV.freeAtk)
      _ENV.freeAtk(_ENV.TriHitGroundComboPhase2, _ENV.HuizhongEX23, _ENV.HuiZhongNormal, _ENV.SpecialAttackCombo(_ENV.TriHitGroundCombo, _ENV.PingPongCombo, _ENV.wingsbrustCombo), _ENV.NormalAttackCombo(_ENV.MaleeCombo, _ENV.RangeCombo), _ENV.Other(_ENV.RetreatComboSecond1))
      _ENV.attack.interval = 1.7
      _ENV.MaleeCombo(_ENV.normalAttack, _ENV.pushawayCombo, _ENV.retreatCombo)
      _ENV.normalAttack(_ENV.combohit(_ENV.biansu))
      _ENV.pushawayCombo(_ENV.pushaway3(_ENV.biansu, _ENV.watertornadoEnd))
      _ENV.retreatCombo(_ENV.retreat)
      _ENV.RetreatComboSecond1(_ENV.pushawayRetreat, _ENV.watertornadoRetreat, _ENV.biansuretreat)
      _ENV.RangeCombo(_ENV.flyhitEarth, _ENV.watertornadoCombo)
      _ENV.flyhitEarth(_ENV.FlyHitFromEarth(_ENV.RealHit(_ENV.biansu, _ENV.pushawayEnd)))
      _ENV.watertornadoCombo(_ENV.watertornado(_ENV.FlyHitFromEarth2))
      _ENV.FlyHitFromEarth2(_ENV.RealHit2)
      _ENV.wingsbrustCombo(_ENV.wingsbrust(_ENV.flyidle(_ENV.watertornadoWingsBrust(_ENV.FlyHitFromAir))))
      _ENV.FlyHitFromAir(_ENV.RealHit3)
      _ENV.PingPongCombo(_ENV.HuizhongPingPong1(_ENV.HuizhongPingPong2), _ENV.PingPongStart)
      _ENV.PingPongStart(_ENV.PingPongStartLoop)
      _ENV.PingPongStartLoop(_ENV.PingPongStartLoopEnd, _ENV.PingPongSecond)
      _ENV.PingPongStartLoopEnd(_ENV.Defend)
      _ENV.PingPongSecond(_ENV.PingPongSecondEnd(_ENV.Defend1))
      _ENV.TriHitGroundCombo(_ENV.FlyHitFromEarthend2(_ENV.RealHitloop1(_ENV.RealHitloop2(_ENV.RealHitend))))
      _ENV.TriHitGroundComboPhase2(_ENV.FlyHitFromEarthend2)
      _ENV.HuiZhongNormal(_ENV.Huizhong(_ENV.HuizhongEnd(_ENV.watertornadoHuizhong(_ENV.watertornadoHuizhong2(_ENV.watertornadoHuizhong3)))))
      _ENV.HuizhongEX23(_ENV.HuizhongEX(_ENV.HuizhongEndEX(_ENV.watertornadoHuizhongEX(_ENV.watertornadoHuizhongEX2(_ENV.watertornadoHuizhongEX3)))))
    end
    
    function states.retreat.tickTrans(retreat)
      if check_magic(monster.npc, 2010480160) then
        return monster.states.RetreatComboSecond1
      end
    end
    
    function skills.pushaway.onBegin(pushaway)
      pushaway.base.onBegin(pushaway)
    end
    
    function skills.pushaway.onEnd(pushaway)
      pushaway.base.onEnd(pushaway)
    end
    
    function skills.pushaway.onBreak(pushaway)
      pushaway.base.onBreak(pushaway)
    end
    
    function states.MaleeCombo.isReady(MaleeCombo)
      local player = get_come_on_hero()
      local disPlayer = get_npc_distance(monster.npc, 1, player, true)
      if disPlayer < 4 then
        monster.randomNum = math.random()
        return true
      end
      return false
    end
    
    function states.NormalAttackCombo.start(NormalAttackCombo)
      if -1.0 == monster.comboTime then
        monster.comboTime = get_npc_time(monster.npc)
      end
    end
    
    function states.pushaway3.isReady(pushaway3)
      return pushaway3.base.isReady(pushaway3) and monster.randomNum > 0.5
    end
    
    function states.normalAttack.isReady(normalAttack)
      if 1 ~= monster.statepre and monster.randomNum < 0.5 then
        return true
      end
      return false
    end
    
    function states.combohit.start(combohit)
      combohit.base.start(combohit)
      monster.statepre = 1
    end
    
    function states.pushawayCombo.isReady(pushawayCombo)
      if 2 ~= monster.statepre and monster.randomNum > 0.5 then
        return true
      end
      return false
    end
    
    function states.pushaway3.start(pushaway3)
      pushaway3.base.start(pushaway3)
      monster.statepre = 2
    end
    
    function states.RangeCombo.isReady(RangeCombo)
      monster.randomNum = math.random()
      return RangeCombo.base.isReady
    end
    
    function states.flyhitEarth.isReady(flyhitEarth)
      return monster.randomNum < 0.4
    end
    
    function states.RealHit.isReady(RealHit)
      return true
    end
    
    function states.RealHit2.isReady(RealHit)
      return true
    end
    
    function states.RealHit3.isReady(RealHit)
      return true
    end
    
    function states.wander.start(wander)
      wander.base.start(wander)
    end
    
    function states.SpecialAttackCombo.isReady(NormalAttackCombo)
      local curTime = get_npc_time(monster.npc)
      if -1.0 == monster.comboTime then
        return false
      end
      if curTime - monster.comboTime > 15 then
        monster.randomNum = math.random()
        return true
      end
      return false
    end
    
    function states.wingsbrustCombo.start(wingsbrustCombo)
      wingsbrustCombo.base.start(wingsbrustCombo)
    end
    
    function states.HuizhongPingPong1.isReady(HuizhongPingPong1)
      local posx, posy, posz = get_area_pos("M1")
      local dis = get_npc_distance(monster.npc, 2, posx, posz, false)
      return dis > 19
    end
    
    function states.HuizhongPingPong2.finTrans(HuizhongPingPong2)
      return states.PingPongStart
    end
    
    function states.PingPongCombo.isReady(PingPongCombo)
      if monster.randomNum < 0.6 then
        return true
      end
      return false
    end
    
    function states.SpecialAttackCombo.finish(SpecialAttackCombo)
      monster.comboTime = -1.0
    end
    
    function states.TriHitGroundComboPhase2.isReady(TriHitGroundComboPhase2)
      if 2 == monster.phase and monster.aircrash == true then
        abort_skill(monster.npc, true)
        return true
      else
        return false
      end
    end
    
    function states.TriHitGroundCombo.isReady(TriHitGroundCombo)
      if 2 == monster.phase then
        return true
      else
        return false
      end
    end
    
    function skills.FlyHitFromEarthend2.onBegin(FlyHitFromEarthend2)
      remove_missile_by_id(201048010103, monster.npc, true)
    end
    
    function skills.Huizhong.onBegin(Huizhong)
    end
    
    function skills.FlyHitFromEarthend2.tick(FlyHitFromEarthend2)
      if check_magic(monster.npc, 2010480134) then
        set_npc_pos(monster.npc, "M1")
        monster.aircrash = false
      end
    end
    
    function skills.Huizhong.tick(Huizhong)
      if check_magic(monster.npc, 2010480134) then
        set_npc_pos(monster.npc, "M1")
        monster.aircrash = false
      end
    end
    
    function skills.HuizhongEnd.onBegin(HuizhongEnd)
      monster.aircrash = false
      monster.HuizhongEndCast = true
    end
    
    function skills.HuizhongEnd.tick(HuizhongEnd)
      if check_magic(monster.npc, 2010480122) and monster.HuizhongEndCast then
        monster.HuizhongEndCast = false
      end
    end
    
    function skills.RealHitloop1.onBegin(RealHitloop1)
      enable_shadow(monster.npc, true)
    end
    
    function skills.RealHitloop1.tick(RealHitloop1)
      if check_magic(monster.npc, 2010480135) and not monster.phase2SkillOver then
        set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Water_1", true)
      end
    end
    
    function skills.RealHitloop2.onBegin(RealHitloop2)
      monster.aircrash = false
    end
    
    function skills.RealHitloop2.tick(RealHitloop2)
      if check_magic(monster.npc, 2010480136) and not monster.phase2SkillOver then
        set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Water_2", true)
      end
    end
    
    function skills.RealHitend.onBegin(RealHitend)
      monster.aircrash = false
    end
    
    function skills.RealHitend.tick(RealHitend)
      if check_magic(monster.npc, 2010480137) then
        cast_magic(monster.npc, monster.npc, 2010480122, 0)
        if not monster.phase2SkillOver then
          switch_bgm_block("bgm_qian_he", 2)
          set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Water_3", true)
          set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Rain", true)
          set_sceneobj_visible_save_state("/Root/Level/Level_boss/water", true)
          set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Smoke_2", true)
          set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Smoke_1", false)
          SceneMgr:scene_illumination_defualt_to_second(1)
          call_scene_logic_custom_event("rain")
        end
        monster.phase2SkillOver = true
      end
    end
    
    function states.HuizhongEX23.isReady(HuizhongEX23)
      local posx, posy, posz = get_area_pos("M1")
      local dis = get_npc_distance(monster.npc, 2, posx, posz, false)
      return dis > 21
    end
    
    function states.HuiZhongNormal.isReady(HuiZhongNormal)
      local posx, posy, posz = get_area_pos("M1")
      local dis = get_npc_distance(monster.npc, 2, posx, posz, false)
      return dis > 19
    end
    
    function states.Other.isReady(Other)
      return false
    end
    
    function skills.combohit.onBegin(combohit)
      cast_magic(monster.npc, monster.npc, 2010480201, 1)
    end
    
    function skills.biansu.onBegin(biansu)
      biansu.base.onBegin(biansu)
      monster.hitSongzhi = false
    end
    
    function skills.biansu.tick(biansu)
      local player = get_come_on_hero()
      local pos = get_npc_pos(player)
      local offse = get_dir_offset(monster.npc, pos.x, pos.z)
      if offse <= 90 then
        set_keyframe_enable(monster.npc, 201048013812, true, true)
      else
        set_keyframe_enable(monster.npc, 201048013812, false, true)
      end
      local hepos = get_npc_offset_position(monster.npc, nil, 0, 8)
      if check_magic(monster.npc, 2010480123) and 1 ~= monster.phase and monster.aircrash == false then
        abort_magic_by_id(monster.npc, 2010480123, 1)
        cast_missile(monster.npc, nil, nil, nil, 201048010107)
        cast_missile(monster.npc, nil, nil, nil, 201048010108)
        cast_missile(monster.npc, nil, nil, nil, 201048010109)
        cast_missile(monster.npc, nil, nil, nil, 201048010110)
        cast_missile(monster.npc, nil, nil, nil, 201048010111)
      end
      if check_magic(monster.npc, 2010480202) then
        cast_magic(monster.npc, monster.npc, 2010480201, 1)
      end
    end
    
    function skills.biansu.onEnd(biansu)
      abort_magic_by_id(monster.npc, 2010480201)
      biansu.base.onEnd(biansu)
    end
    
    function skills.watertornado.onBegin(watertornado)
      if 1 == monster.phase then
        cast_missile(monster.npc, nil, nil, nil, 201048010117)
        cast_missile(monster.npc, nil, nil, nil, 201048010118)
      end
      if 2 == monster.phase then
        cast_missile(monster.npc, nil, nil, nil, 201048010119)
        cast_missile(monster.npc, nil, nil, nil, 201048010120)
        cast_missile(monster.npc, nil, nil, nil, 201048010121)
      end
    end
    
    function skills.watertornadoAir.onBegin(watertornadoAir)
      if 1 == monster.phase then
        cast_missile(monster.npc, nil, nil, nil, 201048010117)
        cast_missile(monster.npc, nil, nil, nil, 201048010118)
      end
      if 2 == monster.phase then
        cast_missile(monster.npc, nil, nil, nil, 201048010119)
        cast_missile(monster.npc, nil, nil, nil, 201048010120)
        cast_missile(monster.npc, nil, nil, nil, 201048010121)
      end
    end
    
    function skills.FlyHitFromEarth.tick(FlyHitFromEarth)
      if check_magic(monster.npc, 2010480207) then
        local player = get_come_on_hero()
        local heplay = get_npc_pos(player)
        monster.skillCamera = true
        enable_shadow(monster.npc, false)
        change_follow_target(1, player, {
          0,
          0,
          {
            heplay.x,
            heplay.y,
            heplay.z
          },
          0,
          0,
          0.55,
          focal_mode = 1
        })
      end
    end
    
    function states.PingPongStart.isReady(PingPongStart)
      local ready = PingPongStart.base.isReady(PingPongStart)
      return ready
    end
    
    function skills.FlyHitFromEarth.onBegin(FlyHitFromEarth)
      monster.IsFlying = true
    end
    
    function skills.FlyHitFromAir.onBegin(FlyHitFromAir)
      monster.IsFlying = true
    end
    
    function skills.RealHit.onBegin(RealHit)
      RealHit.base.onBegin(RealHit)
      enable_shadow(monster.npc, true)
      remove_missile_by_id(201048011104, monster.npc, true)
      remove_missile_by_id(201048010104, monster.npc, false)
      local player = get_come_on_hero()
      local pos = get_npc_pos(player)
      local offse = get_dir_offset(monster.npc, pos.x, pos.z)
      abort_magic_by_id(monster.npc, 2010480212)
      if offse <= 90 then
        set_keyframe_enable(monster.npc, 201048010406, true, true)
      else
        set_keyframe_enable(monster.npc, 201048010406, false, true)
      end
      monster.skillCamera = false
      change_follow_target(4)
    end
    
    function skills.RealHit.tick(RealHit)
      if check_magic(monster.npc, 2010480159) then
        monster.IsFlying = false
      end
    end
    
    function skills.retreat.onBegin(retreat)
      if 1 == monster.phase then
        set_keyframe_enable(monster.npc, 201048012602, false, true)
      end
      if 1 ~= monster.phase and monster.aircrash == false then
        set_keyframe_enable(monster.npc, 201048012602, true, true)
      end
      local player = get_come_on_hero()
      local pos = get_npc_pos(player)
      local offse = get_dir_offset(monster.npc, pos.x, pos.z)
      if offse <= 270 then
        set_keyframe_enable(monster.npc, 201048012607, true, true)
      else
        set_keyframe_enable(monster.npc, 201048012607, false, true)
      end
    end
    
    function states.PingPongStartLoop.tick(PingPongStartLoop)
      PingPongStartLoop.base.tick(PingPongStartLoop)
      if monster.PingPongMissile then
        local player = get_come_on_hero()
        local disPlayer = get_npc_distance(monster.npc, 1, player, true)
        local PingPongDis = get_npc_missile_distance(monster.npc, monster.PingPongMissile)
        if PingPongDis > disPlayer + 3 or 0 == PingPongDis then
          monster.tree:derive(monster.states.PingPongStartLoopEnd)
        end
        if PingPongDis < 12 and 1 == monster.SecondRebound then
          monster.tree:derive(monster.states.PingPongSecond)
        end
      else
        monster.tree:derive(monster.states.PingPongStartLoopEnd)
      end
    end
    
    function skills.PingPongStart.onBegin(PingPongStart)
      PingPongStart.base.onBegin(PingPongStart)
      monster.SecondRebound = 0
      monster.PingPongMissile = nil
      set_keyframe_enable(monster.npc, 201048011209, false, true)
      set_keyframe_enable(monster.npc, 201048011219, false, true)
    end
    
    function skills.wingsbrust.onBegin(wingsbrust)
      wingsbrust.base.onBegin(wingsbrust)
      local heplay = get_npc_pos(monster.npc)
      set_scene_tips(20104802, true, {})
      monster.hitSongzhi = false
      set_keyframe_enable(monster.npc, 201048010607, false, true)
      set_keyframe_enable(monster.npc, 201048010608, false, true)
      set_keyframe_enable(monster.npc, 201048010609, false, true)
      set_keyframe_enable(monster.npc, 201048010610, false, true)
      set_keyframe_enable(monster.npc, 201048010611, false, true)
      set_keyframe_enable(monster.npc, 201048010612, false, true)
      set_keyframe_enable(monster.npc, 201048010613, false, true)
      set_keyframe_enable(monster.npc, 201048010614, false, true)
    end
    
    function states.flyidle.tick(flyidle)
      if check_magic(monster.npc, 2010480158) then
        abort_skill(monster.npc)
        flyidle:derive()
      end
      flyidle.base.tick(flyidle)
    end
    
    function states.PingPongStart.tick(PingPongStart)
      PingPongStart.base.tick(PingPongStart)
      if monster.PingPongMissile then
        if monster.missileRound then
          remove_missile_by_id(201048010130)
          monster.missileRound = false
        end
        local player = get_come_on_hero()
        local disPlayer = get_npc_distance(monster.npc, 1, player, true)
        local PingPongDis = get_npc_missile_distance(monster.npc, monster.PingPongMissile)
        if PingPongDis > disPlayer + 3 or 0 == PingPongDis then
          monster.tree:derive(monster.states.PingPongStartLoopEnd)
        end
        if PingPongDis < 12 and 1 == monster.SecondRebound then
          monster.tree:derive(monster.states.PingPongSecond)
        end
      end
    end
    
    function skills.PingPongSecond.tick(PingPongSecond)
      if monster.PingPongMissile then
        local player = get_come_on_hero()
        local PingPongDis = get_npc_missile_distance(monster.npc, monster.PingPongMissile)
        if PingPongDis < 5 and 1 == monster.SecondRebound then
          cast_magic(monster.npc, monster.npc, 2010480144, 1)
          cast_magic(monster.npc, monster.npc, 2010480145, 1)
          cast_missile(monster.npc, monster.npc, get_npc_pos(monster.npc).x, get_npc_pos(monster.npc).z + 2, 201048010115, 1, get_npc_pos(monster.npc).x, get_npc_pos(monster.npc).z + 2, get_npc_pos(monster.npc).y, get_npc_pos(monster.npc).y, get_npc_pos(monster.npc).x, get_npc_pos(monster.npc).z)
          rebound_missile(monster.PingPongMissile, monster.npc, player, get_npc_pos(player).x, get_npc_pos(player).y, 15, false, false, true)
          cast_magic(monster.npc, player, 2010480146, 1)
          cast_magic(monster.npc, monster.npc, 2010480147, 1)
          cast_magic(monster.npc, monster.npc, 2010480148, 1)
          monster.SecondRebound = monster.SecondRebound + 1
        end
      end
    end
    
    do
      local Defend = skills.Defend
      local DefendAttack = skills.DefendAttack
      Defend(DefendAttack)
      
      function skills.Defend.tick(Defend)
        Defend.base.tick(Defend)
        if check_magic(monster.npc, 2010480131) then
          monster.BOOMDefend = true
          abort_magic_by_id(monster.npc, 2010480131, 1)
          monster.BOOMDefend = true
          abort_skill(monster.npc)
          Defend:deriveAuto()
        end
        if true == monster.BeHitInDefend then
          abort_skill(monster.npc)
          Defend:deriveAuto()
        end
      end
      
      function skills.Defend.onBegin(Defend)
        Defend.base.onBegin(Defend)
        set_scene_tips(20104803, true, {})
        remove_missile_by_id(201048010103, monster.npc, true)
        set_keyframe_enable(monster.npc, 201048012003, false, true)
      end
      
      function skills.Defend.onEnd(Defend)
        Defend.base.onEnd(Defend)
        set_scene_tips(20104803, false, {})
        monster.BeHitInDefend = true
      end
      
      function skills.DefendAttack.onEnd(DefendAttack)
        DefendAttack.base.onEnd(DefendAttack)
      end
      
      function skills.DefendAttack.isReady()
        if monster.BeHitInDefend == true or true == monster.BOOMDefend then
          return true
        else
          return false
        end
      end
      
      function DefendAttack.onBegin()
        monster.BOOMDefend = false
        remove_missile_by_id(201048012004, monster.npc, true)
        remove_missile_by_id(201048012009, monster.npc, true)
        remove_missile_by_id(201048012003, monster.npc, true)
        cast_missile(monster.npc, nil, nil, nil, 201048010122)
        cast_missile(monster.npc, nil, nil, nil, 201048010124)
        cast_missile(monster.npc, nil, nil, nil, 201048010126)
        if 1 == monster.phase then
          set_keyframe_enable(monster.npc, 201048012106, false, true)
        else
          set_keyframe_enable(monster.npc, 201048012106, true, true)
        end
        monster.BeHitInDefend = false
      end
    end
  end
}

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 2,
    maxDis = 10,
    minTime = 1.2,
    maxTime = 2,
    type = "walk"
  }
  monster.search = {minDis = 200, maxDis = 200}
  monster.phase = 1
  monster.phase2SkillOver = false
  monster.ShouldStopPingPong = false
  monster.PingPongMissile = nil
  monster.songzhiMissile = nil
  monster.IsSurfing = false
  monster.IsFlying = false
  monster.BeHitInDefend = false
  monster.BOOMDefend = false
  monster.aircrash = false
  monster.BOOMNPC = false
  monster.BOOMmonster = false
  monster.camera1 = false
  monster.ON3 = false
  monster.fxwu = false
  monster.hitSongzhi = false
  monster.songzhi = false
  monster.biansuOver = false
  monster.longjuanCastOver = false
  monster.HuizhongEndCast = false
  monster.taiji = false
  monster.taijipos = nil
  monster.skillCamera = false
  monster.taijiposNPC = nil
  monster.TANQIU = nil
  monster.SecondRebound = 0
  monster.comboTime = -1.0
  monster.randomNum = 0.1
  monster.statepre = -1
  monster.bornpointX, monster.bornpointY, monster.bornpointZ = get_area_pos("bornpoint")
  monster.bornpoint = {
    x = monster.bornpointX,
    y = monster.bornpointY,
    z = monster.bornpointZ
  }
  monster.check_story_wingsbrust = false
  monster.check_story_zadi = false
  monster.check_story_overZadi = false
  monster.check_story_start = false
  monster.mainStoryRoomID = 1061201
  monster.missileRound = false
  monster.CameraAbort = false
  local t = monster.create_skill_node_cfg
  local actSkills = {
    combohit = t(2010480102, 0, 0, 0, 7, -60, 60),
    biansu = t(2010480138, 0, 0, 0, 6),
    biansuretreat = t(2010480138, 0, 0, 0, 7),
    watertornado = t(2010480107, 0, 0, 8),
    watertornadoWingsBrust = t(2010480203),
    watertornadoEnd = t(2010480107, 0, 0, 6),
    FlyHitFromEarth = t(2010480103, 10),
    FlyHitFromEarth2 = t(2010480103, 10),
    FlyHitFromAir = t(2010480105),
    RealHit = t(2010480104),
    RealHit2 = t(2010480104),
    RealHit3 = t(2010480104),
    retreat = t(2010480126, 5, 0, 0, 5, 60),
    PingPongStart = t(2010480112, 0, 0, 0, 20),
    PingPongStartLoop = t(2010480113),
    PingPongStartLoopEnd = t(2010480114),
    PingPongSecond = t(2010480115),
    PingPongSecondEnd = t(2010480117),
    Defend = t(2010480120, 40, 0, 0, 8),
    DefendAttack = t(2010480121),
    wingsbrust = t(2010480106),
    flyidle = t(2010480109),
    pushawayEnd = t(2010480136, 0, 0, 0, 10, -60, 60),
    pushaway2 = t(2010480136, 0, 0, 0, 10, -60, 60),
    pushaway3 = t(2010480136, 0, 0, 0, 10, -60, 60),
    FlyHitFromEarthend2 = t(2010480135, 30),
    RealHitloop1 = t(2010480130),
    RealHitloop2 = t(2010480131),
    RealHitend = t(2010480132),
    Huizhong = t(2010480201, 30),
    HuizhongEnd = t(2010480202),
    watertornadoHuizhong = t(2010480107, 0, 0, 8),
    watertornadoHuizhong2 = t(2010480107, 0, 0, 8),
    watertornadoHuizhong3 = t(2010480107, 0, 0, 8),
    HuizhongEX = t(2010480201),
    HuizhongEndEX = t(2010480202),
    HuizhongPingPong1 = t(2010480201),
    HuizhongPingPong2 = t(2010480202),
    watertornadoHuizhongEX = t(2010480107),
    watertornadoHuizhongEX2 = t(2010480107),
    watertornadoHuizhongEX3 = t(2010480107),
    pushawayRetreat = t(2010480136, 0, 0, 0, 8, -60, 60),
    watertornadoRetreat = t(2010480107, 0, 0, 6),
    Defend1 = t(2010480120)
  }
  local nodes = {
    "NormalAttackCombo",
    "retreatCombo",
    "normalAttack",
    "MaleeCombo",
    "flyhitEarth",
    "RangeCombo",
    "watertornadoCombo",
    "pushawayCombo",
    "RetreatComboSecond1",
    "SpecialAttackCombo",
    "PingPongCombo",
    "wingsbrustCombo",
    "TriHitGroundCombo",
    "TriHitGroundComboPhase2",
    "HuiZhongCombo",
    "HuiZhongNormal",
    "HuizhongEX23",
    "Other"
  }
  monstBase._init(monster, actSkills, nil, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = states
    _ENV.gotTarget(_ENV.attack, _ENV.wander)
    _ENV.attack(_ENV.freeAtk)
    _ENV.freeAtk(_ENV.TriHitGroundComboPhase2, _ENV.HuizhongEX23, _ENV.HuiZhongNormal, _ENV.SpecialAttackCombo(_ENV.Defend, _ENV.PingPongCombo, _ENV.wingsbrustCombo), _ENV.NormalAttackCombo(_ENV.MaleeCombo, _ENV.RangeCombo), _ENV.Other(_ENV.RetreatComboSecond1))
    _ENV.attack.interval = 1.7
    _ENV.MaleeCombo(_ENV.normalAttack, _ENV.pushawayCombo, _ENV.retreatCombo)
    _ENV.normalAttack(_ENV.combohit)
    _ENV.pushawayCombo(_ENV.pushaway3(_ENV.biansu))
    _ENV.retreatCombo(_ENV.retreat)
    _ENV.RetreatComboSecond1(_ENV.pushawayEnd, _ENV.watertornadoEnd, _ENV.biansuretreat)
    _ENV.RangeCombo(_ENV.flyhitEarth, _ENV.watertornadoCombo)
    _ENV.flyhitEarth(_ENV.FlyHitFromEarth(_ENV.RealHit(_ENV.biansu, _ENV.pushawayEnd)))
    _ENV.watertornadoCombo(_ENV.watertornado(_ENV.FlyHitFromEarth2))
    _ENV.FlyHitFromEarth2(_ENV.RealHit2)
    _ENV.wingsbrustCombo(_ENV.wingsbrust(_ENV.flyidle(_ENV.FlyHitFromAir)))
    _ENV.FlyHitFromAir(_ENV.RealHit3)
    _ENV.PingPongCombo(_ENV.HuizhongPingPong1(_ENV.HuizhongPingPong2), _ENV.PingPongStart)
    _ENV.PingPongStart(_ENV.PingPongStartLoop)
    _ENV.PingPongStartLoop(_ENV.PingPongStartLoopEnd)
    _ENV.TriHitGroundCombo(_ENV.FlyHitFromEarthend2(_ENV.RealHitloop1(_ENV.RealHitloop2(_ENV.RealHitend))))
    _ENV.TriHitGroundComboPhase2(_ENV.FlyHitFromEarthend2)
    _ENV.HuiZhongNormal(_ENV.Huizhong(_ENV.HuizhongEnd(_ENV.watertornadoHuizhong(_ENV.watertornadoHuizhong2(_ENV.watertornadoHuizhong3)))))
    _ENV.HuizhongEX23(_ENV.HuizhongEX(_ENV.HuizhongEndEX(_ENV.watertornadoHuizhongEX(_ENV.watertornadoHuizhongEX2(_ENV.watertornadoHuizhongEX3)))))
  end
  
  function skills.pushaway.onBegin(pushaway)
    pushaway.base.onBegin(pushaway)
  end
  
  function skills.pushaway.onEnd(pushaway)
    pushaway.base.onEnd(pushaway)
  end
  
  function skills.pushaway.onBreak(pushaway)
    pushaway.base.onBreak(pushaway)
  end
  
  function states.MaleeCombo.isReady(MaleeCombo)
    local player = get_come_on_hero()
    local disPlayer = get_npc_distance(monster.npc, 1, player, true)
    if disPlayer < 4 then
      monster.randomNum = math.random()
      return true
    end
    return false
  end
  
  do
    local dead = monster.states.dead
    dead.delay = {fx = 0.5, remove = 1.5}
  end
  
  function states.NormalAttackCombo.start(NormalAttackCombo)
    if -1.0 == monster.comboTime then
      monster.comboTime = get_npc_time(monster.npc)
    end
  end
  
  function states.pushaway3.isReady(pushaway3)
    return pushaway3.base.isReady(pushaway3) and monster.randomNum > 0.5
  end
  
  function states.normalAttack.isReady(normalAttack)
    if 1 ~= monster.statepre and monster.randomNum < 0.5 then
      return true
    end
    return false
  end
  
  function states.combohit.start(combohit)
    combohit.base.start(combohit)
    monster.statepre = 1
  end
  
  function states.pushawayCombo.isReady(pushawayCombo)
    if 2 ~= monster.statepre and monster.randomNum > 0.5 then
      return true
    end
    return false
  end
  
  function states.pushaway3.start(pushaway3)
    pushaway3.base.start(pushaway3)
    monster.statepre = 2
  end
  
  function states.RangeCombo.isReady(RangeCombo)
    monster.randomNum = math.random()
    return RangeCombo.base.isReady
  end
  
  function states.flyhitEarth.isReady(flyhitEarth)
    return monster.randomNum < 0.4
  end
  
  function states.wander.start(wander)
    wander.base.start(wander)
  end
  
  function states.RealHit.isReady(RealHit)
    return true
  end
  
  function states.RealHit2.isReady(RealHit)
    return true
  end
  
  function states.RealHit3.isReady(RealHit)
    return true
  end
  
  function skills.wingsbrust.onBreak(wingsbrust)
    wingsbrust.base.onBreak(wingsbrust)
  end
  
  function states.freeAtk.start(freeAtk)
    if not monster.check_story_start then
      freeAtk.base.start(freeAtk)
      monster.check_story_start = true
    end
  end
  
  function states.RealHitloop1.isReady(RealHitloop1)
    return true
  end
  
  function states.RealHitloop2.isReady(RealHitloop1)
    return true
  end
  
  function states.RealHitend.isReady(RealHitloop1)
    return true
  end
  
  function states.SpecialAttackCombo.isReady(NormalAttackCombo)
    local curTime = get_npc_time(monster.npc)
    if -1.0 == monster.comboTime then
      return false
    end
    if curTime - monster.comboTime > 15 then
      monster.randomNum = math.random()
      return true
    end
    return false
  end
  
  function states.wingsbrustCombo.start(wingsbrustCombo)
    wingsbrustCombo.base.start(wingsbrustCombo)
  end
  
  function states.wingsbrustCombo.finish(wingsbrustCombo)
    wingsbrustCombo.base.finish(wingsbrustCombo)
  end
  
  function states.HuizhongPingPong1.isReady(HuizhongPingPong1)
    local posx, posy, posz = get_area_pos("M1")
    local dis = get_npc_distance(monster.npc, 2, posx, posz, false)
    return dis > 19
  end
  
  function states.HuizhongPingPong2.finTrans(HuizhongPingPong2)
    return states.PingPongStart
  end
  
  function states.PingPongCombo.isReady(PingPongCombo)
    return monster.randomNum < 0.6
  end
  
  function states.SpecialAttackCombo.finish(SpecialAttackCombo)
    monster.comboTime = -1.0
  end
  
  function states.TriHitGroundCombo.finish(TriHitGroundCombo)
    TriHitGroundCombo.base.finish()
  end
  
  function states.TriHitGroundComboPhase2.finish(TriHitGroundCombo)
    TriHitGroundCombo.base.finish()
  end
  
  function states.TriHitGroundComboPhase2.isReady(TriHitGroundComboPhase2)
    if 2 == monster.phase and monster.aircrash == true then
      abort_skill(monster.npc, true)
      return true
    else
      return false
    end
  end
  
  function states.TriHitGroundCombo.isReady(TriHitGroundCombo)
    if 2 == monster.phase then
      return true
    else
      return false
    end
  end
  
  function skills.FlyHitFromEarthend2.onBegin(FlyHitFromEarthend2)
    remove_missile_by_id(201048010103, monster.npc, true)
    if not monster.check_story_zadi and get_cur_room_id() == monster.mainStoryRoomID then
      start_stroy(5061903)
      monster.check_story_zadi = true
    end
  end
  
  function skills.Huizhong.onBegin(Huizhong)
  end
  
  function skills.FlyHitFromEarthend2.tick(FlyHitFromEarthend2)
    if check_magic(monster.npc, 2010480134) then
      set_npc_pos(monster.npc, "M1")
      monster.aircrash = false
    end
  end
  
  function skills.Huizhong.tick(Huizhong)
    if check_magic(monster.npc, 2010480134) then
      set_npc_pos(monster.npc, "M1")
      monster.aircrash = false
    end
  end
  
  function skills.HuizhongEnd.onBegin(HuizhongEnd)
    monster.aircrash = false
    monster.HuizhongEndCast = true
    set_keyframe_enable(monster.npc, 201048020209, false, true)
    set_keyframe_enable(monster.npc, 201048020210, false, true)
    set_keyframe_enable(monster.npc, 201048020211, false, true)
    set_keyframe_enable(monster.npc, 201048020212, false, true)
    set_keyframe_enable(monster.npc, 201048020213, false, true)
    set_keyframe_enable(monster.npc, 201048020214, false, true)
  end
  
  function skills.HuizhongEnd.tick(HuizhongEnd)
    if check_magic(monster.npc, 2010480122) and monster.HuizhongEndCast then
      monster.HuizhongEndCast = false
    end
  end
  
  function skills.RealHitloop1.onBegin(RealHitloop1)
    enable_shadow(monster.npc, true)
    set_keyframe_enable(monster.npc, 201048013009, false, true)
    set_keyframe_enable(monster.npc, 201048013010, false, true)
    set_keyframe_enable(monster.npc, 201048013011, false, true)
    set_keyframe_enable(monster.npc, 201048013012, false, true)
    set_keyframe_enable(monster.npc, 201048013013, false, true)
    set_keyframe_enable(monster.npc, 201048013008, false, true)
  end
  
  function skills.RealHitloop1.tick(RealHitloop1)
    if check_magic(monster.npc, 2010480135) and not monster.phase2SkillOver then
      set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Water_1", true)
    end
  end
  
  function skills.RealHitloop2.onBegin(RealHitloop2)
    monster.aircrash = false
    set_keyframe_enable(monster.npc, 201048013109, false, true)
    set_keyframe_enable(monster.npc, 201048013110, false, true)
    set_keyframe_enable(monster.npc, 201048013111, false, true)
    set_keyframe_enable(monster.npc, 201048013112, false, true)
    set_keyframe_enable(monster.npc, 201048013113, false, true)
    set_keyframe_enable(monster.npc, 201048013114, false, true)
  end
  
  function skills.RealHitloop2.tick(RealHitloop2)
    if check_magic(monster.npc, 2010480136) and not monster.phase2SkillOver then
      set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Water_2", true)
    end
  end
  
  function skills.RealHitend.onBegin(RealHitend)
    monster.aircrash = false
  end
  
  function skills.RealHitend.onEnd(RealHitend)
    if not monster.check_story_overZadi and get_cur_room_id() == monster.mainStoryRoomID then
      start_stroy(5061904)
      monster.check_story_overZadi = true
    end
    skills.RealHitend.base.onEnd(RealHitend)
  end
  
  function skills.RealHitend.tick(RealHitend)
    if check_magic(monster.npc, 2010480137) and not monster.phase2SkillOver then
      cast_magic(monster.npc, monster.npc, 2010480122, 0)
      switch_bgm_block("bgm_qian_he", 2)
      set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Water_3", true)
      set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Rain", true)
      set_sceneobj_visible_save_state("/Root/Level/Level_boss/water", true)
      set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Smoke_2", true)
      set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Smoke_1", false)
      set_scene_camera(2010480102)
      SceneMgr:scene_illumination_defualt_to_second(1)
      call_scene_logic_custom_event("rain")
      monster.phase2SkillOver = true
    end
  end
  
  function states.HuizhongEX23.finish(HuizhongEX23)
    HuizhongEX23.base.finish(HuizhongEX23)
  end
  
  function states.HuiZhongNormal.finish(HuizhongEX23)
    HuizhongEX23.base.finish(HuizhongEX23)
  end
  
  function states.HuizhongEX23.isReady(HuizhongEX23)
    local posx, posy, posz = get_area_pos("M1")
    local dis = get_npc_distance(monster.npc, 2, posx, posz, false)
    return dis > 21
  end
  
  function states.HuiZhongNormal.isReady(HuiZhongNormal)
    local posx, posy, posz = get_area_pos("M1")
    local dis = get_npc_distance(monster.npc, 2, posx, posz, false)
    return dis > 19
  end
  
  function states.retreat.tickTrans(retreat)
    if check_magic(monster.npc, 2010480160) then
      return monster.states.RetreatComboSecond1
    end
  end
  
  function states.Other.isReady(Other)
    return false
  end
  
  function skills.biansu.onBegin(biansu)
    biansu.base.onBegin(biansu)
    monster.hitSongzhi = false
  end
  
  function skills.biansu.tick(biansu)
    local player = get_come_on_hero()
    local pos = get_npc_pos(player)
    local offse = get_dir_offset(monster.npc, pos.x, pos.z)
    if offse <= 90 then
      set_keyframe_enable(monster.npc, 201048013812, true, true)
    else
      set_keyframe_enable(monster.npc, 201048013812, false, true)
    end
    local hepos = get_npc_offset_position(monster.npc, nil, 0, 8)
    if check_magic(monster.npc, 2010480123) and 1 ~= monster.phase and monster.aircrash == false then
      abort_magic_by_id(monster.npc, 2010480123, 1)
      cast_missile(monster.npc, nil, nil, nil, 201048010107)
      cast_missile(monster.npc, nil, nil, nil, 201048010108)
      cast_missile(monster.npc, nil, nil, nil, 201048010109)
      cast_missile(monster.npc, nil, nil, nil, 201048010110)
      cast_missile(monster.npc, nil, nil, nil, 201048010111)
      if not monster.check_story_wingsbrust and get_cur_room_id() == monster.mainStoryRoomID then
        start_stroy(5061902)
        monster.check_story_wingsbrust = true
      end
    end
    if check_magic(monster.npc, 2010480202) then
      cast_magic(monster.npc, monster.npc, 2010480201, 1)
    end
  end
  
  function skills.watertornado.onBegin(watertornado)
    if 1 == monster.phase then
      cast_missile_new(monster.npc, nil, nil, nil, 201048013404)
    end
    if 2 == monster.phase then
      cast_missile_new(monster.npc, nil, nil, nil, 201048010117)
      cast_missile_new(monster.npc, nil, nil, nil, 201048010118)
    end
  end
  
  function skills.watertornadoAir.onBegin(watertornadoAir)
    if 1 == monster.phase then
      cast_missile_new(monster.npc, nil, nil, nil, 201048010117)
      cast_missile_new(monster.npc, nil, nil, nil, 201048013404)
    end
    if 2 == monster.phase then
      cast_missile_new(monster.npc, nil, nil, nil, 201048010117)
      cast_missile_new(monster.npc, nil, nil, nil, 201048010118)
    end
  end
  
  function skills.FlyHitFromEarth.tick(FlyHitFromEarth)
    if check_magic(monster.npc, 2010480207) then
      local player = get_come_on_hero()
      local heplay = get_npc_pos(player)
      monster.skillCamera = true
      enable_shadow(monster.npc, false)
      change_follow_target(1, player, {
        0,
        0,
        {
          heplay.x,
          heplay.y,
          heplay.z
        },
        0,
        0,
        0.55,
        focal_mode = 1
      })
    end
  end
  
  function skills.FlyHitFromEarth.onBegin(FlyHitFromEarth)
    monster.IsFlying = true
  end
  
  function skills.FlyHitFromAir.onBegin(FlyHitFromAir)
    monster.IsFlying = true
  end
  
  function skills.RealHit.onBegin(RealHit)
    RealHit.base.onBegin(RealHit)
    enable_shadow(monster.npc, true)
    remove_missile_by_id(201048011104, monster.npc, true)
    remove_missile_by_id(201048010104, monster.npc, false)
    local player = get_come_on_hero()
    local pos = get_npc_pos(player)
    local offse = get_dir_offset(monster.npc, pos.x, pos.z)
    abort_magic_by_id(monster.npc, 2010480212)
    if offse <= 90 then
      set_keyframe_enable(monster.npc, 201048010406, true, true)
    else
      set_keyframe_enable(monster.npc, 201048010406, false, true)
    end
    monster.skillCamera = false
    change_follow_target(4)
  end
  
  function skills.RealHit.tick(RealHit)
    if check_magic(monster.npc, 2010480159) then
      monster.IsFlying = false
    end
  end
  
  function skills.retreat.onBegin(retreat)
    if 1 == monster.phase then
      set_keyframe_enable(monster.npc, 201048012602, false, true)
    end
    if 1 ~= monster.phase and monster.aircrash == false then
      set_keyframe_enable(monster.npc, 201048012602, true, true)
    end
    local player = get_come_on_hero()
    local pos = get_npc_pos(player)
    local offse = get_dir_offset(monster.npc, pos.x, pos.z)
    if offse <= 270 then
      set_keyframe_enable(monster.npc, 201048012607, true, true)
    else
      set_keyframe_enable(monster.npc, 201048012607, false, true)
    end
  end
  
  function states.PingPongStartLoop.tick(PingPongStartLoop)
    PingPongStartLoop.base.tick(PingPongStartLoop)
    if monster.PingPongMissile then
      local player = get_come_on_hero()
      local disPlayer = get_npc_distance(monster.npc, 1, player, true)
      local PingPongDis = get_npc_missile_distance(monster.npc, monster.PingPongMissile)
      if PingPongDis > disPlayer + 3 or 0 == PingPongDis then
        monster.tree:derive(monster.states.PingPongStartLoopEnd)
      end
    else
      monster.tree:derive(monster.states.PingPongStartLoopEnd)
    end
  end
  
  function skills.PingPongStartLoop.onBegin(PingPongStartLoop)
  end
  
  function skills.PingPongStart.onBegin(PingPongStart)
    PingPongStart.base.onBegin(PingPongStart)
    monster.SecondRebound = 0
    monster.PingPongMissile = nil
  end
  
  function skills.wingsbrust.onBegin(wingsbrust)
    wingsbrust.base.onBegin(wingsbrust)
    local heplay = get_npc_pos(monster.npc)
    set_scene_tips(20104802, true, {})
    monster.hitSongzhi = false
    set_keyframe_enable(monster.npc, 201048010622, false, true)
    set_keyframe_enable(monster.npc, 201048010623, false, true)
    set_keyframe_enable(monster.npc, 201048010624, false, true)
    set_keyframe_enable(monster.npc, 201048010625, false, true)
    set_keyframe_enable(monster.npc, 201048010626, false, true)
    set_keyframe_enable(monster.npc, 201048010627, false, true)
    set_keyframe_enable(monster.npc, 201048010628, false, true)
    set_keyframe_enable(monster.npc, 201048010629, false, true)
  end
  
  function skills.wingsbrust.tick(wingsbrust)
    if get_cur_room_id() == monster.mainStoryRoomID and check_magic(monster.npc, 2010480154) and not monster.check_story_wingsbrust then
      start_stroy(5061902)
      monster.check_story_wingsbrust = true
    end
  end
  
  function states.flyidle.tick(flyidle)
    if check_magic(monster.npc, 2010480158) then
      abort_skill(monster.npc)
      flyidle:derive()
    end
    flyidle.base.tick(flyidle)
  end
  
  function states.PingPongStart.tick(PingPongStart)
    PingPongStart.base.tick(PingPongStart)
    if monster.PingPongMissile then
      local player = get_come_on_hero()
      local disPlayer = get_npc_distance(monster.npc, 1, player, true)
      local PingPongDis = get_npc_missile_distance(monster.npc, monster.PingPongMissile)
      if PingPongDis > disPlayer + 3 or 0 == PingPongDis then
        monster.tree:derive(monster.states.PingPongStartLoopEnd)
      end
    end
  end
  
  do
    local Defend = skills.Defend
    local DefendAttack = skills.DefendAttack
    Defend(DefendAttack)
    
    function skills.Defend.tick(Defend)
      Defend.base.tick(Defend)
      if check_magic(monster.npc, 2010480131) then
        monster.BOOMDefend = true
        abort_magic_by_id(monster.npc, 2010480131, 1)
        monster.BOOMDefend = true
        abort_skill(monster.npc)
        Defend:deriveAuto()
      end
      if true == monster.BeHitInDefend then
        abort_skill(monster.npc)
        Defend:deriveAuto()
      end
    end
    
    function skills.Defend.onBegin(Defend)
      Defend.base.onBegin(Defend)
      set_scene_tips(20104803, true, {})
      remove_missile_by_id(201048010103, monster.npc, true)
      set_keyframe_enable(monster.npc, 201048012015, false, true)
    end
    
    function skills.Defend.onEnd(Defend)
      Defend.base.onEnd(Defend)
      set_scene_tips(20104803, false, {})
      monster.BeHitInDefend = true
    end
    
    function skills.DefendAttack.onEnd(DefendAttack)
      DefendAttack.base.onEnd(DefendAttack)
    end
    
    function skills.DefendAttack.isReady()
      if monster.BeHitInDefend == true or true == monster.BOOMDefend then
        return true
      else
        return false
      end
    end
    
    function DefendAttack.onBegin()
      monster.BOOMDefend = false
      remove_missile_by_id(201048012004, monster.npc, true)
      remove_missile_by_id(201048012009, monster.npc, true)
      remove_missile_by_id(201048012015, monster.npc, true)
      if 1 == monster.phase then
        set_keyframe_enable(monster.npc, 201048012106, false, true)
      else
        set_keyframe_enable(monster.npc, 201048012106, true, true)
      end
      monster.BeHitInDefend = false
    end
  end
  local tags = get_npc_difficulty_tag(monster.npc)
  if tags then
    for key, value in pairs(tags) do
      if monster.difficulty_init[value] then
        monster.difficulty_init[value](monster)
      end
    end
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  local player = get_come_on_hero()
  local playerpos = get_npc_pos(player)
  if missile_cfg.Id == 201048011201 and hit_target == player then
    monster.PingPongMissile = nil
    monster.ShouldStopPingPong = true
    PingPongShouldHitBack = false
    remove_missile_by_id(201048010114, player, false)
    monster.BOOMNPC = true
    local tagList = get_npc_difficulty_tag(monster.npc)
    if tagList and tagList[Const.DIFFICULTY_TAG.HARD] then
      cast_magic(monster.npc, monster.npc, 2010480211, 1)
    end
  end
  if hit_target == player and missile_cfg.Id == 201048010103 then
    monster.tool.roleFaint(hit_target, 4)
    cast_missile_new(monster.npc, player, playerpos.x, playerpos.z, 201048010104, 1, playerpos.x, playerpos.z, playerpos.y, playerpos.y, playerpos.x, playerpos.z)
    cast_magic(player, monster.npc, 2010480215, 0)
    monster.hitSongzhi = true
    remove_missile_by_id(201048010103, monster.npc, true)
    local tagList = get_npc_difficulty_tag(monster.npc)
    if tagList and tagList[Const.DIFFICULTY_TAG.HARD] and 2 == monster.phase then
      monster.songzhi = true
    end
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  local player = get_come_on_hero()
  local playerpos1 = get_npc_pos(monster.npc)
  if missile_cfg.Id == 201048011201 and attacker == player then
    local tagList = get_npc_difficulty_tag(monster.npc)
    if tagList and tagList[Const.DIFFICULTY_TAG.HARD] then
      if 3 == monster.SecondRebound then
        monster.PingPongMissile = nil
        local camera_id = get_cur_camera_id()
        if 2010480101 ~= camera_id then
          set_camera(2010480101, true)
        end
        cast_magic(monster.npc, monster.npc, 2010480210, 1)
        monster.ShouldStopPingPong = true
        cast_magic(monster.npc, monster.npc, 2010480138)
      end
    else
      monster.PingPongMissile = nil
      monster.ShouldStopPingPong = true
      cast_magic(monster.npc, monster.npc, 2010480138)
    end
  end
  if check_magic(monster.npc, 2010480103) then
    monster.BeHitInDefend = true
    local playerpos = get_npc_pos(player)
    cast_missile_new(monster.npc, player, playerpos.x, playerpos.z, 201048010102, 1, playerpos.x, playerpos.z, playerpos.y, playerpos.y, playerpos.x, playerpos.z)
    abort_magic_by_id(monster.npc, 2010480103, 1)
    cast_magic(monster.npc, player, 2020470109, 1)
    cast_magic(monster.npc, player, 2010480105, 1)
    cast_magic(monster.npc, player, 2010480108, 1)
    cast_magic(monster.npc, player, 2010480109, 1)
    cast_magic(monster.npc, player, 2020470145, 1)
  end
  if attacker == monster.npc and missile_cfg.Id == 201048010103 and not monster.IsFlying then
    abort_magic_by_id(monster.npc, Const.LOCK_MASK, 1)
    abort_skill(monster.npc, true)
    enter_stun(monster.npc, false, 4)
    
    local function Exit()
      exit_stun(monster.npc)
      monster.tree:transState(monster.states.freeAtk)
    end
    
    monster:doAfter(Exit, 4)
    cast_missile_new(monster.npc, monster.npc, playerpos1.x, playerpos1.z, 201048010116, 1, playerpos1.x, playerpos1.z, playerpos1.y, playerpos1.y, playerpos1.x, playerpos1.z)
    remove_missile_by_id(201048011102, monster.npc, true)
    remove_missile_by_id(201048011104, monster.npc, true)
    remove_missile_by_id(201048010103, monster.npc, true)
    monster.hitSongzhi = true
  end
end

function monster.before_damage_target(monster, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  monster.base.before_damage_target(monster, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local player = get_come_on_hero()
  if check_magic(monster.npc, 2010480215) then
    monster.tool.roleFaintFinish(player)
    abort_magic_by_id(monster.npc, 2010480215)
    remove_missile_by_id(201048010104, monster.npc, true)
  end
end

function monster:on_self_missile_begin_pos(pos_x, pos_z, missile_cfg, missile)
  if get_missile_skill_action_info(missile) == 201048 and self.rebound_missile_id_map[missile_cfg.Id] then
    change_linetype(missile, 16, {
      -30,
      1.5,
      {1.5},
      {240},
      {-2},
      1
    })
    self.rebound_missile_id_map[missile_cfg.Id] = nil
  end
end

function monster.on_missile_begin_pos(monster, owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201048010103 then
    if monster.hitSongzhi then
      remove_missile(missile, true)
    else
      monster.songzhiMissile = missile
    end
  end
  if missile_cfg.Id == 201048011201 then
    monster.PingPongMissile = missile
  end
  if missile_cfg.Id == 201048010114 then
    monster.PingPongBOOMMissile = missile
  end
  if monster.TANQIU ~= nil and owner ~= monster.npc then
    remove_missile_by_id(monster.TANQIU, monster.npc, true)
  end
  if missile_cfg.Id == 201048010130 then
    transfer_missile_effect(monster.thecopyingMissile, missile)
    monster.missile_copying = false
    monster.missileRound = true
    remove_missile(monster.thecopyingMissile, true)
  end
end

function monster.on_missile_end_pos(monster, owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201048011201 then
    monster.ShouldStopPingPong = true
    monster.PingPongMissile = nil
    monster.songzhiMissile = nil
    monster.PingPongBOOMMissile = nil
    if true == monster.BOOMNPC then
      local player = get_come_on_hero()
      local playerpos = get_npc_pos(player)
      remove_missile_by_id(201048010114, monster.npc, false)
      cast_missile_new(monster.npc, player, playerpos.x, playerpos.z, 201048010113, 1, playerpos.x, playerpos.z, playerpos.y + 1.5, playerpos.y, playerpos.x + 1.5, playerpos.z)
      monster.BOOMNPC = false
    end
  end
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local player = get_come_on_hero()
  if (m1_cfg.Id == 201048011224 or m1_cfg.Id == 201048011223) and m2_owner == player and 2 == m2_cfg.MissileTypeTag and not monster.missile_copying then
    monster.missile_copying = true
    monster.thecopyingMissile = m2
    local pos = get_missile_pos(m2)
    cast_missile_new(monster.npc, player, pos.x, pos.z, 201048010130, 1, nil, nil, nil, pos.y)
  end
  if (m2_cfg.Id == 201048011224 or m2_cfg.Id == 201048011223) and m1_owner == player and 2 == m1_cfg.MissileTypeTag and not monster.missile_copying then
    monster.missile_copying = true
    monster.thecopyingMissile = m1
    local pos = get_missile_pos(m1)
    cast_missile_new(monster.npc, monster.npc, pos.x, pos.z, 201048010130, 1, nil, nil, nil, pos.y)
  end
  if m1_owner == player and m2_owner == monster.npc then
    local magics = m1_cfg.magic
    local magicId = magics and magics[1]
    local magicCfg = magicId and ShareRes.get_magic_cfg(magicId)
    if m2_cfg.Id == 201048011201 and m1_cfg.Id ~= 201048011202 and nil ~= magics and nil ~= magicId and nil ~= magicCfg and 2 == magicCfg.logic[1] then
      monster.IsSurfing = false
      remove_missile_by_id(201048010114, monster.npc, false)
      cast_magic(monster.npc, monster.npc, 2010480144, 1)
      cast_magic(monster.npc, monster.npc, 2010480145, 1)
      local playerpos = get_npc_pos(player)
      cast_missile_new(monster.npc, player, playerpos.x, playerpos.z + 2, 201048010115, 1, playerpos.x, playerpos.z + 2, playerpos.y, playerpos.y, playerpos.x, playerpos.z + 2)
      print("目标1", monster.ON3)
      if true == monster.ON3 then
        cast_magic(monster.npc, player, 2010480146, 1)
        cast_magic(monster.npc, monster.npc, 2010480147, 1)
        cast_magic(monster.npc, monster.npc, 2010480148, 1)
        monster.ON3 = false
      end
      if 1 == monster.phase then
        cast_magic(monster.npc, player, 2010480146, 1)
        cast_magic(monster.npc, monster.npc, 2010480147, 1)
        cast_magic(monster.npc, monster.npc, 2010480148, 1)
      end
      cast_missile3(monster.npc, monster.npc, nil, nil, 201048011229)
      rebound_missile(m2, player, monster.npc, get_npc_pos(monster.npc).x, get_npc_pos(monster.npc).y, 15, false, false, true)
      local tagList = get_npc_difficulty_tag(monster.npc)
      if tagList and tagList[Const.DIFFICULTY_TAG.HARD] then
        monster.SecondRebound = monster.SecondRebound + 1
      end
    end
  end
  if m1_owner == monster.npc and m2_owner == player then
    local magics = m2_cfg.magic
    local magicId = magics and magics[1]
    local magicCfg = magicId and ShareRes.get_magic_cfg(magicId)
    if m1_cfg.Id == 201048011201 and m2_cfg.Id ~= 201048011202 and nil ~= magics and nil ~= magicId and nil ~= magicCfg and 2 == magicCfg.logic[1] then
      monster.IsSurfing = false
      remove_missile_by_id(201048010114, monster.npc, false)
      cast_missile3(monster.npc, monster.npc, nil, nil, 201048011229)
      print("目标4")
      rebound_missile(m1, player, monster.npc, get_npc_pos(monster.npc).x, get_npc_pos(monster.npc).z, 15, false, false, true)
      if get_npc_difficulty_tag(monster.npc)[Const.DIFFICULTY_TAG.HARD] then
        monster.SecondRebound = monster.SecondRebound + 1
      end
    end
  end
end

function monster.on_start(monster)
  print("camera = ", get_cur_camera_id())
  change_follow_target_new(3, monster.npc, {
    6,
    12,
    {
      x = 0,
      y = 0,
      z = 0
    },
    1,
    0.6
  })
  set_camera(2010480101, true)
  set_npc_phase_number(monster.npc, 2)
  monster:xRay()
end

function monster.on_self_npc_hp_zero(monster)
  if 2 == monster.phase then
    monster.base.on_self_npc_hp_zero(monster)
  end
  if 1 == monster.phase then
    monster.aircrash = true
    monster.phase = 2
    cast_magic(monster.npc, monster.npc, 2010480153)
    monster.tool:castMagicToTeam(2010480153, 1, monster.npc, 1)
    change_npc_phase_state(monster.npc, 2, false)
    cast_magic(monster.npc, monster.npc, 1999224, 1)
    cast_magic(monster.npc, monster.npc, 1999225, 1)
    cast_magic(monster.npc, monster.npc, 1999226, 1)
    cast_magic(monster.npc, monster.npc, 1999227, 1)
    cast_magic(monster.npc, monster.npc, 1999228, 1)
    cast_magic(monster.npc, monster.npc, 1999229, 1)
    cast_magic(monster.npc, monster.npc, 1999230, 1)
  end
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  if monster.fxwu == false then
    set_sceneobj_visible_save_state("/Root/Level/Level_boss/sc0602_heliu_pre/Fx/Fx_Smoke_1", true)
    monster.fxwu = true
  end
end

function monster.on_magic_begin(monster, npc, target, magic_id, is_self, magic_level)
  local player = get_come_on_hero()
  if 2010480101 == magic_id then
    monster.tool.roleFaint(player, 3)
  end
  if 2010480131 == magic_id then
    local playerpos = get_npc_pos(player)
    lookat_position(player, playerpos.x, playerpos.z - 5, 1)
  end
  if 2010480111 == magic_id then
    set_left_joystick_inverse(true)
    set_indicator_inverse(true)
  end
  if check_magic(monster.npc, 2010480124) then
    enable_shadow(monster.npc, false)
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  if 2010480111 == magic_id then
    set_left_joystick_inverse(false)
    set_indicator_inverse(false)
  end
  if 2010480144 == magic_id then
    cast_magic(monster.npc, monster.npc, 2010480140, 1)
    exit_stun(monster.npc)
  end
end

function monster.on_self_missile_collide(monster, otherNpc, self_missile, other_missile, self_missile_cfg, other_missile_cfg)
  local player = get_come_on_hero()
end

function monster:on_catch_need_rebound_missile(missile_id)
end

return monster
