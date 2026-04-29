_class("UIN0CookMatRequireController", UIController)
UIN0CookMatRequireController = UIN0CookMatRequireController

function UIN0CookMatRequireController:LoadDataOnEnter(TT, res)
end

function UIN0CookMatRequireController:OnShow(uiParams)
  self._cookData = uiParams[1]
  self._backCall = uiParams[2]
  local com, comInfo = self._cookData:GetComponnet()
  self._component = com
  self._foodData = comInfo
  self._taskTb = {}
  self._widgets = {}
  self:InitWidget()
  self:GetInfo()
  self:RefreshTaskList()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
end

function UIN0CookMatRequireController:InitWidget()
  self._spineLoader = self:GetGameObject("spineLoader")
  self._content = self:GetUIComponent("UISelectObjectPath", "content")
  self._contentRect = self:GetUIComponent("RectTransform", "content")
  self._itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = self._itemInfo:SpawnObject("UISelectInfo")
  self._anim = self:GetUIComponent("Animation", "anim")
  local btns = self:GetUIComponent("UISelectObjectPath", "topBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self._CloseFunc, self)
  end, nil, nil)
end

function UIN0CookMatRequireController:_CloseFunc(TT)
  self:Lock("UIN0CookMatRequireController_Close")
  self._anim:Play("uieff_N0_CookMatRequireController_out")
  local time = self._anim:GetClip("uieff_N0_CookMatRequireController_out").length
  YIELD(TT, time * 1000)
  self:UnLock("UIN0CookMatRequireController_Close")
  self:CloseDialog()
  if self._backCall then
    self._backCall()
  end
end

function UIN0CookMatRequireController:GetInfo()
end

function UIN0CookMatRequireController:RefreshTaskList()
  local campaign = self._cookData:GetCampaign()
  self:_Sort()
  self._content:SpawnObjects("UIN0CookMatRequireItem", #self._taskTb)
  self._widgets = self._content:GetAllSpawnList()
  for i, v in pairs(self._widgets) do
    local task = self._taskTb[i]
    v:SetData(task, self._component, campaign, self._cookData:GetComponentId(), i, function()
      self:_ReceiveCallback()
    end, function(tplId, pos)
      self:OnItemClicked(tplId, pos)
    end)
  end
end

function UIN0CookMatRequireController:_ReceiveCallback()
end

function UIN0CookMatRequireController:_Sort()
  self._taskTb = {}
  local tb = self._foodData.task_list
  local unFinish = {}
  local received = {}
  for _, task in pairs(tb) do
    if task.status == NewYearDinner_Status.E_NewYearDinner_Status_UN_FINISH then
      table.insert(unFinish, task)
    elseif task.status == NewYearDinner_Status.E_NewYearDinner_Status_CAN_RECV then
      table.insert(self._taskTb, task)
    elseif task.status == NewYearDinner_Status.E_NewYearDinner_Status_RECVED then
      table.insert(received, task)
    end
  end
  for _, task in pairs(unFinish) do
    table.insert(self._taskTb, task)
  end
  for _, task in pairs(received) do
    table.insert(self._taskTb, task)
  end
end

function UIN0CookMatRequireController:OnItemClicked(matid, pos)
  self._selectInfo:SetData(matid, pos)
end

function UIN0CookMatRequireController:OnActivityCloseEvent(campaignId)
  local campaign = self._cookData:GetCampaign()
  if campaign and campaign._id == campaignId then
    self:CloseDialog()
  end
end
