local UINEventWeeklyQAQuestionNode = class("UINEventWeeklyQAQuestionNode", UIBaseNode)
local base = UIBaseNode
local EventWeeklyQAQuestionData = require("Game.EventWeeklyQA.Data.EventWeeklyQAQuestionData")
local UINEventWeeklyQAQuestionResultItem = require("Game.EventWeeklyQA.UI.UINEventWeeklyQAQuestionResultItem")
local UINEventWeeklyQAQuestionItem = require("Game.EventWeeklyQA.UI.UINEventWeeklyQAQuestionItem")
local EventWeeklyQAEnum = require("Game.EventWeeklyQA.EventWeeklyQAEnum")
local CS_MessageCommon = CS.MessageCommon

function UINEventWeeklyQAQuestionNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:SetRecommandTagShow(EventWeeklyQAEnum.EWeeklyQATagType.None)
  self.questionResultPool = UIItemPool.New(UINEventWeeklyQAQuestionResultItem, self.ui.obj_questionResult)
  self.ui.obj_questionResult:SetActive(false)
  self.questionItem = UINEventWeeklyQAQuestionItem.New()
  self.questionItem:Init(self.ui.obj_questionItem)
  self.questionItem:InitWeeklyQAQuestionItem(BindCallback(self, self.ClickOptionCallback))
  self.questionResultItems = {}
  self.ui.btn_finish.gameObject:SetActive(false)
  self.ui.btn_lock.gameObject:SetActive(false)
  self.ui.btn_nextQuestion.gameObject:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_finish, self, self.OnClickBtnFinish)
  UIUtil.AddButtonListener(self.ui.btn_nextQuestion, self, self.OnClickBtnNextQuestion)
  self.qaController = ControllerManager:GetController(ControllerTypeId.EventWeeklyQA, false)
end

function UINEventWeeklyQAQuestionNode:InitWeeklyQAQuestionNodeByQAData(QAData)
  self.qaData = QAData
  self.questionResultPool:HideAll()
  self.questionResultItems = {}
  local currentQuestion, lastAnsweredQuestionIndex = QAData:GetCurrentQuestion()
  local isFromMiddle = currentQuestion.questionIndex ~= 1 or currentQuestion.questionIndex == 1 and lastAnsweredQuestionIndex == 1
  for index, question in ipairs(QAData.questions) do
    local resultItem = self.questionResultPool:GetOne()
    resultItem:InitWeeklyQAQuestionResultItem(question, index <= lastAnsweredQuestionIndex)
    table.insert(self.questionResultItems, resultItem)
  end
  if self._cdTimer ~= nil then
    TimerManager:StopTimer(self._cdTimer)
    self._cdTimer = nil
  end
  self:SetToNewQuestion(currentQuestion)
end

function UINEventWeeklyQAQuestionNode:SetToNewQuestion(newQuestion)
  if self.currentQuestion ~= nil then
    local resultItem = self.questionResultItems[self.currentQuestion.questionIndex]
    if resultItem ~= nil then
      resultItem:SetCurrentQuestionCursorShow(false)
    end
  end
  self.ui.btn_finish.gameObject:SetActive((self.qaData:CheckIsAnsweredAllQuestions()))
  self.ui.btn_finish.interactable = self.qaData:CheckIsAllRight()
  self.ui.btn_lock.gameObject:SetActive(false)
  self.ui.btn_nextQuestion.gameObject:SetActive(true)
  self.ui.btn_nextQuestion.interactable = false
  local lastAnsweredQuestion = self.qaData.questions[self.qaData.lastAnsweredQuestionIndex]
  local lastAnsweredQuestionId = lastAnsweredQuestion and lastAnsweredQuestion.questionId or 0
  self.qaController:RecordCurrentQuestionIndex(self.qaData, newQuestion.questionId, lastAnsweredQuestionId)
  self.currentQuestion = newQuestion
  self.ui.texItem_questionIndex:SetIndex(0, tostring(newQuestion.questionIndex), tostring(#self.qaData.questions))
  self:SetRecommandTagShow(newQuestion.playerRecommend)
  self.questionItem:RefreshWeeklyQAQestionByQuestionData(newQuestion, self.qaData.lastAnsweredQuestionIndex)
  local resultItem = self.questionResultItems[newQuestion.questionIndex]
  if resultItem ~= nil then
    resultItem:SetCurrentQuestionCursorShow(true)
  end
end

function UINEventWeeklyQAQuestionNode:SetRecommandTagShow(tagType)
  if tagType == EventWeeklyQAEnum.EWeeklyQATagType.None then
    self.ui.obj_playerRecommend:SetActive(false)
  else
    self.ui.obj_playerRecommend:SetActive(true)
    self.ui.tex_playerRecommend:SetIndex(tagType - 1)
    self.ui.img_playerRecommend:SetIndex(tagType - 1)
  end
end

function UINEventWeeklyQAQuestionNode:ClickOptionCallback(isShowNextBtn, logicIndex, isReqNetSet)
  if isReqNetSet then
    self:ReqSetResultItem(self.qaData, self.currentQuestion.questionId, logicIndex)
  end
  self.qaController:UpdateQuestionState(self.qaData:GetActId(), self.currentQuestion.questionId, logicIndex)
  if isShowNextBtn then
    self:ShowNextBtn()
  else
    self:OnAnswerFalse()
  end
end

function UINEventWeeklyQAQuestionNode:ReqSetResultItem(qaData, questionId, logicIndex)
  if self.qaController == nil then
    return
  end
  self.qaController:ReqSetQuestionState(qaData, questionId, logicIndex)
end

function UINEventWeeklyQAQuestionNode:OnClickBtnFinish()
  if self.qaData:GetQADataIsExpired() then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7804))
    return
  end
  local qaMainWindow = UIManager:GetWindow(UIWindowTypeID.EventWeeklyQA)
  if qaMainWindow == nil then
    return
  end
  self:Hide()
  if self.qaData:CheckIsAllRight() then
    qaMainWindow:ShowAllRightNode()
  else
    qaMainWindow:ShowFinishNode()
  end
