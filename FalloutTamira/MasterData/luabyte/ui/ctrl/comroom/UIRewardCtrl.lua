local M = BaseClass("UIRewardCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    local UIAtlasHeroCtrl = require("UI.Ctrl.ComRoom.UIAtlasHeroCtrl")
    local UIAtlasHeroView = require("UI.View.ComRoom.UIAtlasHeroView")
    self.m_gridHero = self._view.gridHero
    self.m_gridHero:Init(UIAtlasHeroCtrl, UIAtlasHeroView)
    self._view.btn:onClick(Bind(self, self.OnBtnClick))
end

--- data heroReward
function M:UpdateItem(data)
    self.m_data = data
    local cfg = data.heroReward
    self._view.labTitle:SetText(cfg.desc)
    self.m_gridHero:SetDataList(data.showHeros)
    self._view.labNum2:SetText("/" .. #cfg.hero)
    self._view.item:EnablePopItem(data.state ~= 1)
    self._view.labNum1:SetText(tostring(data.haveNum))
    self._view.item:SetInfo(cfg.itemId[1], ItemNumberType.TOTLE, cfg.itemNum[1])

    if data.state == 2 then
        self._view.uiState:SetState(3) -- 已领取
    elseif data.state == 1 then
        self._view.uiState:SetState(2) -- 可领取
    else
        self._view.uiState:SetState(1) -- normal
    end
end

function M:OnBtnClick()
    if not self.m_data then return end

    PlotAtlasDataMgr:GetInstance():RequestRewardBookAward(self.m_data.heroReward.id)
end

function M:OnDispose()
    self.m_gridHero = nil
    self.m_data = nil
    M.super.OnDispose(self)
end

return M
