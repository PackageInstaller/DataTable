-- baoruichang
-- 2021/12/13 20:13:11
local UIVotingGetMoreCtrl = BaseClass("UIVotingGetMoreCtrl", BaseUICtrl)
local M = UIVotingGetMoreCtrl
local UIVotingGetMoreItemCtrl = require("UI.Ctrl.UIVotingGetMore.UIVotingGetMoreItemCtrl")
local UIVotingGetMoreItemView = require("UI.View.UIVotingGetMore.UIVotingGetMoreItemView")

function M:Init()
    -- self.jumpId = { 85, 86 } --获得的跳转jump表id
    self._view.btnClose:onClick(self, self.OnBtnCloseClick)

    self.gridScroll = self._view.List
    self.gridScroll:Init(UIVotingGetMoreItemCtrl, UIVotingGetMoreItemView)
end

function M:OnShow()
    self.jumpData = {}
    local votingId = VotingDataMgr:GetInstance():GetVotingId()
    self.jumpId = ConfigHelper.GetCfgPropByLua("item", votingId, "wayValue2")
    for i = 1, #self.jumpId do
        local jump = ConfigHelper.GetCfg("jump", self.jumpId[i])
        local data = {}
        data.id = jump.id
        data.desc = jump.desc
        self.jumpData[i] = data
    end

    self.gridScroll:SetDataList(self.jumpData)
end

function M:OnBtnCloseClick()
    self:Close()
end

function M:OnDispose()
    self.jumpId = nil
    M.super.OnDispose(self)
end

return UIVotingGetMoreCtrl
