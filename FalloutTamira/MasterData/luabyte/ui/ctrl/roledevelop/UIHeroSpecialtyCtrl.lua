--角色养成主界面中的属性面板
local UIHeroSpecialtyCtrl = BaseClass("UIHeroSpecialtyCtrl", UIBaseComponent)
local M = UIHeroSpecialtyCtrl
function M:__init(view)
    self._view = view
end

function M:UpdateData(data)
    self._view.imgIcom:SetPic(data.icon)
    self._view.labSpecialty:SetText(data.specialty)
end

return UIHeroSpecialtyCtrl
