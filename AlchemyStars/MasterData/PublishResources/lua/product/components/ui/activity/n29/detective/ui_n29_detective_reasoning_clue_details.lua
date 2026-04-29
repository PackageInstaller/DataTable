_class("UIN29DetectiveReasoningClueDetails", UIController)
UIN29DetectiveReasoningClueDetails = UIN29DetectiveReasoningClueDetails

function UIN29DetectiveReasoningClueDetails:Constructor()
end

function UIN29DetectiveReasoningClueDetails:LoadDataOnEnter(TT, res, uiParams)
  self._idClue = uiParams[1]
  self._isCheck = uiParams[2]
end

function UIN29DetectiveReasoningClueDetails:OnShow(uiParams)
  self._txtNameValue = self:GetUIComponent("UILocalizationText", "txtNameValue")
  self._txtPlaceValue = self:GetUIComponent("UILocalizationText", "txtPlaceValue")
  self._txtDescValue = self:GetUIComponent("UILocalizationText", "txtDescValue")
  self._titleChecked = self:GetUIComponent("RectTransform", "titleChecked")
  self._titleUnchecked = self:GetUIComponent("RectTransform", "titleUnchecked")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._animation = self:GetUIComponent("Animation", "animation")
  self:Flush()
end

function UIN29DetectiveReasoningClueDetails:OnHide()
end

function UIN29DetectiveReasoningClueDetails:BtnCloseOnClick(go)
  self:CloseDialogAnimation()
end

function UIN29DetectiveReasoningClueDetails:BtnAnywhereOnClick(go)
  self:CloseDialogAnimation()
end

function UIN29DetectiveReasoningClueDetails:Flush()
  local allClue = Cfg.cfg_component_detective_item({})
  local cfgClue = allClue[self._idClue]
  if cfgClue == nil then
    Log.error("cfg_component_detective_item 缺少配置! id --> ", self._idClue)
    return
  end
  self._txtNameValue:SetText(StringTable.Get(cfgClue.Name))
  self._txtPlaceValue:SetText(StringTable.Get(cfgClue.Place))
  self._txtDescValue:SetText(StringTable.Get(cfgClue.Info))
  self._titleChecked.gameObject:SetActive(self._isCheck)
  self._titleUnchecked.gameObject:SetActive(not self._isCheck)
  self._iconLoader:LoadImage(cfgClue.Icon)
end

function UIN29DetectiveReasoningClueDetails:CloseDialogAnimation(cbFinish)
  self:StartTask(function(TT)
    self._animation:Play("uieff_UIN29DetectiveReasoningClueDetails_out")
    YIELD(TT, 167)
    self:CloseDialog()
    if cbFinish then
      cbFinish()
    end
  end)
end
