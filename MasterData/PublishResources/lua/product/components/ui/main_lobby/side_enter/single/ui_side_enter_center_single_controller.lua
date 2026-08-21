_class("UISideEnterCenterSingleController", UIController)
UISideEnterCenterSingleController = UISideEnterCenterSingleController

function UISideEnterCenterSingleController:LoadDataOnEnter(TT, res, uiParams)
  local id = uiParams and uiParams[1] or 0
  Log.info("UISideEnterCenterSingleController:LoadDataOnEnter() id = ", id)
  local class, prefab = UISideEnterConst.GetCfg_SideEnterContent_Info(id, ESideEnterContentType.Single)
  if string.isnullorempty(class) or string.isnullorempty(prefab) then
    res:SetSucc(false)
    return
  end
  local obj = UIWidgetHelper.SpawnObject(self, "_pool", class, prefab)
  obj:OnInit(ESideEnterContentType.Single, function()
    self:CloseDialog()
  end)
  self._campaign = obj._campaign
end

function UISideEnterCenterSingleController:OnShow(uiParams)
  self:AddListener()
end

function UISideEnterCenterSingleController:OnHide()
  self:DetachListener()
end

function UISideEnterCenterSingleController:AddListener()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
end

function UISideEnterCenterSingleController:DetachListener()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
end

function UISideEnterCenterSingleController:OnActivityCloseEvent(id)
  if self._campaign and self._campaign._id == id then
    self:CloseDialog()
  end
end
