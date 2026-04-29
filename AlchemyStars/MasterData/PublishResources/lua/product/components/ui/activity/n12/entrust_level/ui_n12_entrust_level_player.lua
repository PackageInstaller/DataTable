_class("UIN12EntrustLevelPlayer", UICustomWidget)
UIN12EntrustLevelPlayer = UIN12EntrustLevelPlayer

function UIN12EntrustLevelPlayer:_PlayAnim(widgetName, animName, time, callback)
  local anim = self:GetUIComponent("Animation", widgetName)
  self:Lock(animName)
  anim:Play(animName)
  self:StartTask(function(TT)
    YIELD(TT, time)
    self:UnLock(animName)
    if callback then
      callback()
    end
  end, self)
end

function UIN12EntrustLevelPlayer:OnShow(uiParams)
end

function UIN12EntrustLevelPlayer:SetData(component, nodeId)
  local flag = self._nodeId ~= nodeId
  self._component = component
  self._nodeId = nodeId
  self:_SetPos(nodeId)
  self:_PlayAnim("root", "uieff_Level_Player", 400)
end

function UIN12EntrustLevelPlayer:_SetPos(nodeId)
  local pos = self._component:GetEventPointPos(nodeId)
  local rect = self:GetGameObject():GetComponent("RectTransform")
  rect.anchorMax = Vector2(0, 0.5)
  rect.anchorMin = Vector2(0, 0.5)
  rect.sizeDelta = Vector2.zero
  rect.anchoredPosition = pos
end
