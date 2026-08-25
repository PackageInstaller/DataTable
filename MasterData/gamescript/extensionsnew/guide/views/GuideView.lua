local math_max = math.max
local math_min = math.min
local Vector3 = CS.UnityEngine.Vector3
local GuideView, Super = NewClass("GuideView", BaseView)
GuideView.uiResCls = UI_Guide_TipsResource

function GuideView:ctor()
  Super.ctor(self)
  self._panelWidth = 0
  self._panelHeight = 0
  self._guideWidth = 0
  self._guideHeight = 0
  self._posTimerId = nil
  self._disappearTimerId = nil
  self._endAction = nil
end

function GuideView:OnBuildView()
end

function GuideView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnGuideDataChanged, self._RefreshAll, self)
end

function GuideView:RegisterEvents()
  self:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self._OnTouchBegin))
end

function GuideView:OnEnterView()
  Super.OnEnterView(self)
  GuideModel.Instance:SyncFromDataCenter()
  local rectTrans = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local rect = rectTrans.rect
  self._panelWidth = rect.width
  self._panelHeight = rect.height
  rectTrans = self.ui.UI_Guide_Tips:GetComponent(typeof(CS.UnityEngine.RectTransform))
  rect = rectTrans.rect
  self._guideWidth = rect.width
  self._guideHeight = rect.height
  self.ui.uiNode:SetActive(false)
  self._posTimerId = self:BindTimer(0.1, 0, nil, function()
    self.ui.uiNode:SetActive(true)
    self:LocalNotify(NotifyId.OnGuideDataChanged)
  end)
  self:_TryStartEndAction()
end

function GuideView:OnExitView()
  if self._posTimerId then
    self:StopTimer(self._posTimerId)
    self._posTimerId = nil
  end
  if self._disappearTimerId then
    self:StopTimer(self._disappearTimerId)
    self._disappearTimerId = nil
  end
  if self._endAction and GuideUtils["Action_" .. self._endAction] then
    GuideUtils["Action_" .. self._endAction]()
  end
  self._endAction = nil
  Super.OnExitView(self)
end

function GuideView:_OnTouchBegin()
  self.ui.UI_Guide_Frame:SetActive(false)
end

function GuideView:_TryStartEndAction()
  local cfg = GuideModel.Instance:GetGuideCfg()
  if not cfg then
    return
  end
  if cfg.StartAction and GuideUtils["Action_" .. cfg.StartAction] then
    GuideUtils["Action_" .. cfg.StartAction]()
  end
  self._endAction = cfg.EndAction
end

function GuideView:_RefreshAll()
  local model = GuideModel.Instance
  local cfg = model:GetGuideCfg()
  if not cfg then
    self:Close()
    return
  end
  self:SetText(self.ui.Text_Desc, model:GetGuideContent() or "")
  local headIcon = model:GetHeadIcon()
  if headIcon then
    self:SetImage(self.ui.Icon_Article, headIcon)
  end
  self:SetText(self.ui.Text_Name, model:GetGuideName() or "")
  local hasHead = model:HasAwakerHead()
  self.ui.Group_Name:SetActive(hasHead)
  self.ui.Group_Article:SetActive(hasHead)
  if not cfg.GuidePos then
    self:Close()
    return
  end
  local guidePos = self:GetGuidePos(cfg.GuideGameObj, cfg.GuidePos)
  self:SetGuideTipPos(guidePos)
  if cfg.IsFocus then
    self:SetFocusRect(self:GetGameObjRect(cfg.GuideGameObj))
  else
    self:SetFocusRect(nil)
  end
  if self._disappearTimerId then
    self:StopTimer(self._disappearTimerId)
    self._disappearTimerId = nil
  end
  if cfg.DisappearTime then
    self._disappearTimerId = self:BindTimer(cfg.DisappearTime, 0, nil, function()
      self:Close()
    end)
  end
end

