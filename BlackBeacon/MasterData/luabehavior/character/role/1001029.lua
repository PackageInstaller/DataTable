local roleBase = import("character.base.role_base")
local SpFlorence = Util.create_child_mt(roleBase)
local chain_missile = 10010294106
local chain_misInst
local chain_dashMagic = 1029012
local chain_blockMagic = 10290122
local stele_npcId = 2010571
local stele_creatMagic = 1029008
local stele_lifeTime = 1029009
local stele_num = 0
local explosion_pos
local coreSkill_num = 0

function SpFlorence._init(role, npc)
  role.npc = npc
  local misIds = {skill2_focusMis = 10010293117}
  local magicIds = {}
  roleBase._init(role, misIds, magicIds)
  local skills = role.skills
  local skActs = role.skActs
  local icons = role.icons
  local btns = role.btns
  local misLogics = role.misLogics
  local magics = role.magics
  role.limit_trial = false
  role.toolNpcList = {}
  for i = 1, 3 do
    role.toolNpcList[i] = {}
    for j = 1, 2 do
      role.toolNpcList[i][j] = nil
    end
  end
  role.heavyPro_num = 0
  local spWeapon = role.spWeapon
  
  function skActs.chain.onBegin(chain)
    local atkBtn = role.btns.atk
    local justiceSword = role.icons.justiceSword
    atkBtn:setIcon(justiceSword)
    chain.base.onBegin(chain)
  end
  
  function skActs.justiceSword.onBegin(justiceSword)
    role.spBarStatus(true, 1)
    coreSkill_num = coreSkill_num + 1
    if 2 == coreSkill_num then
      local sk2Btn = role.btns.sk2
      local spreadCrime = role.icons.spreadCrime
      sk2Btn:setIcon(spreadCrime)
    end
    local atkBtn = role.btns.atk
    local atk = role.icons.atk
    atkBtn:setIcon(atk)
    justiceSword.base.onBegin(justiceSword)
  end
  
  function skActs.justiceSword.onBefTime(justiceSword)
    if nil ~= chain_misInst then
      remove_missile(chain_misInst)
    end
    abort_magic_by_id(npc, stele_lifeTime)
    justiceSword.base.onBefTime(justiceSword)
  end
  
  skActs.atk3.heavy = skActs.heavy
  
  function skActs.atk3.isReady(atk3)
    if not atk3.base.isReady(atk3) then
      return false
    end
    local role = atk3.role
    local roleAct = role.skAct
    local atk = role.icons.atk
    if roleAct == atk3.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif roleAct == atk3.heavy then
      return true
    else
      return false
    end
  end
  
  skActs.atk4.counter = skActs.counter
  
  function skActs.atk4.isReady(atk4)
    if not atk4.base.isReady(atk4) then
      return false
    end
    local role = atk4.role
    local roleAct = role.skAct
    local atk = role.icons.atk
    if roleAct == atk4.preAtk and get_npc_time(role.npc) < roleAct.reset.timer then
      return true
    elseif roleAct == atk4.counter then
      return true
    else
      return false
    end
  end
  
  function skActs.spreadCrime.onBegin(spreadCrime)
    role.spBarStatus(false, 2)
    coreSkill_num = 0
    local sk2Btn = role.btns.sk2
    local trialTime2 = role.icons.trialTime2
    sk2Btn:setIcon(trialTime2)
    spreadCrime.base.onBegin(spreadCrime)
  end
  
  do
    local function focusCamBegin(Focus, FocusInst, owner, posX, posZ)
      Focus.unit:change_follow_target_new(1, FocusInst, {
        9999,
        
        0,
        {
          x = 0,
          y = 0,
          z = 0
        },
        1,
        0,
        0.05,
        0,
        0
      })
    end
    
    local function focusCamEnd(Focus, FocusInst, owner, posX, posZ)
      local role = Focus.unit
      change_focus_follow_speed(2)
      role:change_follow_target(4)
      
      local function resetFollow(role)
        change_focus_follow_speed(4)
      end
      
      role:doAfter(resetFollow, 0.5)
    end
    
    misLogics.skill2_focusMis.onBegin = focusCamBegin
    misLogics.skill2_focusMis.onEnd = focusCamEnd
  end
  
  function SpFlorence.spBarStatus(Status, num)
    if false == Status then
      role.spBar:decrease(num)
      return
    end
    if true == Status then
      role.spBar:increase(num)
    end
  end
