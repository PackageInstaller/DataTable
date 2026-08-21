_class("UIN12EntrustStageLine", UICustomWidget)
UIN12EntrustStageLine = UIN12EntrustStageLine

function UIN12EntrustStageLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UIN12EntrustStageLine:OnHide()
end

function UIN12EntrustStageLine:SetPos(from, to)
  local dis = Vector2.Distance(from, to)
  self._rect.sizeDelta = Vector2(dis, self._rect.sizeDelta.y)
  self._rect.anchoredPosition = from
  local v = to - from
  self._rect.localRotation = Quaternion.FromToRotation(Vector3.right, Vector3(v.x, v.y, 0))
end

function UIN12EntrustStageLine:PlayAnim(id, widgetName, delayTime, time, callback)
  local obj = self:GetGameObject(widgetName)
  local lockName = "UIN12EntrustStageLine_PlayAnim()_" .. id
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

function UIN12EntrustStageLine:_DoSizeDlta(time)
  local targetWidth = self._rect.sizeDelta.x
  self._rect.sizeDelta = Vector2(0, self._rect.sizeDelta.y)
  self._rect:DOSizeDelta(Vector2(targetWidth, self._rect.sizeDelta.y), time / 1000)
end
