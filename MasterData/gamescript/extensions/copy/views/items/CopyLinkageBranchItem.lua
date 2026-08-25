local CopyLinkageBranchItem, Super = NewViewComponent("CopyLinkageBranchItem", CopySpecialBranchItem)

function CopyLinkageBranchItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_SetStageGroupLogo()
end

function CopyLinkageBranchItem:_SetStageGroupLogo()
  if not self.ui.Image_Logo then
    return
  end
  if self.stageGroupCfg and self.stageGroupCfg.DailyIcon and self.stageGroupCfg.DailyIcon[3] then
    self:SetActive(self.ui.Image_Logo, true)
    local langCode = DataCenter.gameData.CurrTextLanguage
    local targetLogoName
    local firstLogoName = self.stageGroupCfg.DailyIcon[3]
    for i = 3, #self.stageGroupCfg.DailyIcon do
      local iconName = self.stageGroupCfg.DailyIcon[i]
      if iconName and type(iconName) == "string" then
        local suffix = string.match(iconName, "_(%w+)$")
        if suffix == langCode then
          targetLogoName = iconName
          break
        end
      end
    end
    if not targetLogoName then
      local prefix = string.match(firstLogoName, "(.+)_%w+$")
      targetLogoName = prefix and prefix .. "_COM" or firstLogoName
    end
    local logoPath = string.format("UIResources/AtlasSource/UI_Chapter_Image/%s.png", targetLogoName)
    self:SetImage(self.ui.Image_Logo, logoPath)
  else
    self:SetActive(self.ui.Image_Logo, false)
  end
end

return CopyLinkageBranchItem
