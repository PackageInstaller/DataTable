_class("UIN29DetectiveFragmentPopup", UIController)
UIN29DetectiveFragmentPopup = UIN29DetectiveFragmentPopup

function UIN29DetectiveFragmentPopup:Constructor()
end

function UIN29DetectiveFragmentPopup:LoadDataOnEnter(TT, res, uiParams)
  self._idFragment = uiParams[1]
  self._switchLock = uiParams[2]
  self._fnFinish = uiParams[3]
end

function UIN29DetectiveFragmentPopup:OnShow(uiParams)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N20ShowNormalResult)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "icon")
  self._txtNameValue = self:GetUIComponent("UILocalizationText", "txtNameValue")
  self._descContent = self:GetUIComponent("UILocalizationText", "descContent")
  self._animation = self:GetUIComponent("Animation", "animation")
  self:Flush()
  self:UnLock(self._switchLock)
end

function UIN29DetectiveFragmentPopup:OnHide()
  if self._fnFinish ~= nil then
    self._fnFinish()
  end
end

function UIN29DetectiveFragmentPopup:BtnAnywhereOnClick(go)
  self:Lock(self._switchLock)
  self:StartTask(function(TT)
    self._animation:Play("uieff_UIN29DetectiveFragmentPopup_out")
    YIELD(TT, 200)
    self:CloseDialog()
  end)
end

function UIN29DetectiveFragmentPopup:Flush()
  local allItem = Cfg.cfg_component_detective_item({})
  local cfg = allItem[self._idFragment]
  self._txtNameValue:SetText(StringTable.Get(cfg.Name))
  self._iconLoader:LoadImage(cfg.Icon)
  self._descContent:SetText(StringTable.Get(cfg.Info))
end

_class("UIN29DetectiveFragmentItem", UICustomWidget)
UIN29DetectiveFragmentItem = UIN29DetectiveFragmentItem

function UIN29DetectiveFragmentItem:OnShow(uiParams)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "icon")
  self._txtNameValue = self:GetUIComponent("UILocalizationText", "txtNameValue")
end

function UIN29DetectiveFragmentItem:Flush(id)
  local allItem = Cfg.cfg_component_detective_item({})
  local cfg = allItem[id]
  self._txtNameValue:SetText(StringTable.Get(cfg.Name))
  self._iconLoader:LoadImage(cfg.Icon)
end
