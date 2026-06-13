local TrainingSuccessUICtrl = BaseClass("TrainingSuccessUICtrl", BaseUICtrl)
local M = TrainingSuccessUICtrl

function M:Init()
    self._view.BG:SetOnClick(function()
        self:ClickBG()
      end)
end

function M:OnEnter(_level)
    self._view.Value:SetText(tostring(_level))
end

function M:ClickBG()
    self:Close()
end


return TrainingSuccessUICtrl
