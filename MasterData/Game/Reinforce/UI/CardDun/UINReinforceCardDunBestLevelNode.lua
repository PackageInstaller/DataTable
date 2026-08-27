local base = UIBaseNode
local UINReinforceCardDunBestLevelNode = class("UINReinforceCardDunBestLevelNode", base)
local UINReinforceCardDunLvlDetailNode = require("Game.Reinforce.UI.CardDun.UINReinforceCardDunLvlDetailNode")
local cs_MessageCommon = CS.MessageCommon

function UINReinforceCardDunBestLevelNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Rank, self, self.OnClickRank)
  UIUtil.AddButtonListener(self.ui.Btn_Reward, self, self.OnClickReward)
  UIUtil.AddButtonListener(self.ui.Btn_Check, self, self.OnClickCheck)
  UIUtil.AddButtonListener(self.ui.Btn_Left, self, self.OnClickLeft)
  UIUtil.AddButtonListener(self.ui.Btn_Right, self, self.OnClickRight)
  UIUtil.AddButtonListener(self.ui.Btn_RightLock, self, self.OnClickRightLock)
  self.levelDetailNode = UINReinforceCardDunLvlDetailNode.New()
  self.levelDetailNode:Init(self.ui.LvlDetailsWindow)
  self.levelDetailNode:Hide()
  self.RefreshRedDotCallback = BindCallback(self, self.RefreshRedDot)
end

function UINReinforceCardDunBestLevelNode:RefreshLayerNode(levelData, actData, onLayerChangeCallback)
  self.levelData = levelData
  self.actData = actData
  self.onLayerChangeCallback = onLayerChangeCallback
  local stageId = self.levelData:GetStageId()
  local highestLevel = self.actData:GetHightestLevelByStageId(stageId) or 0
  self.curLevel = self.levelData:GetLayerIndex() or self.actData:GetCurLevelByStageId(stageId) or 1
  self.ui.Tex_BestLvlNum.text = tostring(highestLevel)
  self:RefreshLayer()
end

function UINReinforceCardDunBestLevelNode:RefreshLayer()
  local curLevel = self.curLevel
  local stageId = self.levelData:GetStageId()
  self.ui.Tex_LvlNum:SetIndex(0, tostring(curLevel))
  local isVerifying = self.actData:GetRankScoreIsUnderVerifyByStageId(stageId)
  if isVerifying then
    self.ui.Tex_tittle:SetIndex(1)
  else
    self.ui.Tex_tittle:SetIndex(0)
  end
  local layerGroupId = self.levelData:GetLayerGroupId()
  local cfgList = ConfigData.reinforce_exploration_layer_group[layerGroupId]
  local isNextLocked = false
  if curLevel + 1 <= #cfgList then
    local nextCfg = cfgList[curLevel + 1]
    isNextLocked = (nextCfg.unlock_layer or 0) > (self.actData:GetHightestLevelByStageId(stageId) or 0)
  end
  self.ui.Btn_Left.gameObject:SetActive(true)
  self.ui.Btn_Right.gameObject:SetActive(true)
  self.ui.Btn_RightLock.gameObject:SetActive(false)
  if curLevel <= 1 then
    self.ui.Btn_Left.gameObject:SetActive(false)
  elseif curLevel >= #cfgList then
    self.ui.Btn_Right.gameObject:SetActive(false)
  elseif isNextLocked then
    self.ui.Btn_Right.gameObject:SetActive(false)
    self.ui.Btn_RightLock.gameObject:SetActive(true)
  end
  local stageId = self.levelData:GetStageId()
  self.actData:SetCurLevelByStageId(stageId, curLevel)
  self.levelData:SetLayerIndex(curLevel)
  self:RefreshRedDot()
  if not self.isInited then
    local reddot = self.actData:GetActivityReddot()
    RedDotController:AddListener(reddot.nodePath, self.RefreshRedDotCallback)
    self.isInited = true
  end
  if self.onLayerChangeCallback ~= nil then
    self.onLayerChangeCallback()
  end
end

function UINReinforceCardDunBestLevelNode:OnClickRank()
  local rankId = self.levelData:GetRankId()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(rankId, nil)
  end)
end

function UINReinforceCardDunBestLevelNode:OnClickReward()
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceReward, function(win)
    if win == nil then
      return
    end
    win:InitRewardList(self.levelData, self.actData)
  end)
end

function UINReinforceCardDunBestLevelNode:OnClickCheck()
  self.levelDetailNode:Show()
  self.levelDetailNode:RefreshLevelDetail(self.levelData, self.actData, self.curLevel)
end

function UINReinforceCardDunBestLevelNode:OnClickLeft()
  if self.curLevel > 1 then
    self.curLevel = self.curLevel - 1
    self:RefreshLayer()
  end
end

function UINReinforceCardDunBestLevelNode:OnClickRight()
  local layerGroupId = self.levelData:GetLayerGroupId()
  local cfgList = ConfigData.reinforce_exploration_layer_group[layerGroupId]
  if self.curLevel < #cfgList then
    self.curLevel = self.curLevel + 1
    self:RefreshLayer()
  end
end

function UINReinforceCardDunBestLevelNode:OnClickRightLock()
  local layerGroupId = self.levelData:GetLayerGroupId()
  local cfgList = ConfigData.reinforce_exploration_layer_group[layerGroupId]
  local nextCfg = cfgList[self.curLevel + 1]
  cs_MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(59031), tostring(nextCfg.unlock_layer)))
end

function UINReinforceCardDunBestLevelNode:RefreshRedDot()
  self.ui.Obj_RedDot:SetActive(self.levelData:GetIsHavingCouldPickReward(self.actData))
end

function UINReinforceCardDunBestLevelNode:OnDelete()
  if self.isInited then
    local reddot = self.actData:GetActivityReddot()
    RedDotController:RemoveListener(reddot.nodePath, self.RefreshRedDotCallback)
  end
  base.OnDelete(self)
end

return UINReinforceCardDunBestLevelNode
