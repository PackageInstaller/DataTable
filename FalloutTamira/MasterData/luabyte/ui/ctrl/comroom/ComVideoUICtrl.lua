local ComVideoUICtrl = BaseClass("ComVideoUICtrl", BaseUICtrl)
local M = ComVideoUICtrl

function M:Init()
    self._view.rectClose:onClick(Bind(self, self.Close))
    self._view.rectPlay:onClick(Bind(self, self.OnPlayClick))
end

function M:OnEnter(path)
    
end

function M:OnPlayClick()

end

function M:OnDispose()
    self._view.rectClose:onClick(nil)
    self._view.rectPlay:onClick(nil)

    M.super.OnDispose(self)
end

return ComVideoUICtrl