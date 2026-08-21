_class("UIN16ImGameData", Object)
UIN16ImGameData = UIN16ImGameData
local UIN16AnswerResult = {
  IsRight = 1,
  HaveFaultTolerant = 2,
  Error = 3
}
_enum("UIN16AnswerResult", UIN16AnswerResult)

function UIN16ImGameData:Constructor(args)
  if args.isGm then
    self._questions = UIN16Const.GetAssiginedSubjects()
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
  self._cfgData = Cfg.cfg_n16_subject_test_grade
end

function UIN16ImGameData:GetQuestions()
  return self._questions
end

function UIN16ImGameData:GetOneQuestion()
  if #self._questions == 0 then
    return
  end
  self._curQuestion = table.remove(self._questions, 1)
  return self._curQuestion
end

function UIN16ImGameData:GetCurQuestion()
  return self._curQuestion
end

function UIN16ImGameData:GetLastCount()
  return #self._questions
end

function UIN16ImGameData:GetTotalCount()
  return self._totalCount
end

function UIN16ImGameData:GetTimeInter(OnReady)
  return OnReady == UIN16AnswerType.OnReady and self._readyinter or self._answerinter
end

function UIN16ImGameData:GetAnswerCount()
  return self._listCount
end

function UIN16ImGameData:SetTrueRight(nIndex, answer)
  self._trueRight[nIndex] = answer
end

function UIN16ImGameData:SetSelects(nIndex, answer)
  self._seletAnswers[nIndex] = answer
end

function UIN16ImGameData:GetTrueRight()
  local reightCount = 0
  for key, value in pairs(self._trueRight) do
    if value == 1 then
      reightCount = reightCount + 1
    end
  end
  return reightCount
end

function UIN16ImGameData:CheckAnswers()
  local reightCount = 0
  for key, value in pairs(self._seletAnswers) do
    if value == 1 then
      reightCount = reightCount + 1
    end
  end
  return reightCount
end

function UIN16ImGameData:GetFaultTolerantCount()
  return self._faultTolerantCount
end

function UIN16ImGameData:GetDefultFaultTolerantCount()
  return self._defultfaultTolerantCount
end

function UIN16ImGameData:RequceFaultTolerantCount()
  self._faultTolerantCount = self._faultTolerantCount - 1
end

function UIN16ImGameData:GetUsedFaultTolerantCount()
  return self._defultfaultTolerantCount - self._faultTolerantCount
end

function UIN16ImGameData:GetTestEvaluate()
  local const = UIN16Const:New()
  local rightCount = self:GetTrueRight()
  local result = const:GetGradeResult(rightCount)
  return result
end

function UIN16ImGameData:GetAnswerState(selectIndex)
  local isRight = self:GetCurQuestion():CheckIsRight(selectIndex)
  if not isRight then
    self:RequceFaultTolerantCount()
  end
  if isRight then
    return UIN16AnswerResult.IsRight
  elseif self:GetFaultTolerantCount() > 0 then
    return UIN16AnswerResult.HaveFaultTolerant
  else
    return UIN16AnswerResult.Error
  end
  return UIN16AnswerResult.Error
end
