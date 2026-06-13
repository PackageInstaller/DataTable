local roleBase = import("character.base.role_base")
local Cecilia = Util.create_child_mt(roleBase)

function Cecilia._init(role, npc)
  role.npc = npc
  local misIds = {misPassiveCamera = 10010283310}
  local magicIds = {skill3DodegLink = 102804}
  roleBase._init(role, misIds, magicIds)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local destinies = role.destinies
  local traces = role.traces
  role.nowTime = 0
  role.skill03ProStaty = false
  role.temp_target = nil
  
  local function cameraReset(role)
    change_focus_follow_speed(5)
    change_follow_target(4)
  end
  
  local traces_magic = {}
  local traces = role.traces
  traces[1026281] = 1
  traces[1026282] = 2
  traces[1026283] = 3
  traces[1026284] = 4
  traces[1026285] = 5
  role.tracesMagic = {
    Lv1 = {ultPassivestate = false, ultPassiveTime = 0},
    Lv2 = {damageUp = 1026287},
    Lv4 = nil
  }
  local destinies = role.destinies
  destinies[1026181] = 1
  destinies[1026182] = 2
  destinies[1026183] = 3
  destinies[1026184] = 4
  destinies[1026185] = 5
  role.destiniesMagic = {
    Lv1 = {damageUp = 1026201},
    Lv2 = {damageUp = 1026202},
    Lv3 = {damageUp = 1026203},
    Lv4 = {damageUp = 1026204, distanceLv = 0},
    Lv5 = {mark = 1026206, damageUp = 1026205}
  }
  local spWeapon = role.spWeapon
  spWeapon.magic = 1026200
  spWeapon.damageUp = 1026210
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  
  function Cecilia.on_start(role, npc)
    role.base.on_start(role, npc)
  end
  
  local function cameraReset(speed)
    role:change_follow_target(4)
    change_focus_follow_speed(speed)
  end
  
  function skActs.atk1.onBegin(atk1)
    atk1.base.onBegin(atk1)
  end
  
  function magics.skill3DodegLink.onBegin(spAtkEnd, casterNpc, target)
    skActs.skill03Dodge.trans.enable.skill02_1 = "skill02_1"
    skActs.skill03Dodge.trans.enable.skill02_2 = "skill02_2"
    skActs.skill03Dodge.trans.enable.skill02_3 = "skill02_3"
    skActs.skill03Dodge.trans.enable.skill03_1 = "skill03_1"
    print("进来了吗")
  end
  
  function magics.skill3DodegLink.onEnd(spAtkEnd, casterNpc, target)
    skActs.skill03Dodge.trans.enable.skill02_1 = nil
    skActs.skill03Dodge.trans.enable.skill02_2 = nil
    skActs.skill03Dodge.trans.enable.skill02_3 = nil
    skActs.skill03Dodge.trans.enable.skill03_1 = nil
  end
  
  function skActs.skill03Dodge.isReady(skill03_1)
    return true
  end
  
  do
    local atkActs = {
      skActs.skill02_1,
      skActs.skill02_2,
      skActs.skill02_3
    }
    for i, atkAct in ipairs(atkActs) do
      atkAct.reset = {timer = 0, delay = 0.2}
      
      function atkAct.onCastTime(skAct)
        skAct.reset.timer = get_npc_time(skAct.role.npc) + skAct.reset.delay + 2
        skAct.base.onCastTime(skAct)
      end
    end
    for i = 2, #atkActs do
      local atk = atkActs[i]
      atk.preAtk = atkActs[i - 1]
      atk.dashOut = skActs.dashOut
      atk.dashIn = skActs.dashIn
      
      function atk.isReady(atk)
        if not atk.base.isReady(atk) then
          return false
        end
        local role = atk.role
        local roleAct = role.skAct
        print("有进来吗？", atk.name, atk.preAtk.name)
        if roleAct == atk.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
          return true
        elseif roleAct == atk.dashOut or roleAct == atk.dashIn then
          local preAct = roleAct.preAct
          return preAct == atk.preAtk
        else
          return false
        end
      end
    end
  end
  
  function icons.skill03_1.updateEnhance(skill03_1)
    skill03_1.isEnhance = role.skill03ProStaty
  end
  
  function skills.skill03_1.tarPos(skill03_1)
    local pos
    if role.target then
      pos = get_npc_offset_position(role.target, get_npc_pos(role.npc), 180, 3)
    else
      pos = get_npc_offset_position(role.npc, nil, 0, 5)
    end
    role:debugPos(pos)
    return pos
  end
  
  function skActs.skill03_1.isReady(skill03_1)
    print("当前用的什么技能", role.skAct.name)
    if not skill03_1.base.isReady(skill03_1) or role.skill03ProStaty then
      return false
    end
    return true
  end
  
  function skActs.skill03_1.onBegin(skill03_1)
    skill03_1.base.onBegin(skill03_1)
    print("3技能释放")
    role:doAfter(function()
      print("没添加吗？")
      local pos = get_npc_offset_position(role.npc, nil, 180, 0)
      cast_missile3(role.npc, nil, pos.x, pos.z, 10010283102, 0)
    end, 0.1, true)
  end
  
  function skActs.skill03_1Pro.onBegin(skill03_1Pro)
    skill03_1Pro.base.onBegin(skill03_1Pro)
    skActs.skill03_1Pro.targetList = search_npc(role.npc, 4, 20, nil, true, true)
    print("3技能propropror释放", skActs.skill03_1Pro.targetList[2])
    if skActs.skill03_1Pro.targetList[2] then
      for k, v in pairs(skActs.skill03_1Pro.targetList) do
        if k > 1 then
          local bornPos = get_npc_pos(skActs.skill03_1Pro.targetList[k - 1])
          local lookPos = get_npc_pos(v)
          cast_missile3(role.npc, v, bornPos.x, bornPos.z, 10010283002, 0, lookPos.x, lookPos.z, lookPos.y, bornPos.y, bornPos.x, bornPos.z)
          print("寄哪里了吗？？？？")
        end
      end
    else
    end
  end
  
  function skActs.skill03_1Pro_1.onBegin(skill03_1Pro_1)
    skill03_1Pro_1.base.onBegin(skill03_1Pro_1)
    if role.target then
      local bornPos1 = get_npc_offset_position(role.target, get_npc_pos(role.npc), 60, 2)
      local bornPos2 = get_npc_offset_position(role.target, get_npc_pos(role.npc), 150, 2)
      local bornPos3 = get_npc_offset_position(role.target, get_npc_pos(role.npc), -90, 2)
      local lookPos = get_npc_pos(role.target)
      cast_missile3(role.npc, role.target, bornPos1.x, bornPos1.z, 10010283002, 0, lookPos.x, lookPos.z, lookPos.y, bornPos1.y, bornPos1.x, bornPos1.z)
      role:doAfter(function()
        cast_missile3(role.npc, role.target, bornPos2.x, bornPos2.z, 10010283002, 0, lookPos.x, lookPos.z, lookPos.y, bornPos2.y, bornPos2.x, bornPos2.z)
      end, 0.2, true)
      role:doAfter(function()
        cast_missile3(role.npc, role.target, bornPos3.x, bornPos3.z, 10010283002, 0, lookPos.x, lookPos.z, lookPos.y, bornPos3.y, bornPos3.x, bornPos3.z)
      end, 0.4, true)
    end
  end
  
  function skActs.skill03_1Pro_2.onBegin(skill03_1Pro_2)
    skill03_1Pro_2.base.onBegin(skill03_1Pro_2)
    abort_magic_by_id(role.npc, 102834, 1)
    print("强普2段释放11111")
  end
  
  function misLogics.misPassiveCamera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
    role:change_follow_target(1, misInst, {
      9999,
      0,
      {
        x = 0,
        y = 0,
        z = 0
      },
      0,
      0,
      0.1,
      0,
      1
    })
    print("进来了吗")
  end
  
  function skActs.skill03Dodge.onBegin(skill03Dodge)
    skill03Dodge.base.onBegin(skill03Dodge)
    set_move_offsets_multiplier(role.npc, 1.2)
  end
  
  function skActs.skill03Dodge.onEnd(skill03Dodge)
    set_move_offsets_multiplier(role.npc, 1)
  end
  
  function skActs.skill03Dodge.onBreak(skill03Dodge)
    set_move_offsets_multiplier(role.npc, 1)
  end