end

function UINEventWeeklyQAQuestionNode:OnClickBtnNextQuestion()
  if self.qaData:GetQADataIsExpired() then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7804))
    return
  end
  local nextQuestionIndex = self.currentQuestion.questionIndex + 1
  if nextQuestionIndex > #self.qaData.questions then
    self:OnClickBtnFinish()
  else
    self:SetToNewQuestion(self.qaData.questions[nextQuestionIndex])
  end
end

function UINEventWeeklyQAQuestionNode:ShowNextBtn()
  local nextQuestionIndex = self.currentQuestion.questionIndex + 1
  if nextQuestionIndex > #self.qaData.questions then
    self.ui.btn_nextQuestion.gameObject:SetActive(false)
    self.ui.btn_finish.gameObject:SetActive(true)
    self.ui.btn_finish.interactable = true
  elseif self.qaData:CheckIsAllRight() then
    self.ui.btn_nextQuestion.gameObject:SetActive(true)
    self.ui.btn_nextQuestion.interactable = true
    self.ui.btn_finish.gameObject:SetActive(true)
    self.ui.btn_finish.interactable = true
  else
    self.ui.btn_nextQuestion.gameObject:SetActive(true)
    self.ui.btn_nextQuestion.interactable = true
  end
end

function UINEventWeeklyQAQuestionNode:OnAnswerFalse()
  self.ui.btn_nextQuestion.gameObject:SetActive(false)
  self.ui.btn_lock.gameObject:SetActive(true)
  self.timeCount = self.qaData.wrongCd
  self.ui.tex_lockTime:SetIndex(0, tostring(self.timeCount))
  if self._cdTimer ~= nil then
    TimerManager:StopTimer(self._cdTimer)
    self._cdTimer = nil
  end
  self._cdTimer = TimerManager:StartTimer(1, function()
    self.timeCount = self.timeCount - 1
    self.ui.tex_lockTime:SetIndex(0, tostring(self.timeCount))
    if self.timeCount <= 0 then
      self.ui.btn_lock.gameObject:SetActive(false)
      TimerManager:StopTimer(self._cdTimer)
      self._cdTimer = nil
      self:ShowNextBtn()
    end
  end, self, false)
end

function UINEventWeeklyQAQuestionNode:SetResultItemByIndex(index, newState)
  local resultItem = self.questionResultItems[index]
  if resultItem ~= nil then
    resultItem:SetResultImgItem(newState, true)
  end
end

function UINEventWeeklyQAQuestionNode:OnDelete()
  if self.questionItem ~= nil then
    self.questionItem:Delete()
    self.questionItem = nil
  end
  if self._cdTimer ~= nil then
    TimerManager:StopTimer(self._cdTimer)
    self._cdTimer = nil
  end
  if self.questionResultPool ~= nil then
    self.questionResultPool:DeleteAll()
    self.questionResultPool = nil
  end
end

return UINEventWeeklyQAQuestionNode
