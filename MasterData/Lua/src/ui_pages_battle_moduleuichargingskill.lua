local this = class("moduleUIChargingSkill", G_UIModuleBase)
local C_EChargingSkillStatus = CS.Lens.Gameplay.Modules.BigWorld.EChargingSkillStatus
local _heroTpl = L_GameTpl:getHeroTpl()

function this.bind()
  return {
    fillAmount_bar1 = 0,
    fillAmount_bar2 = 0,
    go_eft_bar1 = false,
    go_eft_bar2 = false,
    go_content = false
  }
end

function this.methods()
  return {}
end

function this:open()
  L_BattleDataManager:addListener(L_BattleDataManager.event.refreshUIChargingSkill, self.onEvent_refreshUIChargingSkill, self)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.onCastSkill, self.onEvent_onCastSkill, self)
  self:refreshShowState()
end

function this:show(options)
end

function this:refreshShowState()
  local hero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if not hero then
    self.bind.go_content = false
    self.canShow = false
    return
  end
  self.heroCfgId = hero.data.configId
  local heroCfg = _heroTpl:getTplById(self.heroCfgId)
  self.maxChargingCount = _heroTpl:getUIChargingParam(heroCfg)
  if self.maxChargingCount <= 0 then
    self.bind.go_content = false
    self.bind.go_eft_bar1 = false
    self.bind.go_eft_bar2 = false
    self.canShow = false
    return
  end
  self.canShow = true
  self.bind.go_content = false
  self.bind.go_eft_bar1 = false
  self.bind.go_eft_bar2 = false
end

function this:onEvent_refreshUIChargingSkill(args)
  if not self.canShow then
    return
  end
  if args.entityType ~= C_EEntityType.Hero or args.configId ~= self.heroCfgId then
    return
  end
  self.skillId = args.skillId
  if args.status ~= C_EChargingSkillStatus.Update then
    if args.status == C_EChargingSkillStatus.Stop then
      self:resetChargingFill()
    end
    if args.status == C_EChargingSkillStatus.End and args.curIndex >= args.count then
      self:resetChargingFill(true)
    end
    return
  end
  if not self.bind.go_content then
    self.bind.go_content = true
  end
  for i = 1, self.maxChargingCount do
    if i < args.curIndex then
      self.bind["fillAmount_bar" .. tostring(i)] = 1
    elseif i == args.curIndex then
      self.bind["fillAmount_bar" .. tostring(i)] = args.chargeProcess
    else
      self.bind["fillAmount_bar" .. tostring(i)] = 0
    end
    if 1 <= args.chargeProcess and i == args.curIndex then
      self.bind["go_eft_bar" .. tostring(i)] = false
      self.bind["go_eft_bar" .. tostring(i)] = true
    end
  end
end

function this:onEvent_onCastSkill(args)
  if args.intArg ~= self.skillId then
    return
  end
  self:resetChargingFill()
end

function this:resetChargingFill(bFull)
  if bFull then
    for i = 1, self.maxChargingCount do
      self.bind["go_eft_bar" .. tostring(i)] = false
      self.bind["go_eft_bar" .. tostring(i)] = true
    end
    if self.timer then
      Timer.remove(self.timer)
      self.timer = nil
    end
    self.timer = Timer.once(0.5, function()
      self.bind.go_content = false
      self.bind.go_eft_bar1 = false
      self.bind.go_eft_bar2 = false
    end, self)
    return
  end
  self.bind.go_content = false
  self.bind.go_eft_bar1 = false
  self.bind.go_eft_bar2 = false
end

function this:setMainControl()
  self:refreshShowState()
end

function this:hide(options)
  self.bind.go_eft_bar1 = false
  self.bind.go_eft_bar2 = false
end

function this:close()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  L_BattleDataManager:removeListener(L_BattleDataManager.event.refreshUIChargingSkill, self.onEvent_refreshUIChargingSkill, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.onCastSkill, self.onEvent_onCastSkill, self)
end

return this
