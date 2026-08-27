local UINActivityDivergentRewardFrame = class("UINActivityDivergentRewardFrame", UIBaseNode)
local base = UIBaseNode
local UINActivityDivergentRewardFrameItem = require("Game.ActivityDivergent.UI.Reward.UINActivityDivergentRewardFrameItem")

function UINActivityDivergentRewardFrame:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  self._rewardItemPool = UIItemPool.New(UINActivityDivergentRewardFrameItem, self.ui.obj_RewardItem, false)
end

function UINActivityDivergentRewardFrame:ShowDivergentRewardFrame()
  if self._divergentHeroId == nil or self.gameObject.activeSelf then
    return
  end
  self:Show()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):PushTopStatusDataToBackStack(true)
  self:RefreshDivergentRewardFrame(self._divergentHeroId)
end

function UINActivityDivergentRewardFrame:InitDivergentRewardFrame(divergentData, divergentHeroId)
  self._data = divergentData
  self._divergentHeroId = divergentHeroId
end

function UINActivityDivergentRewardFrame:RefreshDivergentRewardFrame(divergentHeroId)
  if not self.gameObject.activeSelf then
    return
  end
  self._rewardItemPool:HideAll()
  local rewardGroupCfgs = self._data:GetDivergentHeroRewardGroupCfg(divergentHeroId)
  local levelCfg = rewardGroupCfgs[1]
  for _, rewardData in ipairs(levelCfg) do
    local rewardFrameItem = self._rewardItemPool:GetOne()
    rewardFrameItem:InitDivergentRewardItem(self._data, rewardData, divergentHeroId)
  end
  local progressData = self._data:GetDivergentHeroData(divergentHeroId)
  local currentLevelGoodData = self._data:GetDivergentHeroRewardLevelInStage(divergentHeroId, progressData.rewardStage)
  self.ui.tex_Count:SetIndex(0, tostring(progressData.rewardExp), tostring(currentLevelGoodData.reward_experience))
  local itemNum, maxNum = self._data:GetDivergentHeroFragCurNumAndMaxNum(divergentHeroId)
  self.ui.tex_Num:SetIndex(0, tostring(itemNum), tostring(maxNum))
end

function UINActivityDivergentRewardFrame:__BackAction()
  self:Hide()
end

function UINActivityDivergentRewardFrame:__OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINActivityDivergentRewardFrame:OnDelete()
  UIUtil.PopFromBackStackByUiTab(self)
end

return UINActivityDivergentRewardFrame
