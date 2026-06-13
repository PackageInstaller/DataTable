local roleIcon = {}
roleIcon.__index = roleIcon
local indiBase = import("character.base.base_role_indicator")

function roleIcon.new(iconBase, role, _cfg)
  local result = setmetatable({}, iconBase)
  result.base = iconBase
  result.role = role
  result.tool = role.tool
  result.inputor = role.inputor
  result.btns = {}
  result.btn = nil
  result.icon = result
  local states = {
    idle = {name = "idle"},
    act = {name = "act"},
    unable = {name = "unable"},
    able = {name = "able"},
    up = {name = "up"},
    down = {name = "down"},
    masked = {name = "masked"},
    hitting = {name = "hitting"},
    holding = {name = "holding"}
  }
  
  function states.idle.validOutput()
  end
  
  function states.unable.validOutput(icon)
    return nil, icon.hitUp, icon.hold, icon.holdUp
  end
  
  function states.up.validOutput(icon)
    return icon.hit, icon.hitUp, icon.hold, icon.holdUp
  end
  
  function states.masked.validOutput(icon)
    local hitUp
    if icon.maskTimer < icon.holdTimer and Global.time < icon.holdTimer then
      hitUp = icon.hitUp
    end
    return nil, hitUp, icon.hold, icon.holdUp
  end
  
  function states.hitting.validOutput(icon)
    local hit
    local caches = icon.inputor.caches
    local i, num = icon.inputor:validTop()
    if not i then
      return hit, icon.hitUp, icon.hold, icon.holdUp
    end
    local now = Global.time
    while num > 0 do
      local event = caches.stack[i]
      if not event then
        Log.Error(role.npc:get_hero_name() .. ".icons." .. icon.name .. ".hitting.validOutput() is called, num is " .. num .. ", i is " .. i .. ", roleAct is " .. role.skAct.name .. [[
 input cache is:
 ]] .. role.inputor:tostring())
        break
      end
      if not hit and event.icon == icon and event.name == "hit" and now < event.timer then
        hit = icon.hit
        break
      end
      i = i - 1
      i = i < 1 and caches.max or i
      num = num - 1
    end
    return hit, icon.hitUp, icon.hold, icon.holdUp
  end
  
  function states.holding.validOutput(icon)
    local hit, hitUp, hold
    local caches = icon.inputor.caches
    local i, num = icon.inputor:validTop()
    if not i then
      return hit, hitUp, hold, icon.holdUp
    end
    local now = Global.time
    local event1 = caches.stack[i]
    if i and num >= 1 and event1 and event1.name == "hold" and event1.icon == icon and icon:getState() == "holding" then
      hold = icon.hold
    end
    while num > 0 do
      local event = caches.stack[i]
      if not event then
        local role = icon.role
        Log.Error(role.npc:get_hero_name() .. ".icons." .. icon.name .. ".holding.validOutput() is called, num is " .. num .. ", i is " .. i .. ", roleAct is " .. role.skAct.name .. [[
 input cache is:
 ]] .. role.inputor:tostring())
        break
      end
      if event.icon == icon and event.inputId == icon.inputId and now < event.timer then
        if not hit and event.name == "hit" and event.icon == icon then
          hit = event
        elseif not hitUp and event.name == "hitUp" and event.icon == icon then
          hitUp = event
        elseif not hold and event.name == "hold" and event.icon == icon then
          hold = event
        end
      end
      i = i - 1
      i = i < 1 and caches.max or i
      num = num - 1
    end
    return hit, hitUp, hold, icon.holdUp
  end
  
  function states.act.tick(icon)
    icon:updateEnable()
    icon:updateEnhance()
    icon:updateCharge()
  end
  
  function states.able.tick(icon)
    if not icon.isEnable then
      icon:unable()
    end
  end
  
  function states.unable.tick(icon)
    if icon.isEnable then
      icon:able()
    end
  end
  
  function states.masked.tick(icon)
    if Global.time > icon.maskTimer then
      icon:hitting()
    end
  end
  
  function states.hitting.tick(icon)
    if not icon.inputor:canHold() then
      return
    end
    local now = Global.time
    if now > icon.holdTimer then
      icon:holding()
    end
  end
  
  result.states = states
  result.state = {}
  result.state[1] = states.idle
  local cfg = _cfg or {}
  result.name = cfg.IconName
  result.holdTimer = 0
  result.holdTimeThreshold = cfg.HoldTimeThreshold or 0.2
  result.mastTimer = 0
  result.hitId = 0
  do
    local skActs = {
      HitSkActs = {},
      HitUpSkActs = {},
      HoldSkActs = {},
      HoldUpSkActs = {},
      CancelUpSkActs = {}
    }
    for outputName, acts in pairs(skActs) do
      if cfg[outputName] then
        local roleSkActs = role.skActs
        for i, skActName in ipairs(cfg[outputName]) do
          local skAct = roleSkActs[skActName]
          if not skAct then
            result.role:debugOutput(skActName .. " not found")
            goto lbl_153
          end
          acts[i] = skAct
          acts[skActName] = skAct
        end
        ::lbl_153::
      end
    end
    local chooseSkAct = iconBase.chooseSkAct
    local addUiAct = iconBase.addUiAct
    result.hit = {
      name = "hit",
      icon = result,
      cacheTime = cfg.HitCacheTime or 0.4,
      uiActs = {},
      addUiAct = addUiAct,
      chooseSkAct = chooseSkAct,
      skActs = skActs.HitSkActs
    }
    result.hitUp = {
      name = "hitUp",
      icon = result,
      cacheTime = cfg.HitUpCacheTime or 0.2,
      uiActs = {},
      addUiAct = addUiAct,
      chooseSkAct = chooseSkAct,
      skActs = skActs.HitUpSkActs
    }
    result.hold = {
      name = "hold",
      icon = result,
      cacheTime = cfg.HoldCacheTime or 0.4,
      uiActs = {},
      addUiAct = addUiAct,
      chooseSkAct = chooseSkAct,
      skActs = skActs.HoldSkActs
    }
    result.holdUp = {
      name = "holdUp",
      icon = result,
      cacheTime = cfg.HoldUpCacheTime or 0.2,
      uiActs = {},
      addUiAct = addUiAct,
      chooseSkAct = chooseSkAct,
      skActs = skActs.HoldUpSkActs
    }
    result.cancelUp = {
      name = "cancelUp",
      icon = result,
      cacheTime = 0,
      uiActs = {},
      addUiAct = addUiAct,
      chooseSkAct = chooseSkAct,
      skActs = skActs.CancelUpSkActs
    }
  end
  do
    local skill = role.skills[cfg.UiSkill]
    result.skill = skill
    result.cost = {
      battle = skill.cfg.BattleResCost,
      skill = skill.cfg.SkillResCost,
      ult = skill.cfg.UltResCost,
      cd = skill.cfg.CdChargePerCost
    }
    if cfg.IndicatorCoarseRes or cfg.IndicatorFineRes then
      result.indi = indiBase:new(role, result, cfg)
    end
    result.isEnable = cfg.UiEnable or true
    result.isEnhance = cfg.UiEnhance or false
    result.charge = {
      isOn = nil,
      type = cfg.UiChargeType,
      res = nil,
      attr = {
        curAttrId = cfg.UiChargeAttrCur,
        maxAttrId = cfg.UiChargeAttrMax
      },
      magic = {
        id = cfg.UiChargeMagic,
        isReduce = cfg.UiChargeIsReduce
      }
    }
    local charge = result.charge
    local isBlank = false
    if not charge.type then
      isBlank = true
    else
      charge.type = 1 == charge.type and "water" or "ring"
      if charge.attr.curAttrId and charge.attr.maxAttrId then
        charge.res = "attr"
      end
      if charge.magic.id then
        charge.res = "magic"
      end
      if not charge.res then
        isBlank = true
      end
    end
    if isBlank then
      charge.isOn = false
      
      function result.updateCharge()
      end
    end
    if result.charge.res == "attr" then
      result.updateCharge = iconBase.updateChargeByAttr
    elseif result.charge.res == "magic" then
      result.updateCharge = iconBase.updateChargeByMagic
    end
  end
  return result
