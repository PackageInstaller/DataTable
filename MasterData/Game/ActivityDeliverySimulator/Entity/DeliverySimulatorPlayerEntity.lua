local DeliverySimulatorPlayerEntity = class("DeliverySimulatorPlayerEntity")
local ActLbEnum = require("Game.ActivityLobby.ActLbEnum")
local CS_RigidbodyConstraints = CS.UnityEngine.RigidbodyConstraints

function DeliverySimulatorPlayerEntity:ctor()
  self.targetAniSpeed = 0
  self.acceleration = 4
  self.addAcceleration = 0
  self.maxMoveSpeed = 4
  self.addMaxMoveSpeed = 0
  self.drag = 5
  self.addDrag = 0
  self.maxCapacity = 20
  self._currentRunCd = 0
  self.goodsList = {}
  self.__tempHandInGoodsDic = {}
  self.OverloadBuff = {}
end

function DeliverySimulatorPlayerEntity:InitDSPlayerEntityUI(mainWindow)
  self.knapsackUIItem = mainWindow.knapsackItem
  self.moveAudioTimer = TimerManager:StartTimer(1, function()
    AudioManager:PlayAudioById(8015)
  end, self, false, false, false)
  TimerManager:PauseTimer(self.moveAudioTimer)
end

function DeliverySimulatorPlayerEntity:RefreshAttributeByCfg(attributeCfg)
  self.acceleration = attributeCfg.acceleration
  self.maxMoveSpeed = attributeCfg.max_move_speed
  self.drag = attributeCfg.drag
  self.maxCapacity = attributeCfg.max_capacity
  self.capacityBuffPercentage = attributeCfg.capacity_percentage
  self.capacityBuffId = attributeCfg.capacity_buff
  self.runBuffId = attributeCfg.run_buff
  self.runCd = attributeCfg.run_cd
end

function DeliverySimulatorPlayerEntity:InitDeliverySimulatorPlayerEntity(dsCtrl, cmderHeadFxGo, cmderObject, playerRigidbodyTran, attributeId)
  self.dsCtrl = dsCtrl
  self.dsBuffCtrl = dsCtrl.dsBuffCtrl
  self.attributeCfg = ConfigData.delivery_attribute[attributeId]
  self:RefreshAttributeByCfg(self.attributeCfg)
  self:_InitHeadFx(cmderHeadFxGo, cmderObject)
  self.gameObject = cmderObject
  self.transform = cmderObject.transform
  self.animator = cmderObject:FindComponent(eUnityComponentID.Animator)
  self.animator:SetBool("DormMoveRun", true)
  self.playerRigidbodyTranPrent = playerRigidbodyTran.parent
  playerRigidbodyTran:SetParent(self.transform.parent, false)
  playerRigidbodyTran.transform:SetPositionAndRotation(self.transform.position, self.transform.rotation)
  self.transform:SetParent(playerRigidbodyTran, true)
  self.rigidbody = playerRigidbodyTran.gameObject:GetComponent(typeof(CS.UnityEngine.Rigidbody))
  self.rigidbody.constraints = CS_RigidbodyConstraints.FreezePositionY | CS_RigidbodyConstraints.FreezeRotation
  self:SetColliderShow(false)
  local listener = CS.ColliderEventListener.Get(playerRigidbodyTran.gameObject)
  listener:TriggerEnterEvent("+", BindCallback(self, self._OnTriggerEnter))
  listener:TriggerExitEvent("+", BindCallback(self, self._OnTriggerExit))
end

function DeliverySimulatorPlayerEntity:Reset()
  self:RefreshAttributeByCfg(self.attributeCfg)
  self:StopMove()
  self.goodsList = {}
  self.__tempHandInGoodsDic = {}
  self.OverloadBuff = {}
  self._currentRunCd = 0
  self.addAcceleration = 0
  self.addMaxMoveSpeed = 0
  self.addDrag = 0
end

