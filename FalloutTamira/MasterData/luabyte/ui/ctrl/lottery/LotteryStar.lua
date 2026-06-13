local LotteryStar = BaseClass("LotteryStar")
local M = LotteryStar

function M:__init(view)
    local starItemCls = require("UI.Ctrl.Lottery.LotteryStarItem")
    self._stars = {}
    for i = 1, 5 do
        local viewStar = view["view_Star" .. i]
        table.insert(self._stars, starItemCls.New(viewStar))
    end
end

function M:SetStar(star)
    for i = 1, 5 do
        self._stars[i]:SetStarEnable(star >= i)
    end
end

function M:OnDispose()
    for _, v in ipairs(self._stars or {}) do
        v:OnDispose()
    end
    self._stars = nil
    if self.view then
        self.view:OnDispose()
        self.view = nil
    end
end

return LotteryStar
