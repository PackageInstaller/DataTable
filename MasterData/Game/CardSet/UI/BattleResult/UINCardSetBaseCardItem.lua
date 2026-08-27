local base = UIBaseNode
local UINCardSetBaseCardItem = class("UINCardSetBaseCardItem", base)
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")

function UINCardSetBaseCardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_Root.onPress:AddListener(BindCallback(self, self._OnBtnLongPress))
  self.ui.btn_Root.onPressUp:AddListener(BindCallback(self, self._OnBtnPressUp))
  self.ui.btn_Root.onClick:AddListener(BindCallback(self, self._OnBtnClick))
end

function UINCardSetBaseCardItem:InitCardSetBaseCardItem(cardData, resloader, longPressFunc, pressUpFunc)
  self._cardData = cardData
  self._resloader = resloader
  local iconRes = cardData:GetCardSetCardIcon()
  self.ui.img_Pic.sprite = AtlasUtil.GetSpriteFromAtlas("CardIcon", iconRes, resloader)
  self._longPressFunc = longPressFunc
  self._pressUpFunc = pressUpFunc
  self:_UpdTag()
end

function UINCardSetBaseCardItem:_UpdTag()
  local tagCfg = self._cardData:GetCardSetTagCfgFirst()
  if tagCfg == nil then
    self.ui.cardTag:SetActive(false)
    return
  end
  self.ui.cardTag:SetActive(true)
  self.ui.img_Tag.enabled = false
  self.ui.tex_Tag.text.enabled = false
  if tagCfg.tag_type == CardSetEnum.eCardTag.UseMoreTimes then
    local totalNum = tagCfg.tag_para1
    local curNum = totalNum - self._cardData:GetCsCardUsedNum()
    if 1 < curNum then
      self.ui.tex_Tag:SetIndex(0, tostring(curNum))
      self.ui.tex_Tag.text.enabled = true
    else
      self.ui.cardTag:SetActive(false)
    end
    return
  end
  self.ui.img_Tag.sprite = AtlasUtil.GetSpriteFromAtlas("CardTag", tagCfg.tag_icon, self._resloader)
  self.ui.img_Tag.enabled = true
end

function UINCardSetBaseCardItem:SetCardSetBaseCardItemClickFunc(clickFunc)
  self._clickFunc = clickFunc
end

function UINCardSetBaseCardItem:_OnBtnClick()
  if self._clickFunc ~= nil then
    self._clickFunc(self, self._cardData)
  end
end

function UINCardSetBaseCardItem:_OnBtnLongPress()
  if self._longPressFunc ~= nil then
    self._longPressFunc(self, self._cardData)
  end
end

function UINCardSetBaseCardItem:_OnBtnPressUp()
  if self._longPressFunc ~= nil then
    self._pressUpFunc(self, self._cardData)
  end
end

function UINCardSetBaseCardItem:OnDelete()
  base.OnDelete(self)
end

return UINCardSetBaseCardItem
