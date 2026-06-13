-- baoruichang
-- 假面舞会 icon
local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIGiftItemCtrl = BaseClass("UIMasqueradeGiftCtrl", CircularScrollViewItem)
local M = UIGiftItemCtrl
local tInsert = table.insert

function M:Init()
    self._view:onClick(Bind(self, self._OnItemClick))
    self._tempOnSetSelectState = EventMgr:AddListener(UIMessageNames.DANCE_CLICKGIFT, Bind(self, self._OnSetSelectState))
end

function M:UpdateItem(id)
    self.id = id
    local itemConf = ConfigHelper.GetCfg("item", id)
    self._view.labName:SetText(itemConf.name)
    self._view.imgIcon:SetItemIcon(id)
    self._view.stateQuality:SetState(itemConf.quality)
    local itemNum = ItemDataMgr:GetInstance():GetItemNumById(id)
    self._view.tfMask:SetActive(itemNum <= 0)
    self._view.redPoint:SetParam(0, id)
    self._view.redPoint:Check()
end

function M:_OnItemClick()
    if self.id then
        EventMgr:Broadcast(UIMessageNames.DANCE_CLICKGIFT, self.id)
    end
end

function M:_OnSetSelectState(selectId)
    self._view.stateSelect:SetState(selectId == self.id and 2 or 1)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.DANCE_CLICKGIFT, self._tempOnSetSelectState)
    M.super.OnDispose(self)
end

return UIGiftItemCtrl