end

function SpFlorence.on_self_magic_begin(role, target, magic_id)
  if magic_id == stele_creatMagic then
    if role.target then
      role:stele_born(0.1, role.target, 1)
    else
      role:stele_born(0.1, role.npc, 1)
    end
  end
end

function SpFlorence.on_magic_end(role, npc, target, magic_id)
  role.base.on_magic_end(role, npc, target, magic_id)
  if magic_id == stele_lifeTime then
    role:stele_manager(1, target)
  end
end

function SpFlorence.on_npc_born(role, npc)
  role.base.on_npc_born(role, npc)
  if npc.id ~= stele_npcId then
    return
  end
  role:stele_manager(0, npc)
  print("召唤石碑！！！！！")
end

function SpFlorence.on_npc_removed(role, npc)
end

function SpFlorence.on_self_missile_begin_pos(role, pos_x, pos_z, missile_cfg, missile)
  print("missile.id = ", missile_cfg.Id)
  if missile_cfg.Id == chain_missile then
    chain_misInst = missile
    role:stele_manager(0, missile.v_target, missile)
  end
end

function SpFlorence.on_self_missile_end_pos(role, pos_x, pos_z, missile_cfg, missile, is_break)
  if missile_cfg.Id == chain_missile and missile.v_target ~= nil then
    chain_misInst = nil
    local atkBtn = role.btns.atk
    local atk = role.icons.atk
    atkBtn:setIcon(atk)
    role:stele_explosion(missile.v_target, 0, 1, get_npc_pos(missile.v_target))
  end
end

function SpFlorence.chain_dashTry(role)
  if check_magic(role.npc, chain_dashMagic) or check_magic(role.npc, chain_blockMagic) then
    role.skActs.chain:try()
    print("完美接链！！！你很强。")
    local atkBtn = role.btns.atk
    local justiceSword = role.icons.justiceSword
    atkBtn:setIcon(justiceSword)
  else
    role.skActs.chainStun:try()
    print("你被捆住了！！！菜就多练。stele_num = ", stele_num)
    local atkBtn = role.btns.atk
    local justiceSword = role.icons.justiceSword
    atkBtn:setIcon(justiceSword)
  end
end

function SpFlorence.stele_manager(role, change_kind, npc, missile)
  if 0 == change_kind then
    if nil ~= npc and nil == missile then
      for i = 1, #role.toolNpcList do
        if nil == role.toolNpcList[i][1] then
          role.toolNpcList[i][1] = npc
          role:chain_bind(npc, 1.5)
          stele_num = stele_num + 1
          break
        end
      end
    end
    if nil ~= missile and nil ~= npc then
      for i = 1, #role.toolNpcList do
        if role.toolNpcList[i][1] == npc and nil == role.toolNpcList[i][2] then
          role.toolNpcList[i][2] = missile
          break
        end
      end
    end
  end
  if 1 == change_kind then
    for i = 1, #role.toolNpcList do
      if role.toolNpcList[i][1] == npc then
        cast_magic(role.npc, npc, 10290091, 0)
        role:stele_explosion(npc, 0.15, 2, get_npc_pos(role.toolNpcList[i][1]))
        role.toolNpcList[i][1] = nil
        role.toolNpcList[i][2] = nil
        stele_num = stele_num - 1
        abort_magic_by_id(role.npc, 1029014)
        abort_magic_by_id(role.npc, 1029004)
        break
      end
    end
  end
  if 3 == change_kind then
    for i = 1, #role.toolNpcList do
      if nil ~= role.toolNpcList[i][1] then
        cast_magic(role.npc, role.toolNpcList[i][1], 1029007, 0)
        cast_magic(role.npc, npc, 10290091, 0)
        role.toolNpcList[i][1] = nil
        role.toolNpcList[i][2] = nil
        stele_num = 0
        abort_magic_by_id(role.npc, 1029014)
        abort_magic_by_id(role.npc, 1029004)
      end
    end
  end
