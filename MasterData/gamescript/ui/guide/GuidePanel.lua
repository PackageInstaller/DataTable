local math_max = math.max
local math_min = math.min
local Vector3 = CS.UnityEngine.Vector3
local GuidePanel, Super = System.NewClass("GuidePanel", UIBasePanel)
GuidePanel.uiResCls = UI_Guide_TipsResource

function GuidePanel:ctor()
  Super.ctor(self)
end

function GuidePanel:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(GuideModel)
  self.model = model
  local rectTrans = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local rect = rectTrans.rect
  self.panelWidth = rect.width
  self.panelHeight = rect.height
  rectTrans = self.ui.UI_Guide_Tips:GetComponent(typeof(CS.UnityEngine.RectTransform))
  rect = rectTrans.rect
  self.guideWidth = rect.width
  self.guideHeight = rect.height
  binder:BindToText(self.ui.Text_Desc, function()
    do return model.GetGuideContent end
    return model.GetGuideContent, model
  end)
  binder:BindToImage(self.ui.Icon_Article, function()
    do return model.GetHeadIcon end
    return model.GetHeadIcon, model
  end)
  binder:BindToText(self.ui.Text_Name, function()
    do return model.GetGuideName end
    return model.GetGuideName, model
  end)
  binder:BindToVisible(self.ui.Group_Name, function()
    local cfg = model:GetGuideCfg()
    return cfg.AwakerHead ~= nil
  end)
  binder:BindToVisible(self.ui.Group_Article, function()
    local cfg = model:GetGuideCfg()
    return cfg.AwakerHead ~= nil
  end)
  self.ui.uiNode:SetActive(false)
  binder:BindTimer(0.1, 0, nil, function()
    self:BindGuidePos()
    self:BindFocusRect()
  end)
  binder:BindEvent(EventMgr.Instance.TouchBeginEvent, function()
    self.ui.UI_Guide_Frame:SetActive(false)
  end)
  binder:BindToRaw(function(_, curCfg)
    if not curCfg then
      return
    end
    if curCfg.StartAction and GuideUtils["Action_" .. curCfg.StartAction] then
      GuideUtils["Action_" .. curCfg.StartAction]()
    end
    if curCfg.EndAction then
      binder:onDestroy(function()
        if GuideUtils["Action_" .. curCfg.EndAction] then
          GuideUtils["Action_" .. curCfg.EndAction]()
        end
      end)
    end
  end, function()
    do return model.GetGuideCfg end
    return model.GetGuideCfg, model
  end)
  binder:BindToRaw(function(_, guidePos)
    if not guidePos then
      self:Close()
    end
  end, function()
    local cfg = model:GetGuideCfg()
    return cfg.GuidePos
  end)
  binder:BindToRaw(function(childBinder, DisappearTime)
    if DisappearTime then
      childBinder:BindTimer(DisappearTime, 0, nil, function()
        self:Close()
      end)
    end
  end, function()
    local cfg = model:GetGuideCfg()
    return cfg.DisappearTime
  end)
end

function GuidePanel:BindGuidePos()
  self.ui.uiNode:SetActive(true)
  self.binder:BindToRaw(function(_, guidePos)
    self:SetGuideTipPos(guidePos)
  end, function()
    local cfg = self.model:GetGuideCfg()
    do return self.GetGuidePos, self, cfg.GuideGameObj end
    return self.GetGuidePos, self, cfg.GuideGameObj, cfg.GuidePos
  end)
end

function GuidePanel:BindFocusRect()
  self.binder:BindToRaw(function(_, focusRect, _)
    self:SetFocusRect(focusRect)
  end, function()
    local cfg = self.model:GetGuideCfg()
    if cfg.IsFocus then
      do return self.GetGameObjRect, self end
      return self.GetGameObjRect, self, cfg.GuideGameObj
    end
  end)
end

function GuidePanel:SetGuideTipPos(guidePos)
  if not guidePos then
    return
  end
  local cfg = self.model:GetGuideCfg()
  local filterX, filterY = self:FilterPanelRange(guidePos[1], guidePos[2], self.guideWidth, self.guideHeight)
  local cfgShiftX, cfgShiftY = table.unpack(cfg.ShiftPos or {0, 0})
  self.ui.UI_Guide_Tips.transform.localPosition = Vector3(filterX + cfgShiftX, filterY - cfgShiftY, 0)
end

function GuidePanel:SetFocusRect(focusRect)
  self.ui.UI_Guide_Frame:SetActive(nil ~= focusRect)
  if not focusRect then
    return
  end
  local frameW, frameH = 100, 100
  self.ui.UI_Guide_Frame.transform.position = focusRect.centerPos
  self.ui.UI_Guide_Frame.transform.localScale = Vector3(focusRect.width / frameW, focusRect.height / frameH, 1)
end

function GuidePanel:GetGuidePos(guideGameObjName, guidePos)
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
      shiftY = rect.height * 0.5 + self.guideHeight * 0.5
    elseif guidePos == CommonDefine.GuidePos.GO_DOWN then
      shiftY = -rect.height * 0.5 - self.guideHeight * 0.5
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

function GuidePanel:GetGameObjRect(guideGameObjName)
  if not guideGameObjName then
    return
  end
  local rectFuncName = "GetRect_" .. guideGameObjName
  local getRectFunc = GuideUtils[rectFuncName]
  if getRectFunc then
    local rect = getRectFunc()
    if not rect then
      Logger.Warn("GuideUtils.lua没有定义[%s]函数,或者函数没有返回rect")
      return
    end
    return rect
  else
    local rect = GuideUtils.GetRectCommon(guideGameObjName)
    return rect
  end
end

function GuidePanel:GetGuideScreenPos(guidePos)
  local anchorPos = string.split(guidePos, ",")
  anchorPos[1] = tonumber(anchorPos[1]) - 0.5
  anchorPos[2] = tonumber(anchorPos[2]) - 0.5
  return {
    anchorPos[1] * self.panelWidth,
    anchorPos[2] * self.panelHeight
  }
end

function GuidePanel:FilterPanelRange(x, y, width, height)
  local rectTrans = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local rect = rectTrans.rect
  local minX = rect.xMin + width * 0.5
  local maxX = rect.xMax - width * 0.5
  local minY = rect.yMin + height * 0.5
  local maxY = rect.yMax - height * 0.5
  return math_max(minX, math_min(maxX, x)), math_max(minY, math_min(maxY, y))
end

return GuidePanel
