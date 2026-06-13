local ShopTypeRedPointChecker = BaseClass("ShopTypeRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = ShopTypeRedPointChecker

function M:__init()
    self.dataCenterId = { EGetterID.ShopData }
end

function M:Check(type)
    if not self:OnChanged(type) then
        return
    end

    self.checkResult = ShopDataMgr:CheckNormalShopTypeRedPoint(type) and 1 or 0
end

return ShopTypeRedPointChecker
