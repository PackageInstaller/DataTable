_class("UISeasonItemS4", UICustomWidget)
UISeasonItemS4 = UISeasonItemS4

function UISeasonItemS4:Constructor()
  self.mRole = GameGlobal.GetModule(RoleModule)
  self.colorTxtCount = Color.white
end

function UISeasonItemS4:OnShow()
  self._trans = self:GetGameObject()
  self.bg = self:GetUIComponent("Image", "bg")
  self.bgGo = self:GetGameObject("bg")
  self.quality = self:GetUIComponent("Image", "quality")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.colorTxtCount = self.txtCount.color
  self.first = self:GetGameObject("first")
  self.atlas = self:GetAsset("UIS4Scene.spriteatlas", LoadType.SpriteAtlas)
  self.rect = self:GetUIComponent("RectTransform", "rect")
end

function UISeasonItemS4:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UISeasonItemS4:Flush(roleAsset, funcClick, notShowTips)
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
  self.quality.sprite = self.atlas:GetSprite("exp_s4_map_daoju_pinji0" .. color)
  self.txtCount:SetText(self:FormatCount(count))
  self.first:SetActive(roleAsset.first ~= nil)
  self.funcClick = funcClick
  self._notShowTips = notShowTips
end

function UISeasonItemS4:SetFin(show)
  self:GetGameObject("_fin"):SetActive(show)
end

function UISeasonItemS4:FormatCount(count)
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

function UISeasonItemS4:TxtCountRedIfNotEnough(cost)
  local c = self.mRole:GetAssetCount(self.roleAsset.assetid) or 0
  if cost <= c then
    self.txtCount.color = self.colorTxtCount
  else
    self.txtCount.color = Color.red
  end
end

function UISeasonItemS4:SetNotShowTips(notShowTips)
  self._notShowTips = notShowTips
end

function UISeasonItemS4:BtnOnClick(go)
  if self.funcClick then
    self.funcClick()
  end
  if not self._notShowTips then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, self.roleAsset.assetid, self._trans.transform.position)
  end
end

function UISeasonItemS4:GetBtn()
  return self.bgGo
end

function UISeasonItemS4:SetRect(scale)
  self.rect.localScale = Vector3(scale, scale, scale)
end
