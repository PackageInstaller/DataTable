_class("UIHomelandMinimapManager", Object)
UIHomelandMinimapManager = UIHomelandMinimapManager

function UIHomelandMinimapManager:Constructor()
  HomelandMinimapConst.Init()
  self._addIcontCallback = GameHelper:GetInstance():CreateCallback(self.AddMinimapIcon, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.MinimapAddIcon, self._addIcontCallback)
  self._removeIcontCallback = GameHelper:GetInstance():CreateCallback(self.RemoveMinimapIcon, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.MinimapRemoveIcon, self._removeIcontCallback)
  self._iconDatas = {}
end

function UIHomelandMinimapManager:Destroy()
  self:RemoveListener()
  self._iconDatas = nil
end

function UIHomelandMinimapManager:RemoveListener()
  if self._addIcontCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.MinimapAddIcon, self._addIcontCallback)
    self._addIcontCallback = nil
  end
  if self._removeIcontCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.MinimapRemoveIcon, self._removeIcontCallback)
    self._removeIcontCallback = nil
  end
end

function UIHomelandMinimapManager:AddMinimapIcon(id, index, transform, param)
  local t = {}
  t.id = id
  t.index = index
  t.transform = transform
  t.param = param
  self._iconDatas[#self._iconDatas + 1] = t
end

function UIHomelandMinimapManager:RemoveMinimapIcon(id, index)
  for i = 1, #self._iconDatas do
    if self._iconDatas[i].id == id and self._iconDatas[i].index == index then
      table.remove(self._iconDatas, i)
      return
    end
  end
end

function UIHomelandMinimapManager:Update(deltaTimeMS)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapUpdate)
end

function UIHomelandMinimapManager:GetIconData()
  return self._iconDatas
end

function UIHomelandMinimapManager:SetIconMarkStatus(type, id, status)
  local key = self:GetSaveKey(type, id)
  if status then
    LocalDB.SetInt(key, 1)
  else
    LocalDB.SetInt(key, 0)
  end
end

function UIHomelandMinimapManager:GetIconMarkStatus(type, id)
  local key = self:GetSaveKey(type, id)
  if not LocalDB.HasKey(key) then
    return true
  end
  local value = LocalDB.GetInt(key, 0)
  return value == 1
end

function UIHomelandMinimapManager:GetSaveKey(type, id)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local roleId = loginModule:GetRoleShowID()
  return "MINIMAPICONMARKSTATUS" .. roleId .. type .. id
end
