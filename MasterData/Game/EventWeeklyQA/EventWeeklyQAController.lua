local EventWeeklyQAController = class("EventWeeklyQAController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local EventWeeklyQAData = require("Game.EventWeeklyQA.Data.EventWeeklyQAData")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local EventWeeklyQAQuestionData = require("Game.EventWeeklyQA.Data.EventWeeklyQAQuestionData")
local CS_MessageCommon = CS.MessageCommon

function EventWeeklyQAController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_answer_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_answer_library)
  ConfigData:LoadDynCfg(eDynConfigData.activity_answer_problem)
  ConfigData:LoadDynCfg(eDynConfigData.activity_answer_reward)
  self._dataDic = {}
  self._net = NetworkManager:GetNetwork(NetworkTypeID.EventWeeklyQA)
  self._frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._updateQuestionState = BindCallback(self, self.UpdateQuestionState)
  self._ReqWeeklyQAData = BindCallback(self, self.ReqWeeklyQAData)
end

function EventWeeklyQAController:InitWeeklyQA(msg)
  local data = EventWeeklyQAData.New()
  self._dataDic[msg.actId] = data
  data:InitEventWeeklyQADataByMsg(msg)
  if data:HasQADataExpiredTm() then
    self._frameCtrl:AddActivityDataUpdateTimeListen(data:GetActFrameId(), data:GetQADataExpiredTm() + 1, self._ReqWeeklyQAData)
  end
  return data
end

function EventWeeklyQAController:GetTheLatestWeeklyQAData()
  local res
  for k, v in pairs(self._dataDic) do
    if res == nil then
      res = v
    elseif v:GetActivityBornTime() > res:GetActivityBornTime() then
      res = v
    end
  end
  return res
end

function EventWeeklyQAController:RemoveWeeklyQAData(actId)
  self._dataDic[actId] = nil
end

function EventWeeklyQAController:ReqWeeklyQAData(frameId)
  local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  actFrameNet:CS_ACTIVITY_SingleConcreteInfo(frameId, function(objList)
    local msg = objList[0]
    if msg ~= nil and msg.activityAnswer ~= nil then
      self:InitWeeklyQA(msg.activityAnswer)
      self:ShowWindowByWeeklyQAData()
    end
  end)
end

function EventWeeklyQAController:ShowWindowByWeeklyQAData()
  local qaData = self:GetTheLatestWeeklyQAData()
  local qaMainWindow = UIManager:GetWindow(UIWindowTypeID.EventWeeklyQA)
  if qaMainWindow == nil then
    return
  end
  qaMainWindow:RefreshWeeklyQAByQAData(qaData)
end

function EventWeeklyQAController:ReqSetQuestionState(qaData, questionId, choice)
  if qaData:GetQADataIsExpired() then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7804))
    return
  end
  self._net:CS_Activity_Answer_Choice(qaData:GetActId(), questionId, choice, function()
    self:RecordCurrentQuestionIndex(qaData, questionId, questionId)
    local qaMainWindow = UIManager:GetWindow(UIWindowTypeID.EventWeeklyQA)
    if qaMainWindow == nil then
      return
    end
    qaData:RefreshRewardState()
    qaMainWindow:RefreshWeeklyQARewards(qaData)
  end)
end

function EventWeeklyQAController:UpdateQuestionState(actId, questionId, logicIndex)
  local currentQAData = self:GetTheLatestWeeklyQAData()
  if currentQAData == nil or currentQAData.questionsIdIndexDic[questionId] == nil then
    return
  end
  local questionIndex = currentQAData.questionsIdIndexDic[questionId]
  local questionData = currentQAData.questions[questionIndex]
  local newQuestionResult = questionData:SetQuestionResultByChoice(logicIndex)
  local qaMainWindow = UIManager:GetWindow(UIWindowTypeID.EventWeeklyQA)
  if qaMainWindow == nil then
    return
  end
  qaMainWindow:SetResultItemByIndex(questionIndex, newQuestionResult)
  qaMainWindow:SetCharacterTalkLabel()
end

function EventWeeklyQAController:RecordCurrentQuestionIndex(qaData, questionId, lastAnsweredQuestionId)
  local _, recordDic = PlayerDataCenter.gameSettingData:IsGSDataDirty()
  lastAnsweredQuestionId = lastAnsweredQuestionId and lastAnsweredQuestionId or 0
  local opQuestionId = questionId << 16 | lastAnsweredQuestionId
  recordDic.ActivityAnswerOpId = opQuestionId
  NetworkManager:GetNetwork(NetworkTypeID.Object):CS_Client_Record_Set(recordDic)
  qaData:SetCurrentQuestionIndexByOpProblemId(opQuestionId)
end

function EventWeeklyQAController:ReqGetWeeklyQAReward(qaData, needScore, callback)
  if qaData:GetQADataIsExpired() then
    return
  end
  self._net:CS_Activity_Answer_Reward(qaData:GetActId(), needScore, callback)
end

function EventWeeklyQAController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_answer_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_answer_library)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_answer_problem)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_answer_reward)
end

return EventWeeklyQAController
