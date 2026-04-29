_class("UIHomelandMinimapDetailBreedLand", UIHomelandMinimapDetailBase)
UIHomelandMinimapDetailBreedLand = UIHomelandMinimapDetailBreedLand

function UIHomelandMinimapDetailBreedLand:Constructor()
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._atlas = self:GetAsset("UIHomelandMap.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomelandMinimapDetailBreedLand:OnShow(uiParams)
  self:_GetComponents()
end

function UIHomelandMinimapDetailBreedLand:_GetComponents()
  self._titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self._titleRectTransform = self._titleText.transform.parent:GetComponent("RectTransform")
  self._descriptionText = self:GetUIComponent("UILocalizationText", "DescriptionText")
  self._breedIcon = self:GetUIComponent("RawImageLoader", "BreedIcon")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._stateText = self:GetUIComponent("UILocalizationText", "StateText")
  self._stateImg = self:GetUIComponent("Image", "StateImg")
  self._stateImgObj = self:GetGameObject("StateImg")
end

function UIHomelandMinimapDetailBreedLand:CloseBtnOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapCloseDetailUI)
  self:OnClose()
end

function UIHomelandMinimapDetailBreedLand:ConfirmBtnOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapCloseDetailUI)
  self:OnClose()
end

function UIHomelandMinimapDetailBreedLand:OnInitDone()
  local breedLand = self._iconData:GetParam()
  local itemID = breedLand:GetBuildId()
  local cfg = Cfg.cfg_item[itemID]
  self._titleText:SetText(StringTable.Get(cfg.Name))
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._titleRectTransform)
  self._descriptionText:SetText(StringTable.Get(cfg.Intro))
  local curPhases = breedLand:GetCurPhases()
  local breedIcon = cfg.Icon
  local name = StringTable.Get("str_homeland_minimap_freeland")
  local state = StringTable.Get("str_homeland_minimap_freestate")
  local color = Color(0.6549019607843137, 0.6588235294117647, 0.6588235294117647)
  local spriteName
  local cfgTree = breedLand:GetCurTree()
  if cfgTree then
    local cfgItem = Cfg.cfg_item[cfgTree.ID]
    if cfgItem then
      if 0 < curPhases and curPhases <= 2 then
        name = StringTable.Get("str_homeland_exp_source_2")
      end
      if 3 <= curPhases then
        name = StringTable.Get(cfgItem.Name)
        breedIcon = cfgItem.Icon
      end
    end
  end
  if 0 < curPhases then
    local remainTime = breedLand:GetRemainTime()
    if 0 < remainTime then
      color = Color(0.5019607843137255, 0.7372549019607844, 0.34901960784313724)
      spriteName = "n17_dt_ppdk_time"
      state = HomelandBreedTool.GetRemainTime(remainTime)
      state = StringTable.Get("str_homeland_minimap_remain_time", state)
    else
      spriteName = "n17_dt_ppdk_goux"
      color = Color(0.9803921568627451, 0.6666666666666666, 0.1568627450980392)
      state = StringTable.Get("str_homeland_minimap_reapstate")
    end
  end
  self._breedIcon:LoadImage(breedIcon)
  self._name:SetText(name)
  self._stateText:SetText(state)
  self._stateText.color = color
  spriteName = spriteName and self._atlas:GetSprite(spriteName)
  self._stateImg.sprite = spriteName
  self._stateImgObj:SetActive(spriteName ~= nil)
  self._titleRect = self:GetUIComponent("RectTransform", "Title")
  if self._titleRect then
    local titleWidth = self._titleText.preferredWidth
    if 350 < titleWidth then
      titleWidth = 350
    end
    self._titleRect.sizeDelta = Vector2(titleWidth, self._titleRect.sizeDelta.y)
  end
end

function UIHomelandMinimapDetailBreedLand:GetCloseAnimtionName()
  return "UIHomelandMinimapDetailBreedLand_out"
end
