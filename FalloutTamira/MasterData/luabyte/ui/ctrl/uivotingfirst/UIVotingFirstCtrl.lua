-- baoruichang
-- 2021/12/14 14:03:27
local UIVotingFirstCtrl = BaseClass("UIVotingFirstCtrl", BaseUICtrl)
local M = UIVotingFirstCtrl

function M:Init()
    self._view.btnReward:SetOnClick(self, self.OnBtnRewardClick)
    self._view.btnDetails:SetOnClick(self, self.OnBtnDetailsClick)
end

-- 进入UI，可传参数
function M:OnEnter(heroDatas)
    self.heroDatas = heroDatas
    local VotingHeroScene = require "UI.Ctrl.UIVotingFirst.VotingHeroScene"
    self._uiVotingHeroSceneCtrl = VotingHeroScene:GetInstance()

    -- 客户端保护
    if not self.heroDatas or #self.heroDatas <= 0 then
        local heroData = {HeroId=110001, Ticket=101}
        self.heroDatas[1] = heroData
    end

    if self.heroDatas ~= nil and #self.heroDatas > 0 then
        self.heroData = self.heroDatas[1]
        self.heroId = self.heroData.HeroId
        Logger.Log(self.heroData.HeroId)
        self._view.textName:SetAvatarName(self.heroId, RoleType.ERT_Hero)
        self._view.textNum:SetText(tostring(self.heroData.Ticket))
        self._view.imgProfession:SetProfessional(self.heroId)
        self._view.imageQuality:SetHeroRare(self.heroId)

        self._uiVotingHeroSceneCtrl:ChangeHero(self.heroId)
    else
        Logger.LogError("数据为空")
        -- self:Close()
    end
    self._view.layGroup.enabled = true
end

function M:OnBtnRewardClick()
    -- self:Close()
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingShop)
end

function M:OnBtnDetailsClick()
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingHero, self.heroData.HeroId, {self.heroData}, false)
end

function M:OnDispose()
    self._view.btnReward:RemoveOnClick()
    self._view.btnDetails:RemoveOnClick()

    if self._uiVotingHeroSceneCtrl then
        self._uiVotingHeroSceneCtrl:OnDispose()
    end
    M.super.OnDispose(self)
end

return UIVotingFirstCtrl
