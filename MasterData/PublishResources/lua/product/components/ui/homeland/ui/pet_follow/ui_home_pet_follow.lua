_class("UIHomePetFollow", UIController)
UIHomePetFollow = UIHomePetFollow

function UIHomePetFollow:OnShow(uiParams)
  local uiHomeModule = GameGlobal.GetUIModule(HomelandModule)
  self._homeClient = uiHomeModule:GetClient()
  self._followMgr = self._homeClient:HomePetFollowManager()
  self._usingType = self._followMgr:CurrentShape()
  self._currentType = self._usingType
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._shapes = self._followMgr:GetShapes()
  local count = #self._shapes
  self._pool:SpawnObjects("UIHomePetFollowItem", count)
  local pool = self._pool:GetAllSpawnList()
  for i = 1, count do
    local item = pool[i]
    local shape = self._shapes[i]
    local type = shape.Type
    item:SetData(i, shape, self._usingType, self._currentType, function(idx)
      self:ItemClick(idx)
    end)
  end
end

function UIHomePetFollow:ItemClick(idx)
  local shape = self._shapes[idx]
  self._currentType = shape.Type
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomePetFollowClick, self._currentType)
end

function UIHomePetFollow:SureBtnOnClick(go)
  if self._currentType == self._usingType then
  else
    self._followMgr:ChangeShape(self._currentType)
    self._usingType = self._currentType
    local pool = self._pool:GetAllSpawnList()
    self._shapes = self._followMgr:GetShapes()
    local count = #self._shapes
    for i = 1, count do
      local item = pool[i]
      local shape = self._shapes[i]
      local type = shape.Type
      item:SetData(i, shape, self._usingType, self._currentType, function(idx)
        self:ItemClick(idx)
      end)
    end
  end
  self:CloseDialog()
end

function UIHomePetFollow:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIHomePetFollow:OnHide()
end
