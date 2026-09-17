local this = class("cellIconPetDuel", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _petCatchItemTpl = L_GameTpl:getPetCatchItemTpl()
local petTpl = L_GameTpl:getPetTpl()
local elementTypeTpl = L_GameTpl:getElementTypeTpl()
local trialPetTpl = L_GameTpl:getTrialPetTpl()
local templateValueTpl = L_GameTpl:getTemplateValueTpl()

function this.bind()
  return {
    img_bg = "",
    img_petIcon = "",
    img_petIconNew = "",
    active_petIconNew = false,
    img_elementBg = "",
    img_elementIcon = "",
    img_subElementBg = "",
    img_subElementIcon = "",
    active_subElementBg = false,
    costNum = "0",
    txt_petName = "",
    levelText = "",
    cdAmount = 0,
    keyText = "",
    keyActive = false,
    cdActive = true,
    selectActive = false,
    healingIconActive = false,
    tagList = {
      moduleName = "pages/petDuel/cellKiBoDuelTag"
    },
    fxBackActive = false,
    glowNormal = false,
    glowHeal = false,
    shiningActive = false,
    shiningFxActive = false,
    normalGlowActive = true,
    shingGlowActive = false,
    active_mobileMask = false,
    active_pcMask = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.index)
    end,
    onDragBegin = function(self, screenPos)
      self:emit("onDragBegin", self.bind.index, screenPos)
    end,
    onDrag = function(self, screenPos)
      self:emit("onDrag", self.bind.index, screenPos, self.fingerId)
    end,
    onDragEnd = function(self, screenPos)
      self:emit("onDragEnd", self.bind.index, screenPos)
    end,
    onDown = function(self)
      self:emit("onDown")
    end,
    onUp = function(self)
      self:emit("onUp")
    end
  }
end

function this:open()
  if C_KiboArenaSystemMgr.isInArena then
    return
  end
  self.pointerId = 0
  self.fingerId = 0
  self.dissolveBase = 0.26606
  self.dissolveMax = 0.73314
  self.refreshHealingIconHandler = self.refreshHealingIconHandler or handler(self, self.refreshHealingIcon)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.RefreshKiBoHealing, self.refreshHealingIconHandler)
  self:configTouch("+")
  self.cdMat = C_UnityObject.Instantiate(self.bindComponents.cdMask.material)
  self.bindComponents.cdMask.material = self.cdMat
  self.bind.active_mobileMask = C_AppConfigManager.IsMobilePlatformForUI
  self.bind.active_pcMask = C_AppConfigManager.IsPcPlatformForUI
end

function this:close()
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.RefreshKiBoHealing, self.refreshHealingIconHandler)
  self.refreshHealingIconHandler = nil
  self:configTouch("-")
  if self.cdMat then
    C_UnityObject.Destroy(self.cdMat)
    self.cdMat = nil
  end
  self:disposeRecoverTimer()
  self:disposeTween()
end

function this:disableEvents(isDisable)
  self.isDisableEvents = isDisable
end

function this:refresh()
  L_ProfilerUtil.BeginSample("cellIconPetDuel.Refresh")
  if not self.isBind then
    L_ProfilerUtil.EndSample()
    return
  end
  if self.bind.isNext then
    self.bind.active_mobileMask = true
    self.bind.active_pcMask = false
    self.bind.cdActive = true
    self.bind.cdAmount = 1
    self:setIconData(self.bind.petInfo)
    self:disableEvents(true)
    self.bind.fxBackActive = false
    self.cdMat:SetFloat("_Dissolve", 1)
    L_ProfilerUtil.EndSample()
    return
  end
  self.bind.cdActive = true
  self:disposeRecoverTimer()
  self:setIconData(self.bind.petInfo)
  self:refreshHealingIcon()
  L_ProfilerUtil.EndSample()
end

