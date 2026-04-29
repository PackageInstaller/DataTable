_class("UIPetIntimacyImageRecallController", UIController)
UIPetIntimacyImageRecallController = UIPetIntimacyImageRecallController

function UIPetIntimacyImageRecallController:OnShow(uiParams)
  self._imageRecallData = uiParams[1]
  self._petData = uiParams[2]
  self._indexLabel = self:GetUIComponent("UILocalizationText", "Index")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._titleLabel = self:GetUIComponent("UILocalizationText", "Title")
  self._indexLabel.text = self._imageRecallData.index
  self._desLabel.text = HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(self._imageRecallData.des))
  self._titleLabel.text = StringTable.Get(self._petData:GetPetName()) .. "  " .. StringTable.Get(self._imageRecallData.title)
end

function UIPetIntimacyImageRecallController:ButtonBackgroundOnClick(go)
  self:CloseDialog()
end

function UIPetIntimacyImageRecallController:ButtonPlayOnClick(go)
  self:ShowDialog("UIStoryController", self._imageRecallData.storyId, function()
    self:CloseDialog()
  end)
end
