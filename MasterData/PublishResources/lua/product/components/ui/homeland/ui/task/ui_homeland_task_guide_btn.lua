_class("UIHomelandTaskGuideBtn", UICustomWidget)
UIHomelandTaskGuideBtn = UIHomelandTaskGuideBtn

function UIHomelandTaskGuideBtn:Constructor()
  self._atlas = self:GetAsset("UIHomelandTask.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomelandTaskGuideBtn:OnShow(uiParams)
  self:_GetComponents()
end

function UIHomelandTaskGuideBtn:_GetComponents()
  self._text = self:GetUIComponent("UILocalizationText", "Text")
  self._btnImg = self:GetUIComponent("Image", "Btn")
end

function UIHomelandTaskGuideBtn:SetData(groupID, callBack)
  self._groupID = groupID
  self._callBack = callBack
  local cfg = Cfg.cfg_homeland_task_group[self._groupID]
  if cfg then
    self._text:SetText(StringTable.Get(cfg.GroupTitle))
  end
end

function UIHomelandTaskGuideBtn:BtnOnClick(go)
  if self._callBack then
    self._callBack(self._groupID)
  end
end

function UIHomelandTaskGuideBtn:RefreshBtn(groupID)
  local color = Color(0.5607843137254902, 0.5607843137254902, 0.5607843137254902)
  local sprite = "N17_task_btn02"
  if self._groupID == groupID then
    sprite = "N17_task_btn05"
    color = Color.white
  end
  self._text.color = color
  self._btnImg.sprite = self._atlas:GetSprite(sprite)
end
