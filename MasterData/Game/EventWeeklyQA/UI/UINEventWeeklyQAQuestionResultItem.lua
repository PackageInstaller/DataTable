local UINEventWeeklyQAQuestionResultItem = class("UINEventWeeklyQAQuestionResultItem", UIBaseNode)
local base = UIBaseNode

function UINEventWeeklyQAQuestionResultItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.obj_arrow:SetActive(false)
end

function UINEventWeeklyQAQuestionResultItem:InitWeeklyQAQuestionResultItem(questionData, isShowFalse)
  self.questionData = questionData
  self:SetResultImgItem(questionData.questionResult, isShowFalse)
end

function UINEventWeeklyQAQuestionResultItem:SetCurrentQuestionCursorShow(isShow)
  self.ui.obj_arrow:SetActive(isShow)
end

function UINEventWeeklyQAQuestionResultItem:SetResultImgItem(result, isShowFalse)
  local showResult = result
  if not isShowFalse then
    showResult = result == 0 and 0 or 2
  end
  self.ui.imgItem_result:SetIndex(showResult)
end

return UINEventWeeklyQAQuestionResultItem
