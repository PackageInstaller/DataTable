local Vector3 = CS.UnityEngine.Vector3
local TentacleStatusUIItem, Super = System.NewComponent("TentacleStatusUIItem")

function TentacleStatusUIItem:ctor(firstNode, otherNode, role)
  Super.ctor(self)
  self.firstNode = firstNode
  self.otherNode = otherNode
  self.role = role
  self.tentacleMap = {}
  self.tentacleAnimators = {}
  self.tentacleDmgTxt = {}
  self.maxTentacleCount = 0
  self.tentacleCount = 0
  self.fixedTentacleCount = 0
  self.battleSlotLimit = 0
  self.tentacleAttackCount = 0
  self.tentaleDamage = 0
  self.tentacleDmgShow = 0
  self.tentacleChangeList = {}
  self.isForbidUpdate = false
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function TentacleStatusUIItem:OnBind(binder)
  self.binder = binder
  self.binder:BindEvent(EventMgr.Instance.OnAwakerExSkillAnimStart, function()
    self.isForbidUpdate = true
  end)
  self.binder:BindEvent(EventMgr.Instance.OnAwakerExSkillAnimEnd, function()
    self.isForbidUpdate = false
  end)
  self.binder:BindTimer(0.05, -1, function()
    self:UpdateTentacle()
  end)
end

function TentacleStatusUIItem:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function TentacleStatusUIItem:UpdateTentacle()
  if self.isForbidUpdate then
    return
  end
  local maxCount = self.role:GetTentacleMaxCount()
  local count = self.role:GetTentacleCount()
  local attackCount = self.role:GetTentacleAttackCount()
  local fixedCount = self.role:GetTentacleFixedCount()
  local battleSlotLimit = fixedCount
  if self.role.GetTentacleBattleSlotLimit then
    battleSlotLimit = self.role:GetTentacleBattleSlotLimit() or fixedCount
  end
  local damage = self.role:GetTentacleDmg()
  local tentacleDmgShow = self.role:GetTentacleDmgShow()
  if self.role.camp ~= bc.BattleCamp.Camp1 then
    damage = self.role:GetBossTentacleDmg()
  end
  if maxCount ~= self.maxTentacleCount or count ~= self.tentacleCount or fixedCount ~= self.fixedTentacleCount or battleSlotLimit ~= self.battleSlotLimit or damage ~= self.tentaleDamage or attackCount ~= self.tentacleAttackCount or tentacleDmgShow ~= self.tentacleDmgShow then
    if maxCount ~= self.maxTentacleCount then
      self:OnMaxCountChange(maxCount, self.maxTentacleCount)
      self.maxTentacleCount = maxCount
    end
    if count ~= self.tentacleCount then
      self:OnCountChange(count, self.tentacleCount)
      self.tentacleCount = count
    end
    if fixedCount ~= self.fixedTentacleCount or battleSlotLimit ~= self.battleSlotLimit then
      self.fixedTentacleCount = fixedCount
      self.battleSlotLimit = battleSlotLimit
      self:RefreshAllTentacleAttr()
    end
    if damage ~= self.tentaleDamage or tentacleDmgShow ~= self.tentacleDmgShow then
      self.tentaleDamage = damage
      self.tentacleDmgShow = tentacleDmgShow
      self:UpdateFirstTentacleDamage()
    end
    if attackCount ~= self.tentacleAttackCount then
      self.tentacleAttackCount = attackCount
      self:UpdateFirstTentacleDamage()
    end
  end
end

function TentacleStatusUIItem:UpdateFirstTentacleDamage()
  local firstTentacleItem = self.tentacleMap[1]
  if firstTentacleItem then
    firstTentacleItem:SetTentacleDamage(self.tentaleDamage, true, self.tentacleDmgShow)
  end
end

