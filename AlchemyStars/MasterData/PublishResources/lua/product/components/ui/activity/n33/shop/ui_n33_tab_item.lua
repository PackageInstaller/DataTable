_class("UIN33TabItem", UICustomWidget)
UIN33TabItem = UIN33TabItem

function UIN33TabItem:OnShow(uiParams)
  self:_GetComponents()
  self._animCfg = {
    [1] = {
      "uieff_UIN33TabItem_in",
      333.3333333333333
    },
    [2] = {
      "uieff_UIN33TabItem_select_in",
      300.0
    },
    [3] = {
      "uieff_UIN33TabItem_select_out",
      266.6666666666667
    }
  }
  self._isSelected = false
end

function UIN33TabItem:OnHide()
  if self._inAnimTask then
    GameGlobal.TaskManager():KillTask(self._inAnimTask)
    self._inAnimTask = nil
  end
  if self._animTask then
    GameGlobal.TaskManager():KillTask(self._animTask)
    self._animTask = nil
  end
end

function UIN33TabItem:InitData(idx, islock, isbigEmpty, leftNum, callback, yieldTime)
  self._id = idx
  self._islock = islock
  self._isbigEmpty = isbigEmpty
  self._leftNum = leftNum
  self._callback = callback
  self:_FillUi()
  if 0 <= yieldTime then
    self._goAnim:SetActive(false)
    self:ShowInAnim(yieldTime)
  end
end

function UIN33TabItem:_GetComponents()
  self._inAnim = self:GetUIComponent("Animation", "inAnim")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._goAnim = self:GetGameObject("anim")
  self._goLock = self:GetGameObject("lock")
  self._goUnlock = self:GetGameObject("unlock")
  self._imgBabyJianYing = self:GetUIComponent("RawImageLoader", "babyJianYing")
  self._imgBaby = self:GetUIComponent("RawImageLoader", "baby")
  self._textLeftNum = self:GetUIComponent("UILocalizationText", "leftNum")
  self._goBig = self:GetGameObject("big")
  self._goSelect = self:GetGameObject("GoSelect")
end

function UIN33TabItem:_FillUi()
  local uiCfg = Cfg.cfg_n33_shop_ui[self._id]
  if not uiCfg then
    return
  end
  self._goLock:SetActive(self._islock)
  self._goUnlock:SetActive(not self._islock)
  if self._islock then
    self._imgBabyJianYing:LoadImage(uiCfg.DollShadowImage)
  else
    self._imgBaby:LoadImage(uiCfg.DollImage)
    self._textLeftNum:SetText(StringTable.Get("str_n33_shop_tab_left_item_number") .. self._leftNum)
    self._goBig:SetActive(self._isbigEmpty)
  end
end

function UIN33TabItem:ChangeSelect(show, yieldTime)
  if 0 < yieldTime then
    if show then
      self:ShowAnim(2, yieldTime)
      self._isSelected = true
    end
  elseif not self._isSelected and show then
    self:ShowAnim(2, yieldTime)
    self._isSelected = true
  elseif self._isSelected and not show then
    self:ShowAnim(3, yieldTime)
    self._isSelected = false
  end
end

function UIN33TabItem:BgOnClick(go)
  if self._callback then
    self._callback(self._id)
  end
end

function UIN33TabItem:ShowInAnim(yieldTime)
  local data = self._animCfg[1]
  self._inAnimTask = self:StartTask(function(TT)
    YIELD(TT, yieldTime)
    self._goAnim:SetActive(true)
    self._inAnim:Play(data[1])
    YIELD(TT, data[2])
    self._inAnimTask = nil
  end)
end

function UIN33TabItem:ShowAnim(id, yieldTime)
  if self._animTask then
    GameGlobal.TaskManager():KillTask(self._animTask)
    self._animTask = nil
  end
  local data = self._animCfg[id]
  self._animTask = self:StartTask(function(TT)
    YIELD(TT, yieldTime)
    self._anim:Play(data[1])
    YIELD(TT, data[2])
    self._animTask = nil
  end)
end
