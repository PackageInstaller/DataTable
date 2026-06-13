local UIContentView = BaseClass("UIContentView")
local M = UIContentView 

function M:Init(go,itemType,itemViewType)
    self._itemType = itemType
    self._itemViewType = itemViewType 
    self.itemView = itemViewType.New(go.transform)
    self.item = self._itemType.New(self.itemView)
end


function M:SetData(data)
    if not data then 
        data = {}
    end
    self._data = data 
    self.item:UpdateItem(data)
end

--获得所有数据
function M:GetData()
    return self._data
end

function M:Dispose()

end

return UIContentView 