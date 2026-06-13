local roleIndiMgr = {}
roleIndiMgr.__index = roleIndiMgr
roleIndiMgr.tool = import("common.role_tool")
roleIndiMgr.states = {
  hide = {name = "hide", isShow = false},
  show = {name = "show", isShow = true},
  preAim = {name = "preAim"},
  castAim = {name = "castAim"},
  cast = {name = "cast"}
}
roleIndiMgr.state = {}
roleIndiMgr.state[1] = roleIndiMgr.states.hide
roleIndiMgr.indis = {}
roleIndiMgr.indi = nil
roleIndiMgr.slomoMagic = Const.INDICATOR.SLOMO
roleIndiMgr.darkenFx = Const.INDICATOR.DARKEN

function roleIndiMgr.states.show.tick(mgr)
  local indi = mgr.indi
  local role = indi.role
  local tool = mgr.tool
  indi:targetUpdate()
end

function roleIndiMgr.tick(mgr)
  local indis = mgr.indis
  for _, indi in ipairs(indis) do
    indi:tick()
  end
  for _, state in ipairs(mgr.state) do
    if state.tick then
      state.tick(mgr)
    end
  end
end

function roleIndiMgr.addIndi(mgr, indi)
  local indis = mgr.indis
  if indis[indi] then
    Log.Error("multiple add indi, icon: " .. indi.icon.name .. "\n" .. debug.traceback())
    return
  end
  indis[indi] = indi
  table.insert(indis, 1, indi)
end

function roleIndiMgr.removeIndi(mgr, indi)
  local indis = mgr.indis
  if not indis[indi] then
    return
  end
  indis[indi] = nil
  local pos
  for i, _indi in ipairs(indis) do
    if _indi == indi then
      pos = i
      break
    end
  end
  table.remove(indis, pos)
end

function roleIndiMgr.isAllIndiHide(mgr)
  local indis = mgr.indis
  if 0 == #indis then
    return true
  end
  for _, indi in ipairs(indis) do
    if indi:isActive() then
      return false
    end
  end
  return true
end

function roleIndiMgr.pop(mgr)
  local indis = mgr.indis
  local activeIndi
  for _, indi in ipairs(indis) do
    if indi:isActive() then
      activeIndi = indi
      break
    end
  end
  if activeIndi then
    local oldIndi = mgr.indi
    local oldIndiState = oldIndi:getState()
    local newIndiState = activeIndi:getState()
    if oldIndi ~= activeIndi or oldIndiState ~= newIndiState then
      mgr[newIndiState](mgr, activeIndi)
    end
  else
    mgr:hide()
  end
end

function roleIndiMgr.isActive(mgr)
  return mgr.state[1].isShow
end

function roleIndiMgr.trySlomo(mgr)
  if not mgr:isActive() then
    return
  end
  local indi = mgr.indi
  if not indi then
    return
  end
  if not indi.slomo or indi.isSlowed then
    return
  end
  local role = indi.role
  if not role:isInBattle() then
    return
  end
  local roleAct = role.skAct
  if roleAct and not roleAct.isCastOver then
    return
  end
  cast_magic(role.npc, role.npc, mgr.slomoMagic)
  cast_magic(role.npc, role.npc, mgr.darkenFx)
end

function roleIndiMgr.quitSlomo(mgr)
  mgr.tool:abortMagicToTeam(mgr.slomoMagic, mgr.darkenFx)
end

function roleIndiMgr.indiAct(mgr, indi)
  local indis = mgr.indis
  if not indis[indi] then
    mgr:addIndi(indi)
  end
end

function roleIndiMgr.indiPreAim(mgr, indi, isInit)
  if isInit or mgr.indi == indi then
    mgr:preAim(indi)
  elseif mgr.state[1].name == "hide" and not isInit then
    local icon = indi.icon
    local btn = indi.btn
    Log.Error("indiMgr.indiPreAim: state disorder, icon: " .. icon.name .. ", btn: " .. btn.name .. "\n" .. debug.traceback())
  end
end

function roleIndiMgr.indiCastAim(mgr, indi, isInit)
  if isInit or mgr.indi == indi then
    mgr:castAim(indi)
  elseif mgr.state[1].name == "hide" and not isInit then
    local icon = indi.icon
    local btn = indi.btn
    Log.Error("indiMgr.indiCastAim: state disorder, icon: " .. icon.name .. ", btn: " .. btn.name .. "\n" .. debug.traceback())
  end
end

function roleIndiMgr.indiCast(mgr, indi, isInit)
  if isInit or mgr.indi == indi then
    mgr:cast(indi)
  elseif mgr.state[1].name == "hide" and not isInit then
    local icon = indi.icon
    local btn = indi.btn
    Log.Error("indiMgr.indiCast: state disorder, icon: " .. icon.name .. ", btn: " .. btn.name .. "\n" .. debug.traceback())
  end
end

function roleIndiMgr.indiHide(mgr, indi)
  if mgr.state[1].name == "hide" then
    return
  end
  if indi == mgr.indi then
    mgr:pop()
  end
end

function roleIndiMgr.indiIdle(mgr, indi)
  mgr:removeIndi(indi)
  if mgr.state[1].name == "show" and indi == mgr.indi then
    local tool = mgr.tool
    local setIconLocks = tool.setIconLocks
    if setIconLocks[indi.btn.name] then
      return
    else
      mgr:pop()
    end
  end
end

