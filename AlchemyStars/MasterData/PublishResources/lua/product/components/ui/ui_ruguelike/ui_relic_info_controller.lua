_class("UIRelicInfoController", UIController)
UIRelicInfoController = UIRelicInfoController

function UIRelicInfoController:OnShow(uiParam)
  self._atlas = self:GetAsset("UIMazeChoose.spriteatlas", LoadType.SpriteAtlas)
  self.ItemColorToTextColor = {
    [ItemColor.ItemColor_White] = Color(0.8117647058823529, 0.8117647058823529, 0.8117647058823529, 1),
    [ItemColor.ItemColor_Green] = Color(0.12549019607843137, 0.8470588235294118, 0.6470588235294118, 1),
    [ItemColor.ItemColor_Blue] = Color(0.21568627450980393, 0.6588235294117647, 1.0, 1),
    [ItemColor.ItemColor_Purple] = Color(0.6980392156862745, 0.5372549019607843, 0.9803921568627451, 1),
    [ItemColor.ItemColor_Yellow] = Color(1.0, 0.9529411764705882, 0.21568627450980393, 1),
    [ItemColor.ItemColor_Golden] = Color(1.0, 0.5568627450980392, 0 / 255, 1)
  }
  self._relicID = uiParam[1]
  if not self._relicID then
    Log.fatal("###error --> maze relic info controller - the uiParam is nil !")
    return
  end
  self:GetComponents()
end

function UIRelicInfoController:GetComponents()
  local relicPool = self:GetUIComponent("UISelectObjectPath", "relicPool")
  local item = relicPool:SpawnObject("UIRugueLikeBackpackItem")
  item:SetData(1, self._relicID, function(tIndex)
  end, false)
  local nameTex = self:GetUIComponent("UILocalizationText", "name")
  local descTex = self:GetUIComponent("UILocalizationText", "desc")
  local colorBg = self:GetUIComponent("Image", "colorDown")
  local cfg = Cfg.cfg_item[self._relicID]
  if cfg then
    nameTex:SetText(StringTable.Get(cfg.Name))
    descTex:SetText(StringTable.Get(cfg.RpIntro))
    colorBg.sprite = self._atlas:GetSprite("map_shengwu_xian" .. cfg.Color)
    local c = Color(1, 1, 1, 1)
    c = self.ItemColorToTextColor[cfg.Color]
    nameTex.color = c
  else
    Log.fatal("###error --> maze relic info controller - the cfg_item is nil ! id --> ", self._relicID)
  end
end

function UIRelicInfoController:bgOnClick()
  self:CloseDialog()
end
