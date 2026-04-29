_class("AircraftPresentManager", Object)
AircraftPresentManager = AircraftPresentManager

function AircraftPresentManager:Constructor(aircraftMain)
  self._main = aircraftMain
  self._aircraftModule = GameGlobal.GetModule(AircraftModule)
  self._petModule = GameGlobal.GetModule(PetModule)
end

function AircraftPresentManager:Init()
  local presentPetsPstidList = self._aircraftModule:GetHavePresentPets()
  for k, petPstid in pairs(presentPetsPstidList) do
    local pet = self._petModule:GetPet(petPstid)
    if pet then
      local petID = pet:GetTemplateID()
      self:DelieverPetWander(petID)
    else
      Log.exception("背包中没有星灵，不能送礼！")
    end
  end
end

function AircraftPresentManager:Dispose()
end

function AircraftPresentManager:AcceptPresent(pet)
  GameGlobal.TaskManager():StartTask(self.reqAcceptGift, self, pet)
end

function AircraftPresentManager:reqAcceptGift(TT, pet)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "reqAcceptGift")
  local tmpID = pet:TemplateID()
  local res, assetList = self._aircraftModule:AcceptPresentByTemplateID(TT, tmpID)
  if not res:GetSucc() then
    AirLog("收取礼物失败，错误码:", res:GetResult())
    ToastManager.ShowToast(self._aircraftModule:GetErrorMsg(res:GetResult()))
    self:OnAcceptPresentEnd(tmpID)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "reqAcceptGift")
  local currentPet = self._main:GetPetByTmpID(tmpID)
  if assetList and table.count(assetList) > 0 then
    local delieverPresentAction = AirActionDelieverPresent:New(currentPet, assetList, self._main)
    currentPet:StartMainAction(delieverPresentAction)
    local _x, _z = self._main:GetMainCameraXZ()
    local _y = pet:WorldPosition().y
    local lookAtPoint = Vector3(_x, _y, _z)
    local rotateAction = AirActionRotate:New(pet, lookAtPoint)
    pet:StartViceAction(rotateAction)
  end
  self:OnAcceptPresentEnd(tmpID)
end

function AircraftPresentManager:OnAcceptPresentEnd(petTemplateID)
  local pet = self._main:GetPetByTmpID(petTemplateID)
  pet:StopMatAnim()
end

function AircraftPresentManager:DelieverPetWander(petTemplateID)
  if self._main:IsRandomStoryPet(petTemplateID) then
    AirLog("送礼星灵触发随机剧情，不触发送礼：", petTemplateID)
    return
  end
  AirLog("创建1个送礼星灵：", petTemplateID)
  local pet, sp = self._main:AddPet(petTemplateID)
  if pet then
    pet:SetGiftFlag(true)
    self._main:RandomInitActionForPet(pet)
    local presentBubbleID = AircraftPetGiftBubble.Gift
    local faceAction = AirActionEffect:New(pet, presentBubbleID, AircraftPetSlotType.Head, Vector3(0.4, 0.5, 0), nil)
    pet:StartSpecialAction(AircraftSpecialActionType.PresentBag, faceAction)
    local obj = faceAction:GetGameObject()
    pet:SetPresentObject(obj)
  elseif sp then
    Log.debug("###[AircraftPresentManager] 送礼星灵创建失败，有sp星灵存在,sp:", sp)
  else
    Log.debug("###[AircraftPresentManager] 送礼星灵创建失败")
  end
end
