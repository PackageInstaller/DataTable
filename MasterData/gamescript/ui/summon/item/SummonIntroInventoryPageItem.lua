local GameObject = CS.UnityEngine.GameObject
local SummonIntroInventoryPageItem, Super = System.NewComponent("SummonIntroInventoryPageItem")
local SPACE = 24
local CELLCOUNT_PER_ROW = 9

function SummonIntroInventoryPageItem:ctor(uiNode, inventory)
  Super.ctor(self)
  self.ui = UI_Summon_Item_ProbabilityResource(uiNode)
  self.inventory = inventory
end

function SummonIntroInventoryPageItem:OnBind(binder)
  binder:SetText(self.ui.Text_Title, self.inventory.title)
  binder:SetText(self.ui.Text_Desc, self.inventory.desc)
  self.ui.Cell_Template:SetActive(false)
  local cellRootTrans = self.ui.Root_Cells.transform
  local sizeDelta = self.ui.Cell_Template.transform.sizeDelta
  for index, cellData in ipairs(self.inventory.cells) do
    local cellGO = GameObject.Instantiate(self.ui.Cell_Template, cellRootTrans).gameObject
    cellGO:SetActive(true)
    local upTF = cellGO.transform:Find("Text_Up")
    local upGO = upTF and upTF.gameObject
    if upGO then
      upGO:SetActive(cellData.showTagType and 1 == cellData.showTagType or false)
    end
    local limitTF = cellGO.transform:Find("Text_Limit")
    local limitGO = limitTF and limitTF.gameObject
    if limitGO then
      limitGO:SetActive(cellData.showTagType and 2 == cellData.showTagType or false)
      binder:SetText(limitGO, LT.Text("SummonLimitDesc"))
    end
    local itemGO = cellGO.transform:Find("Group_Item/Icon_Article").gameObject
    local QualityGo = cellGO.transform:Find("Group_Item/Image_Quality").gameObject
    local RateGo = cellGO.transform:Find("Group_Item/Text_Article_Number").gameObject
    binder:SetImage(itemGO, ItemDataUtils.GetIcon(cellData.tid))
    binder:SetImage(QualityGo, ItemDataUtils.GetQualityIcon(cellData.tid))
    binder:SetText(RateGo, cellData.text)
    binder:BindButtonClick(cellGO, function()
      ItemDataUtils.ShowItemDetailTips(binder, cellGO, nil, cellData.tid)
    end)
    local idx = index - 1
    local row = math.floor(idx / CELLCOUNT_PER_ROW)
    local col = idx % CELLCOUNT_PER_ROW
    CS.Framework.TransformUtil.SetAnchoredPos(cellGO.transform, (sizeDelta.x + SPACE) * col, (sizeDelta.y + SPACE) * row * -1)
  end
  self.ui.Text_Desc.transform.anchoredPosition = CS.UnityEngine.Vector2(0, -self:GetCellsHeight())
end

function SummonIntroInventoryPageItem:GetCellsHeight()
  local cellCount = math.ceil(#self.inventory.cells / CELLCOUNT_PER_ROW)
  local cellHeight = self.ui.Cell_Template.transform.sizeDelta.y * cellCount
  local spaceHeight = (cellCount - 1) * SPACE
  return cellHeight + spaceHeight + 113
end

return SummonIntroInventoryPageItem
