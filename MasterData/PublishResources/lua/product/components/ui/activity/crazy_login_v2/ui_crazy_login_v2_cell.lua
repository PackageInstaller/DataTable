_class("UICrazyLoginV2Cell", UICustomWidget)
UICrazyLoginV2Cell = UICrazyLoginV2Cell

function UICrazyLoginV2Cell:OnShow(uiParams)
  self._dayNum = 1
  self:SetSelected(false)
end

function UICrazyLoginV2Cell:OnHide()
  if self._resF then
    self._resF:Dispose()
    self._resF = nil
  end
  if self._resB then
    self._resB:Dispose()
    self._resB = nil
  end
end

function UICrazyLoginV2Cell:_SetUI_ByCfg()
  local value = UICrazyLoginV2Helper.GetValue(self._campaign, "AwardParticecleF")
  self._resF = UICrazyLoginV2Helper.SetEffByCfg(self, "eff_front", value, self._resF)
  value = UICrazyLoginV2Helper.GetValue(self._campaign, "AwardParticecleB")
  self._resB = UICrazyLoginV2Helper.SetEffByCfg(self, "eff_back", value, self._resB)
  value = UICrazyLoginV2Helper.GetValue(self._campaign, "LockImage")
  UIWidgetHelper.SetRawImage(self, "_imgLock", value)
  value = UICrazyLoginV2Helper.GetValue(self._campaign, "SpecialBg")
  UIWidgetHelper.SetRawImage(self, "_fgSpecial", value)
  value = UICrazyLoginV2Helper.GetValue(self._campaign, "SelectedBg")
  UIWidgetHelper.SetRawImage(self, "_fgSelected", value)
end

function UICrazyLoginV2Cell:_SetStageUI_ByCfg(state)
  local value = UICrazyLoginV2Helper.GetStateValue(self._campaign, state, "bg")
  UIWidgetHelper.SetRawImage(self, "_bg", value)
  local color = UICrazyLoginV2Helper.GetStateValue(self._campaign, state, "day")
  UICrazyLoginV2Helper.SetTextColorByCfg(self, "_txtDay", color)
  local widget = {
    "StateCanGetText",
    "StateGotText",
    "StateLockedText"
  }
  color = UICrazyLoginV2Helper.GetStateValue(self._campaign, state, "desc")
  UICrazyLoginV2Helper.SetTextColorByCfg(self, widget[state], color)
end

function UICrazyLoginV2Cell:SetData(campaign, idx, data, lastCell, selectCallback, getCallback, tipCallback, lastDay)
  self._campaign = campaign
  self._idx = idx
  self._data = data
  self._lastCell = lastCell
  self._selectCallback = selectCallback
  self._getCallback = getCallback
  self._tipCallback = tipCallback
  self._lastFixed = UICrazyLoginV2Helper.GetValue(self._campaign, "LastFixed") or false
  self:_SetUI_ByCfg()
  self:_SetItems(data.m_rewards)
  self:_SetDayText(data.m_login_days)
  self._state = UICrazyLoginV2Helper.SafeState(data.m_reward_status)
  self:_SetState(self._state)
end

function UICrazyLoginV2Cell:_SetState(state, forEffect)
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {
      "StateCanGet"
    },
    {"StateGot"},
    {
      "StateLocked"
    }
  })
  UIWidgetHelper.SetObjGroupShow(objs, state)
  local isGot = UICrazyLoginV2Helper.IsStateRecved(state)
  self:_SetStageUI_ByCfg(state)
  if forEffect then
    return
  end
  local effShow = isSpecial and not isGot
  self:_SetEffShow(effShow)
  local value = isGot and 0.5 or 1
  self:_SetAlpha(value)
  local isSpecial = self._lastCell
  self:_SetSpecial(isSpecial)
end

function UICrazyLoginV2Cell:_SetItems(itemData)
  local objs = UIWidgetHelper.SpawnObjects(self, "_itemPool", "UICrazyLoginV2Item", #itemData)
  for i, v in ipairs(objs) do
    v:SetData(itemData[i], self._tipCallback)
  end
end

function UICrazyLoginV2Cell:_SetDayText(dayNum)
  local text = StringTable.Get("str_temp_sign_in_day_text", dayNum)
  UIWidgetHelper.SetLocalizationText(self, "_txtDay", text)
end

function UICrazyLoginV2Cell:_SetEffShow(effShow)
  self:GetGameObject("eff_front"):SetActive(effShow)
  self:GetGameObject("eff_back"):SetActive(effShow)
end

function UICrazyLoginV2Cell:SetSelected(show)
  self:GetGameObject("_fgSelected"):SetActive(show)
end

function UICrazyLoginV2Cell:_SetSpecial(show)
  self:GetGameObject("_fgSpecial"):SetActive(show)
end

function UICrazyLoginV2Cell:_SetAlpha(value)
  local cg = self:GetUIComponent("CanvasGroup", "AlphaArea")
  cg.alpha = value
  local cg2 = self:GetUIComponent("CanvasGroup", "StateArea")
  cg2.alpha = value
end

function UICrazyLoginV2Cell:OnAwardGot(rewards)
  self:_SetState(ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED, true)
  local animName = "uieff_UIActivityCrazyLoginContent_Cell_Get"
  UIWidgetHelper.PlayAnimation(self, "_anim", animName, 333, function()
    UIActivityHelper.ShowUIGetRewards(rewards)
  end)
end

function UICrazyLoginV2Cell:BgBtnOnClick(go)
  local idx = self._idx
  if self._selectCallback then
    self._selectCallback(idx)
  end
  local canRecv = UICrazyLoginV2Helper.IsStateCanRecv(self._data.m_reward_status)
  if canRecv and self._getCallback then
    self._getCallback(idx)
  end
end
