local base = UIBaseNode
local UINHandBookCardItem = class("UINHandBookCardItem", base)

function UINHandBookCardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.CardItem, self, self._OnClickRoot)
end

function UINHandBookCardItem:InitHnadBoolCardItem(cardId, star, isLock, clickFunc, resloder)
  self.cardId = cardId
  self.star = star
  local itemCfg = ConfigData.item[cardId]
  if itemCfg ~= nil then
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(itemCfg.name)
  end
  self._clickFunc = clickFunc
  self.ui.obj_lock:SetActive(isLock)
  self:_UpdStar()
  self:__LoadRfCdBg(resloder, cardId, self.ui.Img_BgPic)
end

function UINHandBookCardItem:_UpdStar()
  self._starPool = self._starPool or UIItemPool.New(UIBaseNode, self.ui.starItem, false)
  self._starPool:HideAll()
  for i = 1, self.star do
    self._starPool:GetOne()
  end
end

function UINHandBookCardItem:__LoadRfCdBg(resloder, cardId, rawImg)
  local cardCfg = ConfigData.reinforce_card_card_main[cardId]
  if cardCfg ~= nil then
    rawImg.enabled = false
    resloder:LoadABAssetAsync(PathConsts:GetReinforceCardBgPath(cardCfg.image), function(texture)
      if IsNull(texture) then
        return
      end
      rawImg.texture = texture
      rawImg.enabled = true
    end)
  end
end

function UINHandBookCardItem:_OnClickRoot()
  if self._clickFunc then
    self._clickFunc(self.cardId, self.star)
  end
end

function UINHandBookCardItem:OnDelete()
  if self._starPool then
    self._starPool:DeleteAll()
  end
  base.OnDelete(self)
end

return UINHandBookCardItem
