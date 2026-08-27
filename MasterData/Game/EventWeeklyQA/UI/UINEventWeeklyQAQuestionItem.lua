local UINEventWeeklyQAQuestionItem = class("UINEventWeeklyQAQuestionItem", UIBaseNode)
local base = UINEventWeeklyQAQuestionItem
local UINEventWeeklyQAQuestionOptionItem = require("Game.EventWeeklyQA.UI.UINEventWeeklyQAQuestionOptionItem")
local EventWeeklyQAQuestionData = require("Game.EventWeeklyQA.Data.EventWeeklyQAQuestionData")
local EventWeeklyQAQuestionOption = require("Game.EventWeeklyQA.Data.EventWeeklyQAQuestionOption")

function UINEventWeeklyQAQuestionItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.questionOptionPool = UIItemPool.New(UINEventWeeklyQAQuestionOptionItem, self.ui.obj_questionOption)
  self.ui.obj_questionOption:SetActive(false)
  self.__onClickOption = BindCallback(self, self.OnClickOption)
end

function UINEventWeeklyQAQuestionItem:InitWeeklyQAQuestionItem(clickOptionCallback)
  self.clickOptionCallback = clickOptionCallback
end

function UINEventWeeklyQAQuestionItem:RefreshWeeklyQAQestionByQuestionData(questionData, lastAnsweredQuestionIndex)
  self.questionData = questionData
  self.allowClickOption = true
  self.ui.tex_question.text = LanguageUtil.GetLocaleText(questionData.title)
  self.questionOptionPool:HideAll()
  self.optionItems = {}
  for _, optionIndex in ipairs(questionData.optionIndexs) do
    local optionData = questionData.options[optionIndex]
    local optionItem = self.questionOptionPool:GetOne()
    optionItem:InitWeeklyQAQuestionOptionItem(optionData, self.__onClickOption)
    self.optionItems[optionData.logicIndex] = optionItem
  end
  if questionData.questionResult == EventWeeklyQAQuestionData.eQuestionResult.trueAnswer then
    self.allowClickOption = false
    local rightIndex = self.questionData:GetRightAnswerLogicIndex()
    self.optionItems[rightIndex]:SetOptionImgItem(EventWeeklyQAQuestionOption.eOptionState.trueAnswer)
    if self.clickOptionCallback ~= nil then
      self.clickOptionCallback(true, 1, false)
    end
  elseif self.questionData.lastlogicIndex ~= nil and self.questionData.questionIndex == lastAnsweredQuestionIndex then
    self.allowClickOption = false
    local rightIndex = self.questionData:GetRightAnswerLogicIndex()
    self.optionItems[rightIndex]:SetOptionImgItem(EventWeeklyQAQuestionOption.eOptionState.trueAnswer)
    self.optionItems[self.questionData.lastlogicIndex]:SetOptionImgItem(EventWeeklyQAQuestionOption.eOptionState.falseAnswer)
    if self.clickOptionCallback ~= nil then
      self.clickOptionCallback(true, self.questionData.lastlogicIndex, false)
    end
  end
end

function UINEventWeeklyQAQuestionItem:OnClickOption(logicIndex)
  if not self.allowClickOption then
    return
  end
  local isRight = self.questionData:GetIsRightAnswer(logicIndex)
  if isRight then
    self.optionItems[logicIndex]:SetOptionImgItem(EventWeeklyQAQuestionOption.eOptionState.trueAnswer)
  else
    self.optionItems[logicIndex]:SetOptionImgItem(EventWeeklyQAQuestionOption.eOptionState.falseAnswer)
    local rightIndex = self.questionData:GetRightAnswerLogicIndex()
    self.optionItems[rightIndex]:SetOptionImgItem(EventWeeklyQAQuestionOption.eOptionState.trueAnswer)
  end
  self.allowClickOption = false
  if self.clickOptionCallback ~= nil then
    self.clickOptionCallback(isRight, logicIndex, true)
  end
end

function UINEventWeeklyQAQuestionItem:OnDelete()
  if self.questionOptionPool ~= nil then
    self.questionOptionPool:DeleteAll()
    self.questionOptionPool = nil
  end
end

return UINEventWeeklyQAQuestionItem
