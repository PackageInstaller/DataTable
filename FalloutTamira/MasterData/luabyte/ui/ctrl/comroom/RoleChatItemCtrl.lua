local RoleChatItemCtrl = BaseClass("RoleChatItemCtrl")
local M = RoleChatItemCtrl

function M:__init(view)
    self._view = view
end

--data:heroStory
function M:UpdateItem(data)
    if data == nil then
        return
    end

    self:_SetAvatar(data)
    self:_SetDialogue(data)
    -- self:_UpdateLayout()
end

function M:_SetAvatar(data)
    self._view.imgRoleAvatar:SetAvatarIcon(data.hero, 1)
end

function M:_SetDialogue(data)
    if data.id == 999999 then
        self._view.txtRoleDialogue:SetText("<color=#0BD7FF>对方正在输入中...</color>")
    else
        self._view.txtRoleDialogue:SetText(data.words[1])
    end
end

function M:_UpdateLayout()
    self._view.fitterRoleDialogue:SetLayoutVertical()
    local height = self._view.txtRoleDialogue.rectTransform.sizeDelta.y
    self._view.rectRoleChatItem:SetSizeWithCurrentAnchors(1, height + 78)

    local width = self._view.txtRoleDialogue:GetPreferredWidth(self._view.txtRoleDialogue.rectTransform)
    width = width > self._view.txtRoleDialogue.rectTransform.sizeDelta.x and self._view.txtRoleDialogue.rectTransform.sizeDelta.x or width
end

function M:Dispose()
    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return RoleChatItemCtrl
