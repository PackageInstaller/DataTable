_class("AircraftVisitingManager", Object)
AircraftVisitingManager = AircraftVisitingManager

function AircraftVisitingManager:Constructor(aircraftMain)
  self._main = aircraftMain
  self._aircraftModule = GameGlobal.GetModule(AircraftModule)
  self._petModule = GameGlobal.GetModule(PetModule)
  self._visitingPets = {}
end

function AircraftVisitingManager:Init()
  local visitpets = self._aircraftModule:GetVisitPets()
  for k, airVisitPet in pairs(visitpets) do
    self._visitingPets[airVisitPet.pet_info.pet_template_id] = airVisitPet
  end
  if table.count(self._visitingPets) > 0 then
    for petTemplateID, airVisitPet in pairs(self._visitingPets) do
      self:VisitingPetWander(airVisitPet)
    end
  end
end

function AircraftVisitingManager:Dispose()
end

function AircraftVisitingManager:AcceptAllPresent(pets, visitPets, callback)
  local requestCount = #pets + #visitPets
  local finishIdx = 0
  local allGiftList = {}
  if requestCount == 0 then
    callback(allGiftList)
    return
  end
  
  local function finishCheck()
    finishIdx = finishIdx + 1
    if finishIdx >= requestCount then
      callback(allGiftList)
    end
  end
  
  for _, pet in pairs(visitPets) do
    local id = pet:TemplateID()
    if not self._visitingPets[id] then
      Log.exception("找不到拜访星灵：", id)
    end
    if self._visitingPets[id].is_accpet_gift then
      Log.exception("拜访星灵已没有礼物，不能送礼：", id)
    end
    GameGlobal.TaskManager():StartTask(function(TT)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "AcceptVisitingPresent")
      local visitPetPstID = self._visitingPets[id].pet_info.pet_pst_id
      local res, assetList = self._aircraftModule:AcceptVisitingPresent(TT, visitPetPstID)
      if not res:GetSucc() then
        AirLog("收取礼物消息返回错误:", res:GetResult(), "，星灵:", tmpID)
        ToastManager.ShowToast(self._aircraftModule:GetErrorMsg(res:GetResult()))
      end
      self._visitingPets = {}
      local visitpets = self._aircraftModule:GetVisitPets()
      for k, airVisitPet in pairs(visitpets) do
        self._visitingPets[airVisitPet.pet_info.pet_template_id] = airVisitPet
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "AcceptVisitingPresent")
      if assetList and table.count(assetList) > 0 then
        for _, v in pairs(assetList) do
          table.insert(allGiftList, v)
        end
      end
      finishCheck()
    end)
  end
  for _, pet in pairs(pets) do
    GameGlobal.TaskManager():StartTask(function(TT)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "reqAcceptGift")
      local tmpID = pet:TemplateID()
      local res, assetList = self._aircraftModule:AcceptPresentByTemplateID(TT, tmpID)
      if not res:GetSucc() then
        AirLog("收取礼物失败，错误码:", res:GetResult())
        ToastManager.ShowToast(self._aircraftModule:GetErrorMsg(res:GetResult()))
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "reqAcceptGift")
      if assetList and table.count(assetList) > 0 then
        for _, v in pairs(assetList) do
          table.insert(allGiftList, v)
        end
      end
      finishCheck()
    end)
  end
end

function AircraftVisitingManager:AcceptVisitingPresent(pet)
  local id = pet:TemplateID()
  if not self._visitingPets[id] then
    Log.exception("找不到拜访星灵：", id)
  end
  if self._visitingPets[id].is_accpet_gift then
    Log.exception("拜访星灵已没有礼物，不能送礼：", id)
  end
  GameGlobal.TaskManager():StartTask(self.recieveVisitGift, self, pet)
end

