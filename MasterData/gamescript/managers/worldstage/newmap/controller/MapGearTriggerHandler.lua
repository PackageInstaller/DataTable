local MapGearTriggerHandler = {}
local GearItemType = CommonDefine.GearItemType
local OptionBeforeChildTypes = {
  [GearItemType.Event] = true,
  [GearItemType.Camp] = true,
  [GearItemType.Beacon] = true,
  [GearItemType.HiddenChannel] = true,
  [GearItemType.HiddenAward] = true,
  [GearItemType.Machine] = true,
  [GearItemType.Obstacle] = true,
  [GearItemType.StageGroup_1_Talent] = true,
  [GearItemType.StageGroup_2_Talent] = true,
  [GearItemType.BloodPool] = true
}
local ChildBeforeOptionTypes = {
  [GearItemType.Treasure] = true,
  [GearItemType.BoxDrop] = true,
  [GearItemType.StoneDrop] = true,
  [GearItemType.Relic] = true
}

function MapGearTriggerHandler:Handle(controller, uid, svrData)
  if not controller or not uid then
    return
  end
  local data = svrData and svrData.data
  if not data then
    return
  end
  local gearType = controller.model:GetGearType(uid)
  if data.option and self:ShouldOpenOptionBeforeChild(gearType, data) then
    controller:OpenEventPanelByUid(uid, svrData)
    return true
  end
  if self:HandleByType(controller, uid, svrData, gearType) then
    return true
  end
  if data.option then
    controller:OpenEventPanelByUid(uid, svrData)
    return true
  end
end

function MapGearTriggerHandler:ShouldOpenOptionBeforeChild(gearType, data)
  if ChildBeforeOptionTypes[gearType] and data.items then
    return false
  end
  if ChildBeforeOptionTypes[gearType] and data.option and data.eventId then
    return true
  end
  return OptionBeforeChildTypes[gearType] or not ChildBeforeOptionTypes[gearType]
end

function MapGearTriggerHandler:HandleByType(controller, uid, svrData, gearType)
  if CommonDefine.GearBattleType[gearType] then
    do return self.HandleBattle, self, controller, uid end
    return self.HandleBattle, self, controller, uid, svrData, nil
  end
  if OptionBeforeChildTypes[gearType] then
    do return self.RunLegacyGearChild, self, controller, uid end
    return self.RunLegacyGearChild, self, controller, uid, svrData, nil
  end
  if gearType == GearItemType.Treasure or gearType == GearItemType.BoxDrop or gearType == GearItemType.StoneDrop or gearType == GearItemType.Relic then
    do return self.RunLegacyGearChild, self, controller, uid end
    return self.RunLegacyGearChild, self, controller, uid, svrData, nil
  end
  if gearType == GearItemType.Transport then
    do return self.HandleTransport, self, controller, uid, svrData end
    return self.HandleTransport, self, controller, uid, svrData, false
  end
  if gearType == GearItemType.SingleTransport then
    do return self.HandleTransport, self, controller, uid, svrData end
    return self.HandleTransport, self, controller, uid, svrData, true
  end
  if gearType == GearItemType.Shop or gearType == GearItemType.RelicShop or gearType == GearItemType.EnchantShop or gearType == GearItemType.CustomizeRelicShop or gearType == GearItemType.CustomizeEnchantShop or gearType == GearItemType.SpecialShop or gearType == GearItemType.MysteryShop or gearType == GearItemType.Story or gearType == GearItemType.ShadowEffect or gearType == GearItemType.Wall or gearType == GearItemType.PoisonGas or gearType == GearItemType.ChangeAvatarRes then
    do return self.RunLegacyGearChild, self, controller, uid end
    return self.RunLegacyGearChild, self, controller, uid, svrData, true
  end
end

function MapGearTriggerHandler:RunLegacyGearChild(controller, uid, svrData)
  do return controller.RunGearChildTrigger, controller, uid end
  return controller.RunGearChildTrigger, controller, uid, svrData
end

function MapGearTriggerHandler:HandleBattle(controller, uid, svrData)
  local data = svrData and svrData.data
  if not data then
    return
  end
  controller:StartGearTriggerByUid(uid)
  if data.prize then
    controller:NotifyGearHandleResult(uid, data)
    return true
  end
  if not data.checkStartBattleAgain and data.battleTid and 0 ~= data.battleTid then
    controller:EnterGearBattleByUid(uid, data)
    return true
  end
end

function MapGearTriggerHandler:HandleTransport(controller, uid, svrData, isSingleTransport)
  local data = svrData and svrData.data
  if not data then
    return
  end
  if isSingleTransport then
    local cfg = controller.model:GetGearConfigData(uid)
    if cfg and cfg.NodeType == DT.GetConstant("GridExport") then
      controller:AfterTriggerByUid(uid)
      return true
    end
  end
  if data.x and data.y then
    local moveMgr = controller:GetComponent(MapMoveManager)
    if moveMgr then
      moveMgr:TransToPos(data.x, data.y)
    end
    if isSingleTransport then
      AudioManager.Instance:PostSoundEvent("EXPLORE_SECRETAISLE_PLAYERSEND")
    else
      AudioManager.Instance:PostSoundEvent("EXPLORE_PASSAGE_PLAYERSEND")
    end
    controller:AfterTriggerByUid(uid)
  else
    controller:OpenEventPanelByUid(uid, svrData)
  end
  return true
end

return MapGearTriggerHandler
