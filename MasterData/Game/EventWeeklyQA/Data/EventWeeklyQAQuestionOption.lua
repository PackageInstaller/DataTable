local EventWeeklyQAQuestionOption = class("EventWeeklyQAQuestionOption")
EventWeeklyQAQuestionOption.eOptionState = {
  trueAnswer = 0,
  falseAnswer = 1,
  notAnswer = 2
}

function EventWeeklyQAQuestionOption:ctor(des, logicIndex, isRight)
  self.des = des
  self.logicIndex = logicIndex
  self.isRight = isRight == true
  return self
end

function EventWeeklyQAQuestionOption:SetShowIndex(showIndex)
  self.showIndex = showIndex
end

return EventWeeklyQAQuestionOption