function AircraftVisitingManager:recieveVisitGift(TT, pet)
  local tmpID = pet:TemplateID()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "AcceptVisitingPresent")
  local visitPetPstID = self._visitingPets[tmpID].pet_info.pet_pst_id
  local res, assetList = self._aircraftModule:AcceptVisitingPresent(TT, visitPetPstID)
  if not res:GetSucc() then
    AirLog("收取礼物消息返回错误:", res:GetResult(), "，星灵:", tmpID)
    ToastManager.ShowToast(self._aircraftModule:GetErrorMsg(res:GetResult()))
  end
  self._visitingPets = {}
  local visitpets = self._aircraftModule:GetVisitPets()
  for k, airVisitPet in pairs(visitpets) do
    self._visitingPets[airVisitPet.pet_info.pet_template_id] = airVisitPet
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "AcceptVisitingPresent")
  if assetList and table.count(assetList) > 0 then
    local delieverPresentAction = AirActionDelieverPresent:New(pet, assetList, self._main)
    pet:StartMainAction(delieverPresentAction)
    local _x, _z = self._main:GetMainCameraXZ()
    local _y = pet:WorldPosition().y
    local lookAtPoint = Vector3(_x, _y, _z)
    local rotateAction = AirActionRotate:New(pet, lookAtPoint)
    pet:StartViceAction(rotateAction)
  end
  pet:StopMatAnim()
end

function AircraftVisitingManager:BeVisitingPet(visitPetTemplateID)
  return self._visitingPets[visitPetTemplateID] ~= nil
end

function AircraftVisitingManager:HaveVisitingPresent(visitPetTemplateID)
  if self._visitingPets[visitPetTemplateID] then
    return self._visitingPets[visitPetTemplateID].is_accpet_gift == false
  end
  return false
end

function AircraftVisitingManager:VisitingPetWander(airVisitPet)
  local pet = self._main:AddVisitPet(airVisitPet)
  pet:SetVisitGift(airVisitPet.is_accpet_gift == false)
  AirLog("星灵触发送礼：", pet:TemplateID(), "，是否有礼物:", pet:HasVisitGift())
  if pet == nil then
    Log.exception("AddVisitPet fail!!!")
    return
  end
  self._main:RandomInitActionForPet(pet)
  if pet:HasVisitGift() then
    self:ShowPresentBag(pet)
  end
  self:ShowLight(pet)
  self:ShowName(pet)
end

function AircraftVisitingManager:ShowPresentBag(pet)
  local presentBubbleID = AircraftPetGiftBubble.Gift
  local faceAction = AirActionEffect:New(pet, presentBubbleID, AircraftPetSlotType.Head, Vector3(0.4, 0.8, 0), nil)
  pet:StartSpecialAction(AircraftSpecialActionType.PresentBag, faceAction)
  local obj = faceAction:GetGameObject()
  pet:SetPresentObject(obj)
end

function AircraftVisitingManager:ShowLight(pet)
  local lightBubbleID = AircraftPetGiftBubble.Light
  local faceAction = AirActionEffect:New(pet, lightBubbleID, AircraftPetSlotType.Root, Vector3(0, 0.01, 0), nil)
  pet:StartSpecialAction(AircraftSpecialActionType.Light, faceAction)
end

function AircraftVisitingManager:ShowName(pet)
  local nameBubbleID = AircraftPetGiftBubble.VisitName
  local faceAction = AirActionEffect:New(pet, nameBubbleID, AircraftPetSlotType.Head, Vector3(0, 0.5, 0), nil)
  pet:StartSpecialAction(AircraftSpecialActionType.Name, faceAction)
  local nameObj = faceAction:GetGameObject()
  if not nameObj then
    return
  end
  local view = nameObj:GetComponent("UIView")
  local petText = view:GetUIComponent("UILocalizationText", "PetText")
  local ownerText = view:GetUIComponent("UILocalizationText", "ownerText")
  petText:SetText(pet:PetName())
  local ownerNameText = self._visitingPets[pet:TemplateID()].owner_nick
  ownerText:SetText(ownerNameText)
  pet:SetOwnerName(ownerNameText)
end
