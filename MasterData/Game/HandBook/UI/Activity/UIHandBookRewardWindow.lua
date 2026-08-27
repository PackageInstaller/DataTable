local UIHandBookRewardWindow = class("UIHandBookRewardWindow", UIBaseWindow)
local base = UIBaseWindow
local UINHandBookRewardItem = require("Game.HandBook.UI.Activity.UINHandBookRewardItem")
local cs_Tweening = CS.DG.Tweening

function UIHandBookRewardWindow:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBack)
  self._rewardPool = UIItemPool.New(UINHandBookRewardItem, self.ui.item)
  self.ui.item:SetActive(false)
end

function UIHandBookRewardWindow:InitHandBookRewardWindow(name, rewardIdList)
  self.ui.tex_ActName.text = name
  local totalCount = 0
  local hasCount = 0
  self._rewardPool:HideAll()
  for _, itemId in ipairs(rewardIdList) do
    totalCount = totalCount + 1
    local itemCfg = ConfigData.item[itemId]
    local noGet = true
    if itemCfg.type == eItemType.DormFurniture then
      if PlayerDataCenter.dormBriefData:ExistDormFntItem(itemId) then
        noGet = false
      end
    elseif itemCfg.type == eItemType.HeroCard then
      if PlayerDataCenter.heroDic[itemCfg.arg[1]] ~= nil then
        noGet = false
      end
    elseif itemCfg.type == eItemType.Skin then
      if PlayerDataCenter.skinData:IsHaveSkin(itemCfg.arg[1]) then
        noGet = false
      end
    elseif 0 < PlayerDataCenter:GetItemCount(itemId) then
      noGet = false
    end
    local item = self._rewardPool:GetOne()
    item:InitHandbookReward(itemId)
    item:SetHandbookRewardState(noGet)
    if not noGet then
      hasCount = hasCount + 1
    end
  end
  self.ui.tex_Progress:SetIndex(0, tostring(hasCount), tostring(totalCount))
end

function UIHandBookRewardWindow:PlayBookRewardAni(worldPos)
  self.ui.main:DOComplete()
  self.ui.main:DOMove(worldPos, 0.2):From():SetEase(cs_Tweening.Ease.OutQuad)
  self.ui.main:DOScale(0.2, 0.2):From():SetEase(cs_Tweening.Ease.OutQuad)
  for i, v in ipairs(self._rewardPool.listItem) do
    v:PlayBookRewarsItemAni(0.1 + (i - 1) * 0.033)
  end
end

function UIHandBookRewardWindow:OnClickBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHandBookRewardWindow:OnDelete()
  self.ui.main:DOComplete()
  self._rewardPool:DeleteAll()
  base.OnDelete(self)
end

return UIHandBookRewardWindow
