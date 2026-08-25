local UIAnimationController = CS.Z1Client.UIAnimationController
local SummonResultExtraItemInfo, Super = System.NewComponent("SummonResultExtraItemInfo")
local itemInfoTitleMap = {
  Summon = LT.Text("SummonExtraItem"),
  AutoDecompose = LT.Text("SummonAutoDecomposeItem")
}

function SummonResultExtraItemInfo:ctor(uiNode)
  Super.ctor(self)
  self.ui = UI_Summon_Item_Side_TipResource(uiNode)
end

function SummonResultExtraItemInfo:OnBind(binder)
  self.binder = binder
end

function SummonResultExtraItemInfo:CalcDisplayInfo(extraItem, awakerFragmentCount)
  local itemCfg = DT.Item[extraItem.tid]
  if itemCfg.Type == CommonDefine.ItemType.AwakerItem then
    local awakerTid = itemCfg.SpParam[1]
    if not awakerFragmentCount then
      return "ClipItem", awakerTid, extraItem.changedNum
    else
      local fragmentCount = awakerFragmentCount[awakerTid]
      local fragmentCountLimit = DT.GetConstant("AwakerChipMaxOwnedNum")
      if fragmentCount < fragmentCountLimit then
        awakerFragmentCount[awakerTid] = fragmentCount + extraItem.changedNum
        return "ClipItem", awakerTid, extraItem.changedNum
      else
        local data = DT.Constant.AwakerChipOverflowTransform.Data
        local itemTid = data[1]
        local itemCount = {
          Orange = data[2],
          Purple = data[3],
          Blue = data[4]
        }
        local awakerCfg = DT.AwakerConfig[awakerTid]
        return "ClipItemTrans", DT.Item[itemTid], itemCount[awakerCfg.Quality]
      end
    end
  else
    return "Item", itemCfg, extraItem.changedNum, extraItem.reason
  end
end

function SummonResultExtraItemInfo:Display(extraItem, awakerFragmentCount)
  local itemCfg = DT.Item[extraItem.tid]
  if itemCfg.Type == CommonDefine.ItemType.AwakerItem then
    local awakerTid = itemCfg.SpParam[1]
    if not awakerFragmentCount then
      self:DisplayAwakerClipItem(awakerTid, extraItem.changedNum, extraItem.reason)
    else
      local fragmentCount = awakerFragmentCount[awakerTid]
      local fragmentCountLimit = DT.GetConstant("AwakerChipMaxOwnedNum")
      if fragmentCount < fragmentCountLimit then
        self:DisplayAwakerClipItem(awakerTid, extraItem.changedNum, extraItem.reason)
        awakerFragmentCount[awakerTid] = fragmentCount + extraItem.changedNum
      else
        local data = DT.Constant.AwakerChipOverflowTransform.Data
        local itemTid = data[1]
        local itemCount = {
          Orange = data[2],
          Purple = data[3],
          Blue = data[4]
        }
        local awakerCfg = DT.AwakerConfig[awakerTid]
        self:DisplayAwakerClipItemTransform(DT.Item[itemTid], itemCount[awakerCfg.Quality], extraItem.reason)
      end
    end
  else
    self:DisplayItem(itemCfg, extraItem.changedNum, extraItem.reason)
  end
end

function SummonResultExtraItemInfo:_DisplayAwakerClip(itemCfg, count)
  self.ui.Image_Article_Icon:SetActive(false)
  self.ui.Group_Head:SetActive(true)
  local fragment = CommonDefine.SummonItemFragment[itemCfg.Quality]
  self.binder:SetImage(self.ui.Image_Awaker_Head, fragment)
  self.binder:SetText(self.ui.Text_Note, LT.Text("SummonRepetitiveAwaker"))
  self.binder:SetText(self.ui.Text_Desc, ItemNumUtils.GetNextLineStr(LT.Textf("AwakerFragment", itemCfg.Name), count))
end

function SummonResultExtraItemInfo:DisplayAwakerClipItem(awakerTid, count, reason)
  local clipItemTid = DT.AwakerConfig[awakerTid].AwakerSpecialItem
  local clipItemCfg = DT.Item[clipItemTid]
  self:DisplayItem(clipItemCfg, count, reason)
  self.binder:SetText(self.ui.Text_Note, LT.Text("SummonRepetitiveAwaker"))
end

function SummonResultExtraItemInfo:DisplayAwakerClipItemTransform(itemCfg, count, reason)
  self:DisplayItem(itemCfg, count, reason)
  self.binder:SetText(self.ui.Text_Note, LT.Text("SummonRepetitiveAwaker"))
end

function SummonResultExtraItemInfo:DisplayItem(itemCfg, count, reason)
  self.ui.Group_Head:SetActive(false)
  self.ui.Image_Article_Icon:SetActive(true)
  self.binder:SetImage(self.ui.Image_Article_Icon, itemCfg.Icon)
  self.binder:SetText(self.ui.Text_Note, itemInfoTitleMap[reason])
  self.binder:SetText(self.ui.Text_Desc, ItemNumUtils.GetNextLineStr(LT.Text(itemCfg.Name), count))
  local animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  animController:PlayMultiState("UI_Summon_Item_Side_Tip_Open", nil, 1, false)
end

return SummonResultExtraItemInfo
