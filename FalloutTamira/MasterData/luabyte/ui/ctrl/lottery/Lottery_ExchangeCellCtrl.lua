local Lottery_ExchangeCellCtrl = BaseClass("Lottery_ExchangeCellCtrl", UIBaseComponent)
local M = Lottery_ExchangeCellCtrl

--data{itemid,itemnum}
function M:SetData(data)
    self:SetActive(data ~= nil)
    if data == nil then
        return
    end

    local itemdata = ConfigHelper.GetCfgByLua("item", data.Id)
    self._view.name:SetText(itemdata.name)
    self._view.num:SetText(tostring(data.Cnt))
    self._view.icon:SetPic(itemdata.icon)
    local hasNumber = ItemDataMgr:GetInstance():GetItemNumById(data.Id)
    local enough = hasNumber >= data.Cnt
    -- if enough then
    --     self._view.state:SetState(1)
    -- else
    --     self._view.state:SetState(2)
    -- end
end

return M
