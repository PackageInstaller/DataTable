_class("UIFeatureAlgorithmUpgradeInfo", UIController)
UIFeatureAlgorithmUpgradeInfo = UIFeatureAlgorithmUpgradeInfo

function UIFeatureAlgorithmUpgradeInfo:OnShow(uiParams)
  self._auData = uiParams[1]
  self:InitWidget()
  self:_RefreshContent()
end

function UIFeatureAlgorithmUpgradeInfo:InitWidget()
  self._titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self._content = self:GetUIComponent("UILocalizationText", "Content")
end

function UIFeatureAlgorithmUpgradeInfo:DotBGOnClick()
  self:CloseDialog()
end

function UIFeatureAlgorithmUpgradeInfo:_RefreshContent()
  local activeRelics = InnerGameHelperRender.GetFeatureAUActiveRelics()
  if self._auData then
    local relicIDList = self._auData:GetRelicIDList()
    local relicDescList = self._auData:GetRelicDescList()
    if #relicDescList ~= #relicIDList then
      Log.error("AlgorithmUpgrade relic id and desc count is not match!")
      return
    end
    local validColorStrFormat = "<color=#E2C017>%s</color>"
    if relicIDList then
      local paramCount = #relicIDList
      local contentStr = ""
      for i, relicID in ipairs(relicIDList) do
        local descStr = StringTable.Get(relicDescList[i])
        if table.icontains(activeRelics, relicID) then
          descStr = string.format(validColorStrFormat, descStr)
        end
        if paramCount == i then
          contentStr = contentStr .. descStr
        else
          contentStr = contentStr .. descStr .. "\n"
        end
      end
      self._content:SetText(contentStr)
    end
  end
end
