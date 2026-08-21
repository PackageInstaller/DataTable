_class("UIBattlePassCN1ExpInfo", UICustomWidget)
UIBattlePassCN1ExpInfo = UIBattlePassCN1ExpInfo

function UIBattlePassCN1ExpInfo:OnShow()
  self._imgProgressValue = self:GetUIComponent("Image", "imgProgressValue")
  local isZh = UIActivityZhHelper.IsZh()
  self:GetGameObject("txtTitle1_zh"):SetActive(isZh)
  self:GetGameObject("txtTitle1"):SetActive(not isZh)
  self._seq = DG.Tweening.DOTween.Sequence()
end

function UIBattlePassCN1ExpInfo:OnHide()
end

function UIBattlePassCN1ExpInfo:SetData(type, campaign, upgrade, refreshCallback)
  self._type = type
  self._campaign = campaign
  self._cmptId, self._component, self._componentInfo = UIActivityBattlePassHelper.Component_LVReward(self._campaign)
  self._refreshCallback = refreshCallback
  UIBattlePassStyleHelper.FitStyle_Widget(self._campaign, self)
  self:_SetState(type)
  self:_SetBuyLevelBtn()
  self:_SetIcon(self._componentInfo.m_item_id)
  if not upgrade then
    self:_SetExpNormal()
  else
    self:_SetExpUpgrade()
  end
end

function UIBattlePassCN1ExpInfo:_SetState(state)
  local widgetGroup = {
    {"_width1", "_space1"},
    {"_width2", "_space2"}
  }
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, widgetGroup, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
end

function UIBattlePassCN1ExpInfo:_SetBuyLevelBtn()
  local flag = self._componentInfo.m_current_level < self._componentInfo.m_max_level
  self:GetGameObject("_buyLevel"):SetActive(flag)
end

function UIBattlePassCN1ExpInfo:_SetTitle(lv)
  UIWidgetHelper.SetLocalizationText(self, "txtTitle1", "Lv.")
  lv = UIActivityHelper.FormatNumber_PreZero(2, lv)
  UIWidgetHelper.SetLocalizationText(self, "txtTitle2", lv)
  local txt3 = StringTable.Get("str_activity_battlepass_n5_main_title")
  UIWidgetHelper.SetLocalizationText(self, "txtTitle3", txt3)
end

function UIBattlePassCN1ExpInfo:_SetExp(lv, progress)
  self:_SetTitle(lv)
  local maxProgress = self._componentInfo.m_level_max_progress
  local text = string.format("%s/%s", progress, maxProgress)
  UIWidgetHelper.SetLocalizationText(self, "txtProgress", text)
  local rate = progress / maxProgress
  if rate ~= nil and 0 <= rate and rate <= 1 then
    self._imgProgressValue.fillAmount = rate
  end
  local max = self._component:CheckIsLevelMax()
  self:_SetMaxObj(max)
end

function UIBattlePassCN1ExpInfo:_SetMaxObj(isShow)
  local isZh = UIActivityZhHelper.IsZh()
  self:GetGameObject("max_zh"):SetActive(isZh and isShow)
  self:GetGameObject("max"):SetActive(not isZh and isShow)
end

function UIBattlePassCN1ExpInfo:_SetIcon(itemId)
  UIWidgetHelper.SetItemIcon(self, itemId, "imgIcon")
end

function UIBattlePassCN1ExpInfo:_SetExpNormal()
  self._curLv = self._componentInfo.m_current_level
  self._curProgress = self._componentInfo.m_current_progress
  self:_SetExp(self._curLv, self._curProgress)
end

function UIBattlePassCN1ExpInfo:_SetExpUpgrade()
  self._expIncreaseAnimTime = 1
  local curLv = self._curLv
  local curProgress = self._curProgress
  local targetLv = self._componentInfo.m_current_level
  local targetProgress = self._componentInfo.m_current_progress
  if curLv == targetLv and curProgress == targetProgress then
    self:_SetExpNormal()
    return
  end
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

function UIBattlePassCN1ExpInfo:_PlayFillAmount(lv, progress, callback)
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

function UIBattlePassCN1ExpInfo:BuyLevelBtnOnClick(go)
  Log.info("UIBattlePassCN1ExpInfo:BuyLevelBtnOnClick")
  UIActivityBattlePassHelper.OpenBuyLevelController(self._refreshCallback)
end