function this:setIconData(petInfo)
  if not self.isBind then
    return
  end
  self.bind.petInfo = petInfo or self.bind.petInfo
  if not self.bind.petInfo then
    return
  end
  if self.bind.petInfo.id == self.remId then
    return
  end
  self.remId = self.bind.petInfo.id
  if self.bind.petInfo.is_trial then
    self:refreshSystemPetInfo()
  else
    self:refreshPlayerPetInfo()
  end
end

function this:refreshSystemPetInfo()
  self:setShingGlow(false)
  local trialId = self.bind.petInfo.id
  local trialTpl = trialPetTpl:getTplById(trialId)
  if trialTpl == nil then
    error("trialPet表内找不到 id" .. tostring(trialId) .. " guid" .. tostring(self.bind.petInfo.guid))
    return
  end
  local petId = trialPetTpl:getTrialPet(trialTpl)
  local tpl = petTpl:getTplById(petId)
  if tpl == nil then
    error("pet表内找不到" .. tostring(petId) or "")
    return
  end
  self.bind.img_petIcon = petTpl:getKiboCardIcon(tpl)
  local petIconNew = petTpl:getKiboCardIconNew(tpl)
  if petIconNew and #petIconNew ~= 0 then
    self.bind.active_petIconNew = true
    self.bind.img_petIconNew = petIconNew
  else
    self.bind.active_petIconNew = false
  end
  self.bind.txt_petName = C_KiboDuelSystemMgr:GetPetNameByGuid(self.bind.petInfo.guid)
  self:refreshElementInfo(tpl)
  local level = L_PetDuelStore:getTrialPetLevel(trialPetTpl:getTrialPetLevel(trialTpl))
  self.bind.levelText = "Lv " .. tostring(level)
  if self.bind.index and not self.bind.isNext then
    self.bind.keyActive = true
  end
  self.bind.keyText = tostring(self.bind.index)
  self:refreshPetCost(petId)
  self:refreshTagList(petId)
end

function this:refreshElementInfo(petCfg)
  local elementIds = petTpl:getElement(petCfg)
  local eTpl = elementTypeTpl:getTplById(elementIds[1])
  self.bind.img_bg = elementTypeTpl:getKiBoCardElementBg(eTpl, 1)
  self.bind.img_elementBg = elementTypeTpl:getKiBoCardElementBg(eTpl, 2)
  self.bind.img_elementIcon = elementTypeTpl:getKiBoCardIcon(eTpl)
  self.bind.active_subElementBg = false
  if 1 < #elementIds then
    local sub_eTpl = elementTypeTpl:getTplById(elementIds[2])
    self.bind.active_subElementBg = true
    self.bind.img_subElementBg = elementTypeTpl:getKiBoCardElementBg(eTpl, 2)
    self.bind.img_subElementIcon = elementTypeTpl:getKiBoCardIcon(sub_eTpl)
    self.bind.active_subElementBg = true
  end
end

function this:refreshTagList(petId)
  if not self.isBind then
    return
  end
  local tpl = petTpl:getTplById(petId)
  local tags = petTpl:getKiboDuelTag(tpl)
  local data = {}
  for _, id in ipairs(tags) do
    table.insert(data, {tagId = id})
  end
  self.bind.tagList:freshAll(data)
end

function this:refreshPetCost(petId)
  local tempTpl = templateValueTpl:getTplById(petId)
  local cost = templateValueTpl:getPetBaseAttribute(tempTpl)[L_Const.kiBoDuelEnum.petCost]
  if cost ~= nil then
    self.bind.costNum = tostring(cost)
  end
end

