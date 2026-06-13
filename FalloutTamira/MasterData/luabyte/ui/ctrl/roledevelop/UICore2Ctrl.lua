-- baoruichang
local UICore2Ctrl = BaseClass("UICore2Ctrl")
local M = UICore2Ctrl
local ITEMNUM = 6

function M:__init(view)
    self._view = view
    self._view.btn:onClick(Bind(self, self._onClick))
end

function M:Updata(star)
    for i = 1, ITEMNUM do
        self._view["uiState" .. i]:SetState(i <= star and 2 or 1)
    end
end

function M:SetState(state, lv)
    self._view.uiState:SetState(state)
    if state == 1 then
        self._view.labLockTips:SetText(tostring(lv))
    end
end

function M:_onClick()
    if self.func then
        self.func()
    end
end

function M:SetOnClick(func)
    self.func = func
end

function M:SetActive(state)
    self._view:SetActive(state)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UICore2Ctrl
