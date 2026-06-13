local DormitoryDressupTabItemCtrl = BaseClass("DormitoryDressupTabItemCtrl")
local M = DormitoryDressupTabItemCtrl

function M:__init(view)
    self._view = view
    self._view.ClickTarget.transform:onClick(Bind(self, self.OnClickTab))
    self.updateRedPointCallback = EventMgr:AddListener(UIMessageNames.DORM_FURNITURE_REDPOINT, Bind(self, self.UpdateRedPoint))
end
 
function M:SetCallback(callback)
    self.callback = callback
end

function M:OnClickTab(go)
    self._view.UIState:SetState(2)
    if self.callback then
        self.callback(self.type)
    end
end

function M:UpdateData(type)
    self.type = type
    self:UpdateRedPoint()
    if self.type == DormConst.DressupTableType.AccessoryFurniture then
        self._view.Text:SetText("布置附属家具")
        return
    end

    if self.type == DormConst.DressupTableType.ParentFurniture then
        self._view.Text:SetText("布置主家具")
        return
    end
end

function M:UpdateRedPoint()
    self._view.Redpoint:SetParam(0,self.type)
    self._view.Redpoint:Check()
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    self.type = 0
    EventMgr:RemoveListener(UIMessageNames.DORM_FURNITURE_REDPOINT, self.updateRedPointCallback)
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return DormitoryDressupTabItemCtrl
