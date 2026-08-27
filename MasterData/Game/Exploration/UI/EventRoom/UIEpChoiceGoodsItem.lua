local UIEpChoiceGoodsItem = class("UIEpChoiceGoodsItem", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UIEpChoiceGoodsItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIEpChoiceGoodsItem:ShowWithChipData(data, showCount)
  if self.chipItem == nil then
    self.chipItem = UINChipItem.New()
    self.ui.goodsNode.onPressDown:AddListener(function()
      self:__OnChipItemPress(self.ui.uINChipItem.gameObject, self.chipItem:GetChipData())
    end)
    self.ui.goodsNode.onPressUp:AddListener(BindCallback(self, self.HideFloatingFrame))
  end
  self.ui.buffNode.gameObject:SetActive(false)
  self.chipItem:Init(self.ui.uINChipItem.gameObject)
  self.chipItem:InitChipItem(data, showCount)
  self.chipItem:Show()
end

function UIEpChoiceGoodsItem:__OnChipItemPress(item, chipData)
  if chipData == nil then
    return
  end
  local name = chipData:GetName()
  local describe = chipData:GetChipDescription()
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(LanguageUtil.GetLocaleText(name), LanguageUtil.GetLocaleText(describe))
  win:FloatTo(item.transform, HAType.right, VAType.down)
end

function UIEpChoiceGoodsItem:ShowWithBuffData(buffId)
  local buffCfg = ConfigData.exploration_buff[buffId]
  self._buffCfg = buffCfg
  self.ui.buffNode.sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
  self.ui.buffNode.gameObject:SetActive(true)
  if self.chipItem ~= nil then
    self.chipItem:Hide()
  end
  if not self._InitBuffListener then
    self.ui.goodsNode.onPressDown:AddListener(function()
      self:ShowBuffDescription(self.ui.buffNode, self._buffCfg)
    end)
    self.ui.goodsNode.onPressUp:AddListener(BindCallback(self, self.HideFloatingFrame))
    self._InitBuffListener = true
  end
end

function UIEpChoiceGoodsItem:ShowBuffDescription(item, buffCfg)
  local window = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if window == nil or not window.active then
    window = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
    window:SetTitleAndContext(LanguageUtil.GetLocaleText(buffCfg.name), LanguageUtil.GetLocaleText(buffCfg.describe))
    window:FloatTo(item.transform, HAType.right, VAType.down)
  end
end

function UIEpChoiceGoodsItem:SetLayOutElementEnable(bEnable)
  self.ui.layoutNode.enabled = bEnable
end

function UIEpChoiceGoodsItem:HideFloatingFrame()
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UIEpChoiceGoodsItem:OnDelete()
  base.OnDelete(self)
  if self.chipItem ~= nil then
    self.chipItem:OnDelete()
  end
end

return UIEpChoiceGoodsItem
