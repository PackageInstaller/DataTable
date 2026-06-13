--预制体：HeroAtlasRewardPopUp
local M = BaseClass("HeroAtlasPopUpUICtrl", BaseUICtrl)
local eventId = UIMessageNames.HERO_ATLAS_REWARD_STATE_UPDATE

function M:Init()
    local UIRewardCtrl = require("UI.Ctrl.ComRoom.UIRewardCtrl")
    local UIRewardView = require("UI.View.ComRoom.UIRewardView")
    self.m_gridItem = self._view.gridItem
    self.m_gridItem:Init(UIRewardCtrl, UIRewardView)
    -- self._view.btnMask:onClick(Bind(self, self.Close))
    self._view.btn_award:onClick(Bind(self, self.OnClickFastAward))
    self.m_stateUpdateEvent = EventMgr:AddListener(eventId, Bind(self, self._InitRewards))
end

function M:OnEnter()
    self:_InitRewards()
end

function M:OnDispose()
    EventMgr:RemoveListener(eventId, self.m_stateUpdateEvent)
    self.m_stateUpdateEvent = nil
    self.m_gridItem = nil
    M.super.OnDispose(self)
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

-- 点击一键领奖
function M:OnClickFastAward(go)
    if #self.m_availables > 0 then
        PlotAtlasDataMgr:GetInstance():BooksFastAward({
            BookType = 5, RewardIndex = self.m_availables
        })
    else
        Logger.LogError("no reward !!!")
    end
end

function M:_InitRewards()
    local heroBooks = PlotAtlasDataMgr:GetInstance():GetRewardData()
    self.m_availables = {}
    self.m_gridItem:SetDataList(heroBooks)
    for _, value in ipairs(heroBooks) do
        if value.state == 1 then
            table.insert(self.m_availables, value.heroReward.id)
        end
    end
    self._view.btn_award:SetActive(#self.m_availables > 0)
end

return M
