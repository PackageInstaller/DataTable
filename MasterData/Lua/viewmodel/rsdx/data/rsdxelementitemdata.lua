







RSDXElementItemData = {}
RSDXElementItemData.__index = RSDXElementItemData

RSDXElementItemData.New = function()

    local self = {}
    setmetatable(self, RSDXElementItemData)
    return self
end



function RSDXElementItemData:RefreshElement(elementID)
    self.CurElementID = elementID
    self.CurElementConfig = ConfigMgr.Config.ColorGameElementMap[tostring(elementID)]
end