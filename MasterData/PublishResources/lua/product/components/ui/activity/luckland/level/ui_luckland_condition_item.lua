_class("UILuckLandConditionItem", UICustomWidget)
UILuckLandConditionItem = UILuckLandConditionItem

function UILuckLandConditionItem:OnShow(uiParams)
  self._atlas = self:GetAsset("LuckLand.spriteatlas", LoadType.SpriteAtlas)
  self:_InitWidget()
end

function UILuckLandConditionItem:_InitWidget()
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
  self._isDone = self:GetUIComponent("Image", "IsDone")
end

function UILuckLandConditionItem:SetData(index, id, passInfo, fromInner)
  self._index = index
  self._desc:SetText(self:_ThreeConditionParse(id))
  local isDone = false
  if passInfo then
    if fromInner then
      isDone = passInfo.cur_star & 1 << index - 1 > 0
    else
      isDone = 0 < passInfo.star & 1 << index - 1
    end
  end
  if isDone then
    self._isDone.sprite = self._atlas:GetSprite("n11_gqxq_di06")
  else
    self._isDone.sprite = self._atlas:GetSprite("n11_gqxq_di05")
  end
end

function UILuckLandConditionItem:_ThreeConditionParse(id)
  local str = ""
  local cfg = Cfg.cfg_luckland_client_threestarcondition[id]
  if cfg then
    if cfg.Type == LuckLandThreeStarType.Score then
      str = StringTable.Get(cfg.Name, cfg.Value[1])
    elseif cfg.Type == LuckLandThreeStarType.BuildingLevel then
      local buildingID = cfg.Value[1]
      local buildingLevel = cfg.Value[2]
      local buildingCfg = Cfg.cfg_luckland_client_build[buildingID]
      local buildingName = ""
      if buildingCfg then
        str = StringTable.Get(cfg.Name, StringTable.Get(buildingCfg.BuildName), buildingLevel)
      else
        str = StringTable.Get(cfg.Name, buildingName, buildingLevel)
      end
    elseif cfg.Type == LuckLandThreeStarType.HP then
      str = StringTable.Get(cfg.Name, cfg.Value[1])
    end
  end
  return str
end
