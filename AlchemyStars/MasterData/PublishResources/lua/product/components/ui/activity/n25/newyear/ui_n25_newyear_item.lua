_class("UIN25NewYearItem", UICustomWidget)
UIN25NewYearItem = UIN25NewYearItem

function UIN25NewYearItem:Constructor()
  self.mRole = GameGlobal.GetModule(RoleModule)
  self.colorTxtCount = Color.white
end

function UIN25NewYearItem:OnShow()
  self.bg = self:GetUIComponent("Image", "bg")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.colorTxtCount = self.txtCount.color
  self.first = self:GetGameObject("first")
  self.atlas = self:GetAsset("UIN25NewYear.spriteatlas", LoadType.SpriteAtlas)
end

function UIN25NewYearItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN25NewYearItem:Flush(roleAsset, funcClick, notShowTips, showNew, newState)
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
  self._notShowTips = notShowTips
end

function UIN25NewYearItem:FormatCount(count)
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

function UIN25NewYearItem:TxtCountRedIfNotEnough(cost)
  local c = self.mRole:GetAssetCount(self.roleAsset.assetid) or 0
  if cost <= c then
    self.txtCount.color = self.colorTxtCount
  else
    self.txtCount.color = Color.red
  end
end

function UIN25NewYearItem:SetNotShowTips(notShowTips)
  self._notShowTips = notShowTips
end

function UIN25NewYearItem:BgOnClick(go)
  if self.funcClick then
    self.funcClick()
  end
end