function DeliverySimulatorPlayerEntity:SetColliderShow(bool)
  if self._collider == nil then
    self._collider = self.gameObject:GetComponent(typeof(CS.UnityEngine.Collider))
  end
  self._collider.enabled = bool
end

function DeliverySimulatorPlayerEntity:_InitHeadFx(cmderHeadFxGo, cmderObject)
  self._cmderHeadFxGo = cmderHeadFxGo
  local posConstraint = cmderHeadFxGo:GetComponent(typeof(CS.UnityEngine.Animations.PositionConstraint))
  if posConstraint ~= nil then
    local constraintSource = posConstraint:GetSource(0)
    local headPath = self.dsCtrl:GetMainRoleResPath() .. "/root/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 Head"
    local headTran = cmderObject.transform:Find(headPath)
    if IsNull(headTran) then
      warn("Commander head point is null : " .. tostring(headPath))
    end
    constraintSource.sourceTransform = headTran
    posConstraint:SetSource(0, constraintSource)
  end
end

function DeliverySimulatorPlayerEntity:TryPickUpGoods(goodsSpawnEntity)
  if goodsSpawnEntity == nil then
    return false
  end
  local capacity = self:GetRemainingLoadCapacity()
  local goodsWeight = goodsSpawnEntity:GetGoodsWeight()
  if capacity < goodsWeight then
    return false, 58008
  end
  local goods = goodsSpawnEntity:LostGoods()
  self:AddGoods(goods)
  return true
end

function DeliverySimulatorPlayerEntity:AddGoods(goods)
  table.insert(self.goodsList, goods)
  self.knapsackUIItem:AddKnapsackGoods(goods)
  self:CheckCapacity()
end

function DeliverySimulatorPlayerEntity:HandInGoods()
  table.clearmap(self.__tempHandInGoodsDic)
  for index, goods in ipairs(self.goodsList) do
    local good_id = goods.goods_spawn_id
    if self.__tempHandInGoodsDic[good_id] == nil then
      self.__tempHandInGoodsDic[good_id] = 1
    else
      self.__tempHandInGoodsDic[good_id] = self.__tempHandInGoodsDic[good_id] + 1
    end
  end
  table.clearmap(self.goodsList)
  self:CheckCapacity()
  self.knapsackUIItem:HideAllGoodsItem()
  return self.__tempHandInGoodsDic
end

function DeliverySimulatorPlayerEntity:GetOverloadLevel()
  local totalWeight = self:GetTotalGoodsWeight()
  local currentAffordabilityRate = totalWeight / self:GetMaxCapacity() * 100
  local capacityBuffTable = self.capacityBuffPercentage
  local overloadLevel = 0
  for index, affordabilityLimit in ipairs(capacityBuffTable) do
    if affordabilityLimit <= currentAffordabilityRate then
      overloadLevel = overloadLevel + 1
    end
  end
  return overloadLevel
end

function DeliverySimulatorPlayerEntity:RefreshOverLoadBuff(overloadLevel)
  for index = 1, #self.capacityBuffId do
    local buffId = self.capacityBuffId[index]
    if index <= overloadLevel then
      if self.OverloadBuff[buffId] == nil then
        local buff = self.dsCtrl.dsBuffCtrl:AddBuff(buffId, self)
        self.OverloadBuff[buffId] = buff
      end
    elseif self.OverloadBuff[buffId] ~= nil then
      self.dsCtrl.dsBuffCtrl:RemoveBuff(self.OverloadBuff[buffId])
      self.OverloadBuff[buffId] = nil
    end
  end
end

function DeliverySimulatorPlayerEntity:CheckCapacity()
  local overloadLevel = self:GetOverloadLevel()
  self:RefreshOverLoadBuff(overloadLevel)
  self.knapsackUIItem:UpdateDeliverySimulatorKnapsackCapacity(self:GetTotalGoodsWeight(), self:GetMaxCapacity(), overloadLevel)
end

