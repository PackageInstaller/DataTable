local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIVotingEight1ItemCtrl = BaseClass("UIVotingEight1ItemCtrl", CircularScrollViewItem)
local M = UIVotingEight1ItemCtrl
--  海选英雄界面
--  对应view UIVotingHeroPropItemView
function M:Init()
    self._view.btn:onClick(Bind(self, self.OnBtnClick))
end

function M:UpdateItem(data)
    self.heroId = data.heroId
    self._view.textName:SetAvatarName(self.heroId, RoleType.ERT_Hero)
    self._view.textNum:SetText(tostring(data.Ticket))
    self._view.imageIcon:SetImageHalf(self.heroId,RoleType.ERT_Hero,1)
end

function M:OnBtnClick()
    if self.heroId > 0 then
        EventMgr:Broadcast(UIMessageNames.VOTING_SELECTHERO1, self.heroId)
    end
end

return UIVotingEight1ItemCtrl
