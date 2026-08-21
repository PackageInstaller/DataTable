_class("UIQuestDailyActivePointItem", UICustomWidget)
UIQuestDailyActivePointItem = UIQuestDailyActivePointItem

function UIQuestDailyActivePointItem:OnShow(uiParams)
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
  self._module = GameGlobal.GetModule(QuestModule)
  if self._module == nil then
    Log.fatal("###[quest] error --> QuestModule is nil !")
  end
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.RolePropertyChanged, self._OnValue)
end

function UIQuestDailyActivePointItem:SetData(index, points, currentPoint, posX, callback, tipsCb, high)
  self:_GetComponents()
  self._index = index
  self._points = points
  self._point = self._points[self._index].VigPoint
  self._rewards = self._points[self._index].Reward
  self._state = 0
  self._currentPoint = currentPoint
  self._posX = posX
  self._callback = callback
  self._tipsCb = tipsCb
  self._high = high
  self:_OnValue()
end

function UIQuestDailyActivePointItem:OnHide()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.RolePropertyChanged, self._OnValue)
end

function UIQuestDailyActivePointItem:_GetComponents()
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._img = self:GetUIComponent("Image", "img")
  self._pointTex = self:GetUIComponent("UILocalizationText", "pointTex")
  self._bglight = self:GetGameObject("bglight")
  self._bglight:SetActive(false)
  self._fglight = self:GetGameObject("fglight")
  self._fglight:SetActive(false)
  self._yellowPoint = self:GetGameObject("YellowPoint")
  self._yellowPoint:SetActive(false)
  self._highObj = self:GetGameObject("high")
  self._graPointObj = self:GetGameObject("graPoint")
end

function UIQuestDailyActivePointItem:_OnValue()
  if not self._index then
    return
  end
  self._rect.anchoredPosition = Vector2(self._posX + 8.6, 0)
  local get = self._module:IsGotVigorousReward(self._index)
  if get then
    self._state = 2
  elseif self._currentPoint < self._point then
    self._state = 0
  else
    self._state = 1
  end
  if 0 >= self._state then
    self._img.sprite = self._atlas:GetSprite("task_daily_liwu2")
    self._bglight:SetActive(false)
    self._fglight:SetActive(false)
    self._yellowPoint:SetActive(false)
  elseif self._state == 1 then
    self._bglight:SetActive(true)
    self._yellowPoint:SetActive(true)
    self._highObj:SetActive(self._high)
    if self._high then
      self._img.sprite = self._atlas:GetSprite("task_daily_liwu3")
      self._fglight:SetActive(true)
    else
      self._img.sprite = self._atlas:GetSprite("task_daily_liwu8")
      self._fglight:SetActive(false)
    end
  elseif self._state == 2 then
    self._img.sprite = self._atlas:GetSprite("task_daily_liwu1")
    self._bglight:SetActive(false)
    self._fglight:SetActive(false)
    self._yellowPoint:SetActive(true)
  end
  self._pointTex:SetText(self._point)
end

function UIQuestDailyActivePointItem:GetActiveState()
  return self._state == 1
end

function UIQuestDailyActivePointItem:bgOnClick()
  if self._state == 0 or self._state == 2 then
    local cfg = Cfg.cfg_vigorous_reward[self._index]
    if cfg == nil then
      Log.fatal("[quest] error --> cfg_vigorous_reward is nil ! index --> " .. self._index)
      return
    end
    local rewards = {}
    for i = 1, table.count(cfg.Reward) do
      rewards[i] = {}
      rewards[i].assetid = cfg.Reward[i][1]
      rewards[i].count = cfg.Reward[i][2]
    end
    local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
    local loginModule = GameGlobal.GetModule(LoginModule)
    local extraAward = cfg.ExtraReward
    if extraAward then
      local cfg_extras = Cfg.cfg_vigorous_extra_reward({})
      for i = 1, #extraAward do
        local extraAwardID = extraAward[i]
        local cfg_extra = cfg_extras[extraAwardID]
        local startTimeStr = cfg_extra.StartTime
        local endTimeStr = cfg_extra.EndTime
        local nowTime = svrTimeModule:GetServerTime() * 0.001
        local startTime = loginModule:GetTimeStampByTimeStr(startTimeStr, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
        local endTime = loginModule:GetTimeStampByTimeStr(endTimeStr, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
        if nowTime >= startTime and nowTime < endTime then
          local reward = cfg_extra.Reward
          if reward then
            for j = 1, #reward do
              local key = #rewards + 1
              rewards[key] = {}
              rewards[key].assetid = reward[j][1]
              rewards[key].count = reward[j][2]
            end
          end
        end
      end
    end
    if self._tipsCb then
      self._tipsCb(rewards, self._rect.anchoredPosition)
    end
  elseif self._state == 1 and self._callback then
    self._callback(self._index)
  end
end
