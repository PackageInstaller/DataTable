local roleBase = import("character.base.role_base")
local Jixia = Util.create_child_mt(roleBase)

function Jixia._init(role, npc)
  role.npc = npc
  local misIds = {
    misWaterWall = 10010230306,
    misAreaRipples = 10010233201,
    misAreaOpenHit = {10010233203, 10010238104},
    misAreaSwordHit = 10010233506,
    misAreaRipplesEffect = 10010233202,
    misArea = {10010233501, 10010233502},
    misUlt1Atk = {10010238101, 10010238115},
    misUlt2Atk = 10010238406,
    misDestiniesArea = 10010233531,
    misLinkSkill02 = 10010232502,
    misUltCamera = 10010238421
  }
  local magicIds = {
    rainArea = 102357,
    waterArea = {
      102358,
      102359,
      102366
    },
    treeArea = 102373,
    skill02FacePos = 102314,
    skill03AtkTime = 102356,
    collideTime = {102348, 102349},
    text = 102311,
    skill02Mark = 102350,
    skill03FlashTime = 102351
  }
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
  local offsetAtk2 = false
  role.rainStaty = false
  role.rainTime = 0
  role.rainTimeDuration = 7
  role.rainTimeMagic = 0
  role.rainTimeMagicInterval = 3
  role.misWaterWall = nil
  role.WaterWallIsBreak = false
  role.skill02MovePos = nil
  role.skill02LookPos = nil
  role.skill02MarkList = {}
  role.areaSearchTargetList = {}
  role.areaAtkTargetList = {}
  role.areaMIsList = {}
  role.buttonDustTime = 0
  role.skill03TimeList = {}
  role.posTarget = nil
  role.posMyself = nil
  role.ultWaterAtkTime = 0
  role.ultWaterAtkNumb = 0
  
  local function cameraReset(role)
    change_focus_follow_speed(5)
    role:change_follow_target(4)
  end
  
  local traces_magic = {}
  local traces = role.traces
  traces[1023281] = 1
  traces[1023282] = 2
  traces[1023283] = 3
  traces[1023284] = 4
  traces[1023285] = 5
  role.tracesMagic = {
    Lv1 = {
      1023286,
      startTime = 0,
      endTime = 0
    },
    Lv2 = 1023287,
    Lv4 = 1023289
  }
  local destinies = role.destinies
  destinies[1023181] = 1
  destinies[1023182] = 2
  destinies[1023183] = 3
  destinies[1023184] = 4
  destinies[1023185] = 5
  role.destiniesMagic = {
    Lv1 = {
      magicID = 1023201,
      num = 0,
      magicID2 = 1023208
    },
    Lv2 = 1023202,
    Lv3 = nil,
    Lv4 = 1023204,
    Lv5 = 1023205,
    Lv6 = 1023208
  }
  local spWeapon = role.spWeapon
  spWeapon.magic = 1023200
  spWeapon.targetList = {}
  local spWeaponMagic = 1023206
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function Logic()
      role.tracesMagic.Lv1.startTime = role.nowTime
    end
    
    local function LogicEnd()
      role.tracesMagic.Lv1.endTime = role.nowTime - 0.1
      local minTime = 0.2962962962962963
      local magicLv = math.ceil((role.tracesMagic.Lv1.endTime - role.tracesMagic.Lv1.startTime - minTime) * 20)
      if magicLv >= 1 then
        cast_magic(role.npc, role.npc, role.tracesMagic.Lv1[1], magicLv)
      end
    end
    
    local function moveMagic()
      abort_magic_by_id(role.npc, role.tracesMagic.Lv1[1])
    end
    
    tool.insert(misLogics.misAreaRipplesEffect, "onBegin", Logic)
    tool.insert(misLogics.misAreaRipplesEffect, "onEnd", LogicEnd)
    tool.insert(skActs.skill03AreaAtk, "onCastTime", moveMagic)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.rainTimeDuration = 13
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function AddMagic(magic, casterNpc, target)
      abort_magic_by_id(role.npc, role.destiniesMagic.Lv1.magicID2)
      
      cast_magic(role.npc, role.npc, role.destiniesMagic.Lv1.magicID, 0)
    end
    
    local function abortMagic(magic, casterNpc, target)
      if magic.id == magics.waterArea[3].id and not check_magic(role.npc, magics.waterArea[1].id) then
        abort_magic_by_id(role.npc, role.destiniesMagic.Lv1.magicID)
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv1.magicID2, 0)
      elseif magic.id == magics.waterArea[1].id and not check_magic(role.npc, magics.waterArea[3].id) then
        abort_magic_by_id(role.npc, role.destiniesMagic.Lv1.magicID)
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv1.magicID2, 0)
      end
    end
    
    tool.insert(magics.waterArea[1], "onBegin", AddMagic)
    tool.insert(magics.waterArea[3], "onBegin", AddMagic)
    tool.insert(magics.waterArea[1], "onEnd", abortMagic)
    tool.insert(magics.waterArea[3], "onEnd", abortMagic)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1023126 == magic_id or 1023127 == magic_id or 1023128 == magic_id or 1023129 == magic_id or 1023130 == magic_id then
        cast_magic(role.npc, role.npc, 1023202, 1)
      end
    end
    
    tool.insert(role, "before_damage_target", damageUp)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    role.rainTimeMagicInterval = 2.5
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1023121 == magic_id or 1023122 == magic_id or 1023123 == magic_id or 1023124 == magic_id then
        cast_magic(target, target, role.destiniesMagic.Lv4, 1)
      end
    end
    
    tool.insert(role, "before_damage_target", damageUp)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1023121 == magic_id or 1023122 == magic_id or 1023123 == magic_id or 1023124 == magic_id then
        cast_magic(role.npc, role.npc, role.destiniesMagic.Lv5, 1)
      end
    end
    
    tool.insert(role, "before_damage_target", damageUp)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function damageUp(role, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level)
      if 1023121 == magic_id or 1023122 == magic_id or 1023124 == magic_id then
        cast_magic(role.npc, role.npc, spWeaponMagic, role.spWeapon.lv)
      end
    end
    
    local function damageUp2(misRunesId, misInst, casterNpc, hitTarget, hitType, skill, part_npc)
      if hitTarget.spWeaponMagic or part_npc and part_npc.spWeaponMagic then
        cast_magic(role.npc, role.npc, spWeaponMagic, role.spWeapon.lv)
        hitTarget.spWeaponMagic = false
      end
    end
    
    local function getTargetList(magic, casterNpc, target)
      spWeapon.targetList = {}
      spWeapon.targetList = search_npc(role.npc, 4, 30, role.magics.skill02Mark.id, true, true)
      for k, v in pairs(spWeapon.targetList) do
        v.spWeaponMagic = true
      end
    end
    
    tool.insert(skActs.skill03Area, "onBegin", getTargetList)
    tool.insert(misLogics.misAreaRipples, "onHit", damageUp2)
    tool.insert(role, "before_damage_target", damageUp)
  end
  
  function skills.atk1.startFrame()
    if role.preAct == role.skActs.dashIn then
      return 4
    elseif role.preAct == role.skActs.dashOut then
      return 2
    else
      return 0
    end
  end
  
  function misLogics.misWaterWall.onBegin(missile_cfg, missile, owner, pos_x, pos_z)
    role.misWaterWall = missile
    role.WaterWallIsBreak = false
    role:doAfter(function()
      if not role.WaterWallIsBreak then
        play_effect_anim(role.npc, "Fx_H1001023_atk03_3", "End_1")
      end
    end, 1.05)
  end
  
  function skills.heavy.onCastTime(heavy)
    offsetAtk2 = true
    role:doAfter(function()
      offsetAtk2 = false
    end, 0.35)
    heavy.base.onCastTime(heavy)
  end
  
  function skills.qte.onCastTime(qte)
    offsetAtk2 = true
    role:doAfter(function()
      offsetAtk2 = false
    end, 0.35)
    qte.base.onCastTime(qte)
  end
  
  function skActs.atk2.isReady(atk2)
    if not atk2.base.isReady(atk2) then
      return false
    end
    local role = atk2.role
    local roleAct = role.skAct
    if roleAct == atk2.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif offsetAtk2 then
      offsetAtk2 = false
      return true
    else
      return false
    end
  end
  
  skills.skill02_1.hitTargetList = {}
  
  function skills.skill02_1.onBegin(skill02_1)
    for k, v in pairs(skills.skill02_1.hitTargetList) do
      v.IsSkill02Hit = false
    end
    skills.skill02_1.hitTargetList = {}
    role.skill02MovePos = get_npc_offset_position(role.npc, nil, 0, 7)
    role.skill02LookPos = get_npc_offset_position(role.npc, nil, 180, 15)
  end
  
  function magics.skill02FacePos.onBegin(magic, casterNpc, target)
    abort_skill(role.npc, 1)
    lookat_position(role.npc, role.skill02LookPos.x, role.skill02LookPos.z, true)
  end
  
  function skills.skill02_1.onHit(skilskill, casterNpc, hitTarget, hitType, missile, part_npc)
    if 5 ~= get_role_kind(hitTarget) and not hitTarget.IsSkill02Hit then
      hitTarget.IsSkill02Hit = true
      table.insert(skills.skill02_1.hitTargetList, hitTarget)
    end
  end
  
  magics.waterArea[1].onBegin = function(magic, casterNpc, target)
    role.tool:castMagicToTeam(102360)
    for k, v in pairs(role.areaSearchTargetList) do
      if check_magic(v, role.magics.skill02Mark.id) then
        cast_magic(role.npc, v, 102374, 1)
        cast_magic(role.npc, v, 102347, 1)
      else
        cast_magic(role.npc, v, 102373, 1)
        cast_magic(role.npc, v, 102346, 1)
      end
      abort_magic_by_id(v, role.magics.skill02Mark.id)
    end
  end
  magics.waterArea[1].onEnd = function(magic, casterNpc, target)
    role.tool:abortMagicToTeam(102360)
  end
  magics.waterArea[2].onBegin = function(magic, casterNpc, target)
    role.tool:castMagicToTeam(102360)
    role:set_search_kind()
    local targetList = search_npc(role.npc, 4, 20, nil, true, true)
    for _, curNpc in pairs(targetList) do
      for _, trapNpc in pairs(role.areaSearchTargetList) do
        if check_npc_distance(curNpc, trapNpc, 2.5, true) then
          goto lbl_41
        end
      end
      table.insert(role.areaSearchTargetList, curNpc)
      ::lbl_41::
    end
    role:doAfter(function()
      for k, v in pairs(role.areaSearchTargetList) do
        cast_magic(role.npc, v, 102371, 1)
        cast_magic(role.npc, v, 102372, 1)
        cast_magic(role.npc, v, 102375, 1)
      end
    end, 0.01, true)
  end
  magics.waterArea[2].onEnd = function(magic, casterNpc, target)
    role.tool:abortMagicToTeam(102360)
    role:set_search_kind()
    local targetList = search_npc(role.npc, 4, 20, nil, true, true)
    for k, v in pairs(targetList) do
      abort_magic_by_id(v, 102375)
      abort_magic_by_id(v, 102371)
      abort_magic_by_id(v, 102372)
    end
  end
  magics.waterArea[3].onBegin = function(magic, casterNpc, target)
    role.tool:castMagicToTeam(102360)
    magics.waterArea[3].isUltWater = true
  end
  magics.waterArea[3].onEnd = function(magic, casterNpc, target)
    role.tool:abortMagicToTeam(102360)
    magics.waterArea[3].isUltWater = false
  end
  
  function magics.rainArea.onBegin(magic, casterNpc, target)
    role:doAfter(function(role)
      role.rainStaty = true
      role.rainTimeMagic = role.nowTime
      role.rainTime = role.nowTime + role.rainTimeDuration
      if role:isRampage() then
        role.rainTime = role.nowTime + 15
        local sk2 = role.btns.sk2
        local skill03 = role.icons.skill03AreaAtkPro
        sk2:setIcon(skill03)
      end
    end, 1.5, true)
  end
  
  function magics.rainArea.onEnd(magic, casterNpc, target)
    role.rainStaty = false
    if role:isRampage() then
      local sk2 = role.btns.sk2
      local skill03 = role.icons.skill03Flash
      sk2:setIcon(skill03)
    end
  end
  
  magics.collideTime[1].onBegin = function(magic, casterNpc, target)
    local function timeCalculator()
      local Time = 0.3076923076923077
      
      return -Time
    end
    
    role:doAfter(function(role)
      if is_cast_skill_time(role.npc, 100102332) then
        for k, v in pairs(role.areaAtkTargetList) do
          if v == target then
            role.areaAtkTargetList[k] = nil
            abort_magic_by_id(target, role.magics.collideTime[1].id, 1)
            abort_magic_by_id(target, 102346, 1)
          end
          table.remove(role.areaAtkTargetList, 1)
        end
      end
    end, timeCalculator(), true)
  end
  magics.collideTime[2].onBegin = function(magic, casterNpc, target)
    local function timeCalculator()
      local Time = 0.46153846153846156
      
      return -Time
    end
    
    role:doAfter(function(role)
      if is_cast_skill_time(role.npc, 100102332) then
        for k, v in pairs(role.areaAtkTargetList) do
          if v == target then
            role.areaAtkTargetList[k] = nil
            abort_magic_by_id(target, role.magics.collideTime[2].id, 1)
            abort_magic_by_id(target, 102347, 1)
          end
          table.remove(role.areaAtkTargetList, 1)
        end
      end
    end, timeCalculator(), true)
  end
  
  function skActs.skill03Flash.canStay()
    return false, true
  end
  
  do
    local icons = role.icons
    
    local function cancelSk3(icon)
      local role = icon.role
      local roleAct = role.skAct
      if roleAct ~= role.skActs.skill03Flash then
        return
      end
      abort_skill(role.npc, true)
    end
    
    icons.skill03Flash.cancelUp:addUiAct(cancelSk3)
    
    local function skillstaty(icon)
      icon.base.updateEnable(icon)
      if icon.isEnable and icon.role.buttonDustTime > 0 then
        icon.isEnable = false
      end
    end
    
    icons.skill02_1.updateEnable = skillstaty
    icons.atk.updateEnable = skillstaty
    
    function icons.dash.updateEnable(dash)
      dash.isEnable = not check_magic(dash.role.npc, dash.cdMagic.id)
      if dash.isEnable and dash.role.buttonDustTime > 0 then
        dash.isEnable = false
      end
    end
    
    function skills.skill03FlashStr.onBegin(skill03FlashStr)
      local pos = get_npc_pos(role.npc)
      cast_magic(role.npc, role.npc, 102323, 1)
    end
    
    function skills.skill03FlashStr.onBreak(skill03FlashStr)
      cast_magic(role.npc, role.npc, 102354, 1)
      cast_magic(role.npc, role.npc, 102364, 1)
    end
    
    function skills.skill03FlashStr.onEnd(skill03FlashStr)
      skill03FlashStr.base.onEnd()
      cast_magic(role.npc, role.npc, 102354, 1)
      cast_magic(role.npc, role.npc, 102364, 1)
    end
    
    function magics.skill03FlashTime.onEnd(magic, casterNpc, target)
      cast_magic(role.npc, role.npc, 102354, 1)
      on_up_skill_btn(20, true)
    end
    
    function skills.skill03Area.onBegin(skill03Area)
      role.areaSearchTargetList = {}
      role.areaAtkTargetList = {}
      role.areaMIsList = {}
      role.skill02MarkList = {}
      role.skill03TimeList = {}
      local pos_button = {x = nil, z = nil}
      pos_button.x, pos_button.z = get_indicator_pos(20)
      if not pos_button.x then
        pos_button = get_npc_pos(role.npc)
      end
      flash_to_pos(role.npc, pos_button.x, pos_button.z)
      role:set_search_kind()
      local targetList = search_npc(role.npc, 4, 20, nil, true, true)
      role.skill03TimeList = targetList
      for _, curNpc in pairs(targetList) do
        if 2 == get_role_kind(curNpc) then
          role:doAfter(function()
            cast_magic(role.npc, curNpc, 102355, 1)
          end, 0.1)
        else
          cast_magic(role.npc, curNpc, 102355, 1)
        end
        if check_magic(curNpc, role.magics.skill02Mark.id) then
          table.insert(role.skill02MarkList, curNpc)
        end
        for _, trapNpc in pairs(role.areaSearchTargetList) do
          if check_npc_distance(curNpc, trapNpc, 2.5, true) then
            abort_magic_by_id(curNpc, role.magics.skill02Mark.id, 1)
            goto lbl_111
          end
        end
        table.insert(role.areaSearchTargetList, curNpc)
        ::lbl_111::
      end
      local distance = {}
      for k, v in pairs(role.areaSearchTargetList) do
        local posSet = get_npc_pos(v)
        if check_magic(v, role.magics.skill02Mark.id) then
          table.insert(role.areaMIsList, nil)
          if posSet then
            cast_missile(v, v, posSet.x, posSet.z, misIds.misArea[2], 0)
          end
        else
          table.insert(role.areaMIsList, nil)
          if posSet then
            cast_missile(v, v, posSet.x, posSet.z, misIds.misArea[1], 0)
          end
        end
        table.insert(distance, get_npc_distance(role.npc, 1, v, true))
        cast_missile(role.npc, v, nil, nil, 10010233503, 0)
        cast_magic(role.npc, v, 102368, 1)
      end
      local pos_my = get_npc_to_camera_offset_position(role.npc, 35, 1)
      lookat_position(role.npc, pos_my.x, pos_my.z, true)
      if distance[1] then
        role.buttonDustTime = math.max(table.unpack(distance)) / 13 + 0.4 + 0.4
        role:doAfter(function()
          role.buttonDustTime = 0
        end, role.buttonDustTime, true)
      end
    end
    
    function skills.skill03Area.onBreak(skill03Area)
      local role = skill03Area.role
      local skAct = role.skAct
      if skAct.name == "skill03AreaAtk" then
        return
      end
      abort_magic_by_id(role.npc, 102358)
      for k, v in pairs(role.areaMIsList) do
        if v then
          remove_missile(v)
          role.areaMIsList[k] = nil
        end
      end
      for k, v in pairs(role.skill03TimeList) do
        abort_magic_by_id(v, 102346)
        abort_magic_by_id(v, 102347)
        abort_magic_by_id(v, 102373)
        abort_magic_by_id(v, 102374)
        abort_magic_by_id(v, 102355)
        abort_magic_by_id(v, 102361)
        abort_magic_by_id(v, 102362)
      end
    end
    
    misLogics.misAreaOpenHit[1].onHit = function(bladeFall, misInst, casterNpc, hitTarget, hitType, skill)
      if check_npc_status(hitTarget, 10) then
        cast_missile(role.npc, hitTarget, nil, nil, 10010233504, 0)
      end
    end
    misLogics.misAreaOpenHit[2].onHit = function(bladeFall, misInst, casterNpc, hitTarget, hitType, skill)
      if check_npc_status(hitTarget, 10) then
        cast_missile(role.npc, hitTarget, nil, nil, 10010233504, 0)
      end
    end
    misLogics.misArea[1].onBegin = function(missile_cfg, missile, owner, pos_x, pos_z)
      local key
      for k, v in pairs(role.areaSearchTargetList) do
        if v == owner then
          key = k
        end
      end
      role.areaMIsList[key] = missile
    end
    misLogics.misArea[2].onBegin = function(missile_cfg, missile, owner, pos_x, pos_z)
      local key
      for k, v in pairs(role.areaSearchTargetList) do
        if v == owner then
          key = k
        end
      end
      role.areaMIsList[key] = missile
    end
    
    function misLogics.misAreaRipplesEffect.onBegin(missile_cfg, missile, owner, pos_x, pos_z)
      abort_magic_by_id(role.npc, magics.rainArea.id, 1)
    end
    
    function misLogics.misAreaRipplesEffect.onEnd(missile_cfg, missile, owner, pos_x, pos_z)
      local sk2 = role.btns.sk2
      local skill03 = role.icons.skill03Flash
      sk2:setIcon(skill03, 0.5)
      role.buttonDustTime = 0
      role:set_search_kind()
      local targetList = search_npc(role.npc, 4, 20, nil, true, true)
      for k, v in pairs(targetList) do
        abort_magic_by_id(v, 102346)
        abort_magic_by_id(v, 102347)
        abort_magic_by_id(v, 102373)
        abort_magic_by_id(v, 102374)
      end
      role:doAfter(function(role)
        abort_magic_by_id(role.npc, 102358)
      end, 1.3, true)
    end
    
    function magics.skill03AtkTime.onBegin(magic, casterNpc, target)
      local skAct = role.skAct
      if skAct.name == "skill03AreaAtk" or skAct.name == "linkQte" then
        local isHit = false
        for k, v in pairs(role.areaAtkTargetList) do
          cast_missile(role.npc, v, nil, nil, 10010233506, 0)
          cast_missile(role.npc, v, nil, nil, 10010233508, 0)
          if 1 == k then
            cast_magic(role.npc, role.npc, magics.rainArea.id, 1)
            isHit = true
          end
        end
        local targetList = search_npc(role.npc, 4, 30, 102355, true, true)
        for k, v in pairs(targetList) do
          abort_magic_by_id(v, 102355)
          abort_magic_by_id(v, 102362)
          cast_magic(role.npc, v, 102361, 1)
        end
        if isHit then
          set_keyframe_enable(role.npc, 10010233308, true, true)
          set_keyframe_enable(role.npc, 10010233309, true, true)
          role:doAfter(function(role)
            for k, v in pairs(role.skill03TimeList) do
              abort_magic_by_id(v, 102355)
              abort_magic_by_id(v, 102361)
            end
          end, 1, true)
        else
          set_keyframe_enable(role.npc, 10010233308, false, true)
          set_keyframe_enable(role.npc, 10010233309, false, true)
          for k, v in pairs(role.skill03TimeList) do
            abort_magic_by_id(v, 102355)
            abort_magic_by_id(v, 102361)
          end
        end
      end
    end
    
    misLogics.misAreaSwordHitList = {}
    
    function misLogics.misAreaSwordHit.onHit(misLogic, misInst, casterNpc, hitTarget, hitType, skill, part_npc)
      if not hitTarget.IsSwordHit then
        table.insert(misLogics.misAreaSwordHitList, hitTarget)
        for _, skill02target in pairs(role.skill02MarkList) do
          if hitTarget == skill02target then
            cast_magic(skill02target, skill02target, 102315)
          end
        end
        hitTarget.IsSwordHit = true
      end
    end
    
    function misLogics.misAreaSwordHit.onEnd(misLogic, misInst, casterNpc, hitTarget, hitType, skill, part_npc)
      for k, v in pairs(misLogics.misAreaSwordHitList) do
        v.IsSwordHit = false
      end
      misLogics.misAreaSwordHitList = {}
    end
    
    function skills.skill03AreaAtk.onBegin(skill03AreaAtk)
      role:doAfter(function(role)
        for k, v in pairs(role.areaMIsList) do
          if v then
            remove_missile(v)
            role.areaMIsList[k] = nil
          end
        end
      end, 0.1, true)
    end
    
    function icons.skill03Flash.indi.tarPosInit(indi)
      return indi.role.npc:get_pos_vec3()
    end
    
    function skActs.skill03AreaAtkPro.isReady()
      return true
    end
    
    function skActs.skill03AreaAtkPro.start()
      if role.rainStaty and role:isRampage() then
        local pos_button = {x = nil, z = nil}
        pos_button.x, pos_button.z = get_indicator_pos(20)
        cast_missile(role.npc, nil, pos_button.x, pos_button.z, 10010233516, 0)
        cast_magic(role.npc, role.npc, 102388, 1)
      end
    end
  end
  
  function skills.ult.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      set_keyframe_enable(role.npc, 10010238131, false, true)
      set_keyframe_enable(role.npc, 10010238111, false, true)
      return 100
    else
      set_keyframe_enable(role.npc, 10010238131, true, true)
      set_keyframe_enable(role.npc, 10010238111, true, true)
      return 0
    end
  end
  
  function skills.ult2.startFrame(ult)
    local skAct = ult.skAct
    if skAct:isUltFast() then
      set_keyframe_enable(role.npc, 10010238441, false, true)
      set_keyframe_enable(role.npc, 10010238442, false, true)
      set_keyframe_enable(role.npc, 10010238402, false, true)
      set_keyframe_enable(role.npc, 10010238451, false, true)
      set_keyframe_enable(role.npc, 10010238443, true, true)
      set_keyframe_enable(role.npc, 10010238444, true, true)
      set_keyframe_enable(role.npc, 10010238445, true, true)
      set_keyframe_enable(role.npc, 10010238452, true, true)
      set_keyframe_enable(role.npc, 10010238461, true, true)
      return 1
    else
      set_keyframe_enable(role.npc, 10010238441, true, true)
      set_keyframe_enable(role.npc, 10010238442, true, true)
      set_keyframe_enable(role.npc, 10010238402, true, true)
      set_keyframe_enable(role.npc, 10010238451, true, true)
      set_keyframe_enable(role.npc, 10010238443, false, true)
      set_keyframe_enable(role.npc, 10010238444, false, true)
      set_keyframe_enable(role.npc, 10010238445, false, true)
      set_keyframe_enable(role.npc, 10010238452, false, true)
      set_keyframe_enable(role.npc, 10010238461, false, true)
      return 8
    end
  end
  
  do
    local magicList = {
      nil,
      102316,
      102317,
      102318,
      102319,
      102320
    }
    local elementType
    local teamElement = {}
    
    function skills.ult.onBegin(ult)
      role:change_follow_target(1, role.target, {
        9999,
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        0,
        0,
        30,
        0,
        1
      })
      local posSet = role.target and get_npc_offset_position(role.target, get_npc_to_camera_offset_position(role.target, 1, 0), 0, 2.5) or get_npc_pos(role.npc)
      role:tp(posSet, 30, posSet)
      local pos_my = get_npc_to_camera_offset_position(role.npc, 1, 0)
      lookat_position(role.npc, pos_my.x, pos_my.z, true)
      role.areaSearchTargetList = {}
      local castNpc = get_come_on_hero()
      teamElement = {}
      for k, v in pairs(role.tool.team.role) do
        local list = {
          npc = v.npc,
          attr = get_npc_attr(v.npc, 23)
        }
        table.insert(teamElement, list)
      end
      table.sort(teamElement, function(a, b)
        if a.attr > b.attr then
          return true
        elseif a.attr == b.attr then
          return a.npc.id > b.npc.id
        end
        return false
      end)
      elementType = get_active_char_element(teamElement[1].npc)
      role:set_search_kind()
      local targetList = search_npc(castNpc, 4, 20, nil, true, true)
      for k, v in pairs(targetList) do
        change_abnormal_flag_count(v, elementType, 1)
      end
    end
    
    function skills.ult2.onBegin(ult2)
      ult2.base.onBegin(ult2)
      if role.target and not check_npc_die(role.target) then
        role.posTarget = get_npc_offset_position(role.target, get_npc_pos(role.npc), 0, 4)
        flash_to_pos(role.npc, role.posTarget.x, role.posTarget.z)
      end
      local pos_my = get_npc_to_camera_offset_position(role.npc, 3, 180)
      lookat_position(role.npc, pos_my.x, pos_my.z, true)
    end
    
    function misLogics.misUltCamera.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if role.target then
        role:change_follow_target(1, misInst, {
          9999,
          0,
          {
            x = 0,
            y = 0,
            z = 250
          },
          0,
          0,
          0.08
        })
      end
    end
    
    function misLogics.misUltCamera.onEnd(missile, misInst, casterNpc, hitTarget, hitType, skill)
      if role.skAct == role.skActs.ult or role.skAct == role.skActs.ultFast then
        role:change_follow_target(4)
        change_focus_follow_speed(1.5)
      end
    end
    
    local function skillUltCameraReset()
      role:change_follow_target(4)
      change_focus_follow_speed(6)
    end
    
    function skills.ult2.onBreak(ult2)
      ult2.base.onBreak(ult2)
      skillUltCameraReset()
    end
    
    function skills.ult2.onEnd(ult2)
      ult2.base.onEnd(ult2)
      skillUltCameraReset()
    end
    
    misLogics.misUlt1Atk[2].onBegin = function(missile, misInst, casterNpc, hitTarget, hitType, skill)
      cast_missile(role.npc, role.target, nil, nil, 10010233513, 0)
      role:change_follow_target(4)
      change_focus_follow_speed(5)
    end
    
    function misLogics.misUlt2Atk.onBegin(missile, misInst, casterNpc, hitTarget, hitType, skill)
      role:set_search_kind()
      local targetList = search_npc(role.npc, 4, 20, nil, true, true)
      for k, v in pairs(targetList) do
        abort_magic_by_id(v, 102375)
      end
    end
    
    local function onUltBreak(ult, tarAct)
      ult.role:StopUlt(true)
      return ult.base.onBreak(ult, tarAct)
    end
    
    skActs.ult.onBreak = onUltBreak
    skActs.ultFast.onBreak = onUltBreak
    
    function skills.linkQte.onBegin(linkQte)
      role.areaSearchTargetList = {}
      role.areaAtkTargetList = {}
      role.areaMIsList = {}
      role:set_search_kind()
      local targetList = search_npc(role.npc, 4, 30, nil, true, true)
      role.skill03TimeList = targetList
      for _, curNpc in pairs(targetList) do
        cast_magic(role.npc, curNpc, 102355, 1)
        for _, trapNpc in pairs(role.areaSearchTargetList) do
          if check_npc_distance(curNpc, trapNpc, 2.5, true) then
            abort_magic_by_id(curNpc, role.magics.skill02Mark.id, 1)
            goto lbl_65
          end
        end
        table.insert(role.areaSearchTargetList, curNpc)
        table.insert(role.areaAtkTargetList, curNpc)
        ::lbl_65::
      end
      local posSet
      local pos_my = get_npc_to_camera_offset_position(role.npc, 35, 1)
      lookat_position(role.npc, pos_my.x, pos_my.z, true)
    end
    
    function skills.linkQte.onEnd(linkQte)
      linkQte.base.onEnd(linkQte)
      role:doAfter(function(role)
        abort_magic_by_id(role.npc, 102358)
      end, 1.3, true)
    end
  end
  
  function role.waterLogic(role)
    role.nowTime = get_npc_time(role.npc)
    if role.rainStaty then
      if role.nowTime >= role.rainTime then
        abort_magic_by_id(role.npc, magics.rainArea.id)
      end
      if role.nowTime >= role.rainTimeMagic then
        role.rainTimeMagic = role.nowTime + role.rainTimeMagicInterval
        role:set_search_kind()
        local targetList = {}
        local targetListNew = {}
        local numbMax = 0
        local randomNumber = 1
        local rainTarget
        targetList = search_npc(role.npc, 4, 20, nil, true, true)
        for k, v in pairs(targetList) do
          if not check_npc_die(v) then
            table.insert(targetListNew, v)
            numbMax = numbMax + 1
          end
        end
        if numbMax >= 1 then
          randomNumber = math.random(1, numbMax)
        end
        rainTarget = targetListNew[randomNumber]
        if rainTarget and not check_npc_die(rainTarget) then
          cast_missile(role.npc, rainTarget, nil, nil, 10010233510, 0)
        end
        if role.traceLv >= 4 then
          role:doAfter(function(role)
            role:set_search_kind()
            local targetList = {}
            local targetListNew = {}
            targetList = search_npc(role.npc, 4, 12, nil, true, true)
            numbMax = 0
            randomNumber = 0
            for k, v in pairs(targetList) do
              if v ~= rainTarget and not check_npc_die(v) then
                table.insert(targetListNew, v)
                numbMax = numbMax + 1
              end
            end
            if numbMax >= 1 then
              randomNumber = math.random(1, numbMax)
              rainTarget = targetListNew[randomNumber]
            end
            if rainTarget and not check_npc_die(rainTarget) then
              cast_missile(role.npc, rainTarget, nil, nil, 10010233510, 0)
            end
          end, 0.35, true)
        end
      end
    end
  end
