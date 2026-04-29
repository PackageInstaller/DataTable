_class("UIActivityCrazyLoginCell", UICustomWidget)
UIActivityCrazyLoginCell = UIActivityCrazyLoginCell

function UIActivityCrazyLoginCell:OnShow(uiParams)
  self._dayNum = 1
  self:SetSelected(false)
end

function UIActivityCrazyLoginCell:OnHide()
  if self._resF then
    self._resF:Dispose()
    self._resF = nil
  end
  if self._resB then
    self._resB:Dispose()
    self._resB = nil
  end
end

function UIActivityCrazyLoginCell:SetData(idx, data, cfg_data, selectCallback, getCallback, tipCallback, lastDay)
  self._idx = idx
  self._data = data
  self._cfg_data = cfg_data
  self._selectCallback = selectCallback
  self._getCallback = getCallback
  self._tipCallback = tipCallback
  self._lastDay = lastDay and lastDay or false
  self:_SetItems()
  self:_SetDayText(self._data._dayNum)
  self:_SetState(self._data._state)
  self:_FillUIByCfg(cfg_data)
end

function UIActivityCrazyLoginCell:_SetItems()
  local itemData = self._data._items
  self._items = UIWidgetHelper.SpawnObjects(self, "ItemArea", "UIActivityCrazyLoginItem", #itemData)
  for i, v in ipairs(self._items) do
    v:SetData(itemData[i], self._tipCallback)
  end
end

function UIActivityCrazyLoginCell:_FillUIByCfg(cfg)
  if not cfg then
    Log.error("UIActivityCrazyLoginCell:_FillUIByCfg() cfg is nil !")
    return
  end
  local color = self._data._isSpecial and cfg.SpecialTextColor or cfg.NormalTextColor
  self:_SetTextColorByCfg("DayText", color)
  if not self._setSpecBg then
    local bg = self._data._isSpecial and cfg.SpecialBg or cfg.NormalBg
    UIWidgetHelper.SetRawImage(self, "Bg", bg)
  end
  local lastFrame = cfg.LastDataImg
  if lastFrame then
    UIWidgetHelper.SetRawImage(self, "lastFrame", lastFrame)
  end
  self._resF = self:_SetEffByCfg("eff_front", cfg.AwardParticecleF, self._resF)
  self._resB = self:_SetEffByCfg("eff_back", cfg.AwardParticecleB, self._resB)
end

function UIActivityCrazyLoginCell:_SetTextColorByCfg(widgetName, cfg)
  if not cfg or #cfg ~= 3 then
    return
  end
  local r, g, b = cfg[1], cfg[2], cfg[3]
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj.color = Color(r / 255, g / 255, b / 255, obj.color.a)
end

function UIActivityCrazyLoginCell:_SetEffByCfg(widgetName, cfg, res)
  res = res or ResourceManager:GetInstance():SyncLoadAsset(cfg, LoadType.GameObject)
  if res then
    local go = res.Obj
    local eff = self:GetGameObject(widgetName)
    go.transform:SetParent(eff.transform)
    local rect = go:GetComponent("RectTransform")
    rect.anchoredPosition = Vector2(0, 0)
    rect.localScale = Vector3(1, 1, 1)
    go:SetActive(true)
  else
    Log.error("UIActivityCrazyLoginCell:_SetEffByCfg() res is nil ! resName = " .. cfg)
  end
  return res
end

function UIActivityCrazyLoginCell:_SetAlpha(value)
  local cg = self:GetUIComponent("CanvasGroup", "SetAlphaArea")
  cg.alpha = value
  local cg2 = self:GetUIComponent("CanvasGroup", "StateArea")
  cg2.alpha = value
end

function UIActivityCrazyLoginCell:SetSelected(show)
  self:GetGameObject("SelectStateArea"):SetActive(show)
end

function UIActivityCrazyLoginCell:_SetLastFrame(show)
  self:GetGameObject("lastFrame"):SetActive(show)
end

function UIActivityCrazyLoginCell:_SetDayText(day)
  UIWidgetHelper.SetLocalizationText(self, "DayText", StringTable.Get("str_temp_sign_in_day_text", day))
end

function UIActivityCrazyLoginCell:_SetState(state, forEffect)
  local tb_check = {
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_UNKNOW] = true,
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_Expired] = true
  }
  state = tb_check[state] and ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK or state
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
  if forEffect then
    return
  end
  local isLastDay = self._lastDay
  self:_SetLastFrame(isLastDay)
  local isGot = state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED
  local value = isGot and 0.5 or 1
  self:_SetAlpha(value)
  local effShow = self._data._isSpecial and not isGot
  self:GetGameObject("eff_front"):SetActive(effShow)
  self:GetGameObject("eff_back"):SetActive(effShow)
  self._setSpecBg = false
  local riLoader = self:GetUIComponent("RawImageLoader", "Bg")
  if riLoader then
    if isGot and self._cfg_data.GetOverBg then
      riLoader:LoadImage(self._cfg_data.GetOverBg)
      self._setSpecBg = true
    end
    if state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV and self._cfg_data.CanGetBg then
      riLoader:LoadImage(self._cfg_data.CanGetBg)
      self._setSpecBg = true
    end
  end
end

function UIActivityCrazyLoginCell:OnAwardGot(rewards)
  self:_SetState(ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED, true)
  local animName = "uieff_UIActivityCrazyLoginContent_Cell_Get"
  UIWidgetHelper.PlayAnimation(self, "_anim", animName, 333, function()
    UIActivityHelper.ShowUIGetRewards(rewards)
  end)
end

function UIActivityCrazyLoginCell:BgBtnOnClick(go)
  local idx = self._idx
  if self._selectCallback then
    self._selectCallback(idx)
  end
  local canGet = self._data._state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV
  if canGet and self._getCallback then
    self._getCallback(idx)
  end
end
