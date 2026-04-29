_class("UIN22EntrustStageDetailController", UIController)
UIN22EntrustStageDetailController = UIN22EntrustStageDetailController

function UIN22EntrustStageDetailController:OnShow(uiParams)
  self._campaign = uiParams[1]
  self._componentId = uiParams[2]
  self._levelId = uiParams[3]
  self._enterCallback = uiParams[4]
  self._component = self._campaign:GetComponent(self._componentId)
  self:_SetTitleDesc()
  self:_SetClearReward()
  self:_SetExplorReward()
  self:_SetExplorText()
  self:_SetPassIcon()
  self._isConfirm = nil
end

function UIN22EntrustStageDetailController:OnHide()
  if self._isConfirm and self._enterCallback then
    self._isConfirm = nil
    self._enterCallback(self._levelId)
  end
end

function UIN22EntrustStageDetailController:_SetTitleDesc()
  local strTitle, strDesc = self._component:GetStageTitleDesc(self._levelId)
  local obj = self:GetUIComponent("UILocalizationText", "_txtTitle")
  obj:SetText(StringTable.Get(strTitle))
  obj = self:GetUIComponent("UILocalizationText", "_txtDesc")
  obj:SetText(StringTable.Get(strDesc))
end

function UIN22EntrustStageDetailController:_SetClearReward()
  local lst1, lst2 = self._component:GetStagePassReward(self._levelId)
  local count = #lst1
  local objs = UIWidgetHelper.SpawnObjects(self, "_clearRewardPool", "UIN22EntrustRewardItem", count)
  for i = 1, count do
    objs[i]:SetData(lst1[i], lst2[i], function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
    end)
  end
end

function UIN22EntrustStageDetailController:_SetExplorReward()
  local lst1, lst2 = self._component:GetStageBoxReward(self._levelId)
  local count = #lst1
  local objs = UIWidgetHelper.SpawnObjects(self, "_explorRewardPool", "UIN22EntrustRewardItem", count)
  for i = 1, count do
    objs[i]:SetData(lst1[i], lst2[i], function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
    end)
  end
end

function UIN22EntrustStageDetailController:_SetExplorText()
  local num = self._component:GetExplorNum(self._levelId)
  local str = num .. "%"
  UIWidgetHelper.SetLocalizationText(self, "_txtExplor", str)
  UIWidgetHelper.SetLocalizedTMPText(self, "_txtExplorTmp", str)
end

function UIN22EntrustStageDetailController:_SetPassIcon()
  local show = self._component:IsStagePass(self._levelId)
  local obj = self:GetGameObject("_pass")
  obj:SetActive(show)
end

function UIN22EntrustStageDetailController:BtnOnClick()
  Log.info("UIN22EntrustStageDetailController:BtnOnClick")
  self._isConfirm = true
  self:CloseDialog()
end

function UIN22EntrustStageDetailController:CloseBtnOnClick()
  self:CloseDialog()
end

function UIN22EntrustStageDetailController:EmptyBtnOnClick()
  self:CloseDialog()
end