end

function SpFlorence.stele_born(role, delay, target, kind)
  if stele_num >= 2 then
    return
  end
  delay = delay or 0.1
  target = target or role.npc
  kind = kind or 1
  if 1 == kind then
    local function born()
      local originPos = get_npc_pos(role.npc)
      
      local tarPos = get_npc_offset_position(role.npc, nil, 0, 1)
      local npc_pos1 = get_position_offset_position(originPos, tarPos, 0, 5)
      add_npc2(1, stele_npcId, tarPos.x, tarPos.z, originPos.x, originPos.z, 2, 1)
      if 0 == stele_num then
        cast_magic(role.npc, role.npc, 1029014, 0)
      end
    end
    
    role:doAfter(born, delay)
  elseif 2 == kind then
    local function born()
      local angel
      
      if 0 == stele_num then
        angel = 180
        print("stele_num =  0 ,angel = ", angel)
      elseif 1 == stele_num then
        angel = 120
        print("stele_num =  1 ,angel = ", angel)
      elseif 2 == stele_num then
        angel = -120
        print("stele_num =  2 ,angel = ", angel)
      end
      local originPos = get_npc_pos(role.npc)
      local tarPos = get_npc_offset_position(target, nil, angel, 1)
      local npc_pos1 = get_position_offset_position(originPos, tarPos, 0, 5)
      add_npc2(1, stele_npcId, tarPos.x, tarPos.z, originPos.x, originPos.z, 2, 1)
      if 0 == stele_num then
        cast_magic(role.npc, role.npc, 1029014, 0)
      end
    end
    
    role:doAfter(born, delay)
  end
end

function SpFlorence.stele_explosion(role, npc, delay, kind, born_pos)
  delay = delay or 0
  kind = kind or 1
  local npc_sreach
  for i = 1, #role.toolNpcList do
    if role.toolNpcList[i][1] ~= nil then
      npc_sreach = role.toolNpcList[i][1]
      break
    end
  end
  npc = npc or npc_sreach
  explosion_pos = born_pos or get_npc_pos(role.npc)
  if 1 == kind then
    local function chain_break()
      local lookat_pos = get_npc_pos(role.npc)
      
      cast_missile3(role.npc, nil, nil, nil, 10010294107, 0, lookat_pos.x, lookat_pos.z, nil, nil, explosion_pos.x, explosion_pos.z)
      if 0 == stele_num then
        cast_magic(role.npc, role.npc, 1029011, 0)
      end
    end
    
    role:doAfter(chain_break, delay)
  elseif 2 == kind then
    local function stele_break()
      cast_magic(role.npc, npc, 1029007, 0)
      
      local lookat_pos = get_npc_pos(role.npc)
      print("lookat_pos = ", lookat_pos.x, lookat_pos.z, "explosion_pos", explosion_pos.x, explosion_pos.z, "npc", npc.id)
      cast_missile3(role.npc, nil, nil, nil, 10010294111, 0, lookat_pos.x, lookat_pos.z, nil, nil, explosion_pos.x, explosion_pos.z)
    end
    
    role:doAfter(stele_break, delay)
  end
end

function SpFlorence.chain_bind(role, target, delay)
  local function chain_link(role)
    cast_missile3(role.npc, target, nil, nil, chain_missile, 0)
    
    cast_magic(role.npc, role.npc, 1029004, 0)
    role:chain_dashTry()
  end
  
  role:doAfter(chain_link, delay)
end

return SpFlorence
