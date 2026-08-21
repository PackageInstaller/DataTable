_class("UIActivityOneAndHalfAnniversaryController", UIController)
UIActivityOneAndHalfAnniversaryController = UIActivityOneAndHalfAnniversaryController

function UIActivityOneAndHalfAnniversaryController:OnInit()
end

function UIActivityOneAndHalfAnniversaryController:PlayBtnOnClick()
  self:ShowDialog("UIActivityOneAndHalfAnniversaryVideoController")
end

function UIActivityOneAndHalfAnniversaryController:QuitBtnOnClick()
  self:CloseDialog()
end

function UIActivityOneAndHalfAnniversaryController:OnHide()
end
