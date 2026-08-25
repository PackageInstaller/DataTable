local ResearchMainItem, Super = System.NewComponent("ResearchMainItem")

function ResearchMainItem:ctor(uiNode, unLockCfg, tFuncData)
  Super.ctor(self)
  self.ui = UI_Research_Panel_Main_ItemResource(uiNode)
  self.unLockCfg = unLockCfg
  self.clickFunc = tFuncData.callFunc
  self.redType = tFuncData.redType
  self.redFunc = tFuncData.redFunc
  self.redRemoveData = tFuncData.redRemoveData
end

function ResearchMainItem:OnBind(binder)
  self.binder = binder
  self:BindVisible()
  self:BindButton()
  self:BindTextState()
  self:SetImageByLockState()
  self:BindRedDot()
end

function ResearchMainItem:BindButton()
  self.binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
end

function ResearchMainItem:BindVisible()
  self.binder:BindToVisible(self.ui.Group_Lock, function()
    do return self.IsLock end
    return self.IsLock, self
  end)
end

function ResearchMainItem:BindTextState()
  self.binder:BindToText(self.ui.Text_Name, function()
    return self.unLockCfg.FeatureName
  end)
  self.binder:BindToTextColor(self.ui.Text_Name, function()
    local isLock = self:IsLock()
    return isLock and CommonDefine.ColorType.Dark or CommonDefine.ColorType.Normal
  end)
end

function ResearchMainItem:SetImageByLockState()
  self.binder:BindToImage(self.ui.Image_Icon, function()
    local isLock = self:IsLock()
    return isLock and self.unLockCfg.ResearchLockIcon or self.unLockCfg.ResearchIcon
  end)
end

function ResearchMainItem:IsLock()
  local featureId, key = self:GetFeatureTidAndKey()
  local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(featureId, key)
  return not isUnlock
end

function ResearchMainItem:BindRedDot()
  local Fn, showFn
  if self.redType ~= nil then
    Fn = self.redFunc
    showFn = nil
  else
    Fn = nil
    showFn = self.redFunc
  end
  local result = nil ~= Fn or nil ~= showFn
  self.ui.Com_RedDot:SetActive(result)
  if result then
    self.binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, self.redType, Fn, showFn))
  end
end

function ResearchMainItem:GetFeatureTidAndKey()
  local featureCfg = self.unLockCfg
  local key = featureCfg.Key or PlayerDataUtils.GetFeatureMainTypeKey()
  return featureCfg.Feature, key
end

function ResearchMainItem:OnBtnClick()
  local featureId, key = self:GetFeatureTidAndKey()
  local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(featureId, key)
  if not isUnlock then
    PlayerDataUtils.AlertLockedTips(featureId, key)
  elseif self.clickFunc then
    local featureCfg = self.unLockCfg
    self.clickFunc(featureCfg)
    if self.redRemoveData then
      local redType = self.redRemoveData[1]
      local attrType = self.redRemoveData[2]
      local tid = self.redRemoveData[3]
      RedPointDataUtils.ReqRemoveData(redType, attrType, tid)
    end
  end
end

return ResearchMainItem
