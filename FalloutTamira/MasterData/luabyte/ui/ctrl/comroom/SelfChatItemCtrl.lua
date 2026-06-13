local SelfChatItemCtrl = BaseClass("SelfChatItemCtrl")
local M = SelfChatItemCtrl

function M:__init(view)
    self._view = view
end

--data:heroStory
function M:UpdateItem(data)
    if data == nil then
        return
    end

    self:_SetDialogue(data)
    -- self:_UpdateLayout()
end

function M:_SetDialogue(data)
    local index = ComRoomDataMgr:GetInstance():GetCaptionSelectIndex(data.id)
    if index then
        self._view.txtSelfDialogue:SetText(data.lotWords[index])
    end
end

function M:_UpdateLayout()
    self._view.fitterSelfDialogue:SetLayoutVertical()
    local height = self._view.txtSelfDialogue.rectTransform.sizeDelta.y
    self._view.rectSelfChatItem:SetSizeWithCurrentAnchors(1, height + 105)

    local width = self._view.txtSelfDialogue:GetPreferredWidth(self._view.txtSelfDialogue.rectTransform)
    width = width > self._view.txtSelfDialogue.rectTransform.sizeDelta.x and self._view.txtSelfDialogue.rectTransform.sizeDelta.x or width
    self._view.rectSelfLine:SetRectSizeDeltaX(width + 130)
end

function M:Dispose()
    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return SelfChatItemCtrl
