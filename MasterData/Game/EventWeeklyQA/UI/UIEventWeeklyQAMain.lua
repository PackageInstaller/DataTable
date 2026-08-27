local UIEventWeeklyQAMain = class("UIEventWeeklyQAMain", UIBaseWindow)
local base = UIBaseWindow
local UINEventWeeklyQAQuestionNode = require("Game.EventWeeklyQA.UI.UINEventWeeklyQAQuestionNode")
local UInSectorTaskRewardFloat = require("Game.Sector.SectorTask.UInSectorTaskRewardFloat")
local EventWeeklyQAQuestionRewardData = require("Game.EventWeeklyQA.Data.EventWeeklyQAQuestionRewardData")
local UINWeeklyQARewardItem = require("Game.EventWeeklyQA.UI.UINWeeklyQARewardItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local CS_MessageCommon = CS.MessageCommon

function UIEventWeeklyQAMain:OnInit()
  self.eventWeeklyQAController = ControllerManager:GetController(ControllerTypeId.EventWeeklyQA, true)
  self.__OnClickRewardFunc = BindCallback(self, self.OnClickRewardItem)
  self.viewReward = UInSectorTaskRewardFloat.New()
  self.viewReward:Init(self.ui.viewReward)
  self.questionNode = UINEventWeeklyQAQuestionNode.New()
  self.questionNode:Init(self.ui.obj_questionNode)
  self.questionNode:Hide()
  self.ui.obj_allRightNode:SetActive(false)
  self.ui.obj_finishNode:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_check, self, self.InitEventWeeklyQA)
  UIUtil.AddButtonListener(self.ui.btn_again, self, self.InitEventWeeklyQA)
  UIUtil.AddButtonListener(self.ui.btn_tips, self, self.__ShowWeeklyQAGuideTip)
end

function UIEventWeeklyQAMain:InitEventWeeklyQA(actId)
  if self.qaData ~= nil and self.qaData:GetQADataIsExpired() then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7804))
    return
  end
  self.eventWeeklyQAController:ShowWindowByWeeklyQAData()
end

function UIEventWeeklyQAMain:RefreshWeeklyQAByQAData(qaData)
  self.qaData = qaData
  self.ui.obj_allRightNode:SetActive(false)
  self.ui.obj_finishNode:SetActive(false)
  self.questionNode:InitWeeklyQAQuestionNodeByQAData(qaData)
  self.questionNode:Show()
  self:SetCharacterTalkLabel()
  self:RefreshWeeklyQARewards(qaData)
  if qaData:GetQADataIsExpired() then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7804))
    return
  end
  qaData:SetWeeklyQADataLooked()
end

function UIEventWeeklyQAMain:RefreshWeeklyQARewards(qaData)
  local rewardItems = self.rewardItems or {}
  for index, rewardData in ipairs(qaData.rewards) do
    if rewardItems[index] == nil then
      local rewardItem = UINWeeklyQARewardItem.New()
      rewardItem:Init(self.ui.obj_rewardItems[index])
      rewardItems[index] = rewardItem
    end
    rewardItems[index]:InitWeeklyQARewardItem(index, rewardData.currentState, rewardData.needScore, self.__OnClickRewardFunc)
  end
  self.rewardItems = rewardItems
end

function UIEventWeeklyQAMain:ShowAllRightNode()
  self.questionNode:Hide()
  self.ui.obj_allRightNode:SetActive(true)
  self.ui.obj_finishNode:SetActive(false)
  self:SetCharacterTalkLabel()
  self.eventWeeklyQAController:RecordCurrentQuestionIndex(self.qaData, self.qaData.questions[1].questionId)
  self.qaData:ReFlushAllQuestionOptions()
end

function UIEventWeeklyQAMain:ShowFinishNode()
  self.questionNode:Hide()
  self.ui.obj_allRightNode:SetActive(false)
  self.ui.obj_finishNode:SetActive(true)
  self:SetCharacterTalkLabel()
  self.eventWeeklyQAController:RecordCurrentQuestionIndex(self.qaData, self.qaData.questions[1].questionId)
  self.qaData:ReFlushAllQuestionOptions()
end

function UIEventWeeklyQAMain:SetResultItemByIndex(index, newState)
  self.questionNode:SetResultItemByIndex(index, newState)
end

function UIEventWeeklyQAMain:SetCharacterTalkLabel()
  if self.qaData:CheckIsAllRight() then
    self.ui.tex_talkLable.text = self.qaData:GetQAAllRightTalkText()
  else
    self.ui.tex_talkLable.text = self.qaData:GetQACommonTalkText()
  end
end

function UIEventWeeklyQAMain:__ShowAchivRewardsFloatWin(rewardItem, achivRewardIds, achivRewardNums)
  self.viewReward:FloatTo(rewardItem.transform, HAType.autoCenter, VAType.up)
  self.viewReward:RefreshItems(achivRewardIds, achivRewardNums, function()
    rewardItem:SetViewState(false)
  end)
  self.viewReward:Show()
  rewardItem:SetViewState(true)
  AudioManager:PlayAudioById(1055)
end

function UIEventWeeklyQAMain:OnClickRewardItem(item, index)
  if self.qaData:GetQADataIsExpired() then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7804))
    return
  end
  local rewardData = self.qaData.rewards[index]
  if rewardData.currentState == EventWeeklyQAQuestionRewardData.eRewardState.CompleteNoPicked then
    item:SetPicking(true)
    self.eventWeeklyQAController:ReqGetWeeklyQAReward(self.qaData, rewardData.needScore, function()
      item:SetPicking(false)
      AudioManager:PlayAudioById(1120)
      self.qaData:SetWeeklyQARewardGotten(rewardData.needScore)
      self:RefreshWeeklyQARewards(self.qaData)
    end)
  else
    self:__ShowAchivRewardsFloatWin(item, rewardData.rewardCfg.rewardIds, rewardData.rewardCfg.rewardNums)
  end
end

function UIEventWeeklyQAMain:__ShowWeeklyQAGuideTip()
  if self.qaData:GetQADataIsExpired() then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7804))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(self.qaData:GetWeeklyQAMainCfg().rule_des), ConfigData:GetTipContent(self.qaData:GetWeeklyQAMainCfg().rule_title), nil)
  end)
end

function UIEventWeeklyQAMain:OnDelete()
  if self.questionNode ~= nil then
    self.questionNode:Delete()
  end
end

return UIEventWeeklyQAMain
