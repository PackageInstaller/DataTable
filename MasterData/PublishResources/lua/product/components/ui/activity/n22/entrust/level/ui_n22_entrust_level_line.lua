_class("UIN22EntrustLevelLine", UICustomWidget)
UIN22EntrustLevelLine = UIN22EntrustLevelLine

function UIN22EntrustLevelLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UIN22EntrustLevelLine:OnHide()
end

function UIN22EntrustLevelLine:SetPos(from, to)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end

function UIN22EntrustLevelLine:PlayAnim(id, animName, delayTime, time, callback)
  local widgetName = "shape"
  local obj = self:GetGameObject(widgetName)
  local lockName = "UIN22EntrustLevelLine_PlayAnim()_" .. id
  self:Lock(lockName)
  self:StartTask(function(TT)
    if delayTime and delayTime ~= 0 then
      obj:SetActive(false)
      YIELD(TT, delayTime)
      obj:SetActive(true)
    end
    self:_DoSizeDlta(time)
    YIELD(TT, time)
    self:UnLock(lockName)
    if callback then
      callback()
    end
  end, self)
end

function UIN22EntrustLevelLine:_DoSizeDlta(time)
  local target = self._rect.sizeDelta
  self._rect.sizeDelta = Vector2(0, self._rect.sizeDelta.y)
  self._rect:DOSizeDelta(target, time / 1000)
end

function UIN22EntrustLevelLine:SetDebugText(txt)
  self:GetGameObject("_debug"):SetActive(UIActivityHelper.CheckDebugOpen())
  local obj = self:GetUIComponent("UILocalizationText", "_debug")
  obj:SetText(txt)
end