end

function Cecilia.onRampageStart(role, stage)
end

function Cecilia.on_self_skill_hit(role, kill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  print("被攻击了吗222222", missile_cfg.Tag, role.skill03ProStaty)
  if missile_cfg.Tag == 1001028 then
    print("被攻击了吗", hit_target.passiveNum)
    if hit_target.passiveNum and hit_target.passiveNum <= 15 then
      hit_target.passiveNum = hit_target.passiveNum + 1
    else
      hit_target.passiveNum = 1
    end
    if hit_target.passiveNum >= 15 then
      if not check_magic(hit_target, 102803) then
        abort_magic_by_id(hit_target, 102801, 1)
        abort_magic_by_id(hit_target, 102802, 1)
        cast_magic(role.npc, hit_target, 102803, 1)
      elseif hit_target.passiveNum >= 10 then
        if not check_magic(hit_target, 102802) then
          abort_magic_by_id(hit_target, 102801, 1)
          abort_magic_by_id(hit_target, 102803, 1)
          cast_magic(role.npc, hit_target, 102802, 1)
        end
      elseif hit_target.passiveNum >= 5 and not check_magic(hit_target, 102801) then
        abort_magic_by_id(hit_target, 102802, 1)
        abort_magic_by_id(hit_target, 102803, 1)
        cast_magic(role.npc, hit_target, 102801, 1)
      end
    end
  end
  if missile_cfg.Id == 10010283101 then
    hit_target.passiveNum = hit_target.passiveNum - 5
    abort_magic_by_id(hit_target, 102801, 1)
    abort_magic_by_id(hit_target, 102802, 1)
    abort_magic_by_id(hit_target, 102803, 1)
    if hit_target.passiveNum >= 15 then
      cast_magic(role.npc, hit_target, 102803, 1)
    elseif hit_target.passiveNum >= 10 then
      cast_magic(role.npc, hit_target, 102802, 1)
    elseif hit_target.passiveNum >= 5 then
      cast_magic(role.npc, hit_target, 102801, 1)
    end
  end
end

function Cecilia.on_target_self_skill_hit(role, skill_id, attacker, hit_type, missile_cfg, missile, part_npc)
  print("自己受到攻击")
  role.skActs.skill03Dodge:try()
end

function Cecilia.on_npc_born(role, npc)
  role.base.on_npc_born(role, npc)
end

function Cecilia.on_frame_background(role)
  role.base.on_frame_background(role)
end

function Cecilia.on_frame(role)
  role.base.on_frame(role)
  role.nowTime = get_npc_time(role.npc)
  if npc_is_destroy(role.temp_target) or not check_magic(role.temp_target, 102801) and not check_magic(role.temp_target, 102802) and not check_magic(role.temp_target, 102803) then
    set_search_npc_limit(nil, nil, 102801)
    set_search_npc_limit(nil, nil, 102802)
    set_search_npc_limit(nil, nil, 102803)
    role.temp_target = search_npc(role.npc, 4, 20, nil, true, false)
  end
  if not npc_is_destroy(role.temp_target) then
    role.skill03ProStaty = true
  else
    role.skill03ProStaty = false
  end
end

return Cecilia