function this:refreshPlayerPetInfo()
  local id = self.bind.petInfo.id
  local petData = L_PetStore:getPetItem(id)
  if petData then
    if id ~= self.lastPetGuidId then
      self:setShingGlow(petData:hasFlashGene())
    end
    self.lastPetGuidId = id
    local tpl = petTpl:getTplById(petData.id)
    self.bind.img_petIcon = petTpl:getKiboCardIcon(tpl, petData:isSpecialPet())
    local petIconNew = petTpl:getKiboCardIconNew(tpl, petData:isSpecialPet())
    if petIconNew and #petIconNew ~= 0 then
      self.bind.active_petIconNew = true
      self.bind.img_petIconNew = petIconNew
    else
      self.bind.active_petIconNew = false
    end
    self.bind.txt_petName = C_KiboDuelSystemMgr:GetPetNameByGuid(id)
    self:refreshElementInfo(tpl)
    self.bind.levelText = "Lv." .. tostring(petData.lv)
    if self.bind.index then
      self.bind.keyActive = true
    end
    self.bind.keyText = tostring(self.bind.index)
    self:refreshPetCost(petData.id)
    self:refreshTagList(petData.id)
  else
    self:setShingGlow(false)
  end
end

function this:setShingGlow(isShining)
  self.bind.shiningActive = isShining
  self.bind.shiningFxActive = isShining
  self.bind.shingGlowActive = isShining
end

function this:refreshSelect(isSelect, isUse)
  self.bind.selectActive = isSelect
  self.bind.keyActive = not isSelect
  if isSelect then
    self:playCellAnimation("anim_petduel_card_small2big")
  elseif self.lastIsSelect then
    if isUse then
      Timer.once(0.167, function()
        self:playCellAnimation("anim_petduel_card_draw")
      end, self, self.gameObject)
    else
      self:playCellAnimation("anim_petduel_card_big2small")
    end
  end
  self.lastIsSelect = isSelect
end

function this:refreshSelectNew(index)
  self.bind.selectActive = self.bind.index == index
  self.bind.keyActive = self.bind.index ~= index
  if self.isSelected then
    self:playCellAnimation("anim_petduel_card_big2small")
    self.bindComponents.cardAnimator:SetBool("Selected", false)
    self.isSelected = false
  elseif self.bind.index == index then
    self:playCellAnimation("anim_petduel_card_small2big")
    self.bindComponents.cardAnimator:SetBool("Selected", true)
    self.isSelected = true
  end
end

function this:refreshSelectByGuid(guid)
  self.bind.selectActive = self.bind.guid == guid
  self.bind.keyActive = self.bind.guid ~= guid
  if self.isSelected then
    self:playCellAnimation("anim_petduel_card_big2small")
    self.bindComponents.cardAnimator:SetBool("Selected", false)
    self.isSelected = false
  elseif self.bind.guid == guid then
    self:playCellAnimation("anim_petduel_card_small2big")
    self.bindComponents.cardAnimator:SetBool("Selected", true)
    self.isSelected = true
  end
end

function this:refreshCast(index)
  if self.bind.index == index then
    if self.isSelected then
      self.isSelected = false
      self:playCellAnimation("anim_petduel_card_cast")
    else
      Timer.once(0.167, function()
        self:playCellAnimation("anim_petduel_card_draw")
      end, self, self.gameObject)
    end
  end
end

function this:setPosX(x)
  self:disposeTween()
  self.tweenX = self.bindComponents.rect:DOLocalMoveX(x, 0.25):SetEase(Tweening.Ease.Linear):OnComplete(function()
    self:disposeTween()
  end):SetId("cellIconPetDuel.tweenX")
end

function this:disposeTween()
  if self.tweenX then
    self.tweenX:Kill()
    self.tweenX = nil
  end
end

function this:refreshHealingIcon(e, varList)
  if not self.isBind then
    return
  end
  if self.isDisableEvents then
    return
  end
  self.bind.healingIconActive = C_KiboDuelSystemMgr:CheckIsPetOnBattle(self.bind.guid)
  self.bind.glowHeal = self.bind.healingIconActive
  self.bind.glowNormal = not self.bind.healingIconActive
end

