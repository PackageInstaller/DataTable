require("monster_behavior_base")
_class("MonsterBeHaviorView", MonsterBeHaviorBase)
MonsterBeHaviorView = MonsterBeHaviorView

function MonsterBeHaviorView:Constructor()
  self._gameObject = nil
  self._resRequest = nil
  self._gameObjectRt = nil
  self.resCfg = nil
  self._change = false
end

function MonsterBeHaviorView:Name()
  return "MonsterBeHaviorView"
end

function MonsterBeHaviorView:GetGameObject()
  return self._gameObject
end

function MonsterBeHaviorView:OnInit(param)
  self.resId = param.ResId
  self._change = false
  self._boxRect = {}
  self:LoadRes(self.resId)
end

function MonsterBeHaviorView:GetAttackedLength()
  return self.resCfg.BeAttackedDuration
end

function MonsterBeHaviorView:ChgRes(newResId)
  self:OnRelease()
  self:LoadRes(newResId)
  self:SetParent(self._parent)
  local posBehavior = self:GetBehavior(MonsterBeHaviorPosition:Name())
  if posBehavior then
    posBehavior:ResetPosition()
  end
  self._change = true
  local anim = self:GetBehavior("MonsterBeHaviorAnimation")
  if anim then
    anim:Release()
  end
end

function MonsterBeHaviorView:OnShow()
  if self._gameObject then
    self._gameObject:SetActive(true)
  end
  if self._change then
    self:Release()
    self:OnReset()
    self._change = false
  end
end

function MonsterBeHaviorView:OnReset()
  if self._gameObject then
    self._gameObject:SetActive(false)
  end
end

function MonsterBeHaviorView:OnRelease()
  if self._resRequest then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
  self._gameObject = nil
end

function MonsterBeHaviorView:GetBox(name)
  if self._gameObject == nil then
    return nil
  end
  local tran = self._gameObject.transform
  return tran:Find("box/" .. name)
end

function MonsterBeHaviorView:GetRect()
  local rectData = self._boxRect.box
  if not rectData then
    local boxRt = self:GetBox("box")
    if not boxRt then
      Log.error("MonsterBeHaviorView no box/box " .. self.resId)
      return
    end
    rectData = {}
    local originRect = boxRt.rect
    local originPos = boxRt.anchoredPosition
    rectData[1] = originRect
    rectData[2] = originRect.x + originPos.x
    rectData[3] = originRect.y + originPos.y
    self._boxRect.box = rectData
  end
  local monserPos = self._gameObjectRt.anchoredPosition
  local retRect = rectData[1]
  retRect.x = rectData[2] + self._boxRootPos.x + monserPos.x
  retRect.y = rectData[3] + self._boxRootPos.y + monserPos.y
  return retRect
end

function MonsterBeHaviorView:GetBounceRect()
  if not self._gameObjectRt then
    return
  end
  if not self.boucneRect then
    self.boucneRect = BounceRect:New(self._gameObjectRt.anchoredPosition, self._gameObjectRt.sizeDelta)
  else
    self.boucneRect:ChgPosition(self._gameObjectRt.anchoredPosition)
  end
  return self.boucneRect
end

function MonsterBeHaviorView:SetPosition(pos)
  if not self._gameObjectRt then
    return
  end
  self._gameObjectRt.anchoredPosition = pos
end

function MonsterBeHaviorView:GetPosition()
  if not self._gameObjectRt then
    return
  end
  return self._gameObjectRt.anchoredPosition
end

function MonsterBeHaviorView:SetParent(parent)
  if self._gameObject == nil then
    return
  end
  self._parent = parent
  self._gameObject.transform:SetParent(parent)
  self._gameObject.transform.localScale = Vector3(1, 1, 1)
end

function MonsterBeHaviorView:LoadRes(resId)
  local cfg = Cfg.cfg_bounce_monster_res[resId]
  self.resCfg = cfg
  if cfg == nil then
    Log.fatal("[bounce]加载怪物资源配置失败:" .. resId)
    return
  end
  self._resRequest = ResourceManager:GetInstance():SyncLoadAsset(cfg.Name, LoadType.GameObject)
  if not self._resRequest or not self._resRequest.Obj then
    Log.fatal("[bounce]加载怪物资源失败" .. resId)
    return
  end
  self._gameObject = self._resRequest.Obj
  self._gameObjectRt = self._gameObject:GetComponent("RectTransform")
  self._gameObject:SetActive(true)
  self._boxRootRt = self._gameObject.transform:Find("box")
  self._boxRootPos = self._boxRootRt.anchoredPosition
  self._boxRect = {}
  if BounceDebug.ShowObjRect then
    self:InitDebugRect()
  end
end

function MonsterBeHaviorView:InitDebugRect()
  local rectRt = self:GetBox("box")
  if not rectRt then
    return
  end
  local image = rectRt.gameObject:AddComponent(typeof(UnityEngine.UI.Image))
  if image then
    image.color = Color(0, 1, 0, 0.4)
  end
end
