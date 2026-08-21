_class("BuffViewAddDamageShield", BuffViewBase)
BuffViewAddDamageShield = BuffViewAddDamageShield

function BuffViewAddDamageShield:PlayView(TT)
  local player = self._world:Player():GetCurrentTeamEntity()
  local curShield = self:GetBuffResult():GetShield()
  local hpCmpt = player:HP()
  if not hpCmpt then
    Log.error("add damge shield no hpCmpt!!")
    return
  end
  hpCmpt:SetShieldValue(curShield)
  player:TriggerHPUpdate()
  local hpBarID = hpCmpt:GetHPSliderEntityID()
  local hpBarEntity = self._world:GetEntityByID(hpBarID)
  local go = hpBarEntity:View().ViewWrapper.GameObject
  local uiview = go:GetComponent("UIView")
  local shieldImg = uiview:GetUIComponent("Image", "shield")
  if shieldImg ~= nil then
    shieldImg.gameObject:SetActive(true)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamHPChange, {
    isLocalTeam = self._world:Player():IsLocalTeamEntity(player),
    currentHP = hpCmpt:GetRedHP(),
    maxHP = hpCmpt:GetMaxHP(),
    hitpoint = hpCmpt:GetWhiteHP(),
    shield = hpCmpt:GetShieldValue(),
    entityID = player:GetID(),
    showCurseHp = hpCmpt:GetShowCurseHp(),
    curseHpVal = hpCmpt:GetCurseHpValue()
  })
end

_class("BuffViewRemoveDamageShield", BuffViewBase)
BuffViewRemoveDamageShield = BuffViewRemoveDamageShield

function BuffViewRemoveDamageShield:PlayView(TT)
  local player = self._world:Player():GetCurrentTeamEntity()
  local hpCmpt = player:HP()
  if not hpCmpt then
    Log.error("add damge shield no hpCmpt!!")
    return
  end
  hpCmpt:SetShieldValue(0)
  player:TriggerHPUpdate()
  local hpBarID = hpCmpt:GetHPSliderEntityID()
  local hpBarEntity = self._world:GetEntityByID(hpBarID)
  local go = hpBarEntity:View().ViewWrapper.GameObject
  local uiview = go:GetComponent("UIView")
  local shieldImg = uiview:GetUIComponent("Image", "shield")
  if shieldImg ~= nil then
    shieldImg.gameObject:SetActive(false)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamHPChange, {
    isLocalTeam = self._world:Player():IsLocalTeamEntity(player),
    currentHP = hpCmpt:GetRedHP(),
    maxHP = hpCmpt:GetMaxHP(),
    hitpoint = hpCmpt:GetWhiteHP(),
    shield = hpCmpt:GetShieldValue(),
    entityID = player:GetID(),
    showCurseHp = hpCmpt:GetShowCurseHp(),
    curseHpVal = hpCmpt:GetCurseHpValue()
  })
end
