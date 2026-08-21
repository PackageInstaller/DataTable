_class("UIHauteItem", UICustomWidget)
UIHauteItem = UIHauteItem

function UIHauteItem:Constructor()
  self.mRole = GameGlobal.GetModule(RoleModule)
  self.colorTxtCount = Color.white
end

function UIHauteItem:OnShow()
  self.bg = self:GetUIComponent("Image", "bg")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.colorTxtCount = self.txtCount.color
  self._goumaiObj = self:GetGameObject("goumai")
  self.first = self:GetGameObject("first")
  self.atlas = self:GetAsset("UIHauteCoutureKL.spriteatlas", LoadType.SpriteAtlas)
end

function UIHauteItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIHauteItem:Flush(roleAsset, funcClick, showTips)
  self.roleAsset = roleAsset
  local icon = ""
  local color = 1
  local count = 0
  if roleAsset.exp then
    icon = ""
    color = 6
    count = roleAsset.count
  else
    local cfg = Cfg.cfg_item[roleAsset.assetid]
    icon = cfg.Icon
    color = cfg.Color
    count = roleAsset.count
  end
  self.imgIcon:LoadImage(icon)
  self.bg.sprite = self.atlas:GetSprite("N17_produce_bg_item_" .. color)
  self.txtCount:SetText(self:FormatCount(count))
  self.first:SetActive(roleAsset.first ~= nil)
  self.funcClick = funcClick
  self._showTips = showTips
  self._goumaiObj:SetActive(self._showTips)
end

function UIHauteItem:FormatCount(count)
  if not count or count == "" then
    return ""
  end
  if 999999 < count then
    local c = math.floor(count * 1.0E-4)
    return StringTable.Get("str_homeland_backpack_n_w", c)
  elseif 99999 < count then
    local c = math.floor(count * 0.001) * 0.1
    return StringTable.Get("str_homeland_backpack_n_w", c)
  end
  return tostring(count)
end

function UIHauteItem:TxtCountRedIfNotEnough(cost)
  local c = self.mRole:GetAssetCount(self.roleAsset.assetid) or 0
  if cost <= c then
    self.txtCount.color = self.colorTxtCount
  else
    self.txtCount.color = Color.red
  end
end

function UIHauteItem:SetNotShowTips(notShowTips)
  self._notShowTips = notShowTips
end

function UIHauteItem:BgOnClick(go)
  if self.funcClick then
    self.funcClick(go)
  end
  if not self._notShowTips then
  end
end
