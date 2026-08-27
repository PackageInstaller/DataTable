local UINEpCommonModeSelectDiffInfinityNode = class("UINEpCommonModeSelectDiffInfinityNode", UIBaseNode)
local base = UIBaseNode

function UINEpCommonModeSelectDiffInfinityNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_self, self, self.__OnInfinityClick)
  UIUtil.AddButtonListener(self.ui.Btn_Rank, self, self.__OnClickRank)
  UIUtil.AddButtonListener(self.ui.Btn_Reward, self, self.__OnClickReward)
  UIUtil.AddButtonListener(self.ui.Btn_CheckFormation, self, self.__OnClickCheckFormation)
end

function UINEpCommonModeSelectDiffInfinityNode:InitEpCommonModeSelectDiffInfinityNode(modeData, diffCfg, epInifinityData, OnSelectCallback)
  self.modeData = modeData
  self.diffCfg = diffCfg
  self.epInifinityData = epInifinityData
  self.OnSelectCallback = OnSelectCallback
  self:InitRedDot()
  local getCurrentScoreCallback = self.modeData:GetGetInifinityCurrentScoreCallback()
  if getCurrentScoreCallback ~= nil then
    local diffId = self.diffCfg.difficulty_id
    local currentScore = getCurrentScoreCallback(diffId)
    self.ui.Tex_PointNow:SetIndex(0, tostring(currentScore))
  end
end

function UINEpCommonModeSelectDiffInfinityNode:SetIsSelected(bool)
  self.ui.obj_Selected:SetActive(bool)
end

function UINEpCommonModeSelectDiffInfinityNode:InitRedDot()
  function self.__refreshReward(node)
    local isOn = node:GetRedDotCount() > 0
    
    self.ui.redDot_reward:SetActive(isOn)
  end
  
  local rewardNode = self.modeData:GetInfinityRewardRedDotNode(self.diffCfg.difficulty_id)
  self.__refreshReward(rewardNode)
  RedDotController:AddListener(rewardNode.nodePath, self.__refreshReward)
end

function UINEpCommonModeSelectDiffInfinityNode:__OnInfinityClick()
  self:SetIsSelected(true)
  self.OnSelectCallback(nil)
end

function UINEpCommonModeSelectDiffInfinityNode:__OnClickRank()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(self.diffCfg.rank_id)
  end)
end

function UINEpCommonModeSelectDiffInfinityNode:__OnClickReward()
  self.modeData:ShowMsInfinityReward(self.diffCfg)
end

function UINEpCommonModeSelectDiffInfinityNode:__OnClickCheckFormation()
  UIManager:ShowWindowAsync(UIWindowTypeID.InfinityFmtCheck, function(win)
    if win == nil then
    end
    win:InitFmtSaveChipPanel(self.epInifinityData:GetEpFormationSaveData())
  end)
end

function UINEpCommonModeSelectDiffInfinityNode:OnDelete()
  if self.modeData ~= nil then
    local rewardNode = self.modeData:GetInfinityRewardRedDotNode(self.diffCfg.difficulty_id)
    RedDotController:RemoveListener(rewardNode.nodePath, self.__refreshReward)
  end
  base.OnDelete(self)
end

return UINEpCommonModeSelectDiffInfinityNode
