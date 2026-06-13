local M = BaseClass("MissionSweepRewardUICtrl", BaseUICtrl)

function M:Init()
    self._view.btn_back:onClick(Bind(self, self.Close))

    local ctrl = require("UI.Ctrl.Mission.MissionSweepRewardItemCtrl")
    local view = require("UI.View.Mission.MissionSweepRewardItemView")
    self._view.looplist:Init(ctrl, view)
end

function M:OnEnter(list, mission, playerExp)
    self._view.looplist:SetDataList(list)
    self._view.expCtrl:Refresh(mission, playerExp)
end

return M
