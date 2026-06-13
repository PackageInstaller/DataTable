local PlotAtlasItemCtrl = BaseClass("PlotAtlasItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))
local M = PlotAtlasItemCtrl

function M:Init()
    self._view.btn_enter:onClick(Bind(self, self._OnClickItem))
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    -- bookReward数据
    self._data = data
    self._view.txt_chName:SetText(self._data.name)
    self._view.txt_enName:SetText(self._data.nameEN)
    self._view.img_role:SetPic(self._data.bookPicture, false)
    self._view.txt_index:SetText(string.format("%02d", self._data.type))
    self._view.redPoint:SetParam(0, self._data.type)
    self._view.redPoint:Check()
end

function M:_OnClickItem(go)
    UIContextMgr:GetInstance():Show("PlotAtlasProgressUI", self._data)
end

return PlotAtlasItemCtrl
