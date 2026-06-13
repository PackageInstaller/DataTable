local M = BaseClass("ShortcutItemCtrl")

function M:__init(view)
    self._view = view
    self._view:onClick(Bind(self, self.OnClick))
    local jumpCfg = ConfigHelper.GetCfg("jump", self._view.jumpId)
    if jumpCfg then self._view.label:SetText(jumpCfg.label) end
end

function M:SetCurUI(uiconfig)
    self.uiConfig = uiconfig
end

function M:OnClick(go)
    local jumpId = self._view.jumpId
    if jumpId and jumpId > 0 then
        if GameHelper.CheckLockByJumpId(jumpId) > 0 then
            GameHelper.TipsById(4138)
            return
        end
        UIContextMgr:GetInstance():Close("ShortcutUI")
        GameHelper.JumpFormGeneral(jumpId)
    else
        GameHelper.Tips(ConfigHelper.GetLocalString(4139) .. tostring(jumpId))
        return
    end
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return M
