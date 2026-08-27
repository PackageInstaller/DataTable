local UIEpEventChoiceItem = class("UIEpEventChoiceItem", UIBaseNode)
local base = UIBaseNode
local ChipData = require("Game.PlayerData.Item.ChipData")
local EpCommonUtil = require("Game.Exploration.Util.EpCommonUtil")

function UIEpEventChoiceItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_choiceItem, self, self.OnChoiceItemClick)
end

function UIEpEventChoiceItem:InitEventChoiceItem(choiceData, clickAction, hideGoodsNode)
  self.idx = choiceData.idx
  self.choiceId = choiceData.choiceId
  self.catId = choiceData.catId
  self.choiceData = choiceData
  self.cfg = choiceData.cfg
  self.hideGoodsNode = hideGoodsNode
  self.onClickAction = clickAction
end

function UIEpEventChoiceItem:RefreshChoiceUI(displayGetNewData)
  self.ui.tex_Describe.text = EpCommonUtil.GetEventReplaceText(self.cfg, "describe")
  self.ui.img_Icon.sprite = CRH:GetSprite(self.cfg.icon, CommonAtlasType.ExplorationIcon)
  self.ui.tex_Describe.color = self.cfg.choice_color and Color.white or Color.black
  self.ui.img_IconBg.color = self.cfg.choice_color and Color.New(1, 1, 1, 0.3) or Color.New(0, 0, 0, 0.7)
  self.ui.img_Buttom:SetIndex(self.cfg.choice_color and 1 or 0)
  self:__SetChipItem(displayGetNewData)
  if self.choiceData.isAble ~= nil then
    self:SetItemCanClick(self.choiceData.isAble)
  end
  self:RefreshIsUesed()
end

function UIEpEventChoiceItem:RefreshIsUesed()
  if self.choiceData.isUesed ~= nil then
    self.ui.obj_isUesed:SetActive(self.choiceData.isUesed)
  end
end

function UIEpEventChoiceItem:SetItemCanClick(isAble)
  self.isAble = isAble
  local color = isAble and Color.white or self.ui.col_CantSelect
  self.ui.img_Buttom.image.color = color
  self.ui.img_Icon.color = color
  self.ui.ani_Select:SetActive(isAble)
end

function UIEpEventChoiceItem:OnChoiceItemClick()
  if self.onClickAction ~= nil then
    self.onClickAction(self.cfg, self.idx, self.isAble, self.catId)
  end
end

function UIEpEventChoiceItem:__SetChipItem(displayGetNewData)
  self.chipData = nil
  if displayGetNewData == nil or self.hideGoodsNode then
    return
  end
  if self.extraItemPool == nil then
    return
  end
  if displayGetNewData.type == eEpEvtChoiceGetNewType.item then
    if ConfigData:GetItemType(displayGetNewData.dataId) == eItemType.GlobalChip then
      self.goodsItem = self.extraItemPool:GetOne()
      self.goodsItem.transform:SetParent(self.transform)
      if displayGetNewData.dataNum > 1 then
        self.chipData = ChipData.New(displayGetNewData.dataId, displayGetNewData.dataNum)
      else
        self.chipData = ChipData.NewChipForLocal(displayGetNewData.dataId)
      end
      self.goodsItem:ShowWithChipData(self.chipData, false)
      self.goodsItem:Show()
    end
  elseif displayGetNewData.type == eEpEvtChoiceGetNewType.expBuff then
    self.goodsItem = self.extraItemPool:GetOne()
    self.goodsItem.transform:SetParent(self.transform)
    self.goodsItem:ShowWithBuffData(displayGetNewData.dataId)
    self.goodsItem:Show()
  end
  if self.goodsItem ~= nil then
    if self.isLimitExtraItem then
      self.goodsItem:SetLayOutElementEnable(true)
    else
      self.goodsItem:SetLayOutElementEnable(false)
    end
  end
end

function UIEpEventChoiceItem:InjectExtraItemPool(extraItemPool)
  self.extraItemPool = extraItemPool
end

function UIEpEventChoiceItem:IsNeedExtraItemLimitWidth(bValue)
  self.isLimitExtraItem = bValue
end

function UIEpEventChoiceItem:GetAutoTipsHolder()
  return self.ui.autoTipsHolder
end

function UIEpEventChoiceItem:SetParent(transform)
  self.transform:SetParent(transform)
end

function UIEpEventChoiceItem:OnHide()
  if self.goodsItem ~= nil then
    self.goodsItem:Hide()
    self.goodsItem = nil
  end
end

function UIEpEventChoiceItem:OnDelete()
  if self.goodsItem ~= nil then
    self.goodsItem:OnDelete()
  end
  base.OnDelete(self)
end

return UIEpEventChoiceItem
