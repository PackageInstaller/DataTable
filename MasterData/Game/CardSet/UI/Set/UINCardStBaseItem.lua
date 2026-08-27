local base = UIBaseNode
local UINCardStBaseItem = class("UINCardStBaseItem", UIBaseNode)
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local cs_MessageCommon = CS.MessageCommon

function UINCardStBaseItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_cardSetCardItem, self, self.__OnClick)
end

function UINCardStBaseItem:InitCSCardBaseItem(cardSetCtrl, cardSetData, cardData, effectId, rootCard)
  self.cardSetCtrl = cardSetCtrl
  self.cardSetData = cardSetData
  self.cardData = cardData
  self._effectId = effectId
  self._rootCard = rootCard
  self:RefreshCSCardPic()
  self:RefreshCSCardAddition()
  self.ui.img_Quality.color = cardData:GetCardStQualityColor(effectId)
  local itemCfg = cardSetData:GetCurCardSetScoreItemCfg()
  self.ui.img_PointIcon.sprite = CRH:GetSprite(itemCfg.small_icon)
  self:UpdCardStBaseItemBan()
  self:_UpdTag()
end

function UINCardStBaseItem:UpdCardStBaseItemBan()
  self.ui.obj_Lock:SetActive(false)
  self.ui.img_Ban:SetActive(false)
  local cardDiffData = self.cardSetData:GetCardSetCurDiffData()
  local banEffectIdDic = cardDiffData:GetCardSetDiffBanEffectDic()
  local banCardIdDic = cardDiffData:GetCardSetDiffBanCardIdDic()
  self._isBan = false
  if banEffectIdDic[self._effectId] or banCardIdDic[self.cardData:GetCardSetCardId()] then
    self._isBan = true
    self.ui.obj_Lock:SetActive(true)
    self.ui.img_Ban:SetActive(true)
  end
end

function UINCardStBaseItem:RefreshCSCardPic()
  local iconRes = self.cardData:GetCardSetCardIcon(self._effectId)
  local resloader = self.cardSetCtrl:GetCardSetResloader()
  self.ui.img_Pic.sprite = AtlasUtil.GetSpriteFromAtlas("CardIcon", iconRes, resloader)
end

function UINCardStBaseItem:_UpdTag()
  local tagCfg = self.cardData:GetCardSetTagCfgFirst(self._effectId)
  if tagCfg == nil then
    self.ui.cardTag:SetActive(false)
    return
  end
  self.ui.cardTag:SetActive(true)
  self.ui.img_Tag.enabled = false
  self.ui.tex_Tag.text.enabled = false
  if tagCfg.tag_type == CardSetEnum.eCardTag.UseMoreTimes then
    local totalNum = tagCfg.tag_para1
    local curNum = totalNum - self.cardData:GetCsCardUsedNum()
    if 1 < curNum then
      self.ui.tex_Tag:SetIndex(0, tostring(curNum))
      self.ui.tex_Tag.text.enabled = true
    else
      self.ui.cardTag:SetActive(false)
    end
    return
  end
  local resloader = self.cardSetCtrl:GetCardSetResloader()
  self.ui.img_Tag.sprite = AtlasUtil.GetSpriteFromAtlas("CardTag", tagCfg.tag_icon, resloader)
  self.ui.img_Tag.enabled = true
end

function UINCardStBaseItem:RefreshCSCardAddition()
  local addNum
  local playType = self.cardSetCtrl:GetCardSetPlayType()
  if playType == CardSetEnum.eSetType.normal or playType == CardSetEnum.eSetType.rewind then
    addNum = self.cardData:GetCardSetCardCoinAddNum(self._effectId)
  elseif playType == CardSetEnum.eSetType.rank then
    addNum = self.cardData:GetCardSetCardScoreAddNum(self._effectId)
  end
  local scoreAdd = self.cardData:GetCardSetTagAddScoreNum(self._effectId)
  addNum = scoreAdd + addNum
  local hasScoreAdd = 0 < scoreAdd
  self.ui.mask.color = self.ui.color_mask[hasScoreAdd and 2 or 1]
  self.ui.tex_Precent:SetIndex(0, tostring(addNum))
end

function UINCardStBaseItem:RefeshIsSelectedCardBaseItem(selectedCard)
  local isSelectEffect = selectedCard and self.cardData:GetCardEffectId() == self._effectId
  self.ui.obj_SelectedUp:SetActive(isSelectEffect)
end

function UINCardStBaseItem:ShowCardSetItemSelectArrow(show)
  self.ui.obj_Arrow.gameObject:SetActive(show)
  if show then
    self.ui.obj_Arrow:SetParent(self.transform)
    self.ui.obj_Arrow.anchoredPosition = Vector2.zero
  end
end

function UINCardStBaseItem:__OnClick()
  if self._isBan then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2213))
    return
  end
  local isSelect = self.cardSetData:GetIsSelectedCard(self.cardData)
  if not isSelect then
    local cardType = self.cardData:GetCardSetCardType(self._effectId)
    local useLimitNum = self.cardSetData:GetCardSetCardHUseLimitNum4Type(cardType)
    local curUseNum = self.cardSetData:GetCardSetSelectCardNum4Type(cardType)
    if useLimitNum <= curUseNum then
      if useLimitNum == 1 then
        local list = self.cardSetData:GetSelectedCardListByType(cardType)
        for _, cardData in pairs(list) do
          self.cardSetData:SetSelectCard(cardData, false)
          MsgCenter:Broadcast(eMsgEventId.OnCardSetCardChange, cardData, false)
        end
      else
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2222))
        return
      end
    end
    self.cardData:SetCardEffectId(self._effectId)
  end
  if isSelect and self.cardData:GetCardEffectId() ~= self._effectId then
    self.cardData:SetCardEffectId(self._effectId)
    self:ShowCardSetItemSelectArrow(true)
    self._rootCard:RefeshIsSelectedCardItem()
    MsgCenter:Broadcast(eMsgEventId.OnCardSetCardEffectIdChange, self.cardData)
  else
    self.cardSetData:SetSelectCard(self.cardData, not isSelect)
    self:ShowCardSetItemSelectArrow(not isSelect)
    MsgCenter:Broadcast(eMsgEventId.OnCardSetCardChange, self.cardData, not isSelect)
  end
  if not isSelect then
    self.cardSetData:TryCheckCsCostOk()
  end
end

function UINCardStBaseItem:OnDelete()
  base.OnDelete(self)
end

return UINCardStBaseItem
