_class("UISeasonBackpack", UIController)
UISeasonBackpack = UISeasonBackpack

function UISeasonBackpack:Constructor()
  self._seasonModule = self:GetModule(SeasonModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UISeasonBackpack:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonBackpack:OnShow(uiParams)
  self._eventPoint = uiParams[1]
  self._callBack = uiParams[2]
  self._cfgs = {}
  self._interval = 0
  self:InitWidget()
  self:OnValue()
  local key = "UISeasonBackpack" .. GameGlobal.GetModule(LoginModule):GetRoleShowID()
  LocalDB.SetInt(key, 1)
end

function UISeasonBackpack:OnUpdate(deltaTime)
  self._interval = self._interval + deltaTime
  if self._interval >= 1000 then
    self._interval = 0
    self:_SetRemainTime()
  end
end

function UISeasonBackpack:InitWidget()
  self._backBtns = self:GetUIComponent("UISelectObjectPath", "BackBtns")
  self._lines = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodes = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._animation = self:GetGameObject():GetComponent("Animation")
  self._centerRect = self:GetUIComponent("RectTransform", "Center")
end

function UISeasonBackpack:OnValue()
  local obj = UIWidgetHelper.SpawnObject(self, "BackBtns", "UISeasonTopBtn")
  obj:SetData(function()
    self:Back()
  end, function()
    self:GoHome()
  end)
  self:_SetRemainTime()
  self:_CreateNodes()
  self:_MoveToFirstNode()
  self:Lock("uieff_UISeasonBackpack_in:OnValue")
  self:StartTask(function(TT)
    self._animation:Play("uieff_UISeasonBackpack_in")
    YIELD(TT, 300)
    self:PlayNodesAnimation()
    YIELD(TT, 500)
    self:UnLock("uieff_UISeasonBackpack_in:OnValue")
  end)
end

function UISeasonBackpack:_SetRemainTime()
  local seasonObj = self._seasonModule:GetCurSeasonObj()
  if seasonObj and seasonObj._sample then
    local sample = seasonObj._sample
    local endTime = sample.end_time
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local remainTime = endTime - curTime
    if 0 < remainTime then
      local timeStr = "<color=#D2B443>" .. UIActivityHelper.GetFormatTimerStr(remainTime) .. "</color>"
      self._remainTime:SetText(StringTable.Get("str_season_debris_remain", timeStr))
    end
  end
end

function UISeasonBackpack:Close()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonBackpackClose)
  self:CloseDialog()
end

function UISeasonBackpack:_CreateNodes()
  self._cfgs = Cfg.cfg_season_debris_mission({
    SeasonID = self._seasonModule:GetCurSeasonID(),
    Type = 1
  })
  if self._cfgs then
    table.sort(self._cfgs, function(a, b)
      return a.ID < b.ID
    end)
    local count = table.count(self._cfgs)
    self._nodes:SpawnObjects("UISeasonBackpackNode", count)
    self._lines:SpawnObjects("UISeasonBackpackLine", count - 1)
    self._nodeWidgets = self._nodes:GetAllSpawnList()
    self._lineWidgets = self._lines:GetAllSpawnList()
    for i = 1, count do
      self._nodeWidgets[i]:SetData(i, self._cfgs[i])
      if count > i then
        self._lineWidgets[i]:SetData(i)
      end
    end
  end
end

function UISeasonBackpack:_GetFirstChallenge()
  local targetIndex = 1
  for _, widget in pairs(self._nodeWidgets) do
    if widget:IsUnlock() and targetIndex < widget:Index() then
      targetIndex = widget:Index()
    end
  end
  return targetIndex
end

function UISeasonBackpack:_MoveToFirstNode()
  local index = self:_GetFirstChallenge()
  local pos = index * 400 + 290
  if pos > self._centerRect.rect.width then
    self._contentRect.anchoredPosition = Vector2(-(pos - self._centerRect.rect.width), 0)
  end
end

function UISeasonBackpack:RefreshUI()
  if self._nodeWidgets then
    for _, widget in pairs(self._nodeWidgets) do
      widget:Refresh()
    end
  end
end

function UISeasonBackpack:PlayNodesAnimation()
  if self._nodeWidgets then
    for _, widget in pairs(self._nodeWidgets) do
      widget:PlayAnimation()
    end
  end
end

function UISeasonBackpack:GoHome()
  if self._callBack then
    self._callBack(true)
  end
  self._seasonModule.uiModule:ExitSeasonTo(UIStateType.UIMain)
end

function UISeasonBackpack:IsClose()
  local seasonObj = self._seasonModule:GetCurSeasonObj()
  if seasonObj and seasonObj._sample then
    local sample = seasonObj._sample
    local endTime = sample.end_time
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local remainTime = endTime - curTime
    return remainTime <= 0
  end
  return true
end

function UISeasonBackpack:Back()
  self:Lock("uieff_UISeasonBackpack_out")
  self:StartTask(function(TT)
    self._animation:Play("uieff_UISeasonBackpack_out")
    YIELD(TT, 267)
    if self._callBack then
      self._callBack(true)
    end
    self:Close()
    self:UnLock("uieff_UISeasonBackpack_out")
  end)
end
