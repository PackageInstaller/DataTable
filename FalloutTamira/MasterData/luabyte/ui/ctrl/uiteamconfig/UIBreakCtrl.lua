--baoruichang
--突破图标
local UIBreakCtrl = BaseClass("UIBreakCtrl")
local M = UIBreakCtrl
local NUM = 8

function M:__init(view)
    self._view = view
    self.allBreakNum = { 5, 6, 7, 8 }
end

function M:Updata(rare, grade)
    local breakNum = self.allBreakNum[rare]
    for i = 1, NUM do
        self._view["tf" .. i].parent:SetActive(breakNum >= i)
    end
    for i = 1, breakNum do
        self._view["tf" .. i]:SetActive(grade >= i)
    end
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
end

return UIBreakCtrl
