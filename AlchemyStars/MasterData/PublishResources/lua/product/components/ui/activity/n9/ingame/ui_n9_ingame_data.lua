_class("UIN9ImGameData", Object)
UIN9ImGameData = UIN9ImGameData
local UIN9AnswerResult = {
  IsRight = 1,
  HaveFaultTolerant = 2,
  Error = 3
}
_enum("UIN9AnswerResult", UIN9AnswerResult)

function UIN9ImGameData:Constructor(args)
  if args.isGm then
    self._questions = UIN9Const.GetAssiginedSubjects()
  else
    self._questions = args:GenSubject() or {}
  end
  self._readyinter = 3
  self._answerinter = args:GetAnswerTime()
  self._listCount = 4
  self._curQuestion = nil
  self._seletAnswers = {}
  self._trueRight = {}
  self._totalCount = #self._questions
  self._faultTolerantCount = args:GetFailedCount()
  self._defultfaultTolerantCount = args:GetFailedCount()
  self._cfgData = Cfg.cfg_subject_test_grade
end

function UIN9ImGameData:GetQuestions()
  return self._questions
end

function UIN9ImGameData:GetOneQuestion()
  if #self._questions == 0 then
    return
  end
  self._curQuestion = table.remove(self._questions, 1)
  return self._curQuestion
end

function UIN9ImGameData:GetCurQuestion()
  return self._curQuestion
end

function UIN9ImGameData:GetLastCount()
  return #self._questions
end

function UIN9ImGameData:GetTotalCount()
  return self._totalCount
end

function UIN9ImGameData:GetTimeInter(OnReady)
  return OnReady == UIN9AnswerType.OnReady and self._readyinter or self._answerinter
end

function UIN9ImGameData:GetAnswerCount()
  return self._listCount
end

function UIN9ImGameData:SetTrueRight(nIndex, answer)
  self._trueRight[nIndex] = answer
end

function UIN9ImGameData:SetSelects(nIndex, answer)
  self._seletAnswers[nIndex] = answer
end

function UIN9ImGameData:GetTrueRight()
  local reightCount = 0
  for key, value in pairs(self._trueRight) do
    if value == 1 then
      reightCount = reightCount + 1
    end
  end
  return reightCount
end

function UIN9ImGameData:CheckAnswers()
  local reightCount = 0
  for key, value in pairs(self._seletAnswers) do
    if value == 1 then
      reightCount = reightCount + 1
    end
  end
  return reightCount
end

function UIN9ImGameData:GetFaultTolerantCount()
  return self._faultTolerantCount
end

function UIN9ImGameData:GetDefultFaultTolerantCount()
  return self._defultfaultTolerantCount
end

function UIN9ImGameData:RequceFaultTolerantCount()
  self._faultTolerantCount = self._faultTolerantCount - 1
end

function UIN9ImGameData:GetUsedFaultTolerantCount()
  return self._defultfaultTolerantCount - self._faultTolerantCount
end

function UIN9ImGameData:GetTestEvaluate()
  local const = UIN9Const:New()
  local rightCount = self:GetTrueRight()
  local result = const:GetGradeResult(rightCount)
  return result
end

function UIN9ImGameData:GetAnswerState(selectIndex)
  local isRight = self:GetCurQuestion():CheckIsRight(selectIndex)
  if not isRight then
    self:RequceFaultTolerantCount()
  end
  if isRight then
    return UIN9AnswerResult.IsRight
  elseif self:GetFaultTolerantCount() > 0 then
    return UIN9AnswerResult.HaveFaultTolerant
  else
    return UIN9AnswerResult.Error
  end
  return UIN9AnswerResult.Error
end
