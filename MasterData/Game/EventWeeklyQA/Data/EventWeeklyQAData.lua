local base = require("Game.ActivityFrame.ActivityBase")
local EventWeeklyQAData = class("EventWeeklyQAData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.EventWeeklyQA
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local EventWeeklyQAQuestionData = require("Game.EventWeeklyQA.Data.EventWeeklyQAQuestionData")
local EventWeeklyQAQuestionRewardData = require("Game.EventWeeklyQA.Data.EventWeeklyQAQuestionRewardData")
local redDotType = {redDotReward = 1, redDotNewQA = 2}

function EventWeeklyQAData:InitEventWeeklyQADataByMsg(msg)
  local actId = msg.actId
  local order = msg.order
  self:SetActFrameDataByType(CurActType, actId)
  self._mainCfg = ConfigData.activity_answer_main[actId]
  self._problemCfg = ConfigData.activity_answer_problem[actId][order]
  self._rewardCfg = ConfigData.activity_answer_reward[actId]
  self.currentOrder = order
  self.startTm = self._problemCfg.start_time
  self.endTm = self._problemCfg.end_time
  local questions = {}
  local questionsIdIndexDic = {}
  for index, problemId in ipairs(self._problemCfg.problem_group) do
    local problemCfg = ConfigData.activity_answer_library[problemId]
    local questionData = EventWeeklyQAQuestionData.New(problemCfg, index, 2)
    table.insert(questions, questionData)
    questionsIdIndexDic[problemId] = index
  end
  self.questions = questions
  self.questionsIdIndexDic = questionsIdIndexDic
  for index, choiceElem in ipairs(msg.choice) do
    local problemId = choiceElem.problemId
    local choice = choiceElem.choice
    local questionIndex = self.questionsIdIndexDic[problemId]
    local questionData
    if questionIndex ~= nil then
      questionData = self.questions[questionIndex]
      questionData:SetQuestionResultByChoice(choice)
    end
  end
  self.wrongCd = self._mainCfg.wrong_cd
  self._net = NetworkManager:GetNetwork(NetworkTypeID.EventWeeklyQA)
  local rewardGotDic = {}
  for _, gottenRewardNeedScore in ipairs(msg.rewardGot) do
    rewardGotDic[gottenRewardNeedScore] = true
  end
  self.rewardGot = rewardGotDic
  local rewards = {}
  for needScore, rewardCfg in pairs(self._rewardCfg) do
    local rewardData = EventWeeklyQAQuestionRewardData.New(needScore, rewardCfg, EventWeeklyQAQuestionRewardData.eRewardState.unComplete)
    table.insert(rewards, rewardData)
  end
  table.sort(rewards, function(a, b)
    return a.needScore < b.needScore
  end)
  self.rewards = rewards
  self:RefreshRewardState()
  self.lastAnsweredQuestionIndex = 0
  self:SetCurrentQuestionIndexByOpProblemId(msg.opProblemId)
  self:__UpdateWeeklyQA()
end

function EventWeeklyQAData:__UpdateWeeklyQA()
  self:RefreshWeeklyQARedDotReward()
  self:RefreshWeeklyQARedDotNewQA()
end

function EventWeeklyQAData:RefreshWeeklyQARedDotReward()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local rewardRed = actRed:AddChild(redDotType.redDotReward)
  for _, rewardData in ipairs(self.rewards) do
    if rewardData.currentState == EventWeeklyQAQuestionRewardData.eRewardState.CompleteNoPicked then
      rewardRed:SetRedDotCount(1)
      return
    end
  end
  rewardRed:SetRedDotCount(0)
end

function EventWeeklyQAData:RefreshWeeklyQARedDotNewQA()
  local actRed = self:GetActivityReddot()
  if actRed == nil then
    return
  end
  local newQARed = actRed:AddChild(redDotType.redDotNewQA)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  if not saveUserData:GetWeeklyQALooked(self:GetActId(), self.currentOrder) then
    newQARed:SetRedDotCount(1)
    return
  end
  newQARed:SetRedDotCount(0)
end

function EventWeeklyQAData:SetCurrentQuestionIndexByOpProblemId(opProblemId)
  local realQuestionId = opProblemId >> 16
  local currentQuestionIndex = self.questionsIdIndexDic[realQuestionId]
  local lastAnsweredQuestionId = opProblemId & 65535
  local lastAnsweredQuestionIndex = self.questionsIdIndexDic[lastAnsweredQuestionId] or 0
  currentQuestionIndex = currentQuestionIndex ~= nil and currentQuestionIndex or 1
  self:SetCurrentQuestionIndex(currentQuestionIndex, lastAnsweredQuestionIndex)
end

function EventWeeklyQAData:SetCurrentQuestionIndex(newIndex, lastAnsweredQuestionIndex)
  self.currentQuestionIndex = newIndex
  self.lastAnsweredQuestionIndex = lastAnsweredQuestionIndex
end

function EventWeeklyQAData:SetWeeklyQARewardGotten(needScore)
  self.rewardGot[needScore] = true
  self:RefreshRewardState()
end

function EventWeeklyQAData:SetWeeklyQADataLooked()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetWeeklyQALooked(self:GetActId(), self.currentOrder)
  self:__UpdateWeeklyQA()
end

function EventWeeklyQAData:RefreshRewardState()
  local currentScore = self:GetQADataScore()
  for _, rewardData in ipairs(self.rewards) do
    if self.rewardGot[rewardData.needScore] then
      rewardData.currentState = EventWeeklyQAQuestionRewardData.eRewardState.Picked
    elseif currentScore >= rewardData.needScore then
      rewardData.currentState = EventWeeklyQAQuestionRewardData.eRewardState.CompleteNoPicked
    end
  end
  self:__UpdateWeeklyQA()
end

function EventWeeklyQAData:ReFlushAllQuestionOptions()
  for _, questionData in ipairs(self.questions) do
    questionData:FlushWeeklyQAOptions()
  end
end

function EventWeeklyQAData:GetWeeklyQAMainCfg()
  return self._mainCfg
end

function EventWeeklyQAData:GetWeeklyQARewardCfg()
  return self._rewardCfg
end

function EventWeeklyQAData:CheckIsAllRight()
  for _, question in ipairs(self.questions) do
    if question.questionResult ~= EventWeeklyQAQuestionData.eQuestionResult.trueAnswer then
      return false
    end
  end
  return true
end

function EventWeeklyQAData:CheckIsAnsweredAllQuestions()
  for _, question in ipairs(self.questions) do
    if question.questionResult == EventWeeklyQAQuestionData.eQuestionResult.notAnswer then
      return false
    end
  end
  return true
end

function EventWeeklyQAData:GetCurrentQuestion()
  return self.questions[self.currentQuestionIndex], self.lastAnsweredQuestionIndex
end

function EventWeeklyQAData:HasQADataExpiredTm()
  return self.endTm > 0
end

function EventWeeklyQAData:GetQADataExpiredTm()
  return self.endTm
end

function EventWeeklyQAData:GetQADataIsExpired()
  local actFrameCtr = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameData = actFrameCtr:GetActivityFrameData(self:GetActFrameId())
  if actFrameData == nil or not actFrameData:IsActivityOpen() then
    return true
  end
  return false
end

function EventWeeklyQAData:GetQADataScore()
  local currentScore = 0
  for _, question in ipairs(self.questions) do
    if question.questionResult == EventWeeklyQAQuestionData.eQuestionResult.trueAnswer then
      currentScore = currentScore + 1
    end
  end
  return currentScore
end

function EventWeeklyQAData:GetQAAllRightTalkText()
  return ConfigData:GetTipContent(7803)
end

function EventWeeklyQAData:GetQACommonTalkText()
  return ConfigData:GetTipContent(self._mainCfg.tips_id)
end

return EventWeeklyQAData
