local GuideNoteTierRewardTipView, Super = NewClass("GuideNoteTierRewardTipView", BaseView)
GuideNoteTierRewardTipView.uiResCls = "UI/UI_GuideNote/UI_GuideNote_Prefab/UI_GuideNote_Tip_Reward.prefab"

function GuideNoteTierRewardTipView:ctor(anchorGo, rewardList, shiftX, shiftY)
  Super.ctor(self)
  self._anchorGo = anchorGo
  self._rewardList = self:_GetSortedRewardList(rewardList or {})
  self._shiftX = shiftX or 0
  self._shiftY = shiftY or 0
  self._spawnedItems = {}
end

function GuideNoteTierRewardTipView:RegisterEvents()
  self:AddUICustomInputlistener(self.ui.uiNode, function(hover)
    if not hover then
      if ItemDetailsController.Instance:IsItemDetailTipsShowing() then
        return
      end
      self:Close()
    end
  end)
end

function GuideNoteTierRewardTipView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshRewardItems()
  self:_SetTipPosition()
end

function GuideNoteTierRewardTipView:OnExitView()
  self:_ClearSpawnedItems()
  Super.OnExitView(self)
end

function GuideNoteTierRewardTipView:SetRendered(isRendered)
  Super.SetRendered(self, isRendered)
  if isRendered then
    self:_SetTipPosition()
  end
end

function GuideNoteTierRewardTipView:_RefreshRewardItems()
  local itemTemplateTf = self:FindChildRecursively(self.ui.uiNode, "UI_Common_Item_WuPin_Type2")
  if not itemTemplateTf then
    return
  end
  local itemRootTf = itemTemplateTf.transform.parent
  local itemTemplateGo = itemTemplateTf.gameObject
  if not itemRootTf or not itemTemplateGo then
    return
  end
  for i, reward in ipairs(self._rewardList) do
    local itemGo
    if 1 == i then
      itemGo = itemTemplateGo
    else
      itemGo = CS.UnityEngine.GameObject.Instantiate(itemTemplateGo, itemRootTf)
      table.insert(self._spawnedItems, itemGo)
    end
    itemGo:SetActive(true)
    local itemTid = reward and reward.tid or 0
    local itemCount = reward and reward.changedNum or 0
    local viewData = {
      itemTid = itemTid,
      itemCount = itemCount,
      extraDesc = reward and reward.extraDesc or nil,
      extraDescBgType = reward and reward.extraDescBgType or nil,
      clickFunc = function()
        ItemDataUtils.ShowItemDetailTips(self.binder, itemGo, nil, itemTid, true)
      end
    }
    self:AddViewComponentOnce(itemGo, CompPublicIconItemType2, viewData)
  end
end

function GuideNoteTierRewardTipView:_GetSortedRewardList(rewardList)
  local sortedRewardList = table.clone(rewardList)
  table.sort(sortedRewardList, System.fn(self, self._SortReward))
  return sortedRewardList
end

function GuideNoteTierRewardTipView:_SortReward(a, b)
  if a.tid == b.tid then
    local sortGroupA = self:_GetSameItemSortGroup(a)
    local sortGroupB = self:_GetSameItemSortGroup(b)
    if sortGroupA ~= sortGroupB then
      return sortGroupA < sortGroupB
    end
  end
  do return ItemDataUtils.CommonItemSortFunc, a end
  return ItemDataUtils.CommonItemSortFunc, a, b, b
end

function GuideNoteTierRewardTipView:_GetSameItemSortGroup(reward)
  if not reward then
    return 2
  end
  if reward.reason == CommonDefine.ItemReason.GuideNoteExtra then
    return 1
  end
  if reward.reason == CommonDefine.ItemReason.BattlePassDoubleEx then
    return 3
  end
  if self:_HasCornerMark(reward) then
    return 1
  end
  return 2
end

function GuideNoteTierRewardTipView:_HasCornerMark(reward)
  return reward and (reward.extraDesc and reward.extraDesc ~= "" or reward.extraOrigin and reward.extraOrigin > 0 or reward.itemAwardType) and true or false
end

function GuideNoteTierRewardTipView:_SetTipPosition()
  if not self._anchorGo or IsNil(self._anchorGo) or not self.ui.uiNode then
    return
  end
  local tipTf = self.ui.uiNode.transform
  local tipRt = tipTf:GetComponent(typeof(CS.UnityEngine.RectTransform))
  if not tipRt then
    return
  end
  local parentTf = tipTf.parent
  if not parentTf then
    return
  end
  local parentRt = parentTf:GetComponent(typeof(CS.UnityEngine.RectTransform))
  if not parentRt then
    return
  end
  local anchorScreenPos = CS.UnityEngine.RectTransformUtility.WorldToScreenPoint(nil, self._anchorGo.transform.position)
  local isInside, anchorLocalPos = CS.UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(parentRt, anchorScreenPos, nil)
  if not isInside then
    return
  end
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(tipRt)
  local halfParentWidth = parentRt.rect.width * 0.5
  local halfTipWidth = tipRt.rect.width * 0.5
  local clampedX = math.max(-halfParentWidth + halfTipWidth + 10, math.min(halfParentWidth - halfTipWidth - 10, anchorLocalPos.x))
  CS.Framework.TransformUtil.SetAnchoredPos(tipTf, clampedX + self._shiftX, anchorLocalPos.y + 95 + self._shiftY)
end

function GuideNoteTierRewardTipView:_ClearSpawnedItems()
  for _, itemGo in ipairs(self._spawnedItems) do
    if itemGo then
      CS.UnityEngine.GameObject.Destroy(itemGo)
    end
  end
  self._spawnedItems = {}
end

return GuideNoteTierRewardTipView