end

function roleIcon.chooseSkAct(output)
  for i, skAct in ipairs(output.skActs) do
    if skAct:isReady() then
      return skAct
    end
  end
end

function roleIcon.addUiAct(output, fun)
  table.insert(output.uiActs, fun)
end

function roleIcon.insertFun(icon, funName, newFun)
  icon.tool.insert(icon, funName, newFun)
end

function roleIcon.removeFun(icon, funName, newFun)
  icon.tool.remove(icon, funName, newFun)
end

function roleIcon:updateEnable()
  local cost = self.cost
  local role = self.role
  local cur = role.attr
  local cd = get_npc_cd_charge(role.npc, self.skill.id)
  local battleCheck = cur[2] >= cost.battle
  local skillCheck = cur[74] >= cost.skill
  local ultCheck = cur[108] >= cost.ult
  local cdCheck = cd >= cost.cd
  self.isEnable = battleCheck and skillCheck and ultCheck and cdCheck
end

function roleIcon:updateEnhance()
end

function roleIcon:updateChargeByMagic()
  local charge = self.charge
  charge.isOn = check_magic(self.role.npc, charge.magic.id)
end

function roleIcon:updateChargeByAttr()
  local role = self.role
  local charge = self.charge
  local cur = role.attr[charge.attr.curAttrId]
  local max = role.attr[charge.attr.maxAttrId]
  if not cur then
    self.role:debugOutput("icon " .. self.name .. ".charge attr cur is nill")
  end
  if not max then
    self.role:debugOutput("icon " .. self.name .. ".charge attr max is nill")
  end
  charge.isOn = cur > 0.1 and cur < max - 0.1
