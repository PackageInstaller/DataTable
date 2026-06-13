local OnePageCtrl = BaseClass("OnePageCtrl")
local M = OnePageCtrl

function M:__init(view)
    self._view = view
end


function M:_SetPageInfo(ranks)
    self._allRanks = ranks
end

function M:UpdateItem(data,idx)
    self._allRanks = data
    local page=idx-1
    local index = page*10+1
    local count = index + 10
    local num = page*10+10
    if num>#self._allRanks then
        count = self._allRanks%10
    end
    local ranks = {}
    local j=0
    for i = index, count-1 do
        ranks[j] = self._allRanks[i]
        j =j+1
    end
    self:_SetRankList(ranks,page)
end

function M:_SetRankList(ranks,page)
    local content = self._view.transform
    local item
    local round = page*10
    local len = Mathf.Max(content.childCount,#ranks)
    local ctrl = require("UI.Ctrl.Bridge.BridgeRankItemCtrl")
    content:ClearChildren()
    for i = 0, len do
        
            local view = self._view.rankItem:Instantiate()
            item = ctrl.New(view)
            item:_SetInfo(ranks[i],i+round)
            view.transform:SetParent(content)
            
        
    end
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return OnePageCtrl