end

function Jixia.on_missile_collide(role, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  roleBase.on_missile_collide(role, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if (m2_cfg.Id == role.misLogics.misArea[1].id or m2_cfg.Id == role.misLogics.misArea[2].id) and not npc_is_destroy(m2) and m1_cfg.Id == role.misLogics.misAreaRipplesEffect.id then
    remove_missile(m2)
    for k, v in pairs(role.areaMIsList) do
      if m2 == v then
        abort_magic_by_id(role.areaSearchTargetList[k], 102373)
        abort_magic_by_id(role.areaSearchTargetList[k], 102374)
        if check_magic(role.areaSearchTargetList[k], 102346) then
          cast_magic(role.npc, role.areaSearchTargetList[k], 102348, 1)
        elseif check_magic(role.areaSearchTargetList[k], 102347) then
          cast_magic(role.npc, role.areaSearchTargetList[k], 102349, 1)
        end
        table.insert(role.areaAtkTargetList, role.areaSearchTargetList[k])
      end
    end
  end
end

function Jixia.on_npc_hp_zero(role, npc)
  role.base.on_npc_hp_zero(role, npc)
  if npc.H1001023Area and npc:get_camp() ~= role.npc:get_camp() then
    role.destiniesMagic.Lv1.num = role.destiniesMagic.Lv1.num - 1
    npc.H1001023Area = false
  end
end

function Jixia.on_npc_born(role, npc)
  if 1 ~= get_role_kind(npc) and (get_role_kind(npc) < 5 or 8 == get_role_kind(npc)) and (role.skAct.name == "ult" or role.skAct.name == "ultFast") then
    table.insert(role.areaSearchTargetList, npc)
  end
end

function Jixia.on_element_aborn_start(role, npc, element, skill_id)
  if 2 == element and check_magic(npc, 102315) then
    role:doAfter(function()
      abort_magic_by_id(npc, 102315)
    end, 0.05, true)
  end
end

function Jixia.on_input(role, input_id)
  role.base.on_input(role, input_id)
end

function Jixia.on_keyframe_action(role, kfId, npcTag, comnTag)
  if "skill02Mark" == npcTag then
    for k, v in pairs(role.skills.skill02_1.hitTargetList) do
      cast_magic(role.npc, v, role.magics.skill02Mark.id, 1)
      v.IsSkill02Hit = false
    end
  end
  if "skill03AreaAtkButton" == npcTag then
    local sk2 = role.btns.sk2
    local skill03 = role.icons.skill03AreaAtk
    sk2:setIcon(skill03, 0.5)
  end
  if "water" == npcTag then
    if role.destinyLv >= 1 then
      cast_magic(role.npc, role.npc, role.magics.waterArea[3].id, 0)
    else
      cast_magic(role.npc, role.npc, 102365, 0)
    end
  end
  if "ult" == npcTag then
    local team_hero_list = {
      get_scene_hero_by_poskey(21),
      get_scene_hero_by_poskey(22),
      get_come_on_hero()
    }
    local skillLv = get_skill_lv(role.npc, 100102381) or 1
    for k, v in pairs(team_hero_list) do
      if v then
        cast_magic(v, v, 102321, skillLv)
      end
    end
  end
end

function Jixia.onRampageStart(role, stage)
end

function Jixia.onRampageEnd(role, stage)
  if role.skAct.name ~= "skill03Area" then
    if get_come_on_hero() == role.npc then
      cast_magic(role.npc, role.npc, 102395, 1)
    end
    local sk2 = role.btns.sk2
    local skill03 = role.icons.skill03Flash
    sk2:setIcon(skill03, 0.5)
  end
end

function Jixia.StopUlt(role, force)
  if force or is_cast_skill_time(role.npc, 100102381) or is_cast_skill_time(role.npc, 100102384) then
    abort_skill(role.npc, 1)
    abort_magic_by_id(role.npc, role.magics.waterArea[2].id)
    abort_magic_by_id(role.npc, 102332)
    role:abortMagic(102384)
    cast_magic(role.npc, role.npc, 102387, 1)
  end
end

function Jixia.on_timeline_begin(role)
  role.StopUlt(role)
end

function Jixia.on_room_change(role)
  cast_magic(role.npc, role.npc, 102387, 1)
  role.tool:abortMagicToTeam(102360)
end

function Jixia.on_frame_background(role)
  role.base.on_frame_background(role)
  role.waterLogic(role)
end

function Jixia.on_frame(role)
  role.base.on_frame(role)
  role.waterLogic(role)
end

function Jixia.force_shift_magic_init(role, magic_id, target)
  if 102311 == magic_id and role.skAct == role.skActs.skill02_1 then
    local monsterPos = get_npc_pos(target)
    local basePos = role.skill02MovePos
    local dir = basePos - monsterPos
    return basePos
  end
end

function Jixia.set_search_kind(role)
  set_search_npc_limit(2)
  set_search_npc_limit(3)
  set_search_npc_limit(4)
  set_search_npc_limit(8)
  set_search_npc_limit(9)
end

function Jixia.on_before_skill_link_end(role, npc)
  role.base.on_before_skill_link_end(role, npc)
  role.tool:abortMagicToTeam(1001904, 1001905, 1001909, 1004114, 10041141, 1008989, 10099082, 10099084, 1009908, 10099086, 1010995, 1010130, 1011194, 1011196, 1012804, 1013501, 10135011, 101494, 101496, 1015100, 1015102, 1016036, 1017100, 1017102, 1018313, 1019100, 1019109, 1020100, 1020098, 1021045, 10210451, 1022090, 10220901, 1024100, 1027107)
end

return Jixia