function TentacleStatusUIItem:RefreshAllTentacleAttr()
  self.fixedTentacleCount = self.role:GetTentacleFixedCount()
  if self.role.GetTentacleBattleSlotLimit then
    self.battleSlotLimit = self.role:GetTentacleBattleSlotLimit() or self.fixedTentacleCount
  else
    self.battleSlotLimit = self.fixedTentacleCount
  end
  for index, tentacleItem in pairs(self.tentacleMap) do
    tentacleItem.index = index
    if tentacleItem.isHaveTenacle then
      tentacleItem:ShowTentacleAttrBg()
    end
    tentacleItem:ShowDamageText(1 == index)
  end
  self:UpdateFirstTentacleDamage()
end

function TentacleStatusUIItem:OnMaxCountChange(maxCount, preMaxCount)
  local appearDelay = 0
  for index = 1, math.max(maxCount, preMaxCount) do
    local isNew = preMaxCount < index
    local isDelete = maxCount < index and preMaxCount >= index
    local tentacleItem = self.tentacleMap[index]
    if isNew and not tentacleItem then
      local isFirst = 1 == index
      local parentNode = isFirst and self.firstNode or self.otherNode
      local tentacleComponent = self.role.camp == bc.BattleCamp.Camp1 and TentacleItem or TentacleBossItem
      tentacleItem = self.binder:BindNewComponent(parentNode, tentacleComponent, UI_Battle_TentacleResource, self.role, index)
      if isFirst then
        local firstTranform = tentacleItem.ui.uiNode.transform
        firstTranform.localScale = Vector3.one
        firstTranform.localPosition = Vector3(0, 0, 0)
      end
      self.tentacleMap[index] = tentacleItem
      local skipEnterAnim = bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim()
      if skipEnterAnim then
        tentacleItem.ui.uiNode:SetActive(true)
        tentacleItem:SetTentacleDamage(self.tentaleDamage, isFirst, self.tentacleDmgShow)
        tentacleItem:OpenSlot(true)
        if index <= self.tentacleCount then
          tentacleItem:CreateTentacle(true)
        end
      elseif bg.isPVE and not bg.battleDataCenter:IsMyCamp(self.role.camp) then
        tentacleItem.ui.uiNode:SetActive(false)
        self.binder:BindTimer(appearDelay, 0, nil, function()
          tentacleItem.ui.uiNode:SetActive(true)
          tentacleItem:SetTentacleDamage(self.tentaleDamage, isFirst, self.tentacleDmgShow)
          tentacleItem:PlayAppearEffect()
          tentacleItem:OpenSlot()
          if index <= self.tentacleCount then
            tentacleItem:CreateTentacle()
          end
        end)
        appearDelay = appearDelay + 0.05
      else
        tentacleItem:SetTentacleDamage(self.tentaleDamage, isFirst, self.tentacleDmgShow)
        tentacleItem:OpenSlot()
        if index <= self.tentacleCount then
          tentacleItem:CreateTentacle()
        end
      end
      Logger.Info("创建触腕", index)
    end
    if isDelete and tentacleItem then
      self.tentacleMap[index] = nil
      Logger.Info("移除触腕", index)
      if tentacleItem then
        tentacleItem:CloseSlot(function()
          tentacleItem.binder:teardown()
        end)
      end
    end
  end
  if 0 ~= preMaxCount and preMaxCount < maxCount and bg.isPVE and self.role.camp ~= bc.BattleCamp.Camp1 then
    AudioManager.Instance:PostSoundEvent("Play_SFX_Monster_B0006_Tentacle_Limitup")
  end
  self:RefreshAllTentacleAttr()
end

function TentacleStatusUIItem:OnCountChange(curCount, preCount)
  local skipEnterAnim = bg.battleDataCenter and bg.battleDataCenter:ShouldSkipEnterUIAnim()
  for index, tentacleItem in pairs(self.tentacleMap) do
    local isNew = index <= curCount and preCount < index
    local isDelete = curCount < index and index <= preCount
    if isNew then
      tentacleItem:CreateTentacle(skipEnterAnim)
    end
    if isDelete then
      tentacleItem:ClearTentacle()
    end
  end
  self:RefreshAllTentacleAttr()
end

return TentacleStatusUIItem
