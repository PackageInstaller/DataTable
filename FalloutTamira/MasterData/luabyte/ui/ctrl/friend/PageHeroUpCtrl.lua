local PageHeroUpCtrl = BaseClass("PageHeroUpCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = PageHeroUpCtrl



function M:Hide()
    self:HidePanel()
end

function M:OpenPanel()
    self:ShowPanel()
    self._heroList = FriendDataMgr:GetInstance():GetUpHeroIds()
    self:_UpdateCard(0)
end

function M:_UpdateCard(index)
    local list = MapUtil.OrderFilterValues(self._heroList, function(v) return v > 0 end)

    for i = 1, 5 do
        self._heroList[i] = list[i] or 0
        self:_RefreshCards(i, self._heroList[i])
    end
end

function M:_RefreshCards(index, id)
    local name = string.format("card%d", index)
    local null = string.format("null%d", index)
    local data = { heroId = id, selectIndex = 0 }
    self._view[null]:SetActive(id == 0)
    self._view[name]:SetActive(id ~= 0)

    if id ~= 0 then
        self._view[name]:UpdateItem(data)
    end
end

function M:Init()
    for i = 1, 5 do
        local name = string.format("card%dBtn", i)
        self._view[name]:onClick(Bind(self, self._OnClickShow, i))
    end
end

function M:_OnClickShow(index)
    local pos = 0--self._heroList[index] == 0 and 0 or index
    UIContextMgr:GetInstance():Show("SelectHero", pos, self._heroList, Bind(self, self._OnSelectHeroCallBack))
end

function M:_OnSelectHeroCallBack(heroIds, index)
    self._selectHeroIds = heroIds
    self._selectindex = index
    FriendDataMgr:GetInstance():SendRequestSelectHero(self._selectHeroIds, Bind(self, self._OnResponseCallBack))
end

function M:_OnResponseCallBack()
    self._heroList = self._selectHeroIds
    self:_UpdateCard(self._selectindex)
    self._selectHeroIds = nil
    self._selectindex = nil
end

return PageHeroUpCtrl
