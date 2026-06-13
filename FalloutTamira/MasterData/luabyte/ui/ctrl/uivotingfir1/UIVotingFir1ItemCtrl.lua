local UIVotingFir1ItemCtrl = BaseClass("UIVotingFir1ItemCtrl")
local M = UIVotingFir1ItemCtrl

function M:__init(view)
    self._view = view
    self._view.btn:onClick(Bind(self, self.OnBtnClick))
end

function M:InitData(data)
    self.data = data
    self.heroId = data.HeroId
    self._view.textName:SetAvatarName(self.heroId, RoleType.ERT_Hero)
    self._view.textNum:SetText(tostring(data.Ticket))
    self._view.imageRole:SetHeroDrawing(data.HeroId)
    self._view.imageRole:SetImageWhole(self.heroId, RoleType.ERT_Hero)
end

function M:OnBtnClick()
    if self.heroId <= 0 then
        return 
    end
    
    EventMgr:Broadcast(UIMessageNames.VOTING_TWESELECTHERO1, self.heroId)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return UIVotingFir1ItemCtrl
