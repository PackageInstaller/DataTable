local CompPublicDungeonAwardBigItem, Super = NewViewComponent("CompPublicDungeonAwardBigItem")

function CompPublicDungeonAwardBigItem:ctor(uiNode, view, itemInfo)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Award_Article_BigResource(uiNode)
  self.itemInfo = itemInfo
end

function CompPublicDungeonAwardBigItem:OnEnterComponent()
  if self.itemInfo.overflow and self.itemInfo.reason == cd.ItemReason.UseItem then
    self.overflowTid = self.itemInfo.tid
    self.itemTid = self.itemInfo.overflow.tid
  else
    self.itemTid = self.itemInfo.tid
  end
  self.itemCfg = DT.Item[self.itemTid]
  self:_InitCommonItemTypeComp()
  self:SetText(self.ui.Text_Name, LT.Text(self.itemCfg.Name or ""))
  self.ui.Text_Name:SetActive(self.itemInfo.showName)
  self:_HandleOverflowDisplay()
  self:_HandleWeaponLevelDisplay()
  AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name, 0, 0, 0, nil, true)
end

function CompPublicDungeonAwardBigItem:_HandleOverflowDisplay()
  if self.overflowTid then
    self.ui.Group_OverFlow:SetActive(true)
    self:SetImage(self.ui.Image_OverflowItem, ItemDataUtils.GetIcon(self.overflowTid))
    self:SetText(self.ui.Text_OverFlow, LT.Text("ConvertedToFragment"))
  else
    self.ui.Group_OverFlow:SetActive(false)
  end
end

function CompPublicDungeonAwardBigItem:_HandleWeaponLevelDisplay()
  if not self:_ShowWeaponLevel() then
    self.ui.Group_Down:SetActive(false)
    return
  end
  self.ui.Group_Down:SetActive(true)
  local itemData = ItemDataUtils.GetItemByUid(self.itemInfo.uid)
  local level = itemData and itemData.level or 0
  local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
  local numStars = math.min(level, refineStage1MaxLevel)
  for i = 1, 5 do
    local obj = self.ui["Star_" .. i]
    if obj then
      obj:SetActive(i <= numStars)
    end
  end
  if level > refineStage1MaxLevel then
    self.ui.Image_Max:SetActive(true)
    self:SetText(self.ui.Text_Max, level - refineStage1MaxLevel)
  else
    self.ui.Image_Max:SetActive(false)
  end
end

function CompPublicDungeonAwardBigItem:_ShowWeaponLevel()
  local itemType = ItemDataUtils.GetItemType(self.itemTid)
  if itemType ~= CommonDefine.ItemType.Weapon then
    return false
  end
  return self.itemInfo.showWeaponLevel
end

function CompPublicDungeonAwardBigItem:_InitCommonItemTypeComp()
  local tid, uid = self.itemTid, self.itemInfo.uid
  local num, multipleNum = self.itemInfo.num, self.itemInfo.multipleNum
  local itemInfo = self.itemInfo
  local itemCount
  if self.itemCfg.Type == "DropItem" or self:_ShowWeaponLevel() then
    itemCount = ""
  elseif self:CheckIsSpecialNormalAward() then
    itemCount = num * multipleNum
  else
    itemCount = num
  end
  local effectiveAwardType = self:CheckIsSpecialNormalAward() and CommonDefine.ItemAwardType.FirstMult or itemInfo.type
  local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
  local hasAwardTag = effectiveAwardType and effectiveAwardType ~= CommonDefine.ItemAwardType.Normal
  local viewData = {
    itemTid = tid,
    itemCount = itemCount,
    isGot = itemInfo.isGot == true,
    extraOrigin = itemInfo.extraOrigin,
    extraDesc = itemInfo.extraDesc or hasAwardTag and itemAwardTypeDescMap[effectiveAwardType] or nil,
    extraDescBgType = itemInfo.extraDescBgType,
    itemAwardTypeDesc = itemInfo.itemAwardTypeDesc,
    clickFunc = function()
      local displayTid = tid
      if self.overflowTid then
        displayTid = self.overflowTid
      end
      if ItemDataUtils.GetItemType(displayTid) == CommonDefine.ItemType.AwakerItem then
        local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(displayTid)
        AwakerDataUtils.JumpToSingleAwakerPanel(CommonDefine.AwakerPage.Detail, awakerTid)
        return
      end
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.UI_Common_Item_WuPin_Type2, uid, displayTid)
    end
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Item_WuPin_Type2, CompPublicIconItemType2, viewData)
end

function CompPublicDungeonAwardBigItem:CheckIsSpecialNormalAward()
  return self:CheckAwardType(CommonDefine.ItemAwardType.Normal) and self.itemInfo.isFirst and self.itemInfo.isFirst == true and self.itemInfo.multipleNum and self.itemInfo.multipleNum > 1
end

function CompPublicDungeonAwardBigItem:CheckAwardType(type)
  return self.itemInfo.type == type
end

function CompPublicDungeonAwardBigItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicDungeonAwardBigItem
