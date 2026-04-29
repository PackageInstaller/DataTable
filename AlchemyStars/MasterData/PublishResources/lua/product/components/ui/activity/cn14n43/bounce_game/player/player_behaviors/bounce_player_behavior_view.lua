_class("BouncePlayerBeHaviorView", BouncePlayerBeHaviorBase)
BouncePlayerBeHaviorView = BouncePlayerBeHaviorView

function BouncePlayerBeHaviorView:Constructor(playerPrefabName, parentRt, initPos)
  self._gameObject = nil
  self._curPosition = initPos
  self._resRequest = ResourceManager:GetInstance():SyncLoadAsset(playerPrefabName, LoadType.GameObject)
  if not self._resRequest or not self._resRequest.Obj then
    Log.fatal("加载怪物资源失败")
    return
  end
  self._gameObject = self._resRequest.Obj
  self._gameObject:SetActive(true)
  self._gameObjectRt = self._gameObject:GetComponent("RectTransform")
  self:SetParent(parentRt)
  self:SetPosition(initPos)
  self._boxRootRt = self._gameObject.transform:Find("box")
  self._boxRootPos = self._boxRootRt.anchoredPosition
  self._boxRect = {}
end

function BouncePlayerBeHaviorView:Name()
  return "BouncePlayerBeHaviorView"
end

function BouncePlayerBeHaviorView:GetGameObject()
  return self._gameObject
end

function BouncePlayerBeHaviorView:OnRelease()
  if self._resRequest then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
  self._gameObject = nil
end

function BouncePlayerBeHaviorView:GetBox(name)
  if self._gameObject == nil then
    return nil
  end
  local tran = self._gameObject.transform
  return tran:Find("box/" .. name)
end

function BouncePlayerBeHaviorView:GetRect(name)
  local rectData = self._boxRect[name]
  if not rectData then
    local boxRt = self:GetBox(name)
    if not boxRt then
      Log.error("BouncePlayerBeHaviorView no box/" .. name)
      return
    end
    rectData = {}
    local originRect = boxRt.rect
    local originPos = boxRt.anchoredPosition
    rectData[1] = originRect
    rectData[2] = originRect.x + originPos.x
    rectData[3] = originRect.y + originPos.y
    self._boxRect[name] = rectData
  end
  local pos = self._gameObjectRt.anchoredPosition
  local retRect = rectData[1]
  retRect.x = rectData[2] + self._boxRootPos.x + pos.x
  retRect.y = rectData[3] + self._boxRootPos.y + pos.y
  return retRect
end

function BouncePlayerBeHaviorView:SetParent(parent)
  if self._gameObject == nil then
    return
  end
  self._gameObject.transform:SetParent(parent)
  self._gameObject.transform.localScale = Vector3(1, 1, 1)
end

function BouncePlayerBeHaviorView:SetPosition(position)
  self._gameObjectRt.anchoredPosition = position
  self._curPosition = position
end

function BouncePlayerBeHaviorView:GetPosition()
  return self._curPosition
end

function BouncePlayerBeHaviorView:SetVisible(bVisible)
  if self._gameObject then
    self._gameObject:SetActive(bVisible)
  end
end
