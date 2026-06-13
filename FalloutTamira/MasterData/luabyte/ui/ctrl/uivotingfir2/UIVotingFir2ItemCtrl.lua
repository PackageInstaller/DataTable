local UIVotingFir2ItemCtrl = BaseClass("UIVotingFir2ItemCtrl")
local M = UIVotingFir2ItemCtrl
-- local Color = CS.UnityEngine.Color
function M:__init(view)
    self._view = view
    self._view.btn:SetOnClick(self, self.OnBtnClick)
    self._view.btnHero:SetOnClick(self, self.OnBtnHeroClick)
end

function M:InitData(data, heroDatas)
    self.heroDatas = heroDatas
    self.data = data
    self.heroId = data.HeroId
    self._view.textName:SetAvatarName(self.heroId, RoleType.ERT_Hero)
    self._view.textNum:SetText(tostring(data.Ticket))
    self._view.imageRole:SetImageWhole(self.heroId, RoleType.ERT_Hero)
    self._view.imageRole2:SetImageWhole(self.heroId, RoleType.ERT_Hero)
end

function M:OnBtnClick()
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingVote, self.heroId, self.data.Ticket)
end

function M:OnDispose()
    self._view.btn:RemoveOnClick()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:OnBtnHeroClick()
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingHero, self.heroId, self.heroDatas, true)
end

return UIVotingFir2ItemCtrl
