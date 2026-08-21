_class("UISeasonMazeOvalTip", Object)
UISeasonMazeOvalTip = UISeasonMazeOvalTip

function UISeasonMazeOvalTip:Constructor(seasonMazeID, req, onClick)
  self._seasonMazeID = seasonMazeID
  self._req = req
  self._onClick = onClick
  self._gameObject = req.Obj
  self._rectTransform = self._gameObject:GetComponent(typeof(UnityEngine.RectTransform))
  self._uiView = self._gameObject:GetComponent(typeof(UIView))
  self._uiView:SetShow(true, self)
  self._icon = self._uiView:GetGameObject("Icon")
  self._iconImg = self._uiView:GetUIComponent("Image", "Icon")
  self._arrowObj = self._uiView:GetGameObject("Arrow")
  self._arrowRect = self._uiView:GetUIComponent("RectTransform", "Arrow")
  self._arrowIcon = self._uiView:GetUIComponent("Image", "ArrowIcon")
  self._name2Asset = {}
end

function UISeasonMazeOvalTip:TargetWorldPos()
  if self._type == UISeasonOvalTipType.Player then
    local target = self._target
    return target:Position()
  end
end

function UISeasonMazeOvalTip:Show()
  self._isIn = false
  local show = true
  if self._target and self._type == UISeasonOvalTipType.Task then
    show = self._target:IsShow()
  end
  self._gameObject:SetActive(show)
end

function UISeasonMazeOvalTip:Hide()
  self._isIn = true
  self._gameObject:SetActive(false)
end

function UISeasonMazeOvalTip:Delete()
  self._req = nil
  self._gameObject = nil
  self._uiView:SetShow(false, self)
  self._uiView = nil
  for _, req in pairs(self._name2Asset) do
    req:Dispose()
  end
end

function UISeasonMazeOvalTip:Dispose()
  self._req:Dispose()
  self:Delete()
end

function UISeasonMazeOvalTip:IsInOval()
  return self._isIn
end

function UISeasonMazeOvalTip:Sync(pos, rot)
  self._rectTransform.anchoredPosition = pos
  self._arrowRect.localRotation = rot
end

function UISeasonMazeOvalTip:IconOnClick()
  self._onClick(self)
end

function UISeasonMazeOvalTip:ArrowIconOnClick()
  self._onClick(self)
end

function UISeasonMazeOvalTip:ResetTarget(target, type)
  self._uiView:SetShow(false, self)
  self._uiView:SetShow(true, self)
  self._type = type
  local cameraCfg = Cfg.cfg_season_maze_camera[self._seasonMazeID]
  if self._type == UISeasonOvalTipType.Player then
    self._target = target
    self._icon:SetActive(true)
    local min = cameraCfg.PlayerTipHideRange[1]
    local max = cameraCfg.PlayerTipHideRange[2]
    local maxSize = cameraCfg.CameraSizeMin
    local minSize = cameraCfg.CameraSizeMax
    self._tipHideParam = (max - min) / (maxSize - minSize)
    self._tipHideMinDistance = min
    self._cameraMinSize = minSize
  end
  self:_RefreshIcon()
  self:Hide()
end

function UISeasonMazeOvalTip:GetCanShowDistance(cameraSize)
  if self._tipHideMinDistance then
    return self._tipHideMinDistance + (cameraSize - self._cameraMinSize) * self._tipHideParam
  end
  return 0
end

function UISeasonMazeOvalTip:_RefreshIcon()
end
