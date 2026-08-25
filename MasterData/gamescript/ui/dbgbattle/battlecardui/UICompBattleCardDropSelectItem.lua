local CardDataUtils = require("Data.CardDataUtils")
local UICompBattleCardDropSelectItem, Super = NewViewComponent("UICompBattleCardDropSelectItem")

function UICompBattleCardDropSelectItem:ctor(uiNode, view, onClickCallback)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Battle_Item_CardGroupResource(uiNode)
  self.packIndex = 0
  self.onClickCallback = onClickCallback
end

function UICompBattleCardDropSelectItem:OnEnterComponent()
  if self.onClickCallback then
    self:AddButtonClickListener(self.gameObject, function()
      if self.onClickCallback then
        self.onClickCallback(self.packIndex, self.gameObject)
      end
    end)
  end
end

function UICompBattleCardDropSelectItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function UICompBattleCardDropSelectItem:Refresh(packIndex, packData, isSelected)
  self.packIndex = packIndex
  self.packData = packData
  self.isSelected = isSelected
  local skillTid = packData.showCardId
  local skillCfg = skillTid and SkillCfgUtils.GetCfg(skillTid)
  if self.ui.Text_Name then
    local packName = skillCfg and LT.Text(skillCfg.Name) or ""
    self:SetText(self.ui.Text_Name, packName)
  end
  if self.ui.Image_Icon then
    local icon = skillCfg and skillCfg.Icon or ""
    self:SetImage(self.ui.Image_Icon, icon)
  end
  if self.ui.Image_Select then
    self.ui.Image_Select:SetActive(isSelected)
  end
  if packData.keeperSkillInfos and #packData.keeperSkillInfos > 0 and (not packData.cardUids or 0 == #packData.cardUids) then
    self:_RefreshKeeperSkill(packData)
  else
    self:_RefreshCards(packData)
  end
end

function UICompBattleCardDropSelectItem:_RefreshCards(packData)
  local cardUids = packData.cardUids or {}
  if not self.ui.Group_Cards then
    return
  end
  local itemNum = #cardUids
  if 0 == itemNum then
    self.ui.Group_Cards:SetActive(false)
    return
  end
  self.ui.Group_Cards:SetActive(true)
  local ct = self.ui.Group_Cards.transform
  local cnt = self:ReserveChildren(ct, itemNum)
  local cardMgr = bg.battleRender and bg.battleRender.cardMgr
  for i = 1, itemNum do
    local cardGo = ct:GetChild(i - 1).gameObject
    cardGo:SetActive(true)
    local cardItem = self:AddViewComponentOnce(cardGo, UICompBattleCardDropSelectItem)
    local cardName = ""
    local cardCost = 0
    if cardMgr then
      local card = cardMgr:GetCardByUid(cardUids[i])
      if card then
        cardName = CardDataUtils.GetCardName(card.configId) or ""
        cardCost = card:GetCostText() or 0
      end
    end
    if cardItem.ui.Text_Name then
      cardItem:SetText(cardItem.ui.Text_Name, cardName)
    end
    if cardItem.ui.Text_Expenses then
      cardItem:SetText(cardItem.ui.Text_Expenses, tostring(cardCost))
    end
  end
  for i = itemNum + 1, cnt do
    local go = ct:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

function UICompBattleCardDropSelectItem:_RefreshKeeperSkill(packData)
  local keeperSkillInfos = packData.keeperSkillInfos or {}
  if not self.ui.Group_Cards then
    return
  end
  if 0 == #keeperSkillInfos then
    self.ui.Group_Cards:SetActive(false)
    return
  end
  self.ui.Group_Cards:SetActive(true)
  local ct = self.ui.Group_Cards.transform
  local cnt = self:ReserveChildren(ct, #keeperSkillInfos)
  for i = 1, #keeperSkillInfos do
    local itemGo = ct:GetChild(i - 1).gameObject
    itemGo:SetActive(true)
    local itemComp = self:AddViewComponentOnce(itemGo, UICompBattleCardDropSelectItem)
    local info = keeperSkillInfos[i]
    local skillCfg = info and DT.Skill[info.tid]
    local skillName = skillCfg and LT.Text(skillCfg.Name) or ""
    if itemComp.ui.Text_Name then
      itemComp:SetText(itemComp.ui.Text_Name, skillName)
    end
    if itemComp.ui.Text_Expenses then
      itemComp:SetText(itemComp.ui.Text_Expenses, "")
    end
  end
  for i = #keeperSkillInfos + 1, cnt do
    local go = ct:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
end

return UICompBattleCardDropSelectItem
