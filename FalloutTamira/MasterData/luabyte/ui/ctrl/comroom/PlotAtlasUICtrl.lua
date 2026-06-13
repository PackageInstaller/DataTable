local M = BaseClass("PlotAtlasUICtrl", BaseUICtrl)
-- 百科图鉴

function M:Init()
    local circular = require("Framework.UI.Component.CircularScrollView")
    local itemCtrl = require("UI.Ctrl.ComRoom.PlotAtlasItemCtrl")
    local itemView = require("UI.View.ComRoom.PlotAtlasItemView")
    self._view.btn_back:onClick(Bind(self, self.Close))
    self._atlasScroll = circular.New(self._view.node_list)
    self._atlasScroll:Init(itemCtrl, itemView)
end

function M:OnEnter()
    local list = PlotAtlasDataMgr:GetInstance():GetBookTypeConfigs()
    self._atlasScroll:SetDataList(list)
    PlotAtlasDataMgr:GetInstance():ChangeBookState(0, false)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

return M
