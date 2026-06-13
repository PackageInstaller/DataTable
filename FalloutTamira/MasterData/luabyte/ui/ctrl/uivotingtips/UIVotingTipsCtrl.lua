--baoruichang
--2021/12/31 17:16:25

local UIVotingTipsCtrl = BaseClass("UIVotingTipsCtrl", BaseUICtrl)
local M = UIVotingTipsCtrl

function M:Init()
    self._view.mask:onClick(Bind(self,self.BtnClickClick))
    
end

function M:OnEnter(tips)
    self._view.text:SetText(tips)
end

function M:BtnClickClick()
    self:Close()
end

return UIVotingTipsCtrl