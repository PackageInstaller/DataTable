local CollectionRewardCom, Super = NewViewComponent("CollectionRewardCom")
local Vector2 = CS.UnityEngine.Vector2
local T_ContentSizeFitter = typeof(CS.UnityEngine.UI.ContentSizeFitter)
local MAX_WIDTH = 450

function CollectionRewardCom:ctor(uiNode, view, rewardType, progressFunc)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Item_rewardResource(uiNode)
  self.rewardType = rewardType
  self.progressFunc = progressFunc
end

function CollectionRewardCom:OnBuildComponent()
  Super.OnBuildComponent(self)
  self:_InitUIElements()
end

function CollectionRewardCom:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_InitUIElements()
  self:_RefreshProgress()
  self:_RefreshRed()
end

function CollectionRewardCom:RegisterEvents()
  if self.rewardType then
    self:AddButtonClickListener(self.ui.Image_BG, System.fn(self, self._OnClickOpenReward))
  end
end

function CollectionRewardCom:RegisterNotifications()
  self:RegisterNotify(NotifyId.CollectionItemUnlocked, System.fn(self, self._RefreshProgress))
  self:RegisterNotify(NotifyId.CollectionRewardGet, self._RefreshRed, self)
end

function CollectionRewardCom:_RefreshProgress()
  local unlockedCount, totalCount
  if self.progressFunc and type(self.progressFunc) == "function" then
    unlockedCount, totalCount = self.progressFunc()
  else
    unlockedCount, totalCount = 0, 0
  end
  unlockedCount = unlockedCount or 0
  totalCount = totalCount or 0
  self:SetText(self.ui.Text_Existing, unlockedCount)
  self:SetText(self.ui.Text_Quantity, "/" .. totalCount)
end

function CollectionRewardCom:_RefreshRed()
  if not self.rewardType then
    return
  end
  self:AddViewComponentOnce(self.ui.Red_Rewards, UICompRedDot, CommonDefine.RedDotType.Dot, nil, function()
    do return RedPointDataUtils.NewCollectionReward end
    return RedPointDataUtils.NewCollectionReward, self.rewardType
  end)
end

function CollectionRewardCom:_OnClickOpenReward()
  ArtCollectionController.Instance:OpenRewardView(self.rewardType)
end

function CollectionRewardCom:_InitUIElements()
  self.ui.Image_Icon:SetActive(self.rewardType)
  local textLangKey = self.rewardType and ArtCollectionDefine.progressLangKeys[self.rewardType] or ArtCollectionDefine.defaultProgressLangKey
  self:SetText(self.ui.Text_Progress, LT.Text(textLangKey))
  local width = StrUtils.SetPreferredWidth(self.ui.Text_Progress)
  self.ui.Text_Progress:GetComponent(T_ContentSizeFitter).enabled = width <= MAX_WIDTH
  if width > MAX_WIDTH then
    width = math.min(width, MAX_WIDTH)
    self.ui.Text_Progress.transform.sizeDelta = Vector2(width, self.ui.Text_Progress.transform.sizeDelta.y)
  end
  local bgWidth = width + (self.rewardType and 190 or 155)
  self.ui.Image_BG.transform.anchoredPosition = Vector2(-0.5 * bgWidth + 15, self.ui.Image_BG.transform.anchoredPosition.y)
  self.ui.Image_BG.transform.sizeDelta = Vector2(bgWidth, self.ui.Image_BG.transform.sizeDelta.y)
end

return CollectionRewardCom
