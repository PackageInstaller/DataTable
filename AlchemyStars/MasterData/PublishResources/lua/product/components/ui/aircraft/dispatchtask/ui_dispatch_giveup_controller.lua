_class("UIDispatchGiveUpController", UIController)
UIDispatchGiveUpController = UIDispatchGiveUpController

function UIDispatchGiveUpController:OnShow(uiParams)
  self._dispatchDetailItem = uiParams[1]
end

function UIDispatchGiveUpController:LeftButtonOnClick(go)
  self:CloseDialog()
end

function UIDispatchGiveUpController:RightButtonOnClick(go)
  GameGlobal.TaskManager():StartTask(self._GiveUpTask, self)
end

function UIDispatchGiveUpController:_GiveUpTask(TT)
  self:Lock("UIDispatchGiveUpController_GiveUpTask")
  local siteInfo = self._dispatchDetailItem:GetSiteInfo()
  local teamMembers = siteInfo.teamMember
  local templateIds = {}
  local petModule = GameGlobal.GetModule(PetModule)
  if teamMembers then
    for i = 1, #teamMembers do
      local pet = petModule:GetPet(teamMembers[i])
      templateIds[#templateIds + 1] = pet:GetTemplateID()
    end
  end
  local aircraftModule = GameGlobal.GetModule(AircraftModule)
  local res, replay = aircraftModule:HandleCEventDispatchCancelTask(TT, self._dispatchDetailItem:GetSiteId())
  if res:GetSucc() then
    aircraftModule:HandleCEventDispatchSite(TT)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateDispatchTaskItemInfo)
    self:PushPets(templateIds)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateDispatchTaskSiteInfo)
    ToastManager.ShowToast(StringTable.Get("str_dispatch_room_give_up_task_success"))
    self:CloseDialog()
  else
    ToastManager.ShowToast(aircraftModule:GetErrorMsg(res:GetResult()))
  end
  self:UnLock("UIDispatchGiveUpController_GiveUpTask")
end

function UIDispatchGiveUpController:PushPets(templateIds)
  if not templateIds then
    return
  end
  for i = 1, #templateIds do
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftPushPetQueue, templateIds[i])
  end
end
