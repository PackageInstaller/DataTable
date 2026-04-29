_class("UIWidgetFeatureScan", UICustomWidget)
UIWidgetFeatureScan = UIWidgetFeatureScan

function UIWidgetFeatureScan:OnShow(uiParams)
  self.enableFakeInput = true
end

function UIWidgetFeatureScan:SetData()
end

function UIWidgetFeatureScan:UIWidgetFeatureScanButtonOnClick()
  if InnerGameHelperRender.IsPuzzleState() or InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    return
  end
  local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
  if coreGameStateID ~= GameStateID.WaitInput then
    return
  end
  local scanTrap = FeatureServiceHelper.FeatureScanGetScanTrapIDList()
  GameGlobal.UIStateManager():ShowDialog("UIFeatureScanController", scanTrap)
end
