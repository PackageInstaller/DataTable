--人设总入口
--预制体  RoleProfile_New
local M = BaseClass("RoleProfileCtrl", BaseUICtrl)

function M:Init()
    self.m_context = UIContextMgr:GetInstance():GetContext(UIDefine.RoleDevelopMain)
    self._refreshDataHandler = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, Bind(self, self._OnRefreshData))
end

function M:OnEnter(heroData)
    self.idx = self.m_context:GetSelectDocType()
    self._heroData = heroData
    self._view.tab:Init(self.idx, Bind(self, self._OnSelect))
    self._ctrls = { self._view.persona, self._view.story, self._view.voice }
    self._view.tab:SetIndex(self.idx, true)
    self._view.tab:SetRedPointParma(1, 0, self._heroData:GetHeroId())
    self._view.tab:SetRedPointCheck(1)
end

function M:OnDispose()
    self:_RemoveListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, self._refreshDataHandler)

    M.super.OnDispose(self)
end

function M:_OnSelect(idx)
    self.idx = idx
    self._ctrls[idx + 1]:SetHeroData(self._heroData)

    self._view.tab:SetRedPointParma(1, 0, self._heroData:GetHeroId())
    self._view.tab:SetRedPointCheck(1)
    self.m_context:SelectDocType(idx)
end

function M:_OnRefreshData(heroId)
    self._heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    self:_OnSelect(self.idx)
end

return M
