local UINEventWeeklyQAQuestionOptionItem = class("UINEventWeeklyQAQuestionOptionItem", UIBaseNode)
local base = UIBaseNode
local EventWeeklyQAQuestionOption = require("Game.EventWeeklyQA.Data.EventWeeklyQAQuestionOption")

function UINEventWeeklyQAQuestionOptionItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_option, self, self._OnClickOption)
end

function UINEventWeeklyQAQuestionOptionItem:InitWeeklyQAQuestionOptionItem(optionData, onClickOption)
  self.optionData = optionData
  self.ui.tex_des:SetIndex(optionData.showIndex - 1, LanguageUtil.GetLocaleText(optionData.des))
  self:SetOptionImgItem(EventWeeklyQAQuestionOption.eOptionState.notAnswer)
  self.__onClickOption = onClickOption
end

function UINEventWeeklyQAQuestionOptionItem:SetOptionImgItem(optionState)
  self.ui.imgItem_option:SetIndex(optionState)
end

function UINEventWeeklyQAQuestionOptionItem:_OnClickOption()
  if self.__onClickOption ~= nil then
    self.__onClickOption(self.optionData.logicIndex)
  end
end

return UINEventWeeklyQAQuestionOptionItem