function roleIndiMgr.preAim(mgr, indi)
  local oldState = mgr.state[2]
  local oldIndi = mgr.indi
  mgr.state[1] = mgr.states.show
  mgr.state[2] = mgr.states.preAim
  mgr:quitSlomo()
  local id = indi.btn.id
  if not oldState then
    local role = indi.role
    local tarPos = indi:tarPosInit()
    update_skill_indicator(id, indi.coarse, indi.fine, indi.sensi)
    set_indicator_active(id, true, indi.autoLock, nil, nil, true)
    if not role.target then
      tarPos = tarPos or get_npc_offset_position(indi.role.npc, nil, 0, 4)
      set_indicator_pos(id, tarPos.x, tarPos.z)
    end
  elseif oldIndi and oldIndi.btn.id == indi.btn.id then
    local x, z = get_indicator_pos(id)
    set_indicator_active(id, false, nil, nil, nil, nil, true)
    update_skill_indicator(id, indi.coarse, indi.fine, indi.sensi)
    set_indicator_active(id, true, false, nil, nil, true, true)
    set_indicator_pos(id, x, z)
  else
    set_indicator_active(oldIndi.btn.id, false, nil, nil, nil, nil, true)
    oldIndi.btn.indi = nil
    local role = indi.role
    indi:tarPosInit()
    update_skill_indicator(id, indi.coarse, indi.fine, indi.sensi)
    set_indicator_active(id, true, false, nil, nil, true, true)
  end
  set_attach_target_enable(indi.viscous and not indi.btn:isDrag())
  mgr.indi = indi
  indi.btn.indi = indi
end

function roleIndiMgr.castAim(mgr, indi)
  local oldState = mgr.state[2]
  local oldIndi = mgr.indi
  mgr.state[1] = mgr.states.show
  mgr.state[2] = mgr.states.castAim
  local id = indi.btn.id
  mgr:quitSlomo()
  if not oldState then
    local role = indi.role
    local tarPos = indi:tarPosInit()
    update_skill_indicator(id, indi.coarse, indi.fine, indi.sensi)
    set_indicator_active(id, true, indi.autoLock, nil, nil, false)
    if not role.target then
      tarPos = tarPos or get_npc_offset_position(indi.role.npc, nil, 0, 4)
      set_indicator_pos(id, tarPos.x, tarPos.z)
    end
  elseif oldIndi and oldIndi.btn.id == indi.btn.id then
    local x, z = get_indicator_pos(indi.btn.id)
    set_indicator_active(id, false, nil, nil, nil, nil, true)
    update_skill_indicator(id, indi.coarse, indi.fine, indi.sensi)
    set_indicator_active(id, true, false, nil, nil, false, true)
    set_indicator_pos(id, x, z)
  else
    set_indicator_active(oldIndi.btn.id, false, nil, nil, nil, nil, true)
    oldIndi.btn.indi = nil
    local role = indi.role
    indi:tarPosInit()
    update_skill_indicator(id, indi.coarse, indi.fine, indi.sensi)
    set_indicator_active(id, true, false, nil, nil, false, true)
  end
  mgr.indi = indi
  indi.btn.indi = indi
  set_attach_target_enable(indi.viscous and not indi.btn:isDrag())
  mgr:trySlomo()
end

function roleIndiMgr.cast(mgr, indi)
  local oldState = mgr.state[2]
  local oldIndi = mgr.indi
  mgr.state[1] = mgr.states.show
  mgr.state[2] = mgr.states.cast
  local id = indi.btn.id
  mgr:quitSlomo()
  if not oldState then
    local role = indi.role
    local tarPos = indi:tarPosInit()
    update_skill_indicator(id, indi.coarse, indi.fine, indi.sensi)
    set_indicator_active(id, true, indi.autoLock, nil, nil, false)
    if not role.target then
      tarPos = tarPos or get_npc_offset_position(indi.role.npc, nil, 0, 4)
      set_indicator_pos(id, tarPos.x, tarPos.z)
    end
  elseif oldIndi and oldIndi.btn.id == indi.btn.id then
    local x, z = get_indicator_pos(indi.btn.id)
    set_indicator_active(id, false, nil, nil, nil, nil, true)
    update_skill_indicator(id, indi.coarse, indi.fine, indi.sensi)
    set_indicator_active(id, true, false, nil, nil, false, true)
    set_indicator_pos(id, x, z)
  else
    set_indicator_active(oldIndi.btn.id, false, nil, nil, nil, nil, true)
    oldIndi.btn.indi = nil
    update_skill_indicator(id, indi.coarse, indi.fine, indi.sensi)
    set_indicator_active(id, true, false, nil, nil, false, true)
    local pos = get_npc_offset_position(indi.role.npc, nil, 0, 4)
    set_indicator_pos(id, pos.x, pos.z)
  end
  set_attach_target_enable(indi.viscous and not indi.btn:isDrag())
  mgr.indi = indi
  indi.btn.indi = indi
end

function roleIndiMgr.hide(mgr)
  mgr.state[1] = mgr.states.hide
  mgr.state[2] = nil
  set_attach_target_enable(false)
  local indi = mgr.indi
  if indi then
    set_indicator_active(indi.btn.id, false)
    indi.btn.indi = nil
  end
  mgr:quitSlomo()
end

function roleIndiMgr.onBtnDrag(mgr, isDrag, btn)
  if not isDrag then
    return
  end
  if mgr:isActive() and mgr.indi.btn == btn then
    set_attach_target_enable(false)
  end
end

function roleIndiMgr.on_act_cast_time(mgr, act)
  mgr:tick()
  mgr:trySlomo()
end

function roleIndiMgr.isOn(mgr, indi)
  if indi and mgr.indi then
    return false
  end
  return mgr.state[1] == mgr.states.show
end

return roleIndiMgr
