-- baoruichang
local UIGeneClassCtrl = BaseClass("UIGeneClassCtrl")
local M = UIGeneClassCtrl
local NUM = 6

function M:__init(view)
    self._view = view
    self._view.btn:onClick(Bind(self, self._onClick))
end

function M:Update(geneLv)
    for i = 1, NUM do
        self._view["itemState" .. i]:SetState(i <= geneLv and 3 or 1)
    end
end

function M:SetState(state, lv)
    self._view.state:SetState(state)
    if state == 1 then
        self._view.labLockTips:SetText(tostring(lv))
    end
end

function M:SetActive(state)
    self._view:SetActive(state)
end

function M:_onClick()
    if self.func then
        self.func()
    end
end

function M:SetOnClick(func)
    self.func = func
end


function M:OnDispose()
    self._view:onClick(nil)
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
    self.clickFunc = nil
end

return UIGeneClassCtrl
