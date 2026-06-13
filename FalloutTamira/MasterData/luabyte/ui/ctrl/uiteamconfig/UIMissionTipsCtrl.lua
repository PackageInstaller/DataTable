-- baoruichang
-- 预制体 UIMissionTips
local UIMissionTipsCtrl = BaseClass("UIMissionTipsCtrl", BaseUICtrl)
local M = UIMissionTipsCtrl

function M:Init()
    self._view:onClick(Bind(self, self._OnClick))
end

-- 进入UI，可传参数
function M:OnEnter(teamPicture)
    self.teamPicture = teamPicture
    self._picIndex = 0
    self:_OnClick()
end

function M:_OnClick()
    if self._picIndex < self.teamPicture.Length then
        self._view.RawImage:SetPic(self.teamPicture[self._picIndex])
        self._picIndex = self._picIndex + 1
    else
        self:Close()
    end
end

return UIMissionTipsCtrl