function DeliverySimulatorPlayerEntity:TryRun()
  if self:IsInRunCD() then
    return
  end
  local runBuffId = self:GetRunBuffId()
  if self.dsBuffCtrl:GetBuff(runBuffId) == nil then
    self.dsBuffCtrl:AddBuff(runBuffId)
    self._currentRunCd = self.runCd
    AudioManager:PlayAudioById(8015)
  end
end

function DeliverySimulatorPlayerEntity:GetRunBuffId()
  return self.runBuffId
end

function DeliverySimulatorPlayerEntity:GetTotalGoodsWeight()
  local totalWeight = 0
  for index, goods in ipairs(self.goodsList) do
    totalWeight = totalWeight + goods.weight
  end
  return totalWeight
end

function DeliverySimulatorPlayerEntity:GetRemainingLoadCapacity()
  return self:GetMaxCapacity() - self:GetTotalGoodsWeight()
end

function DeliverySimulatorPlayerEntity:SetActLbCmdPos(posV3)
  self.transform.position = posV3
end

function DeliverySimulatorPlayerEntity:SetActLbCmdRotation(qua)
  if qua == nil then
    return
  end
  self.transform.rotation = qua
end

function DeliverySimulatorPlayerEntity:GetActLbCmdPos()
  return self.transform.position
end

function DeliverySimulatorPlayerEntity:GetActLbCmdRotation()
  return self.transform.rotation
end

function DeliverySimulatorPlayerEntity:GetAcceleration()
  return self.acceleration + self.addAcceleration
end

function DeliverySimulatorPlayerEntity:SetAddAcceleration(value)
  self.addAcceleration = self.addAcceleration + value
end

function DeliverySimulatorPlayerEntity:GetMaxMoveSpeed()
  return self.maxMoveSpeed + self.addMaxMoveSpeed
end

function DeliverySimulatorPlayerEntity:SetAddMaxMoveSpeed(value)
  self.addMaxMoveSpeed = self.addMaxMoveSpeed + value
end

function DeliverySimulatorPlayerEntity:GetDrag()
  return self.drag + self.addDrag
end

function DeliverySimulatorPlayerEntity:GetMaxCapacity()
  return self.maxCapacity
end

function DeliverySimulatorPlayerEntity:SetAddDrag(value)
  self.addDrag = self.addDrag + value
end

function DeliverySimulatorPlayerEntity:IsInRunCD()
  return self._currentRunCd > 0
end

function DeliverySimulatorPlayerEntity:GetRunCd()
  return self._currentRunCd
end

function DeliverySimulatorPlayerEntity:UpdateRunCd(deltaTime)
  if self._currentRunCd > 0 then
    self._currentRunCd = self._currentRunCd - deltaTime
  end
end

function DeliverySimulatorPlayerEntity:UpdateMove(moveData, fixedDeltaTime)
  if not self.dsCtrl:IsGameStart() then
    return
  end
  if moveData ~= nil then
    local dir = Quaternion.Euler(0, -moveData.angle + 90, 0)
    local acceleration = self:GetAcceleration()
    local move = dir:Forward().normalized * acceleration * fixedDeltaTime * moveData.power
    self.rigidbody.velocity = self.rigidbody.velocity + move
    self.rigidbody.velocity = move.normalized * self.rigidbody.velocity.magnitude
    local maxMoveSpeed = self:GetMaxMoveSpeed()
    if maxMoveSpeed < self.rigidbody.velocity.magnitude then
      self.rigidbody.velocity = self.rigidbody.velocity.normalized * maxMoveSpeed
    end
    self.rigidbody.transform.localRotation = dir
    TimerManager:ResumeTimer(self.moveAudioTimer)
  else
    local drag = self:GetDrag()
    if self.rigidbody.velocity.sqrMagnitude > (self.rigidbody.velocity.normalized * drag * fixedDeltaTime).sqrMagnitude then
      self.rigidbody.velocity = self.rigidbody.velocity - self.rigidbody.velocity.normalized * drag * fixedDeltaTime
    else
      self.rigidbody.velocity = Vector3.zero
    end
    TimerManager:PauseTimer(self.moveAudioTimer)
  end
  self.dsCtrl.actLbCamCtrl:SetActLbCamFollowTarget(self.rigidbody.transform)
  self:SetMoveTargetAniSpeed(self.rigidbody.velocity.magnitude)
