local UIVotingHeroPropItemCtrl = BaseClass("UIVotingHeroPropItemCtrl")
local M = UIVotingHeroPropItemCtrl
-- UIVotingHeroItemCtrl
function M:__init(view)
    self._view = view
end

function M:UpdateItem(data)
    self._view.textName:SetText(data.key)
    self._view.textNum:SetText(data.value)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return UIVotingHeroPropItemCtrl
