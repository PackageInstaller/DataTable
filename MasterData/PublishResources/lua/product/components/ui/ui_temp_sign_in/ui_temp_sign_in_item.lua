_class("UITempSignInItem", UICustomWidget)
UITempSignInItem = UITempSignInItem

function UITempSignInItem:OnShow(uiParam)
end

function UITempSignInItem:OnHide()
end

function UITempSignInItem:SetData(idx, data, currentTotalDay, selectCallback, getCallback, tipCallback, lastDay)
  self._idx = idx
  self._data = data
  self._currentTotalDay = currentTotalDay
  self._selectCallback = selectCallback
  self._getCallback = getCallback
  self._tipCallback = tipCallback
  self._lastDay = lastDay and lastDay or false
  self:_SetItems()
  self:_SetDayText(self._data.day)
  self:_SetState(self._data.got)
end

function UITempSignInItem:_SetItems()
  local awards = self._data.awardList
  local items = UIWidgetHelper.SpawnObjects(self, "ItemArea", "UITempSignInAwardItem", #awards)
  for i = 1, #items do
    items[i]:SetData(i, awards[i], self._tipCallback)
  end
end

function UITempSignInItem:_SetCurDay(isCurDay)
  local state = isCurDay and 1 or 2
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "bg_curday",
      "DayText_curday"
    },
    {
      "bg_normal",
      "DayText_normal"
    }
  })
  UIWidgetHelper.SetObjGroupShow(objs, state)
end

function UITempSignInItem:_SetState(state, forEffect)
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "StateLocked"
    },
    {
      "StateCanGet"
    },
    {"StateGot"}
  })
  UIWidgetHelper.SetObjGroupShow(objs, state)
  if forEffect then
    return
  end
  local isCurDay = self._data.day == self._currentTotalDay
  local isLastDay = self._lastDay
  local isGot = self._data.got == NewPlayerLoginStatus.NPLS_Accepted
  self:_SetCurDay(isCurDay)
  self:_SetLastFrame(isLastDay)
  local showEff = (isCurDay or isLastDay) and not isNotGot
  self:GetGameObject("eff_front"):SetActive(showEff)
  self:GetGameObject("eff_back"):SetActive(showEff)
  local value = isGot and 0.5 or 1
  self:_SetAlpha(value)
end

function UITempSignInItem:_SetAlpha(value)
  local cg = self:GetUIComponent("CanvasGroup", "SetAlphaArea")
  cg.alpha = value
  local cg2 = self:GetUIComponent("CanvasGroup", "StateArea")
  cg2.alpha = value
end

function UITempSignInItem:SetSelected(show)
  self:GetGameObject("SelectStateArea"):SetActive(show)
end

function UITempSignInItem:_SetLastFrame(show)
  self:GetGameObject("lastFrame"):SetActive(show)
end

function UITempSignInItem:_SetDayText(day)
  local tb = {
    "DayText_curday",
    "DayText_normal"
  }
  for _, v in ipairs(tb) do
    UIWidgetHelper.SetLocalizationText(self, v, StringTable.Get("str_temp_sign_in_day_text", day))
  end
end

function UITempSignInItem:OnAwardGot(data)
  self._data = data
  self:_SetState(self._data.got, true)
  local animName = "uieff_UITempSigninContent_Cell_Get"
  UIWidgetHelper.PlayAnimation(self, "_anim", animName, 333, function()
    UIActivityHelper.ShowUIGetRewards(data.awardList)
  end)
end

function UITempSignInItem:BgBtnOnClick(go)
  local idx = self._idx
  if self._selectCallback then
    self._selectCallback(idx)
  end
  local canGet = self._data.got == NewPlayerLoginStatus.NPLS_UnAccept
  if canGet and self._getCallback then
    self._getCallback(idx)
  end
end
