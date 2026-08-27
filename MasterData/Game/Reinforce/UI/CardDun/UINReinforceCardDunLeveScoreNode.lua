local base = UIBaseNode
local UINReinforceCardDunLeveScoreNode = class("UINReinforceCardDunLeveScoreNode", base)

function UINReinforceCardDunLeveScoreNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Rank, self, self.__OnClickRank)
  UIUtil.AddButtonListener(self.ui.Btn_Reward, self, self.__OnClickReward)
  self.RefreshRedDotCallback = BindCallback(self, self.RefreshRedDot)
end

function UINReinforceCardDunLeveScoreNode:RefreshRankNode(levelData, actData)
  self.levelData = levelData
  self.actData = actData
  local stageId = self.levelData:GetStageId()
  local curScore = self.actData:GetRankScoreByStageId(stageId)
  local isVerifying = self.actData:GetRankScoreIsUnderVerifyByStageId(stageId)
  self.ui.Tex_Score.text = tostring(curScore)
  if isVerifying then
    self.ui.Tex_Title:SetIndex(1)
  else
    self.ui.Tex_Title:SetIndex(0)
  end
  local isIntime, finishTime = self.levelData:GetLevelIsIntime()
  if isIntime then
    self.ui.Tex_Tip.text = string.format(ConfigData:GetTipContent(59020), TimeUtil:TimestampToDateString(finishTime, false, true))
  else
    self.ui.Tex_Tip.text = ConfigData:GetTipContent(59021)
  end
  self:RefreshRedDot()
  if not self.isInited then
    local reddot = self.actData:GetActivityReddot()
    RedDotController:AddListener(reddot.nodePath, self.RefreshRedDotCallback)
    self.isInited = true
  end
end

function UINReinforceCardDunLeveScoreNode:RefreshRedDot()
  self.ui.Obj_RedDot:SetActive(self.levelData:GetIsHavingCouldPickReward(self.actData))
end

function UINReinforceCardDunLeveScoreNode:__OnClickRank()
  local rankId = self.levelData:GetRankId()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(rankId, nil)
  end)
end

function UINReinforceCardDunLeveScoreNode:__OnClickReward()
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceReward, function(win)
    if win == nil then
      return
    end
    win:InitRewardList(self.levelData, self.actData)
  end)
end

function UINReinforceCardDunLeveScoreNode:OnDelete()
  if self.isInited then
    local reddot = self.actData:GetActivityReddot()
    RedDotController:RemoveListener(reddot.nodePath, self.RefreshRedDotCallback)
  end
  base.OnDelete(self)
end

return UINReinforceCardDunLeveScoreNode
