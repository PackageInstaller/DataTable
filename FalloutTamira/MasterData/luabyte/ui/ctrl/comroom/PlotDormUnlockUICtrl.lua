local M = BaseClass("PlotDormUnlockUI", BaseUICtrl)

function M:Init()
    self.m_onCallback = Bind(self, self.OnClickUnlock)
    local itemCtrl = require("UI.Ctrl.ComRoom.PlotDormUnlockItemCtrl")
    local itemView = require("UI.View.ComRoom.PlotDormUnlockItemView")
    self._view.looplist:Init(itemCtrl, itemView)
    self._view.btn_back:onClick(Bind(self, self.Close))
    self._view.looplist:SetCreateItemCallback(Bind(self, self.OnCreateItem))
end

function M:OnEnter(datas)
    self._view.looplist:SetDataList(datas)
end

function M:OnDispose()
    self.m_onCallback = nil
    M.super.OnDispose(self)
end

function M:OnClickUnlock(cfg, id)
    if not cfg then return end

    local costId, costNum = cfg.cost[1], cfg.cost[2]
    local itemNum = ItemDataMgr:GetInstance():GetItemNumById(costId)
    if itemNum < costNum then
        GameHelper.TipsById(30171) -- 消耗不足
        GameHelper.PopItem(costId, 0, self._view, function() end)
        return
    end

    local storyName = ConfigHelper.GetLocalString(cfg.storyTitle)
    local itemName = ItemHelper.GetItemNameById(costId)
    local strfmt = ConfigHelper.GetLocalString(6314) -- "是否消耗%s*%d解锁剧情#%s#?"
    GameHelper.ConfirmPopupUI(string.format(strfmt, itemName, costNum, storyName), function(ok)
        if ok then
            PlotAtlasDataMgr:GetInstance():SendUnlockBookStory({ BookStoryId = id, SubStoryId = cfg.id }, function()
                self._view.looplist:UpdateList()
            end)
        end
    end)
end

function M:OnCreateItem(ctrl)
    ctrl:SetCallback(self.m_onCallback)
end

return M
