local M = BaseClass("StoryReviewItemCtrl")

function M:__init(view)
    self._view = view
    self.onClickTextCallback = nil
    self._view.txtDialogue:SetOnClick(Bind(self,self.OnClickText))
end

function M:OnClickText(hrefName, centerX, centerY)
    if string.isNullOrEmpty(hrefName) then return end
    self:_SetKeywordTips(hrefName, centerX, centerY)
end

function M:_SetKeywordTips(hrefName, centerX, centerY)
    local arr = string.split(hrefName, "|", 1)
    if arr and #arr == 2 then
        local titleId = tonumber(arr[1])
        local contentId = tonumber(arr[2])
        local content = ConfigHelper.GetLocalStringByPlayerName(contentId)
        if self.onClickTextCallback then
            self.onClickTextCallback(titleId, content, centerX, centerY)
        end
    end
end

function M:UpdateItem(data)
    if not data then return end

    if table.isNullOrEmpty(data.nameIds) then
        self._view.txtName:SetText("")
    else
        self._view.txtName:SetText(data.nameIds[1])
    end
    local content = ConfigHelper.GetLocalStringByPlayerName(data.dialogueId)
    self._view.txtDialogue:SetText(content)

    self._view.layoutItem:CalculateLayoutInputVertical()
    self._view.fitterItem:SetLayoutVertical()
end

function M:OnDispose()
    self.onClickTextCallback = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
