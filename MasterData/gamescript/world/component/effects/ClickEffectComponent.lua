local typeof = _ENV.typeof
local RectTransform = CS.UnityEngine.RectTransform
local ParticleSystem = CS.UnityEngine.ParticleSystem
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local RectTransformUtility = CS.UnityEngine.RectTransformUtility
local ClickEffectComponent, Super = System.NewClass("ClickEffectComponent", Component, IUpdater)

function ClickEffectComponent:ctor()
  Super.ctor(self)
  self.effects = {}
  self.effectPath = DT.GetConstant("ClickEffectPath")
  self.effectParentTf = CS.UnityEngine.GameObject.Find("TopRoot"):GetComponent(typeof(RectTransform))
  self.uiCamera = UIRootMgr.GetUICamera()
  local pos = CS.UnityEngine.Vector3(-2000, -2000)
  local effectObj = EffectManager.Instance:PlayEffect(self.effectPath, self.effectParentTf, pos)
  self.effectTf = effectObj:GetComponent(typeof(RectTransform))
  self.clickEffect = {
    obj = effectObj,
    objTransform = effectObj.transform,
    ps = effectObj:GetComponent(typeof(ParticleSystem))
  }
  self.intervalTime = 0.1
  self.clickTime = CS.Framework.TimeUtil.GetRealtimeSinceStartup()
  self.childScales = {}
  local childCount = effectObj.transform.childCount
  for i = 0, childCount - 1 do
    local transform = effectObj.transform:GetChild(i)
    self.childScales[transform] = transform.localScale
  end
end

function ClickEffectComponent:Awake(binder)
  Super.Awake(self)
  binder:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self.OnClicked))
  binder:BindEvent(EventMgr.Instance.CSSendEvent, System.fn(self, self.OnCSEvent))
  binder:BindEvent(EventMgr.Instance.ScreenCaptureEvent, System.fn(self, self.OnCaptureScreen))
end

function ClickEffectComponent:OnCaptureScreen(eventValue)
  if 1 == tonumber(eventValue) then
    self.clickEffect.obj:SetActive(false)
  else
    if CS.Framework.TimeUtil.GetRealtimeSinceStartup() - self.clickTime > 0.1 then
      return
    end
    self.clickEffect.obj:SetActive(true)
  end
end

function ClickEffectComponent:OnCSEvent(eventName, eventValue)
  if "OnStartGrabScreen" ~= eventName then
    return
  end
  if 1 == tonumber(eventValue) then
    self.clickEffect.obj:SetActive(false)
  else
    if CS.Framework.TimeUtil.GetRealtimeSinceStartup() - self.clickTime > 0.1 then
      return
    end
    self.clickEffect.obj:SetActive(true)
  end
end

local function ScreenToLocalPos(screenPos, parentTransform, transform, camera)
  local _, localPos = RectTransformUtility.ScreenPointToLocalPointInRectangle(parentTransform, screenPos, camera)
  local parentPivot = parentTransform.pivot
  local pivot = transform.pivot
  local sizeDelta = parentTransform.sizeDelta
  local deltaX = (parentPivot.x - pivot.x) * sizeDelta.x
  local deltaY = (parentPivot.y - pivot.y) * sizeDelta.y
  localPos.x = localPos.x + deltaX
  localPos.y = localPos.y + deltaY
  return localPos
end

function ClickEffectComponent:OnClicked(x, y)
  if CS.Framework.TimeUtil.GetRealtimeSinceStartup() - self.clickTime < self.intervalTime then
    return
  end
  local screenPos = Vector2(x, y)
  local uiPos = ScreenToLocalPos(screenPos, self.effectParentTf, self.effectTf, self.uiCamera)
  self:ShowEffect(Vector3(uiPos.x, uiPos.y, 0))
  self.clickTime = CS.Framework.TimeUtil.GetRealtimeSinceStartup()
end

function ClickEffectComponent:ShowEffect(pos)
  self.clickEffect.obj:SetActive(true)
  self.clickEffect.objTransform.localPosition = pos
  self.clickEffect.ps:Stop()
  self.clickEffect.ps:Play()
end

function ClickEffectComponent:OnDestroy()
  Super.OnDestroy(self)
  local obj = self.clickEffect.obj
  self.clickEffect.obj = nil
  EffectManager.Instance:DestroyEffect(obj)
  self.clickEffect = nil
end

function ClickEffectComponent:ScaleDown()
  for transform, scale in pairs(self.childScales) do
    transform.localScale = Vector3(0.06, 0.06, 0.06)
  end
end

function ClickEffectComponent:RestoreScale()
  for transform, scale in pairs(self.childScales) do
    transform.localScale = scale
  end
end

return ClickEffectComponent
