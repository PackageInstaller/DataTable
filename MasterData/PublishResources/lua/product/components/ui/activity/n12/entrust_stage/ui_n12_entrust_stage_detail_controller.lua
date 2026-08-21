_class("UIN12EntrustStageDetailController", UIController)
UIN12EntrustStageDetailController = UIN12EntrustStageDetailController

function UIN12EntrustStageDetailController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIN12EntrustStageDetailController:_SpawnObjects(widgetName, className, count)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local objs = {}
  pool:SpawnObjects(className, count, objs)
  return objs
end

function UIN12EntrustStageDetailController:_InitWidget()
end

function UIN12EntrustStageDetailController:OnShow(uiParams)
  self._campaign = uiParams[1]
  self._componentId = uiParams[2]
  self._levelId = uiParams[3]
  self._component = self._campaign:GetComponent(self._componentId)
  self._isOpen = true
  self:_InitWidget()
  self:_SetTitleDesc()
  self:_SetClearReward()
  self:_SetExplorReward()
  self:_SetExplorText()
  self:_SetPassIcon()
  self:_SetEnterTex()
end

function UIN12EntrustStageDetailController:_SetEnterTex()
  self:SetTextMat()
end

function UIN12EntrustStageDetailController:SetTextMat()
  local tex = self:GetUIComponent("UILocalizedTMP", "txt")
  self:SetFontMat(tex, "uieff_n12_map_enter_tex.mat")
end

function UIN12EntrustStageDetailController:SetFontMat(lable, resname)
  self._res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  if not self._res then
    return
  end
  local obj = self._res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN12EntrustStageDetailController:OnHide()
  self._isOpen = false
  if self._res then
    self._res:Dispose()
    self._res = nil
  end
end

function UIN12EntrustStageDetailController:_SetTitleDesc()
  local strTitle, strDesc = self._component:GetStageTitleDesc(self._levelId)
  local obj = self:GetUIComponent("UILocalizationText", "_txtTitle")
  obj:SetText(StringTable.Get(strTitle))
  obj = self:GetUIComponent("UILocalizationText", "_txtDesc")
  obj:SetText(StringTable.Get(strDesc))
end

function UIN12EntrustStageDetailController:_SetClearReward()
  local lst1, lst2 = self._component:GetStagePassReward(self._levelId)
  local count = #lst1
  local objs = self:_SpawnObjects("_clearRewardPool", "UIN12EntrustStageDetailItem", count)
  for i = 1, count do
    objs[i]:SetData(lst1[i], lst2[i], function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
    end)
  end
end

function UIN12EntrustStageDetailController:_SetExplorReward()
  local lst1, lst2 = self._component:GetStageBoxReward(self._levelId)
  local count = #lst1
  local objs = self:_SpawnObjects("_explorRewardPool", "UIN12EntrustStageDetailItem", count)
  for i = 1, count do
    objs[i]:SetData(lst1[i], lst2[i], function(matid, pos)
      UIWidgetHelper.SetAwardItemTips(self, "_tipsPool", matid, pos)
    end)
  end
end

function UIN12EntrustStageDetailController:_SetExplorText()
  local num = self._component:GetExplorNum(self._levelId)
  local obj = self:GetUIComponent("UILocalizationText", "_txtExplor")
  obj:SetText(num .. "%")
end

function UIN12EntrustStageDetailController:_SetPassIcon()
  local show = self._component:IsStagePass(self._levelId)
  local obj = self:GetGameObject("_pass")
  obj:SetActive(show)
end

function UIN12EntrustStageDetailController:BtnOnClick()
  Log.info("UIN12EntrustStageDetailController:BtnOnClick")
  self._component:SetCurLevelId(self._levelId)
  self._component:SetPlayerPos(0)
  self._component:SetBannerState(0)
  self._campaign._campaign_module:CampaignSwitchState(true, UIStateType.UIN12EntrustLevelController, UIStateType.UIMain, {
    self._levelId,
    true
  }, self._campaign._id, self._componentId)
end

function UIN12EntrustStageDetailController:CloseBtnOnClick()
  self:CloseDialog()
end

function UIN12EntrustStageDetailController:EmptyBtnOnClick()
  self:CloseDialog()
end
