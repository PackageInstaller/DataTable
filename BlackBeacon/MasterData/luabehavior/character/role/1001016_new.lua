local roleBase = import("character.base.role_base")
local vec3 = require("base.vec3")
local Viola = Util.create_child_mt(roleBase)

function Viola._init(role, npc)
  role.npc = npc
  local misIds_1 = {
    misYellow = 10010161103,
    misYellowEx = 10010161102,
    misRed = 10010161101,
    waveYellowFx = 10010162901,
    waveYellowDamage = 10010162903,
    waveYellowDamageJudge = 10010161313,
    waveRedFx = 10010162902,
    waveRedDamage = 10010162904,
    waveRedDamageJudge = 10010161314,
    misBoom = 10010161104,
    BoomRedFx = 10010161105,
    BoomYellowFx = 10010161106,
    ultMis = {
      10010162001,
      10010162002,
      10010162003,
      10010162004,
      10010162005,
      10010162006,
      10010162007
    },
    violinMis = 10010161311,
    exQte2ndHit = 10010161302
  }
  local magicIds_1 = {
    balletStartDerive = 1016037,
    balletLoopDerive = 1016039,
    balletMisTimer = 1016038,
    balletSpeedUp = 1016043,
    balletCd = 1016609,
    thunderFx = 1016040,
    thunderCamShake = 1016028,
    noteChangeCamShake = 1016028,
    waveRecovery = 1016933,
    trace4AddPursuit = 1016940,
    misDamageFix = 1016932,
    slowDown = 1016201,
    ultDamageFix = 1016524,
    waveDamageFix = {
      1016520,
      1016526,
      1016527,
      1016528,
      1016529
    },
    spWeaponTagNum = 1016192,
    balletWeaponEffectAbort = 1016025,
    ultMagic = {
      1016045,
      1016046,
      1016047,
      1016048,
      1016049,
      1016050,
      1016051
    },
    violinMagic = 1016004,
    abortViolinMagic = 1016005,
    violinTagMagic = 1016052,
    ult_hair_magic_skin_1 = 1016026,
    ult_hair_magic_skin_2 = 1016053,
    finish_hair_magic_skin_1 = 1016947,
    finish_hair_magic_skin_2 = 1016948
  }
  roleBase._init(role, misIds_1, magicIds_1)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  local traces = role.traces
  local destinies = role.destinies
  local spWeapon = role.spWeapon
  local model_id = get_role_fashion_id(role.npc)
  skActs.atk2.reset.delay = 0.5
  do
    local note = {}
    role.note = note
    
    function role.alter1(role)
      local btns = role.btns
      local icons = role.icons
      local skActs = role.skActs
      btns.sk1:setIcon(icons.balletUp)
      if not skActs.ballet.isCdCasted then
        change_skill_cd(role.npc, btns.sk1.id, 2, magics.balletCd.id)
        skActs.ballet.isCdCasted = true
      end
    end
    
    note.role = role
    note._castPos = vec3:New()
    note.thunderFx = magics.thunderFx
    note.thunderCamShake = magics.thunderCamShake
    note.misYellow = misLogics.misYellow
    note.misYellowEx = misLogics.misYellowEx
    note.misRed = misLogics.misRed
    note.balletLv = get_skill_lv(role.npc, skills.balletLoop.id)
    note.balletCost = skills.balletLoopIcon.cost.battle
    note.max = 2
    note.sk1 = btns.sk1
    note.balletUp = icons.balletUp
    
    function note.castMisYellow(note, posx, posz, noCost, noSpread)
      local role = note.role
      cast_magic(role.npc, role.npc, note.thunderCamShake.id)
      if not noCost then
        role:costAttr2(note.balletCost)
      end
      local tarMis = note.misYellow
      if noSpread then
        tarMis = note.misYellowEx
      end
      local pos = note._castPos
      pos:Set(posx, 0, posz)
      pos = role:fixPosA(pos, -60)
      cast_missile(role.npc, nil, pos.x, pos.z, tarMis.id, note.balletLv, nil, nil, nil, pos.y, pos.x, pos.z, pos.y, role.skills.balletStart:skInfo())
      role:updateAttr()
      if role.attr[2] < note.balletCost then
        role:alter1()
      end
    end
    
    function note.castMisRed(note, posx, posz)
      local role = note.role
      cast_magic(role.npc, role.npc, note.thunderCamShake.id)
      local pos = note._castPos
      pos:Set(posx, 0, posz)
      pos = role:fixPosA(pos, -60)
      cast_missile(role.npc, nil, pos.x, pos.z, note.misRed.id, note.balletLv, nil, nil, nil, nil, nil, nil, nil, role.skills.balletStart:skInfo())
    end
    
    note.list = {}
    note.waitList = {}
    note.yellowNum = 0
    note.redNum = 0
    
    function note.add(note, mis)
      local list = note.list
      table.insert(list, 1, mis)
      if mis.d_color == "yellow" then
        note.yellowNum = note.yellowNum + 1
      elseif mis.d_color == "red" then
        note.redNum = note.redNum + 1
      end
      note:removeWait(get_missile_uuid(mis))
      note:gcByColor(mis.d_color)
    end
    
    function note.addWait(note, uuid, color)
      local waitList = note.waitList
      if waitList[uuid] then
        return note.role:debugOuput("note.addWait is called but uuid is occupied, color is ", color)
      end
      waitList[uuid] = color
    end
    
    function note.removeWait(note, uuid)
      local waitList = note.waitList
      if not waitList[uuid] then
        return
      end
      waitList[uuid] = nil
    end
    
    note.removeList = {}
    
    function note.gcByColor(note, color)
      local list = note.list
      local removeList = note.removeList
      local max = note.max
      local retainPos = max
      for i = max, #list do
        if list[i].d_color ~= color then
          retainPos = i
          break
        end
      end
      for i = max, #list do
        if i ~= retainPos then
          table.insert(removeList, list[i])
        end
      end
      for i, mis in pairs(removeList) do
        remove_missile(mis)
        removeList[i] = nil
      end
    end
    
    function note.gcByTime(note, color)
      local list = note.list
      local removeList = note.removeList
      local max = note.max
      for i = max + 1, #list do
        table.insert(removeList, list[i])
      end
      for i, mis in pairs(removeList) do
        remove_missile(mis)
        removeList[i] = nil
      end
    end
    
    function note.remove(note, mis)
      local pos
      for i, usbInst in ipairs(note.list) do
        if usbInst == mis then
          pos = i
        end
      end
      if not pos then
      else
        table.remove(note.list, pos)
        if mis.d_color == "yellow" then
          note.yellowNum = note.yellowNum - 1
        elseif mis.d_color == "red" then
          note.redNum = note.redNum - 1
        end
      end
    end
    
    function note.enableChange(note)
      for _, mis in ipairs(note.list) do
        mis.d_enableChange = true
      end
    end
    
    note.changeCamShake = magics.noteChangeCamShake
    
    function note.change(note, mis)
      local tarMis, tarColor
      if mis.d_color == "yellow" then
        tarMis = note.misRed
        tarColor = "red"
      elseif mis.d_color == "red" then
        tarMis = note.misYellowEx
        tarColor = "yellow"
      end
      local isWave = false
      local misColor = mis.d_color
      for _, _mis in pairs(note.list) do
        if _mis ~= mis and _mis.d_color == misColor then
          isWave = true
          break
        end
      end
      for _, color in pairs(note.waitList) do
        if color == misColor then
          isWave = true
          break
        end
      end
      local pos = get_missile_pos(mis)
      remove_missile(mis)
      local role = note.role
      local uuid = cast_missile(role.npc, nil, pos.x, pos.z, tarMis.id, note.balletLv, nil, nil, nil, nil, nil, nil, nil, role.skills.balletStart:skInfo())
      note:addWait(uuid, tarColor)
      cast_magic(role.npc, role.npc, note.changeCamShake.id)
      return isWave
    end
    
    note.timer = 0
    note.interval = 1.1
    note.waveLv = get_skill_lv(role.npc, 100101629)
    note.waveYellowFx = misLogics.waveYellowFx
    note.waveYellowDamage = misLogics.waveYellowDamage
    note.waveRedFx = misLogics.waveRedFx
    note.waveRedDamage = misLogics.waveRedDamage
    
    function note.tick(note)
      if 0 == note.yellowNum or 0 == note.redNum then
        return
      end
      local role = note.role
      local now = get_npc_time(role.npc)
      if now < note.timer then
        return
      end
      local lv = note.waveLv
      note.timer = now + note.interval
      for _, mis in ipairs(note.list) do
        local fx, damage
        if mis.d_color == "yellow" then
          fx = note.waveYellowFx
          damage = note.waveYellowDamage
        elseif mis.d_color == "red" then
          fx = note.waveRedFx
          damage = note.waveRedDamage
        end
        local pos = get_missile_pos(mis)
        cast_missile(role.npc, nil, pos.x, pos.z, fx.id, lv, nil, nil, nil, pos.y, nil, nil, nil, role.skills.balletStart:skInfo())
        cast_missile(role.npc, nil, pos.x, pos.z, damage.id, lv, nil, nil, nil, pos.y, nil, nil, nil, role.skills.balletStart:skInfo())
      end
    end
    
    misLogics.misYellow.note = note
    
    function misLogics.misYellow.onBegin(misYellow, misInst, owner, posX, posZ)
      misInst.d_enableChange = false
      misInst.d_color = "yellow"
      misYellow.note:add(misInst)
    end
    
    function misLogics.misYellow.onEnd(misYellow, misInst, owner, posX, posZ)
      misYellow.note:remove(misInst)
    end
    
    function misLogics.misYellow.onCollideMis(misYellow, misInst, mis2, misOwner, mis2Owner)
      if mis2Owner ~= misOwner then
        return
      end
      if not misInst.d_enableChange then
        return
      end
      misInst.d_enableChange = false
      misInst.d_isWavedOnChange = misYellow.note:change(misInst)
    end
    
    misLogics.misYellowEx.note = note
    
    function misLogics.misYellowEx.onBegin(misYellowEx, misInst, owner, posX, posZ)
      misInst.d_enableChange = false
      misInst.d_color = "yellow"
      misYellowEx.note:add(misInst)
    end
    
    function misLogics.misYellowEx.onEnd(misYellowEx, misInst, owner, posX, posZ)
      misYellowEx.note:remove(misInst)
    end
    
    function misLogics.misYellowEx.onCollideMis(misYellowEx, misInst, mis2, misOwner, mis2Owner)
      if mis2Owner ~= misOwner then
        return
      end
      if not misInst.d_enableChange then
        return
      end
      misInst.d_enableChange = false
      misInst.d_isWavedOnChange = misYellowEx.note:change(misInst)
    end
    
    misLogics.misRed.note = note
    
    function misLogics.misRed.onBegin(misRed, misInst, owner, posX, posZ)
      misInst.d_enableChange = false
      misInst.d_color = "red"
      misRed.note:add(misInst)
    end
    
    function misLogics.misRed.onEnd(misRed, misInst, owner, posX, posZ)
      misRed.note:remove(misInst)
    end
    
    function misLogics.misRed.onCollideMis(misRed, misInst, mis2, misOwner, mis2Owner)
      if mis2Owner ~= misOwner then
        return
      end
      if not misInst.d_enableChange then
        return
      end
      misInst.d_enableChange = false
      misInst.d_isWavedOnChange = misRed.note:change(misInst)
    end
  end
  skActs.ballet.sk1 = btns.sk1
  skActs.ballet.balletHold = icons.balletHold
  skActs.ballet.misCount = 0
  skActs.ballet.misMax = 3
  skActs.ballet.balletMisTimer = magics.balletMisTimer
  skActs.ballet.balletSpeedUp = magics.balletSpeedUp
  skActs.ballet.balletSpeedUpState = false
  
  function skActs.ballet.onBegin(ballet)
    ballet.base.onBegin(ballet)
    if ballet.balletSpeedUpState then
      cast_magic(role.npc, role.npc, ballet.balletSpeedUp.id)
    end
    ballet.misCount = 0
    ballet.isCdCasted = false
    if ballet.sk1.isDown then
      ballet.icon = ballet.balletHold
      ballet.sk1:setIcon(ballet.balletHold)
    end
  end
  
  skActs.ballet.balletUp = icons.balletUp
  skActs.ballet.cdMagic = magics.balletCd
  
  function skActs.ballet.onCastTime(ballet)
    ballet.role:alter1()
    ballet.base.onCastTime(ballet)
    abort_magic_by_id(ballet.role.npc, ballet.balletMisTimer.id)
    abort_magic_by_id(ballet.role.npc, ballet.balletSpeedUp.id)
    stop_skill_joystick_move(ballet.role.npc)
  end
  
  skActs.ballet.thunderFx = magics.thunderFx
  
  function skActs.ballet.onBreak(ballet, tarAct)
    ballet.base.onBreak(ballet, tarAct)
    ballet.role:alter1()
    cast_magic(ballet.role.npc, ballet.role.npc, magics.balletWeaponEffectAbort.id)
    abort_magic_by_id(ballet.role.npc, ballet.balletMisTimer.id)
    abort_magic_by_id(ballet.role.npc, ballet.balletSpeedUp.id)
    abort_magic_by_id(ballet.role.npc, ballet.thunderFx.id)
    stop_skill_joystick_move(ballet.role.npc)
  end
  
  icons.balletHold.skAct = skActs.ballet
  icons.balletHold.sk1 = btns.sk1
  icons.balletHold.balletUp = icons.balletUp
  do
    local function alterBalletUp(balletHold)
      if balletHold.role.skAct == balletHold.skAct then
        balletHold.role:alter1()
      end
    end
    
    icons.balletHold.hitUp:addUiAct(alterBalletUp)
    icons.balletHold.holdUp:addUiAct(alterBalletUp)
    icons.balletHold.cancelUp:addUiAct(alterBalletUp)
    magics.balletStartDerive.balletStart = skills.balletStart
    
    function magics.balletStartDerive.onBegin(balletStartDerive, casterNpc, target)
      set_skill_end_to_idle(role.npc, false)
    end
    
    function skills.balletStart.onBegin(balletStart)
      balletStart.base.onBegin(balletStart)
      stop_skill_joystick_move(balletStart.role.npc)
    end
    
    function skills.balletLoop.tarPos()
    end
    
    function skills.balletEnd.tarPos()
    end
    
    magics.balletLoopDerive.balletLoop = skills.balletLoop
    magics.balletLoopDerive.ballet = skActs.ballet
    magics.balletLoopDerive.balletCost = skills.balletLoopIcon.cost.battle
    magics.balletLoopDerive.sk1 = btns.sk1
    magics.balletLoopDerive.balletHold = icons.balletHold
    magics.balletLoopDerive.misTimer = magics.balletMisTimer
    
    function magics.balletLoopDerive.onBegin(balletLoopDerive, casterNpc, target)
      local iconCheck = balletLoopDerive.sk1.icon == balletLoopDerive.balletHold
      local act = balletLoopDerive.ballet
      local countCheck = act.misCount <= act.misMax
      local role = balletLoopDerive.unit
      role:updateAttr()
      local energyCheck = role.attr[2] >= balletLoopDerive.balletCost
      if not (iconCheck and countCheck and energyCheck) or get_come_on_hero() ~= role.npc then
        balletLoopDerive.balletLoop:deriveAuto()
      end
    end
    
    magics.balletMisTimer.ballet = skActs.ballet
    magics.balletMisTimer.sk1 = btns.sk1
    magics.balletMisTimer.balletHold = icons.balletHold
    magics.balletMisTimer.balletUp = icons.balletUp
    magics.balletMisTimer.sk1 = btns.sk1
    magics.balletMisTimer.note = role.note
    
    function magics.balletMisTimer.onBegin(balletMisTimer, casterNpc, target)
      local posx, posz = get_indicator_pos(balletMisTimer.sk1.id)
      balletMisTimer.note:castMisYellow(posx, posz)
    end
    
    magics.balletMisTimer.balletCost = skills.balletLoopIcon.cost.battle
    
    function magics.balletMisTimer.onEnd(balletMisTimer, casterNpc, target)
      local role = balletMisTimer.unit
      local iconCheck = balletMisTimer.sk1.icon == balletMisTimer.balletHold
      local act = balletMisTimer.ballet
      act.misCount = act.misCount + 1
      local numCheck = act.misCount < act.misMax
      role:updateAttr()
      local energyCheck = role.attr[2] >= balletMisTimer.balletCost
      if iconCheck and numCheck and energyCheck then
        cast_magic(role.npc, role.npc, balletMisTimer.id)
      elseif iconCheck then
        local posx, posz = get_indicator_pos(balletMisTimer.sk1.id)
        balletMisTimer.note:castMisYellow(posx, posz)
        role:alter1()
      end
    end
  end
  skActs.martele.note = role.note
  
  function skActs.martele.onBegin(martele)
    martele.base.onBegin(martele)
    martele.note:enableChange()
    local event = martele and martele.event
    if event and event.isSwitch then
      local role = martele.role
      local pos1 = get_npc_offset_position(role.npc, nil, 50, 4.5)
      local pos2 = get_npc_offset_position(role.npc, nil, -50, 4.5)
      local note = role.note
      note:castMisYellow(pos1.x, pos1.z, true)
      note:castMisRed(pos2.x, pos2.z)
    end
  end
  
  function skills.finish.onBegin(martele)
    if 3003016 == model_id then
      cast_magic(role.npc, role.npc, magics.finish_hair_magic_skin_2.id)
    else
      cast_magic(role.npc, role.npc, magics.finish_hair_magic_skin_1.id)
    end
  end
  
  set_keyframe_enable_by_tag(role.npc, 100101620, 2, false, true)
  
  function skills.ult.onBegin(ult)
    local skAct = ult.skAct
    if 3003016 == model_id then
      cast_magic(role.npc, role.npc, magics.ult_hair_magic_skin_2.id)
    else
      cast_magic(role.npc, role.npc, magics.ult_hair_magic_skin_1.id)
    end
    if skAct:isUltFast() then
      set_keyframe_enable_by_tag(role.npc, 100101620, 1, false, true)
      return 0
    else
      set_keyframe_enable_by_tag(role.npc, 100101620, 1, true, true)
      return 0
    end
  end
  
  do
    local ultMapping = {}
    for i = 1, math.min(#misIds_1.ultMis, #magicIds_1.ultMagic) do
      ultMapping[i] = {
        ultMis = misIds_1.ultMis[i],
        ultMagic = magicIds_1.ultMagic[i]
      }
    end
    
    local function ultMisCast(magicId)
      for _, v in ipairs(ultMapping) do
        if v.ultMagic == magicId then
          if role.target then
            do
              local pos = get_npc_pos(role.target)
              if 10 == get_npc_status(role.target) then
                cast_missile(role.npc, nil, pos.x, pos.z, v.ultMis, nil, nil, nil, nil, nil, nil, nil, nil, role.skills.ult:skInfo())
                break
              end
              cast_missile(role.npc, role.target, nil, nil, v.ultMis, nil, nil, nil, nil, nil, nil, nil, nil, role.skills.ult:skInfo())
            end
            break
          end
          cast_missile(role.npc, role.npc, nil, nil, v.ultMis, nil, nil, nil, nil, nil, nil, nil, nil, role.skills.ult:skInfo())
          break
        end
      end
    end
    
    for i, magicId in ipairs(magicIds_1.ultMagic) do
      if magics.ultMagic[i] then
        magics.ultMagic[i].onBegin = function()
          ultMisCast(magicId)
        end
      end
    end
    
    local function ultShowUpFx(act)
      local role = act.role
      local facePos = get_npc_offset_position(role.npc, nil, 0, 10)
      local chestPos = get_npc_pos(role.npc, "Bip001 Chest")
      chestPos.y = chestPos.y - 0.15
      create_scene_effect(Const.SWITCH_CONFIG.TO_FRONT_FLASH_QTE, chestPos, 5, nil, facePos, true)
    end
    
    skActs.ult.showUpFx = ultShowUpFx
    skActs.ultFast.showUpFx = ultShowUpFx
  end
  skActs.exQte.note = role.note
  skActs.exQte.tarPos = skActs.exQte.base.tarPos
  
  function skActs.exQte.onBegin(exQte)
    exQte.note:enableChange()
  end
  
  do
    local lastBulletColor = "yellow"
    misLogics.exQte2ndHit.note = role.note
    
    function misLogics.exQte2ndHit.onBegin(exQte2ndHit, casterNpc, hitTarget, hitType, skill, missile)
      exQte2ndHit.note:enableChange()
      local pos = get_npc_pos(role.npc)
      if "yellow" == lastBulletColor then
        cast_missile(role.npc, nil, pos.x, pos.z, misLogics.waveRedFx.id, 0)
        cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.waveRedDamage.id, 0)
        cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.waveRedDamageJudge.id, 0)
        lastBulletColor = "red"
      else
        cast_missile(role.npc, nil, pos.x, pos.z, misLogics.waveYellowFx.id, 0)
        cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.waveYellowDamage.id, 0)
        cast_missile3(role.npc, nil, pos.x, pos.z, misLogics.waveYellowDamageJudge.id, 0)
        lastBulletColor = "yellow"
      end
    end
    
    function magics.violinTagMagic.onBegin(violinTagMagic, casterNpc, target)
      if role:isRampage() and not check_magic(role.npc, magics.violinMagic.id) then
        cast_magic(role.npc, role.npc, magics.violinMagic.id)
        cast_missile3(role.npc, role.npc, nil, nil, misLogics.violinMis.id, 0)
      end
    end
  end
  traces[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local note = role.note
    note.isCastByBalletList = {}
    
    function note.refresh(note)
      local id, pos
      local role = note.role
      local uuid, color
      for _, mis in pairs(note.list) do
        id = mis.missile_id
        color = mis.d_color
        pos = get_missile_pos(mis)
        remove_missile(mis)
        uuid = cast_missile(role.npc, nil, pos.x, pos.z, id, note.balletLv, nil, nil, nil, nil, nil, nil, nil, role.skills.balletStart:skInfo())
        note:addWait(uuid, color)
      end
    end
    
    local function misCollide(misLogic, misInst, mis2, misOwner, mis2Owner)
      if not misInst.d_isWavedOnChange then
        return
      end
      misLogic.note:refresh()
    end
    
    tool.insert(misLogics.misYellow, "onCollideMis", misCollide)
    tool.insert(misLogics.misYellowEx, "onCollideMis", misCollide)
    tool.insert(misLogics.misRed, "onCollideMis", misCollide)
  end
  traces[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function recovery(mis, misInst, owner, posX, posZ)
      local now_hp = get_npc_attr(owner, 1)
      
      local hp_check = get_npc_attr(owner, 4) * 0.5
      if now_hp < hp_check then
        cast_magic(owner, owner, magics.waveRecovery.id)
      end
    end
    
    tool.insert(misLogics.waveYellowDamage, "onBegin", recovery)
    tool.insert(misLogics.waveRedDamage, "onBegin", recovery)
  end
  traces[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function misCollide(misLogic, misInst, mis2, misOwner, mis2Owner)
      if not misInst.d_isWavedOnChange then
        return
      end
      cast_magic(misOwner, misOwner, magics.trace4AddPursuit.id)
    end
    
    tool.insert(misLogics.misYellow, "onCollideMis", misCollide)
    tool.insert(misLogics.misYellowEx, "onCollideMis", misCollide)
    tool.insert(misLogics.misRed, "onCollideMis", misCollide)
  end
  destinies[1] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local note = role.note
    note.interval = 1
    
    local function change_atk_cd(mis, misInst, owner, posX, posZ, missile_cfg)
      change_missile_config(mis.id, "AtkCD", 1, 0)
    end
    
    tool.insert(misLogics.waveYellowDamage, "onBegin", change_atk_cd)
    tool.insert(misLogics.waveRedDamage, "onBegin", change_atk_cd)
    tool.insert(misLogics.misYellow, "onBegin", change_atk_cd)
    tool.insert(misLogics.misYellowEx, "onBegin", change_atk_cd)
    tool.insert(misLogics.misRed, "onBegin", change_atk_cd)
  end
  destinies[2] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    misLogics.misYellow.damageFix = magics.misDamageFix
    misLogics.misRed.damageFix = magics.misDamageFix
    misLogics.misYellowEx.damageFix = magics.misDamageFix
    
    local function damageFix(wave, misInst, caster, target, damage_sign, damage_type, target_camp, change_level, magic_level, magic_id)
      cast_magic(caster, caster, wave.damageFix.id)
    end
    
    tool.insert(misLogics.misYellow, "befDamage", damageFix)
    tool.insert(misLogics.misYellowEx, "befDamage", damageFix)
    tool.insert(misLogics.misRed, "befDamage", damageFix)
  end
  destinies[3] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    misLogics.misYellow.slowDown = magics.slowDown
    misLogics.misRed.slowDown = magics.slowDown
    misLogics.misYellowEx.slowDown = magics.slowDown
    
    local function slowDown(misLogic, misInst, casterNpc, hitTarget, hitType, skill)
      cast_magic(casterNpc, hitTarget, misLogic.slowDown.id)
    end
    
    tool.insert(misLogics.misYellow, "onHit", slowDown)
    tool.insert(misLogics.misYellowEx, "onHit", slowDown)
    tool.insert(misLogics.misRed, "onHit", slowDown)
  end
  destinies[4] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    skActs.ult.damageFix = magics.ultDamageFix
    
    local function damageFix(ult, caster, hitTarget, hitType, skill, missile)
      cast_magic(caster, caster, ult.damageFix.id)
    end
    
    tool.insert(skActs.ult, "befDamage", damageFix)
  end
  destinies[5] = function(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function boom_red(misYellow, misInst, owner, posX, posZ)
      cast_missile(owner, nil, posX, posZ, misLogics.misBoom.id, nil, nil, nil, nil, nil, nil, nil, role.skills.balletStart:skInfo())
      
      cast_missile(owner, nil, posX, posZ, misLogics.BoomRedFx.id, nil, nil, nil, nil, nil, nil, nil, role.skills.balletStart:skInfo())
    end
    
    local function boom_yellow(misYellow, misInst, owner, posX, posZ)
      cast_missile(owner, nil, posX, posZ, misLogics.misBoom.id, nil, nil, nil, nil, nil, nil, nil, role.skills.balletStart:skInfo())
      cast_missile(owner, nil, posX, posZ, misLogics.BoomYellowFx.id, nil, nil, nil, nil, nil, nil, nil, role.skills.balletStart:skInfo())
    end
    
    tool.insert(misLogics.misYellow, "onEnd", boom_yellow)
    tool.insert(misLogics.misYellowEx, "onEnd", boom_yellow)
    tool.insert(misLogics.misRed, "onEnd", boom_red)
  end
  
  function spWeapon.fun(role, tool, skills, skActs, icons, btns, misLogics, magics)
    local function buffCast(mis, misInst, owner, posX, posZ)
      cast_magic(owner, owner, magics.spWeaponTagNum.id)
    end
    
    tool.insert(misLogics.waveYellowDamage, "onBegin", buffCast)
    tool.insert(misLogics.waveRedDamage, "onBegin", buffCast)
    
    local function damageFix(wave, misInst, caster, target, damage_sign, damage_type, target_camp, change_level, magic_level, magic_id)
      misLogics.waveYellowDamage.damageFix = magics.waveDamageFix[wave.unit.spWeapon.lv]
      misLogics.waveRedDamage.damageFix = magics.waveDamageFix[wave.unit.spWeapon.lv]
      cast_magic(caster, caster, wave.damageFix.id, get_magic_num(caster, magics.spWeaponTagNum.id))
    end
    
    tool.insert(misLogics.waveYellowDamage, "befDamage", damageFix)
    tool.insert(misLogics.waveRedDamage, "befDamage", damageFix)
  end
end

function Viola.on_frame(role)
  role.base.on_frame(role)
  role.note:tick()
end

function Viola.on_frame_background(role)
  role.base.on_frame_background(role)
  role.note:tick()
end

function Viola.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
  local magics = role.magics
  local misLogics = role.misLogics
  if npc == role.npc and not is_showup then
    cast_magic(role.npc, role.npc, magics.abortViolinMagic.id)
    remove_missile_by_id(misLogics.violinMis.id, role.npc)
  end
  role.base.on_hero_showup_or_back(role, npc, is_showup, by_ult_change)
end

function Viola.onRampageStart(role, stage)
  local skActs = role.skActs
  local skills = role.skills
  local tool = role.tool
  local martele = role.skills.martele
  local sk2 = role.btns.sk2
  if get_come_on_hero() == role.npc then
    local pos1 = get_npc_offset_position(role.npc, nil, 50, 4.5)
    local pos2 = get_npc_offset_position(role.npc, nil, -50, 4.5)
    local note = role.note
    note:castMisYellow(pos1.x, pos1.z, true)
    note:castMisRed(pos2.x, pos2.z)
  end
  sk2:setIcon(role.icons.exQte)
end

function Viola.onRampageEnd(role, stage)
  local skActs = role.skActs
  local martele = role.skills.martele
  local sk2 = role.btns.sk2
  sk2:setIcon(role.icons.martele)
  local magics = role.magics
  local misLogics = role.misLogics
  cast_magic(role.npc, role.npc, magics.abortViolinMagic.id)
  remove_missile_by_id(misLogics.violinMis.id, role.npc)
end

return Viola
