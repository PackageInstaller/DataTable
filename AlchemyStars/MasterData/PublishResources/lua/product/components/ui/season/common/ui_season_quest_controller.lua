_class("UISeasonQuestController", UIController)
UISeasonQuestController = UISeasonQuestController

function UISeasonQuestController:LoadDataOnEnter(TT, res, uiParams)
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  local reqRes = self._seasonModule:ForceRequestCurSeasonData(TT)
  if not reqRes:GetSucc() then
    self._seasonModule:CheckErrorCode(reqRes:GetResult(), -1)
    res:SetSucc(false)
    return
  end
  local component = self._seasonModule:GetCurSeasonQuestComponent()
  local isOpen = component and component:ComponentIsOpen()
  if not isOpen then
    res:SetSucc(false)
    return
  end
  self._seasonId = self._seasonModule:GetCurSeasonID()
end

function UISeasonQuestController:OnShow(uiParams)
  self:_SetCommonTopButton()
  local className, prefabName = UISeasonHelper.GetCurSeasonQuestContent()
  if not string.isnullorempty(className) then
    local function closeFunc()
      self:CloseDialog()
    end
    
    local obj = UIWidgetHelper.SpawnObject(self, "_pool", className, prefabName)
    obj:SetData({
      ownerName = self:GetName(),
      closeCallback = closeFunc
    })
    self._content = obj
  end
  self:AddListener()
end

function UISeasonQuestController:OnHide()
  self:DetachListener()
end

function UISeasonQuestController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    if self._content and self._content.CloseDialogWithAnim then
      self._content:CloseDialogWithAnim(function()
        self:CloseDialog()
      end)
    else
      self:CloseDialog()
    end
  end, nil, nil, false)
end

function UISeasonQuestController:AddListener()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
end

function UISeasonQuestController:DetachListener()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
end

function UISeasonQuestController:OnActivityCloseEvent(id)
  if self._seasonId and self._seasonId == id then
    self:CloseDialog()
  end
end