function this:refreshKiBoDuelCost(data)
  if not self.isBind then
    return
  end
  if self.isDisableEvents then
    return
  end
  if self.isCast then
    self:disposeRecoverTimer()
    self.bind.cdAmount = 0
    self.bind.fxBackActive = true
    self.bindComponents.cdMask.material:SetFloat("_Dissolve", 1)
    return
  end
  local cost = data.currentCost
  local costNum = tonumber(self.bind.costNum)
  if cost >= costNum then
    self:disposeRecoverTimer()
    self.bind.cdAmount = 0
    if not self.bind.fxBackActive and data.inRecover then
      L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Card_Ready")
    end
    self.bind.fxBackActive = true
    self.bindComponents.cdMask.material:SetFloat("_Dissolve", 1)
    return
  end
  self:disposeRecoverTimer()
  
  local function cbFunction()
    if self.isCast then
      return
    end
    if cost >= tonumber(self.bind.costNum) then
      self:disposeRecoverTimer()
      self.bind.cdAmount = 0
      self.bindComponents.cdMask.material:SetFloat("_Dissolve", 1)
    else
      local percent, _ = C_KiboDuelSystemMgr:GetCostData()
      self.bind.cdAmount = 1 - (cost / tonumber(self.bind.costNum) + 1 / tonumber(self.bind.costNum) * percent)
      self.bindComponents.cdMask.material:SetFloat("_Dissolve", self:getDissolveValue(1 - self.bind.cdAmount))
    end
    self.bind.fxBackActive = cost >= tonumber(self.bind.costNum)
  end
  
  if self.recoverTimer == nil then
    cbFunction()
    self.recoverTimer = Timer.repeated(0.1, cbFunction, self)
  end
end

function this:getDissolveValue(percent)
  local value = (self.dissolveMax - self.dissolveBase) * percent + self.dissolveBase
  return value
end

function this:disposeRecoverTimer()
  if self.recoverTimer ~= nil then
    Timer.remove(self.recoverTimer)
  end
  if self.onceTimer ~= nil then
    Timer.remove(self.onceTimer)
  end
  self.onceTimer = nil
  self.recoverTimer = nil
end

function this:playAnimator(isShow, isPlayAni, delayTime)
  Timer.once(delayTime, function()
    if not self.isBind or not self.bindComponents.cardAnimator then
      return
    end
    self.bindComponents.cardAnimator:SetBool("PlayAnim", isPlayAni)
    self.bindComponents.cardAnimator:SetBool("Show", isShow)
  end, self)
end

function this:setCastStatus(isCast)
  self.isCast = isCast
  self.bind.fxBackActive = isCast
end

function this:playNextAnimation(aniName, delayTime)
  if string.isEmpty(aniName) then
    return
  end
  if delayTime then
    self.onceTimer = Timer.once(delayTime, function()
      if not self.isBind or not self.bindComponents.nextAnimator then
        return
      end
      self.bindComponents.nextAnimator:Play(aniName)
    end, self)
  else
    if not self.isBind or not self.bindComponents.nextAnimator then
      return
    end
    self.bindComponents.nextAnimator:Play(aniName)
  end
end

function this:playCellAnimation(aniName)
  if string.isEmpty(aniName) then
    return
  end
  if not self.isBind or not self.bindComponents.cardAnimator then
    return
  end
  self.bindComponents.cardAnimator:Play(aniName)
end

function this:configTouch(operator)
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUI_dragStartHandle, self)
  C_ScreenTouch.OnUI_DragStart(operator, self.onUIDragStartHandle)
end

function this:onUI_dragStartHandle(gesture)
  if L_CommonUtil.isValid(self.gameObject) and not self.gameObject.activeInHierarchy then
    return
  end
  if self.bindComponents and self.bindComponents.rect_btnSelect and gesture.go == self.bindComponents.rect_btnSelect.gameObject then
    self.pointerId = gesture:GetPointerId()
    self.fingerId = gesture:GetFingerId()
    if self.pointerId < 0 then
      self.pointerId = 0
    end
    if self.fingerId < 0 then
      self.fingerId = 0
    end
  end
end

return this
