local module = class("cellTalentRuneItem", G_UIModuleBase)
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()

function module.bind()
  return {
    itemIcon = "",
    addMarkActive = true,
    runeName = "",
    itemColor = C_Color.white,
    contentAnchorPos = C_Vector2(0, 0),
    targetRingActive = false,
    redStatusActive = false,
    statusText = ""
  }
end

function module.methods()
  return {
    onClick_addMark = function(self)
      local options = self.runeData
      options.notShowAccess = self:GetSourceLuaPageOptions("failure_jump")
      L_UI:open("pageHeroTalentInfo", options)
    end,
    onClick_ItemIcon = function(self)
      local options = self.runeData
      options.notShowAccess = self:GetSourceLuaPageOptions("failure_jump")
      L_UI:open("pageHeroTalentInfo", options)
    end
  }
end

function module:open()
  self.onEvent_composeSuccessHandle = handler(self, self.onEvent_composeSuccess)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_composeSuccessHandle)
end

function module:close()
  self:removeTargetTimer()
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_composeSuccessHandle)
end

function module:onEvent_composeSuccess()
  self:refreshRedInfo()
end

function module:refresh()
  if not self.isBind or not self.bind.runeId then
    return
  end
  self.bind.contentAnchorPos = self.bind.runePosition
  self.runeData = {
    isEquiped = self.bind.isEquiped,
    runeId = self.bind.runeId,
    heroGuid = self.bind.heroGuid,
    slotId = self.bind.slotId,
    canEquip = not self.bind.isEquiped and self.bind.isPreview ~= true,
    currentRank = self.bind.curRank
  }
  self.bind.addMarkActive = not self.bind.isEquiped
  if self.bind.isEquiped then
    self.bind.itemColor = C_Color.white
  else
    self.bind.itemColor = C_Color(1, 1, 1, 0.3)
  end
  local runeTpl = talentRuneTpl:getTplById(self.bind.runeId)
  local itemId = talentRuneTpl:getRuneItem(runeTpl)
  local item = L_ItemTplManager:getCommonItem(itemId)
  self.itemId = itemId
  self.bind.runeName = item.name
  self.bind.itemIcon = item.icon
  self:setTargetRing()
  self:refreshRedInfo()
  if self.bind.isInit then
    if self.beginPlay then
      return
    end
    self:cellPlayFillAnim("Filled", self.bind.isEquiped, 0)
    self.bindComponents.cellTalentAnimator:Play("Init", 1)
    self.bind.isInit = false
    return
  end
  if not self.bind.isEquiped and not self.bind.isPreview then
    self:cellPlayFillAnim("Filled", false, 0)
  else
    self:cellPlayFillAnim("Filled", true, (self.bind.slotId + 1) * 0.1)
    self.bind.firstFilled = true
  end
end

function module:refreshRedInfo()
  if self.bind == nil then
    return
  end
  if not self.bind.isEquiped and not self.bind.isPreview then
    self.bind.redStatusActive = true
    local isHadMaterial = L_RuneStore:checkIsCanMaterialByRuneId(self.bind.runeId, true)
    if isHadMaterial then
      self.bind.statusText = L_WordsTpl:getValue("ui_talent_rune_compose_06")
    else
      self.bind.statusText = L_WordsTpl:getValue("ui_talent_detail_rune_state2")
    end
  else
    self.bind.redStatusActive = false
  end
end

function module:checkAllRuneCoinEnough(runeTpl)
  local coinTab = talentRuneTpl:getEquipRuneCoin(runeTpl)
  local runeCoinEnough = true
  for _, v in ipairs(coinTab) do
    if L_ItemTplManager:getItemNum(L_Const.resType.currency, v[1]) < v[2] then
      runeCoinEnough = false
    end
  end
  return runeCoinEnough
end

function module:setTargetRing()
  if not self.isBind then
    return
  end
end

function module:checkExtraCost(runeTpl)
  local extraCost = talentRuneTpl:getExtraCost(runeTpl)[1]
  local itemType = extraCost[1]
  local itemId = extraCost[2]
  local itemNum = extraCost[3]
  local has = L_ItemTplManager:getItemNum(itemType, itemId)
  return itemNum <= has
end

function module:removeTargetTimer()
  if self.targetTimer ~= nil then
    Timer.remove(self.targetTimer)
    self.targetTimer = nil
  end
end

function module:cellPlayAnim(needInit, animName, layer, delayTime)
  self.beginPlay = true
  if not self.isBind or not self.bindComponents.cellTalentAnimator then
    return
  end
  if needInit then
    self.bindComponents.cellTalentAnimator:Play("Init", 0)
  end
  Timer.once(delayTime, function()
    if not self.isBind or not self.bindComponents.cellTalentAnimator then
      return
    end
    self.bindComponents.cellTalentAnimator:Play(animName, layer)
  end, self)
end

function module:cellPlayFillAnim(animName, bool, delayTime)
  self.beginPlay = true
  Timer.once(delayTime, function()
    if not self.isBind or not self.bindComponents.cellTalentAnimator then
      return
    end
    self.bindComponents.cellTalentAnimator:SetBool(animName, bool)
  end, self)
end

function module:playInitAni()
  self:cellPlayFillAnim("Filled", self.bind.isEquiped, 0)
  self.bindComponents.cellTalentAnimator:Play("Init", 1)
  self.beginPlay = true
end

return module
