local PackBuyItemCtrl = BaseClass("PackBuyItemCtrl")
local M = PackBuyItemCtrl

function M:__init(view)
    self._view = view
    self.isMonthCard = false
    self._view.imgIcon.transform:onClick(Bind(self, self.OnClickItem))
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self.data = data
    local itemCfg = ConfigHelper.GetCfg("item", data.id)
    self._view.imgIcon:SetPic(itemCfg.icon, false)
    local itemName = ConfigHelper.GetLocalString(itemCfg.name)
    local desPrefix = nil
    if data.every_day and self.isMonthCard then
        desPrefix = ConfigHelper.GetLocalString(5750)
    else
        desPrefix = ConfigHelper.GetLocalString(1229)
    end
    self._view.txtDes:SetText(desPrefix .. itemName)
    self._view.txtNum:SetText("x" .. data.num)
end

function M:OnClickItem(go)
    GameHelper.PopItem(self.data.id, self.data.num, self._view)
end

function M:Dispose()
    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return PackBuyItemCtrl
