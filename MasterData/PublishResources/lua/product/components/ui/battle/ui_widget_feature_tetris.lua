_class("UIWidgetFeatureTetris", UICustomWidget)
UIWidgetFeatureTetris = UIWidgetFeatureTetris

function UIWidgetFeatureTetris:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeatureTetris:InitWidget()
  self._tetrisIconAtlas = self:GetAsset("UIFeatureSkill.spriteatlas", LoadType.SpriteAtlas)
  self._tetrisIconGo = self:GetGameObject("TetrisIcon")
  self._curEnergyGo = self:GetGameObject("CurEnergy")
  self._imageTetrisIcon = self:GetUIComponent("Image", "TetrisIcon")
  self._curEnergyValue = self:GetUIComponent("UILocalizationText", "CurEnergy")
  self:RegisterEvent()
end

function UIWidgetFeatureTetris:RegisterEvent()
  self:AttachEvent(GameEventType.TetrisFeatureRandom, self._OnTetrisRandom)
  self:AttachEvent(GameEventType.TetrisFeatureChangePower, self._OnTetrisPowerChange)
end

function UIWidgetFeatureTetris:_OnTetrisRandom(newTetrisIndex, newTetrisType)
  self:SetTetrisIcon(newTetrisIndex)
end

function UIWidgetFeatureTetris:SetData(initData)
  self._initData = initData
  self._curEnergyGo:SetActive(self._initData:GetPowerEnable())
  self:SetTetrisIcon(self._initData:GetDefaultTetris())
  self:_OnTetrisPowerChange(0)
end

function UIWidgetFeatureTetris:SetTetrisIcon(tetrisIndex)
  local icon = self._initData:GetTetrisSmallIconByIndex(tetrisIndex)
  self._imageTetrisIcon.sprite = self._tetrisIconAtlas:GetSprite(icon)
end

function UIWidgetFeatureTetris:_OnTetrisPowerChange(power)
  self._curEnergyValue:SetText(power)
end

function UIWidgetFeatureTetris:UIWidgetFeatureTetrisOnClick(go)
  if InnerGameHelperRender.IsPuzzleState() or InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    return
  end
  local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
  if coreGameStateID ~= GameStateID.WaitInput then
    return
  end
  self:ShowDialog("UIFeatureTetrisInfo", self._initData)
end
