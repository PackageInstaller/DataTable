_class("UIActivityBattlePassN5ExpInfo", UICustomWidget)
UIActivityBattlePassN5ExpInfo = UIActivityBattlePassN5ExpInfo

function UIActivityBattlePassN5ExpInfo:_GetComponents()
  self._txtTitle1 = self:GetUIComponent("UILocalizationText", "txtTitle1")
  self._txtTitle2 = self:GetUIComponent("UILocalizationText", "txtTitle2")
  self._txtTitle3 = self:GetUIComponent("UILocalizationText", "txtTitle3")
  self._txtTitle4 = self:GetUIComponent("UILocalizationText", "txtTitle4")
  self._imgProgressBg = self:GetUIComponent("Image", "imgProgressBg")
  self._imgProgressValue = self:GetUIComponent("Image", "imgProgressValue")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._txtProgress = self:GetUIComponent("UILocalizationText", "txtProgress")
end

function UIActivityBattlePassN5ExpInfo:OnShow()
  self._isOpen = true
  self:_GetComponents()
  local isZh = UIActivityZhHelper.IsZh()
  self:GetGameObject("txtTitle1_zh"):SetActive(isZh)
  self:GetGameObject("txtTitle1"):SetActive(not isZh)
  self._seq = DG.Tweening.DOTween.Sequence()
end

function UIActivityBattlePassN5ExpInfo:OnHide()
  self._isOpen = false
end

function UIActivityBattlePassN5ExpInfo:SetData(campaign, componentInfo, upgrade)
  self._campaign = campaign
  self._componentInfo = componentInfo
  self:_SetIcon(self._componentInfo.m_item_id)
  if not upgrade then
    self:_SetExpNormal()
  else
    self:_SetExpUpgrade()
  end
end

function UIActivityBattlePassN5ExpInfo:_SetTitle(lv)
  self._txtTitle1:SetText("Lv.")
  if lv < 10 then
    lv = "<color=#7f7f7f>0</color>" .. lv
  end
  self._txtTitle2:SetText(lv)
  self._txtTitle3:SetText(StringTable.Get("str_activity_battlepass_n5_main_title"))
  local strId = UIActivityBattlePassHelper.GetStrIdInCampaign(self._campaign, "str_activity_battlepass_n5_main_title_2")
  self._txtTitle4:SetText(StringTable.Get(strId))
end

function UIActivityBattlePassN5ExpInfo:_SetExp(lv, progress)
  self:_SetTitle(lv)
  local maxProgress = self._componentInfo.m_level_max_progress
  local maxLv = self._componentInfo.m_max_level
  local formatStr = "%s<color=#FF0000>/</color><size=30>%s</size>"
  self._txtProgress:SetText(string.format(formatStr, progress, maxProgress))
  local rate = progress / maxProgress
  if rate ~= nil and 0 <= rate and rate <= 1 then
    self._imgProgressValue.fillAmount = rate
  end
  local max = lv == maxLv and progress == maxProgress
  self._txtProgress.gameObject:SetActive(not max)
  self:_SetMaxObj(max)
end

function UIActivityBattlePassN5ExpInfo:_SetMaxObj(isShow)
  local isZh = UIActivityZhHelper.IsZh()
  self:GetGameObject("max_zh"):SetActive(isZh and isShow)
  self:GetGameObject("max"):SetActive(not isZh and isShow)
end

function UIActivityBattlePassN5ExpInfo:_SetIcon(itemId)
  self._cfg_item = Cfg.cfg_item[itemId]
  if self._cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. itemId)
    return
  end
  local icon = self._cfg_item.Icon
  self._imgIcon:LoadImage(icon)
end

function UIActivityBattlePassN5ExpInfo:_SetExpNormal()
  self._curLv = self._componentInfo.m_current_level
  self._curProgress = self._componentInfo.m_current_progress
  self:_SetExp(self._curLv, self._curProgress)
end

function UIActivityBattlePassN5ExpInfo:_SetExpUpgrade()
  self._expIncreaseAnimTime = 1
  local curLv = self._curLv
  local curProgress = self._curProgress
  local targetLv = self._componentInfo.m_current_level
  local targetProgress = self._componentInfo.m_current_progress
  local maxProgress = self._componentInfo.m_level_max_progress
  if curLv < targetLv then
    self:_PlayFillAmount(curLv, maxProgress, function()
      self:_SetExp(targetLv, 0)
      self:_PlayFillAmount(targetLv, targetProgress)
    end)
  else
    self:_PlayFillAmount(targetLv, targetProgress)
  end
  self._curLv = targetLv
  self._curProgress = targetProgress
end

function UIActivityBattlePassN5ExpInfo:_PlayFillAmount(lv, progress, callback)
  local maxProgress = self._componentInfo.m_level_max_progress
  local rate = progress / maxProgress
  local tweener = self._imgProgressValue:DOFillAmount(rate, self._expIncreaseAnimTime):OnUpdate(function()
    local value = math.floor(self._imgProgressValue.fillAmount * maxProgress)
    self:_SetExp(lv, value)
  end):OnComplete(function()
    self:_SetExp(lv, progress)
    if callback then
      callback()
    end
  end)
  self._seq:Append(tweener)
end
