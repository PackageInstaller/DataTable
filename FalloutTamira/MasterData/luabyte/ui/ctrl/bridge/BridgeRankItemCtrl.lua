local BridgeRankItemCtrl = BaseClass("BridgeRankItemCtrl")
local M = BridgeRankItemCtrl


function M:__init(view)
    self._view = view
    self._view.gameObject:SetActive(true)
    self._stars = {}
    for i = 1, 10 do
        self._stars[i] = self._view["Star" .. i]
    end
end

function M:_SetInfo(data, index)
    if data then
        self._view.playerName:SetText(data.BaseInfo.Nick)
    end
    self._view.topBg:SetActive(index <= 2)
    self._view.top1:SetActive(index == 0)
    self._view.top2:SetActive(index == 1)
    self._view.top3:SetActive(index == 2)
    self._view.normalBg:SetActive(index > 2)

    self._view.rank:SetText(tostring(index + 1))
    self._view.odd:SetActive(index % 2 == 0)
    self._view.even:SetActive(index % 2 ~= 0)



end

function M:_SetLevel(idx)
    for i = 1, 10 do
        self._stars[i]:SetActive(i < idx)

    end
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return BridgeRankItemCtrl