end

function DeliverySimulatorPlayerEntity:SetMoveTargetAniSpeed(value)
  if value < 0.001 then
    self.targetAniSpeed = value
    return
  end
  if math.abs(self.targetAniSpeed - value) > 0.1 then
    self.targetAniSpeed = value
  end
end

function DeliverySimulatorPlayerEntity:UpdateMoveAnim()
  local currentAniSpeed = self.animator:GetFloat("DormWalkSpeed")
  local difference = self.targetAniSpeed - currentAniSpeed
  local absDifference = math.abs(self.targetAniSpeed - currentAniSpeed)
  local animSpeedChangeRate = 10 * Time.deltaTime
  if 0.001 < absDifference then
    local nextAniSpeed = Mathf.Lerp(currentAniSpeed, self.targetAniSpeed, animSpeedChangeRate)
    self.animator:SetFloat("DormWalkSpeed", nextAniSpeed)
  else
    self.animator:SetFloat("DormWalkSpeed", self.targetAniSpeed)
  end
end

function DeliverySimulatorPlayerEntity:SetAnimSpeed(speed)
  if 2.5 < speed then
    self.animator:SetFloat("DormWalkSpeed", 2.5)
    local animSpeed = speed > self.maxMoveSpeed and speed / self.maxMoveSpeed or 1
    self.animator:SetFloat("WalkAnimSpeed", animSpeed)
  else
    self.animator:SetFloat("DormWalkSpeed", speed)
    self.animator:SetFloat("WalkAnimSpeed", 1)
  end
end

function DeliverySimulatorPlayerEntity:StopMove()
  self:UpdateMove(nil, 0)
  self.rigidbody.velocity = Vector3.zero
  self:SetMoveTargetAniSpeed(0)
  self:SetAnimSpeed(0)
end

function DeliverySimulatorPlayerEntity:_OnTriggerEnter(collider)
  if ActLbEnum.InteractRangeName ~= collider.name then
    return
  end
  local interactEntity = self.dsCtrl.dsInteractCtrl:GetInteractEntityByCollider(collider)
  if interactEntity == nil then
    return
  end
  if not self.dsCtrl:IsGameStart() then
    return
  end
  interactEntity:OnPlayerTrigger(self, self.dsCtrl, true)
end

function DeliverySimulatorPlayerEntity:_OnTriggerExit(collider)
  if ActLbEnum.InteractRangeName ~= collider.name then
    return
  end
  local interactEntity = self.dsCtrl.dsInteractCtrl:GetInteractEntityByCollider(collider)
  if interactEntity == nil then
    return
  end
  if not self.dsCtrl:IsGameStart() then
    return
  end
  interactEntity:OnPlayerTrigger(self, self.dsCtrl, false)
end

function DeliverySimulatorPlayerEntity:Pause()
  self.animator.enabled = false
  self.rigidbody.isKinematic = true
end

function DeliverySimulatorPlayerEntity:Continue()
  self.animator.enabled = true
  self.rigidbody.isKinematic = false
end

function DeliverySimulatorPlayerEntity:OnDelete()
  self._collider = nil
  self.rigidbody.transform:SetParent(self.playerRigidbodyTranPrent, false)
  local listener = CS.ColliderEventListener.Get(self.rigidbody.gameObject)
  listener:TriggerEnterEvent("-", BindCallback(self, self._OnTriggerEnter))
  listener:TriggerExitEvent("-", BindCallback(self, self._OnTriggerExit))
  self.rigidbody = nil
  TimerManager:StopTimer(self.moveAudioTimer)
  self.moveAudioTimer = nil
  DestroyUnityObject(self.gameObject, true)
end

return DeliverySimulatorPlayerEntity