end

function roleIcon.addBtn(icon, btn)
  local btns = icon.btns
  if btns[btn.name] then
  else
    table.insert(btns, btn)
    btns[btn.name] = btn
  end
end

function roleIcon.removeBtn(icon, btn)
  local btns = icon.btns
  if not btns[btn.name] then
  else
    btns[btn.name] = nil
    for i, _btn in ipairs(btns) do
      if _btn.name == btn.name then
        btns[i] = nil
        return
      end
    end
  end
end

function roleIcon.isIdle(icon)
  local state = icon.state[1]
  return state == icon.states.idle
end

function roleIcon.isDown(icon)
  for _, btn in pairs(icon.btns) do
    if btn.isDown then
      return btn
    end
  end
  return false
end

function roleIcon.getState(icon)
  local state = icon.state
  return state[#state].name
end

function roleIcon.validOutput(icon)
  local state = icon.state
  return state[#state].validOutput(icon)
end

function roleIcon.tick(icon)
  for _, state in ipairs(icon.state) do
    local tick = state.tick
    if tick then
      tick(icon)
    end
  end
end

function roleIcon.idle(icon)
  icon.state[1] = icon.states.idle
  icon.state[2] = nil
  icon.state[3] = nil
  icon.state[4] = nil
  local indi = icon.indi
  if indi then
    indi:idle(true)
  end
end

function roleIcon.act(icon, maskTime)
  icon.state[1] = icon.states.act
  icon.state[2] = nil
  icon.state[3] = nil
  icon.state[4] = nil
  icon:tick()
  if icon.state[1] == icon.states.act and not icon.state[2] and not icon.state[3] and not icon.state[4] then
    if icon.isEnable then
      icon:able(maskTime)
    else
      icon:unable()
    end
  end
end

function roleIcon.able(icon, maskTime)
  icon.state[1] = icon.states.act
  icon.state[2] = icon.states.able
  icon.state[3] = nil
  icon.state[4] = nil
  icon:tick()
  if icon.state[2] == icon.states.able and not icon.state[3] and not icon.state[4] then
    local downBtn = icon:isDown()
    if downBtn then
      icon.btn = downBtn
      icon:down(maskTime)
    else
      icon:up()
    end
  end
end

function roleIcon.unable(icon)
  icon.state[1] = icon.states.act
  icon.state[2] = icon.states.unable
  icon.state[3] = nil
  icon.state[4] = nil
  local indi = icon.indi
  if indi then
    indi:idle()
  end
  icon:tick()
end

function roleIcon.down(icon, maskTime)
  icon.state[1] = icon.states.act
  icon.state[2] = icon.states.able
  icon.state[3] = icon.states.down
  icon.state[4] = nil
  icon.holdTimer = Global.time + icon.holdTimeThreshold
  icon:tick()
  if icon.state[3] == icon.states.down and not icon.state[4] then
    if maskTime then
      icon:masked(maskTime)
    else
      icon:hitting()
    end
  end
end

function roleIcon.masked(icon, maskTime)
  icon.state[1] = icon.states.act
  icon.state[2] = icon.states.able
  icon.state[3] = icon.states.down
  icon.state[4] = icon.states.masked
  icon.maskTimer = Global.time + maskTime
  icon:tick()
end

function roleIcon.up(icon)
  icon.state[1] = icon.states.act
  icon.state[2] = icon.states.able
  icon.state[3] = icon.states.up
  icon.state[4] = nil
  local indi = icon.indi
  if indi then
    indi:idle()
  end
  icon:tick()
end

function roleIcon.hitting(icon)
  icon.hitId = icon.hitId + 1
  icon.state[1] = icon.states.act
  icon.state[2] = icon.states.able
  icon.state[3] = icon.states.down
  icon.state[4] = icon.states.hitting
  icon:tick()
  local indi = icon.indi
  if indi then
    indi:act()
  end
  if icon.output_hit_event then
    icon.output(icon.hit)
  end
end

function roleIcon.holding(icon)
  icon.state[1] = icon.states.act
  icon.state[2] = icon.states.able
  icon.state[3] = icon.states.down
  icon.state[4] = icon.states.holding
  icon.output(icon.hold)
  icon:tick()
end

function roleIcon.btnOn(icon, btn, maskTime)
  icon:addBtn(btn)
  if icon:isIdle() or 1 == #icon.btns then
    local role = icon.role
    if role:isInControl() then
      icon:act(maskTime)
    else
      icon:idle()
    end
  elseif btn.isDown and icon:getState() == "up" then
    icon:down()
  end
end

function roleIcon.btnOff(icon, btn)
  icon:removeBtn(btn)
  if 0 == #icon.btns then
    icon:idle()
  elseif icon.state[3] and icon.state[3].name == "down" and not icon:isDown() then
    icon:up()
  end
end

function roleIcon.btnCancelUp(icon, btn)
  icon.btn = btn
  if icon:isDown() then
    return
  end
  local state = icon.state[3]
  if state and state.name == "down" then
    icon.output(icon.cancelUp)
  end
  icon:up()
end

function roleIcon.btnDown(icon, btn)
  icon.btn = btn
  if icon.state[3] == icon.states.up then
    icon.output_hit_event = true
    icon:down()
    icon.output_hit_event = nil
  end
end

function roleIcon.btnUp(icon, btn)
  icon.btn = btn
  if icon:isDown() then
    return
  end
  local state = icon.state[4]
  if state == icon.states.hitting then
    icon.output(icon.hitUp)
  elseif state == icon.states.holding then
    icon.output(icon.holdUp)
  end
  icon:up()
end

function roleIcon.output(event)
  local icon = event.icon
  event.btn = icon.btn
  event.indiState = icon.indi and icon.indi:getState()
  event.inputId = icon.inputId
  event.timer = Global.time + event.cacheTime
  for _, uiAct in ipairs(event.uiActs) do
    uiAct(icon)
  end
  local inputor = icon.inputor
  local skAct
  if inputor:canOutput() then
    skAct = event:chooseSkAct()
    if skAct then
      skAct:start(event)
      inputor:clear()
    end
  end
  if not skAct and inputor:canCache() then
    inputor:cache(event)
  end
  return skAct
end

function roleIcon.pop(event)
  local skAct = event:chooseSkAct()
  local icon = event.icon
  icon:updateEnable()
  if icon.isEnable and skAct then
    skAct:start(event)
    return skAct
  else
    return nil
  end
end

function roleIcon:replaceBy(tarIcon)
  for _, btn in pairs(self.btns) do
    btn:setIcon(tarIcon)
  end
end

function roleIcon.isIndiOn(icon)
  return icon.indi:isOn()
end

function roleIcon.getIndiPos(icon)
  return icon.indi and icon.indi:getPos()
end

return roleIcon
