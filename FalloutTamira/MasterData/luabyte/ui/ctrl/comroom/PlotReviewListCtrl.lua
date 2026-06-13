local M = BaseClass("PlotReviewListCtrl", BaseUICtrl)

-- 剧情图鉴当前章节图鉴列表

function M:Init()
    local itemCtrl = require("UI.Ctrl.ComRoom.PlotReviewListItemCtrl")
    local itemView = require("UI.View.ComRoom.PlotReviewListItemView")
    self._view.btn_back:onClick(Bind(self, self.Close))
    self._view.node_list:Init(itemCtrl, itemView)
end

function M:OnEnter(data, idx)
    self.m_data = data
    self._view.node_banner:UpdateItem(self.m_data, idx)
    self._view.node_list:SetDataList(self.m_data.Groups)
    GameHelper.DoPlayerAction(PlayerAction.OpenMessage) --为解决从剧情跳出来bgm异常 所以这里切一个大厅的BGM
end

function M:OnDispose()
    PlotAtlasDataMgr:GetInstance():CheckOffStoryBookRedPoint(self.m_data.SubType)
    IRedPointMgr:ForceCheck(RedPointConst.StoryBookMainTypeRedPointChecker)
    IRedPointMgr:ForceCheck(RedPointConst.StoryBookTypeRedPointChecker)
    self.m_data = nil
    M.super.OnDispose(self)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnVisible()
    GameHelper.DoPlayerAction(PlayerAction.OpenMessage)
end

return M