function GuideView:SetGuideTipPos(guidePos)
  if not guidePos then
    return
  end
  local cfg = GuideModel.Instance:GetGuideCfg()
  local filterX, filterY = self:FilterPanelRange(guidePos[1], guidePos[2], self._guideWidth, self._guideHeight)
  local cfgShiftX, cfgShiftY = table.unpack(cfg.ShiftPos or {0, 0})
  self.ui.UI_Guide_Tips.transform.localPosition = Vector3(filterX + cfgShiftX, filterY - cfgShiftY, 0)
end

function GuideView:SetFocusRect(focusRect)
  self.ui.UI_Guide_Frame:SetActive(nil ~= focusRect)
  if not focusRect then
    return
  end
  local frameW, frameH = 100, 100
  self.ui.UI_Guide_Frame.transform.position = focusRect.centerPos
  self.ui.UI_Guide_Frame.transform.localScale = Vector3(focusRect.width / frameW, focusRect.height / frameH, 1)
end

function GuideView:GetGuidePos(guideGameObjName, guidePos)
  if not guidePos then
    return
  end
  if string.find(guidePos, ",", 0, true) then
    do return self.GetGuideScreenPos, self end
    return self.GetGuideScreenPos, self, guidePos, 0, true, nil, nil, nil
  end
  if guideGameObjName then
    local rect = self:GetGameObjRect(guideGameObjName)
    if not rect then
      return
    end
    local centerPos = rect.centerPos
    local localPos = self.ui.uiNode.transform:InverseTransformPoint(centerPos)
    local shiftX, shiftY = 0, 0
    if guidePos == CommonDefine.GuidePos.GO_UP then
      shiftY = rect.height * 0.5 + self._guideHeight * 0.5
    elseif guidePos == CommonDefine.GuidePos.GO_DOWN then
      shiftY = -rect.height * 0.5 - self._guideHeight * 0.5
    elseif guidePos == CommonDefine.GuidePos.GO_CENTER then
      shiftX, shiftY = 0, 0
    elseif guidePos == CommonDefine.GuidePos.GO_LEFT then
      shiftX = -rect.width * 0.5 - rect.height * 0.5
    elseif guidePos == CommonDefine.GuidePos.GO_RIGHT then
      shiftX = rect.width * 0.5 + rect.height * 0.5
    end
    return {
      localPos.x + shiftX,
      localPos.y + shiftY
    }
  end
end

function GuideView:GetGameObjRect(guideGameObjName)
  if not guideGameObjName then
    return
  end
  local rectFuncName = "GetRect_" .. guideGameObjName
  local getRectFunc = GuideUtils[rectFuncName]
  if getRectFunc then
    local rect = getRectFunc()
    if not rect then
      Logger.Warn("GuideUtils.lua没有定义[%s]函数,或者函数没有返回rect", rectFuncName)
      return
    end
    return rect
  end
  do return GuideUtils.GetRectCommon end
  return GuideUtils.GetRectCommon, guideGameObjName, "GuideUtils.lua没有定义[%s]函数,或者函数没有返回rect", rectFuncName
end

function GuideView:GetGuideScreenPos(guidePos)
  local anchorPos = string.split(guidePos, ",")
  anchorPos[1] = tonumber(anchorPos[1]) - 0.5
  anchorPos[2] = tonumber(anchorPos[2]) - 0.5
  return {
    anchorPos[1] * self._panelWidth,
    anchorPos[2] * self._panelHeight
  }
end

function GuideView:FilterPanelRange(x, y, width, height)
  local rectTrans = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local rect = rectTrans.rect
  local minX = rect.xMin + width * 0.5
  local maxX = rect.xMax - width * 0.5
  local minY = rect.yMin + height * 0.5
  local maxY = rect.yMax - height * 0.5
  return math_max(minX, math_min(maxX, x)), math_max(minY, math_min(maxY, y))
end

return GuideView
