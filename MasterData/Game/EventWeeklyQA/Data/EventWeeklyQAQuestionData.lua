local EventWeeklyQAQuestionData = class("EventWeeklyQAQuestionData")
local EventWeeklyQAQuestionOption = require("Game.EventWeeklyQA.Data.EventWeeklyQAQuestionOption")
EventWeeklyQAQuestionData.eQuestionResult = {
  trueAnswer = 0,
  falseAnswer = 1,
  notAnswer = 2
}

local function Swap(targetList, index1, index2)
  local tempValue = targetList[index1]
  targetList[index1] = targetList[index2]
  targetList[index2] = tempValue
end

local function Shuffle(targetList)
  for currentIndex = 1, #targetList - 1 do
    local randomTargetIndex = math.random(currentIndex, #targetList)
    Swap(targetList, currentIndex, randomTargetIndex)
  end
end

function EventWeeklyQAQuestionData:ctor(problemCfg, questionIndex, questionResult)
  self.questionId = problemCfg.title_id
  self.questionIndex = questionIndex
  self.playerRecommend = problemCfg.player_recommend
  self.title = problemCfg.title
  self.questionResult = questionResult
  local options = {}
  table.insert(options, EventWeeklyQAQuestionOption.New(problemCfg.answer_1right, 1, true))
  table.insert(options, EventWeeklyQAQuestionOption.New(problemCfg.answer_2, 2))
  table.insert(options, EventWeeklyQAQuestionOption.New(problemCfg.answer_3, 3))
  table.insert(options, EventWeeklyQAQuestionOption.New(problemCfg.answer_4, 4))
  self.options = options
  self:FlushWeeklyQAOptions()
end

function EventWeeklyQAQuestionData:FlushWeeklyQAOptions()
  local optionIndexs = {
    1,
    2,
    3,
    4
  }
  Shuffle(optionIndexs)
  self.optionIndexs = optionIndexs
  for showIndex, logicIndex in ipairs(optionIndexs) do
    self.options[logicIndex]:SetShowIndex(showIndex)
  end
end

function EventWeeklyQAQuestionData:SetQuestionResultByChoice(logicIndex)
  self.lastlogicIndex = logicIndex
  self.questionResult = self.options[logicIndex].isRight and EventWeeklyQAQuestionData.eQuestionResult.trueAnswer or EventWeeklyQAQuestionData.eQuestionResult.falseAnswer
  return self.questionResult
end

function EventWeeklyQAQuestionData:GetIsRightAnswer(logicIndex)
  return self.options[logicIndex].isRight
end

function EventWeeklyQAQuestionData:GetRightAnswerLogicIndex()
  return 1
end

return EventWeeklyQAQuestionData
