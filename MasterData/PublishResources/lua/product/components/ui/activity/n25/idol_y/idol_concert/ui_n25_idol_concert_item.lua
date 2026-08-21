_class("UIN25IdolConcertItem", UICustomWidget)
UIN25IdolConcertItem = UIN25IdolConcertItem

function UIN25IdolConcertItem:Constructor()
  self.weekIdx2Tex = {
    [1] = "str_n25_idol_y_concert_week_1",
    [2] = "str_n25_idol_y_concert_week_2",
    [3] = "str_n25_idol_y_concert_week_3",
    [4] = "str_n25_idol_y_concert_week_4",
    [5] = "str_n25_idol_y_concert_week_5",
    [6] = "str_n25_idol_y_concert_week_6"
  }
  self.weekDay2Tex = {
    [1] = "str_n25_idol_y_concert_Monday",
    [2] = "str_n25_idol_y_concert_Tuesday",
    [3] = "str_n25_idol_y_concert_Wednesday",
    [4] = "str_n25_idol_y_concert_Thursday",
    [5] = "str_n25_idol_y_concert_Friday",
    [6] = "str_n25_idol_y_concert_Saturday",
    [7] = "str_n25_idol_y_concert_Sunday"
  }
end

function UIN25IdolConcertItem:OnShow(uiParams)
  self:GetComponents()
end

function UIN25IdolConcertItem:SetData(component, tipsCallback)
  self.component = component
  self._tipsCallback = tipsCallback
  self:OnValue()
  self:AttachEvent(GameEventType.OnN25FansChange, self.OnN25FansChange)
end

function UIN25IdolConcertItem:OnN25FansChange()
  local info = self.component:GetComponentInfo()
  local breakInfo = info.break_info
  local fansTex = breakInfo.funs_num
  local fansTexStr = HelperProxy:GetInstance():GetItemCountStr(fansTex, 6, "#cccccc", "#737373")
  self.fansTex:SetText(fansTexStr)
end

function UIN25IdolConcertItem:OnHide()
end

function UIN25IdolConcertItem:GetComponents()
  self.notGo = self:GetGameObject("not")
  self.todayGo = self:GetGameObject("today")
  self.fansTex = self:GetUIComponent("UILocalizationText", "fansTex")
  self.lessDay = self:GetUIComponent("UILocalizationText", "lessDay")
  self.targetFansValue = self:GetUIComponent("UILocalizationText", "targetFansValue")
  self.concertTypeTex = self:GetUIComponent("UILocalizationText", "concertTypeTex")
  self.weekDay = self:GetUIComponent("UILocalizationText", "weekDay")
  self.target = self:GetGameObject("target")
  self.currentfans = self:GetGameObject("currentfans")
end

function UIN25IdolConcertItem:OnValue()
  local info = self.component:GetComponentInfo()
  local breakInfo = info.break_info
  local currentTurn = breakInfo.round_index
  local concertCfg = self.component:UI_GetNextConcertInfo()
  local round_state = breakInfo.round_state
  local concertTurn = concertCfg.Turn
  local isToDay = concertTurn == currentTurn
  self.notGo:SetActive(not isToDay)
  self.todayGo:SetActive(isToDay)
  if isToDay then
    local title = concertCfg.ConcertTitle
    self.concertTypeTex:SetText(StringTable.Get(title))
  else
    self.lessDay = self:GetUIComponent("UILocalizationText", "lessDay")
    local concertTurn = concertCfg.Turn
    local lessDay = concertTurn - currentTurn
    self.lessDay:SetText(lessDay)
  end
  local targetFans = concertCfg.Fans
  if not targetFans or targetFans <= 0 then
    self.target:SetActive(false)
    self.currentfans:SetActive(true)
  else
    self.target:SetActive(true)
    self.currentfans:SetActive(false)
    self.targetFansValue:SetText(targetFans)
  end
  local fansTex = breakInfo.funs_num
  local fansTexStr = HelperProxy:GetInstance():GetItemCountStr(fansTex, 6, "#cccccc", "#737373")
  self.fansTex:SetText(fansTexStr)
  local weekIdx, weekDay = self.component:UI_Calc_WeekDay(currentTurn)
  local weekIdxTex = self.weekIdx2Tex[weekIdx]
  local weekDayTex = self.weekDay2Tex[weekDay]
  self.weekDay:SetText(StringTable.Get(weekIdxTex) .. " " .. StringTable.Get(weekDayTex))
end

function UIN25IdolConcertItem:BtnOnClick(go)
  if self._tipsCallback then
    local pos = go.transform.position
    local type = 4
    self._tipsCallback(pos, {type})
  end
end
