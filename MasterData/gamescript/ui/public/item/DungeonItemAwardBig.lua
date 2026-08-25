local DungeonItemAwardBig, Super = System.NewComponent("DungeonItemAwardBig")

function DungeonItemAwardBig:ctor(uiNode, itemInfo)
  Super.ctor(self)
  self.ui = UI_Dungeons_Item_Award_Article_BigResource(uiNode)
  self.itemInfo = itemInfo
end

function DungeonItemAwardBig:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(DungeonItemAwardModel, self.itemInfo)
  local model = self.model
  binder:BindToRaw(function(itemBinder, nVal)
    local itemTid = nVal[1]
    local overflowTid
    local nUid = nVal[2]
    local itemCount
    local itemCfg = DT.Item[itemTid]
    local itemInfo = self.itemInfo
    if itemCfg.Type == "DropItem" or self:_ShowWeaponLevel() then
      itemCount = ""
    elseif self:CheckIsSpecialNormalAward() then
      itemCount = itemInfo.num * itemInfo.multipleNum
    else
      itemCount = itemInfo.num
    end
    if itemInfo.overflow and itemInfo.reason == cd.ItemReason.UseItem then
      overflowTid = itemTid
      itemTid = itemInfo.overflow.tid
    end
    local effectiveAwardType = self:CheckIsSpecialNormalAward() and CommonDefine.ItemAwardType.FirstMult or itemInfo.type
    local itemAwardTypeDescMap = CommonDefine.ItemAwardType2TagMap()
    local hasAwardTag = effectiveAwardType and effectiveAwardType ~= CommonDefine.ItemAwardType.Normal
    local itemData = {
      itemTid = itemTid,
      itemCount = itemCount,
      isGot = itemInfo.isGot == true,
      extraOrigin = itemInfo.extraOrigin,
      extraDescFunc = itemInfo.extraDescFunc,
      extraDescBgType = itemInfo.extraDescBgType,
      extraDesc = itemInfo.extraDesc or hasAwardTag and itemAwardTypeDescMap[effectiveAwardType] or nil,
      itemAwardTypeDesc = itemInfo.itemAwardTypeDesc,
      clickFunc = function()
        if ItemDataUtils.GetItemType(itemTid) == CommonDefine.ItemType.AwakerItem then
          local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
          AwakerDataUtils.JumpToSingleAwakerPanel(CommonDefine.AwakerPage.Detail, awakerTid)
          return
        end
        ItemDataUtils.ShowItemDetailTips(itemBinder, self.ui.UI_Common_Item_WuPin_Type2, nUid, itemTid)
      end
    }
    itemBinder:BindComponent(CommonIconItemType2(self.ui.UI_Common_Item_WuPin_Type2, itemData))
    itemBinder:BindToText(self.ui.Text_Name, function()
      local cfg = DT.Item[itemTid]
      return cfg.Name or ""
    end)
    itemBinder:SetActive(self.ui.Group_OverFlow, nil ~= overflowTid)
    if overflowTid then
      itemBinder:SetImage(self.ui.Image_OverflowItem, ItemDataUtils.GetIcon(overflowTid))
      itemBinder:SetText(self.ui.Text_OverFlow, LT.Text("ConvertedToFragment"))
    end
    AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name, 0, 0, 0, nil, true)
  end, function()
    return {
      model.itemInfo.tid,
      model.itemInfo.uid,
      model.itemInfo.num,
      model.itemInfo.type
    }
  end)
  binder:BindToVisible(self.ui.Text_Name, function()
    return model.itemInfo.showName
  end)
  binder:BindToVisible(self.ui.Group_Down, function()
    do return self._ShowWeaponLevel end
    return self._ShowWeaponLevel, self
  end)
  binder:BindToRaw(function(childBinder, level)
    local refineStage1MaxLevel = DT.GetConstant("WeaponRefineSkillParaNum")
    local numStars = math.min(level, refineStage1MaxLevel)
    for i = 1, 5 do
      local obj = self.ui["Star_" .. i]
      if obj then
        childBinder:SetActive(obj, i <= numStars)
      end
    end
    if level > refineStage1MaxLevel then
      self.ui.Image_Max:SetActive(true)
      childBinder:SetText(self.ui.Text_Max, level - refineStage1MaxLevel)
    else
      self.ui.Image_Max:SetActive(false)
    end
  end, function()
    local showWeaponLevel = self:_ShowWeaponLevel()
    if not showWeaponLevel then
      return 0
    end
    local itemData = ItemDataUtils.GetItemByUid(self.itemInfo.uid)
    return itemData and itemData.level or 0
  end)
end

function DungeonItemAwardBig:_ShowWeaponLevel()
  local itemType = ItemDataUtils.GetItemType(self.itemInfo.tid)
  if itemType ~= CommonDefine.ItemType.Weapon then
    return false
  end
  return self.itemInfo.showWeaponLevel
end

function DungeonItemAwardBig:SetItemTid(tid)
  self.model:SetConfigId(tid)
end

function DungeonItemAwardBig:SetItemUid(uid)
  self.model:SetUid(uid)
end

function DungeonItemAwardBig:SetNumText(num)
  self.model:SetNum(num)
end

function DungeonItemAwardBig:SetItemType(type)
  self.model:SetType(type)
end

function DungeonItemAwardBig:SetVisible(visible)
  self.ui.uiNode:SetActive(visible)
end

function DungeonItemAwardBig:CheckAwardType(type)
  return self.model.itemInfo.type == type
end

function DungeonItemAwardBig:CheckIsSpecialNormalAward()
  return self:CheckAwardType(CommonDefine.ItemAwardType.Normal) and self.model.itemInfo.isFirst and self.model.itemInfo.isFirst == true and self.model.itemInfo.multipleNum and self.model.itemInfo.multipleNum > 1
end

return DungeonItemAwardBig
