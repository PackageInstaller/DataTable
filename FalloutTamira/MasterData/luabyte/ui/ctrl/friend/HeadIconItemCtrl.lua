local HeadIconItemCtrl = BaseClass("HeadIconItemCtrl")
local M = HeadIconItemCtrl

function M:__init(view)
    self._view = view
    self._view.transform:onClick(Bind(self, self._ClickItem))
    self.selectCallback = nil
end

function M:_ClickItem(go)
    if self.data.isSelect then
        return
    end
    if self.selectCallback then
        self.selectCallback(self.data.cfg.id)
    end
end

function M:UpdateItem(data)
    if data == nil then
        return
    end
    self.data = data
    self._view.HeadIcon:SetPic(data.cfg.icon)
    self._view.Select.gameObject:SetActive(data.isSelect)
    if data.isUsed then
        self._view.HeadState:SetState(2)
    else
        if data.unlock then
            self._view.HeadState:SetState(1)
        else
            self._view.HeadState:SetState(3)
        end
    end
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return HeadIconItemCtrl
